Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624E448658C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiAFNv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiAFNv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:51:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CB6C061245;
        Thu,  6 Jan 2022 05:51:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F8C461BB0;
        Thu,  6 Jan 2022 13:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078B3C36AE3;
        Thu,  6 Jan 2022 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641477085;
        bh=9rdZAeLsUyj9v9gaJNRkMhgxgzmJttu+aTeMrHIrIqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLt9JCgXW5yVZrGpW8qdeHdnoZug4vDwaxXo2rLkbbTGecX1QVDzlsL5raVMe1pI/
         qeKSIc/p2/O6UUvUFuQLJEAAdG2GICmy+VR5JqzYzQ4XFsJ3bhxgYRZNQw31qta94U
         S6dTq7oBMdU8C8Yqf8alvvjbD6tRCiv8QDrfHToXtfsgwxjjs4F8axlIsDeP/PfAsW
         RS4k9WhF0M8aSWQtsdHlvisvlXE9gH42lKfac85H9wve76OrmOu/mBemS2GCZrKoMl
         GU2HUCqa7bXe7b9bhmLkqJM1viK2kao+mGj6MTzHLHSdwEoiuLCnPGkaLMzafSknBE
         kS1xxP+UBzGyg==
Date:   Thu, 6 Jan 2022 13:51:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     patrice.chotard@foss.st.com
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com
Subject: Re: spi: stm32-qspi: Update spi registering
Message-ID: <Ydbz2JkT8jRvNBBZ@sirena.org.uk>
References: <20220106132052.7227-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YYOP+xPh7cdL05sG"
Content-Disposition: inline
In-Reply-To: <20220106132052.7227-1-patrice.chotard@foss.st.com>
X-Cookie: I think we're in trouble.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YYOP+xPh7cdL05sG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 06, 2022 at 02:20:52PM +0100, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
>=20
> Replace devm_spi_register_master() by spi_register_master() to ensure
> that spi sub-nodes are unregistered in the correct order when qspi driver
> is removed.

This commit message doesn't describe the actual issue.  The change is
fixing ordering within the driver itself - the driver is freeing things
in the remove() callback which are used by the controller but thanks to
the use of devm the controller isn't unregistered from the core until
after the remove() callback has run so we might still have something
running.  "Subnodes" aren't an issue here.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--YYOP+xPh7cdL05sG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHW89cACgkQJNaLcl1U
h9ALYgf/alknJs2Xw7QDMlNENN0v5aGZepFImNoIF+MG+Z7JBhPh+nlvN5ozU0jA
k1OXYLsZwIlhc8OESLxTSipWlYf7N7UPJVnpkuTjLkNQHGMCQg3JEGPvZ34JG2vy
gu6YV6voQPJJs9Lhy0DOzyT/8b0TUtv11CR6GDZGD85Amlr+7Vp3kEqslVuslvAR
irCFPzUc4L66O6LuJwH3blcQOLh7f0gnlSv4AI/DWClT/PcvNy/I+6K0AzlbRCth
F+1eMArVQLS7I49ldfqSfS8kuBMDtZOPcwmve1KAimPwyEsQj5BhOSQvugcVT0YP
9cbCfaK320vSdx28c9xLZEd3zZfFAw==
=Kk5C
-----END PGP SIGNATURE-----

--YYOP+xPh7cdL05sG--
