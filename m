Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD2486A00
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242914AbiAFSd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbiAFSd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:33:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8522C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 10:33:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39D0EB8205D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 18:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F84CC36AEB;
        Thu,  6 Jan 2022 18:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641494036;
        bh=+XEjbfwoO8OLHSnfZYwgQrnldEDT5sKXi+2iaAXT/7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/TD3rX5YBISPIlLbiNdavtyjs/4LZDms0wX9+IYtKnopzmK5jmk5V0ugzxpGX5Ps
         8RkivDuddzfuiciSragsCeE0msTUTOpWewFscITApM49bZDXF2Ue2CcTbcvqA+xz3w
         bNjwTQ62ZyDEPpQNbZtufxrI9Bdnd5e6DYk1mO+lSFZtIZd4WYoayVxsK6/FiK7ne/
         x0XcIzo4mzLqttiyLhsMY4QMsartzA/Jp7RGsxvI6BZJjoEsTVYLsNYKPyjsB22JjM
         SVwfgMSUD/WG3rZEL3+ZwjE4a0Z8dXweeeRtXuHnKoVBWDFYXc1keK69c09VKTt1u2
         AYGyg06bKt7Dw==
Date:   Thu, 6 Jan 2022 18:33:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     matthias.schiffer@ew.tq-group.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: debugfs: Free debugfs_name buffer after usage
Message-ID: <Ydc2EHf5f12w4YcW@sirena.org.uk>
References: <20220106175019.3116389-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oNEgbt41o7xMIY3M"
Content-Disposition: inline
In-Reply-To: <20220106175019.3116389-1-festevam@gmail.com>
X-Cookie: I think we're in trouble.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oNEgbt41o7xMIY3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 06, 2022 at 02:50:19PM -0300, Fabio Estevam wrote:

> The reason for the duplicate name is that map->debugfs_name is never freed,
> which can cause a directory to be created with the same name used in the
> previous debugfs entry allocation.

> Fix this problem by freeing map->debugfs_name and setting it to NULL
> after its usage.

OK, but what's the logic here?  The name is getting thrown away here but
clearly there is a file still so I'm not seeing how anything is going to
clean that file up.  That means that if the device gets freed we'll end
up with the old debugfs file hanging around pointing at nothing.  Like I
said (originally in response to Matthias' patch but pasted in this
thread as well):

| (we should probably clean up the one with no device but that's not what
| your commit does).  I think what you need to look at here is that we

The use after free extends beyond just the filename, we're also loosing
track of the already created file, which does seem to be an existing
bug.  To be more explicit this means we need a call to regmap_debugfs_exit()
which will clean up all the existing debugfs stuff before we loose
references to it.

--oNEgbt41o7xMIY3M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHXNg8ACgkQJNaLcl1U
h9AczQf+MWrIXa2mSNXhkoiFt3mCkFFC/wxFGchHjw6pGzL66+e5JdeHDqa2EjWH
WjDlxHsv+5zWF6tiJT4c5oNZNE3MYpHp63SMkIKnlCow4KLYcuTQtk3Lxz+nPzGF
PoMiIPG387pXVxP1DvNfzOHqXfLXPllVHs2AlEKPTpd7v2gAgvexZjMnVD9SMBb2
7hMSdaroeULHWTTlvnuI+b3mEV2OmP1A8ApiPwByaSANgLBtnIg5wyrzWMJ6CRXM
yxSDc0krbxQnaBAdGBAZN//R3KLU5h4c55gDu5NlK4GnxKEgcY0l4adfyL9in9ZL
V9xV/7AMSR/pVKhu8lZfB5TNiLe+4Q==
=qp/v
-----END PGP SIGNATURE-----

--oNEgbt41o7xMIY3M--
