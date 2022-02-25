Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE214C4292
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbiBYKlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbiBYKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:41:15 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F2E68FBA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:40:37 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id a6so6882251oid.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XmHgx7i/9vNrhvW/myAVOgnrCLxN2TVncbf1coqXilo=;
        b=JShMinXGneeNUXr6MBtvLnsdFzLyYYPtsUCiR1SgKcXep3GIi8/lspMh7qpTsNS+4P
         IQU+sI8epCbEo+wm4GebX17uOpKZdhmwAdbT807V0RgLDlEvibQSQWM7XdjGnZCNmPIa
         6hKDByDP3wolEPSOkSdLIyX3nQsPCK5Vfy5L+waT20TTaKawHhkeTmNSPEte2FmrceFe
         v+6xcrbAgcBLra+7OTyLfY9V1z4JRO1vrdf5TwzAdbXW5ZbXl+1QiUYQJ4nnqrmbgfhV
         rKN3RIc45tWwJoHgB8Zony4h91g7IoWebGN/osaLBTHRi4zLm2FgRV7TzjbfNPcVFxB6
         LA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XmHgx7i/9vNrhvW/myAVOgnrCLxN2TVncbf1coqXilo=;
        b=ddJaF1qZO16WbOyXsGF30c+Xk2oiySGcaqsuiL7rIYljslkFoO6UYq03lobd3tNLv/
         YR1pL+9aUgDAqdIMpSryURqXt9SWjOnh5v1dFUOTmzQtfpoOdL6DRGuX7H9BseURZsp/
         9W+eGa2wS0x3vIeIwbN+4NknkMiFCnM/4j16ARb2u1A1Dd5TA9ug71N9RUzdKpKmBMC/
         ucBQx2Cp9ai1IjrkoHSbw9aKNFlOyYsGD+21OwVqaXO9AA1c9byOLoRjzCkgi31GzzQW
         8I6gjMoGnVq1lewKY8s54KhtnbpRcHsJQvuql9oGv5cDAX2yhhhypo3GouUl7Tbd9Zp0
         ex+g==
X-Gm-Message-State: AOAM531QeqwhfgCzuAQOIzsxnDvCVHyN60B1luYawwLJJk6GHYvFUCNO
        IvM9wuI7znXXm+qeydzmYoZ3LXhMv3Tw76HuHRwHdQ==
X-Google-Smtp-Source: ABdhPJx9aAd/x8lOBAlC3AOKrKYl71PZj1ZJrbUXQn++GPnT4jD/17UUadhTANVxEvJPL5JqOpZ6gLbTAqxp4YOXaXo=
X-Received: by 2002:a05:6808:114e:b0:2d5:4101:844e with SMTP id
 u14-20020a056808114e00b002d54101844emr1162908oiu.169.1645785637242; Fri, 25
 Feb 2022 02:40:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Feb 2022 02:40:36 -0800
MIME-Version: 1.0
In-Reply-To: <1c791b60-935c-1e8e-dd1b-4b18fc273c1b@collabora.com>
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-5-granquet@baylibre.com>
 <1c791b60-935c-1e8e-dd1b-4b18fc273c1b@collabora.com>
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: alot/0.10
Date:   Fri, 25 Feb 2022 02:40:36 -0800
Message-ID: <CABnWg9uoDNbA6ZYGdEgkyySBW0pfY1+3Zrnh51XjadNU8_+U9A@mail.gmail.com>
Subject: Re: [PATCH v8 04/19] video/hdmi: Add audio_infoframe packing for DP
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, airlied@linux.ie,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de, vkoul@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-02-22 16:16:48)
> Il 18/02/22 15:54, Guillaume Ranquet ha scritto:
> > From: Markus Schneider-Pargmann <msp@baylibre.com>
> >
> > Similar to HDMI, DP uses audio infoframes as well which are structured
> > very similar to the HDMI ones.
> >
> > This patch adds a helper function to pack the HDMI audio infoframe for
> > DP, called hdmi_audio_infoframe_pack_for_dp().
> > hdmi_audio_infoframe_pack_only() is split into two parts. One of them
> > packs the payload only and can be used for HDMI and DP.
> >
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>
> Hello Guillaume,
>
> I've just noticed that this patch will not apply against the latest linux-next,
> as the include/drm/drm_dp_helper.h header was moved to
> include/drm/dp/drm_dp_helper.h
>
> Can you please rebase for v9?
>
> Thanks,
> Angelo
>

I'm sorry, I'm a bit of a noob, I rebased this series against 5.17-rc4 ...
I'll rebase v9 against linux-next.

Thx,
Guillaume.

> > ---
> >   drivers/video/hdmi.c        | 83 ++++++++++++++++++++++++++++---------
> >   include/drm/drm_dp_helper.h |  2 +
> >   include/linux/hdmi.h        |  7 +++-
> >   3 files changed, 72 insertions(+), 20 deletions(-)
> >
