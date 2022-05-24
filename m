Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5507E5331B4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiEXTVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiEXTVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:21:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B1426AE3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:21:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t6so27103067wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uNv6ls8dnKUufiUdGbGdaPRRmY56nlCsQeJp2G8NpvM=;
        b=gNLvbkl8DL0/vaUesQvC2yj0wqHMsNaX2V5C5eX6vnKLo93SlXLl+UVLehFU351TVz
         eipO9D3yXkW5h0R4bxeR4b7S8wI4Bt9HWyQJCUknU5b5o2xo1/6egDPDoGXy50Wp1gqL
         LoA6dXoQOTvHoC4pxb9YIEWJZpuQARNAmQXgfG3zP2b5JKNsiyxD608QSGsMM8tnhipO
         XQ1l4ZDGqTeC9HJI95aEHlpe4uq83tsAz7ZCjVilWF8Ia5jY1CfX9cnwD6w6YM4Fbm03
         XRm59y4MwnOiUQPPSbcnnctS1Snwg87jqEShIHgxrUe+eoOgLIG+SN0bkzWW/F3EuumO
         1hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uNv6ls8dnKUufiUdGbGdaPRRmY56nlCsQeJp2G8NpvM=;
        b=mAnSqZaBdfYmAhTcX+I2wB3ghLd6pDyrLLbxBbCb+hw1Hm8gE1+Dxuq/5ou7Z2qJq8
         kCHhkI8P7688YOBaDPONnBzUzodo9Yg4fOnZYs5Jcns19aeXoNI66TtmvEOl/2wvVqbh
         lQmur36dnPhGgycMdtaCCqrzjaOEeCVatqDOPhzpQdyLsnuPQb16lRdEgqvJF2Z3kY/X
         AgIwFG74/iEP7TxnNjqLZi+GYNGw5dSMauuuIuwQWZLOuSG/wT/QfT6ohorvX5TbS87T
         thDIvKwrLo1NTX8pbnfa5hl9+WPqgQozWYrudKi0p4gjlmJsH1qiltmwjKInNbAJhhTy
         2YRQ==
X-Gm-Message-State: AOAM530ZTAbWd1OJ1ThVljcmdmGT25rr/QW8n2iNDhIrbe+CN3sHg4wu
        mrMoziFaujIdJ2KmHxqy3d0XSg==
X-Google-Smtp-Source: ABdhPJx3mRKDU6VolRY97BlNo6uf523WeVOwvNCjBxD2+leUVArciHSXU9pGzgvvUWL0Ms61KXchfg==
X-Received: by 2002:a05:6000:1a8c:b0:20c:bd6b:ecaf with SMTP id f12-20020a0560001a8c00b0020cbd6becafmr24165632wry.341.1653420091080;
        Tue, 24 May 2022 12:21:31 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:d9b6:6217:ea92:4fe0])
        by smtp.gmail.com with ESMTPSA id e21-20020a5d5955000000b0020c5253d8d0sm274479wri.28.2022.05.24.12.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:21:30 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] Input: mt6779-keypad - fix hardware code
 mapping
In-Reply-To: <Yosex9/a7OTuC6ZK@google.com>
References: <20220513151845.2802795-1-mkorpershoek@baylibre.com>
 <20220513151845.2802795-2-mkorpershoek@baylibre.com>
 <YoHf6Z4HTfh4Y+bn@google.com> <874k1qkk7n.fsf@baylibre.com>
 <4a7bcbfb-12da-0e3f-8732-ecc53046a4ff@collabora.com>
 <Yosex9/a7OTuC6ZK@google.com>
Date:   Tue, 24 May 2022 21:21:28 +0200
Message-ID: <87y1yq91on.fsf@baylibre.com>
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

On dim., mai 22, 2022 at 22:42, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Mon, May 16, 2022 at 01:06:43PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 16/05/22 09:30, Mattijs Korpershoek ha scritto:
>> > Hi Dmitry,
>> > 
>> > Thank you for your review,
>> > 
>> > On dim., mai 15, 2022 at 22:23, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> > 
>> > > On Fri, May 13, 2022 at 05:18:44PM +0200, Mattijs Korpershoek wrote:
>> > > > In mt6779_keypad_irq_handler(), we
>> > > > 1. Read a hardware code from KPD_MEM1 -> KPD_MEM5
>> > > > 2. Use that hardware code to compute columns/rows for the standard
>> > > >     keyboard matrix.
>> > > > 
>> > > > According to the (non-public) datasheet, the
>> > > > map between the hardware code and the cols/rows is:
>> > > > 
>> > > >          |(0)  |(1)  |(2)
>> > > >      ----*-----*-----*-----
>> > > >          |     |     |
>> > > >          |(9)  |(10) |(11)
>> > > >      ----*-----*-----*-----
>> > > >          |     |     |
>> > > >          |(18) |(19) |(20)
>> > > >      ----*-----*-----*-----
>> > > >          |     |     |
>> > > > 
>> > > > This brings us to another formula:
>> > > > -> row = code / 9;
>> > > > -> col = code % 3;
>> > > 
>> > > What if there are more than 3 columns?
>> > That's not supported, in hardware, according to the datasheet.
>> > 
>> > The datasheet I have states that "The interface of MT6763 only supports
>> > 3*3 single or 2*2 double, but internal ASIC still detects keys in the
>> > manner of 8*8 single, and 3*3 double. The registers and key codes still
>> > follows the legacy naming".
>> > 
>> > Should I add another patch in this series to add that limitation in the
>> > probe? There are no checks done in the probe() right now.
>> > 
>> 
>> I've just checked a downstream kernel for MT6795 and that one looks like
>> being fully compatible with this driver as well... and as far as downstream
>> is concerned, apparently, mt6735, 6739, 6755, 6757, 6758, 6763, 6771, 6775
>> all have the same register layout and the downstream driver for these is
>> always the very same one...
>> 
>> ...so, I don't think that there's currently any SoC that supports more than
>> three columns. Besides, a fast check shows that MT8195 also has the same.
>> At this point, I'd say that assuming that there are 3 columns, nor less, not
>> more, is just fine.
>
> OK, now that I looked at the datasheet I remember how it came about. The
> programming (register) interface does not really care about how actual
> matrix is organized, and instead has a set of bits representing keys,
> from KEY0 to KEY77, arranged in 5 chunks of 15 bits split into 5 32-bit
> registers. So we simply decided to use register number as row and
> offset in the register as column when encoding our "matrix".

That's correct and that's a good way to phrase it.
I will add that in the commit message.

>
> This does not match the actual keypad matrix organization, so if we want
> to change this, that's fine, but then we also need to recognize that we
> are skipping bits 16-31, 48-63, and so on, so to get to the right key
> number we need to do something like:
>
> 	key = bit_nr / 32 * 16 + bit_nr % 32;
> 	row = key / 9;
> 	col = key % 9;

I would prefer to have the driver's matrix_keypad (build in probe()) to
match the actual hardware. To me this seems easier to understand for
people familiar with the hardware.

I've also tested the above snippet and it matches my expectations.

>
> I looked at the datasheets I have and they talk about 8x8 single keypad
> matrix, and 3x3 double keypad (with actual matrices either 3x3 or 2x2)

Indeed. I plan to send out double keypad support for this driver since
that's actually needed for mt8183-pumpkin as well.
It's already in our mtk-v5.10[1] integration tree but I have not submitted
it yet.
I planned to send this a separate series to avoid burdening / have
smaller chunks to review. If that was a mistake, please let me know.

> but I do not actually see this map layout that Mattijs drew  documented

The map layout that I draw is not directly copied from the datasheet.
It's a "translation" of the following table:

| hardware key code | col0 | col1 | col2|
| ----------------- | -----| ---- | --- |
| row0              | 0    | 1    | 2   |
| row1              | 9    | 10   | 11  |
| row2              | 18   | 19   | 20  |

It seems that caused more confusion than actual useful information,
sorry about that.

> anywhere though...  I also wonder if there are already existing DTSes in
> the wild that will be rendered invalid by these changes. I wonder if it
> would not be be better to document the existing meaning of row and
> column in the driver?

The concern for "DTSes in the wild" that will break is a valid point.
I'm not aware of any of those. Most vendor trees i've seen don't use
this driver at all. I hope that will change at some point.

In the end. I'd prefer to have the driver's keypad matrix match
the actual hardware. Right now we can have a 5x32 matrix which seems
absurd. Having at most an 8x8 is more reasonable.

I'd like to send v3 with just fixing the row/column suggestion in
mt6779_keypad_irq_handler() that Dmitry suggested.

Would that work Dmitry?


[1] https://gitlab.com/mediatek/aiot/bsp/linux/-/tree/mtk-v5.10

> Thanks.
>
> -- 
> Dmitry
