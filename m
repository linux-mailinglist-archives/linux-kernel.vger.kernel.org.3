Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D223C522C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242268AbiEKGsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiEKGrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:47:55 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D4133E20;
        Tue, 10 May 2022 23:47:54 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id m62so585202wme.5;
        Tue, 10 May 2022 23:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d0+VSEkVTN5UKp/1tlZfodLf5D5A+zx04J2EOUOCF00=;
        b=bpIyUzwbs/OtUHpzNEIE2R7Q4lGuQhU5BWu7fPzD6N45WXlzywpcfzFUtlRKK+WLyX
         M+gETnkRftfEV7SDDmpvxYYh5K2m12i5hLxhPwWEa2BL5+2eOsk4S1fEkqXm7wucvnda
         xT+Fi2wXunMoBdMn1oCoQl6Nx9ITSjfl11ZESjHqhAEIu3jA9n+DLkUpNRRG51Xfiyd6
         5uHn7iKO+ulUhUu9JGwMbqZjp8DGbMuiI1cywCL/SEY5P8lAjasQh+xQ8/I0/84oHDiq
         iw4kkhodK6NmJjfaa90lpd3TkKYA98d3WRyVAIfg2phx+fkFP5qpLHjG15Ag0d8IsnNQ
         zqrg==
X-Gm-Message-State: AOAM530GyhAAuAh7qo1Sof6+iEFZwkxzOEJlfGELnYZD3pmjhwe/1MuU
        kvdgqgeha7pU5D1uVkqOaJA=
X-Google-Smtp-Source: ABdhPJzpnoc2OQxaCLNzOlLY2Q6PMGILiG41ZK3gGqRANQoSQNuIjjpR7zhzwOg/QpERIZ7XiCnJ5Q==
X-Received: by 2002:a05:600c:6021:b0:394:56be:18e with SMTP id az33-20020a05600c602100b0039456be018emr3207844wmb.86.1652251672631;
        Tue, 10 May 2022 23:47:52 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id m36-20020a05600c3b2400b003942a244edbsm1446971wms.32.2022.05.10.23.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 23:47:52 -0700 (PDT)
Message-ID: <48cfa0b3-0424-81bd-ac6a-d631184b71b7@kernel.org>
Date:   Wed, 11 May 2022 08:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/1] soc: fujitsu: Add A64FX diagnostic interrupt
 driver
Content-Language: en-US
To:     Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-serial@vger.kernel.org, sumit.garg@linaro.org
Cc:     arnd@arndb.de, olof@lixom.net, catalin.marinas@arm.com,
        will@kernel.org, gregkh@linuxfoundation.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, peterz@infradead.org
References: <20220511062113.2645747-1-hasegawa-hitomi@fujitsu.com>
 <20220511062113.2645747-2-hasegawa-hitomi@fujitsu.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220511062113.2645747-2-hasegawa-hitomi@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 05. 22, 8:21, Hitomi Hasegawa wrote:
> Enable diagnostic interrupts for the Fujitsu A64FX.
> 
> Register the NMI/IRQ corresponding to the A64FX's device definition
> dedicated to diagnostic interrupts, so that when this interrupt is
> sent using the BMC, it causes a panic. This can be used to obtain
> a kernel dump.
> 
> Signed-off-by: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>

Hi,

I'm not sure why you cc linux-serial, but anyway, comments below :).

> --- /dev/null
> +++ b/drivers/soc/fujitsu/a64fx-diag.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * A64FX diag driver.
> + * Copyright (c) 2022 Fujitsu Ltd.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define A64FX_DIAG_IRQ 1
> +#define BMC_DIAG_INTERRUPT_STATUS_OFFSET (0x0044)
> +#define BMC_DIAG_INTERRUPT_ENABLE_OFFSET (0x0040)
> +#define BMC_DIAG_INTERRUPT_MASK BIT(31)
> +
> +struct a64fx_diag_priv {
> +	int irq;
> +	void __iomem *mmsc_reg_base;
> +	bool has_nmi;

There are unnecessary holes in the struct. If you reorder it, you drop 
some alignment. Like: pointer, int, bool.

> +};
> +
> +static irqreturn_t a64fx_diag_handler_nmi(int irq, void *dev_id)
> +{
> +	nmi_panic(NULL, "a64fx_diag: interrupt received\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t a64fx_diag_handler_irq(int irq, void *dev_id)
> +{
> +	panic("a64fx_diag: interrupt received\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void a64fx_diag_interrupt_clear(struct a64fx_diag_priv *priv)
> +{
> +	u32 mmsc;
> +	void __iomem *diag_status_reg_addr;

I'm not sure what soc/ maintainers prefer, but inverted xmas tree would 
look/read better.

> +
> +	diag_status_reg_addr = priv->mmsc_reg_base + BMC_DIAG_INTERRUPT_STATUS_OFFSET;
> +	mmsc = readl(diag_status_reg_addr);
> +	if (mmsc & BMC_DIAG_INTERRUPT_MASK)
> +		writel(BMC_DIAG_INTERRUPT_MASK, diag_status_reg_addr);
> +}
> +
> +static void a64fx_diag_interrupt_enable(struct a64fx_diag_priv *priv)
> +{
> +	u32 mmsc;
> +	void __iomem *diag_enable_reg_addr;
> +
> +	diag_enable_reg_addr = priv->mmsc_reg_base + BMC_DIAG_INTERRUPT_ENABLE_OFFSET;
> +	mmsc = readl(diag_enable_reg_addr);
> +	if (!(mmsc & BMC_DIAG_INTERRUPT_MASK)) {
> +		mmsc |= BMC_DIAG_INTERRUPT_MASK;
> +		writel(mmsc, diag_enable_reg_addr);
> +	}
> +}
> +
> +static void a64fx_diag_interrupt_disable(struct a64fx_diag_priv *priv)
> +{
> +	u32 mmsc;
> +	void __iomem *diag_enable_reg_addr;
> +
> +	diag_enable_reg_addr = priv->mmsc_reg_base + BMC_DIAG_INTERRUPT_ENABLE_OFFSET;
> +	mmsc = readl(diag_enable_reg_addr);
> +	if (mmsc & BMC_DIAG_INTERRUPT_MASK) {
> +		mmsc &= ~BMC_DIAG_INTERRUPT_MASK;
> +		writel(mmsc, diag_enable_reg_addr);
> +	}
> +}
> +
> +static int a64fx_diag_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	unsigned long irq_flags;
> +	struct device *dev = &pdev->dev;
> +	struct a64fx_diag_priv *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(struct a64fx_diag_priv), GFP_KERNEL);

Don't we prefer sizeof(*priv)?

> +	if (priv == NULL)
> +		return -ENOMEM;
> +
> +	priv->mmsc_reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->mmsc_reg_base))
> +		return PTR_ERR(priv->mmsc_reg_base);
> +
> +	priv->irq = platform_get_irq(pdev, A64FX_DIAG_IRQ);
> +	if (priv->irq < 0)
> +		return priv->irq;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	a64fx_diag_interrupt_clear(priv);
> +	a64fx_diag_interrupt_enable(priv);
> +
> +	irq_flags = IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_AUTOEN |
> +		   IRQF_NO_THREAD;
> +	ret = request_nmi(priv->irq, &a64fx_diag_handler_nmi, irq_flags,
> +			"a64fx_diag_nmi", NULL);
> +	if (ret) {
> +		ret = request_irq(priv->irq, &a64fx_diag_handler_irq,
> +				irq_flags, "a64fx_diag_irq", NULL);
> +		if (ret) {
> +			dev_err(dev, "cannot register IRQ %d\n", ret);

No a64fx_diag_interrupt_disable()?

> +			return ret;
> +		}
> +		enable_irq(priv->irq);

Hmm...

> +		priv->has_nmi = false;

No need to set zeroed priv member to zero.

> +	} else {
> +		enable_nmi(priv->irq);

Provided the above, I don't immediatelly see, what's the purpose of 
IRQF_NO_AUTOEN then?

> +		priv->has_nmi = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __exit a64fx_diag_remove(struct platform_device *pdev)

Is __exit appropriate here at all -- I doubt that.

> +{
> +	struct a64fx_diag_priv *priv = platform_get_drvdata(pdev);
> +
> +	a64fx_diag_interrupt_disable(priv);
> +	a64fx_diag_interrupt_clear(priv);
> +
> +	if (priv->has_nmi)
> +		free_nmi(priv->irq, NULL);
> +	else
> +		free_irq(priv->irq, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id a64fx_diag_acpi_match[] = {
> +	{ "FUJI2007", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, a64fx_diag_acpi_match);
> +
> +
> +static struct platform_driver a64fx_diag_driver = {
> +	.driver = {
> +		.name = "a64fx_diag_driver",
> +		.acpi_match_table = ACPI_PTR(a64fx_diag_acpi_match),
> +	},
> +	.probe = a64fx_diag_probe,
> +	.remove = a64fx_diag_remove,
> +};
> +
> +module_platform_driver(a64fx_diag_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>");
> +MODULE_DESCRIPTION("A64FX diag driver");


-- 
js
suse labs
