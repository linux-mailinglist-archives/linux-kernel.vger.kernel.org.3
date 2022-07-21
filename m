Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041C957C443
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiGUGNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiGUGNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:13:02 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F437BE2B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qr7oKWhmeYPmyM//W5Em35SMG2f3WHdymHVbjjayLH3sqL8NtbfT3aLo0B94yNCxGNMerWxicmZ4QSFndp5FdXGiZTBJ/XTj1burnZGhRk7CRKZuz6lJX1Cn7oCgcKVIDSljbxW4M9ypSZZKwKgpqNxhXY45YhxU0k6SN5dYGISmW+GrScIF2/9F7qfqLIrzaWRXy8RtyKmUbwNlP3bgirU4IYv30VxkQ5EBWgPD7RuB2nLkrcJG/PQe8UZ3BzST4t/3j16Mb/aLSPb/BUjmGxhAIPZjRQpjJ2Ihf4Du5Wki9xm017ghjip622r42qPgJjqxL1iCzAthfj/9zqBdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I26mgX95nboKQprXCEu0ow4pktR9sdk2HQm/H+dhv8U=;
 b=V/HqOSZ+A99zcSS4IWF9+S6h6La0KH5OFjesB+Fnx+pRjaYjY01JzDBfl96MSZItnwaFTWx+5RyeySGj1Tb7oIOlibgl2ugC7DTwXh9SVHIdbENkMnL7ObgPgEitb71mcrOeP268FT/2/cisoF1Lz3fuBIVXE9w/yEA1B2eTMtj3hvtyMJY0dW1og6OfMMXbzjlIVCcqQYrFIBqfZECirZAmG3UbRJv8mt4OlRNl1oHuncJtlSyO/DovjhebemOyOBzshJuzJLQvQnfOI7mTAxj6PD+VGCvBXY0XEIz9/vZxtjaBuzOqifwAXjaX6PP3XkzA6js0i2mHEwRIsbgiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I26mgX95nboKQprXCEu0ow4pktR9sdk2HQm/H+dhv8U=;
 b=jYMiF+7xf59hJUoYUizFrnU3eFq8pgTTVdQdxINF0rrhYmMBYH98P6bsRWyd7DrZAH0TWMymZWFyF8edqnNaoJ34sCzbI3EPfwnXWNyCUJt+/M5CN1M/rr5YPrQWjYWiX5ocA+el+2Ty19qyWiPSe4vHk77JoDU7786hfYgN9ls=
Received: from BN9PR03CA0633.namprd03.prod.outlook.com (2603:10b6:408:13b::8)
 by BN6PR12MB1538.namprd12.prod.outlook.com (2603:10b6:405:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 06:12:41 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::b2) by BN9PR03CA0633.outlook.office365.com
 (2603:10b6:408:13b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Thu, 21 Jul 2022 06:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 06:12:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 01:12:29 -0500
Received: from amd-Z97X-UD7-TH.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 21 Jul 2022 01:12:21 -0500
From:   syed sabakareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <vijendar.mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] ASoC: amd: add RPL Platform init/de-init functions
Date:   Thu, 21 Jul 2022 11:40:00 +0530
Message-ID: <20220721061035.91139-3-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
References: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bb87649-a779-4949-2528-08da6ae004fc
X-MS-TrafficTypeDiagnostic: BN6PR12MB1538:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyctmtJmteEoqz0eJ2rhe25xSNBCYMpIa4OOagZt51wyTDdncdJ03i4pqjeGvkoxNTkQWpFKqG+oyCBeWnhRZON83t8LDloYIeFAW7OuqXa/+HGCT2LY0++U0pfEtdT3RFXC7/pUd2vMb37AyWlVsefYqv7hE/VvO1UacvcoIYmSfnrl1t6YqLatqq7OCywsK8GpiZR4rPagHn0YDUEGMPq94PPufTwr6s7FABhYXRiYY85PU37N386qrPdsf/rhDsmiFWHAYFY6qfoL8KJVVH9e31RYgCpriImuI6D2BSRZx9eJKrgA/Ds0chSmRlp2qifhaTWrUEd/vxtHzkSOduH2Q9tYbn1fiRpd0IHZfw7TQ8QpTOT/gVNE01Iq5xBoPhXyDtEm4MKVSwYDh+cXXvPQNBaZEwOOxhEOpRWSBPtCUFg/mtixOVMn7k5Fr5wTEvy65hwoMWul8sA7WP4uq1ojdCUkuaiBHWtrMi+73MOsecL6/bDQJ4+3ZuGWSXMd3UWuiGFnq1M5rlAMilpHvHOpA230qn9ZXal6gjUFkrdRJQlY+kBr1PLBtiKLAtExu6qb8OjpY4ncVojbOrIJlXbGQFAZhIn4XXO+1TedRew/WGTaRgCnFxix7iXDdcm4sjapj45gUNxDnJ1jb8CmNEIBloCA86MRV7n9lZbY2S3UeQ+kiG3FBogR4KvFM8lmYI87JfX1Il+99FKMqyca+omvYR8WVp+cgOonyS503TmZ5yktBiuav5ePn4dPevd1cyDKLBrkT4dzyNo7Tx7BSMJEagx2yypdwSgyA3gEcuj1Gzf20FAkbjwgw4rlZi0o1Bza5xnYmpRGAJMfQorQoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(346002)(40470700004)(46966006)(36840700001)(41300700001)(6666004)(5660300002)(7696005)(26005)(8936002)(81166007)(356005)(82740400003)(47076005)(426003)(186003)(336012)(478600001)(70586007)(8676002)(4326008)(1076003)(316002)(70206006)(36860700001)(110136005)(54906003)(40460700003)(2906002)(86362001)(2616005)(36756003)(40480700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 06:12:41.4573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb87649-a779-4949-2528-08da6ae004fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1538
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

Add RPL Platform ACP init/de-init functions.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/rpl/rpl-pci-acp6x.c | 92 +++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/sound/soc/amd/rpl/rpl-pci-acp6x.c b/sound/soc/amd/rpl/rpl-pci-acp6x.c
index 7a82a978cf24..71ae90a00f36 100644
--- a/sound/soc/amd/rpl/rpl-pci-acp6x.c
+++ b/sound/soc/amd/rpl/rpl-pci-acp6x.c
@@ -17,6 +17,88 @@ struct rpl_dev_data {
 	void __iomem *acp6x_base;
 };
 
+static int rpl_power_on(void __iomem *acp_base)
+{
+	u32 val;
+	int timeout;
+
+	val = rpl_acp_readl(acp_base + ACP_PGFSM_STATUS);
+
+	if (!val)
+		return val;
+
+	if ((val & ACP_PGFSM_STATUS_MASK) != ACP_POWER_ON_IN_PROGRESS)
+		rpl_acp_writel(ACP_PGFSM_CNTL_POWER_ON_MASK, acp_base + ACP_PGFSM_CONTROL);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = rpl_acp_readl(acp_base + ACP_PGFSM_STATUS);
+		if (!val)
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+static int rpl_reset(void __iomem *acp_base)
+{
+	u32 val;
+	int timeout;
+
+	rpl_acp_writel(1, acp_base + ACP_SOFT_RESET);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = rpl_acp_readl(acp_base + ACP_SOFT_RESET);
+		if (val & ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK)
+			break;
+		cpu_relax();
+	}
+	rpl_acp_writel(0, acp_base + ACP_SOFT_RESET);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = rpl_acp_readl(acp_base + ACP_SOFT_RESET);
+		if (!val)
+			return 0;
+		cpu_relax();
+	}
+	return -ETIMEDOUT;
+}
+
+static int rpl_init(void __iomem *acp_base)
+{
+	int ret;
+
+	/* power on */
+	ret = rpl_power_on(acp_base);
+	if (ret) {
+		pr_err("ACP power on failed\n");
+		return ret;
+	}
+	rpl_acp_writel(0x01, acp_base + ACP_CONTROL);
+	/* Reset */
+	ret = rpl_reset(acp_base);
+	if (ret) {
+		pr_err("ACP reset failed\n");
+		return ret;
+	}
+	rpl_acp_writel(0x03, acp_base + ACP_CLKMUX_SEL);
+	return 0;
+}
+
+static int rpl_deinit(void __iomem *acp_base)
+{
+	int ret;
+
+	/* Reset */
+	ret = rpl_reset(acp_base);
+	if (ret) {
+		pr_err("ACP reset failed\n");
+		return ret;
+	}
+	rpl_acp_writel(0x00, acp_base + ACP_CLKMUX_SEL);
+	rpl_acp_writel(0x00, acp_base + ACP_CONTROL);
+	return 0;
+}
+
 static int snd_rpl_probe(struct pci_dev *pci,
 			 const struct pci_device_id *pci_id)
 {
@@ -59,6 +141,9 @@ static int snd_rpl_probe(struct pci_dev *pci,
 	}
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
+	ret = rpl_init(adata->acp6x_base);
+	if (ret)
+		goto release_regions;
 	return 0;
 release_regions:
 	pci_release_regions(pci);
@@ -70,6 +155,13 @@ static int snd_rpl_probe(struct pci_dev *pci,
 
 static void snd_rpl_remove(struct pci_dev *pci)
 {
+	struct rpl_dev_data *adata;
+	int ret;
+
+	adata = pci_get_drvdata(pci);
+	ret = rpl_deinit(adata->acp6x_base);
+	if (ret)
+		dev_err(&pci->dev, "ACP de-init failed\n");
 	pci_release_regions(pci);
 	pci_disable_device(pci);
 }
-- 
2.25.1

