Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98D147C3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbhLUQTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:19:07 -0500
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:36209
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239649AbhLUQTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:19:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abiVcQG3goz98yaSjG5ZbzWzbbgLBCUyX8Gr02ZWDH1qLDAavx8SU/kKCKzN1+r1fUmmvpa5o4GxeOAz3FMBGHd4FBrKEX92jZVMnXmdGgkf0Ra5AfRps4w8dskJjTd2rwBV0rbFp3oHE+mC8kpv2kZIzedH0tNfZcd+Qp5vJkp++bSGXEKL11tpGMA2ucMt+yT1MdURIhDbTX+KdC1U3LfFAM0q1wZJ6+3hI2DdpeqtuOmG3UmxGpjcEZu/bzw02ITuTvXiPXZMFmuzqNyr3kJ5jkU6g/mufKeYEhaTG92tZcMWZcv7YXSW/MphCV6aT1MKz/BBi0N6B+n18BcuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rItwZkKUxti8nGR81PnvwHALhzE3fm9ukB6UAKqP8EM=;
 b=TBdZQ7DAZRBiPHjQGTp+4/8V4kLrhYhX/dvX4rjhcLxFYIBk0uu5xOkFhP4qnVVgFvbm8McbBi5NrYd5rNVUFP0/Vi8EF2/ePSFf3p7r1Xaoewdq7TvaQPOXfR1NdNFEOQYrw3qfLBHSGkyjCifjSydGc2SLvf09QOIKgYVkK+Ql8A88bUh9b4tYays6oJow0dMbiIKkzTATfKPzugmdS8d+7eSU6Nh23TvlYjviBKrCz9sF60mRgsYKRWjKV+de7NFyz/O69JEmANcO7Bg5NN6Yq383YCq0dn8x1BDSic5lmK7wr5lS60AiMvQL5ImasXZZrd00qrYqjtpBP63/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rItwZkKUxti8nGR81PnvwHALhzE3fm9ukB6UAKqP8EM=;
 b=WSvfVy83DkEy78C+zMTWhUtwKMVm1ECkSf0OonkdJOV1WYIwSunKmhQiT61d7lwGUvzRWFVnOsLuNWzJDNwL5kbWTaMr2MzvZCdTSWB9A/+nNHzB3YiqEyCr1MoOhVKuZJxJnOABlZ4y13scqYc7CoKXLbVVMwnApvBIR6z1ZcA=
Received: from DM5PR20CA0035.namprd20.prod.outlook.com (2603:10b6:3:13d::21)
 by MN2PR12MB3616.namprd12.prod.outlook.com (2603:10b6:208:cc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 16:19:03 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::d7) by DM5PR20CA0035.outlook.office365.com
 (2603:10b6:3:13d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Tue, 21 Dec 2021 16:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 16:19:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 10:18:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 10:18:56 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 21 Dec 2021 10:18:52 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Curtis Malainey <curtis@malainey.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ASoC: amd: acp-config: Update sof_tplg_filename for SOF machines
Date:   Tue, 21 Dec 2021 21:48:09 +0530
Message-ID: <20211221161814.236318-3-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221161814.236318-1-AjitKumar.Pandey@amd.com>
References: <20211221161814.236318-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc735b1c-97fb-4a97-7d77-08d9c49d9acb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3616:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36163BB5CC8EAD7A8DA08A09827C9@MN2PR12MB3616.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxR42KjH2bFGj0es0U5H0mv5X5Ij6JmeQ1M9IM5JQ05YF3Avcyg5nile003zvLjK77cSx1zoskguKPRo1Kd9YxAbFMrqjrkleVANuKEVLVHq8loeQRRTf6/IjbiTWT70tb6CruVwgSlSOB566DWiqxni6B+3+NgHNSWokcRukAzcI27+ervfEgrv0xUXHQFUBUYhpU57WBxPZFFSvAMkvuZ70caAePRCjxNjWFVO1z8VmcovG7dsuHX3HPqFnK0yqvheEllyhElbzI/wnp+FM+TEn6fiA4vDSmDUHgIVf3xd0SSpOjCrwivwLcT0kkdBkD2xM88hrxMWSIWEp89fGkGKl+WrSsFxDvHJ2zgEljBqVvkE0Hwmxm84hqtf8H7hq66tdxU8ZA8X/4ckFHGhNbK3kDbEZ7XH2LlcmT//TPhjttPN+FiXjsDMB3ZVYpBl5bNe1foou+c3fFRR8959phjlTD9B2bzargbAWMwhpPKRhU8t7OZlg1U4UZD0Fm2XXjwv7lDxhB2ciZ4sIAN8rboP2YdoJKwwuVX0jMqpEWNmqKdK0NeGBAJ9WpJoJEjD/K53cVRCtyT/+aL4CqmDEremonqR9g+NLR0AiFTS9rpKwlHXi+BDOgRWCChhO58k9VUSaKI4X1qvFLpSKsCVpZp4kmrRw3xJc9VTSYbiXT9rBlfDJEwVO1fPd6CVk1B/iOkPf8OgQghga1PIv7ZQCRg5i6NQSwXCxi5kjUWX1ZxmL15evAZodF4WpuB/pTM3o2jHZvHeIKmbu8/G9lkB6kNahvp5r7HMSMxXkfMjX88=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(6666004)(2906002)(508600001)(4326008)(15650500001)(186003)(356005)(36756003)(40460700001)(8936002)(316002)(336012)(47076005)(86362001)(2616005)(7416002)(82310400004)(5660300002)(83380400001)(36860700001)(70206006)(110136005)(70586007)(54906003)(26005)(426003)(1076003)(81166007)(8676002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 16:19:03.4774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc735b1c-97fb-4a97-7d77-08d9c49d9acb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3616
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SOF machines support different codec end points and hence required
different topologies configuration. Update tplg filename in machine
struct to load different topology files for SOF machines.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Reviewed-by: Curtis Malainey <curtis@malainey.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/amd/acp-config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index c0bbcdb1761d..c9e1c08364f3 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -90,7 +90,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_sof_machines[] = {
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &amp_rt1019,
 		.fw_filename = "sof-rn.ri",
-		.sof_tplg_filename = "sof-acp.tplg",
+		.sof_tplg_filename = "sof-rn-rt5682-rt1019.tplg",
 	},
 	{
 		.id = "10EC5682",
@@ -99,7 +99,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_sof_machines[] = {
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &amp_max,
 		.fw_filename = "sof-rn.ri",
-		.sof_tplg_filename = "sof-acp.tplg",
+		.sof_tplg_filename = "sof-rn-rt5682-max98360.tplg",
 	},
 	{
 		.id = "RTL5682",
@@ -108,7 +108,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_sof_machines[] = {
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &amp_max,
 		.fw_filename = "sof-rn.ri",
-		.sof_tplg_filename = "sof-acp.tplg",
+		.sof_tplg_filename = "sof-rn-rt5682-max98360.tplg",
 	},
 	{
 		.id = "AMDI1019",
-- 
2.25.1

