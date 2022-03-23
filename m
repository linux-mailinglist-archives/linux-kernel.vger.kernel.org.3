Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0724E56A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbiCWQki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbiCWQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B9A7CB00;
        Wed, 23 Mar 2022 09:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A46D66188A;
        Wed, 23 Mar 2022 16:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ED9C340F2;
        Wed, 23 Mar 2022 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648053546;
        bh=zqIdI6XFaOEiAfgKwkAFcchz8EtPXIeghZmHVNoN/sY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hozcNfXDlo2THvCgEP/xIFuFbGs2glSGG1q+/TD6le6Qs7SM64GDqe5/pPQQrkIWR
         c+yhA4cmrhzvMveQ4YRLirCkWoreJ6hR8NBptysdQcJwJ5PVWL6eyPy8A8TyuVskpt
         ctxpHRikq4hysstgL6lX7Z6cg6lmOqMQ7ZoPth1h+oDftTiMk+zdnH4TZkA6dsMG9S
         JGiRezV5U9m/9hfLplScCX83jIISvq5co7eiPyuPNvIUedhFZauD4AdssiB0jiM1SI
         NNo0u6Ffv5igNzMS0/cDDebrLpzCrCEx9aYiTEJN+KI0qcuv4mPddBbiJm3/76WojL
         WwgARERt/5tLg==
Date:   Wed, 23 Mar 2022 16:39:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] spidev: Do not use atomic bit operations when
 allocating minor
Message-ID: <YjtNJe4Pgp3WIwOa@sirena.org.uk>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e3LsxH1FINaB/t84"
Content-Disposition: inline
In-Reply-To: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Nice guys get sick.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e3LsxH1FINaB/t84
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2022 at 04:02:12PM +0200, Andy Shevchenko wrote:
> There is no need to use atomic bit operations when allocating a minor
> number since it's done under a mutex. Moreover, one of the operations
> that is in use is non-atomic anyway.

>  	if (status == 0) {
> -		set_bit(minor, minors);
> +		__set_bit(minor, minors);
>  		list_add(&spidev->device_entry, &device_list);

There's no *need* but the __ looks suspicious...  what's the upside
here?

--e3LsxH1FINaB/t84
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI7TSQACgkQJNaLcl1U
h9Ag+Qf7BdKt1OGVCut6QPnDdPOHMLmnzlzeUDuCX039ExUzVn0JTFX0imeelROu
DctTz2qO/vvUZiIQvQiI46B5kO39Ye0kppe+9i9nfn+yvuKF8/NsqL9y4A/YWG8L
kYbtKrpDSjNpqDu6d4wvb/TMqIpzd8oN2shMNy/VCEvpResI5VS3/iyr0+NT1Zth
n5herH+FBVPyZode/CeGVC4nwDBbVJZcscTgXGdml8VLaXcBgiFYGUEFnX4JObAa
MuEsLwzAyRno79wFfQ5HbdFQiPFptcTySxsjiPYjMjQ1OumR37TF1Rvs9MO7o0oh
1fa7JCUPmbI1C7qM16GWIpVDdaWU0Q==
=NtkR
-----END PGP SIGNATURE-----

--e3LsxH1FINaB/t84--
