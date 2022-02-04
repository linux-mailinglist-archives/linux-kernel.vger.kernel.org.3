Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFF54A9FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiBDTD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiBDTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:02:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D44C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:02:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B068EB838D2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 19:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04667C004E1;
        Fri,  4 Feb 2022 19:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644001352;
        bh=6ngj7r3EAtDqwAjDyj6UiGc7OBQFO0jCuKHmtOkOCl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVMTuNYDWowP5VRdpgFPmyjoJov2uecR6KSkuYc1deoGMeHh/8ZBJXf9yaE4VrKTl
         zTn9q7V6gU59HhEJPg7F0y/cuIM2EOtU7cbwyMhSuJGSOQpssmJseTloB4C2eN4c6H
         cvxLEPsP5qj2T8N0jY1WMGkn5L6L7McFoq8wWERNMNCPGaTEWCBS1szEpaexFlMz7P
         UwxJUyyDKZ5NpL+lPaJVke63WGMYap1v2pWmg+GMwGOim7owbtvEU9JNyQ5Z2W4bDJ
         dVQ0afvjMpsJggwc3z1nxKjySBhVgbsYHWFEl3QkcrmOgNxZ8lrTiazQwfM/g7hNNU
         JUELHospbpZyw==
Date:   Fri, 4 Feb 2022 19:02:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: regmap: mmio: lack of runtime_pm support for debugfs
Message-ID: <Yf14RJbM10O3RdA+@sirena.org.uk>
References: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
 <20200423104000.GD4808@sirena.org.uk>
 <DB6PR0402MB27600084E4A040609EF620A088D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200423112244.GH4808@sirena.org.uk>
 <DB6PR0402MB2760FBCA05C1BADB27F0356488D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200424103004.GB5850@sirena.org.uk>
 <Ye87P19+JOjPEGTY@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hRRnzNzDsjG7npUH"
Content-Disposition: inline
In-Reply-To: <Ye87P19+JOjPEGTY@google.com>
X-Cookie: Torque is cheap.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hRRnzNzDsjG7npUH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 24, 2022 at 03:50:23PM -0800, Brian Norris wrote:

> The only 'runtime_pm' flag I'm finding for regmap is for regmap_irq_chip
> -- there isn't anything useful for other kinds of regmaps (like MMIO).

> If this seems like an expected/useful feature, I'll look at adding it to
> the generic 'struct regmap_config' / drivers/base/regmap/regmap.c.

> This could be tricky in theory given the atomic context requirements,
> but in reality, I think it would still be OK: this feature would really
> be useful _only_ for otherwise-unregulated contexts, like debugfs
> access (where we can sleep). For all non-debugfs accesses, we expect to
> already be RPM_ACTIVE, because the driver should already be managing
> runtime PM.

Are you sure you wouldn't be better off with a cache here, or marking
the registers as precious so they don't get read (perhaps conditionally
to allow reading while the device is live)?  The general idea
expectation with the debugfs is that it shouldn't materially affect the
device, this would mean that it could cause the power to get bounced on
which feels like it might lead to surprises.  If you are sending a patch
adding support for this it should be debugfs specific, not a general
flag so it's clear that it's not going to do power management outside of
debugfs, as you say in the normal case it seems better for the driver to
do power management.

--hRRnzNzDsjG7npUH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH9eEMACgkQJNaLcl1U
h9CyNAf8Dw6weMFAkpEdp9ndGZJ+cTBeYRiFEQUDD+GOjV/Sy8bsbeYNvJzCeofh
q1dTYpYAlgkyT2FpqkfB77jqUK81fku/E96ibto1n2r0+qoQBeTyo5lTvwyQiv8l
CoJq0ZjXfXUAg2cQuGqULkg8lfmUFtdsDtr5tUwQrfJ0saPLuibigYAtEUcaBCGM
b/jh3GRypX+iHDyfSZQCEwtz2emj9l3KLp13moFieVADysxNe1JII85GM9h/wnpq
Cxt8LQNEl7KhD182oAyvZrt3Qq6F/7jF4vc5HfcpI8a4DucAnKsVqTEm/yxzHza6
tKzWPT8R3/AlY3uNqIW7AgW51nTBlA==
=bTdf
-----END PGP SIGNATURE-----

--hRRnzNzDsjG7npUH--
