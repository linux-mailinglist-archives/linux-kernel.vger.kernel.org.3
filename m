Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949F3471F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhLMDdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLMDdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:33:00 -0500
X-Greylist: delayed 85518 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Dec 2021 19:33:00 PST
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E493C06173F;
        Sun, 12 Dec 2021 19:33:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A0FF8425B1;
        Mon, 13 Dec 2021 03:32:54 +0000 (UTC)
To:     Sven Peter <sven@svenpeter.dev>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20211212034726.26306-1-marcan@marcan.st>
 <20211212034726.26306-4-marcan@marcan.st>
 <2f23875c-ce8e-436a-837b-b8afb6e8411b@www.fastmail.com>
From:   Hector Martin <marcan@marcan.st>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <49d1deeb-6d58-b1ca-addc-2505847d602f@marcan.st>
Date:   Mon, 13 Dec 2021 12:32:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2f23875c-ce8e-436a-837b-b8afb6e8411b@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review!

On 12/12/2021 21.39, Sven Peter wrote:
>> +
> 
> #include <linux/bits.h> for GENMASK even though it's probably
> pulled in by one of the #includes below

Ack, fixed for v2.

>> +	/* We will want to poll if the time we need to wait is
>> +	 * less than the context switching time.
>> +	 * Let's call that threshold 5us. The operation will take:
>> +	 *    bits_per_word * fifo_threshold / hz <= 5 * 10^-6
>> +	 *    200000 * bits_per_word * fifo_threshold <= hz
>> +	 */
>> +	return 200000 * t->bits_per_word * APPLE_SPI_FIFO_DEPTH / 2 <=
>> t->speed_hz;
> 
> Nice :-)

I stole this one from the sifive driver :-) (slightly adjusted)

>> +static int apple_spi_probe(struct platform_device *pdev)
>> +{
>> +	struct apple_spi *spi;
>> +	int ret, irq;
>> +	struct spi_controller *ctlr;
>> +
>> +	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct apple_spi));
> 
> devm_spi_alloc_master and then you can get rid of the spi_controller_put
> error path.

Ack, fixed for v2. That simplifies a bunch of the error handling.

> 
>> +	if (!ctlr) {
>> +		dev_err(&pdev->dev, "out of memory\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	spi = spi_controller_get_devdata(ctlr);
>> +	init_completion(&spi->done);
>> +	platform_set_drvdata(pdev, ctlr);
>> +
>> +	spi->regs = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(spi->regs)) {
>> +		ret = PTR_ERR(spi->regs);
>> +		goto put_ctlr;
>> +	}
>> +
>> +	spi->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(spi->clk)) {
>> +		dev_err(&pdev->dev, "Unable to find bus clock\n");
>> +		ret = PTR_ERR(spi->clk);
>> +		goto put_ctlr;
>> +	}
> 
> dev_err_probe can be used here in case devm_clk_get returns -EPROBE_DEFER.

Yup, good point. I switched most of the dev_errs to dev_err_probe.

> 
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0) {
>> +		ret = irq;
>> +		goto put_ctlr;
>> +	}
>> +
>> +	ret = devm_request_irq(&pdev->dev, irq, apple_spi_irq, 0,
>> +			       dev_name(&pdev->dev), spi);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Unable to bind to interrupt\n");
>> +		goto put_ctlr;
>> +	}
>> +
>> +	ret = clk_prepare_enable(spi->clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Unable to enable bus clock\n");
>> +		goto put_ctlr;
>> +	}
> 
> Unfortunately there's no devm_clk_prepare_enable but you could use
> devm_add_action_or_reset like almost all watchdog drivers as well.

Done.

>> +
>> +	ctlr->dev.of_node = pdev->dev.of_node;
>> +	ctlr->bus_num = pdev->id;
>> +	ctlr->num_chipselect = 1;
>> +	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
>> +	ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
>> +	ctlr->flags = 0;
>> +	ctlr->prepare_message = apple_spi_prepare_message;
>> +	ctlr->set_cs = apple_spi_set_cs;
>> +	ctlr->transfer_one = apple_spi_transfer_one;
>> +	ctlr->auto_runtime_pm = true;
>> +
>> +	pm_runtime_set_active(&pdev->dev);
>> +	pm_runtime_enable(&pdev->dev);
> 
> You could also use devm_pm_runtime_enable here and then everything
> should be devres managed.

Done, though I still need to wrap the remove remove function in 
pm_runtime calls, since the device might be suspended when it gets called.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
