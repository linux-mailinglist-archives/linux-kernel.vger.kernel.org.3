Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65D14C0D39
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiBWHZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiBWHZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:25:16 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D167007F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:24:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNOGxceMb20JJmzATcL+s2MTK806u1j2kdCniz4gxcwVYm1QHZlHb05WXj49y26GipCcV+NyF0zhtkxKDb4C/zJh3YYhvA2mdDm0zR4pJREJO1PV2rHIl/sUxpfJLDOQ+ys4omrcEyZceNfZAl+A20ryPn0WpMoxmnUJqRyL84/Nqhi8iUB/tzVISPewveR9ziKw9xpxR6goYf4Mfh/4VhSP29OUsV3H5e1DJdEpzgDVyp2k4jpYHs+oDStFYwPMbIMS4+qlZnEd/5pJ0m95dNkM+HuF9HCvSMHIGCVNJ7mtMxEq8BV5ucL79o91kj6orBh3gtp2AQzLQ+PnYKd5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7xGXCgOBqLlRtfmLnCo6ngGAXObtc0QHwij5Yc2q5A=;
 b=EfSYI+jsntp2WuuNNsLfTRCKlX9v/zRd1+AracAFhwEl+21ZR4FFOxkrZ6c1WdXPcE1mgKRqi/+sIkFYtrrEySsP9KEb+qE2r2f2SbVl5skOx/P/zFIXLDyhIyNjUbAkUaFBnbbEDD0hwU5bHeefnc1KZug4OWIeHkjQhes6htwHaZEERT2hDJJUu8w9Ef0FWMeBs8JHUoB7tYwsQ8i5Flu1Y9lmIaSsvgTCfmndt8UNoF7bMeA8M4tHHm5f/F8TJSuAcZgvfzRNM0jKgj23+JqVW4qjZ/8YLcrhn8LwN+cY0KDLeNp3UVPjxiqj8eT93QQeCKYB2d1Y8HWMMH9/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7xGXCgOBqLlRtfmLnCo6ngGAXObtc0QHwij5Yc2q5A=;
 b=S9YYnre/oOCe86L3rW2j6DWv1apM2NT/131Ukxal5Ofe/DqtScL9hFuawosv4Ur0osX3llkuai+o66xU7yQgcZCHsV6pxtbJsWm9OQTSGR3PzGhsZfU4nsyK8ezbglyNeR1aex8zos5Jt+15hIXOuT++a+LCI5nafJK8kM6+k40=
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by BYAPR12MB2871.namprd12.prod.outlook.com (2603:10b6:a03:13d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 07:24:33 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::58) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 07:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 07:24:32 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 01:24:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 23:24:31 -0800
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 23 Feb 2022 01:24:28 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>, <wtli@nuvoton.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/9] ASoC: amd: vg: apply sample bits pcm constraint
Date:   Wed, 23 Feb 2022 12:49:34 +0530
Message-ID: <20220223071959.13539-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
References: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f25d9d4d-b6fb-4d93-b07b-08d9f69d8994
X-MS-TrafficTypeDiagnostic: BYAPR12MB2871:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB28716FFD7FFF2A7416907FE1973C9@BYAPR12MB2871.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77Pd10GToVb/I+dDdGr/vy8YwuHX13vm+2XAMzt3T0szTbkQW/EI5kypGaq93XH/iUbHMtZO+VHMQna+8VEKgwf4obQvEmn8/uReRGwzoeiEPNeLwyLq1jeJisqNn8uYtH9r8/Mp0pqR89CugdvzHE2RU7ygrMIzOXdHg/8AX5SKQqjSAd1easnl9zrnbcp7hW3VOBAoUjbFoRkluI73pspYQsi88yf8UmzvSJdo6zNE/ijbkx9ksC+qoBwrHQ6TIwfxnuEroLbfr7rTFIPxCgllRZAGcCDU3gzKPx+ydKyQ3Lv31Ti2c/aaVgQekc/4VamDMe1m7erS8fids231heMQdlKF5we2HzOtW5OiKFFPBeSK+U/S0SHqMYSAJFKQO63Nkan4OjEBzNVJkG7isQECn/Gjco1ThAfy0SCYG3BscKSmahTC+CUHq5W17tISBRUTPHhDoNYBY3g/o/INj54f0L9MnCV22ANrmX7h2sZXxaMml3LcvfuM6CGbrjwaYrgk7/RN8VKIjmm+LaAhqIsTa194w3jyWbWLSj1skrJ3hRGWBVN1AyYi3db8GVHxYrll7gW+XEd34CijznMxaTGyvpPsEA6X+1G0E4+vVFo0TGlLNQGitIabfeTILfX4p68oTTXPz6/97Iqul0BpxlhVDVubdvEro6DtHnlQ3zvFi7KYepSF06fgxV+OavOxtLFLmQc6YdBG0RniNYiz3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(2616005)(47076005)(81166007)(356005)(7696005)(2906002)(54906003)(110136005)(316002)(40460700003)(70206006)(70586007)(86362001)(4326008)(5660300002)(36756003)(8676002)(1076003)(8936002)(82310400004)(426003)(26005)(186003)(508600001)(6666004)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:24:32.7532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25d9d4d-b6fb-4d93-b07b-08d9f69d8994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2871
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP I2S controller has limitation to program different BCLK
for TX and RX paths.
Headset path uses I2S SP controller instance.
As per requirement, Restricted 32 bits as sample bits by
applying pcm constraint in startup calabck for Headset path.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index e610616d796c..18b2fdc8dc9e 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -100,6 +100,13 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.mask = 0,
 };
 
+static const unsigned int acp5x_nau8821_format[] = {32};
+
+static struct snd_pcm_hw_constraint_list constraints_sample_bits = {
+	.list = acp5x_nau8821_format,
+	.count = ARRAY_SIZE(acp5x_nau8821_format),
+};
+
 static int acp5x_8821_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -115,6 +122,9 @@ static int acp5x_8821_startup(struct snd_pcm_substream *substream)
 				   &constraints_channels);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				   &constraints_sample_bits);
 	return 0;
 }
 
-- 
2.17.1

