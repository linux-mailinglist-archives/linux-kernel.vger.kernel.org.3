Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0DB5646F1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiGCLFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiGCLFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:05:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B67643;
        Sun,  3 Jul 2022 04:05:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id cl1so9445503wrb.4;
        Sun, 03 Jul 2022 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=7DUjjtXVZ1JAAkcFuhk8EQe1NcnY/rlPFrCMqUddOfE=;
        b=oFvgtd6O9hfvRAcNCd5d8OYRmqxxyQgYH6J+5+ylHpN23I2fFjJtvOR1QF2NH/CNlD
         AmfhiVcYW+oBZur0Hmb9eOEW58qEXaxnJuaxyElZ8NI7+cW+qHzbqx/iqjtqe64qi1fj
         R5RP06UTKNeLWc8fER6u4wTw9xXROBitppJMt5VDwtk7uIaETFljwoz7M3alxrsdjtoO
         PCfm8Ha6+NOTh2ujNqxo/0FeAGIunHNDMa4fJiv9Lcc20SgrKFww7zgDHVDjxJQY2pYJ
         maFTF1SBvjBtUCC2WV2morJunT39i6/qey3A6csF4sUGbklb97KO6iR6lsPPWLfm3J+Z
         s8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=7DUjjtXVZ1JAAkcFuhk8EQe1NcnY/rlPFrCMqUddOfE=;
        b=190qCKE3bT8pgko8Ka8byK9xs9eM5rlFpf/OB0DT6h2McEQp/lcTcNs7RfSPqP5aDM
         4+GhVGaQz60k6+oLaAnvtKUnu6f/Lc7QlrcwQckmJMhpgoV39au/GREixEXtqcDHr2EO
         uFraMavsxRC4Kd767DuxorL78JFdFVBtPqBYbfbIKWQ0+FmqqBD/WiF+9sWTxwNYDqB9
         LyZlMduM8//aTadUgy0vTcktcMejduZOwkkBU1suSJZG2jThkXVh+u2OWaG2JsRggjxr
         XxLDY0l+5196G2wIUL5YIk/K3yqE7SMq/FLIGf0z7FypTX2ZfXfKNqywKNEyDGOV/hoP
         tI9g==
X-Gm-Message-State: AJIora+EMooBTN8/AnjFXDBiHhDUMC6aD+zv7yql5bRiK4ehne1SNp84
        yE5pFy5vT+aKGo4dO8gIMLfBaZgMyos=
X-Google-Smtp-Source: AGRyM1sKT10TsS+cvZPa4L87pJ75lgV274uxpDpZcGo8HftTtSx2T6JR52jwbeaTEczN/SSYQ9m0xQ==
X-Received: by 2002:a05:6000:1547:b0:21b:a2e2:6151 with SMTP id 7-20020a056000154700b0021ba2e26151mr21597551wry.481.1656846351065;
        Sun, 03 Jul 2022 04:05:51 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id d21-20020a1c7315000000b003a02cbf862esm15934392wmb.13.2022.07.03.04.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:05:50 -0700 (PDT)
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
 <20220623211420.918875-12-aidanmacdonald.0x0@gmail.com>
 <CGME20220701163330eucas1p13456e7757d9d2bc8d0aa35c16f143590@eucas1p1.samsung.com>
 <acaaf77f-3282-8544-dd3c-7915fc1a6a4f@samsung.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 11/12] regmap-irq: Add get_irq_reg() callback
In-reply-to: <acaaf77f-3282-8544-dd3c-7915fc1a6a4f@samsung.com>
Date:   Sun, 03 Jul 2022 12:06:58 +0100
Message-ID: <J6lhcwtTNjo9XCDWYcEz3QEWJBaJ34Qk@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marek Szyprowski <m.szyprowski@samsung.com> writes:

> Hi All,
>
> On 23.06.2022 23:14, Aidan MacDonald wrote:
>> Replace the internal sub_irq_reg() function with a public callback
>> that drivers can use when they have more complex register layouts.
>> The default implementation is regmap_irq_get_irq_reg_linear(), used
>> if the chip doesn't provide its own callback.
>>
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>
> This patch landed in today's linux next-20220701 as commit bdf9b86cd3ad 
> ("regmap-irq: Add get_irq_reg() callback"). I've noticed that it causes 
> a regression on my test systems: the RTC alarm stopped working on all 
> boards with Samsung PMICs (drivers/mfd/sec*.c). There are no 
> warnings/oopses/etc. Waitng for the RTC alarm lasts forever, so it looks 
> that something is broken with interrupts. Reverting it on top of 
> linux-next fixes the issue.
>
> Unfortunately I'm going for a holidays for the whole next week and I'm 
> not able to analyze this issue further today. Krzysztof: maybe You will 
> be able to provide some more hints which regmap irq variant is broken?

Fortunately it's nothing complicated -- just a typo. Thanks for testing.

>>   drivers/base/regmap/regmap-irq.c | 126 ++++++++++++++++++++-----------
>>   include/linux/regmap.h           |  15 +++-
>>   2 files changed, 93 insertions(+), 48 deletions(-)
>> [..]
>> +unsigned int regmap_irq_get_irq_reg_linear(struct regmap_irq_chip_data *data,
>> +					   unsigned int base, int index)
>> +{
>> +	const struct regmap_irq_chip *chip = data->chip;
>> +	struct regmap *map = data->map;
>> +
>> +	/*
>> +	 * FIXME: This is for backward compatibility and should be removed
>> +	 * when not_fixed_stride is dropped (it's only used by qcom-pm8008).
>> +	 */
>> +	if (chip->not_fixed_stride && chip->sub_reg_offsets) {
>> +		struct regmap_irq_sub_irq_map *subreg;
>> +
>> +		subreg = &chip->sub_reg_offsets[0];
>> +		return base + subreg->offset[0];
>> +	}
>> +
>> +	return base + index * map->reg_stride * chip->irq_reg_stride;

chip->irq_reg_stride is usually 0. This should be data->irq_reg_stride,
which will be corrected to the default value of 1.

>> +}
>> +EXPORT_SYMBOL_GPL(regmap_irq_get_irq_reg_linear);
>> +
>>   /**
>>    * regmap_irq_set_type_config_simple() - Simple IRQ type configuration callback.
>>    * @buf: Buffer containing configuration register values, this is a 2D array of
>> @@ -862,6 +891,11 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>
> Best regards
