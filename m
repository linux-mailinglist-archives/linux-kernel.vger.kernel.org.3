Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77E52B2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiERG40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiERG4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:56:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539EBD104
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:56:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t6so1257409wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CQIReHnD+6J/f9DYUtohMgFS79x6Zc0p2l4WD6IBG7c=;
        b=KyJCyCdZX/CgAvmTt7yYHwAt8cwO+kY+mY1Q9hSekfZAEuaZm4EtJijZqVNc2O63c4
         h9pACHHzz2ZLJ/YQnc2e5gMLpvwkjM0ipMcB+3VM6Etb704T5hLWiUbKYzNgGM47CvID
         qmhWCsdy/0g3axEBFScsaWFI1wZrdcZ438b3WkaFg6Ht7Mse1GKnG+mUnqe3ZFy/UEzl
         MvkXJgNfg8ryjQpyc5Ba26iyuCQz75kKZ++SOmNTPKrr0I3nwteVmSJZOmcg6jxaIyQl
         NdkcYaDDvblu1CdZz4hE4BHZmKzk/SFSKRC80p4HOrfaf2tjDRqzjlzokEM3TnaLbJSR
         VpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CQIReHnD+6J/f9DYUtohMgFS79x6Zc0p2l4WD6IBG7c=;
        b=gEV4sbMjJ/7xzmsFVTmjM+Qwl/nrQ1VmoL9OevZRpqA1iV4w09ilKR4rA7MIpt5YqD
         ul7usrtT974nYFW8sZeFlQfCagSkJFcDF1I/tdCknib2N7PlqT/As6Pp3KsmIWhLF2nn
         XZMi+3P6vtHNCnZJNUimhGHg4PvWWxztnCmbs8vH1w4zpQQTLpuF3Nc3olt4GMrfim6d
         ruZJ7K7+Baoy9lYbB4D8PKgrjYYX5cQuNeIexSRO2y061JUUgD7u5VFUPyJMzJZ/7epd
         k38gMNEZmaGiUJvzq9/CvenDMudPDmJUfrBpxgKVAra1LD+YG4avJiHUhIPTjG1Np9Is
         8y3A==
X-Gm-Message-State: AOAM531v9IiKi40FlwTY7/TJoeKO6q/yQ9Gcl4FNPBv1xvwByktXLdYW
        NCcqPAuBQHLXP7oXpWqePXlo0g==
X-Google-Smtp-Source: ABdhPJxqFJWFFJAZOCXntQD4XGLErH8Sgri/Wrkfkvpk99R2ty4HwuD52N1klwypW+CMYx+ticzBqg==
X-Received: by 2002:a5d:448d:0:b0:20d:744:7663 with SMTP id j13-20020a5d448d000000b0020d07447663mr12747395wrq.654.1652856980810;
        Tue, 17 May 2022 23:56:20 -0700 (PDT)
Received: from localhost (laubervilliers-656-1-151-143.w92-154.abo.wanadoo.fr. [92.154.18.143])
        by smtp.gmail.com with ESMTPSA id m7-20020adfa3c7000000b0020c5253d8cesm1097175wrb.26.2022.05.17.23.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 23:56:20 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] Input: mt6779-keypad - fix hardware code
 mapping
In-Reply-To: <4a7bcbfb-12da-0e3f-8732-ecc53046a4ff@collabora.com>
References: <20220513151845.2802795-1-mkorpershoek@baylibre.com>
 <20220513151845.2802795-2-mkorpershoek@baylibre.com>
 <YoHf6Z4HTfh4Y+bn@google.com> <874k1qkk7n.fsf@baylibre.com>
 <4a7bcbfb-12da-0e3f-8732-ecc53046a4ff@collabora.com>
Date:   Wed, 18 May 2022 08:56:19 +0200
Message-ID: <87bkvve3cc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 13:06, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 16/05/22 09:30, Mattijs Korpershoek ha scritto:
>> Hi Dmitry,
>> 
>> Thank you for your review,
>> 
>> On dim., mai 15, 2022 at 22:23, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> 
>>> On Fri, May 13, 2022 at 05:18:44PM +0200, Mattijs Korpershoek wrote:
>>>> In mt6779_keypad_irq_handler(), we
>>>> 1. Read a hardware code from KPD_MEM1 -> KPD_MEM5
>>>> 2. Use that hardware code to compute columns/rows for the standard
>>>>     keyboard matrix.
>>>>
>>>> According to the (non-public) datasheet, the
>>>> map between the hardware code and the cols/rows is:
>>>>
>>>>          |(0)  |(1)  |(2)
>>>>      ----*-----*-----*-----
>>>>          |     |     |
>>>>          |(9)  |(10) |(11)
>>>>      ----*-----*-----*-----
>>>>          |     |     |
>>>>          |(18) |(19) |(20)
>>>>      ----*-----*-----*-----
>>>>          |     |     |
>>>>
>>>> This brings us to another formula:
>>>> -> row = code / 9;
>>>> -> col = code % 3;
>>>
>>> What if there are more than 3 columns?
>> That's not supported, in hardware, according to the datasheet.
>> 
>> The datasheet I have states that "The interface of MT6763 only supports
>> 3*3 single or 2*2 double, but internal ASIC still detects keys in the
>> manner of 8*8 single, and 3*3 double. The registers and key codes still
>> follows the legacy naming".
>> 
>> Should I add another patch in this series to add that limitation in the
>> probe? There are no checks done in the probe() right now.
>> 
>
> I've just checked a downstream kernel for MT6795 and that one looks like
> being fully compatible with this driver as well... and as far as downstream
> is concerned, apparently, mt6735, 6739, 6755, 6757, 6758, 6763, 6771, 6775
> all have the same register layout and the downstream driver for these is
> always the very same one...
Thank you for taking the time to check in your downstream kernels, I
really appreciate it.

>
> ...so, I don't think that there's currently any SoC that supports more than
> three columns. Besides, a fast check shows that MT8195 also has the same.
> At this point, I'd say that assuming that there are 3 columns, nor less, not
> more, is just fine.
>
> To stay on the safe side, though, perhaps add a comment explaining that
> this driver works on that assumption? ..but that's clear, anyway, if you
> actually read the code.
>
>  From my perspective, this commit is good to go.
I will keep as is for v2 series and apply your review tag. thanks again !

>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
