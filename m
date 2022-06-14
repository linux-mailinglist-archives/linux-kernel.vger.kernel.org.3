Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A494954AD05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiFNJOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiFNJOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:14:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350AC3B3EF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:14:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h5so10402964wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=1PEgNV76hBzB6iDg7NLqEWfxjK6e1PfjB4fdqgmJIsg=;
        b=g7qdxe5wJnpbkvpmYcGZUkBL7RrbUdm9iFiiyxxOx98PpAX6nOBWp+TbUAep6PLjWC
         P0obYORDbNp3LDjSfc+uWU6hVRaAnWk2vbAowTErtJD6dbBtp+E2ZnxvISME/ppJAl05
         7SYkDMy4TZI3dOtq1cwQAj5PXZmT/UsiizBzvoYbKNXqXXjD/0PZ8RAo1d4cAviUHP07
         eOOCpA0lpwjV0qXPxvcCeQpFnmvIgO4ChVo2dbOEaznpu9M1NJZzRpTyjcperKuYPq8n
         RrezbIx+aLjJw3QiZqu8AZPvIN6Dle0ejIsJ0Ekp5xj1Kiq126E4KVpwH1RAkcllNErP
         tVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1PEgNV76hBzB6iDg7NLqEWfxjK6e1PfjB4fdqgmJIsg=;
        b=64Y/YUmJwPEnoxb576e7pKPvZ/6ZMB4vdPzadRRZJ1ZLIfnW2mtI1BPZY/YxrxXAzz
         H51UMQngpfGdimbSRTD2dya5wUk8F2fhdVGjxdJqySwoSC0ivCFBwFLdSDBPpjkBOfFP
         HExH2exhPs2m6ntJs1WwHgFkcvei1C7vmeTu0v0e0SsCXC7rfbzENGNb7AD/i5NNjF3F
         w8EeHzJgcVll+i0HwnFTjLYLR8mA3Nd7YetweXvKbXXOZh9zjBR2atbjorLiFGoI7x2T
         5VY3vTZSR9FtDPuFuPMQBhxL5q+cWc3wa/PKrC/Nb2qotQLkpv0iqd7Dh9b6VSXWW62S
         kNaQ==
X-Gm-Message-State: AJIora/pf8cRCOS2JjuvWC7WNZw9kcwRpSpvVys9/U6VR3eSQQAfXTiZ
        4kYYCa5mgWd1H3+HIS9Fn3QKgQ==
X-Google-Smtp-Source: AGRyM1tSmncL8VjzLwW+1DETDL6nQuvoWygWqWZi9ryqLeCWAt6zZJ1mW0CRtdxhg1hWk+o3NzC41w==
X-Received: by 2002:a05:6000:1e0a:b0:210:32e1:3b03 with SMTP id bj10-20020a0560001e0a00b0021032e13b03mr3957404wrb.642.1655198042707;
        Tue, 14 Jun 2022 02:14:02 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:7683:73d4:ea19:83d0])
        by smtp.gmail.com with ESMTPSA id f5-20020adfdb45000000b00210352bf36fsm11133784wrj.33.2022.06.14.02.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 02:14:02 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] Input: mt6779-keypad - fix hardware code
 mapping
In-Reply-To: <YpMDZORAlHmg/x/0@google.com>
References: <20220513151845.2802795-1-mkorpershoek@baylibre.com>
 <20220513151845.2802795-2-mkorpershoek@baylibre.com>
 <YoHf6Z4HTfh4Y+bn@google.com> <874k1qkk7n.fsf@baylibre.com>
 <4a7bcbfb-12da-0e3f-8732-ecc53046a4ff@collabora.com>
 <Yosex9/a7OTuC6ZK@google.com> <87y1yq91on.fsf@baylibre.com>
 <YpMDZORAlHmg/x/0@google.com>
Date:   Tue, 14 Jun 2022 11:14:01 +0200
Message-ID: <874k0nfvza.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sam., mai 28, 2022 at 22:23, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Tue, May 24, 2022 at 09:21:28PM +0200, Mattijs Korpershoek wrote:
>> On dim., mai 22, 2022 at 22:42, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> 
>> > On Mon, May 16, 2022 at 01:06:43PM +0200, AngeloGioacchino Del Regno wrote:
>> >> Il 16/05/22 09:30, Mattijs Korpershoek ha scritto:
>> >> > Hi Dmitry,
>> >> > 
>> >> > Thank you for your review,
>> >> > 
>> >> > On dim., mai 15, 2022 at 22:23, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> >> > 
>> >> > > On Fri, May 13, 2022 at 05:18:44PM +0200, Mattijs Korpershoek wrote:
>> >> > > > In mt6779_keypad_irq_handler(), we
>> >> > > > 1. Read a hardware code from KPD_MEM1 -> KPD_MEM5
>> >> > > > 2. Use that hardware code to compute columns/rows for the standard
>> >> > > >     keyboard matrix.
>> >> > > > 
>> >> > > > According to the (non-public) datasheet, the
>> >> > > > map between the hardware code and the cols/rows is:
>> >> > > > 
>> >> > > >          |(0)  |(1)  |(2)
>> >> > > >      ----*-----*-----*-----
>> >> > > >          |     |     |
>> >> > > >          |(9)  |(10) |(11)
>> >> > > >      ----*-----*-----*-----
>> >> > > >          |     |     |
>> >> > > >          |(18) |(19) |(20)
>> >> > > >      ----*-----*-----*-----
>> >> > > >          |     |     |
>> >> > > > 
>> >> > > > This brings us to another formula:
>> >> > > > -> row = code / 9;
>> >> > > > -> col = code % 3;
>> >> > > 
>> >> > > What if there are more than 3 columns?
>> >> > That's not supported, in hardware, according to the datasheet.
>> >> > 
>> >> > The datasheet I have states that "The interface of MT6763 only supports
>> >> > 3*3 single or 2*2 double, but internal ASIC still detects keys in the
>> >> > manner of 8*8 single, and 3*3 double. The registers and key codes still
>> >> > follows the legacy naming".
>> >> > 
>> >> > Should I add another patch in this series to add that limitation in the
>> >> > probe? There are no checks done in the probe() right now.
>> >> > 
>> >> 
>> >> I've just checked a downstream kernel for MT6795 and that one looks like
>> >> being fully compatible with this driver as well... and as far as downstream
>> >> is concerned, apparently, mt6735, 6739, 6755, 6757, 6758, 6763, 6771, 6775
>> >> all have the same register layout and the downstream driver for these is
>> >> always the very same one...
>> >> 
>> >> ...so, I don't think that there's currently any SoC that supports more than
>> >> three columns. Besides, a fast check shows that MT8195 also has the same.
>> >> At this point, I'd say that assuming that there are 3 columns, nor less, not
>> >> more, is just fine.
>> >
>> > OK, now that I looked at the datasheet I remember how it came about. The
>> > programming (register) interface does not really care about how actual
>> > matrix is organized, and instead has a set of bits representing keys,
>> > from KEY0 to KEY77, arranged in 5 chunks of 15 bits split into 5 32-bit
>> > registers. So we simply decided to use register number as row and
>> > offset in the register as column when encoding our "matrix".
>> 
>> That's correct and that's a good way to phrase it.
>> I will add that in the commit message.
>> 
>> >
>> > This does not match the actual keypad matrix organization, so if we want
>> > to change this, that's fine, but then we also need to recognize that we
>> > are skipping bits 16-31, 48-63, and so on, so to get to the right key
>> > number we need to do something like:
>> >
>> > 	key = bit_nr / 32 * 16 + bit_nr % 32;
>> > 	row = key / 9;
>> > 	col = key % 9;
>> 
>> I would prefer to have the driver's matrix_keypad (build in probe()) to
>> match the actual hardware. To me this seems easier to understand for
>> people familiar with the hardware.
>> 
>> I've also tested the above snippet and it matches my expectations.
>> 
>> >
>> > I looked at the datasheets I have and they talk about 8x8 single keypad
>> > matrix, and 3x3 double keypad (with actual matrices either 3x3 or 2x2)
>> 
>> Indeed. I plan to send out double keypad support for this driver since
>> that's actually needed for mt8183-pumpkin as well.
>> It's already in our mtk-v5.10[1] integration tree but I have not submitted
>> it yet.
>> I planned to send this a separate series to avoid burdening / have
>> smaller chunks to review. If that was a mistake, please let me know.
>> 
>> > but I do not actually see this map layout that Mattijs drew  documented
>> 
>> The map layout that I draw is not directly copied from the datasheet.
>> It's a "translation" of the following table:
>> 
>> | hardware key code | col0 | col1 | col2|
>> | ----------------- | -----| ---- | --- |
>> | row0              | 0    | 1    | 2   |
>> | row1              | 9    | 10   | 11  |
>> | row2              | 18   | 19   | 20  |
>> 
>> It seems that caused more confusion than actual useful information,
>> sorry about that.
>> 
>> > anywhere though...  I also wonder if there are already existing DTSes in
>> > the wild that will be rendered invalid by these changes. I wonder if it
>> > would not be be better to document the existing meaning of row and
>> > column in the driver?
>> 
>> The concern for "DTSes in the wild" that will break is a valid point.
>> I'm not aware of any of those. Most vendor trees i've seen don't use
>> this driver at all. I hope that will change at some point.
>> 
>> In the end. I'd prefer to have the driver's keypad matrix match
>> the actual hardware. Right now we can have a 5x32 matrix which seems
>> absurd. Having at most an 8x8 is more reasonable.
>> 
>> I'd like to send v3 with just fixing the row/column suggestion in
>> mt6779_keypad_irq_handler() that Dmitry suggested.
>> 
>> Would that work Dmitry?
>
> OK, let's do that. Although I'd be curious to see the double keypad
> patches as according to the datasheets I saw the translation is
> different for those.

Sorry for the delay. I had some long needed away time from my computer.

Yes, it's a different translation for double keypad.

I will send a v3 to fix single keys and make sure to send the double
keypad support afterwards.


>
> Thanks.
>
> -- 
> Dmitry
