Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9644C5119F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbiD0Ovo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiD0Ouc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:50:32 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D443BA7D;
        Wed, 27 Apr 2022 07:47:19 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23R81vYl014965;
        Wed, 27 Apr 2022 07:47:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=6MEYlmBcPq8kn+ACy0R3VgoyuZ15TXQIe6ar9+vlJRk=;
 b=Ui3dNPF2QluBYoN8SECKk8HOGQs8RyrQIqKffCrahjBOhImtMPq2vOSN7D97V3FCZqsV
 LCV40YZs6R5LsDksVYagX74SBFA7UG+rRrFpKudH7QAiTydnq80Ht5RVgkC0XSr8m/kI
 5wKBS/INEDMDbW6gUlFDTN8esOPKErkc8Wgui8NEVhoffHyS7nveZobVWcf6Q4OXKee3
 2UVpBw7Upm+fIt8z/HZjMtRZkF+PhSGQR/K8ZX+S7SLm1NBIdCePMIWH0gUVGuZSoDtE
 8ijJWO5a1G6gfITOslnWC72pX2kUpst259yWpiibFcaGXJG+1vYp7oeSdEzm43jJys6j 5w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3fprt4k6v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 07:47:16 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 27 Apr
 2022 07:47:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 27 Apr 2022 07:47:14 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 6CFFA5B6948;
        Wed, 27 Apr 2022 07:47:14 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <rric@kernel.org>,
        <cchavva@marvell.com>, <wsadowski@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 3/5] gpio: thunderx: Configure GPIO pins at probe
Date:   Wed, 27 Apr 2022 07:46:18 -0700
Message-ID: <20220427144620.9105-4-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427144620.9105-1-pmalgujar@marvell.com>
References: <20220427144620.9105-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 14M_RTwEzwoHuUHAtoOCpcRGZbihR07T
X-Proofpoint-GUID: 14M_RTwEzwoHuUHAtoOCpcRGZbihR07T
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

Add support to configure GPIO pins using DTS 'pin-cfg'

Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/gpio/gpio-thunderx.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index bb2b40e4033b00134af35592b6b7c7f83cf6c737..451c412512450fea717937376002d2ba35d1c508 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -426,6 +426,32 @@ static void *thunderx_gpio_populate_parent_alloc_info(struct gpio_chip *chip,
 	return info;
 }
 
+static void thunderx_gpio_pinsel(struct device *dev,
+				 struct thunderx_gpio *txgpio)
+{
+	struct device_node *node;
+	const __be32 *pinsel;
+	int npins, rlen, i;
+	u32 pin, sel;
+
+	node = dev_of_node(dev);
+	if (!node)
+		return;
+
+	pinsel = of_get_property(node, "pin-cfg", &rlen);
+	if (!pinsel || rlen % 2)
+		return;
+
+	npins = rlen / sizeof(__be32) / 2;
+
+	for (i = 0; i < npins; i++) {
+		pin = of_read_number(pinsel++, 1);
+		sel = of_read_number(pinsel++, 1);
+		dev_dbg(dev, "Set GPIO pin %d CFG register to %x\n", pin, sel);
+		writeq(sel, txgpio->register_base + bit_cfg_reg(pin));
+	}
+}
+
 static int thunderx_gpio_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
@@ -548,6 +574,9 @@ static int thunderx_gpio_probe(struct pci_dev *pdev,
 	if (err)
 		goto out;
 
+	/* Configure default functions of GPIO pins */
+	thunderx_gpio_pinsel(dev, txgpio);
+
 	/* Push on irq_data and the domain for each line. */
 	for (i = 0; i < ngpio; i++) {
 		struct irq_fwspec fwspec;
-- 
2.17.1

