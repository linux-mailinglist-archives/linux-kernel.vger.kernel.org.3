Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5584C0D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbiBWHZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbiBWHZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:25:20 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B03675623
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:24:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHqz42/NpA47lZw6O/DzZuEDzDxSik2xT/fsSQkvI3/j+PawRaBn1v8sqLs8oolONG7Je9cKzAv3TRSIsj9YnA4curCcrNLTuzWBMWw5tIx2Fyfpe3pyw+IMps/S7PjFaRz1JYjpuxn3Ow+Kr/OxFf0TngAsW+yetdIxlZ4uGWFkQIRSmrnjJcv9Z9u1oinj+UIWLG4mFYUFmRxixxH9ekL7cjrMMN786LGYjPmxm1z1hByxV3PpMshn1TPPNj4mt/zT5WOPuVeBmp8RxNs48pmN1ZePt0DmPJL32YQsPKIFxKhIM7acWJuxhK6EkR70YflP/DlWeGLoMQFppsIC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qF5aFrLNUIZP6RUTzhtPYwChlMAZo7yzMXVp7fCOFeQ=;
 b=NkDRzwpw9S8JW8AGgtx6e/oUOxPr6RZZ9qSbhQ1CNoJV1Tg3fb0s4ZKW2bceBfHX4aZQuVjlxfzlkLdvhRaSfJ0fiaMaytsEjgblZFz0z4Iq6C2pigszaFxSYYUTwGarDS8wDCNy7it4O4FkX0LWaW4/3IXabVwQMSx52PGWVL31Chb/5Css2Rs5UBx7oNHZ4pJ8stZTiJ1+HtK/2pG2Aubdpf8HB6tcGO/Q7ArK2jD1NY2ipvXEy3X3JYQ3QRr9H5Mf6dRT3jyMI8nRfABHbUnwiQJGT2Xa4WPiVlpmHe4CDygpxlicTK5TQQDsQnCswnIWiH9LgHTWQzz6Kj1Htg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qF5aFrLNUIZP6RUTzhtPYwChlMAZo7yzMXVp7fCOFeQ=;
 b=kIenCyxBQ2ZkGYQT5gjeZ4kj+4gJJ7BJ7BfUN93UBwwRXBd0cJ3wyW0G/oVe8gPdbEJqeCQk53KBWXOzpwr4A8vuK0Oe/fNaYT4KmHx5wQH0NaQiIlRVmUHvqIX3k5jLUtrFV39T7Yw293J/6NhWYLkkl8RVypyU9xDG+/zlm00=
Received: from DS7PR07CA0001.namprd07.prod.outlook.com (2603:10b6:5:3af::10)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 07:24:47 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::bf) by DS7PR07CA0001.outlook.office365.com
 (2603:10b6:5:3af::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 07:24:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 07:24:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 01:24:39 -0600
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 23 Feb 2022 01:24:36 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>, <wtli@nuvoton.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/9] ASoC: amd: vg: update acp init and deinit sequence
Date:   Wed, 23 Feb 2022 12:49:35 +0530
Message-ID: <20220223071959.13539-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
References: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f97a476-cc76-47e9-8cac-08d9f69d9241
X-MS-TrafficTypeDiagnostic: DM6PR12MB3402:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB340249F80C6EF46C3F1BE5CC973C9@DM6PR12MB3402.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ks+u3OjHK4Yf1fWDlAoUrSzkiAXMSDwF5Z8gEngCr0UusUfoSXcw7YVo0eNgVVab++q/A+3e0Ip2518v+bzacO/Vm9xTZ1sCG3hFrvUNW3B2IONx+VudirG1FW8exDoH0TPSMmPrz5bUlIhsiHjpGHW0xLI+VCNlJBQ40rsHPfuOGVinwN4z0WJPlFQXzh+Rd5Ei9wcx0pYvOhODmX73zZT4YbZ3M2vez3RGRnhQ0ktJ0df/7UI2jpB1r89IGcwfAlzxvJu6ZKCv6GVa0mkNPQYlmBAKAiVOaztTh5jxmsZ4d7Nien5bjxeoFCIti7mihOQHzSjcbsGp6Uc7iEJFi2g8n59QpFsyQDbziXRn6cbg/gTU8BnZT+k8zhUNFdqgUxFbH4Wha9UaIPOFgzv3y2Xtw/OV3ny3HFq2yrTMfsXbUXHn+X5/iHFO8MAZ+gNEbct3IbFW89/XSO4jiyufaYkMTNRuVMgfXshIeMGjPsEdioxJsXqwg6nCA024emxCCvMiSdIox1PxmvMVfQao1DyprOZxmxozW7V4YSENdaZM+TVuDJWAk3LQ/cYAFLIbEp/9UMOv7O95b6OZl8bvvVKK4CZfNmw1VsWshjjU8ELZwEhYeXZxHUY8QC4JXrrTf4rfJp+UsJhs0fnv1fri6te9kUqFWThEpIwHGVsb75ojus5MBFahCKwq6XXv95zNtTaGTVwpgx29oOxeDN4KDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(8676002)(70586007)(70206006)(2616005)(86362001)(7696005)(82310400004)(15650500001)(40460700003)(2906002)(356005)(81166007)(83380400001)(5660300002)(36860700001)(8936002)(110136005)(54906003)(508600001)(316002)(186003)(26005)(1076003)(336012)(36756003)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:24:47.2766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f97a476-cc76-47e9-8cac-08d9f69d9241
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of ACP programming sequence, ACP_CONTROL and ACP_CLKMUX_SEL
registers should be updated during acp init and de-init sequence.
This patch updates register sequence during ACP init and
deinit.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/pci-acp5x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/amd/vangogh/pci-acp5x.c b/sound/soc/amd/vangogh/pci-acp5x.c
index 2b6b9edc36e2..e0df17c88e8e 100644
--- a/sound/soc/amd/vangogh/pci-acp5x.c
+++ b/sound/soc/amd/vangogh/pci-acp5x.c
@@ -92,12 +92,14 @@ static int acp5x_init(void __iomem *acp5x_base)
 		pr_err("ACP5x power on failed\n");
 		return ret;
 	}
+	acp_writel(0x01, acp5x_base + ACP_CONTROL);
 	/* Reset */
 	ret = acp5x_reset(acp5x_base);
 	if (ret) {
 		pr_err("ACP5x reset failed\n");
 		return ret;
 	}
+	acp_writel(0x03, acp5x_base + ACP_CLKMUX_SEL);
 	acp5x_enable_interrupts(acp5x_base);
 	return 0;
 }
@@ -113,6 +115,8 @@ static int acp5x_deinit(void __iomem *acp5x_base)
 		pr_err("ACP5x reset failed\n");
 		return ret;
 	}
+	acp_writel(0x00, acp5x_base + ACP_CLKMUX_SEL);
+	acp_writel(0x00, acp5x_base + ACP_CONTROL);
 	return 0;
 }
 
-- 
2.17.1

