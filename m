Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B132C4C5DA4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiB0REI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 12:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiB0REH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:04:07 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC6228E24;
        Sun, 27 Feb 2022 09:03:30 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s14so14410634edw.0;
        Sun, 27 Feb 2022 09:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dANX2Nn44mbCP9zs92/BfwoXKsDqb2azTmCoigDg0oU=;
        b=LL2RxvR/1/nUpXagZ8ezOOBshFZ6Ut3TWhhpQTqimGrQSwON3CRmV6uP61RIU7jB0i
         8l+0YrcDznzwP7CtQOiO3ymzZ8OyL92WUsu9fIypR0iyv3/vyeD5LqMoy0zgyp9E9E0W
         rqZ1KLO/Bf0JwCQ5hbX9suKteBENqBaAAJJwSLvee4oNGb7H4+E3lcOGTyWZnTWrGomu
         XKJ5eMZvpwx0ztwmT9unP4kejlM3pecyWt4D+qKZWaWog8YSi/kB0e2zPhMKBVSsL4HM
         6lNkPX9sF7T466aXwy1AT3KikKt6f5046EMj+XIPVdQSkHeLcLeIU5wNx17UZU7cSDJW
         lPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dANX2Nn44mbCP9zs92/BfwoXKsDqb2azTmCoigDg0oU=;
        b=7haKLubI64RIS/wYy7LqLrJFY3ed1DpBKgZajyt4KQ36/t2dLRDakP918oTsu8sVle
         v77JnpapeNGj47vSXqPj3YbwtSvDKaIRBncCEpyDIgEiVtZKUqcJO5SNxQKlfd0At6Dd
         c6nYxzooNUphPQXwYi9UqQB9NF4SodcK3QOyqPwmJ6a2BP/F2tDZLPz62FXtzf77H6gz
         hXDGaJN1Xu4IZeRAXFOLuneyzMClKGLg/NLKpRuxEaQbISv3Um91BFiKUT3gektJMEez
         mnz+6AmHj7UcL3R/Gu5MzlgP9mPgacW0mWUNE2GILEON57petvUF7uC1E2KQF4+Ijh7u
         UdIA==
X-Gm-Message-State: AOAM532BECB4+EHxG4V+fz6DAXXO7PgxqP0TNfM1VjofYYRKemDYmKe4
        Gn398x/LAEmgCPQND/yi7tI=
X-Google-Smtp-Source: ABdhPJwUjgrEmeNoJb0yPleFkeU4+PhfGM+FDV7S1txB8mcMnr2ykdbwmpn6pMLVCz48WjNv2ZCKkw==
X-Received: by 2002:a05:6402:372:b0:40a:bbf4:7973 with SMTP id s18-20020a056402037200b0040abbf47973mr15856901edw.399.1645981408694;
        Sun, 27 Feb 2022 09:03:28 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id gq15-20020a170906e24f00b006cfba1c5433sm3587873ejb.172.2022.02.27.09.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 09:03:28 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, nicolas@ndufresne.ca, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [RFC PATCH 0/8] media: hantro: Add 10-bit support
Date:   Sun, 27 Feb 2022 18:03:26 +0100
Message-ID: <8898316.CDJkKcVGEf@kista>
In-Reply-To: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 27. februar 2022 ob 15:49:18 CET je Jernej Skrabec napisal(a):
> First two patches add 10-bit formats to UAPI, third extends filtering
> mechanism, fourth fixes incorrect assumption, fifth moves register
> configuration code to proper place, sixth and seventh enable 10-bit
> VP9 decoding on Allwinner H6 and last increases core frequency on
> Allwinner H6.

FYI, additional patch is needed for linear P010 output:
https://github.com/jernejsk/linux-1/commit/
28338c00749b821819690c9fd548fd5c311682b5

With that, only native format was not tested.

Regards,
Jernej

> 
> I'm sending this as RFC to get some comments:
> 1. format definitions - are fourcc's ok? are comments/descriptions ok?
> 2. is extended filtering mechanism ok?
> 
> I would also like if these patches are tested on some more HW.
> Additionally, can someone test tiled P010?
> 
> Please take a look.
> 
> Best regards,
> Jernej
> 
> Ezequiel Garcia (1):
>   media: Add P010 tiled format
> 
> Jernej Skrabec (7):
>   media: Add P010 format
>   media: hantro: Support format filtering by depth
>   media: hantro: postproc: Fix buffer size calculation
>   media: hantro: postproc: Fix legacy regs configuration
>   media: hantro: Store VP9 bit depth in context
>   media: hantro: sunxi: Enable 10-bit decoding
>   media: hantro: sunxi: Increase frequency
> 
>  drivers/media/v4l2-core/v4l2-common.c         |  3 ++
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  2 +
>  drivers/staging/media/hantro/hantro.h         |  4 ++
>  drivers/staging/media/hantro/hantro_drv.c     | 23 +++++++++
>  .../staging/media/hantro/hantro_g2_vp9_dec.c  |  8 ---
>  .../staging/media/hantro/hantro_postproc.c    | 34 ++++++++++---
>  drivers/staging/media/hantro/hantro_v4l2.c    | 50 +++++++++++++++++--
>  drivers/staging/media/hantro/hantro_v4l2.h    |  3 ++
>  drivers/staging/media/hantro/sunxi_vpu_hw.c   | 13 ++++-
>  include/uapi/linux/videodev2.h                |  2 +
>  10 files changed, 122 insertions(+), 20 deletions(-)
> 
> -- 
> 2.35.1
> 
> 


