Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792FA58FC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiHKMi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiHKMi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:38:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9D310A0;
        Thu, 11 Aug 2022 05:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBdoNzeD9VdtO8gPMV9b/mbFu8l+7LkzeltR0J2qaXyXPNn2sovBi5thXG69hovwQLrXNDI4P7/Z5NYolhQXNJVTAwMH4FGJUdKP1aAQjQBNlhwRUJNrjbucuvMfvPeYIheNJdHLxXffTosxsaS+eyuVGfQoYLuQBWnp3W7N/TIORLfn73e2w5XHZOP2lrmtLJQShaNuhFX0ZsmGDHxUMQDEYTJo6yWcrfNmuKP10AMcWeOs33ZgUfXD4O3CviIKo0jkHyHh75UeKMQ+EnrKuzUYDMd4V0akdM27wxIiCasTdHp5dTVXj18wlfBisze+TPoixfaIEkpTIWnvFZdyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//XiLlN83AusKh8pbLJPsHe5bjQYUkAYzwAsvOBMAiw=;
 b=bfYlHspik7DLtyzVoQITTPpplq6Hcv1ctHY7C+pFCNRzbhsxlZLlFSGOhldzAJPY62DGd9rigyGmJTdU+10UGK8MAQ7ZWXjqDUiVtHOeHSQ8frhN8DyTmE/rgYPBVLy/vts3eILL7AXNdW6QTaLZnp9l+5MBDqLMGye8ZYJkNgMiotdsx5+BPZHf9tJChppkswDtumZkjuhDzVr4otKSRxEq10xmlbYtP2GbZtbe5siK1/fCCujTKYPT92TN2FhdNoJ80wGrmALXusQaXOlvoKnRFlnG67TFdKXdr+sgtVWaL+SIp9oIcXedYUmriuUbFvZOhdS1pBTSIxPkhgI9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//XiLlN83AusKh8pbLJPsHe5bjQYUkAYzwAsvOBMAiw=;
 b=mXk1W0+nKCRdZkWinu5WCF6gDlDWlY7YQxPU1ZugLExFA07tCfeW3uT5e+IJfh31q7ix5MtfGaOAsW7eLcvSpIqhBNl4ba6pLPS/x6g2EP7vSmixVaFhYSUuQ1tuVC+q94LQCWaJ8atDwnKLvDY8wwT5xqsRuWiiSxcyVeesIrE=
Received: from MW2PR2101CA0019.namprd21.prod.outlook.com (2603:10b6:302:1::32)
 by PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 12:38:51 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::3b) by MW2PR2101CA0019.outlook.office365.com
 (2603:10b6:302:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.11 via Frontend
 Transport; Thu, 11 Aug 2022 12:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:38:51 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:38:44 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 11/13] perf/x86/amd/lbr: Use fusion-aware branch classifier
Date:   Thu, 11 Aug 2022 17:59:59 +0530
Message-ID: <c324d2d0a9c3976da30b9563d09e50bfee0f264d.1660211399.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1660211399.git.sandipan.das@amd.com>
References: <cover.1660211399.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbf358ad-d921-402c-83b0-08da7b9671e1
X-MS-TrafficTypeDiagnostic: PH7PR12MB6786:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HzaFiKTqTRpMWDKCKjXEPIZb2SNSj17fYF5oKH0gGINaD6e19P2kSBTvg5yuNwkJKpKzl/HG2uNW9sbZajKLBeOMEjQwXTbAdg1A84mZjmFVuQr8/r8gUBVx/93dgT7TzakS9J6/pIfkzY6VUO1PA72UwiNiGL/4GJQO8w8e5VoLM/aUL2kHMV80hAC67h6fMtda/QCOqiyg6jMexHSLeSpRbj1z1aMzbF0/A1rkpKedXSRFErGXl5IUhgpSraEITMBNVUjAbBlD7/EBDThoxfWaGdBHmJOe8JtukywFRDd+Hadydy6pD8NMQGjItrcQjSHWFp1ImpondBziIHW/Lx/zKNH+EmdcCCvRbuHU1DFmOxN7BIjW9s1xMnWuHpyqI+PbDXTTlZ1HUJYXValzHJZ/1GsD6YQhO8lMXIz1B1GTSoZm172PGBJERQNmjwwLWnL7BbDoCdxz+fT4j6AaFZoQtrhB6bwT0AiBSZ8138e4a8QyJbJob9DiifOKg1eSLnT18RoFaZ1LZR++tFkCR+n4l5XeaYgo1n53SoD4Og4te4/EwEvPxLA6bGuMwnC2ORJLAfHMJLi236M7n8+4f2Vim8OvWw+2EZNPDQq0Ua2gl32Lc1T/+Z+dxhcIXXmLJA+eUbMVkBOQArCvO8x5G5gix+wFqThPYK31jYRHCkVu+eWACWBZhcVu7ZC5+s5HSmCeMDud1sEtmPf7IY0xVX/eD2uRoNbtAD4OBIR1KUaEvN/4YtwtxQTVnfbcs1WVqhpwSLnjn2HA5rJVZvudcHiJq8JpoovVxs1yBThRLlpsv4bWYqB/D9/9pGscPdaYKbjCf9cltn35EtmdicZaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(46966006)(40470700004)(6666004)(26005)(70586007)(81166007)(7696005)(70206006)(8676002)(4326008)(478600001)(356005)(316002)(82740400003)(41300700001)(54906003)(110136005)(36860700001)(36756003)(2906002)(2616005)(16526019)(336012)(186003)(47076005)(426003)(40480700001)(82310400005)(5660300002)(40460700003)(8936002)(7416002)(86362001)(44832011)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:38:51.0387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf358ad-d921-402c-83b0-08da7b9671e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Last Branch Record Extension Version 2 (LbrExtV2) can report a branch
from address that points to an instruction preceding the actual branch by
several bytes due to branch fusion and further optimizations in Zen4
processors.

In such cases, software should move forward sequentially in the instruction
stream from the reported address and the address of the first branch
encountered should be used instead. Hence, use the fusion-aware branch
classifier to determine the correct branch type and get the offset for
adjusting the branch from address.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/lbr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 3699ba53a326..5fa985cd44cb 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -97,7 +97,7 @@ static __always_inline u64 sign_ext_branch_ip(u64 ip)
 static void amd_pmu_lbr_filter(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int br_sel = cpuc->br_sel, type, i, j;
+	int br_sel = cpuc->br_sel, offset, type, i, j;
 	bool compress = false;
 	u64 from, to;
 
@@ -109,7 +109,15 @@ static void amd_pmu_lbr_filter(void)
 	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
 		from = cpuc->lbr_entries[i].from;
 		to = cpuc->lbr_entries[i].to;
-		type = branch_type(from, to, 0);
+		type = branch_type_fused(from, to, 0, &offset);
+
+		/*
+		 * Adjust the branch from address in case of instruction
+		 * fusion where it points to an instruction preceding the
+		 * actual branch
+		 */
+		if (offset)
+			cpuc->lbr_entries[i].from += offset;
 
 		/* If type does not correspond, then discard */
 		if (type == X86_BR_NONE || (br_sel & type) != type) {
-- 
2.34.1

