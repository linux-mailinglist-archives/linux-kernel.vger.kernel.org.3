Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572445804A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiGYTsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiGYTr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:47:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A5D1F2D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1HOQ0XHZqGehNPnPoeY1YqJ339uf43L2a9MOtzWbRS3mjZTUiDEgOX5vrMyzFBAb3rxZnPuCfzF93BvvY6FuNCjLH1k7rPEq/cxHOLiB6kAi1OpIkl9NxI78bIFbWbf9LLdYAy17pn6Rz7ivHsALR5Ar+MfMozZTKvT7xQvbmVzGEH0SKTnKNLCwzR/4sJgyk6oQJsQtLtGSRscH/6tZwnQHMxFXtIAH2R/3bP7JHdYmcWbqMINVtyXz45RvA7voUN2DIbZItVqNKDzcgZoDiIXSMT79lssOxsyYBDRHfUtYvxtY2iKXHE+Hf1IEnfUbdU5AtCwHb2FKXb+F78QKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efiDzRyns+kRpJIVWN2Y3GBBORIbf1+gRO/UUgIncM8=;
 b=cgIe/elx9V+QYGLNlr1mIbqmPqbPGlhYTSsHB12yI6Az/v54It3Y04Eqm4Uq1Vnqe2VRxcr3BNdkEcrMGU3qOKUqAgNlvTzFGZ5QnT8NhDSKkOkvOTdlz0N+FU4nAEDQLB0xl9zBG3U9pOy1XEwZwyvVUj3aaJmAC9ojm5cks1O5RBDWHeAs2LUJ5owKWDDopV33qVL0c5hlIlFCHUI9b1TmlqZfAkGbhBk7ZoyudADrp4/6nye3XANmcXd0YNAhm4vBLo9m288TA9aUwnyDfrgcRHSC26a+4ThceMaED6GqWOQUqC9y09XaQS6k16y909ZVI6quw4ovDR7oTha1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efiDzRyns+kRpJIVWN2Y3GBBORIbf1+gRO/UUgIncM8=;
 b=WN6feSKGJgPaCELhsik8Rjgi+mcbZOGgGvj46e8nLmhaSS3ozW0JGg/SNHQNHmBFqYPcw4PvG0JJCJeUih4Nw+UPZJrpQIeAtdsBkeIYlHp+Df6yVbnDQZ1xF3i8W6VAv6COH7D/LStTLE9Q66bU6yku2QGCq3oCjpy6tYlyLs4=
Received: from DS7PR03CA0013.namprd03.prod.outlook.com (2603:10b6:5:3b8::18)
 by DM5PR12MB1129.namprd12.prod.outlook.com (2603:10b6:3:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.23; Mon, 25 Jul 2022 19:47:56 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::53) by DS7PR03CA0013.outlook.office365.com
 (2603:10b6:5:3b8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20 via Frontend
 Transport; Mon, 25 Jul 2022 19:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 19:47:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 14:47:55 -0500
From:   Babu Moger <babu.moger@amd.com>
To:     <eranian@google.com>
CC:     <babu.moger@amd.com>, <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>, <reinette.chatre@intel.com>,
        <x86@kernel.org>
Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
Date:   Mon, 25 Jul 2022 14:47:43 -0500
Message-ID: <20220725194743.173159-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <CABPqkBTU_StuH_zyZ=22wtV5_V8YDnxRpTSjy4Bg0s=mk8PahQ@mail.gmail.com>
References: <CABPqkBTU_StuH_zyZ=22wtV5_V8YDnxRpTSjy4Bg0s=mk8PahQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d300411-2d48-4554-4d6b-08da6e769229
X-MS-TrafficTypeDiagnostic: DM5PR12MB1129:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0IoTjjvSp+dpXYRo9FXbSh/N3vI2YHAn99sejHcFRU7YMO9dGZw0jsRHSlDrj9cI8ZO7WsE8MECRV2sc3DWsR53PZkYuY9cI4rW/3IWOaXxTveB1wJOaH0gYknJa6uAq127C7kRJdokS95tc36jh/jevcwWHF9vVgbUOZi/kbTdtLSYNClcDQssClm+KdvPfed/qAr5C2o2qNtevoY6vpOmme6SfNU9JbYk1WImEDzT5HRPYIAwVhnW8SLemaLTxwP8IRMp1yvsx+7tpEqK585PkxYtAvJT94JKSE7S9xgs5wlTBLvpDm0um7WwMY4OBK4UsRpgIy3QOXxWJqBOZTVIjmjcPYFequaWZ8rvzUH4FTd0d8bSHwz6uv6hKsq1HEI4VhTTTV0pXqW5ayzCszJgwKjMo0w7/DnjrUcS43+6tNviuTAQh4LbdAag1cqWjjjt60myz1g++uxbqlMwd6RSx9rxS5h9hNpEKqisPfU/bEvU/SiDMsSghYkfmkcdi7GUGvDoKaXj8fkqlSWYX72+mnplFxCrP0bLSTVhnAzImmqr8EBnNPCJsKfFffiCmBh3mNvtQXQq16W/K5EcQiRaqKWUi8WM9qf5YD9G1jzEWDiKrsPwGbmosBzX33xvOJuXZmJ6Y7cVVyhU0Jgo9fXQ8ascSBZnlxTCPxR1Z4/NEXSRYLFU2QiEylw0z1i+TO62ImaWiHmpEU0yIaIexUiacCBhwIYpLc+BW+g7b3ViRH7dYBaNhimDzdxUvjEBN7nPFhH2ihMn62IUInVfsU7HTAsFntZjvHRH678UWuqJY+bvKzvg5UIhbNYGFnu54fFbrY7Ot1QLyEbJzIgkWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(40470700004)(36840700001)(40460700003)(6666004)(6916009)(4326008)(70586007)(26005)(8676002)(7696005)(70206006)(54906003)(83380400001)(5660300002)(41300700001)(86362001)(40480700001)(2616005)(316002)(186003)(47076005)(1076003)(16526019)(426003)(336012)(44832011)(36860700001)(82310400005)(8936002)(36756003)(2906002)(478600001)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 19:47:56.2629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d300411-2d48-4554-4d6b-08da6e769229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate

Sorry, I didn't see this thread. Just noticed going thru the archives.
Replying using "git send-email" to the thread.
 
Thanks Stephane for the patch. Thanks Fenghua and Reinette for your comments.
 
Stephane, Are you planning to re-submit the patch with Fenghua's proposal?
If not I will resubmit with my current patch-set.
 
I agree with Fenghua's proposal. Here is my proposal with slight modification.
 
Thanks 

==================================================================================

Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate

Signed-off-by: Babu Moger <babu.moger@amd.com>


diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index bb1c3f5f60c8..a5c51a14fbce 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -66,9 +66,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
 			.cache_level		= 3,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
 			.domains		= domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
@@ -83,9 +80,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
 			.cache_level		= 2,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
 			.domains		= domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
@@ -877,6 +871,7 @@ static __init void rdt_init_res_defs_intel(void)
 			r->cache.arch_has_sparse_bitmaps = false;
 			r->cache.arch_has_empty_bitmaps = false;
 			r->cache.arch_has_per_cpu_cfg = false;
+			r->cache.min_cbm_bits = 1;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
 			hw_res->msr_base = MSR_IA32_MBA_THRTL_BASE;
 			hw_res->msr_update = mba_wrmsr_intel;
@@ -897,6 +892,7 @@ static __init void rdt_init_res_defs_amd(void)
 			r->cache.arch_has_sparse_bitmaps = true;
 			r->cache.arch_has_empty_bitmaps = true;
 			r->cache.arch_has_per_cpu_cfg = true;
+			r->cache.min_cbm_bits = 0;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
 			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
 			hw_res->msr_update = mba_wrmsr_amd;
