Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75B45316EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiEWQ5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbiEWQ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:57:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E6D35245
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyXWvrOSUfDPleNwMYcfJKLHcuimQjg24gvw/Inm7CUWjp21AOAYggoJRIH7nTN3N87/J+17RxHuaTZCh0zgvyPAAVxnJh6lpiG9eJP4vWQnYazcZa4NOa8NUYDJ6md9rIl0WgvByE2WoTsZkX+ZICbovoRbrW/uRRKP/Pz0ZDR/0y/OFIgwHIBwkE7oAc/ChvKLyyhv6Hr55xe7N3bWC7Sc4BTHAL63gxtTIJ2WeqJqNYuaXbe/SLIrIWGjzpGLv/UIDuo/4dfFM3cwsdTtgPB8KsIEpaeoMr5ti9Oh58asdEY7D61uDhOunL2enHmUZeZP38Aj94GRHXp3Dk+O+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7ECY2R7lfPhHdoS6gi72mheN9mfHiC20ANwgk5qNUw=;
 b=boD9AetC3GJXmSqtazfmsIZ+XF0zaLkMprGRUolo5PeGEUDekx61xc3BrO3WVpxu97gB/tD+rjh174bQSeFutCGiw71/M6yB9wLf7vTo0+SrutfOpSsBqoKlwmZOWYicoaHGftn5ILMMg9k+/2VE+hBgN0xG9yv0Hyq4SJr6+UAMxSzMkyh5IsWxDj9QfsyyBXp0mJdQV1GXGSDSZMzKDPuSb+2xb2wDeoBh6jUowLqIeFyUe/t2mq8o27K52vT32y7o2hO0aTXvezvn7JFwmFs/rP6vqcZUpMc1Bf4eK7o8i2fhK8/d3LJ9LCgYJWCUyx6HX03To4H2IfoLPFgrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7ECY2R7lfPhHdoS6gi72mheN9mfHiC20ANwgk5qNUw=;
 b=gp20cCtOpD7cgxRhClfhDyN1zktSQ0OP4cmG55WdI78zzczzlBB3S+qEyCJqE068eSln+YQTKsN50py+FQQ8OC213rDOIZA8wuv5X78KMaZTecec3YOwvYfZSQDs9WsEh/O2gBQma41+VChCL2UTZHLK3b91UrhZCgVuYQ1Wpm0=
Received: from DM5PR06CA0092.namprd06.prod.outlook.com (2603:10b6:3:4::30) by
 DM5PR12MB1641.namprd12.prod.outlook.com (2603:10b6:4:10::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Mon, 23 May 2022 16:57:34 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::e7) by DM5PR06CA0092.outlook.office365.com
 (2603:10b6:3:4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22 via Frontend
 Transport; Mon, 23 May 2022 16:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 16:57:34 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 11:57:26 -0500
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
Subject: [PATCH v4 3/3] x86: Fix comment for X86_FEATURE_ZEN
Date:   Mon, 23 May 2022 22:25:51 +0530
Message-ID: <2333afe4e6acb52999c941ad20713d1b445223bd.1653324016.git-series.wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
References: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d819281-39a4-4aad-8471-08da3cdd5577
X-MS-TrafficTypeDiagnostic: DM5PR12MB1641:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB164100A94CE44B0DA96DFCDF84D49@DM5PR12MB1641.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTIWPe4r35KCRiv67ncvlsK0IPaDkJPP81smlfILJEgbGlK6yoSdxUPrm84EwTEgEbJh+FvZbSuDMznlpYVb5/XbkJgRDlqRLj9YpnNQ9r98QjOm2fXmq3OCRqGEjQMtPD4/amGkGljvzR0hQDJrZ0rVBsajaNYSPqBad94ybT/6NVImbdk/psWtlk4J4T7lWb//uqQEgCWthrCIbaxdHIKYDju+ekgmIxid1TLwqgTjTlq39ZH5cf/ekVj/8108mFfIw364GniXKmvo7RfrxU/An6qO7SMCpBIep1JBmplaYPAfrjrMvieIAOI4agy0arSHejgneyG4ueZcPzCditRXIG0HmRKuc+UdMR3vgvbGzvtScRZujYFgrjfYpUNt9pn5YE+y34Y6lDElZDj21NaWCzxQljSu4iprZeXFoQPW0b/GCp83alh8nJEkCVrEN2jSUKixbqQ0bELyyXaTTomXzk7vL0R7wIKWNzZVK7dlhks1k8Ieq0q+JJTFt2r4RMIK4ZnnFaLvp8F/Fiwm94J3Yll8mYgpwUB9ueNnPSls6cWIu9gdb5U7uU79I8MXKwYbKFumJj3gRk4tS49YJGR5L+fV952b2sl6ohVnCQKYDvjCac3rXeUXskhB6FtlgdntTPVhU8f3hPxa0/twWVkzqbRHnuQO+7/Hb1KkEUTguZ5dv0lIAF/mU5CPFkQTL+5gvq4FmKgrJQxZ2MspCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(4326008)(70586007)(82310400005)(81166007)(5660300002)(316002)(83380400001)(8936002)(7416002)(44832011)(2906002)(70206006)(356005)(86362001)(6666004)(7696005)(426003)(2616005)(26005)(186003)(16526019)(336012)(47076005)(54906003)(6916009)(40460700003)(508600001)(36756003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 16:57:34.4744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d819281-39a4-4aad-8471-08da3cdd5577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1641
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
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 73e643ae94b6..6141457cda38 100644
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
