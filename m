Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F74483BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiADGDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:03:34 -0500
Received: from out28-5.mail.aliyun.com ([115.124.28.5]:43073 "EHLO
        out28-5.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiADGDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:03:32 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1070646|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00848475-0.00139035-0.990125;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.MWR.1lZ_1641276209;
Received: from sunxibot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.MWR.1lZ_1641276209)
          by smtp.aliyun-inc.com(10.147.41.199);
          Tue, 04 Jan 2022 14:03:29 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     ulf.hansson@linaro.org, mripard@kernel.org, wens@csie.org,
        samuel@sholland.org, andre.przywara@arm.com
Cc:     jernej.skrabec@gmail.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Wu <michael@allwinnertech.com>
Subject: [PATCH v2] mmc: sunxi-mmc: check ocr_avail on resource request
Date:   Tue,  4 Jan 2022 14:03:25 +0800
Message-Id: <20220104060325.3957-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms have no regulator, discrete power devices are used instead.
However, sunxi_mmc_probe does not catch this exception when regulator is
absent in DTS. This leads to sd or eMMC init failure.

To solve this, a fixed vmmc regulator must be hooked up in DTS, like this:
reg_dummy_vmmc: dummy_vmmc {
	compatible = "regulator-fixed";
	regulator-name = "dummy-vmmc";
	regulator-min-microvolt = <3300000>;
	regulator-max-microvolt = <3300000>;
};

mmc0:mmc@4020000 {
	compatible = "allwinner,sun50i-a100-emmc";
	device_type = "mmc0";
	vmmc-supply = <&reg_dummy_vmmc>;
}

In this patch, we print an error message and abort the probe process if
the regulator is not specified in DTS.

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 2702736a1c57..0da74bddaf87 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1300,6 +1300,11 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 	if (ret)
 		return ret;
 
+	if (!host->mmc->ocr_avail) {
+		dev_err(&pdev->dev, "Could not get mmc regulator\n");
+		return -EINVAL;
+	}
+
 	host->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host->reg_base))
 		return PTR_ERR(host->reg_base);
-- 
2.29.0

