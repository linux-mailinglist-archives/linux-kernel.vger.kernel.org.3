Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1047CB80
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbhLVDHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:07:14 -0500
Received: from out28-170.mail.aliyun.com ([115.124.28.170]:59181 "EHLO
        out28-170.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhLVDHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:07:13 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1124211|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0614957-0.00474604-0.933758;FP=3273083516590370965|1|1|5|0|-1|-1|-1;HT=ay29a033018047193;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.MMijYBS_1640142430;
Received: from sunxibot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.MMijYBS_1640142430)
          by smtp.aliyun-inc.com(10.147.40.44);
          Wed, 22 Dec 2021 11:07:11 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     ulf.hansson@linaro.org, mripard@kernel.org, wens@csie.org,
        samuel@sholland.org, andre.przywara@arm.com
Cc:     jernej.skrabec@gmail.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Wu <michael@allwinnertech.com>
Subject: [PATCH 1/3] mmc:sunxi-mmc:add support on discrete device power supply
Date:   Wed, 22 Dec 2021 11:06:34 +0800
Message-Id: <20211222030634.33816-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because some platform has no regulator, only use discrete devices
to supply power,For this situation, to use sd/mmc card, we add ocr manually

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 2702736a1c57..afeefead6501 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1300,6 +1300,14 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 	if (ret)
 		return ret;
 
+	/**
+	 * Some platforms has no regulator. Discrete devices are used instead.
+	 * To support sd/mmc card, we need to add ocr manually.
+	 */
+	if (!host->mmc->ocr_avail)
+		host->mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+
+
 	host->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host->reg_base))
 		return PTR_ERR(host->reg_base);
-- 
2.29.0

