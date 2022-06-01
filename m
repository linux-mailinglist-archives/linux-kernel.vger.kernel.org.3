Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5951853ADF2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiFAUsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiFAUrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:47:45 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBC1327C24F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:44:51 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id wUjOnikly26JCwUjOn5OWJ; Wed, 01 Jun 2022 22:14:22 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 01 Jun 2022 22:14:22 +0200
X-ME-IP: 90.11.190.129
Message-ID: <dd525d8b-3cb3-e843-4a79-64f50c0fe8a7@wanadoo.fr>
Date:   Wed, 1 Jun 2022 22:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/5] crypto: aspeed: Add HACE hash driver
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-2-neal_liu@aspeedtech.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220601054204.1522976-2-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 01/06/2022 à 07:42, Neal Liu a écrit :
> Hash and Crypto Engine (HACE) is designed to accelerate the
> throughput of hash data digest, encryption, and decryption.
> 
> Basically, HACE can be divided into two independently engines
> - Hash Engine and Crypto Engine. This patch aims to add HACE
> hash engine driver for hash accelerator.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> ---
>   MAINTAINERS                              |    7 +
>   drivers/crypto/Kconfig                   |    1 +
>   drivers/crypto/Makefile                  |    1 +
>   drivers/crypto/aspeed/Kconfig            |   22 +
>   drivers/crypto/aspeed/Makefile           |    6 +
>   drivers/crypto/aspeed/aspeed-hace-hash.c | 1335 ++++++++++++++++++++++
>   drivers/crypto/aspeed/aspeed-hace.c      |  210 ++++
>   drivers/crypto/aspeed/aspeed-hace.h      |  179 +++
>   8 files changed, 1761 insertions(+)
>   create mode 100644 drivers/crypto/aspeed/Kconfig
>   create mode 100644 drivers/crypto/aspeed/Makefile
>   create mode 100644 drivers/crypto/aspeed/aspeed-hace-hash.c
>   create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
>   create mode 100644 drivers/crypto/aspeed/aspeed-hace.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e8c52d0192a6..c020e0893eed 100644

[...]

> +int aspeed_register_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
> +{
> +	int rc, i;
> +
> +	AHASH_DBG(hace_dev, "\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(aspeed_ahash_algs); i++) {
> +		aspeed_ahash_algs[i].hace_dev = hace_dev;
> +		rc = crypto_register_ahash(&aspeed_ahash_algs[i].alg.ahash);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (hace_dev->version != AST2600_VERSION)
> +		return 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(aspeed_ahash_algs_g6); i++) {
> +		aspeed_ahash_algs_g6[i].hace_dev = hace_dev;
> +		rc = crypto_register_ahash(&aspeed_ahash_algs_g6[i].alg.ahash);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;

Should there be some kind of error handling here, in order to undo 
things already done if an error occures?


> +}
> diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
> new file mode 100644
> index 000000000000..f25b13d120e8
> --- /dev/null
> +++ b/drivers/crypto/aspeed/aspeed-hace.c

[...]

> +static int aspeed_hace_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *hace_dev_id;
> +	struct aspeed_engine_hash *hash_engine;
> +	struct aspeed_hace_dev *hace_dev;
> +	struct resource *res;
> +	int rc;
> +
> +	hace_dev = devm_kzalloc(&pdev->dev, sizeof(struct aspeed_hace_dev),
> +				GFP_KERNEL);
> +	if (!hace_dev)
> +		return -ENOMEM;
> +
> +	hace_dev_id = of_match_device(aspeed_hace_of_matches, &pdev->dev);
> +	if (!hace_dev_id) {
> +		dev_err(&pdev->dev, "Failed to match hace dev id\n");
> +		return -EINVAL;
> +	}
> +
> +	hace_dev->dev = &pdev->dev;
> +	hace_dev->version = (unsigned long)hace_dev_id->data;
> +	hash_engine = &hace_dev->hash_engine;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	platform_set_drvdata(pdev, hace_dev);
> +
> +	spin_lock_init(&hash_engine->lock);
> +	tasklet_init(&hash_engine->done_task, aspeed_hace_hash_done_task,
> +		     (unsigned long)hace_dev);
> +	tasklet_init(&hash_engine->queue_task, aspeed_hace_hash_queue_task,
> +		     (unsigned long)hace_dev);
> +	crypto_init_queue(&hash_engine->queue, ASPEED_HASH_QUEUE_LENGTH);
> +
> +	hace_dev->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (!hace_dev->regs) {
> +		dev_err(&pdev->dev, "Failed to map resources\n");
> +		return -ENOMEM;
> +	}
> +
> +	hace_dev->irq = platform_get_irq(pdev, 0);
> +	if (!hace_dev->irq) {
> +		dev_err(&pdev->dev, "Failed to get interrupt\n");
> +		return -ENXIO;
> +	}
> +
> +	rc = devm_request_irq(&pdev->dev, hace_dev->irq, aspeed_hace_irq, 0,
> +			      dev_name(&pdev->dev), hace_dev);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Failed to request interrupt\n");
> +		return rc;
> +	}
> +
> +	hace_dev->yclk = devm_clk_get(&pdev->dev, "yclk");
> +	if (IS_ERR(hace_dev->yclk)) {
> +		dev_err(&pdev->dev, "Failed to get yclk\n");
> +		return -ENODEV;
> +	}
> +
> +	rc = clk_prepare_enable(hace_dev->yclk);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Failed to enable clock 0x%x\n", rc);
> +		return rc;

This is not undone, neither if an error occures after it, nor in the 
.remove function.

> +	}
> +
> +	hash_engine->ahash_src_addr =
> +		dma_alloc_coherent(&pdev->dev,
> +				   ASPEED_HASH_SRC_DMA_BUF_LEN,
> +				   &hash_engine->ahash_src_dma_addr,
> +				   GFP_KERNEL);
> +	if (!hash_engine->ahash_src_addr) {
> +		dev_err(&pdev->dev, "Failed to allocate dma buffer\n");
> +		return -ENOMEM;
> +	}

Same here, this si not undone in the .remove function.

> +
> +	rc = aspeed_hace_register(hace_dev);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Failed to register hash alg, rc:0x%x\n", rc);

Is this really an error if finaly we continue and return 0 (success) at 
the end?

> +		rc = 0;
> +	}
> +
> +	dev_info(&pdev->dev, "ASPEED Crypto Accelerator successfully registered\n");
> +
> +	return rc;
> +}
> +
> +static int aspeed_hace_remove(struct platform_device *pdev)
> +{
> +	struct aspeed_hace_dev *hace_dev = platform_get_drvdata(pdev);
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +
> +	aspeed_hace_unregister(hace_dev);

Should this be done even if aspeed_hace_register() failed in the probe?

Just my 2c,
CJ


> +
> +	tasklet_kill(&hash_engine->done_task);
> +	tasklet_kill(&hash_engine->queue_task);
> +
> +	return 0;
> +}
> +

[...]
