Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A851759108C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbiHLMLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiHLMKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:10:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD1811465
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxFEtSPwvFHhMVgHq5B8RvdO6n+JE3RXUNed+wLVDppHPygYU3syGUxQcTu/Ms0b7dkgSFLDXTLfxbjjGEsgCO6Wq0SquAeVC6yeUSQ5MP1HY1oC4cTj7q+hcY3ISGpOv3df2XYFfQ6shxkGrUpyAKIayzqZpHPBcN4gkXpTzJaw0rIt8oQ8imv0mQGO/Q9HWcfU/BWEJdikyyJLdzITWxlWBB8KEaIzVJtz+5mRDW2Slprtff8Etyih4TdE6I80/xPjGHZ9WOgkRWAo+Zgv7JUhNch+FC5iqDtxPI/vmJbaCLnfH3Sr6fC6s4Mu4TIHR1x3u68nLNKst39kaDBf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FI5utRtVu0No3ck5MI5X0AKcca7t7nZIh7/WdvG6gog=;
 b=XGCAAw+BuCzwGNHevD5Sqx0qdH0CI67oI467bmI269ZdIxtKhKRfSvbPj35cyw6TPfcEEjOzVb+lofJ2foyDPimJg7kamADwWnd+24QY54J2DtSH3qwaD8jQbb1xbBfwDPh55G/Q2P58iwqF2o9xA+uMt+q6xV8dOjdjqHk6PfTfkTdDqet6nhhAPw5fpQ2K6QhnbnVwYDbd3CqeFQ/sZ0sJZBIHOqbSePXaX1FUmoNWt3qhDmC0Dzeoq098LCvE1etBIapTvUfYbzdxhuib0etDPwaL9iyU7bc9WIytgYiA6E8AGCbRcGscjppCPfvoU0Vx/pjVIBbBwXJv4rJVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FI5utRtVu0No3ck5MI5X0AKcca7t7nZIh7/WdvG6gog=;
 b=an1LkuogtSZKRJyA5NNtsCKYAVFxGIPPLqw34LjSAvoEpxRaMT/jLWGt3WTTEufuxqSeZLBs2KvogOSgYUX0PWK1KhbCIrj7x4Z3ljDClgJpYgm6IOJBPhY25CTGaDtUcbFbw4k2KcEqWtEp2zx48c3kDklZG4AmoT3k4VFHsNE=
Received: from DS7PR03CA0242.namprd03.prod.outlook.com (2603:10b6:5:3b3::7) by
 MWHPR12MB1328.namprd12.prod.outlook.com (2603:10b6:300:c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Fri, 12 Aug 2022 12:10:43 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::c7) by DS7PR03CA0242.outlook.office365.com
 (2603:10b6:5:3b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 12 Aug 2022 12:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Fri, 12 Aug 2022 12:10:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 07:10:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 07:09:49 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 12 Aug 2022 07:09:45 -0500
From:   Syed Saba kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/13] ASoC: amd: add platform devices for acp6.2 pdm driver and dmic driver
Date:   Fri, 12 Aug 2022 17:37:22 +0530
Message-ID: <20220812120731.788052-5-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 180117b1-fd83-4046-0c7b-08da7c5bae78
X-MS-TrafficTypeDiagnostic: MWHPR12MB1328:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQYm9YefTFYkJq6eUdObSLTV+F33r+9BsY5T1PnT6xJeZ07pf1iCl2CUeloN8Dks+nMGjiVEn79xXeck3ZYKUeVVx+gkFuxsmRWZO8rX2Lshb1Z+orzKAyJZUrvGpiJKEe2klicmUHp0mbxmXZJgp0FB8h7DUncMVKS7fEjTrnbCjuH8meFxSkxvn/lmh28LUjFFZEPu7BI7QoiL8aFPMaM+or+82p1idVjoD14uHSQcJQ9UT0BSiWRfjrr9F/Srx4kDxomJHKDS/N+b/HF7rrR7t4nxTgIUJ46P2jR8rrt5nZE7XiVpOpVkw2IafVRuqAImed3pJnkV+/1pEPItVL7uUTHZ55bR+wLROMGvJmKkTSSK3+zv9nYgCxv2en180d72C7gAxhuCFPwZqj8G+kWwUF/Khj1Wjh+c2i08ruTburK9tcD3PCYRBCJD7R9J81y79regKjod+fVJPtORzvn0G4TrqiCO8PCLy+AQGU7862FlmGHXrSH3LG724RV9TzHNxaNYIpI4BYM3uEWojk/g474syIwoxdHURpT1nYRxCyPdAQes9SQKCrdMabxJF8Py1DOBziY6jEWsGj1JUV64Ik6qgoo7c2pGT5AU354MEigKy09BJUHw9VuKTOo8QPNyCDBUCNI6aes07UEd2Yr/aEATx+U+0RUSP658SjPzRWCzDNfzUgFVKLD5L4PhFLvfRDs6TLct9f9A+X23QwqiULvjTxKL+jtDw5MjLVCpRuGwD4vJPXgDbPdlSVGlK7ssvKH3rXoQZLIt/7e9KLDTnndF4xbcWZaFURo4E62MCylM3YtSQKowvhvCSwk+SKH+QWTFs2b2aij0jSEPoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(40470700004)(36840700001)(8936002)(36860700001)(8676002)(40480700001)(54906003)(36756003)(83380400001)(426003)(47076005)(40460700003)(110136005)(70586007)(70206006)(316002)(4326008)(186003)(5660300002)(2616005)(86362001)(41300700001)(6666004)(1076003)(336012)(478600001)(2906002)(81166007)(356005)(82740400003)(7696005)(26005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 12:10:43.6380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 180117b1-fd83-4046-0c7b-08da7c5bae78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1328
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP6.2 IP has PDM decoder block.
Create a platform device for it, so that the PDM platform driver
can be bound to this device.
Pass PCI resources like MMIO to this platform device.

Create a platform device for generic dmic codec driver.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp62.h  | 23 +++++++++++
 sound/soc/amd/ps/pci-ps.c | 83 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
index 8e734f190b11..ab56e1f8c31b 100644
--- a/sound/soc/amd/ps/acp62.h
+++ b/sound/soc/amd/ps/acp62.h
@@ -9,6 +9,10 @@
 
 #define ACP_DEVICE_ID 0x15E2
 #define ACP62_PHY_BASE_ADDRESS 0x1240000
+#define ACP6x_REG_START		0x1240000
+#define ACP6x_REG_END		0x1250200
+#define ACP6x_DEVS		2
+#define ACP6x_PDM_MODE		1
 
 #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
 #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
@@ -22,6 +26,25 @@
 #define ACP_ERROR_MASK 0x20000000
 #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
 
+enum acp_config {
+	ACP_CONFIG_0 = 0,
+	ACP_CONFIG_1,
+	ACP_CONFIG_2,
+	ACP_CONFIG_3,
+	ACP_CONFIG_4,
+	ACP_CONFIG_5,
+	ACP_CONFIG_6,
+	ACP_CONFIG_7,
+	ACP_CONFIG_8,
+	ACP_CONFIG_9,
+	ACP_CONFIG_10,
+	ACP_CONFIG_11,
+	ACP_CONFIG_12,
+	ACP_CONFIG_13,
+	ACP_CONFIG_14,
+	ACP_CONFIG_15,
+};
+
 static inline u32 acp62_readl(void __iomem *base_addr)
 {
 	return readl(base_addr - ACP62_PHY_BASE_ADDRESS);
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 2014f415af15..94201f75427a 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -9,11 +9,16 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
 
 #include "acp62.h"
 
 struct acp62_dev_data {
 	void __iomem *acp62_base;
+	struct resource *res;
+	bool acp62_audio_mode;
+	struct platform_device *pdev[ACP6x_DEVS];
 };
 
 static int acp62_power_on(void __iomem *acp_base)
@@ -117,8 +122,11 @@ static int snd_acp62_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
 	struct acp62_dev_data *adata;
+	struct platform_device_info pdevinfo[ACP6x_DEVS];
+	int index, ret;
+	int val = 0x00;
+	struct acpi_device *adev;
 	u32 addr;
-	int ret;
 
 	/* Pink Sardine device check */
 	switch (pci->revision) {
@@ -157,8 +165,75 @@ static int snd_acp62_probe(struct pci_dev *pci,
 	ret = acp62_init(adata->acp62_base);
 	if (ret)
 		goto release_regions;
+	val = acp62_readl(adata->acp62_base + ACP_PIN_CONFIG);
+	switch (val) {
+	case ACP_CONFIG_0:
+	case ACP_CONFIG_1:
+	case ACP_CONFIG_2:
+	case ACP_CONFIG_3:
+	case ACP_CONFIG_9:
+	case ACP_CONFIG_15:
+		dev_info(&pci->dev, "Audio Mode %d\n", val);
+		break;
+	default:
+
+		/* Checking DMIC hardware*/
+		adev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), 0x02, 0);
+
+		if (adev) {
+			const union acpi_object *obj;
+
+			if (!acpi_dev_get_property(adev, "acp-audio-device-type",
+						   ACPI_TYPE_INTEGER, &obj) &&
+						   obj->integer.value == 2) {
+				adata->res = devm_kzalloc(&pci->dev,
+							  sizeof(struct resource), GFP_KERNEL);
+
+				if (!adata->res) {
+					ret = -ENOMEM;
+					goto de_init;
+				}
+
+				adata->res->name = "acp_iomem";
+				adata->res->flags = IORESOURCE_MEM;
+				adata->res->start = addr;
+				adata->res->end = addr + (ACP6x_REG_END - ACP6x_REG_START);
+				adata->acp62_audio_mode = ACP6x_PDM_MODE;
 
+				memset(&pdevinfo, 0, sizeof(pdevinfo));
+				pdevinfo[0].name = "acp_ps_pdm_dma";
+				pdevinfo[0].id = 0;
+				pdevinfo[0].parent = &pci->dev;
+				pdevinfo[0].num_res = 1;
+				pdevinfo[0].res = adata->res;
+
+				pdevinfo[1].name = "dmic-codec";
+				pdevinfo[1].id = 0;
+				pdevinfo[1].parent = &pci->dev;
+
+				for (index = 0; index < ACP6x_DEVS; index++) {
+					adata->pdev[index] =
+						platform_device_register_full(&pdevinfo[index]);
+
+					if (IS_ERR(adata->pdev[index])) {
+						dev_err(&pci->dev,
+							"cannot register %s device\n",
+							 pdevinfo[index].name);
+						ret = PTR_ERR(adata->pdev[index]);
+						goto unregister_devs;
+					}
+				}
+			}
+		}
+		break;
+	}
 	return 0;
+unregister_devs:
+	for (--index; index >= 0; index--)
+		platform_device_unregister(adata->pdev[index]);
+de_init:
+	if (acp62_deinit(adata->acp62_base))
+		dev_err(&pci->dev, "ACP de-init failed\n");
 release_regions:
 	pci_release_regions(pci);
 disable_pci:
@@ -170,9 +245,13 @@ static int snd_acp62_probe(struct pci_dev *pci,
 static void snd_acp62_remove(struct pci_dev *pci)
 {
 	struct acp62_dev_data *adata;
-	int ret;
+	int ret, index;
 
 	adata = pci_get_drvdata(pci);
+	if (adata->acp62_audio_mode == ACP6x_PDM_MODE) {
+		for (index = 0; index < ACP6x_DEVS; index++)
+			platform_device_unregister(adata->pdev[index]);
+	}
 	ret = acp62_deinit(adata->acp62_base);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
-- 
2.25.1

