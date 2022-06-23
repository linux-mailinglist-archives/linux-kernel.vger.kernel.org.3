Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808BF558A88
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiFWVOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiFWVNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEDB5131D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i67-20020a1c3b46000000b003a03567d5e9so593489wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXcllgLFQkv+OtgQlnqQLrSG+8U6QBobVbJQIfbLeDc=;
        b=Koz/reU77bu0VvbgzNl5NYw466Hvlq+xJzo7e9i6p+Ltpv9ptGfhVMICdtRtcXzIfP
         2ivQSbaBGxkP1GpTxevwBJHstbh84GFj0ov2HyPTH07JcwEm5qSdfs2hYnjNJ2+m/i8j
         yr0U6VoocnfO91cJhusyD5j75Pb+6FDiT/WCOXFoW63pig6Hjb44QrVnQaOeZxd24Tnc
         AMzeXLumoOPR5UO0v5SnlUZ+yTZRZWwKU2CIcq9tnRzZr7Os0LVgEd9xSwux8v9DsI0S
         VIxwm5H996Rtaza0+spjVvpEhIZGu9aCl9d7ZJH1N1LTxTSmoFMeSuAimEXFgTv28L0M
         hqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXcllgLFQkv+OtgQlnqQLrSG+8U6QBobVbJQIfbLeDc=;
        b=Gj6KiPEoKGIXjR8nJh27sW7UG4v7LSbmTKTzBy1/hhuIcaN3fcphQ7eDI3eOKZYgVf
         r1TP2cYcFSM+eI68IN5zA9SrHvmWWGnHcpZUxrlXO3lHyFmCxofifTz5bEtb6zqjJerH
         O0IcaOetwZAbinBkofA4IhWki2CN4sW3D325mh9qvZ/KWOw3Z7yQt/tIbQgvn5hpreNG
         2nFAFQDVkz9/9teKwFwmniSJzZGgQ4z0aFmvfR0S0E31riKglZDRyIA+nwfwvWypelmE
         kn+UZQiQ9W2R9JXyJhV6xFEDy2AMCQXHmPcp/YTM86EsO0lVItpR+uAGvdKByiEUjh7h
         fBtA==
X-Gm-Message-State: AJIora/AetGYtwyfN5baRpqko1jJAxR86yszg3Sk1ozlBwMytputoHr4
        M4jlZvJ6o4o6s785x00ySaw=
X-Google-Smtp-Source: AGRyM1v/B9pfRAAPsksMMQl0bhgtMcCRDcWfQiF0kCvTypfnviL3jOLOIPlrV/Qx5mbGGedlWM7+cg==
X-Received: by 2002:a1c:f310:0:b0:39c:605f:1dba with SMTP id q16-20020a1cf310000000b0039c605f1dbamr6293798wmq.43.1656018820755;
        Thu, 23 Jun 2022 14:13:40 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b0039c5497deccsm6117087wms.1.2022.06.23.14.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:40 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/12] regmap-irq: Deprecate type registers and virtual registers
Date:   Thu, 23 Jun 2022 22:14:17 +0100
Message-Id: <20220623211420.918875-10-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
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

