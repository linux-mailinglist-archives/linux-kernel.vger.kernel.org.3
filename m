Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA44574D11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiGNMID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbiGNMGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:06:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288435C9C7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C037B824A3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC669C341C6;
        Thu, 14 Jul 2022 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657800403;
        bh=Hx7EerRWspqOHGQhu1Nyu8KtBaepz8d9zyknE3mK94U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGn1Fryl60GNhiXiHxGknPX80PVIEE1YqHxRdSgS/mMZ4eSuyKgyOAp07GmOa/WLy
         d0xCI7cs730a0586zkVV5n+5TX7MzGcskiHpmKEIkZwJJaHdxew7feRSGAOV8bUnT4
         E7uEi007P9nR82eIwtkUF43L8glDoL1PCVjReJ44/0FWsxt7DT78bNGR+fSfEg6LTe
         ffcGL3OU9HTH5hjJTWMay/kpD4udC1pWbTmVpHvMQubvymgwltVLl6BnvA7shMYqLK
         eENDLcqLQEwQYcQiFvhDXdP8vfsr1JdMEHNQ5nb1eDRu+JHTABU4zgUEQxVHqadC71
         4NoK3R/PhcO9A==
Date:   Thu, 14 Jul 2022 13:06:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>, peterz@infradead.org
Subject: Re: [PATCH] lkdtm: cfi: add test for HW landing pad CFI
Message-ID: <YtAGzqfT9EkYTFBm@sirena.org.uk>
References: <20220713151815.295520-1-mark.rutland@arm.com>
 <Ys7vRTThFVNz7moO@sirena.org.uk>
 <Ys/+qghGmH4kK4DN@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vUqi5N6saZo+b+5S"
Content-Disposition: inline
In-Reply-To: <Ys/+qghGmH4kK4DN@FVFF77S0Q05N>
X-Cookie: The devil finds work for idle glands.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vUqi5N6saZo+b+5S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 14, 2022 at 12:31:54PM +0100, Mark Rutland wrote:
> On Wed, Jul 13, 2022 at 05:13:57PM +0100, Mark Brown wrote:

> > Not sure that worrying about that at this point isn't making perfect the
> > enemy of good though, it could be dealt with later.  Perhaps just put
> > the offset behind a #define to make it a tiny bit more discoverable?

> How about I just add a comment for now? e.g.

> 	/*
> 	 * Skip past a landing pad instruction.
> 	 * On arm64 all instructions are 4-byte aligned, and x86's ENDBR is 4
> 	 * bytes.
> 	 */

I'd rather have something that will definitely either fail or skip the
test so it can't silently pass, if people need to look at the source to
discover this there's more chance they'll mistakenly think things are
working.  Something like

#ifdef __aarch64__
#define LANDING_PAD_SKIP 4
#elif defined (__x86_64__)
#define LANDING_PAD_SKIP 4
#endif

then #ifdef LANDING_PAD_SKIP around the test perhaps?

--vUqi5N6saZo+b+5S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLQBs0ACgkQJNaLcl1U
h9D0fwf+LE6b2NeOigHSnJohAeum7jXyIHODkNDIDNZRs5B4vZve48iAYxGL0buI
6tCNF9HOBP4tloeq3Mnwo4kIk3A3kXDXPhzfBAXbyhJc/M4G2DQTJi6tNtonwZEW
64hkhk5mP9S4g881UDyoOmIEQLUHIYgo7dECOWIIbvUUs1oBMB+yiSSPHfjxYIp8
spULH1c4KaLnXpKq/CSDo4ZRxbzLPDvWVoGu5JscTvy5+VfcB9BvT08QeNbnLWSi
9t8uXmisRHS9MvlWy8YRmsTv6CticLzc/p0aZBMWC+fT/NFEds524C+XBqQxfwbq
nxyCydp9+WZPuZIB60PA/v/FpdbBKg==
=suLk
-----END PGP SIGNATURE-----

--vUqi5N6saZo+b+5S--
