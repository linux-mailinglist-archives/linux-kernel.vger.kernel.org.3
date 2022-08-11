Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DE558FCB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiHKMra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbiHKMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:47:28 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FA72558F;
        Thu, 11 Aug 2022 05:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXYbip1sKbKbbpwN4gyl0NzVk5+siV1JGpr6VhZGL1q5VK7ILPjSBxNncB7I3sGn3HR/jFQweVqP2VYJHIvuyK3lsAIrE+uh5lHeukII3OrP1TN1Lis1qf7kVm/H6oxEkaaJb6qmBBKPxouYszX+gSUQKZz08jgKNIVEfws68/aEbD9RDk/ij1AD3O683RZwSuOqfODKBPLjdrIfF1LLstzwUBWDBdQC4vfa8g848JQpFrIVYKH+USxclUy0LIirknThmcnH/RRLffZU2N1kByqA6njRXsdCpXIGfcI1D+LksyVzCo6p7DYrb3ZY/Q7KkJq6bCDooAn3pAEiptct3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1t0iDH0AMv/V/mL1L5XFtocytAqY7yTJdjRbU7K11U=;
 b=DdBOZwvwcEntlVFDNmPaFqEzIZShYTXW/sNpuyQQMfQu63+M7fcriqSE3Hu5C4dNCZaCfb2qAOOxQb5sk1iWqUiDTshU9neEMu8S9oQZCfCceGlEG6k7Gnzy3ovMkzlM4oP8nNCLUy0lLRur/wR3ZngsSMlXNNUx7DVgRLh0aa040uydtQwIu4hHEfDnyXmVBHDP03Kq4EIaW4X6XvWzVhRIG91utlPfni6A9+8HDlVT1Si71NcFLGPqKTQT8bBKgBxcGymoDzV/MjSU4i3Xw0JhJK2RA7SezTY91r8N9TdgiYxR/uD4OtAMLv4UJ3Nu3IRItvTnZ5hnyf6/AUpOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1t0iDH0AMv/V/mL1L5XFtocytAqY7yTJdjRbU7K11U=;
 b=j07eP6Y9HRNZ7XVX+EkDtQrMwudfu4UZuo8nqVFjf+Tn+UOhss/x27mD9VQOFGfjR87cQFMf2bGqFI/fQYqor2Bj03GwFtn6tk0MfGeaVwVofnkNbpKafRjROWc6dqldVXwTBZld9Mlw8JVRWRsKfRpfaE3rZGvb5c+36dRKp7g=
Received: from DS7PR05CA0005.namprd05.prod.outlook.com (2603:10b6:5:3b9::10)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:3b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 12:47:25 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::8b) by DS7PR05CA0005.outlook.office365.com
 (2603:10b6:5:3b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 12:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:47:25 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:47:19 -0500
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
Subject: [PATCH 1/4] tools headers uapi: Sync perf_event.h with kernel sources
Date:   Thu, 11 Aug 2022 18:16:46 +0530
Message-ID: <82ca4d1135ebd66884e03e3d4d7d50fbb24d52a3.1660217326.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1660217326.git.sandipan.das@amd.com>
References: <cover.1660217326.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 600501d4-56c0-472f-2f88-08da7b97a444
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QoBEk6+9GhEfk3OwjiJrF6KqYrdDuB+0vtLyOM4wRRzUYYWttT4eHT+BEThnny6vb3zRiXaMGAKhWtiCz7X6+255d/mxanlSR5Ti6+fz5KM6J12XK03CvAg1OWSL4lX1kOWzs0qsaRcOJ5MLKYvYje6aHwC0EtJtoV7DurE0LcCXIPMD0Txb5ab8rvaNORVF/4Fhx+ujFYWseRbgDqUMbbPV1asv1BC+dV24M6RIHffN5gQu/xvbi1hP7JXy2feor8Xxj2XMElHuMKuDRxnEoxn3EJoza5HXIKfmSUgRlLJ/Qrjfs2H2wQWax72YBvrOjEG8FekDDKSB1UYs4rJpDL6jQ4oiiO0i8onWPMPoJMQbnm3Iu174ZMrOb/DYln4hLiG3DkmAgdc627dQW06LnxjOdHQzokCvrVln2rbdaU5m0VdDozl36Twv5veXSJi6dyHkk2lEfbjwQDdWlOyLcEHZyzBhu8gyVgG5xcxMHqLEtS+aje4AnlT603N2VUz1BuMvowWwWh2wzKnRG3o194rOLvo5HyMeKl/XfWMK4S9ROyTKm81V3WdGy4Irs9O7KWdkxth8gBu+3c9zwDcvraK8/BC7QQi5mU4+2bkqC8n52g3O0aap79lXAJMoInq2zXu9p/lxnkIXXWfmMe56i+2wXZQe8J3d2faT2OJoi38F+Lb+/xJQj/AWSi6cd0WrZ1E5TSChQEj1JNF5l+JOQgpDyDoeboL2keYLMU7dOTQLE74Ud56NS879nlq+F0mDowFDhiS4Qw5cEl4hZWg8kZNr55wutyoxlcv1QkNVQYABPW1rjgkVmPi3U+mSyzisZ2KWFg+OAzx7lq2xpYmFpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(8936002)(7416002)(356005)(5660300002)(81166007)(44832011)(26005)(40480700001)(86362001)(82310400005)(2616005)(336012)(426003)(186003)(16526019)(47076005)(41300700001)(6666004)(7696005)(36860700001)(83380400001)(478600001)(316002)(4326008)(8676002)(82740400003)(70206006)(70586007)(54906003)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:47:25.1619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600501d4-56c0-472f-2f88-08da7b97a444
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync perf_event.h with the kernel sources by adding the new "spec" bitfield
to branch entries.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/include/uapi/linux/perf_event.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 4653834f078f..3afda2dc84dd 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -256,6 +256,17 @@ enum {
 	PERF_BR_MAX,
 };
 
+/*
+ * Common branch speculation outcome classification
+ */
+enum {
+	PERF_BR_SPEC_NA			= 0,	/* Not available */
+	PERF_BR_SPEC_WRONG_PATH		= 1,	/* Speculative but on wrong path */
+	PERF_BR_NON_SPEC_CORRECT_PATH	= 2,	/* Non-speculative but on correct path */
+	PERF_BR_SPEC_CORRECT_PATH	= 3,	/* Speculative and on correct path */
+	PERF_BR_SPEC_MAX,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -1360,6 +1371,7 @@ union perf_mem_data_src {
  *     abort: aborting a hardware transaction
  *    cycles: cycles from last branch (or 0 if not supported)
  *      type: branch type
+ *      spec: branch speculation info (or 0 if not supported)
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1370,7 +1382,8 @@ struct perf_branch_entry {
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
 		type:4,     /* branch type */
-		reserved:40;
+		spec:2,     /* branch speculation info */
+		reserved:38;
 };
 
 union perf_sample_weight {
-- 
2.34.1

