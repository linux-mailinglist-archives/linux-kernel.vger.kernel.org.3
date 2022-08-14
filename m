Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54A592034
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiHNOiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbiHNOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:38:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CC715823;
        Sun, 14 Aug 2022 07:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFCE3B80B43;
        Sun, 14 Aug 2022 14:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C54C433D6;
        Sun, 14 Aug 2022 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660487899;
        bh=1R2kSsv8yxj/APAL46W0dsOZfWvi9UbUMoyn3yDzmdE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pTluyPRKNy4j47RUrC6Foivinh94Npye4rXeja8ecySw8vPykANd8Lzd6bWjmLM0o
         i4rztsSLv21ZV1EGPWCGLfdjVpRFVf98tlZmrQVkKnDG0dwVwceiGXJ3gS2sjx2fF1
         VpSRVbkHUi3TywuxnbIp0YUSWHdZG4+HpxysqoQ8WADpu/Lmvr7YzM1lYqi9b/XHQ/
         Q2F05pDdgaAtyCqnUpm9VoUIynl0uumS921RyJAY/rfEtKbcdYJWEQsp5w9lCjXURm
         ynx3iouQAjxrb075t+XNXix24S83+EVbjj/Ou0aSciNxCdlXbu/OlysJRitcNqpGys
         9N3O3+2rW0g/g==
Date:   Sun, 14 Aug 2022 15:48:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     vilhelm.gray@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
Subject: Re: [PATCH v4 3/3] counter: capture-tiecap: capture driver support
 for ECAP
Message-ID: <20220814154848.24442d4c@jic23-huawei>
In-Reply-To: <20220810140724.182389-4-jpanis@baylibre.com>
References: <20220810140724.182389-1-jpanis@baylibre.com>
        <20220810140724.182389-4-jpanis@baylibre.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 16:07:24 +0200
Julien Panis <jpanis@baylibre.com> wrote:

> ECAP hardware on AM62x SoC supports capture feature. It can be used
> to timestamp events (falling/rising edges) detected on signal input pin.
> 
> This commit adds capture driver support for ECAP hardware on AM62x SoC.
> 
> In the ECAP hardware, capture pin can also be configured to be in
> PWM mode. Current implementation only supports capture operating mode.
> Hardware also supports timebase sync between multiple instances, but
> this driver supports simple independent capture functionality.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
Hi Julien,

Been too long since I reviewed a counter driver, so I'll have
to leave that side of things to William (or find a spare few days
to remind myself of the details!)

A few superficial things I notice below whilst taking a quick look.

It might be worth adding a bit of description around what the
result of the various runtime pm calls is (what's actually getting
powered down?)

Jonathan

> +static int ecap_cnt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ecap_cnt_dev *ecap_dev;
> +	struct counter_device *counter_dev;
> +	void __iomem *mmio_base;
> +	int ret;
> +
> +	counter_dev = devm_counter_alloc(dev, sizeof(*ecap_dev));
> +	if (IS_ERR(counter_dev))
> +		return PTR_ERR(counter_dev);
> +
> +	counter_dev->name = ECAP_DRV_NAME;
> +	counter_dev->parent = dev;
> +	counter_dev->ops = &ecap_cnt_ops;
> +	counter_dev->signals = ecap_cnt_signals;
> +	counter_dev->num_signals = ARRAY_SIZE(ecap_cnt_signals);
> +	counter_dev->counts = ecap_cnt_counts;
> +	counter_dev->num_counts = ARRAY_SIZE(ecap_cnt_counts);
> +
> +	ecap_dev = counter_priv(counter_dev);
> +
> +	ecap_dev->clk = devm_clk_get(dev, "fck");
> +	if (IS_ERR(ecap_dev->clk))
> +		return dev_err_probe(dev, PTR_ERR(ecap_dev->clk), "failed to get clock\n");
> +
> +	ret = clk_prepare_enable(ecap_dev->clk);

We now have dev_clk_get_enabled() in upstream - finally!
Text book usecase for it here.

> +	if (ret) {
> +		dev_err(dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, ecap_cnt_clk_disable, ecap_dev->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to add clock disable action\n");
> +		return ret;
> +	}
> +
> +	ecap_dev->clk_rate = clk_get_rate(ecap_dev->clk);
> +	if (!ecap_dev->clk_rate) {
> +		dev_err(dev, "failed to get clock rate\n");
> +		return -EINVAL;
> +	}
> +
> +	mmio_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mmio_base))
> +		return PTR_ERR(mmio_base);
> +
> +	ecap_dev->regmap = devm_regmap_init_mmio(dev, mmio_base, &ecap_cnt_regmap_config);
> +	if (IS_ERR(ecap_dev->regmap))
> +		return dev_err_probe(dev, PTR_ERR(ecap_dev->regmap), "failed to init regmap\n");
> +
> +	spin_lock_init(&ecap_dev->lock);
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get irq\n");
> +		return ret;
> +	}
> +
> +	ret = devm_request_irq(dev, ret, ecap_cnt_isr, 0, pdev->name, counter_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, counter_dev);
> +	pm_runtime_enable(dev);
> +
> +	ecap_dev->enabled = 0;
> +	ecap_cnt_capture_set_evmode(counter_dev, 0);
> +
> +	ret = devm_counter_add(dev, counter_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to add counter\n");
> +		pm_runtime_disable(dev);

Unless there is a very good reason to mix devm and unmanaged
code, it's best to not do so as it leads to much head scratching over
whether there are race conditions.  Here I can't see a reason not
to use devm_add_action_or_reset() to make the pm_runtime_disabled()
into devm managed.

Any setting of enabled occured after probe() was done so that's
fine as unmanaged or you could register another devm_ callback
if you prefer, but with a comment explaining the path to it needing
to do anything.

> +	}
> +
> +	return ret;
> +}
> +
> +static int ecap_cnt_remove(struct platform_device *pdev)
> +{
> +	struct counter_device *counter_dev = platform_get_drvdata(pdev);
> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
> +
> +	if (ecap_dev->enabled)
> +		ecap_cnt_capture_disable(counter_dev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +
