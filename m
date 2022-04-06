Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C854F6AA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiDFT5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiDFT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:56:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FCD286D3;
        Wed,  6 Apr 2022 10:21:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x20so3438133edi.12;
        Wed, 06 Apr 2022 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5y49F6FFIHNJFXwX0mwDpkqnylVMigszjtIkPhpuii8=;
        b=P8w9ucNqgOCkMD9cfh5/9Sy+LhNLNVxHGvjSiEWpTv/tYtCA4FCvREBL+YIGfXOxzY
         4SFHJnrbfJLEM8r6ouWRoqIEuHMY/CooGAHqfac4DSpWWicNAOIw8wuck+DtxI37wVEw
         BaJkkUmrdPoPinQOCn9/dQ4ZdbtiaZbOPVMMW4fTbxC0P53Ew4F6UEFCYiMRd8Juy96/
         d2qwJV6kmc3YTcVNty4BQmYiVVh7Q1wyGOweD4ZFrWSYLXTrGwyGUk4zhQ+7BNL4IYRj
         lT8R10BtopHMNIqAfK2+tmZSRpknsj+6osDd/bevh9ecLeWegNHM33fqaX/lzQEo0Mud
         NMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5y49F6FFIHNJFXwX0mwDpkqnylVMigszjtIkPhpuii8=;
        b=4MekjI0XASgJhrtV887RfITn8Xm5PaNedgkSisDX2gdTtY+coSpEj4p8edLxIbEhuD
         f+Gt4Nz1KBZHr4Y73cM0fNFJnjiloj1YWgiQFKUGzRFpXWGECKCSAtPiXys3cjvtCgQt
         y9bwSHYqkX5Fomx9C2IWi4OPJmmCv6EZFWJkOKS6eyQrV0uT09V2lWnm04ERrVMm8xn7
         Pm4kV7lRAETW/VO62Hq4CLR2v+s5mLVq0EqJqrBiwXPA8SuUH6eAuLZ6Kqcswh8Y6tFT
         2mWWM5L0nx8Pavbu0F+txk0SGDtiiS4e6rq26J79rlG0MS1FKnKEYXzdPPgXjRmL46jo
         NDXg==
X-Gm-Message-State: AOAM5315m9FA9fobNj7MU1g5r1NVZy2WtGc4NobKnFoZWMyCmQeOZbOA
        hdPzUY1yXN9Rla9WXlzhL9OVJcQ/9mClkg==
X-Google-Smtp-Source: ABdhPJw7SwZmk8KMDZN9kawMnoJ2pOLoCUSGiI/T+DYa+t+vvAVLi5zMiKJaRx9H4xaslCQrGhPLEA==
X-Received: by 2002:a50:da8b:0:b0:415:a122:d7ad with SMTP id q11-20020a50da8b000000b00415a122d7admr9951784edj.123.1649265661983;
        Wed, 06 Apr 2022 10:21:01 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id dd6-20020a1709069b8600b006df08710d00sm6947802ejc.85.2022.04.06.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:21:01 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, nicolas@ndufresne.ca, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [RFC PATCH 0/8] media: hantro: Add 10-bit support
Date:   Wed, 06 Apr 2022 19:21:00 +0200
Message-ID: <2820101.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <bf938b83-2b57-95b3-4bcb-f967bbb46413@collabora.com>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com> <4386971.LvFx2qVVIh@jernej-laptop> <bf938b83-2b57-95b3-4bcb-f967bbb46413@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 06. april 2022 ob 08:54:07 CEST je Benjamin Gaignard napisal(a):
> Le 05/04/2022 =C3=A0 20:40, Jernej =C5=A0krabec a =C3=A9crit :
> > Hi Benjamin!
> >=20
> > Dne torek, 05. april 2022 ob 18:07:41 CEST je Benjamin Gaignard=20
napisal(a):
> >> Le 27/02/2022 =C3=A0 15:49, Jernej Skrabec a =C3=A9crit :
> >>> First two patches add 10-bit formats to UAPI, third extends filtering
> >>> mechanism, fourth fixes incorrect assumption, fifth moves register
> >>> configuration code to proper place, sixth and seventh enable 10-bit
> >>> VP9 decoding on Allwinner H6 and last increases core frequency on
> >>> Allwinner H6.
> >>>=20
> >>> I'm sending this as RFC to get some comments:
> >>> 1. format definitions - are fourcc's ok? are comments/descriptions ok?
> >>> 2. is extended filtering mechanism ok?
> >>>=20
> >>> I would also like if these patches are tested on some more HW.
> >>> Additionally, can someone test tiled P010?
> >>>=20
> >>> Please take a look.
> >>=20
> >> Hi Jernej,
> >>=20
> >> I have create a branch to test this series with VP9 and HEVC:
> >> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/tree/10b=
it_
> >> imx 8m Feel free to pick what I may need in it.
> >>=20
> >> That doesn't improve fluster scores, I think more dev are still needed=
 in
> >> GST before getting something fully functional.
> >> Anyway I able to select P010 pixel format if the input is a 10bit
> >> bitstream.>=20
> > What kind of improvements do you expect? Actually, this series is desig=
ned
> > to change nothing for platforms, where 10-bit format is not added into
> > the list of supported formats. I think reasons are quite obvious. First,
> > not every device may support 10-bit output. Second, as you might already
> > figured it out, registers in this series are set only for legacy cores.=
 I
> > have no idea, what needs to be done for newer ones, since I don't have
> > them. Anyway, I tested this with fluster and only one additional test
> > passes, because it is the only one for 10-bit YUV420.
>=20
> In this series you will find that I have added the registers for the new
> cores, fix hevc to be able to use 10-bit, and enable that in IMX8M.

Your changes seems reasonable, but at this point I wouldn't bother with=20
fluster. Instead, try to test with one specific bitstream or even a sample =
video=20
file. I just tested with one random 10-bit VP9 video that I found when work=
ing=20
on this series. That way you avoid any corner cases which sometimes plaque=
=20
fluster testing (reference bitstreams smaller than min. supported size).=20
Anyway, re-check vendor lib if there is any other place to adjust something=
=20
for 10-bit.

Best regards,
Jernej

>=20
> Regards,
> Benjamin
>=20
> > Best regards,
> > Jernej




