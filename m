Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2FC527E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbiEPHb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241130AbiEPHa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:30:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0D10C7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:30:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m1so19216056wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=aotE6OIWBWcMAPi2qqhhLJmw3JfHuAoIxd975f4asGo=;
        b=p50ytBaXArwLqIx9ZuK2RaNm29nxjYQrBkovzkLjtC2CeBs8QG0NPGeqEZIzZU3o5h
         A4tP0viD1OY8LtLfwheDor3V/lmTQoUEsXLvHHqNqRyciYxG9I2cXSv+y68LzqQ0hvTU
         IRV0ijY69+GEAj2bv1sq05P6KnZJ4/7Kr+Ziyh7P4yfenHl7PNehvZM5oXk7M3161hw/
         BrTNrIXMFMLVXjVMh5oEyZ9oegGVmOp88ovQKx7VX0Zt+PG/1LNX2owiNHD9knLes+6B
         GJxwaxivXhwAFnXh7T+FTOCUKrGKCpRq7cJdx8WD6uIR3JZ7vPtesOavbE/lEbNeBI45
         kHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aotE6OIWBWcMAPi2qqhhLJmw3JfHuAoIxd975f4asGo=;
        b=v9xc2dn8FcDGPzmJIIvr5rcRjSx4pXvnwLkVRfztgcV8+E6eE8XuFwiIcujbWIkibH
         nMug0H/16rS6WNkGFrd8FUmJbGjT9KOaAgYKE0f4EwNOAovFLqo/fmJWjvd6M/ImecOR
         7gjeML4N0uHCWgj5GT9yqh4ir3WYsEyeU3zcUnor79jdnwdioFZvQY0zcgHxnZ3NWM0z
         5YhDYTqJfV0WsFF90R1sNeHjZnwmhqfUg2ySotiUpTng1FfdPJ789iONkX4dc6M5xcvB
         ql1PKR5heWW96LwjgCiU0irJaEIkHhXb48BwD+/77vGELw32CFPx+wtPMHetW0Ra5nOB
         z41A==
X-Gm-Message-State: AOAM530hwJZv8UieW0M9o6enoHv1hIzNLLAvzipeLY36HDmvXw5Fd7kA
        VbQWtx74PNrqTMpWrN0lJgLlEg==
X-Google-Smtp-Source: ABdhPJz8SDT8s/y8iDCPKO++gfmDYIj8bfPvrtjBR3u4ZNO4AJVGNlkVbfv1MybV9Lo8reF7IVvVTg==
X-Received: by 2002:a05:6000:716:b0:20c:4cda:b38c with SMTP id bs22-20020a056000071600b0020c4cdab38cmr13182687wrb.226.1652686253793;
        Mon, 16 May 2022 00:30:53 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:6d30:f384:3f7:365e])
        by smtp.gmail.com with ESMTPSA id z12-20020a7bc7cc000000b003942a244f39sm14468765wmk.18.2022.05.16.00.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:30:53 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] Input: mt6779-keypad - fix hardware code
 mapping
In-Reply-To: <YoHf6Z4HTfh4Y+bn@google.com>
References: <20220513151845.2802795-1-mkorpershoek@baylibre.com>
 <20220513151845.2802795-2-mkorpershoek@baylibre.com>
 <YoHf6Z4HTfh4Y+bn@google.com>
Date:   Mon, 16 May 2022 09:30:52 +0200
Message-ID: <874k1qkk7n.fsf@baylibre.com>
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

Hi Dmitry,

Thank you for your review,

On dim., mai 15, 2022 at 22:23, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Fri, May 13, 2022 at 05:18:44PM +0200, Mattijs Korpershoek wrote:
>> In mt6779_keypad_irq_handler(), we
>> 1. Read a hardware code from KPD_MEM1 -> KPD_MEM5
>> 2. Use that hardware code to compute columns/rows for the standard
>>    keyboard matrix.
>> 
>> According to the (non-public) datasheet, the
>> map between the hardware code and the cols/rows is:
>> 
>>         |(0)  |(1)  |(2)
>>     ----*-----*-----*-----
>>         |     |     |
>>         |(9)  |(10) |(11)
>>     ----*-----*-----*-----
>>         |     |     |
>>         |(18) |(19) |(20)
>>     ----*-----*-----*-----
>>         |     |     |
>> 
>> This brings us to another formula:
>> -> row = code / 9;
>> -> col = code % 3;
>
> What if there are more than 3 columns?
That's not supported, in hardware, according to the datasheet.

The datasheet I have states that "The interface of MT6763 only supports
3*3 single or 2*2 double, but internal ASIC still detects keys in the
manner of 8*8 single, and 3*3 double. The registers and key codes still
follows the legacy naming".

Should I add another patch in this series to add that limitation in the
probe? There are no checks done in the probe() right now.

>
>> 
>> Implement this mapping in bitnr_to_col_row() to fetch the
>> correct input event from keypad->input_dev->keycode and report that
>> back to userspace.
>> 
>> Fixes: f28af984e771 ("Input: mt6779-keypad - add MediaTek keypad driver")
>> Co-developed-by: Fabien Parent <fparent@baylibre.com>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>>  drivers/input/keyboard/mt6779-keypad.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
>> index 2e7c9187c10f..23360de20da5 100644
>> --- a/drivers/input/keyboard/mt6779-keypad.c
>> +++ b/drivers/input/keyboard/mt6779-keypad.c
>> @@ -36,6 +36,19 @@ static const struct regmap_config mt6779_keypad_regmap_cfg = {
>>  	.max_register = 36,
>>  };
>>  
>> +/*
>> + * | hardware key code | col0 | col1 | col2|
>> + * | ----------------- | -----| ---- | --- |
>> + * | row0              | 0    | 1    | 2   |
>> + * | row1              | 9    | 10   | 11  |
>> + * | row2              | 18   | 19   | 20  |
>> + */
>> +static void bitnr_to_col_row(int bit_nr, int *col, int *row)
>> +{
>> +	*row = bit_nr / 9;
>> +	*col = bit_nr % 3;
>> +}
>> +
>>  static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
>>  {
>>  	struct mt6779_keypad *keypad = dev_id;
>> @@ -61,8 +74,7 @@ static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
>>  		if (bit_nr % 32 >= 16)
>>  			continue;
>>  
>> -		row = bit_nr / 32;
>> -		col = bit_nr % 32;
>> +		bitnr_to_col_row(bit_nr, &col, &row);
>>  		scancode = MATRIX_SCAN_CODE(row, col, row_shift);
>>  		/* 1: not pressed, 0: pressed */
>>  		pressed = !test_bit(bit_nr, new_state);
>> -- 
>> 2.32.0
>> 
>
> -- 
> Dmitry
