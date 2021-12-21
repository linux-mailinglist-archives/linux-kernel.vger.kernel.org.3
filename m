Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED747C44C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbhLUQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:58:27 -0500
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:41440
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240074AbhLUQ6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:58:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxQx6jrhd35myjD75U9x8SzgHG5uFmH5yZbL1KwxhUGivaj+f87IykO8gAmSoU8KoGkAKyr/JBzgMJdwTJWmWFmm4M+YLdZzaVsk63swqygQ/LEn3EzhzC1J7e0gRNj2N+2Jxy3qcr7lwvaNHQvmDSABinILxBV58GGH2WbnAP1fUkM1E3GsA1f+qTBB5foUlYbHBDtgO89qAk4cax7p+yMuJhDSuGPaKb1XK81WG4DvjwJh0DUYzwugKFMwympbM7ku1Clw8aCVh/MwpdvekvoW14PnSjGw679/ADco4+CRGWrk8J8zw3FJLDeyNV71Mq6KAWuiBKwDdRHiwXDwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guuz+3S5Y3y8QhWp4Gx1t5PJCx+cKgic+o6QtzrCju0=;
 b=LevfJKQW+K21donL3pWTwOkCETdVXk89rHe1uGajIFVi2CzK3Y+SSOiBkliARlFa4b/SDS76wZGviQzy8xQKqd4ueW2BzqdP3af5mOTpncmoHlBIvvWvp3M86ifJU7Yn+zOURgZsZUZT6IWzKa+ijt7MIAsD3XwdCHR1lTRz2X2+e/ZVNycJyo12b8ovrqaMJAJQtwsHcbcsF6hO1xyOu6nl1DsjWI7pDSOiBXL5eTnIu6ec5sRZdVrKhqeEgivubyDPTcu3J839RwLlV7N29IBfxbiMXyEegtd797lxdI/4rUt6bjDu7m8tW3Xlb8B6XjODbm8KkNq8RaPOCRvjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guuz+3S5Y3y8QhWp4Gx1t5PJCx+cKgic+o6QtzrCju0=;
 b=cosPw0I0+pvJBCgfN222PqB9AUTpxxiz093nMlAiJpTKL+wCEZBGK+0H0V/LWAO8nxcVLixZ9quiq3/d5NKxqoOZyH+0sSwAwtJbrIgwv7tNdKRECAdJDAiwee3qgG2mLoUt0jFmhoO9P773AoKiMZF88wtV8VTwcycoGyUzOUI=
Received: from BN6PR20CA0049.namprd20.prod.outlook.com (2603:10b6:404:151::11)
 by BY5PR12MB4952.namprd12.prod.outlook.com (2603:10b6:a03:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 16:58:20 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::e0) by BN6PR20CA0049.outlook.office365.com
 (2603:10b6:404:151::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Tue, 21 Dec 2021 16:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 16:58:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 10:58:19 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 21 Dec 2021 10:58:14 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Ranjani Sridharan" <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Bard Liao <bard.liao@intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] ASoC: SOF: AMD: simplify return status handling
Date:   Tue, 21 Dec 2021 22:27:57 +0530
Message-ID: <20211221165802.236843-1-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b7141fd-4b67-45db-149c-08d9c4a31741
X-MS-TrafficTypeDiagnostic: BY5PR12MB4952:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB495249A3DBCE95BF3F92E21F827C9@BY5PR12MB4952.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2Mpx9jQNTKKNHTIH9PMah568lF7ci4RruiEJwaVqfNiBLgcO5UjWJ9Juzqj4YxHb2JfMHoZu2Iy/r3aq3EKRbQv1EHXf5GYfLUO5dcPRxu6inZ6eyuY+Ig9rFqdfAvl4kLbLi54yk0Hkv64ldGY0SlBuDLieDY8qAg1aBtxKb8oAiKywYILHuSMQ70+vwq8VLeXe9LyN1PXwTEGTERNfZ44vBHG3NC7ckIgOWMH3CTX1GOcBXVB+F0EqzfkHcFnDe9eM/EO5eQjolZFq4KBAQwJSk7NsLNIU0iqksxPCUrV+GqrCqHmBuqsgiIELxmX2HLedYIc2smkIdIq8Yb4GhX3syT8+o9HSQHH7/xHmtLxUB8vIbSIp4qPAOu2sd980LtGbg6Jif6Kv2LDQT/qqeM8792buV83EBmIOV4hjIaOB7zxJb0z1Q1iDHGgBKJQnRinTdSQnvemaVp+Igahus+JfWK6R2padg38y0R+t01jWHh4EfrQvAts9Z0lVjyeZbqYRbIaeNAi6cIXidO9ztdGH3nUlstCtC5PM/KVGQp/sXc0kcaff/xDxHFYo6ZbYD4L4qm9UnQxCvA1OGPHnUHEhz5zA1kgFL8LTdWvVUkmrzHXjCid0A/FzRVte5ov2VVLQ3bFeIiLPI6FpqWZFGDhjfhL408lR4KK1phA9YNaPzKfnX+NhL5dH+ozOmsDQd9FAz0CoGpfxvALL2df4Sb2BiOxbpP7EGYzVHYovAsVmrqG1nE7wRRBvPjenb+KcsnyS3R4MRqcz2e4Cw8rbrLNCtAMgFAy9gWn+Fqdn0g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(2906002)(2616005)(7416002)(36756003)(1076003)(5660300002)(316002)(54906003)(81166007)(26005)(508600001)(40460700001)(110136005)(86362001)(7696005)(6666004)(70586007)(4326008)(8676002)(47076005)(356005)(8936002)(186003)(66574015)(36860700001)(83380400001)(70206006)(426003)(82310400004)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 16:58:19.8021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7141fd-4b67-45db-149c-08d9c4a31741
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4952
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
Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
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

