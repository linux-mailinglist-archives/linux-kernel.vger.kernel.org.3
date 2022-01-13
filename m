Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F4748DBE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiAMQf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:35:56 -0500
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:37917
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236806AbiAMQfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:35:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRlkvRX+7CCRov8v7NSVmp0qOEFSESkeX9u+/6rgxv69IPME1Djvl9xXLT9gYkJ0YQyGOB5cRWTI0CzMl3zP6ybBLXbun8PYrMIizIV+hGA2dSgOnUKpFKkqOgYPtwP7pqiM+9x9mC6JOBgZ8+6ltbD8tB8SFvqbiAnC1YBkzA6kg7ojTzKM9p2kWj1ktGcsA7+Aj+/hHmYOkjdCJIU2UmXac3gni6tJcFehlxdXpqUeaMcw1va6iMkdRDSdMG4DOR9etWfaRScu95t7rksqyqYhHbl3Cwvmv08KsN6nqPymAFdgd1Pw7iKjNLDRfoKEECYFsFMio2AlxcCXM4+Q5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMthq7As3IApvnsSwEpDVZShNtIoE5+Th3bp3BWlFsw=;
 b=jLjVJ34NaMfZgoMCF/SmU7iXrqZKru6YlKbjMO0NwOnnhZSexl2RuptTuiObmRWw5deNZfeWZw464aqHkm6skZhBKbltPAZ0OzttPhgQHXfQ26mDkCrKW9aJGDMFQwaZLWzWTCFJlUcwTv4Bp58iF0YoUbAGOC5QHajMIfjcHqnDmr9QHvjH4f/CMHA76bGeatTYR6ygUAhJ8dEFD7JaQhqqORc+p70seJStrcnYkahY4VAqOYIhpZdXgfur1nYeb08tT9LQEbV6ZSpob1CG+uy2pxDJcM7q0LkgVGZpL9MinNNN+77b5ofHTq3ifqlj5VqIDZhpOhpMmNpRA9cwLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMthq7As3IApvnsSwEpDVZShNtIoE5+Th3bp3BWlFsw=;
 b=uE678U5FaESVY/j87WyKVTjIDl724nBj6dpY320g0DSj1Cy81tlNKejvoMlvsqxoD8jHTzM57J5yjkSGIB3oY3hXBGqOmhoaH0hvp/hENPdBtFGltdZ4hjPOkb3VICYzDhptAV/jTipFHVv/HLaeAaA8SUQTiLT1QSC8gmXs7HE=
Received: from MW4PR03CA0292.namprd03.prod.outlook.com (2603:10b6:303:b5::27)
 by BYAPR12MB2679.namprd12.prod.outlook.com (2603:10b6:a03:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 16:35:47 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::39) by MW4PR03CA0292.outlook.office365.com
 (2603:10b6:303:b5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Thu, 13 Jan 2022 16:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 16:35:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 10:35:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 10:35:45 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 13 Jan 2022 10:35:42 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/6] ASoC: amd: renoir: Add check for acp configuration flags.
Date:   Thu, 13 Jan 2022 22:03:48 +0530
Message-ID: <20220113163348.434108-7-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
References: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5a4568a-2141-4ff0-612a-08d9d6b2c08c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2679:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB26798782DE1D8675DC31664F82539@BYAPR12MB2679.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tw6ArkgHRVw6B7Z5rILIcqpDHWQhahFUNxIEgEifo6B+y8C1272k1vSoVJ5dPG3+j2zgiP1KswaRM4qTE5/7lJSJ34RodKtkw0VkIcOpPgruRlxNTPqdrsnKDsOhaqc6XpR90qO3pWXbi24OcbqqszJqvKlVS9LClZjSmZzBCcnbeQaPOmyo1X+fi76KbrNK9zJNOUytubmOJfOVHHXD8K6+Ptfb+5iHvb/Ie8xaKVJ1BMqrMkk9ATshjCX6B9c9l0eTt9Mp/Vq8rSComXMajS3YzF101pFJ/Fgx5BROVkoqYaIGDazB+2J87yP0mYLOUX/RKIDaDIpQT54QSr12KN0UXR+NiJCA2Yi5gQed28cG/8/sFq2HvtoihPM1+PYutUZNR+BhR6QTiTqg8SG8cNdlONa6cCq8Ubpb/vTuxJDV4tS8MCiF9tSGQI9BVjWJV+DnuPFZk9nrOieuEvJQPlrWMhU0fvA+G9Ch8xqYJtFv96qR43E/bn0QZ9Mz8IR0iLWQfBoTr9fen2Xf7xs3GLbb37IpcB1I4NQ2CRahkdf9218SCXSRPR333w60Dj/TQ7R4PWlMrBn4V6D60+BTHL5lcTCEjce+0Qhe3glmtDSKavs93VDLO7otW/7et6QFFuIxKT8D1H3q6ab1hoeciKq/jjPmRcC5tdqlpQ6ElOQc633rqCRRKxEX8kitY9NqiHqVMjNziExYJqFr3pyRp/TLnsSRPm3tmvJbiSIDTjqR4sPmWd3zduWNpK7XzYMf6BCLPcdiO6ZbtlcOFfh4qOGxrPzyY4DcZHQOPHirBPs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(508600001)(70586007)(70206006)(86362001)(8676002)(7696005)(2906002)(4326008)(83380400001)(36860700001)(2616005)(336012)(47076005)(426003)(40460700001)(36756003)(81166007)(82310400004)(186003)(26005)(54906003)(316002)(5660300002)(8936002)(1076003)(110136005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:35:47.0865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a4568a-2141-4ff0-612a-08d9d6b2c08c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2679
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have SOF and generic ACP support enabled for Renoir platforms
on some machines. Since we have same PCI id used for probing, add
check for machine configuration flag to avoid conflict with newer
pci drivers. Such machine flag has been initialized via dmi match
on few Chrome machines. If no flag is specified probe and register
older platform device.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/renoir/rn-pci-acp3x.c | 7 ++++++-
 sound/soc/amd/renoir/rn_acp3x.h     | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index 7b8040e812a1..b3812b70f5f9 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -212,10 +212,15 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 	acpi_integer dmic_status;
 #endif
 	const struct dmi_system_id *dmi_id;
-	unsigned int irqflags;
+	unsigned int irqflags, flag;
 	int ret, index;
 	u32 addr;
 
+	/* Return if acp config flag is defined */
+	flag = snd_amd_acp_find_config(pci);
+	if (flag)
+		return -ENODEV;
+
 	/* Renoir device check */
 	if (pci->revision != 0x01)
 		return -ENODEV;
diff --git a/sound/soc/amd/renoir/rn_acp3x.h b/sound/soc/amd/renoir/rn_acp3x.h
index 14620399d766..ca586603d720 100644
--- a/sound/soc/amd/renoir/rn_acp3x.h
+++ b/sound/soc/amd/renoir/rn_acp3x.h
@@ -88,3 +88,6 @@ static inline void rn_writel(u32 val, void __iomem *base_addr)
 {
 	writel(val, base_addr - ACP_PHY_BASE_ADDRESS);
 }
+
+/* Machine configuration */
+int snd_amd_acp_find_config(struct pci_dev *pci);
-- 
2.25.1

