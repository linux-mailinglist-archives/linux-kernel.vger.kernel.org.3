Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0DC59EF71
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiHWWtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiHWWtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:49:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52F18B9AF
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7617FB821EA
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F1C433C1;
        Tue, 23 Aug 2022 22:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661294980;
        bh=/1h/yko3lxdT1fcDY8cUkWUNoD8FJccdgl3dWcD8Yv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMB6VUSOLidnwfjlOGNNKee+QGA2vfjIoPhPYzyrLUy855wlBYzIe9SA/XguKvFmm
         3kp8QHJSYdCQXMWGBRaG7UL3/EhDz8mZv9/oUhrC3sLOvxQT1xWT0kMrwt1RjGsmfZ
         bKJEWyfxoTeGMYqpy4aQCfCw4W7fYSYYXcyZe04KfbIB7i58wsi4dnzyzenTOTdfSA
         zyloXxx0AiHADFKVPfk1P9KrJ6W+5DL4JRHglaMmkfF7ZBW976m+Zwb2bu/tITUuYf
         TNmgTziP8Cdn6QS7RZ0iy1HD5P1kvkGjfFYj2C0K/cW4X+3aH8DPBKnsqhCcyMnr3p
         WUP1q7RKRLGrQ==
Date:   Tue, 23 Aug 2022 23:49:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT PATCH] regulator: core: Require regulator drivers to check
 uV for get_optimum_mode()
Message-ID: <YwVZfyDflFuzFAOX@sirena.org.uk>
References: <20220823131629.RFT.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
 <20220823221429.3bte2tgtyniur4wb@halaneylaptop>
 <CAD=FV=WSSrObW2PthmUL+t=VYJ+mN6Z763pozCQDbOdPtAXyQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z9oeYD/PD2GvJnOl"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WSSrObW2PthmUL+t=VYJ+mN6Z763pozCQDbOdPtAXyQA@mail.gmail.com>
X-Cookie: You can't take damsel here now.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z9oeYD/PD2GvJnOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 23, 2022 at 03:32:44PM -0700, Doug Anderson wrote:

> I guess maybe we could add the "initial mode" as an implicitly allowed
> mode? I guess the other option is to implicitly disable
> regulator-allow-set-load if no allowed modes are listed? Both of these

We should do the former, or equivalently just noop out of set_load() via
set_optimium_mode() if no modes are allowed.

> I guess the other option would be to say that if
> "regulator-allow-set-load" is set but not "regulator-allowed-modes"
> then we allow all modes? Somehow that doesn't seem like the "safest"
> option, though.

Yes, I'd prefer to avoid that.

--Z9oeYD/PD2GvJnOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMFWX4ACgkQJNaLcl1U
h9CAyAf9GZvW4cQEOUBHq5ZBD8v/mD+9/727Aa/swqbmz0jYqHaZqOQudN51YG7y
IufNyq3nprs3arGYNj9M2tct3w3OimCJ6QTDKx8Y67+4wJNyhkbiRwpDNfwOVADH
DBgWzD6/R+yHuywjC9it1N7EijcydfCcdafCTnlLhyS203M8rSsltEeux7vKGBye
J6q19vxroEmUQGxpOqYCrEYikbyffQc0sVSM47wHQDwQuhWe/03aw7k2ybm59s1l
Cys4mWc3I09XBld7IUIA1fa5k/7AuLYneAhcFiKxoJqXoHcaxnJtavYo81HWyL8V
8hP8CK38KoeqJMCZLXxX3NRpt073Uw==
=xirN
-----END PGP SIGNATURE-----

--Z9oeYD/PD2GvJnOl--
