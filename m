Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EDB568576
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiGFKYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiGFKYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:24:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4E023BFC;
        Wed,  6 Jul 2022 03:24:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z12so11778001wrq.7;
        Wed, 06 Jul 2022 03:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=gAAFLxTVBbke7idk+TJqhtAe46jVc+eusFaZ2+NGDNc=;
        b=T01qQGVCFpQvsrYLXbIulhJcGg0HUmQARvvOBgipM53C+Kp8/JIW6EVZQb5v0UNLwb
         ml0P7sxKFGboDz7Kyc82mBHUJNEO0yRFzMpFmbK4JRLCoyqkfBGu/dlbT2ajCZH8/rag
         fEVKcZ2ywOjzx+JWnLYUwVSpbUU4PWhsNQzBTji78zfstk9Yu3qAhwlP6Kf0vvPvkd2b
         PP2nxprfreGNNm0gX45OMoKjagQ6gYAa1hM2XRfJomg8WJjQmTsdOWUbhDH+1SGW2013
         GeHT4vlC7fliPHYqfW+hPr4R0eArQu9KrGpNAZm9xnx+v/SIAhMOH/Wjyabf+lLJm7iW
         gzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=gAAFLxTVBbke7idk+TJqhtAe46jVc+eusFaZ2+NGDNc=;
        b=kk9CrQ79OGzuPlAzaQ37UxR0TJLH4d+7ndJqi7cuBEEFOpGi57TVrGV2KSP8UeGT5k
         mXzntGrptd7iz+IVGwdglKH9ZXmoBRD8Q/ytqaELjRMtdnKLjw8ZKKMhgc3lX/DyRq0K
         q/rJMgfec5NrUowTy3TfBZQo+19OHZs50KbtHJshivTmNd+yXvug3VAKQ7n58GzfoKlf
         Ph14ZjTM/P2/ZNGWO0BjI9mJdG9aSB+5Rni9r+1YY0Ws66bgECfv27QXNWjNQjJHI/6i
         Qxu+HfYYoyVy0rIYlwNNSuPaS7N9BjpX5U6JG6GcLUWnwUBWlDRO7i8XZk3EQOED9Kya
         WKtA==
X-Gm-Message-State: AJIora9m8dwFSvgPlgsEk+USgQ6Z198joG6WXwVFwqBKiaDYBSP+o6+0
        S+WC1izObcHnMBmG/6E/myc=
X-Google-Smtp-Source: AGRyM1vU3MJHoH322VL/VZ3kLVOdxQZ29efLU3+xNpoRRoRaYcb0Iv3nb/x5LHrg9UdFMQ7tbtgPbw==
X-Received: by 2002:adf:d1ea:0:b0:21b:a6cb:fcf6 with SMTP id g10-20020adfd1ea000000b0021ba6cbfcf6mr36825810wrd.477.1657103072945;
        Wed, 06 Jul 2022 03:24:32 -0700 (PDT)
Received: from localhost (92.40.202.163.threembb.co.uk. [92.40.202.163])
        by smtp.gmail.com with ESMTPSA id bq25-20020a5d5a19000000b0021d6d74a0ecsm6931272wrb.96.2022.07.06.03.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:24:32 -0700 (PDT)
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <20220629143046.213584-7-aidanmacdonald.0x0@gmail.com>
 <YsQwHiVdooN2TWbh@google.com> <MiQPswErEouy9b8OQ6k5WeQxH3ENw94W@localhost>
 <YsRM0O3MQmBO5WXK@google.com>
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
Date:   Tue, 05 Jul 2022 20:42:43 +0100
In-reply-to: <YsRM0O3MQmBO5WXK@google.com>
Message-ID: <VHU3uih5i4iLk4b8WSSqo4p8Dc5tMaDN@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lee Jones <lee.jones@linaro.org> writes:

> On Tue, 05 Jul 2022, Aidan MacDonald wrote:
>
>> 
>> Lee Jones <lee.jones@linaro.org> writes:
>> 
>> > On Wed, 29 Jun 2022, Aidan MacDonald wrote:
>> >
>> >> The AXP192 PMIC is similar to the AXP202/AXP209, but with different
>> >> regulators, additional GPIOs, and a different IRQ register layout.
>> >> 
>> >> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>> >> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> >> ---
>> >>  drivers/mfd/axp20x-i2c.c   |   2 +
>> >>  drivers/mfd/axp20x.c       | 152 +++++++++++++++++++++++++++++++++++++
>> >>  include/linux/mfd/axp20x.h |  84 ++++++++++++++++++++
>> >>  3 files changed, 238 insertions(+)
>> >> [...]
>> >> +static const struct regmap_irq_chip axp192_regmap_irq_chip = {
>> >> +	.name			= "axp192_irq_chip",
>> >> +	.status_base		= AXP192_IRQ1_STATE,
>> >> +	.ack_base		= AXP192_IRQ1_STATE,
>> >> +	.unmask_base		= AXP192_IRQ1_EN,
>> >> +	.init_ack_masked	= true,
>> >> +	.irqs			= axp192_regmap_irqs,
>> >> +	.num_irqs		= ARRAY_SIZE(axp192_regmap_irqs),
>> >> +	.num_regs		= 5,
>> >> +	.get_irq_reg		= axp192_get_irq_reg,
>> >
>> > Fix me:
>> >
>> > drivers/mfd/axp20x.c:634:35: error: initialization of 'unsigned int (*)(struct regmap_irq_chip_data *, unsigned int,  int)' from incompatible pointer type 'int (*)(unsigned int,  int)' [-Werror=incompatible-pointer-types]
>> >   634 |         .get_irq_reg            = axp192_get_irq_reg,
>> >       |                                   ^~~~~~~~~~~~~~~~~~
>> > drivers/mfd/axp20x.c:634:35: note: (near initialization for 'axp192_regmap_irq_chip.get_irq_reg')
>> >
>> 
>> This doesn't need fixing. You are missing the prerequisite patches.
>> 
>> -- snip --
>> Changes in v4:
>> * Drop regmap-irq patches and rebase on top of the regmap-irq
>>   refactoring series[1], which implements the same functionality.
>> 
>> [1]: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/
>> -- snip --
>
>> Perhaps I wasn't clear enough that it was a dependency, sorry for
>> any confusion.
>
> Any idea why the regmap-irq patches weren't in -next?

Uh, sorry, I didn't pay attention and assumed this was the same error
the kernel test robot was reporting against mfd-next (missing field).
But the field does exist; this error is a type mismatch:

  initialization of 'unsigned int (*)(struct regmap_irq_chip_data *,
                                      unsigned int,  int)'
  from incompatible pointer type 'int (*)(unsigned int,  int)'

So the regmap-irq patches were in -next, the problem is you were
using the old patch from v3.

FYI, I just sent a v5 which drops the GPIO driver, so please use
the patches from that version. Thanks.

Regards,
Aidan
