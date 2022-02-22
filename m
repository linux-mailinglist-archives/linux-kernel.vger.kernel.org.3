Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B034BF1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiBVGNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:13:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiBVGNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:13:34 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C291BC7E5C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:13:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8aLc3I1TgUFG33OA3uQZ4HyflI+UjB01ASq7SICMWMZe24N7qqx8v4w39EflNnAkHvH52wT4g5R80eTyjKxYV5t8HFrn+UsN55NcINaWyRNnaV54zF6d6CyVEwD1R5ICSRFpJzivj3D/k9qroTlwqkZzyJZq4OUoWpWXZ9MyFi7pU17ijEfOQKb/HNl/c0cKqWvIAkvHDfbQA/kx00tknK6Y6+DyVIJRutNHmCbsbvW5FwCi/yyMSbFQQZIlmbXlORaitD2Gi69UcKPAalo6aXeAkPMqVQrmPdV22IR5qTf2o2WavwXJR1pK8V9NzDBd+ZkSNu5qwcGqVRPOoOx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0e5Yf/l7KLhk03Q8tqx3awfxFgaYY9GQxqf0QmqNpU=;
 b=eGk9ik8j9HFUZs524dGfRyo5xFrExDsTjaLznqqsdsflA7jjd2x1L54+wpRiGPzcHgEdNxmLJAVj0NpG+bC57Jl7bU/U7hvYqPLaEQ22mUn+o2O/YuOpquImfQ7Mur/j95xmnx/2o13mknx2+ts7OYHtEVGinKXM/9oR0wh+O4ZWUpaYueAXZceepSDZvQxiIKLoHLCY6zE3undhgpQmqLP2K/eekZPj/JhrfKEHRBCWe9aKk832+gwHRwNwasG848BjlnWS/BqD70caRxQUtPQRT9DKdiub9b9kUt4oo8qSOap1f8gOo0zj7m7t8Y60OD5Wm0tZMxKP4xlfut+XrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0e5Yf/l7KLhk03Q8tqx3awfxFgaYY9GQxqf0QmqNpU=;
 b=MjyZNW7R9SqytB91ZHwZNZOp0xkdR0FZ7KAD2l8DjQZt4GftZ+Ttb7YcPcfDk7rUgDQH01C3sRHVlKD5FN2i+TerUGNb6v0YuUyoJINpd7wMJQ3HZ20LBTYV9teheGIof1YdN/8E4d2BhpXzsnZkEkVCcOGKuIGPzFJ+OUDYANA=
Received: from MW4PR04CA0330.namprd04.prod.outlook.com (2603:10b6:303:82::35)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 06:13:07 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::9) by MW4PR04CA0330.outlook.office365.com
 (2603:10b6:303:82::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Tue, 22 Feb 2022 06:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 06:13:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 00:13:03 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 00:13:02 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 22 Feb 2022 00:12:59 -0600
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
Subject: [PATCH 1/3] ASoC: amd: acp: Change card name for Guybrush Machine
Date:   Tue, 22 Feb 2022 11:41:26 +0530
Message-ID: <20220222061128.719400-2-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222061128.719400-1-AjitKumar.Pandey@amd.com>
References: <20220222061128.719400-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eabe6d7-46b9-45e2-5697-08d9f5ca64a7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5056:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5056253182A56FEB6D4AFEDE823B9@DM4PR12MB5056.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDmgGE5G4LJiEjfi9cHnj0QPDpcN7R6Qa3BgVxOwAbbSV5eibOuw2FI6FyCaEr1yiwcgu3i9GsDSlSAka2JGQJN9IZ2jlaK8Wl9wcCJ2GiCZw1jKC+A9PIivB2hi8wRRR8CkqSygYBjYrOFWYSM+5eE+xd3KmBdt7mytntirnd2cDBzIKksiDrmttq2CeGw0hxhGeTXKYiqBQfegKSO7aSFflYuZU95Z3MNV73LLlgV0cHXZ8av30IFCENFJLScSpOQCyLm+UP2dLy7/b2xn/E+f37q5YPycmr0/DxkApGcyvcSyLcAHnC0SHFar3DJjsoLKpvPcHXt+ct4brXb7J6TLW8P/8Q74lDa2rV52tyyyuK+tpZKuET0XO5tq6Iw7CnrsQ8zp9lf2rZQ2S657ZUZNFcCDdBOEBIVIVPpcMBbf2lQOzJHc7jyd9gZhWgA7tYbYMCpXTAO0ctVaXlEBqsL/IWc2FRVUJl1x6dT/8lFF/qRv3LOUnuNhmNdEdHVsyvngW/NFystj6jws4vKjCH7N1OZZGcaPT4IZ5YLtPj4L6g+CDfnGc4BIeS1AkX5ZWeNmwLJkBqvIITOcq4xqXUh+7FtzJONyoLXtw9w5xgqP4/P7UsF+mSu4zFzEP2nbR6RbzGab1XDUeXqL/MO89cWmV1b3wzP7ns7xNbY5T66MG5bGsiYKoUv54itM7ozbtiLvkA6g5CqQ/0BaG+1gxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(26005)(2616005)(70586007)(70206006)(36860700001)(1076003)(7696005)(6666004)(86362001)(54906003)(110136005)(316002)(82310400004)(508600001)(8676002)(356005)(81166007)(336012)(426003)(83380400001)(4326008)(47076005)(5660300002)(8936002)(2906002)(40460700003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 06:13:06.8648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eabe6d7-46b9-45e2-5697-08d9f5ca64a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change sound card name for guybrush machine with rt5682 as primary
codec and rt1019 amp to align with names given in UCM config.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c | 4 ++--
 sound/soc/amd/acp/acp-renoir.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index 91140d15691b..50a5aa4d6da9 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -96,7 +96,7 @@ static int acp_asoc_probe(struct platform_device *pdev)
 
 static const struct platform_device_id board_ids[] = {
 	{
-		.name = "rn_rt5682_rt1019",
+		.name = "acp3xalc56821019",
 		.driver_data = (kernel_ulong_t)&rt5682_rt1019_data,
 	},
 	{ }
@@ -113,5 +113,5 @@ module_platform_driver(acp_asoc_audio);
 
 MODULE_IMPORT_NS(SND_SOC_AMD_MACH);
 MODULE_DESCRIPTION("ACP chrome audio support");
-MODULE_ALIAS("platform:rn_rt5682_rt1019");
+MODULE_ALIAS("platform:acp3xalc56821019");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index d06ad5ce7fec..b8dc25a1d31d 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -47,7 +47,7 @@ static struct snd_soc_acpi_codecs amp_rt1019 = {
 static struct snd_soc_acpi_mach snd_soc_acpi_amd_acp_machines[] = {
 	{
 		.id = "10EC5682",
-		.drv_name = "rn_rt5682_rt1019",
+		.drv_name = "acp3xalc56821019",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &amp_rt1019,
 	},
-- 
2.25.1

