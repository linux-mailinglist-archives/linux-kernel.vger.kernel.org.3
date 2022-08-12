Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB3959109A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbiHLMM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbiHLMMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:12:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0E3B07C5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuveRyRT1ecXVRCSAkdJfsjfTH9o56O7FmAST3swRGJr+/7/StLjCZ5QhOVoOOefyWV1yQJjQgRZxEky8dkZmGtbREVBDNWAeE/txJstMh19ehBYSo7N1jx30PV8jHf2vmsSt0lBS411ZSBdSs7ljWcX5okZc3GIc0iN3zYN/OdpCYOdzyoF+aEo5AucbZFk8iUb6/GbCCy9hXSZej5u1iPlNH1f+k8Y3H+0Afu2YVAJk+sMoBddWhTZhwdT3n7mVTcQ4C6qAXDayzeRn35Fq74+N14Tbk3zV6xmIRSgF8zCVoots455X+BDFXRDfL4JDuRELamvtpMsHikeK5nwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2Y+fRwSLjjLdm0IyPj2ENAMmdbfBK9N9z1KN9I0P24=;
 b=ORWtwA7FA5WhzAzhgi8mZNVltX8py1QtuMwkp0EM5qKvPvXkMbjK1PGO0HmOvJD9xm4G4IBV/LUjim2iVjef3sCnapKW8f7YJaYg8C3j5ApazSF7dbqea5AW83XrzQjOr4vInl/wSr3hG/vwZ9b1PLCSPr8YVCFsPaFeMWTzY6uDrlBdceCO5lozzpDnHs/GBtONLHvzCC+OmYbFozmPkuf5RQjG8/qAr981ojySR2Q/dcbWJmJWXkrN53Ow7843T37j4NUIHillhseuB9irMG6Lo6LBy8R1yjpMtleTtusUFHl+P/S5rgagP9bYywAvL+ba56wl9n8VmN90oblgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2Y+fRwSLjjLdm0IyPj2ENAMmdbfBK9N9z1KN9I0P24=;
 b=FLgZ+oflR2Ackx1HMfee9zRIJqPz6FXOw2V5wu0WEPpz0F9ZRpIjGh0HrlPK3F3WRp88Iw+iaKPfk8Kj2bZmGg9rVzUcfCl9m5staPByzxcGCxidNN7XDElaxug3xTsDOSNbMNmdHjiIzq8Y3I0OHa28Hqsq0IkS1TyYguyUMp8=
Received: from BN9PR03CA0272.namprd03.prod.outlook.com (2603:10b6:408:f5::7)
 by MN2PR12MB3968.namprd12.prod.outlook.com (2603:10b6:208:16f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 12 Aug
 2022 12:12:07 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::d2) by BN9PR03CA0272.outlook.office365.com
 (2603:10b6:408:f5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 12 Aug 2022 12:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Fri, 12 Aug 2022 12:12:07 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 07:11:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 05:11:38 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 12 Aug 2022 07:11:35 -0500
From:   Syed Saba kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/13] ASoC: amd: add Pink Sardine machine driver using dmic
Date:   Fri, 12 Aug 2022 17:37:30 +0530
Message-ID: <20220812120731.788052-13-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d6e2f03-b87f-46dd-f3c4-08da7c5be03b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3968:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxUuvW/EQSQ8eimdl4Hup41Ja7XNl4nKHn+aJAUotdWyAcYJ9PMsBavHbcNKlBxWwXV8aSJRLNp4gEsMUB5cZnUnbBVA0oKFiDDasRiXq9PjjcFR02ZpxF4Dxw98UZogzG2EUc6MhC9qGMjrS2DOFdldXclrTtat9BYTWnJy2KWBSKtGdSPT/Nghkob1OZ37dBLc2tqufqLSJoxx2Om3B0LFb3koQzNWgHFenXzMygUzWyUvn+QtOD1oS54T3F3EpRT5TJ98qoa2ju3gQIV0aYNGRt23eYverglz0MGSnI8AeaPgR9jhB+we/X1PXEkOm105g21/PWW4ImQP8bM5PycWZaRnfPppPYagUo5CyuF9PNaQGOjGciYZOdj0gDdIoE7drYunBYpVm91y4dbKb1913T1bC0OBYkT6k16gCsrTqMT+SZq7EUjlPqPoPOJ4DazOexU0xkFhu/yyv0TMGX1ll4Ow9Cnu41Yb12BjqBdsUSYsSV8WzXvixNQFQ1Q5RBO9X+8gVYi3tGOvM/+0WRCQocHJlYZoOXLvonEOPcKgY25XVePbdHxkgEpNrsIJEerdqKrlPTeFFS2WkUl/V+1X2a1O1SxOiBuZikL5WT7JgHN0HFOh3dzgWeioN+Y/5vJwrYglgdLNBUx6waT7XCLdH34sDDClNzmW42sfn9OsGZB7V5420mKAxq8ABeSsLmXWqA+VdPCEPSvchiUYL7hZPPW+EGay0+AZ/BODh0GHZRFfEhs8v4kW6CFACnURmD9ilcp9Ge6AvoHs4aUh4x+QjerkMAXfiOzHil/bq8kERYBzKkRzcFlsU8z3l/Mc12+n350xtUifBPx9Uw6KmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(40470700004)(7696005)(82740400003)(81166007)(41300700001)(86362001)(356005)(26005)(36860700001)(336012)(2616005)(186003)(6666004)(1076003)(426003)(40460700003)(47076005)(5660300002)(8936002)(4326008)(8676002)(70206006)(36756003)(40480700001)(70586007)(82310400005)(2906002)(110136005)(478600001)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 12:12:07.1615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6e2f03-b87f-46dd-f3c4-08da7c5be03b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3968
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Pink Sardine platform machine driver using dmic.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/ps/ps-mach.c | 79 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 sound/soc/amd/ps/ps-mach.c

diff --git a/sound/soc/amd/ps/ps-mach.c b/sound/soc/amd/ps/ps-mach.c
new file mode 100644
index 000000000000..b3e97093481d
--- /dev/null
+++ b/sound/soc/amd/ps/ps-mach.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Machine driver for AMD Pink Sardine platform using DMIC
+ *
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ */
+
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <linux/module.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <linux/io.h>
+#include <linux/dmi.h>
+
+#include "acp62.h"
+
+#define DRV_NAME "acp_ps_mach"
+
+SND_SOC_DAILINK_DEF(acp62_pdm,
+		    DAILINK_COMP_ARRAY(COMP_CPU("acp_ps_pdm_dma.0")));
+
+SND_SOC_DAILINK_DEF(dmic_codec,
+		    DAILINK_COMP_ARRAY(COMP_CODEC("dmic-codec.0",
+						  "dmic-hifi")));
+
+SND_SOC_DAILINK_DEF(pdm_platform,
+		    DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_ps_pdm_dma.0")));
+
+static struct snd_soc_dai_link acp62_dai_pdm[] = {
+	{
+		.name = "acp62-dmic-capture",
+		.stream_name = "DMIC capture",
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(acp62_pdm, dmic_codec, pdm_platform),
+	},
+};
+
+static struct snd_soc_card acp62_card = {
+	.name = "acp62",
+	.owner = THIS_MODULE,
+	.dai_link = acp62_dai_pdm,
+	.num_links = 1,
+};
+
+static int acp62_probe(struct platform_device *pdev)
+{
+	struct acp62_pdm *machine = NULL;
+	struct snd_soc_card *card;
+	int ret;
+
+	platform_set_drvdata(pdev, &acp62_card);
+	card = platform_get_drvdata(pdev);
+	acp62_card.dev = &pdev->dev;
+
+	snd_soc_card_set_drvdata(card, machine);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret) {
+		return dev_err_probe(&pdev->dev, ret,
+				"snd_soc_register_card(%s) failed\n",
+				card->name);
+	}
+
+	return 0;
+}
+
+static struct platform_driver acp62_mach_driver = {
+	.driver = {
+		.name = "acp_ps_mach",
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = acp62_probe,
+};
+
+module_platform_driver(acp62_mach_driver);
+
+MODULE_AUTHOR("Syed.SabaKareem@amd.com");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.25.1

