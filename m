Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B635282D2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbiEPLHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiEPLGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:06:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAE7F32;
        Mon, 16 May 2022 04:06:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 185B01F42BC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652699207;
        bh=cuIpTwvM6Wp6EPsCrNGnkRiHx0Cg+OXQRwrHe5I0Obo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VWKf1M6Z3XGlPerCoCGieGG0m47NRZp43NpK9jLnuhMEV2hgS7F2ItS22PN0kHSFw
         Pgj2LvvXGB2mkwug2qo196Rbv1hfSZFvl3e+Vk6uGTJAfknrDNPGXmA8rnHESHnF4m
         i2gjcv+59r9XJK3EyCdfnYjs2kLGZybX2DRCs3g4xZLBKIuM7KS+qRS7Yqxl26HsYH
         NAao8JteBAXK+xMf2V+dYRNMlzAGYVo40EtmMezAlm9bsJTbTIFPLR2Tq2MAOn4MMT
         fZAkAi6kN02ER+4dlJKOPTkSl3Cw4ypxvEcHdcTAzA+IBPg1lrOeox2lqgs6P9UXD9
         PK9bZGs6t4sgw==
Message-ID: <4a7bcbfb-12da-0e3f-8732-ecc53046a4ff@collabora.com>
Date:   Mon, 16 May 2022 13:06:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RESEND PATCH 1/2] Input: mt6779-keypad - fix hardware code
 mapping
Content-Language: en-US
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220513151845.2802795-1-mkorpershoek@baylibre.com>
 <20220513151845.2802795-2-mkorpershoek@baylibre.com>
 <YoHf6Z4HTfh4Y+bn@google.com> <874k1qkk7n.fsf@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <874k1qkk7n.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/05/22 09:30, Mattijs Korpershoek ha scritto:
> Hi Dmitry,
> 
> Thank you for your review,
> 
> On dim., mai 15, 2022 at 22:23, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
>> On Fri, May 13, 2022 at 05:18:44PM +0200, Mattijs Korpershoek wrote:
>>> In mt6779_keypad_irq_handler(), we
>>> 1. Read a hardware code from KPD_MEM1 -> KPD_MEM5
>>> 2. Use that hardware code to compute columns/rows for the standard
>>>     keyboard matrix.
>>>
>>> According to the (non-public) datasheet, the
>>> map between the hardware code and the cols/rows is:
>>>
>>>          |(0)  |(1)  |(2)
>>>      ----*-----*-----*-----
>>>          |     |     |
>>>          |(9)  |(10) |(11)
>>>      ----*-----*-----*-----
>>>          |     |     |
>>>          |(18) |(19) |(20)
>>>      ----*-----*-----*-----
>>>          |     |     |
>>>
>>> This brings us to another formula:
>>> -> row = code / 9;
>>> -> col = code % 3;
>>
>> What if there are more than 3 columns?
> That's not supported, in hardware, according to the datasheet.
> 
> The datasheet I have states that "The interface of MT6763 only supports
> 3*3 single or 2*2 double, but internal ASIC still detects keys in the
> manner of 8*8 single, and 3*3 double. The registers and key codes still
> follows the legacy naming".
> 
> Should I add another patch in this series to add that limitation in the
> probe? There are no checks done in the probe() right now.
> 

I've just checked a downstream kernel for MT6795 and that one looks like
being fully compatible with this driver as well... and as far as downstream
is concerned, apparently, mt6735, 6739, 6755, 6757, 6758, 6763, 6771, 6775
all have the same register layout and the downstream driver for these is
always the very same one...

...so, I don't think that there's currently any SoC that supports more than
three columns. Besides, a fast check shows that MT8195 also has the same.
At this point, I'd say that assuming that there are 3 columns, nor less, not
more, is just fine.

To stay on the safe side, though, perhaps add a comment explaining that
this driver works on that assumption? ..but that's clear, anyway, if you
actually read the code.

 From my perspective, this commit is good to go.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
