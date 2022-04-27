Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8766C511AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiD0OuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbiD0OuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:50:13 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50F23A71F;
        Wed, 27 Apr 2022 07:47:01 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23R8PvKm029548;
        Wed, 27 Apr 2022 07:46:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=kUzkGHosfalGaRapK8AEVNc6FRaQFJYIbMbE7o+fLSQ=;
 b=JOqTrqelIkscEbNsw12aw/yQYr6a/OeWKgXSoUY2p11o/JF2Ra92BdWzMpxDZSYs1tDz
 0QBMcrH0qANhmGii5E2qUSCL77961h03t6dmwT1P3XXb6dXR0UmuFq/bqHF+ncLtPM6D
 YtjRLvqCCImbt1ChanogYBjZRxqmJ12on06Bcr2dK4vyRi7ydRsazcYuMVxu7NWhaqsy
 hxieoNmPpJxFUlt5A5N+FXeZ3DtRZmonC0YxWhQ86HZLA3ZXX3yhFt6Kspvb4SXMQpTN
 p0wunk95E6OWG19n02lfhCt90KEfS6WJ+WRKs38XvEfnL14PvyiFRGotNoU86D2Hgi0c rg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3fprsqu79w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 07:46:58 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 07:46:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 07:46:57 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id C113E3F7063;
        Wed, 27 Apr 2022 07:46:56 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <rric@kernel.org>,
        <cchavva@marvell.com>, <wsadowski@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 1/5] gpio: thunderx: avoid potential deadlock
Date:   Wed, 27 Apr 2022 07:46:16 -0700
Message-ID: <20220427144620.9105-2-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427144620.9105-1-pmalgujar@marvell.com>
References: <20220427144620.9105-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LAvtWri8CC1NfFI3tKWyRRAYN6aS-AzR
X-Proofpoint-GUID: LAvtWri8CC1NfFI3tKWyRRAYN6aS-AzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using irqsave/irqrestore locking variants to avoid any deadlock.

Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/gpio/gpio-thunderx.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 9f66deab46eaa99d05413a996b585284c433574d..bb2b40e4033b00134af35592b6b7c7f83cf6c737 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -104,16 +104,17 @@ static int thunderx_gpio_request(struct gpio_chip *chip, unsigned int line)
 static int thunderx_gpio_dir_in(struct gpio_chip *chip, unsigned int line)
 {
 	struct thunderx_gpio *txgpio = gpiochip_get_data(chip);
+	unsigned long flags;
 
 	if (!thunderx_gpio_is_gpio(txgpio, line))
 		return -EIO;
 
-	raw_spin_lock(&txgpio->lock);
+	raw_spin_lock_irqsave(&txgpio->lock, flags);
 	clear_bit(line, txgpio->invert_mask);
 	clear_bit(line, txgpio->od_mask);
 	writeq(txgpio->line_entries[line].fil_bits,
 	       txgpio->register_base + bit_cfg_reg(line));
-	raw_spin_unlock(&txgpio->lock);
+	raw_spin_unlock_irqrestore(&txgpio->lock, flags);
 	return 0;
 }
 
@@ -135,11 +136,12 @@ static int thunderx_gpio_dir_out(struct gpio_chip *chip, unsigned int line,
 {
 	struct thunderx_gpio *txgpio = gpiochip_get_data(chip);
 	u64 bit_cfg = txgpio->line_entries[line].fil_bits | GPIO_BIT_CFG_TX_OE;
+	unsigned long flags;
 
 	if (!thunderx_gpio_is_gpio(txgpio, line))
 		return -EIO;
 
-	raw_spin_lock(&txgpio->lock);
+	raw_spin_lock_irqsave(&txgpio->lock, flags);
 
 	thunderx_gpio_set(chip, line, value);
 
@@ -151,7 +153,7 @@ static int thunderx_gpio_dir_out(struct gpio_chip *chip, unsigned int line,
 
 	writeq(bit_cfg, txgpio->register_base + bit_cfg_reg(line));
 
-	raw_spin_unlock(&txgpio->lock);
+	raw_spin_unlock_irqrestore(&txgpio->lock, flags);
 	return 0;
 }
 
@@ -188,11 +190,12 @@ static int thunderx_gpio_set_config(struct gpio_chip *chip,
 	int ret = -ENOTSUPP;
 	struct thunderx_gpio *txgpio = gpiochip_get_data(chip);
 	void __iomem *reg = txgpio->register_base + (bank * GPIO_2ND_BANK) + GPIO_TX_SET;
+	unsigned long flags;
 
 	if (!thunderx_gpio_is_gpio(txgpio, line))
 		return -EIO;
 
-	raw_spin_lock(&txgpio->lock);
+	raw_spin_lock_irqsave(&txgpio->lock, flags);
 	orig_invert = test_bit(line, txgpio->invert_mask);
 	new_invert  = orig_invert;
 	orig_od = test_bit(line, txgpio->od_mask);
@@ -243,7 +246,7 @@ static int thunderx_gpio_set_config(struct gpio_chip *chip,
 	default:
 		break;
 	}
-	raw_spin_unlock(&txgpio->lock);
+	raw_spin_unlock_irqrestore(&txgpio->lock, flags);
 
 	/*
 	 * If currently output and OPEN_DRAIN changed, install the new
@@ -329,6 +332,7 @@ static int thunderx_gpio_irq_set_type(struct irq_data *d,
 	struct thunderx_gpio *txgpio = gpiochip_get_data(gc);
 	struct thunderx_line *txline =
 		&txgpio->line_entries[irqd_to_hwirq(d)];
+	unsigned long flags;
 	u64 bit_cfg;
 
 	irqd_set_trigger_type(d, flow_type);
@@ -342,7 +346,7 @@ static int thunderx_gpio_irq_set_type(struct irq_data *d,
 		irq_set_handler_locked(d, handle_fasteoi_mask_irq);
 	}
 
-	raw_spin_lock(&txgpio->lock);
+	raw_spin_lock_irqsave(&txgpio->lock, flags);
 	if (flow_type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_LEVEL_LOW)) {
 		bit_cfg |= GPIO_BIT_CFG_PIN_XOR;
 		set_bit(txline->line, txgpio->invert_mask);
@@ -351,7 +355,7 @@ static int thunderx_gpio_irq_set_type(struct irq_data *d,
 	}
 	clear_bit(txline->line, txgpio->od_mask);
 	writeq(bit_cfg, txgpio->register_base + bit_cfg_reg(txline->line));
-	raw_spin_unlock(&txgpio->lock);
+	raw_spin_unlock_irqrestore(&txgpio->lock, flags);
 
 	return IRQ_SET_MASK_OK;
 }
-- 
2.17.1

