Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2C575168
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbiGNPHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGNPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062D662A63
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95F6861EE9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7B4C34114;
        Thu, 14 Jul 2022 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657811248;
        bh=QwvEM86G2bi2oLbZSTQaOJc4KZYwGMK+yLbEgM6y3nU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ai5ID9myq3lEZC3Jmsd6Wn+rQJV1+1DAZcMX2pQdFMbw/0ssk8ip7SIyDWkwUN8+w
         PInZ5k17+7UyQcjGJ5Keta0N3X+3vkniHXe5Q+mVuTd5UPuFSngKecgXSVGROSf8ve
         LQBC7Bob7lExw32BviVp4bAjz+TVBf2Q5jrJKn+t39O2n+Ljs+TGXBDLcQBvr9de9E
         aJ08JAIk+6kgTlDBt/lNuWpLcSW5SxZHd6smq+h0NKO+02tI5mWTjDe0uZ7U/NpaqJ
         gY4RWAx3M1KhORa28aElg/cTi0R9i53SXBiaY/4G1WxkbDLb4cTTOb8e14ndjwKt7z
         vdYA+hBCf0q4g==
Date:   Thu, 14 Jul 2022 16:07:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question: regmap_field_write() - why using update?
Message-ID: <YtAxK1lIooDmdVBP@sirena.org.uk>
References: <e759045a-bc01-c194-35ad-42b534ccaa01@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U8RA7MvTw2zJCdp3"
Content-Disposition: inline
In-Reply-To: <e759045a-bc01-c194-35ad-42b534ccaa01@linaro.org>
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


--U8RA7MvTw2zJCdp3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 14, 2022 at 05:01:29PM +0200, Krzysztof Kozlowski wrote:

> I am converting my driver using MMIO to regmap from readl/writel and to
> my surprise I found that regmap_field_write() does not behave the same
> as regmap_write(). I would expect that they are the same, except one
> operates on fields.

> However regmap_field_write() uses an update method [1] which means it
> reads and performs update. regmap_write() simply writes without a read.

> I find it inconsistent and a bit confusing. Any reasons for such
> behavior so I won't send a patch which breaks 100 of devices?

How would you propose to write to a field without reading the rest of
the bits in the register?  Otherwise you'd be doing a full register
write rather than just a write to the specific field.

--U8RA7MvTw2zJCdp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLQMSsACgkQJNaLcl1U
h9D9/gf/eF+nAh6E5Ec0QjP71rxIYC33qxhubFwJira6Pz1eyX63TuGRjmj1XUAF
edg7o/yc15r5GuzmwK4nCd271p/YIktYOWZpQ+dXf6bnQezx7B/A6e7ds+6QUj1L
Hn+qxjdyDl6tC2tfDBxkA+PeKRzDzhYsepg9ZLO9IQw6OtG0fESTjG2xx9+gcsbI
5wHHsuqyo8eFHk2dRvq/Itlivc0zfgE1tl5a5uTgq5PX83nADE9f8y923YRB3TZm
hyB2Yz/BWpgzUK+pZFdWzGMSenqWz+b/5bK8qwtY8H1ft/PbqsbUo3hzuK0tXsWC
knbLPZXaBUGkLSfw184oy1tzlGyZDw==
=JcSR
-----END PGP SIGNATURE-----

--U8RA7MvTw2zJCdp3--
