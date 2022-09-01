Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DCF5A9F32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiIASh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiIASg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:36:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7F920190
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56F1661CF7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E538C433C1;
        Thu,  1 Sep 2022 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662057366;
        bh=Y/mO+qRCMrK0idcc254YXG8TJylthMPW6zBfv4IQves=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cLnQGwP/0DENf2zZ79Ge/zMKw5j8Lnv8OnJayM7BMzFac5qxleNiZuzrAzzXYqdh+
         HTXRzfcJnkO+CIyy/QPdXMsorwS85AtvaWYO/6S43WnwJ6r3XwqrGm4mXAYurJX/Wi
         1rmHorJlig9l+4vl/y8Hji+eaKRrXv0kr+saHSKvSskJYAuXL1FOKqoWXeu25NxPX+
         wmIWAAbtzjS/vg5ZISrXYyJG7UHiecX+WHkIUPWP5f9jAmIDQn+gdWG/zAFiRoLoe3
         FBRNPjw81Y2E/7ElZN4GwPM+jepGdbmiIGTChlaXeHgtQ7R7nPSb7V/pDeO3bWzCoQ
         Gf13MF2V8b8DQ==
Date:   Thu, 1 Sep 2022 19:36:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiho Chu <jiho.chu@samsung.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com
Subject: Re: [PATCH 1/9] trinity: Add base driver
Message-ID: <YxD7kWBl88kMbdi5@sirena.org.uk>
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
 <CGME20220725065309epcas1p4565e7bb0fea1aaf3e5e300de00774c2a@epcas1p4.samsung.com>
 <20220725065308.2457024-2-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9lpWXlZqwrEMGTTR"
Content-Disposition: inline
In-Reply-To: <20220725065308.2457024-2-jiho.chu@samsung.com>
X-Cookie: Information is the inverse of entropy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9lpWXlZqwrEMGTTR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 25, 2022 at 03:53:00PM +0900, Jiho Chu wrote:

> +	drv->opened = drv->opened - 1;
> +	if (drv->opened == 0) {
> +		/* wait already submitted requests */
> +		if (drv->desc->drain_reqs)
> +			drv->desc->drain_reqs(drv);

> +		drv->desc->set_state(drv, TRINITY_STATE_PAUSE);

> +	mutex_lock(&drv->lock);
> +	/** remove PAUSE set on the CP of the NPU */
> +	if (drv->opened == 0) {
> +		ret = trinity_wait_ready(drv);
> +		if (ret != 0)
> +			goto out;
> +	}
> +	drv->opened = drv->opened + 1;

Would it perhaps be cleaner to hold a runtime PM reference on the
device for each file and deal with the power up/down of the hardware in
the runtime PM callbacks?

--9lpWXlZqwrEMGTTR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMQ+5AACgkQJNaLcl1U
h9BlHgf9EFnETk9uty/p+c7YsUZXO8zTfgSmK4Ckc+tItNAEHdUVnq1v5qIqjFmq
vAM4wfGeIV9NnmxjTGmAu9t4OP0pVZkSb4uTV89Y+fXuti5XuB6OJuT3Smqham+g
DXRB/oV+Bs1qqnrEJN3cMJc9IZal66VCSeFDq2zcLxJk5xTv9NDlaHXL27/nxvLt
YykqEOaitb1lJ0aw9Uyo/NDMzy5BJMZXlAZQgfKXd7s65PMs0GxZWhiVceYwavXe
lulmAQzZplm5mVFW/QgN/nLtllLAZdsuV2YlshL60nTg7b+pPQsaiycPOqF7Wpmr
mzlyK3kOfbmJ3HDT347rp57G91grHg==
=edp6
-----END PGP SIGNATURE-----

--9lpWXlZqwrEMGTTR--
