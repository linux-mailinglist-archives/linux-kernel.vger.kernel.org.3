Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478914BC613
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 07:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbiBSGtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 01:49:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiBSGtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 01:49:12 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407C4554A7;
        Fri, 18 Feb 2022 22:48:54 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id B061F403DB;
        Sat, 19 Feb 2022 11:48:51 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1645253331; bh=YIrVnRmJ544cu++/OMC8gdl68QikrV9a5SSu5la/2dE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m1tE1zl7XEKGRvNpwcoNOCvz8CUTKI7vxhkNrMQJRGU4zFf3IANsJqb/d86yOeiro
         qtPHxBED251MYRxp4qjxte8GwBFhcnLdVkVwvuIoLDFRDFsnlYtESqOiWC0WWl+ABL
         TJ/xlocxFmriQDUM8zmByIPzEEtRt5JWZHD2eViOXqL/fxPE9VxDR1/xzH8F2XQjhi
         m0KBYnGRO8B0YCErGUUb9BTkd6BV9fkNDjpZHuJvbVRwNA0cP1qpTbkdf8x7xTk5up
         f9zjQaFqgJsg54QfuBO9kFWGEBrnD1xWLSr/9BToLfxrci7SzFvh8V2voUDwTFcMAe
         x5Q780DsTfJmw==
MIME-Version: 1.0
Date:   Sat, 19 Feb 2022 11:48:50 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        sean.anderson@seco.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 2/2] pwm: Add clock based PWM output driver
In-Reply-To: <e1f2f9c4-a597-2c8f-df0c-4ae30a5ad594@canonical.com>
References: <20220212162342.72646-1-nikita@trvn.ru>
 <20220212162342.72646-3-nikita@trvn.ru>
 <e1f2f9c4-a597-2c8f-df0c-4ae30a5ad594@canonical.com>
Message-ID: <170305a686280ed44a5d3e49dee3176f@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Krzysztof Kozlowski писал(а) 14.02.2022 16:19:
> On 12/02/2022 17:23, Nikita Travkin wrote:
>> Some systems have clocks exposed to external devices. If the clock
>> controller supports duty-cycle configuration, such clocks can be used as
>> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
>> similar way and an "opposite" driver already exists (clk-pwm). Add a
>> driver that would enable pwm devices to be used via clk subsystem.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> --
>>
> 
> (...)
> 
>> +
>> +static int pwm_clk_probe(struct platform_device *pdev)
>> +{
>> +	struct pwm_clk_chip *chip;
>> +	int ret;
>> +
>> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
>> +
>> +	chip->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(chip->clk))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(chip->clk),
>> +				     "Failed to get clock\n");
>> +
>> +	chip->chip.dev = &pdev->dev;
>> +	chip->chip.ops = &pwm_clk_ops;
>> +	chip->chip.npwm = 1;
>> +
>> +	ret = clk_prepare(chip->clk);
>> +	if (ret < 0)
>> +		return dev_err_probe(&pdev->dev, ret, "Failed to prepare clock\n");
>> +
>> +	ret = pwmchip_add(&chip->chip);
>> +	if (ret < 0)
>> +		return dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
> 
> You need to cleanup - unprepare the clock.
> 

Oops, I will add unprepare in v6, Thanks!

Nikita

>> +
>> +	platform_set_drvdata(pdev, chip);
>> +	return 0;
>> +}
>> +
> 
> 
> Best regards,
> Krzysztof
