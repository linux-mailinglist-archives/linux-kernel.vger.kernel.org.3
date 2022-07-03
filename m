Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C5A564715
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiGCLUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiGCLU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:20:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3FC9FD9;
        Sun,  3 Jul 2022 04:20:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f2so4092455wrr.6;
        Sun, 03 Jul 2022 04:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXcllgLFQkv+OtgQlnqQLrSG+8U6QBobVbJQIfbLeDc=;
        b=ASubR/DorqHNaHOZTMNmJf42AORByMmajCRhw/xu6F9k8A+f2NMIwkcEXKNu3WV+RV
         F5zT6mcRy3V3xnxgAv48DKjHt1Aa4zWH5mb4aYRp8Aaw7fDq49gqzsUGzUBBO1BMIaVs
         /eYBOxLm1LxL+nENV6FuigRE12tjcDVBX3IuFQsOz5+tmlv8kBGQL75CwVCJ+cFRHVP8
         G3Gj7qv0/7r//MEeoqtpM5F9T3OMj0S+6wtYSKc7/ibJr+C43ZSVngVGtpDYch/ddg2t
         THFtpNYeM4r7iDdSEIxb/LUs1RAv9NoUfgV20IJO3kFqv4Ihuyy/S1t+kx5Sfl+hDscb
         FvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXcllgLFQkv+OtgQlnqQLrSG+8U6QBobVbJQIfbLeDc=;
        b=yktceRG1hW3YQHCQN+lJKJGFiSG2jTbHdsMrBC6nbID9vzerNRicmdMsZ3P+CUoTCF
         jNNxgmQepEVZMsmR563zWQfDYDNE6rP0bnGjZRdsRKwO2zYaTlk2JSjXBAOGHNTzI+MY
         blakbm+2tCG9AlaemoJv7+qu6gM6gIUm7Kf7Njo9QioUCUIp02FROsKYz5QveRww+WRm
         YeG1/zMQlC/fDqEDWj0Ga1mZlMzgZYrS4F0vQcydBiAQeARWNmFeEUH5tPnTEUocLRwu
         1zTJYdMtq+v/V7Txj7DHAIovwL8hvsKdoW5c9N654MIQXFEuCg3/JyFVfxRkPBjxpQuL
         fRpg==
X-Gm-Message-State: AJIora8YYFdjXFR+RjSoJ8fIyO/8OzUuHfeolYtRD70hdQnd4gr90sZe
        QGqu5JMOE/oLJuOKAiKziRA7sw88EK8=
X-Google-Smtp-Source: AGRyM1swzRxDpf8D0d6n5lH5iXztubINWaOhPoN2s7N/2M4fBoQkUD3hkWUFlBtqauR62tmB/UXOzA==
X-Received: by 2002:a5d:5107:0:b0:21b:8c5d:1072 with SMTP id s7-20020a5d5107000000b0021b8c5d1072mr23264520wrt.378.1656847224899;
        Sun, 03 Jul 2022 04:20:24 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bc5d7000000b003a04a9504b0sm13212450wmk.40.2022.07.03.04.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:20:24 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, krzk@kernel.org,
        m.szyprowski@samsung.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 09/12] regmap-irq: Deprecate type registers and virtual registers
Date:   Sun,  3 Jul 2022 12:20:58 +0100
Message-Id: <20220703112101.24493-10-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220703112101.24493-1-aidanmacdonald.0x0@gmail.com>
References: <20220703112101.24493-1-aidanmacdonald.0x0@gmail.com>
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

Config registers can be used to replace both type and virtual
registers, so mark both features are deprecated and issue a
warning if they're used.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c |  6 ++++++
 include/linux/regmap.h           | 18 ++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index e3dbf55a561f..8cbc62c3d638 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -726,6 +726,12 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 				return -EINVAL;
 	}
 
+	if (chip->num_type_reg)
+		dev_warn(map->dev, "type registers are deprecated; use config registers instead");
+
+	if (chip->num_virt_regs || chip->virt_reg_base || chip->set_type_virt)
+		dev_warn(map->dev, "virtual registers are deprecated; use config registers instead");
+
 	if (irq_base) {
 		irq_base = irq_alloc_descs(irq_base, 0, chip->num_irqs, 0);
 		if (irq_base < 0) {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 432449f318cb..2b5b07f85cc0 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1457,8 +1457,10 @@ struct regmap_irq_sub_irq_map {
  * @ack_base:    Base ack address. If zero then the chip is clear on read.
  *               Using zero value is possible with @use_ack bit.
  * @wake_base:   Base address for wake enables.  If zero unsupported.
- * @type_base:   Base address for irq type.  If zero unsupported.
- * @virt_reg_base:   Base addresses for extra config regs.
+ * @type_base:   Base address for irq type.  If zero unsupported.  Deprecated,
+ *		 use @config_base instead.
+ * @virt_reg_base:   Base addresses for extra config regs. Deprecated, use
+ *		     @config_base instead.
  * @config_base: Base address for IRQ type config regs. If null unsupported.
  * @irq_reg_stride:  Stride to use for chips where registers are not contiguous.
  * @init_ack_masked: Ack all masked interrupts once during initalization.
@@ -1467,7 +1469,8 @@ struct regmap_irq_sub_irq_map {
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
- * @type_invert: Invert the type flags.
+ * @type_invert: Invert the type flags. Deprecated, use config registers
+ *		 instead.
  * @type_in_mask: Use the mask registers for controlling irq type. Use this if
  *		  the hardware provides separate bits for rising/falling edge
  *		  or low/high level interrupts and they should be combined into
@@ -1486,9 +1489,11 @@ struct regmap_irq_sub_irq_map {
  * @irqs:        Descriptors for individual IRQs.  Interrupt numbers are
  *               assigned based on the index in the array of the interrupt.
  * @num_irqs:    Number of descriptors.
- * @num_type_reg:    Number of type registers.
+ * @num_type_reg:    Number of type registers. Deprecated, use config registers
+ *		     instead.
  * @num_virt_regs:   Number of non-standard irq configuration registers.
- *		     If zero unsupported.
+ *		     If zero unsupported. Deprecated, use config registers
+ *		     instead.
  * @num_config_bases:	Number of config base registers.
  * @num_config_regs:	Number of config registers for each config base register.
  * @handle_pre_irq:  Driver specific callback to handle interrupt from device
@@ -1496,7 +1501,8 @@ struct regmap_irq_sub_irq_map {
  * @handle_post_irq: Driver specific callback to handle interrupt from device
  *		     after handling the interrupts in regmap_irq_handler().
  * @set_type_virt:   Driver specific callback to extend regmap_irq_set_type()
- *		     and configure virt regs.
+ *		     and configure virt regs. Deprecated, use @set_type_config
+ *		     callback and config registers instead.
  * @set_type_config: Callback used for configuring irq types.
  * @irq_drv_data:    Driver specific IRQ data which is passed as parameter when
  *		     driver specific pre/post interrupt handler is called.
-- 
2.35.1

