Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1102A58FC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiHKMja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbiHKMj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:39:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017392F668;
        Thu, 11 Aug 2022 05:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjrpt2Q99gHdLGO6qySJB9FdmdSY+RQfCM6rp+gqvzxLy+TOUyJ8CvDd8WkHOvzff5qNIFo3X5HvHqWfvLwKFCpLxtJuWrG4CxNHxvpDVLnUfHO+zqoKz35+JCy2WGxRG152X/bOJOXqik6msCbmlwzS/ihVWRCo89cBQLIto7yaS3fqy56NSd0d9FTSePhyMD+nlftG1U6JhlFOsoKG5ZtXShpscqZ8MbpNTUMwfQM7SC0b6s7iOBavBhB4KCRkjFctDzzhJEljuDN0Q4VGZdPSWm8JeUcn3TZ1iMSa7fRkV78lKgl2c5SVafkkKT2kxQWDifb3B3LXUeXUv6aDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2+iFOgVS7l5nXc91WMm2jx5sfefUwgDb5VFh4qcR9E=;
 b=oZUMeVb3xtuzMnW8dLhDAdeFs3edQXkwEG8cQlehPmiNaoYRMT6l/53nBw1AFidTGOLa/ccmlv5gwkBzZMXmQAX6ND6FLntfVXiCLOFxSkb/Wb9HUQ0LQDJ5YqjF2vT7aKjcQBj+lp8YGB3B4SMJ/NRDEkkKX17i8mWLLbSsugLHM+4GfE2g8CvGD7n7FJXsBTp7ko2QbuBIXhQ12nkzwJieAlz0o7lCzsbzpfiOsrdyKH+KzbKBsh1XsVzfjgyOIF9I1o7vY71Xnd5+R++Fg46oXh6Tip3AJjSaT5eUfhdb/XRJyySVXEYj8PLi1gxFT5uRRZcEdb/zWgO+XaZ5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2+iFOgVS7l5nXc91WMm2jx5sfefUwgDb5VFh4qcR9E=;
 b=AX1P7kRyAngFBy+Yja74l5VU1FWk+ol2Q614SSBuC6YqlblUpN79NU1jp+gXPAFoaObj5zOe+ViigbrmI41AVajdnuhdq0Cie7d9dMN9hVCZDgZbXlULHWUTfuZIRvC5e8KCXRzxneRNCS3Mpu6uhB/4abyZOb0AI8sj+ZplTdM=
Received: from MW4PR03CA0256.namprd03.prod.outlook.com (2603:10b6:303:b4::21)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 12:39:23 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::1a) by MW4PR03CA0256.outlook.office365.com
 (2603:10b6:303:b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17 via Frontend
 Transport; Thu, 11 Aug 2022 12:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:39:22 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:39:16 -0500
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
Subject: [PATCH 12/13] perf/core: Add speculation info to branch entries
Date:   Thu, 11 Aug 2022 18:00:00 +0530
Message-ID: <834088c302faf21c7b665031dd111f424e509a64.1660211399.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d9348ed-25f7-4f04-5d67-08da7b9684a4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4253:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIxpKGAMdgC/aCY2RS2HRUfAXiY/5y/UsHCre3eJn97EW7+ZuNDyIR71u4ChFsUgxHR789kljMsaPH8IhmAYfI8CYTsrvCH2zbMTIJd6j/NReQr2qFK79psyAaW2QZ33/pW08zerkWwQf6ijjEcDgAv/ktXryxtCSwJuBbOeidJiYV2z+BWmstH2vkkHkteG4PhA3dp9KIteBg6H3D7P5OJrBezQWRlU1xSfS41WicU6t8y2ffnDIl4O1cEj+iVmiZ3TyBeVlbKlf+CcxaXTs/S6JcbDwBfS9JQpsT+8ENMcf73GH87NOyZ+dLw2LNUXVpNmamlefmIWw3664WaX6rLoeitDhFFnpRsX5lMpOEFDrucAMo/gfW4g9rDHxTOllXdYxPbNZksCZMRRAP34mLwiLT+d9sOy7U6nRQlVWq8jFIGUmkKWcmh1eumScyN5zW34vcocU9iXjcP18JwKg1XE6mLjKja1vR9Ng/K3pHgkmQMaS4ebglKxQJ4Llk7Ep0TtHW/YzaRKeZ/uh41srS7uQoZZRp41XPnHJtDuyE6Pr9/2dN0G7ppCQzJmX6uvwI0XoT8ruO1Pv/7zVfY2o/rGT7IjZpiUtu8H3XGPszJm0fIgHrIJZK1wr9u24Osxz7yu2KvQUHDnhsZzhvw+O38yfhVFesdke7FcW5beglGfotfS1tBjiwudT0SHRctkMXQ/Kg4Pqj/zIFauwAwIPqq7HnpvU8mJq4s9Ldb+QTLuIEZBFka8hmARz5vQj6eIHQBzeOHm/cYg0WzALLkk0+hOw4I9cGdocnY/Ylzb15i/Ph081+Am3o/av5SHn1YlJwY57cbL7siSUHNJG4tdWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(36840700001)(40470700004)(26005)(356005)(81166007)(82310400005)(82740400003)(7416002)(44832011)(5660300002)(40460700003)(8936002)(86362001)(7696005)(478600001)(83380400001)(8676002)(6666004)(41300700001)(4326008)(70586007)(2906002)(70206006)(40480700001)(36756003)(16526019)(110136005)(2616005)(47076005)(54906003)(186003)(426003)(336012)(36860700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:39:22.5302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9348ed-25f7-4f04-5d67-08da7b9684a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new "spec" bitfield to branch entries for providing speculation
information. This will be populated using hints provided by branch sampling
features on supported hardware. The following cases are covered:

  * No branch speculation information is available
  * Branch is speculative but taken on the wrong path
  * Branch is non-speculative but taken on the correct path
  * Branch is speculative and taken on the correct path

Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ee8b9ecdc03b..ae30c61957d2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1078,6 +1078,7 @@ static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *b
 	br->abort = 0;
 	br->cycles = 0;
 	br->type = 0;
+	br->spec = PERF_BR_SPEC_NA;
 	br->reserved = 0;
 }
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 0474ee362151..9656733a95a5 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
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
@@ -1363,6 +1374,7 @@ union perf_mem_data_src {
  *     abort: aborting a hardware transaction
  *    cycles: cycles from last branch (or 0 if not supported)
  *      type: branch type
+ *      spec: branch speculation info (or 0 if not supported)
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1373,7 +1385,8 @@ struct perf_branch_entry {
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

