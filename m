Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD9C542B37
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbiFHJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiFHJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F5A1D8724;
        Wed,  8 Jun 2022 01:36:09 -0700 (PDT)
X-UUID: 4470ec7dfb57491faada2c210a6babfb-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:970d56f0-9126-468c-a77c-e980752fd990,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:970d56f0-9126-468c-a77c-e980752fd990,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:3e2515e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:ab9fe7398c47,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 4470ec7dfb57491faada2c210a6babfb-20220608
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 676625393; Wed, 08 Jun 2022 16:36:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Jun 2022 16:36:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 8 Jun 2022 16:36:02 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        "Guenter Roeck" <groeck@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v2 4/9] remoteproc: mediatek: Support probing for the 2nd core of dual-core SCP
Date:   Wed, 8 Jun 2022 16:35:48 +0800
Message-ID: <20220608083553.8697-5-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220608083553.8697-1-tinghan.shen@mediatek.com>
References: <20220608083553.8697-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk_scp.c driver only supports the single core SCP and the
1st core of a dual-core SCP. This patch extends it for the 2nd core.

MT8195 SCP is a dual-core MCU. Both cores are housed in the same subsys.
They have the same viewpoint of registers and memory.

Core 1 of the SCP features its own set of core configuration registers,
interrupt controller, timers, and DMAs. The rest of the peripherals
in this subsystem are shared by core 0 and core 1.

As for memory, core 1 has its own cache memory. the SCP SRAM is shared
by core 0 and core 1.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_scp.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 3510c6d0bbc8..91b4aefde4ac 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -23,6 +23,10 @@
 #define MAX_CODE_SIZE 0x500000
 #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
 
+#define SCP_CORE_0 0
+#define SCP_CORE_1 1
+#define SCP_CORE_SINGLE 0xF
+
 /**
  * scp_get() - get a reference to SCP.
  *
@@ -836,6 +840,7 @@ static int scp_probe(struct platform_device *pdev)
 	struct resource *res;
 	const char *fw_name = "scp.img";
 	int ret, i;
+	u32 core_id = SCP_CORE_SINGLE;
 
 	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
 	if (ret < 0 && ret != -EINVAL)
@@ -851,8 +856,16 @@ static int scp_probe(struct platform_device *pdev)
 	scp->data = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, scp);
 
+	ret = of_property_read_u32_index(dev->of_node, "mediatek,scp-core", 1, &core_id);
+	if (ret == 0)
+		dev_info(dev, "Boot SCP dual core %u\n", core_id);
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
-	scp->sram_base = devm_ioremap_resource(dev, res);
+	if (core_id == SCP_CORE_1)
+		scp->sram_base = devm_ioremap(dev, res->start, resource_size(res));
+	else
+		scp->sram_base = devm_ioremap_resource(dev, res);
+
 	if (IS_ERR(scp->sram_base))
 		return dev_err_probe(dev, PTR_ERR(scp->sram_base),
 				     "Failed to parse and map sram memory\n");
@@ -873,7 +886,12 @@ static int scp_probe(struct platform_device *pdev)
 		scp->l1tcm_phys = res->start;
 	}
 
-	scp->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	if (core_id == SCP_CORE_1)
+		scp->reg_base = devm_ioremap(dev, res->start, resource_size(res));
+	else
+		scp->reg_base = devm_ioremap_resource(dev, res);
+
 	if (IS_ERR(scp->reg_base))
 		return dev_err_probe(dev, PTR_ERR(scp->reg_base),
 				     "Failed to parse and map cfg memory\n");
-- 
2.18.0

