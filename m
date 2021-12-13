Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1552D472195
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhLMHSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:18:37 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:30320 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhLMHSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:18:36 -0500
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 02:18:36 EST
Received: from rd02-sz.amlogic.software (10.28.8.43) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Mon, 13 Dec 2021
 15:03:32 +0800
From:   Rong Chen <rong.chen@amlogic.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <--to=1131046452@qq.com>
CC:     <45581586@qq.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rong Chen <rong.chen@amlogic.com>
Subject: [PATCH] mmc: meson: initial ocr available by default value
Date:   Mon, 13 Dec 2021 15:03:30 +0800
Message-ID: <20211213070330.3351505-1-rong.chen@amlogic.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.43]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch will add a value of ocr supported by the controller,
to specify some of voltage values are supported.

Ocr_avail should place an initial value to avoid uncertain
value for the platform that unsupport regulator such as S4.

Signed-off-by: Rong Chen <rong.chen@amlogic.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 8f36536cb1b6..c339e12d5516 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -4,6 +4,9 @@
  *
  * Copyright (c) 2016 BayLibre, SAS.
  * Author: Kevin Hilman <khilman@baylibre.com>
+ *
+ * Copyright (c) 2021 Amlogic, inc.
+ * Author: Rong Chen <Rong.Chen@amlogic.com>
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -130,6 +133,7 @@
 #define SD_EMMC_DESC_CHAIN_MODE BIT(1)
 
 #define MUX_CLK_NUM_PARENTS 2
+#define SD_EMMC_OCR_AVAIL 0x200080
 
 struct meson_mmc_data {
 	unsigned int tx_delay_mask;
@@ -1150,6 +1154,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	host->dram_access_quirk = device_property_read_bool(&pdev->dev,
 					"amlogic,dram-access-quirk");
 
+	mmc->ocr_avail = SD_EMMC_OCR_AVAIL;
 	/* Get regulators and the supported OCR mask */
 	host->vqmmc_enabled = false;
 	ret = mmc_regulator_get_supply(mmc);

base-commit: 141edd9e99eb91393e8a4d97742bd98328bff724
-- 
2.25.1

