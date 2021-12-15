Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7744755AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbhLOJ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:58:37 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:34726 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236424AbhLOJ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:58:36 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BF8xCws015281;
        Wed, 15 Dec 2021 10:58:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=lZG15mDYfKTrDheVg7teKe9LQIF/Jfc46902xSXLzgI=;
 b=zBRAqCT8KYZa7beH85eh1dEHtckpKK9HirwREw40i6SDzTKgpOS3+jyzkeKrjftz+X5O
 8uARJNmO4fZ38QRtRkp7CbKcX78oQ5sdD8GmvcZ3Gq96lmpAubY3TFaktkkaKIXR0elc
 XuWuKZ0zZtPQsSAnf0zY/2Ep22gNYNEo4zzvh4rE8NnaVE1Owjq110cCSVAzSzf50g4g
 7yzG1pZHxChnodRArwIN9nkMVvKBqwPlomY2bU5Kd8QlXM1nbyDghjhKuHkOTSW3Uy2h
 5C7oQxfKL1qRzpSThy5T8PbA3nxKWSMK99EPOcsFlXg6o3j5fMrYgpvNAaFDHM7Tt5mB vQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cxrthxn6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 10:58:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DCCC100034;
        Wed, 15 Dec 2021 10:58:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4462F22D195;
        Wed, 15 Dec 2021 10:58:21 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 10:58:20
 +0100
From:   Fabien Dessenne <fabien.dessenne@foss.st.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Christoph Fritz <chf.fritz@googlemail.com>
CC:     Fabien Dessenne <fabien.dessenne@foss.st.com>
Subject: [PATCH] pinctrl: stm32: consider the GPIO offset to expose all the GPIO lines
Date:   Wed, 15 Dec 2021 10:58:08 +0100
Message-ID: <20211215095808.621716-1-fabien.dessenne@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_07,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the GPIO controller offset (from "gpio-ranges") to compute the
maximum GPIO line number.
This fixes an issue where gpio-ranges uses a non-null offset.
  e.g.: gpio-ranges = <&pinctrl 6 86 10>
        In that case the last valid GPIO line is not 9 but 15 (6 + 10 - 1)

Fixes: 67e2996f72c7 ("pinctrl: stm32: fix the reported number of GPIO lines per bank")
Reported-by: Christoph Fritz <chf.fritz@googlemail.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 24764ebcc936..9ed764731570 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1251,10 +1251,10 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 		bank_nr = args.args[1] / STM32_GPIO_PINS_PER_BANK;
 		bank->gpio_chip.base = args.args[1];
 
-		npins = args.args[2];
-		while (!of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3,
-							 ++i, &args))
-			npins += args.args[2];
+		/* get the last defined gpio line (offset + nb of pins) */
+		npins = args.args[0] + args.args[2];
+		while (!of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, ++i, &args))
+			npins = max(npins, (int)(args.args[0] + args.args[2]));
 	} else {
 		bank_nr = pctl->nbanks;
 		bank->gpio_chip.base = bank_nr * STM32_GPIO_PINS_PER_BANK;
-- 
2.25.1

