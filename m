Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871FE5670F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiGEOZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiGEOZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:25:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A1DE3A;
        Tue,  5 Jul 2022 07:25:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso7557181wms.1;
        Tue, 05 Jul 2022 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=kzF2aQ2qZDRgEZ+TJ8G9dh15EJTQP9sotTs3vWpm7gA=;
        b=W3A/aQ7YnKad10stmSsi366qwULKX4WtYgaXftqN5RTXMtMtyus9m7aVi7MoBxO9Ou
         gVoJygZsyFotdvQxFHKjfTAlhq11qTMyup8U0LuBDzNkRNhDuqXZcMmazMWl9BNlw/Jd
         ViMELw0Ymfe+kfu+u0dLXLil7qMMDBHkyG1GN1s94YPcycL7lmtm2CNuGZ7dDUoNVol6
         hIx+xivHtob2Pui16H+RjG4f0trbM3VYRfyDT9/sUw+Wmq0JTJI31J70n/g3F2gQEkfV
         qWbIiC8Y12Lrk8OBCvEKoNgtKHPMZwcieaCwLDj4H+ouq/JXLoril8BOpKJPITT7MYEs
         Ukhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=kzF2aQ2qZDRgEZ+TJ8G9dh15EJTQP9sotTs3vWpm7gA=;
        b=oP6HAoB0ITMAkEt0ETAI2C/aPBgU1a66XeViVvDBNtPIrMh7fPOtg8pfEemeT8NK5b
         BLVVHuIGC/9mamnwWy0/dSFHMYBNUT5JqWPSUalHxahj04UtucsLVXsb0JrXwBy36Pxa
         DtCcJ7dNoUza9xoQsNjv6Sk74NPmoeZXR8dfT71bBrnyzxep9sE/nQVYRoWjMlKmqwfs
         tywz59iVJwErwi6wvZ6kXJuf9SljIzW4B3ZYgyWB8yKFDobB1aodbAnsr1LF5TSEPxmr
         hFIRhe1nXJeJDe3gUxpU0iKjWno0XjhadZ72faUlrZ0Vdl0yVi06iVYzlVysWifPPGht
         RlNA==
X-Gm-Message-State: AJIora/+6tFVEh9Tcw6p6mOXx1QzBYso3Jfeg9fOcPnMOyNxvyXL28Q1
        BGLDDRAiKSWijtPcbvB5qI4=
X-Google-Smtp-Source: AGRyM1uJ7YxpTxQhJVu4OiZ1HqSY0BllwcmeBTP6Ar5PWH9fwjChl3JBg9CWULe6lZvsOQBen1Qx5g==
X-Received: by 2002:a1c:4405:0:b0:3a1:886d:c33c with SMTP id r5-20020a1c4405000000b003a1886dc33cmr27271330wma.200.1657031124621;
        Tue, 05 Jul 2022 07:25:24 -0700 (PDT)
Received: from localhost (92.40.203.109.threembb.co.uk. [92.40.203.109])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b002185d79dc7fsm9631986wrm.75.2022.07.05.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:25:23 -0700 (PDT)
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <20220629143046.213584-7-aidanmacdonald.0x0@gmail.com>
 <YsQwHiVdooN2TWbh@google.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        sre@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        lars@metafoo.de, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 06/15] mfd: axp20x: Add support for AXP192
In-reply-to: <YsQwHiVdooN2TWbh@google.com>
Date:   Tue, 05 Jul 2022 15:26:32 +0100
Message-ID: <MiQPswErEouy9b8OQ6k5WeQxH3ENw94W@localhost>
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


Lee Jones <lee.jones@linaro.org> writes:

> On Wed, 29 Jun 2022, Aidan MacDonald wrote:
>
>> The AXP192 PMIC is similar to the AXP202/AXP209, but with different
>> regulators, additional GPIOs, and a different IRQ register layout.
>> 
>> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  drivers/mfd/axp20x-i2c.c   |   2 +
>>  drivers/mfd/axp20x.c       | 152 +++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/axp20x.h |  84 ++++++++++++++++++++
>>  3 files changed, 238 insertions(+)
>> [...]
>> +static const struct regmap_irq_chip axp192_regmap_irq_chip = {
>> +	.name			= "axp192_irq_chip",
>> +	.status_base		= AXP192_IRQ1_STATE,
>> +	.ack_base		= AXP192_IRQ1_STATE,
>> +	.unmask_base		= AXP192_IRQ1_EN,
>> +	.init_ack_masked	= true,
>> +	.irqs			= axp192_regmap_irqs,
>> +	.num_irqs		= ARRAY_SIZE(axp192_regmap_irqs),
>> +	.num_regs		= 5,
>> +	.get_irq_reg		= axp192_get_irq_reg,
>
> Fix me:
>
> drivers/mfd/axp20x.c:634:35: error: initialization of 'unsigned int (*)(struct regmap_irq_chip_data *, unsigned int,  int)' from incompatible pointer type 'int (*)(unsigned int,  int)' [-Werror=incompatible-pointer-types]
>   634 |         .get_irq_reg            = axp192_get_irq_reg,
>       |                                   ^~~~~~~~~~~~~~~~~~
> drivers/mfd/axp20x.c:634:35: note: (near initialization for 'axp192_regmap_irq_chip.get_irq_reg')
>

This doesn't need fixing. You are missing the prerequisite patches.

-- snip --
Changes in v4:
* Drop regmap-irq patches and rebase on top of the regmap-irq
  refactoring series[1], which implements the same functionality.

[1]: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/
-- snip --

Perhaps I wasn't clear enough that it was a dependency, sorry for
any confusion.

Regards,
Aidan
