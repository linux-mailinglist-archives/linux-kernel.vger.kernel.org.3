Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B26B518652
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiECOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbiECOSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:18:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA8192B5;
        Tue,  3 May 2022 07:14:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 027491F43549
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651587287;
        bh=Vzt5rJ5w7RADVz/xg7c0ik/5e8mPzC+52IMY2R0fGcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G6yBvaUFOtq2v5zmB5Z+4pdtwSex6+dHxIdEZrcLqxGga+4XL1AIF+fl+rZ/d+eAl
         qTP6097PFgYVBcu6+wC/g1/r4ZBLftyWr3N0RSGZyq0K2/OTXTbaovJWPoiKi9GnjI
         XHc3YgavRqfrGGyQdE/HDgre0kA3Iszglg96hVcjl+ANeTLQyR8eSJeRJwtr3oGmwo
         Bn9qG/LhrsL0tvHPDVP+nglNqX00jMqFlWT0eQPUbx+rwSHGP9of7J+Fk1RosrQC13
         hWk4ZmcMKXYvC7T98XJvBSaKGcDsJgqTnT4NiUVZqIx+B925ZNr6TMS3vCh6svtFD7
         vYrlCGdmP0uSQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        matthias.bgg@gmail.com, chun-jie.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: [PATCH v2 2/2] soc: mediatek: pm-domains: Add support for Helio X10 MT6795
Date:   Tue,  3 May 2022 16:14:41 +0200
Message-Id: <20220503141441.125852-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503141441.125852-1-angelogioacchino.delregno@collabora.com>
References: <20220503141441.125852-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pm-domains (mtcmos) data for MediaTek Helio X10 MT6795 SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt6795-pm-domains.h | 112 +++++++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c    |   5 +
 2 files changed, 117 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt6795-pm-domains.h

diff --git a/drivers/soc/mediatek/mt6795-pm-domains.h b/drivers/soc/mediatek/mt6795-pm-domains.h
new file mode 100644
index 000000000000..ef07c9dfdd9b
--- /dev/null
+++ b/drivers/soc/mediatek/mt6795-pm-domains.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT6795_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT6795_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mt6795-power.h>
+
+/*
+ * MT6795 power domain support
+ */
+
+static const struct scpsys_domain_data scpsys_domain_data_mt6795[] = {
+	[MT6795_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
+		.sta_mask = PWR_STATUS_VDEC,
+		.ctl_offs = SPM_VDE_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT6795_POWER_DOMAIN_VENC] = {
+		.name = "venc",
+		.sta_mask = PWR_STATUS_VENC,
+		.ctl_offs = SPM_VEN_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT6795_POWER_DOMAIN_ISP] = {
+		.name = "isp",
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = SPM_ISP_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+	},
+	[MT6795_POWER_DOMAIN_MM] = {
+		.name = "mm",
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = SPM_DIS_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MM_M0 |
+					       MT8173_TOP_AXI_PROT_EN_MM_M1),
+		},
+	},
+	[MT6795_POWER_DOMAIN_MJC] = {
+		.name = "mjc",
+		.sta_mask = BIT(20),
+		.ctl_offs = 0x298,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT6795_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.sta_mask = PWR_STATUS_AUDIO,
+		.ctl_offs = SPM_AUDIO_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT6795_POWER_DOMAIN_MFG_ASYNC] = {
+		.name = "mfg_async",
+		.sta_mask = PWR_STATUS_MFG_ASYNC,
+		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = 0,
+	},
+	[MT6795_POWER_DOMAIN_MFG_2D] = {
+		.name = "mfg_2d",
+		.sta_mask = PWR_STATUS_MFG_2D,
+		.ctl_offs = SPM_MFG_2D_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+	},
+	[MT6795_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = SPM_MFG_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(13, 8),
+		.sram_pdn_ack_bits = GENMASK(21, 16),
+		.bp_infracfg = {
+			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MFG_S |
+					       MT8173_TOP_AXI_PROT_EN_MFG_M0 |
+					       MT8173_TOP_AXI_PROT_EN_MFG_M1 |
+					       MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
+		},
+	},
+};
+
+static const struct scpsys_soc_data mt6795_scpsys_data = {
+	.domains_data = scpsys_domain_data_mt6795,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt6795),
+};
+
+#endif /* __SOC_MEDIATEK_MT6795_PM_DOMAINS_H */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 5ced254b082b..4da53488c381 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/soc/mediatek/infracfg.h>
 
+#include "mt6795-pm-domains.h"
 #include "mt8167-pm-domains.h"
 #include "mt8173-pm-domains.h"
 #include "mt8183-pm-domains.h"
@@ -555,6 +556,10 @@ static void scpsys_domain_cleanup(struct scpsys *scpsys)
 }
 
 static const struct of_device_id scpsys_of_match[] = {
+	{
+		.compatible = "mediatek,mt6795-power-controller",
+		.data = &mt6795_scpsys_data,
+	},
 	{
 		.compatible = "mediatek,mt8167-power-controller",
 		.data = &mt8167_scpsys_data,
-- 
2.35.1

