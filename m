Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8DA54E036
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376814AbiFPLqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359774AbiFPLqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:46:38 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAD658390;
        Thu, 16 Jun 2022 04:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTXLQQ8quzYAE90u9QAc4kTPb8safvjCGqnrpsCRG1mhTx2tDGZaeY2UzdjRc4D0O1HNw0szcvR0m1OMcd8dWuwjyEbeMuCCY9/wdp9aQq6Z4jhYY7vU+Ympv+MCKPos6INfpiSW86aySHG8BYyQsmb357GmWCsxjza5hJT7Yv3zukmGMfiWicWMEbFURX32jYsvXqrAHzW7xXK/BXtLQcPJMHFpSmrcxZLCOOfP+fO4P02UQsBSI3IZzDrGwbg2D3ZE3ylzQMC5RB3w7zmN2mGzF/y0e//2Gqbs81l3jCuDYep0bggRKghuoeafsmN8UebK/proEbOAkWcwiBfmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwf0LYghRj/MX7Bc4AMYtMHjzPr+hbxVZGEoLHCN0aY=;
 b=ncCn/i2SlNNhtr3YrwJg23N6MjJ8VTUPY7Egya65D3vX2VEfllpNR+nwdwpTWYL0OmurVlvo+efI2oAHw2YBXzo6zpU+t9sQKOXv+5COWIg5NJA/vuvNuKJamB8wsU/wXDYaOKSKul9uxlACh7PuGJn873XXJ2uS2XuzngxoKeitV3R9KOIm5IkD+wwpB9cWizprJx3lfHTuhnuwKKZvKh0AjB3zxwJgL5BqyRwDTl3kznsW1Hf6/+UGXtOPwDWUTYc9s/MXYX3EmP3KSnuYtxX0zd1vZQZt+9Y//zuKsbTWeSS8p9jtAdRsCngX4anc1YlxIHQgfueJDMEZdRgzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwf0LYghRj/MX7Bc4AMYtMHjzPr+hbxVZGEoLHCN0aY=;
 b=0IPLBGCUcQYMbz8hTmVhBvBMjFls5EooAA1tNyBXFxDHftEJbDMjUA8oTGOiBXmATv0x3mwJMoCdyGZzsVj6EJqVmyzUhO5Fv8puMIjCZd45R4eq0AqF6uHfYRIsLGwkVohUYPU4ycHquuuG61DqKryGkUxlD8+K8GYhBYhRjWM=
Received: from MW4PR04CA0349.namprd04.prod.outlook.com (2603:10b6:303:8a::24)
 by MWHPR1201MB0015.namprd12.prod.outlook.com (2603:10b6:300:df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 11:46:32 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::4b) by MW4PR04CA0349.outlook.office365.com
 (2603:10b6:303:8a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 11:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:46:32 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:46:19 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 08/14] perf tool: Sync arch/x86/include/asm/amd-ibs.h header
Date:   Thu, 16 Jun 2022 17:06:31 +0530
Message-ID: <20220616113638.900-9-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616113638.900-1-ravi.bangoria@amd.com>
References: <20220616113638.900-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fef424df-efc4-4d97-f9e7-08da4f8ddbc9
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0015:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00156405E74118F5687A8ACCE0AC9@MWHPR1201MB0015.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /h93i7WdP/CPqnONMdNN+iqA1tSvL4sXKyHpW5m+zay35VUd3GxM4Vm9aH01NSzIbAKe967HuegszSTYGwbNxzmGZiNKxgWXsN/rvvk2eVg9qirjgkmstjztDigkvGza6K8KRwqIbVZz7xSS9eb5K2buOg62T8r3RiQywSJccz4axa4SJalSF6NYQ0NFjCaAH0RP+5xc1B62R+aGDeg/koGLAvuWALKNkCb7Cj+/KTvzQaLBZKft3OqyfGfmNROwPvrlYAJkARpPkTxeaQZ3n3iYrn5IBQYtxf7tWatREFX1U86gYJ0YFuPiL/+UXUVB1qwFsnrR2ybXHSDJch4Z3I1SvPcoakAaMoxylMs80Da/eJdvDkMTbAF1r8cpIx6fA2HHJmeJByoLQWmSTWpNZGStoYLtDXEl9v+W99TQWaJ/iWdzD327T095UiXqUu6SXGYQfGbfKE64lzbOEQYvLdo1k1M9PU5HYNG7J8CtC/t8eSmcOmJByyJWPbSdEzkaNj7AdxSuC1nQhpMzKFREyI6Efh1bW7Vb+E0opxSAXiDaE9mERGwxH12cCeaKxoR1Yy9dIxGhz4q8t0uBBfE1aoNbGBz8H4eXfdAwHSWvT31lJK2yI3SsqJAwKAVqUXaV7KRsPJ0jqUOq7sI9ob///7HQDH36SXPxryEtAWYwGUIHQhojyBweSkDLsgzHkkgOsr3kYiAV5CmFPtbwGq07QA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(6666004)(86362001)(54906003)(508600001)(4326008)(110136005)(8676002)(316002)(70206006)(356005)(47076005)(336012)(36860700001)(426003)(186003)(16526019)(7696005)(70586007)(26005)(1076003)(81166007)(40460700003)(2616005)(44832011)(8936002)(7416002)(5660300002)(2906002)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:46:32.0901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef424df-efc4-4d97-f9e7-08da4f8ddbc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although new details added into this header is currently used by
kernel only, tools copy needs to be in sync with kernel file.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/arch/x86/include/asm/amd-ibs.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
index 9a3312e12e2e..93807b437e4d 100644
--- a/tools/arch/x86/include/asm/amd-ibs.h
+++ b/tools/arch/x86/include/asm/amd-ibs.h
@@ -6,6 +6,22 @@
 
 #include "msr-index.h"
 
+/* IBS_OP_DATA2 DataSrc */
+#define IBS_DATA_SRC_LOC_CACHE			 2
+#define IBS_DATA_SRC_DRAM			 3
+#define IBS_DATA_SRC_REM_CACHE			 4
+#define IBS_DATA_SRC_IO				 7
+
+/* IBS_OP_DATA2 DataSrc Extension */
+#define IBS_DATA_SRC_EXT_LOC_CACHE		 1
+#define IBS_DATA_SRC_EXT_NEAR_CCX_CACHE		 2
+#define IBS_DATA_SRC_EXT_DRAM			 3
+#define IBS_DATA_SRC_EXT_FAR_CCX_CACHE		 5
+#define IBS_DATA_SRC_EXT_PMEM			 6
+#define IBS_DATA_SRC_EXT_IO			 7
+#define IBS_DATA_SRC_EXT_EXT_MEM		 8
+#define IBS_DATA_SRC_EXT_PEER_AGENT_MEM		12
+
 /*
  * IBS Hardware MSRs
  */
-- 
2.31.1

