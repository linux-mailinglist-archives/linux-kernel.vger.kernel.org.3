Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A366552530
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343891AbiFTUHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343578AbiFTUGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A69C1EAF8;
        Mon, 20 Jun 2022 13:06:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so8271179wma.4;
        Mon, 20 Jun 2022 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSMrw3v+dSzormMBlFnVqYO9Ybr8y9x05CczXbq+F0o=;
        b=Z5NU7srurHjdW0PF4O55elxfUZBgUDk5YPFMpg1RdqsrfEMk7qqDL8ep246OtTDiC4
         6ju1VuX4sBfj/74uye9hCH9gCwZwRwcHtZnxI5fARi8+LKkAfdtx6MsYh7Pd2V1TJjz4
         mBfORf4k+PothfafLBhj4toSDqA8T3fphY7zdnpKPOEXFqu9HOx5TIDgCjq0SHrD5+CC
         INWDLlQYTChLHohDgNjGViE1FGyoeWG6e0guIJwG/DdPTqvgerAxAxO0lis9868OmZEE
         CKl/wzAj2Z91E8tmS3NFKhGL/f5b2L127K+Vv0HRjyl36ABwGlxo+z8eyN1C5YXCAV/1
         VXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSMrw3v+dSzormMBlFnVqYO9Ybr8y9x05CczXbq+F0o=;
        b=JGnCOgr+9Dk9QepWwHUxOPRbJspBfCevP8F8PAlsKD3C9dAOJOkrKbT8Jf6IGDRDtD
         wWk9VQdumKCNv8TfLhH4600mMw1gEd8OSf0iw1LvyuMNc9G1tmq2IfmFtuVjcjkf96ts
         aAMAUst1r7Qa8PYTipfvj6i4rbabpJDiOfLXGRkEad4lj8twM4GOhXX9mR2/a+oeWsy4
         AP5CGs2FMvCRXV0+Axx4wcPVOXR27c8zhdlQu6s7v1kTfnsZ+SNk5pZmStLMBUWfFHTN
         qCtOek4J1fidirxgVWiG/hb63Ly8kBWxfEOzWsWRNJUcqGwl/hnlGTT0U7NsY0SNeL2M
         mipQ==
X-Gm-Message-State: AJIora9CCSaQIrJ3s7TcD+kPbwC86xER6FHBNev2xgHPR8ABbfUhxomW
        v0gZj04yQl07bDo+0/4s4QA=
X-Google-Smtp-Source: AGRyM1v4nGqgjAhTskzkWcEAA3t4wJpSGRdFd7rK8rtyVQboY6GtKy9ysgj/zJBTNIGbPGeagfeUtA==
X-Received: by 2002:a05:600c:3d18:b0:39c:474c:eb with SMTP id bh24-20020a05600c3d1800b0039c474c00ebmr26181880wmb.87.1655755590681;
        Mon, 20 Jun 2022 13:06:30 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id u25-20020adfa199000000b002184a3a3641sm14724036wru.100.2022.06.20.13.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:30 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        tglx@linutronix.de, maz@kernel.org, lee.jones@linaro.org,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, rjones@gateworks.com,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org
Subject: [PATCH 10/49] regmap-irq: Remove virtual registers support
Date:   Mon, 20 Jun 2022 21:06:05 +0100
Message-Id: <20220620200644.1961936-11-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual registers can be removed, since config registers implement
the same functionality.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 42 --------------------------------
 include/linux/regmap.h           |  9 -------
 2 files changed, 51 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index be35f2e41b8c..5a3e255816fd 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -38,7 +38,6 @@ struct regmap_irq_chip_data {
 	unsigned int *wake_buf;
 	unsigned int *type_buf;
 	unsigned int *type_buf_def;
-	unsigned int **virt_buf;
 	unsigned int **config_buf;
 
 	unsigned int irq_reg_stride;
@@ -218,20 +217,6 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		}
 	}
 
-	if (d->chip->num_virt_regs) {
-		for (i = 0; i < d->chip->num_virt_regs; i++) {
-			for (j = 0; j < d->chip->num_regs; j++) {
-				reg = sub_irq_reg(d, d->chip->virt_reg_base[i],
-						  j);
-				ret = regmap_write(map, reg, d->virt_buf[i][j]);
-				if (ret != 0)
-					dev_err(d->map->dev,
-						"Failed to write virt 0x%x: %d\n",
-						reg, ret);
-			}
-		}
-	}
-
 	for (i = 0; i < d->chip->num_config_bases; i++) {
 		for (j = 0; j < d->chip->num_config_regs; j++) {
 			reg = sub_irq_reg(d, d->chip->config_base[i], j);
@@ -346,10 +331,6 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 		return -EINVAL;
 	}
 
-	if (d->chip->set_type_virt)
-		return d->chip->set_type_virt(d->virt_buf, type, data->hwirq,
-					      reg);
-
 	return 0;
 }
 
@@ -782,24 +763,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			goto err_alloc;
 	}
 
-	if (chip->num_virt_regs) {
-		/*
-		 * Create virt_buf[chip->num_extra_config_regs][chip->num_regs]
-		 */
-		d->virt_buf = kcalloc(chip->num_virt_regs, sizeof(*d->virt_buf),
-				      GFP_KERNEL);
-		if (!d->virt_buf)
-			goto err_alloc;
-
-		for (i = 0; i < chip->num_virt_regs; i++) {
-			d->virt_buf[i] = kcalloc(chip->num_regs,
-						 sizeof(unsigned int),
-						 GFP_KERNEL);
-			if (!d->virt_buf[i])
-				goto err_alloc;
-		}
-	}
-
 	if (chip->num_config_bases && chip->num_config_regs) {
 		/*
 		 * Create config_buf[num_config_bases][num_config_regs]
@@ -989,11 +952,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	kfree(d->mask_buf);
 	kfree(d->status_buf);
 	kfree(d->status_reg_buf);
-	if (d->virt_buf) {
-		for (i = 0; i < chip->num_virt_regs; i++)
-			kfree(d->virt_buf[i]);
-		kfree(d->virt_buf);
-	}
 	if (d->config_buf) {
 		for (i = 0; i < chip->num_config_bases; i++)
 			kfree(d->config_buf[i]);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e48d65756fb4..bb8c89a83b51 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1459,7 +1459,6 @@ struct regmap_irq_sub_irq_map {
  *               Using zero value is possible with @use_ack bit.
  * @wake_base:   Base address for wake enables.  If zero unsupported.
  * @type_base:   Base address for irq type.  If zero unsupported.
- * @virt_reg_base:   Base addresses for extra config regs.
  * @config_base: Base address for IRQ type config regs. If null unsupported.
  * @irq_reg_stride:  Stride to use for chips where registers are not contiguous.
  * @init_ack_masked: Ack all masked interrupts once during initalization.
@@ -1486,8 +1485,6 @@ struct regmap_irq_sub_irq_map {
  *               assigned based on the index in the array of the interrupt.
  * @num_irqs:    Number of descriptors.
  * @num_type_reg:    Number of type registers.
- * @num_virt_regs:   Number of non-standard irq configuration registers.
- *		     If zero unsupported.
  * @type_reg_stride: Stride to use for chips where type registers are not
  *			contiguous.
  * @num_config_bases:	Number of config base registers.
@@ -1496,8 +1493,6 @@ struct regmap_irq_sub_irq_map {
  *		     before regmap_irq_handler process the interrupts.
  * @handle_post_irq: Driver specific callback to handle interrupt from device
  *		     after handling the interrupts in regmap_irq_handler().
- * @set_type_virt:   Driver specific callback to extend regmap_irq_set_type()
- *		     and configure virt regs.
  * @set_type_config: Callback used for configuring irq types.
  * @irq_drv_data:    Driver specific IRQ data which is passed as parameter when
  *		     driver specific pre/post interrupt handler is called.
@@ -1520,7 +1515,6 @@ struct regmap_irq_chip {
 	unsigned int ack_base;
 	unsigned int wake_base;
 	unsigned int type_base;
-	unsigned int *virt_reg_base;
 	const unsigned int *config_base;
 	unsigned int irq_reg_stride;
 	bool mask_writeonly:1;
@@ -1543,15 +1537,12 @@ struct regmap_irq_chip {
 	int num_irqs;
 
 	int num_type_reg;
-	int num_virt_regs;
 	int num_config_bases;
 	int num_config_regs;
 	unsigned int type_reg_stride;
 
 	int (*handle_pre_irq)(void *irq_drv_data);
 	int (*handle_post_irq)(void *irq_drv_data);
-	int (*set_type_virt)(unsigned int **buf, unsigned int type,
-			     unsigned long hwirq, int reg);
 	int (*set_type_config)(unsigned int **buf, unsigned int type,
 			       const struct regmap_irq *irq_data, int idx);
 	void *irq_drv_data;
-- 
2.35.1

