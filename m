Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE415A3908
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiH0RBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiH0RBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:01:10 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADB12AE3A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JN/OOAUoBa5vMyT7BYQzvJ7ujV4N20P9XAviWju9eOJgz1NCaC3uw2MSJWqhKrhcYVT3a0YHRGj7+0koInpsHRlgF3veIx+zXfMD5RrGGx+Zt2fVw0ETcbTByiXn6LtZEy5DfmIytbBIzFiCcOL8RRa3XN0hqEyjM2nHiiueCFgcP+JXIpuay2KSiUzLSrzYggf4xJY5qzdb3zGMmm8m/NpS+DCYCEi5FExEgnObfz+1bQfBUVQ+sjARnYdP/oR5cx8Vn9YAFQH81Wqbu3wP1Y0cGJA7VLB3GpsW7MbE6NgsO2ZE14qTItv8L53cHN8r7JKdny3QeAvu3U1iSp4Gyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWsqTp3JjopfvN6pja74ulXjVHjiAtsPGjew8/PpDO4=;
 b=TXKIB5e0Oc48OORPA8UHI9jS/XkUxWYdKF8ZQA3zFg0agUEy3mKirzFQsmOo0JHI+0sXjs9nZYaam+TVbyN3BAFV+LxJ0ONps4VC0VnYojQ/INAVqVo1zHsD7dKP9KDAplZSr/Rsl3fVAaAOmVNJBYRbKuQESOMAF1W2Ft36MY9mbkPVp/lE5IXEVH1laKI6fgF3k1ng1OgIYvpQ4F7O92UDolCd8jwTWyEyMXP+9MsgGEZs3dXfID6PkQsqIW4ly+7wVvoE/zGRmrM03fT1cIMYduEI6lhVAVkOSISiVIQlybg5tbmjAOhLjU9LUNSxXVml0wWq7eSq0GhdiHbVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWsqTp3JjopfvN6pja74ulXjVHjiAtsPGjew8/PpDO4=;
 b=V856GmCkpHTlIhg+R18A/+oGRPfvV/arumHn6RrYT60PWXTM2GMG18nrmz/VkXxmEWVvQuPTXzqjOaJkjhWNHYddObTetPDg9eaUluP4vnCw0RBm4Kfjxa95cO8/sYSS47IwkkOmYx9RUqyTuP90MiouzoJUg7IPYHqhOzeKe8Y=
Received: from BN9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::23)
 by CY4PR1201MB0151.namprd12.prod.outlook.com (2603:10b6:910:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 17:00:57 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::6e) by BN9P221CA0024.outlook.office365.com
 (2603:10b6:408:10a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 17:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 17:00:55 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 12:00:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 10:00:55 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Sat, 27 Aug 2022 12:00:51 -0500
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
Subject: [PATCH v2 12/13] ASoC: amd: add Pink Sardine machine driver using dmic
Date:   Sat, 27 Aug 2022 22:26:56 +0530
Message-ID: <20220827165657.2343818-13-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
References: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83020c03-326f-43b7-baaf-08da884db521
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0151:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8B1hRD28cFULcBCxEBQ89SukpDwBaxDa6LV9AvjaJdyiHlUOS5+7JfFNVvzvP7V2cUCt/IPyKU1oB7Ebwoc8ax7+EqWxwBiyqzHextjoq4aEaRmaQCGQNO/04oYT/Iydm94YkjZQI9lD9g58tOicR17jvaf4U8Hy7NzWpqeycYkSSUqUWhgFdY8HTTq1nBbAwi7U24VEEd3L3nJTdOYUU4tkeEUNrXK2OAJUsYh7XQl//jPByQhXHlv8ujYcsufLEyVLblAxe5C/ReWfHG3t5Mis60T/lOMGVaui/t98RdsbWR5cNMoEjdz2ZXkFXzHKXntqiFnwPhkqCXJJNKzsWarotwio24gY4axVEFV5ySmQMIc/STSNLLYSVKh58oSl4zUXQdOdANZL9MNEg4piMPoV6Hx2adMZMOT4QTF+jnHMlzftcnZoVvtkyb1AmrRkDIu9nIFtRJUrjceKTVigSEWcGJbDdhQ+ouLS8xU13/37SGQKDFtLSnjyC3c0dNHSfrCeeWGSB241MQ1PHNlmQl+E6iXqWMh7q8Fvbi1e2yDmJ1/IeEsHmABPbDIgYuXqpWLdQSjVHKpFT+Ep6DBxaUi2Tb0Cwv3Odfzm3WhKfJNiMmP0e59ljdxs4s3gsYx5hclTtmuDMWQ2FSalYXWyNPdGqOwPlIu0FGnDBeSfduz/F4clD9OJKkCURIaICyAfMSc/rZJXs6tp68aACNvzdfeMQD90vje3G8/yCXzSHQvpHJ0/Oauj1MMksvV/qvXuPpTRQNl0FRmBbGAsE4Boo93EG4rJSIEz/popJTkVVm8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(40470700004)(46966006)(82310400005)(36860700001)(40480700001)(86362001)(478600001)(356005)(82740400003)(70586007)(81166007)(8676002)(40460700003)(70206006)(8936002)(41300700001)(110136005)(5660300002)(54906003)(4326008)(316002)(1076003)(336012)(186003)(2616005)(47076005)(426003)(7696005)(26005)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 17:00:55.8467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83020c03-326f-43b7-baaf-08da884db521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0151
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
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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

