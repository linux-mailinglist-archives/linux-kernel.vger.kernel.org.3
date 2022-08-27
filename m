Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777FB5A38FB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiH0Q76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 12:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiH0Q7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:59:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F791118
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 09:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMNzcndOxoRvkgdHfOpNzQ6/5DeOpkqscwh7SnThhHZOUlqpDtPqzEPYwKMDDmuSbigNiSXKXbOSHZ62NsxUsARamdCV7lzthB22U5T7orPghg1AY1oZME28SqhmSWgd2R5SDZXqNk3vFyF61ojhKiJjQM78Sksk7ytlfr9/UgdoQDqfbZODQB4rw9CT+fPjxHS6St78lod9Qklt+n4jl6w8IFZYNb3Cgf1UHKTbzghOjwct+bMYIDiuk0VMeTtEgSr6M/FiLq503qZduaHwkaQH78OBxHOrUB9ZECdjHOPgvJTKF40FeDvNEtzZze98s1jbeJTwoRiRSyYEU56Dtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1ZtCbAh6UmUBvQ8RjLjIlxg4WFKsFP5AKwFQeg847U=;
 b=Flgext3U89JqZnmb5+bqJK4eKA42soJwUizH+UTNokhp9ZxUmpBi1MgkvXSSyoR9SzI7xkk53mD28wVlsL7f1OyxgLy/qEMR1U8ZAq10oQxlkedwDp4ypAKzqQXSxj4AzWJArARMNhjxJahgcafDgKlgImpi94S+lMgzwAmt0F765CfW37BiMhS4pQKL/uVyXiiLwyagTR3v+DVc0/D5s20z0m/rNKT+tQpiWCtx1RfqWsbsyWWmap87g6vF/66mppbGSW3E9OpDFkM8TYUcSoeTe/Dh2HrVPCeFWXMGC8FPZJb+fWK+lO0yKKPA2wYPt5vfODKIDjmaaLbORUJVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1ZtCbAh6UmUBvQ8RjLjIlxg4WFKsFP5AKwFQeg847U=;
 b=UCvIjLR3pqjB2rY/gH60hTV8t+/xBRrqiGS+7b9UWlRF9jkeudCneEHijfnitDVpZ/yK5/NUccwpWPkmWszh3UiQjJvQHZbdmU4+KX/MWxzs9Y7ydt/RPl9e3rt9gl/3FaIbA7B+VSBufwzx6CoHtzcpgnyqgBF/tnkffgDiwLQ=
Received: from BN9PR03CA0904.namprd03.prod.outlook.com (2603:10b6:408:107::9)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 16:59:49 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::22) by BN9PR03CA0904.outlook.office365.com
 (2603:10b6:408:107::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 16:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 16:59:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 11:59:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 11:59:46 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Sat, 27 Aug 2022 11:59:43 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <alexander.deucher@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/13] ASoC: amd: add platform devices for acp6.2 pdm driver and dmic driver
Date:   Sat, 27 Aug 2022 22:26:48 +0530
Message-ID: <20220827165657.2343818-5-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
References: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bfb7a4f-dc89-4efa-3a2d-08da884d8cda
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qg+6o1F+nelXaXC5VrVx+QVchR9Kn6fSpUaYgBr9pSBMiNP0hwbioooup5LHNp+XmI+6CJ7HCsfVR8WjXltKlwNSMeAskHIk9R0RmHx0eMmZvwOWEnw+cyXvWIXcw6PX0P0/dn2xG+zcCNZ8d52NtCK/iFAYXRc16AX1o9C/gRN92AQ8/nkkUZO4iktQsruW3zJSMwvmU/wM3GYZPEan4Z0Fh/ybvLbMHAQuXG8r8gmpDDabtXajNYgdTGIOor7+1tzB07uuodsBUd+dGQhTU8Fz0K6rrV/8GRMK414Dn8GGM7+sVdxjjEErqAu+nybgeW8SpAKiI+7rGrmv/Qgj5fXVl+7ZpzWOZlis9EfOEWa0RIN5iJKbusWilY/5XAv0fTxQ2q6ddKjUs7Yw8sG0EmV9A0rU0rUXKlXVX8w+QPKfEdCucG1c1cpY9bTHZ47OuPWYwEI05w2r+pMr9UjEhGNqnN8xEUoMpfv/g8HrCGUQSYRirFYs/F5r3UDrbCt9xj3lMUBiuCGyzDzG9EcARPQ9JQXtn6pb5LJYDA3e1jTprPO1HLAdBrWfXQ0++T22+fzbchY2nQX5mooSPR5xdLm6YaPSSVJvIx3x8bxN3a1OTgfixSThkUwEYz2c3Vw3OtBuyJGPoNPmh9rP6N00gz8/uDhYaHO2brceUBiZMV4a5tyiOk0yazQ1Ql0VlAkjgju5WJIOjOnLhQfzjUy64Y4D30AJuSg3fq8ZpIngkIFkGGmIrR/qeIeQN/Ff13jwY/Uy6mAnz7Uwa80KMRneh5KL4D8ai/WbuUFWr2M2Q62uR9SJOU/xPgWUar1ytrPN
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(36840700001)(40470700004)(336012)(1076003)(426003)(47076005)(186003)(83380400001)(81166007)(356005)(86362001)(36860700001)(82740400003)(2616005)(40480700001)(8676002)(40460700003)(4326008)(70586007)(70206006)(36756003)(316002)(54906003)(82310400005)(110136005)(2906002)(5660300002)(8936002)(41300700001)(478600001)(7696005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 16:59:48.2692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfb7a4f-dc89-4efa-3a2d-08da884d8cda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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
 sound/soc/amd/ps/pci-ps.c | 81 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
index 1f5e7d758f9f..79ad1bdb5b38 100644
--- a/sound/soc/amd/ps/acp62.h
+++ b/sound/soc/amd/ps/acp62.h
@@ -8,6 +8,10 @@
 #include <sound/acp62_chip_offset_byte.h>
 
 #define ACP_DEVICE_ID 0x15E2
+#define ACP6x_REG_START		0x1240000
+#define ACP6x_REG_END		0x1250200
+#define ACP6x_DEVS		2
+#define ACP6x_PDM_MODE		1
 
 #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
 #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
@@ -21,6 +25,25 @@
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
 	return readl(base_addr);
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index a87dbf8847e6..adad29667791 100644
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
@@ -114,8 +119,12 @@ static int snd_acp62_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
 	struct acp62_dev_data *adata;
+	struct platform_device_info pdevinfo[ACP6x_DEVS];
+	int index, ret;
+	int val = 0x00;
+	struct acpi_device *adev;
+	const union acpi_object *obj;
 	u32 addr;
-	int ret;
 
 	/* Pink Sardine device check */
 	switch (pci->revision) {
@@ -154,8 +163,72 @@ static int snd_acp62_probe(struct pci_dev *pci,
 	ret = acp62_init(adata->acp62_base, &pci->dev);
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
+		if (!adev)
+			break;
+
+		if (!acpi_dev_get_property(adev, "acp-audio-device-type",
+					   ACPI_TYPE_INTEGER, &obj) &&
+					   obj->integer.value == 2) {
+			adata->res = devm_kzalloc(&pci->dev, sizeof(struct resource), GFP_KERNEL);
+			if (!adata->res) {
+				ret = -ENOMEM;
+				goto de_init;
+			}
+
+			adata->res->name = "acp_iomem";
+			adata->res->flags = IORESOURCE_MEM;
+			adata->res->start = addr;
+			adata->res->end = addr + (ACP6x_REG_END - ACP6x_REG_START);
+			adata->acp62_audio_mode = ACP6x_PDM_MODE;
 
+			memset(&pdevinfo, 0, sizeof(pdevinfo));
+			pdevinfo[0].name = "acp_ps_pdm_dma";
+			pdevinfo[0].id = 0;
+			pdevinfo[0].parent = &pci->dev;
+			pdevinfo[0].num_res = 1;
+			pdevinfo[0].res = adata->res;
+
+			pdevinfo[1].name = "dmic-codec";
+			pdevinfo[1].id = 0;
+			pdevinfo[1].parent = &pci->dev;
+
+			for (index = 0; index < ACP6x_DEVS; index++) {
+				adata->pdev[index] =
+					platform_device_register_full(&pdevinfo[index]);
+
+				if (IS_ERR(adata->pdev[index])) {
+					dev_err(&pci->dev,
+						"cannot register %s device\n",
+						 pdevinfo[index].name);
+					ret = PTR_ERR(adata->pdev[index]);
+					goto unregister_devs;
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
+	if (acp62_deinit(adata->acp62_base, &pci->dev))
+		dev_err(&pci->dev, "ACP de-init failed\n");
 release_regions:
 	pci_release_regions(pci);
 disable_pci:
@@ -167,9 +240,13 @@ static int snd_acp62_probe(struct pci_dev *pci,
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
 	ret = acp62_deinit(adata->acp62_base, &pci->dev);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
-- 
2.25.1

