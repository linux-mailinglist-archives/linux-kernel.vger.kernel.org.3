Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B90591087
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbiHLMKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbiHLMJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:09:49 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845ECB0293
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4HEKFjXTjSCuiZ2kYhWc22xqrWkC3UnqQDjnYZeRPyp8Cw8P7ceAzgJKhCv9En4JqEIkYGvWmlhPGHYTd/b/P3n3oo3gzX5GEODuVPlSsD9TdIkDy8o6lv/XZS+SimrKoiZgyHISyjsxeUC5bP43lNAfygecfDYc23HJT7H8VucKFUfbkzm2bMANt54dHGtkYm27HtRDo7Xs2iEGMgUIR1FgBcocOuyHCYveVxY+nwFLbnSz1wocDUCpxz5Z+TcqAOe6Jd69sm0AnY7gMvuBqQ+e6DfpnNn6LcSdertJCrSX2UY0K10Tkd/yBjCo0/ZQBtvNKLA1Gs+0cYHL1cFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSodsCWLq8cKlT9dmO2RxckzbB3LTH3xiAQpdUwdaGg=;
 b=AOYuGYGg/ltwoLA05jipjo9lIUMf9zyQB6qoaMDp6rGcXi0BNHY816fGvIpfg4+ei1NYN7h30n9c44QDIaiE8m1tfTkqHQMY5X6smHgyeI0fJycebVdPyYL+4Jy9BknBTDsdVupqv3PclOjkZU/KS0SLhhpeEsAKeLKPe4MDuCndQQXtF8UC1RJucvB+XU5e8IsWuQPsaQVtcmomXCGxXcdA+vJsulyEe59hmuDWh9viFgGK69MqNgDcAafrx29KK+ZL0Ti/6gq6L8eyUAGzDsu1+09WeUs9Er7eK0D61p7Sc8aY6YtCzgqTCKwPceV+/HyqZFndr94kF83b8iHlKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSodsCWLq8cKlT9dmO2RxckzbB3LTH3xiAQpdUwdaGg=;
 b=sIYvJGtB4peLYMs8FE7WwHD5ixJT5+ojiyYI8pBGksK9zcoWl1UN3yGd9fDGKvg8WhWbbq8gXOEOcOkwiReHaGTh4cMtwV+LJsnDVV2hEp0v1ZY2bpBhsyvSJ5Da57lq+Ykw2eyvF+JLXzTjRyt65r7sc8FdkihVfRVhI21yF8Q=
Received: from DS7PR03CA0239.namprd03.prod.outlook.com (2603:10b6:5:3ba::34)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 12:09:45 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::af) by DS7PR03CA0239.outlook.office365.com
 (2603:10b6:5:3ba::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Fri, 12 Aug 2022 12:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Fri, 12 Aug 2022 12:09:45 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 07:09:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 05:09:39 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 12 Aug 2022 07:09:35 -0500
From:   Syed Saba kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/13] ASoC: amd: add acp6.2 init/de-init functions
Date:   Fri, 12 Aug 2022 17:37:21 +0530
Message-ID: <20220812120731.788052-4-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8493c472-3231-4c66-8d13-08da7c5b8bd5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4112:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OIEda1KyeMABPuKbkHP8AWidetqMihvwARNOaSO7WbTUcrgJnwcJ8IKGo6UHA3LvgMtnhpbDakGAX4HjFpFQxpI/5Ld2ymjoc5fx972QVoqL52fPYoJNcrtRer8il98LG6Y3Iu0UeBWyX/qgh/kjcoYd7Tapn6lZgmN6pUgLbN4E0TTjelfEZvTKh7IIxVO3nW8uXfjHGnLAoH6DPWyvhllqkEjOOnBgVJ1H6IZzYJfODEDvziHfzLEq+6DyY+qkN8+RJW8sDKNFNimoz9L7MWjeT2u6Z1q0NWtCjJHKhLkFq91n8Lc4hQBCKiBDrQdVgLKShNy6PIH4VCfrJqjW8In9XAv5EFdE6OO4iLqW2KNrBDVkGedS+tUFpDamdMJMggpB88bGXQovfeXdOYkzBgtypVpECn1a8WJcx/E6G9u+AMhBBQfkn0tdk3Zm4S6v9hi+tILk38cuJ6+jKbgSctEDOwmOFGshJCoIRf5jmO78oDRLqG/QjMpn4yTUKey6amw02hsBS/tSnuQNoRtmswrIvwcxwVCY4eSl6PqUPj7Gzc833q7CAnMif/gxkjNirs3bFLwD2D4mdtsL32fw/bl94Cr0gd2SfSbSv2vkwtdAISlujODvgObkINGQSMMy3dMV4CMAVQ5QnHjl+RmRfyWu4S42bkFVW+mJF71BIQzGGVfuujTl/GAbOwOq4tK0C6ExEzVKyddKmRQs1SSOXzM8XfqdGCNqqxuBSjpUsbCNE+UsRZ8wfKXZm3vJ08pRKzK8Bm45eBh0fJVAaGhOUhmavqlrZjoZNUhQiC5af/0fzJX+LUTIjsnRKNh0WQcOn9Cx1lu8Ffi7v3f+GqUP/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(40470700004)(46966006)(81166007)(82740400003)(86362001)(356005)(36860700001)(40460700003)(4326008)(70586007)(70206006)(54906003)(316002)(2906002)(8676002)(8936002)(5660300002)(40480700001)(41300700001)(110136005)(82310400005)(26005)(6666004)(7696005)(336012)(2616005)(186003)(1076003)(47076005)(426003)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 12:09:45.5305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8493c472-3231-4c66-8d13-08da7c5b8bd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Pink Sardine platform ACP6.2 PCI driver init/deinit functions.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp62.h  |  12 +++++
 sound/soc/amd/ps/pci-ps.c | 109 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
index e91762240c93..8e734f190b11 100644
--- a/sound/soc/amd/ps/acp62.h
+++ b/sound/soc/amd/ps/acp62.h
@@ -10,6 +10,18 @@
 #define ACP_DEVICE_ID 0x15E2
 #define ACP62_PHY_BASE_ADDRESS 0x1240000
 
+#define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
+#define ACP_PGFSM_CNTL_POWER_ON_MASK	1
+#define ACP_PGFSM_CNTL_POWER_OFF_MASK	0
+#define ACP_PGFSM_STATUS_MASK		3
+#define ACP_POWERED_ON			0
+#define ACP_POWER_ON_IN_PROGRESS	1
+#define ACP_POWERED_OFF			2
+#define ACP_POWER_OFF_IN_PROGRESS	3
+
+#define ACP_ERROR_MASK 0x20000000
+#define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
+
 static inline u32 acp62_readl(void __iomem *base_addr)
 {
 	return readl(base_addr - ACP62_PHY_BASE_ADDRESS);
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 25169797275c..2014f415af15 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include "acp62.h"
 
@@ -15,6 +16,103 @@ struct acp62_dev_data {
 	void __iomem *acp62_base;
 };
 
+static int acp62_power_on(void __iomem *acp_base)
+{
+	u32 val;
+	int timeout;
+
+	val = acp62_readl(acp_base + ACP_PGFSM_STATUS);
+
+	if (!val)
+		return val;
+
+	if ((val & ACP_PGFSM_STATUS_MASK) != ACP_POWER_ON_IN_PROGRESS)
+		acp62_writel(ACP_PGFSM_CNTL_POWER_ON_MASK, acp_base + ACP_PGFSM_CONTROL);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = acp62_readl(acp_base + ACP_PGFSM_STATUS);
+		if (!val)
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+static int acp62_reset(void __iomem *acp_base)
+{
+	u32 val;
+	int timeout;
+
+	acp62_writel(1, acp_base + ACP_SOFT_RESET);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = acp62_readl(acp_base + ACP_SOFT_RESET);
+		if (val & ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK)
+			break;
+		cpu_relax();
+	}
+	acp62_writel(0, acp_base + ACP_SOFT_RESET);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = acp62_readl(acp_base + ACP_SOFT_RESET);
+		if (!val)
+			return 0;
+		cpu_relax();
+	}
+	return -ETIMEDOUT;
+}
+
+static void acp62_enable_interrupts(void __iomem *acp_base)
+{
+	acp62_writel(0x01, acp_base + ACP_EXTERNAL_INTR_ENB);
+}
+
+static void acp62_disable_interrupts(void __iomem *acp_base)
+{
+	acp62_writel(ACP_EXT_INTR_STAT_CLEAR_MASK, acp_base +
+		     ACP_EXTERNAL_INTR_STAT);
+	acp62_writel(0x00, acp_base + ACP_EXTERNAL_INTR_CNTL);
+	acp62_writel(0x00, acp_base + ACP_EXTERNAL_INTR_ENB);
+}
+
+static int acp62_init(void __iomem *acp_base)
+{
+	int ret;
+
+	/* power on */
+	ret = acp62_power_on(acp_base);
+	if (ret) {
+		pr_err("ACP power on failed\n");
+		return ret;
+	}
+	acp62_writel(0x01, acp_base + ACP_CONTROL);
+	/* Reset */
+	ret = acp62_reset(acp_base);
+	if (ret) {
+		pr_err("ACP reset failed\n");
+		return ret;
+	}
+	acp62_writel(0x03, acp_base + ACP_CLKMUX_SEL);
+	acp62_enable_interrupts(acp_base);
+	return 0;
+}
+
+static int acp62_deinit(void __iomem *acp_base)
+{
+	int ret;
+
+	acp62_disable_interrupts(acp_base);
+	/* Reset */
+	ret = acp62_reset(acp_base);
+	if (ret) {
+		pr_err("ACP reset failed\n");
+		return ret;
+	}
+	acp62_writel(0x00, acp_base + ACP_CLKMUX_SEL);
+	acp62_writel(0x00, acp_base + ACP_CONTROL);
+	return 0;
+}
+
 static int snd_acp62_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
@@ -56,6 +154,10 @@ static int snd_acp62_probe(struct pci_dev *pci,
 	}
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
+	ret = acp62_init(adata->acp62_base);
+	if (ret)
+		goto release_regions;
+
 	return 0;
 release_regions:
 	pci_release_regions(pci);
@@ -67,6 +169,13 @@ static int snd_acp62_probe(struct pci_dev *pci,
 
 static void snd_acp62_remove(struct pci_dev *pci)
 {
+	struct acp62_dev_data *adata;
+	int ret;
+
+	adata = pci_get_drvdata(pci);
+	ret = acp62_deinit(adata->acp62_base);
+	if (ret)
+		dev_err(&pci->dev, "ACP de-init failed\n");
 	pci_release_regions(pci);
 	pci_disable_device(pci);
 }
-- 
2.25.1

