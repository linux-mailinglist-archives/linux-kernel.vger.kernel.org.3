Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F4E53ADCC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiFAUpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiFAUpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:45:12 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE3023B733
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:30:12 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id wUyenfSGZP8ApwUyeno3EU; Wed, 01 Jun 2022 22:30:10 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 01 Jun 2022 22:30:10 +0200
X-ME-IP: 90.11.190.129
Message-ID: <56f0c3cb-c17f-6bc1-f621-09e0c2e5e62f@wanadoo.fr>
Date:   Wed, 1 Jun 2022 22:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/5] crypto: aspeed: add HACE crypto driver
Content-Language: fr
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
 <20220601054204.1522976-6-neal_liu@aspeedtech.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220601054204.1522976-6-neal_liu@aspeedtech.com>
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

Le 01/06/2022 à 07:42, Neal Liu a écrit :
 > Add HACE crypto driver to support symmetric-key
 > encryption and decryption with multiple modes of
 > operation.
 >
 > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
 > Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
 > ---
 >   drivers/crypto/aspeed/Kconfig              |   16 +
 >   drivers/crypto/aspeed/Makefile             |    2 +
 >   drivers/crypto/aspeed/aspeed-hace-crypto.c | 1019 ++++++++++++++++++++
 >   drivers/crypto/aspeed/aspeed-hace.c        |  101 +-
 >   drivers/crypto/aspeed/aspeed-hace.h        |  107 ++
 >   5 files changed, 1242 insertions(+), 3 deletions(-)
 >   create mode 100644 drivers/crypto/aspeed/aspeed-hace-crypto.c
 >
 > diff --git a/drivers/crypto/aspeed/Kconfig 
b/drivers/crypto/aspeed/Kconfig
 > index 17b800286a51..5e4d18288bf1 100644
[...]

 > +int aspeed_register_hace_crypto_algs(struct aspeed_hace_dev *hace_dev)
 > +{
 > +	int rc, i;
 > +
 > +	for (i = 0; i < ARRAY_SIZE(aspeed_crypto_algs); i++) {
 > +		aspeed_crypto_algs[i].hace_dev = hace_dev;
 > +		rc = crypto_register_skcipher(&aspeed_crypto_algs[i].alg.skcipher);
 > +		if (rc)
 > +			return rc;
 > +	}
 > +
 > +	if (hace_dev->version == AST2600_VERSION) {
 > +		for (i = 0; i < ARRAY_SIZE(aspeed_crypto_algs_g6); i++) {
 > +			aspeed_crypto_algs_g6[i].hace_dev = hace_dev;
 > +			rc = crypto_register_skcipher(
 > +				&aspeed_crypto_algs_g6[i].alg.skcipher);
 > +			if (rc)
 > +				return rc;
 > +		}
 > +	}
Should there be some kind of error handling here, in order to undo 
things already done if an error occures?

 > +
 > +	return 0;
 > +}
 > diff --git a/drivers/crypto/aspeed/aspeed-hace.c 
b/drivers/crypto/aspeed/aspeed-hace.c
 > index f25b13d120e8..f7f90c230843 100644
 > --- a/drivers/crypto/aspeed/aspeed-hace.c
 > +++ b/drivers/crypto/aspeed/aspeed-hace.c
 > @@ -40,10 +40,30 @@ void __weak 
aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
 >   	pr_warn("%s: Not supported yet\n", __func__);
 >   }
 >
 > +/* Weak function for HACE crypto */
 > +int __weak aspeed_hace_crypto_handle_queue(struct aspeed_hace_dev 
*hace_dev,
 > +					   struct crypto_async_request *new_areq)
 > +{
 > +	pr_warn("%s: Not supported yet\n", __func__);
 > +	return -EINVAL;
 > +}
 > +
 > +int __weak aspeed_register_hace_crypto_algs(struct aspeed_hace_dev 
*hace_dev)
 > +{
 > +	pr_warn("%s: Not supported yet\n", __func__);
 > +	return -EINVAL;
 > +}
 > +
 > +void __weak aspeed_unregister_hace_crypto_algs(struct 
aspeed_hace_dev *hace_dev)
 > +{
 > +	pr_warn("%s: Not supported yet\n", __func__);
 > +}
 > +
 >   /* HACE interrupt service routine */
 >   static irqreturn_t aspeed_hace_irq(int irq, void *dev)
 >   {
 >   	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)dev;
 > +	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
 >   	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
 >   	u32 sts;
 >
 > @@ -56,12 +76,36 @@ static irqreturn_t aspeed_hace_irq(int irq, void 
*dev)
 >   		if (hash_engine->flags & CRYPTO_FLAGS_BUSY)
 >   			tasklet_schedule(&hash_engine->done_task);
 >   		else
 > -			dev_warn(hace_dev->dev, "no active requests.\n");
 > +			dev_warn(hace_dev->dev, "HASH no active requests.\n");
To reduce diff, maybe this could already be part of patch 1/5?

 > +	}
 > +
 > +	if (sts & HACE_CRYPTO_ISR) {
 > +		if (crypto_engine->flags & CRYPTO_FLAGS_BUSY)
 > +			tasklet_schedule(&crypto_engine->done_task);
 > +		else
 > +			dev_warn(hace_dev->dev, "CRYPTO no active requests.\n");
 >   	}
 >
 >   	return IRQ_HANDLED;
 >   }
 >
 > +static void aspeed_hace_cryptro_done_task(unsigned long data)
 > +{
 > +	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)data;
 > +	struct aspeed_engine_crypto *crypto_engine;
 > +
 > +	crypto_engine = &hace_dev->crypto_engine;
 > +	crypto_engine->is_async = true;
 > +	crypto_engine->resume(hace_dev);
 > +}
 > +
 > +static void aspeed_hace_crypto_queue_task(unsigned long data)
 > +{
 > +	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)data;
 > +
 > +	aspeed_hace_crypto_handle_queue(hace_dev, NULL);
 > +}
 > +
 >   static void aspeed_hace_hash_done_task(unsigned long data)
 >   {
 >   	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)data;
 > @@ -79,12 +123,27 @@ static void aspeed_hace_hash_queue_task(unsigned 
long data)
 >
 >   static int aspeed_hace_register(struct aspeed_hace_dev *hace_dev)
 >   {
 > -	return aspeed_register_hace_hash_algs(hace_dev);
 > +	int rc1, rc2;
 > +
 > +	rc1 = aspeed_register_hace_hash_algs(hace_dev);
 > +	if (rc1) {
 > +		HACE_DBG(hace_dev, "Failed to register hash alg, rc:0x%x\n",
 > +			 rc1);
 > +	}
 > +
 > +	rc2 = aspeed_register_hace_crypto_algs(hace_dev);
 > +	if (rc2) {
 > +		HACE_DBG(hace_dev, "Failed to register crypto alg, rc:0x%x\n",
 > +			 rc2);
 > +	}
 > +
 > +	return rc1 + rc2;
This looks odd. The error returned could finally be pointless if both 
rc1 and rc2 are not 0.

 >   }
 >
 >   static void aspeed_hace_unregister(struct aspeed_hace_dev *hace_dev)
 >   {
 >   	aspeed_unregister_hace_hash_algs(hace_dev);
 > +	aspeed_unregister_hace_crypto_algs(hace_dev);
 >   }
 >
 >   static const struct of_device_id aspeed_hace_of_matches[] = {
 > @@ -95,6 +154,7 @@ static const struct of_device_id 
aspeed_hace_of_matches[] = {
 >
 >   static int aspeed_hace_probe(struct platform_device *pdev)
 >   {
 > +	struct aspeed_engine_crypto *crypto_engine;
 >   	const struct of_device_id *hace_dev_id;
 >   	struct aspeed_engine_hash *hash_engine;
 >   	struct aspeed_hace_dev *hace_dev;
 > @@ -115,6 +175,7 @@ static int aspeed_hace_probe(struct 
platform_device *pdev)
 >   	hace_dev->dev = &pdev->dev;
 >   	hace_dev->version = (unsigned long)hace_dev_id->data;
 >   	hash_engine = &hace_dev->hash_engine;
 > +	crypto_engine = &hace_dev->crypto_engine;
 >
 >   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 >
 > @@ -127,6 +188,13 @@ static int aspeed_hace_probe(struct 
platform_device *pdev)
 >   		     (unsigned long)hace_dev);
 >   	crypto_init_queue(&hash_engine->queue, ASPEED_HASH_QUEUE_LENGTH);
 >
 > +	spin_lock_init(&crypto_engine->lock);
 > +	tasklet_init(&crypto_engine->done_task, aspeed_hace_cryptro_done_task,
 > +		     (unsigned long)hace_dev);
 > +	tasklet_init(&crypto_engine->queue_task, aspeed_hace_crypto_queue_task,
 > +		     (unsigned long)hace_dev);
 > +	crypto_init_queue(&crypto_engine->queue, ASPEED_HASH_QUEUE_LENGTH);
 > +
 >   	hace_dev->regs = devm_ioremap_resource(&pdev->dev, res);
 >   	if (!hace_dev->regs) {
 >   		dev_err(&pdev->dev, "Failed to map resources\n");
 > @@ -168,9 +236,36 @@ static int aspeed_hace_probe(struct 
platform_device *pdev)
 >   		return -ENOMEM;
 >   	}
 >
 > +	crypto_engine->cipher_ctx =
 > +		dma_alloc_coherent(&pdev->dev,
 > +				   PAGE_SIZE,
 > +				   &crypto_engine->cipher_ctx_dma,
 > +				   GFP_KERNEL);
Should all these dma_alloc_coherent() be undone in the error handling 
path of the probe and in the .rmove function?
If applicable, maybe dmam_alloc_coherent() would ease? realeasing of 
resources?

 > +	crypto_engine->cipher_addr =
 > +		dma_alloc_coherent(&pdev->dev,
 > +				   ASPEED_CRYPTO_SRC_DMA_BUF_LEN,
 > +				   &crypto_engine->cipher_dma_addr,
 > +				   GFP_KERNEL);
 > +	if (!crypto_engine->cipher_ctx || !crypto_engine->cipher_addr) {
 > +		dev_err(&pdev->dev, "Failed to allocate cipher dma\n");
 > +		return -ENOMEM;
 > +	}
 > +
 > +	if (hace_dev->version == AST2600_VERSION) {
 > +		crypto_engine->dst_sg_addr =
 > +			dma_alloc_coherent(&pdev->dev,
 > +					   ASPEED_CRYPTO_DST_DMA_BUF_LEN,
 > +					   &crypto_engine->dst_sg_dma_addr,
 > +					   GFP_KERNEL);
 > +		if (!crypto_engine->dst_sg_addr) {
 > +			dev_err(&pdev->dev, "Failed to allocate dst_sg dma\n");
 > +			return -ENOMEM;
 > +		}
 > +	}
 > +
 >   	rc = aspeed_hace_register(hace_dev);
 >   	if (rc) {
 > -		dev_err(&pdev->dev, "Failed to register hash alg, rc:0x%x\n", rc);
 > +		dev_err(&pdev->dev, "Failed to register algs, rc:0x%x\n", rc);
To reduce diff, maybe this could already be part of patch 1/5?

 >   		rc = 0;
 >   	}
 >   [...]
