Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EFF494F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbiATNhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:37:07 -0500
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:30432
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229664AbiATNg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:36:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1o313R9dj7q0lWDaqMZN5dyXf8inUdcWS7MwU1W3ksyKNqaBevyM4hByKvGE8zrgii9HVksn4u4LnXbg+8EgnSou6/K+694oneuKOeYBGfeUSdid0+On6KivOPZc2di12DsyZcQ+2sE0VA4tbt8nqQ8DJrJgNoudhmohkNV3hNqEo0dFnGtNiA4JXdt8SZHznOY2u75D8JaJ7UB8sungWbyI7MWrTWW/FGC+c/E1EFVlZfCPNRxXiimaMBZAmlUcRPJRyjTdUIsd6H5pVlHaT/9J7Xp6KbEqlfKStHXhBf9FJgyjTGEZSuQdoDPVQD7w5WlMiX10PhfXnijfkb4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GNSX2NERFkOpYps+DwsZXSNT2odsxvBNAwpgDOMK90=;
 b=B15QnBrLx6mp+beWWCeZ3Mpp+D9IhL65XzPu9BBBybdeDJ8/ecFsT7o6eztxMaglhEN71f2t9ZExMlTYec5Qpw04eANjJW3NvQZb1YBNfofI7SbCt7opPk7ZU2hejma8bHm/etpbE3/VqwxiEzGG9KHk0GGuF+ZlFnEz0FDPjhZMp0UVjxtaRPaA6lWzt0DgP2eMsu2G+IyVbFst/XE1e+a9DawsaH3oybyNLWdQSY4w107zx0XHUV7kuetJ2BW7wm/+OTnwZ3yGAG88ymx5QXGay5Az6sdGgP20CjJsKgqqlfBucZQ0eYKxcaIXWKI4jBSRYWphSTjtyxV7Vqx66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GNSX2NERFkOpYps+DwsZXSNT2odsxvBNAwpgDOMK90=;
 b=CLwZDb0BkT1lN6T1b1m1Irr3mHzmP+5lSDzBuuF5lqhZaTd2VB6cFrH7KJxmn/KGTG9mOWuB6azK25zcULBrdytaj6k7+P84ob7CgZyEbzenzW8GoGkasXLTZ2+WdVXrhsZlSgbhf6XbxYQfge84vHyCiX8fBvlE+ptQgirRUhE=
Received: from MWHPR11CA0005.namprd11.prod.outlook.com (2603:10b6:301:1::15)
 by DM6PR12MB4779.namprd12.prod.outlook.com (2603:10b6:5:172::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 13:36:56 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::36) by MWHPR11CA0005.outlook.office365.com
 (2603:10b6:301:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 13:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 13:36:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 07:36:54 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 07:36:54 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 20 Jan 2022 07:36:51 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "V sujith kumar Reddy" <vsujithkumar.reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp-mach: Fix Left and Right rt1019 amp devices
Date:   Thu, 20 Jan 2022 19:06:01 +0530
Message-ID: <20220120133605.476138-1-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 566297d7-dbbf-40bc-cec4-08d9dc19ecf3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4779:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4779143429016DBB6926683D825A9@DM6PR12MB4779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vTUhJkDQwuKsQS52fI83DFz8LHUOdI8jDamqAenmH21iZKYRX4D4RYUIBnylFF+KQ2AcZzM5cgZD9h5YCeYT4d47zM3v5qffLpzusM7SFMAvo8eR977dQgwH+1GxhcJaAag4zXLJh2MrNweSAF1ntpmWjdGDi9RZW8xdIrE5InGsGi9v3zSieWmhNNjIEJ6e2h3MLciRKC1E/szvYDJrPCwHEobcDnCZZVsfHa6lWGGJRY/rY5mm3SZtO+/oWaWNIdmkLdRd4hTOnysGF4O/mvHs7aQE5KMSbaN+j7uIo1E9YYP4k9fWdbweYD19Rv1bmpyRsR3wrfaaxCgitvNcDXFJpf7p5Ep6YlRKuU2NWbLRJiawG+Q2Fd6s4iWW6N8WRXD5fFLg45a77xajWFmhc2Lpd6bUDxpRPwLYsyGIZmlLk4wCEcpVcad7RNcNcuofZRSuJQtcpxzxaGmZFxiq9eZrnYhB0fKt/99KaJnHtjyKXm3LV+geOal0xzKMWqf8Qst6/6yxJ6KFG5gto9AXGDgKOWhzA+QN+1AU862SNefQEnQUMzuC8wVzBJlNgNmPnrBcACS42wL0x9xPaHWIVglnDIShGM4ZUP9b4pG8dGjO3VlDQ97dNYmrz4vXQGrtPU+nW3/QzlTwEHEg2hGZGfIkd8g7+elzFyhx43EA9zoB5Hs3U/cQOxtNuVtpfyL8Mtzf1QsrJOAEwNlmaAGSCtMi060e9hE7Rcp/i+kqNqj9WTPb7Ls9bmeoBbRz6OvyQJk14uP0BECS73hrqktMz5sl90rmFRziUifS9t66zI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(2616005)(7696005)(81166007)(8936002)(36860700001)(5660300002)(508600001)(1076003)(6666004)(40460700001)(86362001)(83380400001)(8676002)(426003)(2906002)(54906003)(70206006)(82310400004)(36756003)(186003)(26005)(110136005)(70586007)(47076005)(356005)(336012)(4326008)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 13:36:55.5767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566297d7-dbbf-40bc-cec4-08d9dc19ecf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4779
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're setting wrong card codec conf for rt1019 amp devices in our
machine driver. Due to this left and right amp channels data are
reversed in our machines as wrong device prefix results in wrong
value for "Mono LR Select" rt1019 mixer control. Reverse dev ids
in codec conf with Left and Right name_prefix to fix such issue.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index c9caade5cb74..cd05ee2802c9 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -303,11 +303,11 @@ static const struct snd_soc_dapm_route rt1019_map_lr[] = {
 
 static struct snd_soc_codec_conf rt1019_conf[] = {
 	{
-		 .dlc = COMP_CODEC_CONF("i2c-10EC1019:00"),
+		 .dlc = COMP_CODEC_CONF("i2c-10EC1019:01"),
 		 .name_prefix = "Left",
 	},
 	{
-		 .dlc = COMP_CODEC_CONF("i2c-10EC1019:01"),
+		 .dlc = COMP_CODEC_CONF("i2c-10EC1019:00"),
 		 .name_prefix = "Right",
 	},
 };
-- 
2.25.1

