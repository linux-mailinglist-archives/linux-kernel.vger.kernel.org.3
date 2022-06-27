Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29D655C83E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiF0OZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbiF0OY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:24:58 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31EC13F17;
        Mon, 27 Jun 2022 07:24:56 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RDUGw7019903;
        Mon, 27 Jun 2022 16:24:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=5ybBWdltrOVfB3COS/9ZMlv6Yfed7gpPzfjsJK88MFQ=;
 b=Mq7bMvfS4SG4urWivh0l6nssNofuNvhEzdofEwfDpnRk0kOTKFpwYRmyc20+JY9iKO5c
 AIY0iUqFrHOHFbzuuzuv6AhuG0Y+4JDKUcNr6PMzfoVerbh2Nu4UJ9k0N7D6xIrVy4XV
 Opwpa79OTwfTjuLwqm61Om36nmsLHMRAeDv1nHXPsOVMNPtLm+m4Gh44td1cVZtp032S
 gJdyPpXvhqL91igL2MKSKsAcuw5dmFmMhG26D9bXgR74VJU/DHp9GsPw85nLWzXeZFXE
 47BxfjNgfR66rpcxHAYH6moxl7HIQKacY+fNyb14VpxN+A5UNbmw2IHafYcnV30p5VZO Vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gy9mr1sy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 16:24:47 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3363510002A;
        Mon, 27 Jun 2022 16:24:47 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CE12C217B6A;
        Mon, 27 Jun 2022 16:24:46 +0200 (CEST)
Received: from localhost (10.75.127.49) by EQNDAG1NODE6.st.com (10.75.129.135)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 27 Jun
 2022 16:23:55 +0200
From:   Fabien Dessenne <fabien.dessenne@foss.st.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@foss.st.com>
Subject: [PATCH] pinctrl: stm32: fix optional IRQ support to gpios
Date:   Mon, 27 Jun 2022 16:23:50 +0200
Message-ID: <20220627142350.742973-1-fabien.dessenne@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To EQNDAG1NODE6.st.com
 (10.75.129.135)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To act as an interrupt controller, a gpio bank relies on the
"interrupt-parent" of the pin controller.
When this optional "interrupt-parent" misses, do not create any IRQ domain.

This fixes a "NULL pointer in stm32_gpio_domain_alloc()" kernel crash when
the interrupt-parent = <exti> property is not declared in the Device Tree.

Fixes: 0eb9f683336d ("pinctrl: Add IRQ support to STM32 gpios")

Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 57a33fb0f2d7..14bcca73238a 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1338,16 +1338,18 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 	bank->secure_control = pctl->match_data->secure_control;
 	spin_lock_init(&bank->lock);
 
-	/* create irq hierarchical domain */
-	bank->fwnode = fwnode;
+	if (pctl->domain) {
+		/* create irq hierarchical domain */
+		bank->fwnode = fwnode;
 
-	bank->domain = irq_domain_create_hierarchy(pctl->domain, 0,
-					STM32_GPIO_IRQ_LINE, bank->fwnode,
-					&stm32_gpio_domain_ops, bank);
+		bank->domain = irq_domain_create_hierarchy(pctl->domain, 0, STM32_GPIO_IRQ_LINE,
+							   bank->fwnode, &stm32_gpio_domain_ops,
+							   bank);
 
-	if (!bank->domain) {
-		err = -ENODEV;
-		goto err_clk;
+		if (!bank->domain) {
+			err = -ENODEV;
+			goto err_clk;
+		}
 	}
 
 	err = gpiochip_add_data(&bank->gpio_chip, bank);
@@ -1510,6 +1512,8 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	pctl->domain = stm32_pctrl_get_irq_domain(pdev);
 	if (IS_ERR(pctl->domain))
 		return PTR_ERR(pctl->domain);
+	if (!pctl->domain)
+		dev_warn(dev, "pinctrl without interrupt support\n");
 
 	/* hwspinlock is optional */
 	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
-- 
2.25.1

