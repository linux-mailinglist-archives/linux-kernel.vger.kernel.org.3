Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713EA57CE37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiGUOv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiGUOvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:51:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294988689F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:51:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m17so2339718wrw.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=IPaODleuydbpyW0oBL1XNwJwvfUIp3A8aiBZ01eGt1Q=;
        b=Bp2CpXtTwoG2Mnt4Fsd7PNBiqhFzvabUoEaCdKBe3coRfhSaMn+IIzpniKnrnFrdUL
         YhHsz3Ra5N7e+r023RiThEm579WWFjxT2W0IebSd/oCBBUrkN2xOrQcsyBg6JyfJ/B06
         uW2TLiUxl2xnqjMml93W/ohzP0oDXt+rL55KYML2aeVYi9E9IwK0fr75+lVU9M4E6WHn
         w+wMYeCQ/PNSDSqlUkF0fvC4GDYMUpr7/gqG3lio6pvxXZ229AUfF0LOIV9uFJw/fDXj
         xPhrjpbrWMoF9dB7pyMhKmgN+M7JS8WWrZtMk0sg7uhJaH7SOHY7byVkp4DdroOI7rGq
         6F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IPaODleuydbpyW0oBL1XNwJwvfUIp3A8aiBZ01eGt1Q=;
        b=R8eDTLzFXXLZfzfFvlfEma575sUZDiUcsdDq70RuZ6GO+oWNVc5DjvWhyiPHok/XWn
         lw2lmY5wRExiskxt4/LqS4DwFNV/QrndoESBENtZ8x0qvq1tZdVhfkdXMxHdfAeumYdh
         lRKsvgMGL1MZnEUPrX58OBCWsjA8+nf6wpXwmnW5AOZ4d2vlDFa8VX+LfBOMmUQTj7he
         0cQlsHmGVQYjPSaV1oe2X7kdDn7Tw778+zJKPFw5aMOOjepN1sKThnzbKb468xL2P/n/
         QfZDLQYl6WWjZ3Ki+aVpm5r4eHKhnWf0bKqDVaG/1dLj7X/XaARUUMgcWheRAkBoxyK+
         k90A==
X-Gm-Message-State: AJIora8Bi6r6yrnUZq3NiUMimrR1VLciqGXj5lBQ9YAZ0Kc6ywcilKV3
        SKpAT4n1SiyzFbOY9osSSkNs2Cj5NIn4lg==
X-Google-Smtp-Source: AGRyM1sfP4ZknR79BKzwBYDjRzsvFl6fMqYkGmVH+vZxkOOLeoF5imavLdHStfa8XEkO8/4kwJBLWg==
X-Received: by 2002:adf:f0c6:0:b0:21e:4480:2fa5 with SMTP id x6-20020adff0c6000000b0021e44802fa5mr9138352wro.377.1658415090631;
        Thu, 21 Jul 2022 07:51:30 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003a0323463absm2087311wmc.45.2022.07.21.07.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 07:51:30 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 4/6] Input: mt6779-keypad - support double keys matrix
In-Reply-To: <b2676b5c-14b3-2058-9fb8-d6d78cc5d29c@collabora.com>
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
 <20220720-mt8183-keypad-v1-4-ef9fc29dbff4@baylibre.com>
 <b2676b5c-14b3-2058-9fb8-d6d78cc5d29c@collabora.com>
Date:   Thu, 21 Jul 2022 16:51:29 +0200
Message-ID: <87ilnqh632.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:34, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 20/07/22 16:48, Mattijs Korpershoek ha scritto:
>> MediaTek keypad has 2 modes of detecting key events:
>> - single key: each (row, column) can detect one key
>> - double key: each (row, column) is a group of 2 keys
>> 
>> Double key support exists to minimize cost, since it reduces the number
>> of pins required for physical keys.
>> 
>> Double key is configured by setting BIT(0) of the KP_SEL register.
>> 
>> Enable double key matrix support based on the mediatek,double-keys
>> device tree property.
>> 
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>> 
>> diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
>> index bf447bf598fb..9a5dbd415dac 100644
>> --- a/drivers/input/keyboard/mt6779-keypad.c
>> +++ b/drivers/input/keyboard/mt6779-keypad.c
>> @@ -18,6 +18,7 @@
>>   #define MTK_KPD_DEBOUNCE_MASK	GENMASK(13, 0)
>>   #define MTK_KPD_DEBOUNCE_MAX_MS	256
>>   #define MTK_KPD_SEL		0x0020
>> +#define MTK_KPD_SEL_DOUBLE_KP_MODE	BIT(0)
>>   #define MTK_KPD_SEL_COL	GENMASK(15, 10)
>>   #define MTK_KPD_SEL_ROW	GENMASK(9, 4)
>>   #define MTK_KPD_SEL_COLMASK(c)	GENMASK((c) + 9, 10)
>> @@ -31,6 +32,7 @@ struct mt6779_keypad {
>>   	struct clk *clk;
>>   	u32 n_rows;
>>   	u32 n_cols;
>> +	bool double_keys;
>>   	DECLARE_BITMAP(keymap_state, MTK_KPD_NUM_BITS);
>>   };
>>   
>> @@ -67,8 +69,13 @@ static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
>>   			continue;
>>   
>>   		key = bit_nr / 32 * 16 + bit_nr % 32;
>> -		row = key / 9;
>> -		col = key % 9;
>> +		if (keypad->double_keys) {
>> +			row = key / 13;
>> +			col = (key % 13) / 2;
>> +		} else {
>> +			row = key / 9;
>> +			col = key % 9;
>> +		}
>
> I don't fully like this if branch permanently evaluating true or false, as no
> runtime can actually change this result...
>
> In practice, it's fine, but I was wondering if anyone would disagree with the
> following proposal...
>
> struct mt6779_keypad {
> 	.......
> 	void (*calc_row_col)(unsigned int *row, unsigned int *col);
> };
>
> In mt6779_keypad_irq_handler:
>
> 	key = bit_nr / 32 * 16 + bit_nr % 32;
> 	keypad->calc_row_col(&row, &col);
>
> and below...
>
>>   
>>   		scancode = MATRIX_SCAN_CODE(row, col, row_shift);
>>   		/* 1: not pressed, 0: pressed */
>> @@ -150,6 +157,8 @@ static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
>>   
>>   	wakeup = device_property_read_bool(&pdev->dev, "wakeup-source");
>>   
>> +	keypad->double_keys = device_property_read_bool(&pdev->dev, "mediatek,double-keys");
>> +
>>   	dev_dbg(&pdev->dev, "n_row=%d n_col=%d debounce=%d\n",
>>   		keypad->n_rows, keypad->n_cols, debounce);
>>   
>> @@ -166,6 +175,10 @@ static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
>>   	regmap_write(keypad->regmap, MTK_KPD_DEBOUNCE,
>>   		     (debounce * (1 << 5)) & MTK_KPD_DEBOUNCE_MASK);
>>   
>> +	if (keypad->double_keys)
>
> 		keypad->calc_row_col = mt6779_keypad_calc_row_col_double_kp;
>
>> +		regmap_update_bits(keypad->regmap, MTK_KPD_SEL,
>> +				   MTK_KPD_SEL_DOUBLE_KP_MODE, MTK_KPD_SEL_DOUBLE_KP_MODE);
>> +
>
> 	} else {
> 		keypad->calc_row_col = mt6779_keypad_calc_row_col_single_kp;
> 	}
>
>>   	regmap_update_bits(keypad->regmap, MTK_KPD_SEL, MTK_KPD_SEL_ROW,
>>   			   MTK_KPD_SEL_ROWMASK(keypad->n_rows));
>>   	regmap_update_bits(keypad->regmap, MTK_KPD_SEL, MTK_KPD_SEL_COL,
>
> what do you think?

Hi Angelo,

Thank you for your detailed suggestion. I like it and since I have to
resend a v2 anyways, I will consider implementing it.
On the other hand, I'm a little reluctant because it means that I'll
have to remove Matthias's reviewed-by :(

>
> Cheers,
> Angelo
