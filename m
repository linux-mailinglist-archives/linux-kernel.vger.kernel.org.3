Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F5455DAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiF0NAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiF0M77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:59:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02C311C22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7qQmrXQEyfgNMO88g0B6dYvu/oJqw0VmPGIZEix3tMC+E6Q9TNGAkDGjnOTbcX+tmw5DUjXloe1davnkdFs+pDdH8JMT89F+3rw4CmRXj2KnCoE1Qe/RV4F3iqtW4ydrFhjBe0V7dUOv5vNq/RCpz3xTmmfmrDsHkmC2STwMxlFGCspqucpNeTJLb2q3hcreGHqCzvd/7Bky7dweC7ruDZbi315HeqNJ++L3/k2WSY3vBIqOtPPfF2Xe1tQ8CvqBHFkGLUbbAEolfj1cEwtgcvOPNvEbmAvSk2I8PVJz24ezBbZzx3vlckdowTWW97NEvHdihPLe4XB18g4dWyiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMEpQkQ0GnZHAcdexr0JHZ9kk/u7yFuWBy/kPIeS1RU=;
 b=Qf8g/T3g03Ne4wi9ANUq2aNdQ/9YSCwxhKJRwT5xYOF9QUO1bnVipixY5i8QbSYiIgOtTMDb/e9AMZ+w2GzxIZaelkxT1kzx57DtpdUWeOdxFN+rqzGEBiLTAIul/jXwu/8eYoXQgzwya4yxMr5bllNtJA09ghzth20WSkmYBHxSGtpTC0owwEsENU94UUC2tzwYOhejpgGNBLOGj9BlecEXMqCbjHMwrbdlmw4lGXIznYXzxZb3NuCP0guTOX9ziFnkG/go2akbibHjNKgQzgRdB9UEA3z4bqD+ueieQ4rmgukAvv7j4HlqqzoZYGfj4jAk4M8b2xkqOrVo5tLlog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMEpQkQ0GnZHAcdexr0JHZ9kk/u7yFuWBy/kPIeS1RU=;
 b=hbA4atJcz72m2r9aihXGlL/V/rohyjI7OP8eBvwDUxg3cb8B3s6I59ElapBh/mLeTH2UXtRSaFKgwfm45PCuKvTpHoqD14skW7d49L1zEEyDAVkQNEVmvWxNtzt5ODhWJlQIWyTT0ivyppO/WShZE2zBpYQjjAnXeegqeq19Dg0=
Received: from BN6PR19CA0061.namprd19.prod.outlook.com (2603:10b6:404:e3::23)
 by MW2PR12MB4665.namprd12.prod.outlook.com (2603:10b6:302:2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 12:59:13 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::8e) by BN6PR19CA0061.outlook.office365.com
 (2603:10b6:404:e3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Mon, 27 Jun 2022 12:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 12:59:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 07:59:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 07:58:48 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Mon, 27 Jun 2022 07:58:34 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, vijendar <vijendar.mukunda@amd.com>,
        "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: amd: amdgpu: fix checkpatch warnings
Date:   Mon, 27 Jun 2022 18:28:33 +0530
Message-ID: <20220627125834.481731-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c1e73e-a044-4e4d-84ce-08da583cd570
X-MS-TrafficTypeDiagnostic: MW2PR12MB4665:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3jfi0sbVHnGdHKYU1BIjRnT0TYHl+1Tjxak8G2eDp2U3elSktUgPOfV0YxiXNJ/j73SeSX07UmvXQjsMC8nuvI2nuoIjV9xo/mQUmIaTHAxCZ9kHVDr6z3wJ/2uTJ4KIFGxvkBnCjY31pEkwqvkFnl7UNT3kTrcSzbHrvFFzSeKlHCmLoQRIU1b29Bp7McH0LUY436Kyb+wckWsJ/Y5+Lv66wEulb4CL9VCHLP92tuRJ9YZ+Yc+Hdr9wfyJ8boZVNmXp9gzypcJtXSaKpRWpPw0TL71suELOyseR6A9J1MRXdoa1qyH7YX+zLpNSotbw4ik+vrYC+ZbOxmcrqBOIpAB9PBvTL1ATAn/oauVNZB2f5/1eXvlS31eNuJhukF/LVqzp63kNYzEcMMEw3/HRQRtw/CFhDhx+ilSukngc3sa8y6Dsiwj8unSHarBt6NIbA1M1rUCVIXEbXDYGNTAKlR0EPYQ5+60JHMtFb5aOusSUwdBdrvIeCINpUhDAcVNzaqJBvaxVy0SfgQCrLKJ95ST0JLzX1YN0mBXQ7kDKdesTvQbZ9w4rRGslUAiYAq9VyvnVfI8sWOPXkn66GpXq9uR6Jh7MUtOTMVF1WrUaTet0HYK8dKI2oHdUObbIsX1MpQokDU4vRRkvvB8mboHeZt+MmN320zK3ytmE5bVo/xq8U30NBAXVNFc+sAHA8OKxu2zCddlO7nvfFxbCQbRW9NJETGdCJIudz3STs9rUcn1hd8gSzytB3SnTwy+DZPcYS26NMFY9r/stHoFfytOHo2OVhYo+3rjywQsoNHYNTXm1NQLrIJg9+z9FYiwe7yuJPxcPvSpStViCqMqxBrgGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966006)(36840700001)(40470700004)(82310400005)(40460700003)(81166007)(336012)(86362001)(83380400001)(186003)(47076005)(2906002)(426003)(356005)(36860700001)(40480700001)(4326008)(70206006)(478600001)(5660300002)(54906003)(8936002)(110136005)(41300700001)(316002)(2616005)(36756003)(7696005)(70586007)(26005)(8676002)(82740400003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 12:59:12.7924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c1e73e-a044-4e4d-84ce-08da583cd570
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4665
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: vijendar <vijendar.mukunda@amd.com>

Fixed below checkpatch warnings and errors

drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:131: CHECK: Comparison to NULL could be written "apd"
drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:150: CHECK: Comparison to NULL could be written "apd"
drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:196: CHECK: Prefer kernel type 'u64' over 'uint64_t'
drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:224: CHECK: Please don't use multiple blank lines
drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:226: CHECK: Comparison to NULL could be written "!adev->acp.acp_genpd"
drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:233: CHECK: Please don't use multiple blank lines
drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:239: CHECK: Alignment should match open parenthesis
drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:241: CHECK: Comparison to NULL could be written "!adev->acp.acp_cell"
drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:247: CHECK: Comparison to NULL could be written "!adev->acp.acp_res"
drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:253: CHECK: Comparison to NULL could be written "!i2s_pdata"
drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:350: CHECK: Alignment should match open parenthesis
drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:550: ERROR: that open brace { should be on the previous line

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 27 +++++++++----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index cc9c9f8b23b2..ba1605ff521f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -128,7 +128,7 @@ static int acp_poweroff(struct generic_pm_domain *genpd)
 	struct amdgpu_device *adev;
 
 	apd = container_of(genpd, struct acp_pm_domain, gpd);
-	if (apd != NULL) {
+	if (apd) {
 		adev = apd->adev;
 	/* call smu to POWER GATE ACP block
 	 * smu will
@@ -147,7 +147,7 @@ static int acp_poweron(struct generic_pm_domain *genpd)
 	struct amdgpu_device *adev;
 
 	apd = container_of(genpd, struct acp_pm_domain, gpd);
-	if (apd != NULL) {
+	if (apd) {
 		adev = apd->adev;
 	/* call smu to UNGATE ACP block
 	 * smu will
@@ -193,7 +193,7 @@ static int acp_genpd_remove_device(struct device *dev, void *data)
 static int acp_hw_init(void *handle)
 {
 	int r;
-	uint64_t acp_base;
+	u64 acp_base;
 	u32 val = 0;
 	u32 count = 0;
 	struct i2s_platform_data *i2s_pdata = NULL;
@@ -220,37 +220,32 @@ static int acp_hw_init(void *handle)
 		return -EINVAL;
 
 	acp_base = adev->rmmio_base;
-
-
 	adev->acp.acp_genpd = kzalloc(sizeof(struct acp_pm_domain), GFP_KERNEL);
-	if (adev->acp.acp_genpd == NULL)
+	if (!adev->acp.acp_genpd)
 		return -ENOMEM;
 
 	adev->acp.acp_genpd->gpd.name = "ACP_AUDIO";
 	adev->acp.acp_genpd->gpd.power_off = acp_poweroff;
 	adev->acp.acp_genpd->gpd.power_on = acp_poweron;
-
-
 	adev->acp.acp_genpd->adev = adev;
 
 	pm_genpd_init(&adev->acp.acp_genpd->gpd, NULL, false);
 
-	adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
-							GFP_KERNEL);
+	adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell), GFP_KERNEL);
 
-	if (adev->acp.acp_cell == NULL) {
+	if (!adev->acp.acp_cell) {
 		r = -ENOMEM;
 		goto failure;
 	}
 
 	adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
-	if (adev->acp.acp_res == NULL) {
+	if (!adev->acp.acp_res) {
 		r = -ENOMEM;
 		goto failure;
 	}
 
 	i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
-	if (i2s_pdata == NULL) {
+	if (!i2s_pdata) {
 		r = -ENOMEM;
 		goto failure;
 	}
@@ -346,8 +341,7 @@ static int acp_hw_init(void *handle)
 	adev->acp.acp_cell[3].platform_data = &i2s_pdata[2];
 	adev->acp.acp_cell[3].pdata_size = sizeof(struct i2s_platform_data);
 
-	r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell,
-								ACP_DEVS);
+	r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell, ACP_DEVS);
 	if (r)
 		goto failure;
 
@@ -546,8 +540,7 @@ static const struct amd_ip_funcs acp_ip_funcs = {
 	.set_powergating_state = acp_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version acp_ip_block =
-{
+const struct amdgpu_ip_block_version acp_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_ACP,
 	.major = 2,
 	.minor = 2,
-- 
2.25.1

