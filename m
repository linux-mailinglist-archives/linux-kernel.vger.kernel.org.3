Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2C44660EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356944AbhLBJ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:57:16 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:55551 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356831AbhLBJ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:56:44 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPA id D0C41240021;
        Thu,  2 Dec 2021 09:53:18 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 5/6] irq: spear-shirq: Add support for IRQ 0..6
Date:   Thu,  2 Dec 2021 10:52:54 +0100
Message-Id: <20211202095255.165797-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202095255.165797-1-herve.codina@bootlin.com>
References: <20211202095255.165797-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ 0..7 are not supported by the driver for SPEAr320 SOC family.

IRQ 0 is not reserved in SPEAr320 SOC (assigned to GPIOINT).
Furthermore, in SPEAr320s SOC variant, IRQ 0..6 are assigned
as follow:
  IRQ 6 - NGPIO_INTR: Combined status of edge programmable
                      interrupts from GPIO ports
  IRQ 5 - TX_OR_INTR: I2S interrupt on Transmit FIFO overrun
  IRQ 4 - TX_EMP_INTR: I2S interrupt on Transmit FIFO empty
  IRQ 3 - RX_OR_INTR: I2S interrupt on Receive FIFO overrun
  IRQ 2 - RX_DA_INTR: I2S interrupt on data available in Receive FIFO
  IRQ 1 - Reserved
  IRQ 0 - GPIO_INTR: Legacy interrupt from GPIO ports

Add support for these IRQs in SPEAr320 SOC family.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/irqchip/spear-shirq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/spear-shirq.c b/drivers/irqchip/spear-shirq.c
index 1518ba31a80c..7c17a6f643ef 100644
--- a/drivers/irqchip/spear-shirq.c
+++ b/drivers/irqchip/spear-shirq.c
@@ -149,6 +149,8 @@ static struct spear_shirq spear320_shirq_ras3 = {
 	.offset		= 0,
 	.nr_irqs	= 7,
 	.mask		= ((0x1 << 7) - 1) << 0,
+	.irq_chip	= &dummy_irq_chip,
+	.status_reg	= SPEAR320_INT_STS_MASK_REG,
 };
 
 static struct spear_shirq spear320_shirq_ras1 = {
-- 
2.31.1

