Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602D2560515
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiF2P7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiF2P7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:59:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF311BE93;
        Wed, 29 Jun 2022 08:59:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so9025116wmp.3;
        Wed, 29 Jun 2022 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNly1dfG4RY5ld91Tin+FHgAbZbcnCeyfevD6nD1vfc=;
        b=ZgK2yec9C4SmTv4WPvJao1de+26SSYJi9rBk2Rm5tsjBhm84Yai0AaWoHnwo8hxldR
         9klx9J26g4poB1ilLULPFvjpYmbTXZgqjR5jBDuDaCXRnejPGxTL9FQWDJQjwvm9d62Z
         wqrON8mV1zO7WtefS2+bi0tYsSsq+R3gxgRt3JZCnSWKxoiX/1wD1l/9G48Nyv48fyK1
         esV/Tfz4nn6Zw1aHdKtTzQgu7Eaic0SxMRHB/Y9gbcJby4fgGAluUiP08MTXcISxD9qO
         +x6hejlvzv8jO2GDoURMi9RpPIAHWVsYCRCbuzEwSmi6pn55/C/vppZqg/HNESGFxliO
         oRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNly1dfG4RY5ld91Tin+FHgAbZbcnCeyfevD6nD1vfc=;
        b=f2rjlWZ47pBRYQbTkjOh/qT2fvifGKbdrvaVyqdlGqnjPpXQVqwJXnk5rLvjhFCzLl
         9ZJ45whtj2kvMhQ1Hote0xIh0FWbkAdZNKPznJlYMvbJVxdXWFe5XmlTZc3fL515oJOQ
         tswuXfw6Gln204qvTcUW9AAsn8QEq6ubqyQGFDZk3VuzxMbyuArn1g+9MzzFsp3B8xDQ
         MEFjSPhekHtm7BeBKj5aaUpR1MDa8LwWf7AF3J4m9UmMvxroEGr6uBgyGxd273mPioa8
         rFRlyom3NmLwwAhjQMbvuXgjC7rWQ0APjra3Z8/Oy4dDlbYbD8OIN0OMXcIS94+4k48O
         uygA==
X-Gm-Message-State: AJIora/S6KoSvjmlF0k4tPuKYeojZnYZYuc4jbXdGJ03P+mSm7pw9LgH
        DaLtLufVIa6WZzTFBmHd263e+H/z1gxjQ6Ktz2Y=
X-Google-Smtp-Source: AGRyM1tAAlS4kM+nsw/NsoxnqWVB7y/vftH9UCWhq7jvEEfRS+sgsPnvHp0EazC+wGHRC5cFIqKQzo9Y/BNHvxxfINU=
X-Received: by 2002:a05:600c:3516:b0:39c:8091:31b6 with SMTP id
 h22-20020a05600c351600b0039c809131b6mr6732490wmq.164.1656518376833; Wed, 29
 Jun 2022 08:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220510132256.v2.1.Ibf12c1b99feecc4130f1e3130a3fc4ddd710a2e9@changeid>
 <YrvVPiLQL6d4MrFV@builder.lan> <654c8819-5721-838e-4148-6fbdc5fc2dcd@quicinc.com>
In-Reply-To: <654c8819-5721-838e-4148-6fbdc5fc2dcd@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 29 Jun 2022 08:59:50 -0700
Message-ID: <CAF6AEGuV=sF2sLfQ53AJ4pQYFCjMH3-ephwyGW_HQqnkKRm5MQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/msm/a6xx: Add support for a new 7c3 sku
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sean Paul <sean@poorly.run>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jun 28, 2022 at 10:32 PM Akhil P Oommen
<quic_akhilpo@quicinc.com> wrote:
>
> On 6/29/2022 9:59 AM, Bjorn Andersson wrote:
> > On Tue 10 May 02:53 CDT 2022, Akhil P Oommen wrote:
> >
> >> Add a new sku to the fuse map of 7c3 gpu.
> >>
> >> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> > Is this series still needed/wanted? I've been waiting for patch 1 to be
> > merged in the driver so that I can pick up the dts change.

It just missed the previous merge window by a couple of days.. I was
planning to pick it up for the upcoming merge window

but I don't think the dt bit should depend on the driver bit in this case

> >
> > Regards,
> > Bjorn
> Internally, this sku is on hold. So we can drop this series for now. I
> will resend it if required in future.

ok, I'll hold off for now

BR,
-R

> -Akhil.
>
> >
> >> ---
> >>
> >> (no changes since v1)
> >>
> >>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> index 841e47a..61bb21d 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> @@ -1771,6 +1771,8 @@ static u32 adreno_7c3_get_speed_bin(u32 fuse)
> >>              return 0;
> >>      else if (fuse == 190)
> >>              return 1;
> >> +    else if (fuse == 96)
> >> +            return 2;
> >>
> >>      return UINT_MAX;
> >>   }
> >> --
> >> 2.7.4
> >>
>
