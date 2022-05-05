Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730A351BDB0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356507AbiEELIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347727AbiEELId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:08:33 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2084.outbound.protection.outlook.com [40.107.102.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0447747AE1
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyBHKxViXD25ZDjmQTsUZBZF/Lr5vcEz7jA9evNlZeUOaqI0UnXcNo+bIMiKebUDAqO+YaPyffxY3FscxelhmDZQ+i4gKqa4kW3RJ7KZIUPgVFQd+mxLCdJRzKBZdHwEmgYGYxIJ6+5lmq2rtKI4DfKzKqoyBhYHiFVLXcKF/ykdggxpuf4NSw6yWW68LnpOZSKi6y9CuBM+qDJMpxr+Azmln2PhN5P18Ilx2st3fNavMSv3xSb4FCycCy52HPQ9RiLujKWCrrfsY5ma88eng5vOac5sbjibuzb9S3DTMimvS6I0pj+MA1r0q+05uWBCwKIQVpNvJ1gNK2NA6nP5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQZYKsXhr5TqkILzTN8gwNMamwyaDpKv5mixrF6mKRQ=;
 b=euD3+BdwBRQ6WR6i7br+IUuHEFvz2hQfwGQnty/xj0zjuFb0Pn6EowqFL8zWZx/nS4wO4kYFjmf1kGP6YCJK0i7ZlBXsHvY9N4DlIMxeB154nTn+CSlsLKfHSxk7vvsP4TAoLrwoIwMbGHOnY+YeylsrwGvUP2NL2XCow9+aMPVux2T4BlaCKqulZ2SC9rm2Kc+R3IkZ1Qxe2HAu0PcCPuUG1fqlPf+mPbN5WBuxJHwnwM9GqOvDQdAc1Bh44R32DwL1HDkR/Kh/v0BdOFjXT73deNDM1NnpbnocB4MFAg0BAtWnYzsR0tJ9ZDhMOl2r5TBoFLLfWBgCNHRsJkSf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQZYKsXhr5TqkILzTN8gwNMamwyaDpKv5mixrF6mKRQ=;
 b=ehB1UDwM9mZD24y/h4UxAqVR2a/QFaHm4Y4ZEODaZhm5bm4CN5A616B3kd8SQg0F+dbA5L2CeHMnQ6RTrGxh5WsGEDpY8vN+k0hryqWBAOvpbuHX1WrP4+v6ie8k/zS+AJipkMvA0r8wF9PwYJLs7G9koMU1aFypLXavCaMSyaQ=
Received: from DS7PR05CA0048.namprd05.prod.outlook.com (2603:10b6:8:2f::19) by
 MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 11:04:50 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::3) by DS7PR05CA0048.outlook.office365.com
 (2603:10b6:8:2f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.7 via Frontend
 Transport; Thu, 5 May 2022 11:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 11:04:49 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 06:04:42 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <Lewis.Carroll@amd.com>, <Mario.Limonciello@amd.com>,
        <gautham.shenoy@amd.com>, <Ananth.Narayan@amd.com>,
        <bharata@amd.com>, <len.brown@intel.com>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <peterz@infradead.org>, <chang.seok.bae@intel.com>,
        <keescook@chromium.org>, <metze@samba.org>,
        <zhengqi.arch@bytedance.com>, <mark.rutland@arm.com>,
        <puwen@hygon.cn>, <rafael.j.wysocki@intel.com>,
        <andrew.cooper3@citrix.com>, <jing2.liu@intel.com>,
        <jmattson@google.com>, <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v2 3/3] x86: Fix comment for X86_FEATURE_ZEN
Date:   Thu, 5 May 2022 16:34:29 +0530
Message-ID: <20220505110429.453279-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220505104856.452311-1-wyes.karny@amd.com>
References: <20220505104856.452311-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02649c6e-c331-403c-537c-08da2e8712fa
X-MS-TrafficTypeDiagnostic: MN0PR12MB6271:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6271F9D46EEAB26C44F3AEF884C29@MN0PR12MB6271.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dquG9FH+1+Dr+ChxW3MRbcOFTKRrRpf3tONaXPycJMyn9Z5k5UEVIRf6Z35+UnVSqvo9LV4IBzPCgMdmSVmJE6QC9fd0/KEDodsnAaeqA9l8qH8QrizbdzglPr/bGJoJbTpvxD8vUAWIOrbjyVOYuXTLbekIt2mh/nz9tAiqWssWzQWiuVfSnx8hEs3Fg7sTSueAskcEZDfuVxYFVRx9wXc0TtRMC02cZUV6nrUoWu1RVS4UPd9aiG+YYt5Uy2Qf0xhm/9dtKq1IJfErWN8HDObMO0Xp6WBqv2rkPRkuy/uenPsJ4vka2yYcI4lfc2AmAkTV1Bnvf7APzWdT6v42wtKoIK+T7e961/2NrDDrJLKjDIEm5IDtYvBHsGKLcGZIlEziyEKi9XQf+kSFdc7hWa5xYhEEM0H+ISBN+ol0QNAob4jD42aY+UtawuPuuXSSSUjtyDAP/IdjB0JxlAM4XcfqSsOLwxcHPI1ZhARVMssIyYqEDd1zWXmOJe+LoUkiptZaPI9spXfLfL591a7kZB+DKVQluMcm/5bQpkalCSMxTgoaTBozmavfmpqEPmDIh4KOrgQq7vELACYYoKGgDv7zU86SUFeyylTpq4/4IF/rU9X5XDid0OVsKodu2sdgsp9rRYPJ1YJgcLwhAy33wN9OM3LM+NcUiV7+Zn+znwe5EvRw3STD1SvLX2HCdOrxVzuaTZYYYF5IOz/klYSiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(86362001)(40460700003)(82310400005)(26005)(316002)(70206006)(81166007)(508600001)(356005)(8676002)(4326008)(6666004)(54906003)(336012)(47076005)(7416002)(426003)(7696005)(186003)(83380400001)(5660300002)(2906002)(6916009)(16526019)(36860700001)(1076003)(2616005)(8936002)(44832011)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 11:04:49.9423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02649c6e-c331-403c-537c-08da2e8712fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature X86_FEATURE_ZEN implies that the CPU supports Zen
microarchitecture. Call this out explicitly in the comment.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 73e643ae94b6..c851ab4e45b9 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -219,7 +219,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 or above (Zen) */
+#define X86_FEATURE_ZEN			(7*32+28) /* "" CPU supports Zen microarchitecture */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
-- 
2.27.0

