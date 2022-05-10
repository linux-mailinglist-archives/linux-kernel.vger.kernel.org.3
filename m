Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED678521214
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbiEJKYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbiEJKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:24:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32864CD3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGE3u9EffQSyLPf6n2zL/z/rdusBJmyuw1fhIXLEwEv0j60pRxzq8awv0IdrRlJV/nVNyEVSz8W3cMyyiBXjOgo/DgW95LabHHR4s95iA2nVwHzwfRq3tlPSB8mwhn3SQjEmbWQW4dKyKyp9KdbfZg1oF5ePcGIARQ63QuDkYETuHK1OcGqvjd3Md8GVV9fljw2JLAwhCvWRq5aoaLslO42iNMuTqxdMC78gCAo3aydeGl3nlWRH1YifywU/SBbnx11faUK8T1H0bY5TC7Wo/oIl4UX2tocg1r3KCXlro6YBtiiWu1J9/EzSsX1fPEY0pFHGfhuxTtO74q30yOfqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIqpqyUviniMJbUUwuT95FlH2q8CMHYa6C1LqZZbqdQ=;
 b=HNulXOtCT0WQ9HslzOJ9BTW8KopMBR8QDMRSd8yRwJwcwz+2flISecABJld2DZ59VUIlJ2fCQXliwj8oaiXiv/B8u8YveAPrSjuQXF9LvCUrdCGI6MGDoNSm8Bf+x6rW5fAt7ajDFQ0E6WMj5mfNIluAdFJN1KTXCMrmbZsJGn25f3LCHNENXAoIDIB+IGBmyO5AJhVoxkNUyfDs69jM8hXV4X+YBV/MCgNcYDRCG6ismgBzCdoNxz+/Sfys8+yVXoegr25uAma2UbDUWogs2bHm+LHqkiW8x9GqmY0OBzNiunDXwbwWYsqXCDH+YCkpARiA1fVR+sK/H/XYK+pXhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIqpqyUviniMJbUUwuT95FlH2q8CMHYa6C1LqZZbqdQ=;
 b=IaQj1wBw3c70lHqPEx4y6BQAApZpPcqfui6UnChU/dut6SiUIC0czqXK5CdwACadNVAm5pOLYF/JxrskS0e4dWFAczH0F1a0bFE7YTSug0/oxBBCEANPGCQeIciLUp8sf2v74Rythm81+njqAGK8VNwq6I9NdxMCA2QM9Ou8UrI=
Received: from DM6PR06CA0028.namprd06.prod.outlook.com (2603:10b6:5:120::41)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Tue, 10 May 2022 10:20:42 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::38) by DM6PR06CA0028.outlook.office365.com
 (2603:10b6:5:120::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 10 May 2022 10:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 10:20:41 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 05:20:34 -0500
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
Subject: [PATCH v3 3/3] x86: Fix comment for X86_FEATURE_ZEN
Date:   Tue, 10 May 2022 15:48:08 +0530
Message-ID: <9566b6fe4c9da433a0ff6c0b61bc93adc8e29a44.1652176835.git-series.wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
References: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbfb1b1c-27f2-4edc-952e-08da326ebca9
X-MS-TrafficTypeDiagnostic: DS7PR12MB6215:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6215192F190AB3FE955F168684C99@DS7PR12MB6215.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WSatCUDje34pT7Xcyo96vpOsHR5TxaBI5Qglkj6bG1HLO2Zq79WWqR9o6UmHVehuM98ZAR32iYrwM6TvLSIJp0IlzhQiQGPXU7wAvpNOFBVoWmizQ9c2e21JJe0XUsNVLJXWq98fLxrhwu5Pxj0BdZmuzAP0ig0UQvAsbeIzA4PRcJfPnskxXDqQwXNGPW4HUUj8T2OnQMDSP/FWQVBTo2V9ERidIUM6v8JmGyAt9fZEyDEXowpYL3jb0fmwKdlj5X7HJaFKKkI91kUYhsIMj2tQO676d+z/Kjfdl4c6t9nsjJPLdZEGIlFeTmYjG67vYZ/4d4hzU6YrEB1xV9uPxkumzJ4VvFHuLUSwwf0+ulcB6ZMVbo2DlWVBAGWIOLHXfsSbsqIrJSyDO2lA11UQwX9zkx/Xd2IPPcij96Id2CK5H/FtoKxaxyD/XadcRyJH9jLfHJuV4AfOdnbcdXKg4v7G8TuRlEEK3gxPkIB3wiF3O8mz7+Df8cmT5O6Mye6tzeR7sJ9Wg+sCo8ozK/8D+yFCL75THCPME03KUgt/im8fbFD9A4WVBM/6R8r1ykSNWxsF+bPtOwERRzmmVQ8BmFJIOgcQhMYAta+F3vZW7kb6aDB5ymjXCAxYu3tgI83COKEV24Z6h59cmhJXl35USEhf7kLfGqlEhyCmGqBy6JMjGdDKt8PPlnS+AU9P+BfZuJOCRt9TXY9hmt/24jGdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(2616005)(16526019)(6666004)(356005)(36756003)(47076005)(426003)(336012)(83380400001)(8676002)(70206006)(81166007)(7696005)(4326008)(70586007)(40460700003)(82310400005)(26005)(36860700001)(5660300002)(7416002)(86362001)(44832011)(54906003)(316002)(2906002)(8936002)(508600001)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 10:20:41.8430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfb1b1c-27f2-4edc-952e-08da326ebca9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature X86_FEATURE_ZEN implies that the CPU based on Zen
microarchitecture. Call this out explicitly in the comment.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
Changes in v3:
- Verbiage fix per Dave Hansen's feedback

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
