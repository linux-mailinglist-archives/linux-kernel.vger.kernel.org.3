Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4013056714A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiGEOiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGEOiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:38:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3718662ED
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:38:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z12so8266387wrq.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LEr7rAT/dnyEPQvdO9AbnDAZNWNC1MOMxzJEHX4ciRw=;
        b=yWHt0oSA5NN7wvK9dqmRUjAPfhTwMvVbR3r6dnaxMKKI3iMkztHCur6uCnCyDSZCnM
         CmQFiFwYbiciwfwbd0yAldFCuRJJ+vM8umXOumxOySv/8JzJLxVD2t7smbq/CKRbJMha
         ToZK+dtiLZlmjDobTzR8B5HTIB28hq53pn4OyjuWv9ud4k31Ns9dI3jMOEm3r0vcpTNu
         NogQrZ+Y1jkD8zKUmuIZDg7BnITD9m+pT3voh5hu05KR/LMPbRHABrmZOBAOfJn6Jluv
         DKwyOrMktNlhmN8aMySVT+XQuH0f9/kSEmDtFkc7oiB/erPXZpV4qirn/2sFsRrSXn7x
         OxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LEr7rAT/dnyEPQvdO9AbnDAZNWNC1MOMxzJEHX4ciRw=;
        b=UfAXc7pZ0wtlvGPNV9SIkJ2k0SMu8H6oEy7FAZ10gBAhSLOiqw7V6bY3ncQ6Omgxxj
         dPLcMiUgutk7rc9vgI4WP72GRrUBW+P60qrpA7KKRGFGlAesPpFqjgn8bTEdccKaMnKo
         2O5X7G059iPZpseF93dtwTIpVEIdMYAkFVrt8+Y+gXAeuGLGueRtI2SfwPyYBinIPzMY
         8t1YZyW4/I0Dv3HdeIs6oDAwxJUZSpyZk0HPZVVyQhZt7g4j70QkaI3EZ7C3T4y6Ycr3
         nuM2hGYxhXHtByOgEObK0Gsn7PynaXSaS6UjvsM++noPo7kzeQ65GJh57+kcEB3AHtdB
         gvWA==
X-Gm-Message-State: AJIora/KycojZIjVZdO/9TL3/4OBy0S7B40KKT1wNsO9Lyik+fwjKpjj
        F5QoiVGoGuhrbKR6SEOl5cu5yQ==
X-Google-Smtp-Source: AGRyM1tjvSYRki+5ro8CHDLjpDR4wA1h8wunkn2tYRP1SfoMKQYJCzQ3sF7vShJ0hFSOY3ibuNwkfw==
X-Received: by 2002:a5d:6d8b:0:b0:21b:9814:793d with SMTP id l11-20020a5d6d8b000000b0021b9814793dmr31966737wrs.344.1657031891814;
        Tue, 05 Jul 2022 07:38:11 -0700 (PDT)
Received: from google.com ([2.26.241.96])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d654b000000b0021b8c554196sm33955336wrv.29.2022.07.05.07.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:38:11 -0700 (PDT)
Date:   Tue, 5 Jul 2022 15:38:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
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
Message-ID: <YsRM0O3MQmBO5WXK@google.com>
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <20220629143046.213584-7-aidanmacdonald.0x0@gmail.com>
 <YsQwHiVdooN2TWbh@google.com>
 <MiQPswErEouy9b8OQ6k5WeQxH3ENw94W@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MiQPswErEouy9b8OQ6k5WeQxH3ENw94W@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jul 2022, Aidan MacDonald wrote:

> 
> Lee Jones <lee.jones@linaro.org> writes:
> 
> > On Wed, 29 Jun 2022, Aidan MacDonald wrote:
> >
> >> The AXP192 PMIC is similar to the AXP202/AXP209, but with different
> >> regulators, additional GPIOs, and a different IRQ register layout.
> >> 
> >> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> >> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> >> ---
> >>  drivers/mfd/axp20x-i2c.c   |   2 +
> >>  drivers/mfd/axp20x.c       | 152 +++++++++++++++++++++++++++++++++++++
> >>  include/linux/mfd/axp20x.h |  84 ++++++++++++++++++++
> >>  3 files changed, 238 insertions(+)
> >> [...]
> >> +static const struct regmap_irq_chip axp192_regmap_irq_chip = {
> >> +	.name			= "axp192_irq_chip",
> >> +	.status_base		= AXP192_IRQ1_STATE,
> >> +	.ack_base		= AXP192_IRQ1_STATE,
> >> +	.unmask_base		= AXP192_IRQ1_EN,
> >> +	.init_ack_masked	= true,
> >> +	.irqs			= axp192_regmap_irqs,
> >> +	.num_irqs		= ARRAY_SIZE(axp192_regmap_irqs),
> >> +	.num_regs		= 5,
> >> +	.get_irq_reg		= axp192_get_irq_reg,
> >
> > Fix me:
> >
> > drivers/mfd/axp20x.c:634:35: error: initialization of 'unsigned int (*)(struct regmap_irq_chip_data *, unsigned int,  int)' from incompatible pointer type 'int (*)(unsigned int,  int)' [-Werror=incompatible-pointer-types]
> >   634 |         .get_irq_reg            = axp192_get_irq_reg,
> >       |                                   ^~~~~~~~~~~~~~~~~~
> > drivers/mfd/axp20x.c:634:35: note: (near initialization for 'axp192_regmap_irq_chip.get_irq_reg')
> >
> 
> This doesn't need fixing. You are missing the prerequisite patches.
> 
> -- snip --
> Changes in v4:
> * Drop regmap-irq patches and rebase on top of the regmap-irq
>   refactoring series[1], which implements the same functionality.
> 
> [1]: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/
> -- snip --

> Perhaps I wasn't clear enough that it was a dependency, sorry for
> any confusion.

Any idea why the regmap-irq patches weren't in -next?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
