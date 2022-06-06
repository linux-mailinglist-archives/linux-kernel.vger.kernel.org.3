Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6803F53ED87
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiFFSFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiFFSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:05:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245FE2632B6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBZLCIhEPAdBf3eZx8bs4EhnfjNSgx+67vSHPuddMjfVxjMv/yAvm7sPKolseGiKzrkqzxcHQc1w59Z1NaMu8yJrrA56iu1pFeiBx2JKY3NIIsg8qIZnxZYW3H/L9gxlCGkmsrC6sgsWBaYOjdsWHjodDdQE2HU73+tIddKi1HhE5ET2euwbYsMNDO6X0SQMgiNXc+Cse7lDQkEExpimXw/mNprcnGr65RQYtHRjW11YokQDHW2B7Tv6Rf+cGZZKBc+iYoM1j/COS+MG8P5tDzEW+KbK6zPdUs9S1PMHiguOXvA/SmemQTH2N857/7u8BGoUlMki+t29VrbYF6E8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRhwj6n7H/X0DORhfgU2ZOXBZbVhNZdUwo9iiZ7Mqf4=;
 b=My9wCfRnNgO+mpw8yquHlunTRbpk8vKDp9uzyaX4TVp8RGxze8/AmmSTLTddptLcPxB+ZWiwJT4boGK6G/HG1Gt9IykLRdqwNe+fpmL/uiSUspngIEMFrGOx84kCDVqwSTPoMF1IqPsGjkUOocTfVLs7qo2RTs+MZhJGwJVD3MB01G7qRGZd0zqDgVh9HcD1pe6lL+pKUfohDCkoZgEOfHdHxglT+Px/ZdUwOdZbPTS81l7oRYzAfTrVEgp0xdkbSoDkBMZOktCo3aWMGHT6/m9pU4p0dURc4pMFVuIRO31nP8lxgTeqOOMmrMN7ovt+JXQKUQpVohmWH82WizSl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRhwj6n7H/X0DORhfgU2ZOXBZbVhNZdUwo9iiZ7Mqf4=;
 b=dwboOlwpn/NLR3z6lT1gZ5ceUhO+UmPA/BqVMMrO+hJJTzKPAhInMSz0gIf7IAm+JXFkDe7P6pwU5JgPkRfIAM0Y5upuaPBm/21QCjM440KVdag9ZSL+3JyMkEJrObYOtGtA7o5BhXNT4OW9LaXBrnwFPmbQJi17JR3zJwb+nvQ=
Received: from MWHPR21CA0045.namprd21.prod.outlook.com (2603:10b6:300:129::31)
 by DM6PR12MB4745.namprd12.prod.outlook.com (2603:10b6:5:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 18:05:15 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::52) by MWHPR21CA0045.outlook.office365.com
 (2603:10b6:300:129::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.0 via Frontend
 Transport; Mon, 6 Jun 2022 18:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 18:05:15 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 13:05:07 -0500
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
        <rui.zhang@intel.com>, <puwen@hygon.cn>,
        <rafael.j.wysocki@intel.com>, <andrew.cooper3@citrix.com>,
        <jing2.liu@intel.com>, <jmattson@google.com>,
        <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v5 3/3] x86: Fix comment for X86_FEATURE_ZEN
Date:   Mon, 6 Jun 2022 23:33:36 +0530
Message-ID: <9931b01a85120a0d1faf0f244e8de3f2190e774c.1654538381.git-series.wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.12ae0052320eae3574e421a17822624143a4bc61.1654538381.git-series.wyes.karny@amd.com>
References: <cover.12ae0052320eae3574e421a17822624143a4bc61.1654538381.git-series.wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd497c00-11bf-4006-b3c8-08da47e71bce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4745:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB474538110E8FE136F7ACDD6984A29@DM6PR12MB4745.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGUkh+EBB4Q4LI+Q1DeeLxqOba5V3zVR199HZxhsYjm9xbN5e9cOWYNXpFMzlIjz0d+Gz2HC5cSvP1JXFlio2jmepAYlZit/JAGER2ah17pp26lhn+u7+qRVmuZ/n8wxuuuU52PhvsuOCvBc8yZ+MrpK0uXIjVMZYJlCwWcIAnw24PpdrLTIwXIb8iDZInPifbn9f+seNLVe2BGgAfln32+c1pF7RpR+h4ZNCAVyzeb42bk6IUjcp+PY0kNfS5LLfnTyJCm4Zt/zVGOFuITMOcYJPsEv+3QeQqXR/0HQEIIJdvWq8yo4A9Iq3aKktnnA82UZreltFy84FlV/glF1ZS2bwhkJvgWznWzJjo6lRE90itFhdAZ3We40eNAJdihQdCJZOoel7UEIR1RiNb3X1F5p4oBBoylf+nJpuWVpI5NAdr6imo23qgl+jEv2S9crK19c2Cp+uNWoEO9yk/RI3bgoifWKXGFIVaHRTL9oAWQexaLHyuSlX9GiP58zJMhI4rFy2XwnCGrPbDWMuyHPhk/7kjGwxHcjhYzYjiWp3doRfqZgyH5d6tCPUNGBgxo74p0U6ynayVxmNF/rjevwx5kLPBoeRBALTrNUp0/XZk4R35uPZs1RhW8yD129ooYnCcc6PGe4VMRfRyEg0cALhrD7ITRNyuZTTfr5NgsKA62CTcqjNZwhmFrtMdKHODGufG0A/QTh0YkMHk+x5+sZOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(7416002)(186003)(2906002)(2616005)(7696005)(40460700003)(81166007)(82310400005)(26005)(356005)(86362001)(36756003)(6666004)(16526019)(54906003)(6916009)(83380400001)(336012)(8936002)(5660300002)(426003)(47076005)(70586007)(8676002)(44832011)(70206006)(4326008)(508600001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 18:05:15.4176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd497c00-11bf-4006-b3c8-08da47e71bce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4745
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature X86_FEATURE_ZEN implies that the CPU based on Zen
microarchitecture. Call this out explicitly in the comment.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 393f2bbb5e3a..140bc82dc9cb 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -219,7 +219,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 or above (Zen) */
+#define X86_FEATURE_ZEN			(7*32+28) /* "" CPU based on Zen microarchitecture */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
-- 
git-series 0.9.1
