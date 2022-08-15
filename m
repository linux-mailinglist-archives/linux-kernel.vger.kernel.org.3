Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F984592BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbiHOJFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbiHOJE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:04:59 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E760020F6E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1660554288;
  x=1692090288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zt034/C45VJoSyl9XibRuMatY47BOXi19qHnJVO9/7o=;
  b=hMoBn8mmAQCTGt/Sek19gAqCwJwzVazF8m7jaLP755hvI89rbg3J2XF+
   VjWGgJ8ZEGOz0I4Sg2xRvtXs6tKHdrpFlPiAP6bao9zniNAYhtx6Vxlrf
   SBzE5mE40zNgQ+aYWGvzyGJx+xD6M3nuarCncAHK2vfAxwkwhIgQPVVS4
   YasDc3I+Xb7iwEC9HWQkVh6sd/9D0OLPthKbTfbuWPelz3Z2dPYtzhRzq
   TjKxubvxnNnNVaPVcupjOMWREglFhtrnsaWr+GyMxsQO6wbpl78hDLS4h
   msHPe4G984uWDhil0Si6uzLov3y6QM11gIea561zknfkKNVNLKbNi77hM
   g==;
From:   Surendranath Parimi <surendranath.parimi@axis.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     <kernel@axis.com>,
        Surendranath Parimi <surendranath.parimi@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] extcon: usbc-tusb320: Expose the charger type
Date:   Mon, 15 Aug 2022 11:04:27 +0200
Message-ID: <20220815090427.3205-1-surendranath.parimi@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the UFP mode of operation, knowing the charger type helps to draw the
appropriate amount of current from the charger. The charger type can be
know by reading the current_mode_detect bits of register 0x08.

Add support to expose the charger type.

Signed-off-by: Surendranath Parimi <surendranath.parimi@axis.com>
---
 drivers/extcon/extcon-usbc-tusb320.c | 37 ++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 6ba3d89b106d..43f07efa3472 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -14,6 +14,10 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 
+#define TUSB320_REG8				0x8
+#define TUSB320_REG8_CURRENT_MODE_DETECT_SHIFT	0x4
+#define TUSB320_REG8_CURRENT_MODE_DETECT_MASK	0x3
+
 #define TUSB320_REG9				0x9
 #define TUSB320_REG9_ATTACHED_STATE_SHIFT	6
 #define TUSB320_REG9_ATTACHED_STATE_MASK	0x3
@@ -42,6 +46,13 @@ enum tusb320_mode {
 	TUSB320_MODE_DRP,
 };
 
+enum tusb320_current_mode_detect {
+	TUSB320_CURRENT_MODE_DETECT_DEFAULT,
+	TUSB320_CURRENT_MODE_DETECT_MEDIUM,
+	TUSB320_CURRENT_MODE_DETECT_ACCESSORY,
+	TUSB320_CURRENT_MODE_DETECT_HIGH,
+};
+
 struct tusb320_priv;
 
 struct tusb320_ops {
@@ -67,6 +78,9 @@ static const char * const tusb_attached_states[] = {
 static const unsigned int tusb320_extcon_cable[] = {
 	EXTCON_USB,
 	EXTCON_USB_HOST,
+	EXTCON_CHG_USB_FAST,
+	EXTCON_CHG_USB_SLOW,
+	EXTCON_CHG_USB_PD,
 	EXTCON_NONE,
 };
 
@@ -187,8 +201,8 @@ static struct tusb320_ops tusb320l_ops = {
 static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
 {
 	struct tusb320_priv *priv = dev_id;
-	int state, polarity;
-	unsigned reg;
+	int state, polarity, current_mode;
+	unsigned int reg, reg8;
 
 	if (regmap_read(priv->regmap, TUSB320_REG9, &reg)) {
 		dev_err(priv->dev, "error during i2c read!\n");
@@ -205,10 +219,26 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
 	dev_dbg(priv->dev, "attached state: %s, polarity: %d\n",
 		tusb_attached_states[state], polarity);
 
+	if (regmap_read(priv->regmap, TUSB320_REG8, &reg8)) {
+		dev_err(priv->dev, "error during i2c read!\n");
+		return IRQ_NONE;
+	}
+
+	current_mode = (reg8 >> TUSB320_REG8_CURRENT_MODE_DETECT_SHIFT) &
+			TUSB320_REG8_CURRENT_MODE_DETECT_MASK;
+
+	dev_dbg(priv->dev, "current_mode:%d\n", current_mode);
+
 	extcon_set_state(priv->edev, EXTCON_USB,
 			 state == TUSB320_ATTACHED_STATE_UFP);
 	extcon_set_state(priv->edev, EXTCON_USB_HOST,
 			 state == TUSB320_ATTACHED_STATE_DFP);
+	extcon_set_state(priv->edev, EXTCON_CHG_USB_SLOW,
+			 current_mode == TUSB320_CURRENT_MODE_DETECT_ACCESSORY);
+	extcon_set_state(priv->edev, EXTCON_CHG_USB_FAST,
+			 current_mode == TUSB320_CURRENT_MODE_DETECT_MEDIUM);
+	extcon_set_state(priv->edev, EXTCON_CHG_USB_PD,
+			 current_mode == TUSB320_CURRENT_MODE_DETECT_HIGH);
 	extcon_set_property(priv->edev, EXTCON_USB,
 			    EXTCON_PROP_USB_TYPEC_POLARITY,
 			    (union extcon_property_value)polarity);
@@ -217,6 +247,9 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
 			    (union extcon_property_value)polarity);
 	extcon_sync(priv->edev, EXTCON_USB);
 	extcon_sync(priv->edev, EXTCON_USB_HOST);
+	extcon_sync(priv->edev, EXTCON_CHG_USB_PD);
+	extcon_sync(priv->edev, EXTCON_CHG_USB_FAST);
+	extcon_sync(priv->edev, EXTCON_CHG_USB_SLOW);
 
 	priv->state = state;
 
-- 
2.20.1

