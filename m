Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094DB54E023
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376843AbiFPLjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiFPLjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:39:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A83D56204;
        Thu, 16 Jun 2022 04:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT95Vasi2RBj9KtLCyQrkOTc9o4Z7CMaivcfI4zPkJg+bXzawpZaMiNcYv1QNc1yZvH0b4IFsGcVmsan3cUBCuwJiFd8cE+CDKn3YxVNyXwPj6Q/RxvKlmkEHl4JeJD//cnhzD0RUvPyvp4B/RQmyPlWx5xsNjWq1DVX8GgXMx4zF0xJrOf421i0Rl90n2gtACokYB06u4UlWqe6XOJPhdLxuQMRb1us1wUc96jOSf2rugK0Z7veoetl7iANir7LoLTDlFnz66BZVSGwbMDMsQFVHqpkSlKY5loqVY7MN0KQr3EhTvofujOekEZWqrFcD+Q4bKzCnXLycg65m+GoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DeGxgUBJRpfzVWKCL9N8CnPijMTF8INV82CdAozipw=;
 b=h7AGNK/M+ABOxwjiK0CJrqmfmGnR68k6s7GTuO8r5CIY3jjMN+78okD7Lgu4ofZfHxlB84cDD5lHxQx0LjqyOID6XOXIhpJS+vyQkHww7Ngiq7iELQu99+rW+3VEYn5SE0cSteeldXCNzbczxb8KQahOSwvXx1dkxe0xc1dnLxv01kXNLjUuN0L9ol30RqXnhfUaw5IyonCV5JA2ILcsPk4v8FumQp8+F/90DGzZX3NwySziWRdtue1mrc9O7vDM2Pufj1pkBix6pAUPq2bzLCL6kXJa9jz0ZteuMwPnke/uk1R+T2dvvPV1QGzajHtiM8TP/H+BAMvJ680uTcI5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DeGxgUBJRpfzVWKCL9N8CnPijMTF8INV82CdAozipw=;
 b=B7+PelxxFLNBhEYSXx6bXnpXu6v11FFZMIYG2TTM9+Vg0bTzkqcyrmznQv2FH+91cfcV7xEfKzvGxpX9V6difqqwNXx93DsInsBR99AhaKnRPu4tOBLikurto/l/IaW+Si4jzSrjRTf9rP+HX5PV9hzDqD68HganrixTqSrs3UM=
Received: from MWHPR1701CA0017.namprd17.prod.outlook.com
 (2603:10b6:301:14::27) by DM6PR12MB4729.namprd12.prod.outlook.com
 (2603:10b6:5:7f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Thu, 16 Jun
 2022 11:39:41 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::d3) by MWHPR1701CA0017.outlook.office365.com
 (2603:10b6:301:14::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Thu, 16 Jun 2022 11:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Thu, 16 Jun 2022 11:39:40 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:38:44 -0500
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
Subject: [PATCH v2 02/14] perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
Date:   Thu, 16 Jun 2022 17:06:25 +0530
Message-ID: <20220616113638.900-3-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 49742303-3d8c-4ac5-9f41-08da4f8ce652
X-MS-TrafficTypeDiagnostic: DM6PR12MB4729:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4729EC0FDC5BB56D416E1A00E0AC9@DM6PR12MB4729.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFS4kBPE07OcTT6z2HiOIQIVMTwhv0nhsy9yj8HsMxTbWe1Yd5R/eHV5/xvNZ0pRGyZFfWD3jz1/5KtZq3fLFqYVdQRb4G0Hl0gjDW7RHV9vpvpdU99OP1kE4PhMmzH9k70Eu79yNz9scl9OZzEaL7p+25cny3BPhG7T1OqSjdqXEwvnAr92eUBL27tEz76CyKyXi254U2BaDfDl5aDua1+9v1rKBuQdYQLOA6hLDWRgWJZaKoaWcAhkMbu/sLgsnbvxafhxue5wU+rCwXj/GGbEFJfWPUN/u07bgxL722S6mQFvjgtbpD1tcyaB/OFxh4QxLkXKTosLZ5UDO2m6urKiAJN33mStdC8N7gyMVvqI/0biUSlF9CT/gXzcBt3VvUzGvSyv2eAN2v49luSdWTRTA37DpbJbS3Vbg/MXPxGVerVe82jDbBJnEDCt4FD9I2mTiY10ko+9MTlaGw1yl9CoP9LmRaROLl+PdVNiUMSibJHp4aYx2Uq+/YSsYQi2NGfDABqVobPANfYbMqZd7AUqSfXnWbGmVDvljmCpJNcKpFNKH7s5HwE+e228u6DVuzbu4oNQLdSYy5UBCgfgyKnODmteMVV7Cj7p6UaTrLPlOwjv+4x7VtbV6+cMUXBjFu8YzAJVXg+1HtT9pXTgCgG1Pm/71uzSUvdsEBousTJrQ7b+EXWtuBviW+VpXUAnsMxRIHeckV0KqJvj9gHGbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(44832011)(316002)(4326008)(186003)(2906002)(5660300002)(110136005)(86362001)(70586007)(16526019)(8676002)(2616005)(82310400005)(7416002)(1076003)(70206006)(83380400001)(54906003)(7696005)(81166007)(498600001)(6666004)(8936002)(36860700001)(47076005)(336012)(426003)(36756003)(40460700003)(356005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:39:40.2661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49742303-3d8c-4ac5-9f41-08da4f8ce652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4729
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS_OP_DATA2 DataSrc provides detail about location of the data
being accessed from by load ops. Define macros for legacy and
extended DataSrc values.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/include/asm/amd-ibs.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index f3eb098d63d4..cb2a5e113daa 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -6,6 +6,22 @@
 
 #include <asm/msr-index.h>
 
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

