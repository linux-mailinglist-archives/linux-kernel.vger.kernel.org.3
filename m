Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC1D47C39D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhLUQSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:18:42 -0500
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47]:28710
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232032AbhLUQSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:18:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3WlC9nRJDT1HTrsxu9kgqCXtm3IUSnB32URbxRGy4o1oe5CIdl19b4wWImlpe+SUmGY/2/yGYlWdrmR0SVseoVkaMBUOWNk6lprdhyCykrDQK9y5VrefQqx+xm/6FMyKDmxeDunDx+qVWDTepEy/nygblAMc8rgsk54my1tb2IoKBjPxI6SRYL6Cw3uKUCOWGzbwWDymDEU1Tnl6uDTdVa50FWeDoiBja9ZH6AEezRAAPV3U43OjCRaCm1hFLrjhl6sp9lJjWC3UiCO4sqZKJ3FqgswUKaBELpWfrlIR1Gzjckxgz8BQ92i7vbCYElYZamQvSpnsmSMj6DOEghe+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0JhfL/tWlEZs/2BnC5c+vVm4l5UDvIAgDih3fuPBcY=;
 b=cKMNuo0yBzJIq/UjELknHr17qEcmK52v27XwZo0MdwSp1fGtPeVjkqg/beT4ynz4asd60VvIs4NJx8sJT3wkLQi0Q1oFPpwPwxDwOlJZd0LvT/6JFgcsQZBO+x2QKQwjDdoYh99CTf+1dQAl2nGPIwHb0lfHed6TvZYPgHKllc8dCGKuGuYVB5xWcfnROlkQKhieppChhb4lsfGPGubr4rpzf/sNFW7PlSAa0MlIDE+y8SL4N2gfIZqxd98ks3ezPG+FNCmzS1ESI3SKSgYFFF0IpWhphqib3B8a6eJXPgrypjulVn+joATxZXTo+dqPz2lyScHL8/hnrQjhA0SvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0JhfL/tWlEZs/2BnC5c+vVm4l5UDvIAgDih3fuPBcY=;
 b=I6zy5kTkEkvgEKRGDDmwZC6GilUMBqz1dldbhRq4pTbJhJPV3SBkzoBK1flz3kyyAghiNh7AugWlYRCBt08oKXBILiYkfs9I0LOBXDgdR95Fzd2VET6IyPgBd/wuQR4xY4TE+Jh5nSaHK6mVQP933s9GzIqamOSIBJuUSdUpqDE=
Received: from DM6PR05CA0050.namprd05.prod.outlook.com (2603:10b6:5:335::19)
 by BYAPR12MB2599.namprd12.prod.outlook.com (2603:10b6:a03:6b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 16:18:36 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::99) by DM6PR05CA0050.outlook.office365.com
 (2603:10b6:5:335::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14 via Frontend
 Transport; Tue, 21 Dec 2021 16:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 16:18:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 10:18:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 10:18:33 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 21 Dec 2021 10:18:29 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Bard Liao <bard.liao@intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ASoC: SOF: AMD: simplify return status handling
Date:   Tue, 21 Dec 2021 21:48:07 +0530
Message-ID: <20211221161814.236318-1-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd2e92c1-9e70-4153-5e33-08d9c49d8a78
X-MS-TrafficTypeDiagnostic: BYAPR12MB2599:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB259965079AA07FEA050F6DF1827C9@BYAPR12MB2599.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0DUIgs1AIkZbEmIfIVkgxjJ/lKcOBwwI2dyDlcmeFTckD4AZs7wCr+tbMqke/YdP1fRtFWbswr6wuOpH5wVoSpNVPJO3cfXhcEmK/vX8/tlZzIibx5ZM2HfI72Mg8GZzhWCTenHRagqUAk3TI+sPNlwlcFgef8t8DH5CnVDbh+pg9Qr6D5gzCwc8omdz3fCIK1ARUjdbsyEwfzuAk17eNc1s+drWWRiUamuZi1yFP9xuaKalWjc8cBxBGrvJehtfOiUwUBYoC5GIJ9cqYYDrUCXdilW3BBX+vgfGbi3jO1UzjeGa8I7KKCkZrdU5TxKeipNA80bNhM1iO9gehbe+Vb3abX+KV3QLeweo26sIt7UaGCCLWmWdJmRCpzdez3l/iWJDEmlBswCL2uDR0O8zvJmR8dbQgT5wMMzbUsf4i5zJY2+tLnMKbitBKWXiYAC9D6TwaSebiFdfS85I6fqDbf1p7CP6AiJlRH1QQtp8Mv6Rf1WGhlBGUU7hhI91he6I0Y+t/tqbeQvNlaSkH3XRa6ntjqDXO4ZgzebOhkxmMCu0RvhebIFcj5zpiZJ/NXiT7CnL7q8sPPAN+ZRaOS1PqEeE5dwNg0waX0vF1yf9dxvdAKLCwPri5oeQ6NCZ4U+Po4zt85tfiTCC4RWNvdiaDppjwJRyTQXQ1Esnsa+6TD2sd544nIaLmHo4QdgqH8Vy5VrKh+9XA0EnjOXWM/B9SoIp01tt1VN9/d+ZYtwBoIQAEGjBrzW8GnFBvsSj6acJ/rK1avnRC5TPnkrP58ssZzwqOw0D6IDx9QFYHYFtSQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(8936002)(336012)(40460700001)(426003)(70586007)(82310400004)(47076005)(70206006)(26005)(508600001)(1076003)(110136005)(8676002)(83380400001)(4326008)(316002)(54906003)(66574015)(6666004)(2616005)(186003)(2906002)(356005)(81166007)(7416002)(86362001)(5660300002)(36860700001)(36756003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 16:18:36.0752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2e92c1-9e70-4153-5e33-08d9c49d8a78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2599
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

cppcheck warning:

sound/soc/sof/amd/acp.c:222:9: warning: Identical condition and return
expression 'ret', return value is always 0
[identicalConditionAfterEarlyExit]
 return ret;
        ^
sound/soc/sof/amd/acp.c:213:6: note: If condition 'ret' is true, the
function will return/exit
 if (ret)
     ^
sound/soc/sof/amd/acp.c:222:9: note: Returning identical expression 'ret'
 return ret;
        ^

Just return 0; on success.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/amd/acp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 4c5550e8d364..fe9b7dc5bc86 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -219,7 +219,7 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 		return -EINVAL;
 	}
 
-	return ret;
+	return 0;
 }
 
 int acp_dma_status(struct acp_dev_data *adata, unsigned char ch)
-- 
2.25.1

