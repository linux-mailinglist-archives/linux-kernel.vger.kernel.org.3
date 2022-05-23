Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF940530824
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355605AbiEWDlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355561AbiEWDku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:40:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2058.outbound.protection.outlook.com [40.107.101.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DDB35DF6;
        Sun, 22 May 2022 20:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TE1b0BPHudZd/T1eorf5CibF1z1GRr8uM4vUz2qzVzn1+WuMMQso0+h4Fef0Qwhtyi5gnKRHtXS22mkcl0Fz6Yccjj4+sYGFwMN2xUeUJsqGYSDeQowsqX4ZXwl96R24wJ6dXp3PLTOIZmUvQdSiBh6DDnCPkK6z1FkTB9S5nKOPDrXSrorecqGKNZO5btF9Z+27DoBk9q0g59Iv27X3eCI4YuF8cG3PwicEMS3KE4LwPD4Az43fPIeAi2o+HkZcgc/YaFAOP/oDTXBw+HFeCBgdo2Gls0eIsflKf5h2vgKrJZMFXZhzG1VYq2j5lheTLBlI3VcuCgAG01aeoSosMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58OUnmftGccIflpVRC3kry/dTTF/1fMLkNTsUzjZkiY=;
 b=QJx0wQW2T0vxl00gMXYq7feXkiG77if2QNmgTK+nlgkpxMKs4UAbShbSQfEX1swX1HDJg42/C+Oo5Pv9/dXkjr0oMnmasbBhmQgZf4CDDUbj1LRcC1Q5/1eDbCnGZLTLhOkLh1ev6YZzqPIvtSMUwfAzUzCsnGv78unFAt+BRTc3GeH9Ge7mmVYBGu7rfgIxBqjR27C3KCoi0ehXicTdjp82J5hZovalb8ryk8j60k3RvZLUlhzj7DOh9RrN2V/K/O/HAuClFdWh3VUpm+WO8JYBESUwQ6kNK07skKii3gVyNOc0ovW9GZ33+iXOj5mJpFSqAbOclxnRUU8v33qSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58OUnmftGccIflpVRC3kry/dTTF/1fMLkNTsUzjZkiY=;
 b=uo7pAJN29YFdZIgtG3hiS/Qcywd+WGKyxxGMoTTzyRHOSil9bE7NmDlqZGRAYsD8dXkBc1E/w+055c3+t8pNcY5uxvBJFbwMIoGWWgLeZRbqbBs/R7VYHqCWzHe+cntm88LHQNZL8asFps/e8JfGFu+0T86alzQAiIzWW+WEF88=
Received: from DM6PR05CA0056.namprd05.prod.outlook.com (2603:10b6:5:335::25)
 by BYAPR12MB2870.namprd12.prod.outlook.com (2603:10b6:a03:12d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Mon, 23 May
 2022 03:40:44 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::1b) by DM6PR05CA0056.outlook.office365.com
 (2603:10b6:5:335::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.12 via Frontend
 Transport; Mon, 23 May 2022 03:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 03:40:44 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 22 May
 2022 22:40:33 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v4 3/5] perf/x86/ibs: Add new IBS register bits into header
Date:   Mon, 23 May 2022 09:09:43 +0530
Message-ID: <20220523033945.1612-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523033945.1612-1-ravi.bangoria@amd.com>
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 682f6cf5-857a-4548-11da-08da3c6e0447
X-MS-TrafficTypeDiagnostic: BYAPR12MB2870:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2870B6BFEB04D0701AD119DAE0D49@BYAPR12MB2870.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kua0w29eJoS0y7N3v2rqpzsQ0GmMGVYw6IfupwptO9NM0OzvTUunA+oX9OdSjBXSj2p5Gq1olypUZw1Dnrs4v517Du3kODmmvafv4SBsorbQDDh9E4hT3EFoN/8MD+263pPb/FeY0nMFniZU6aS6H6cjF0sWkDxtEv8Bbw/Xzw81/hHvMJRwJYoexbAdmm1WvybBiPEDMfhbWyDyJG4jHdtOk5M5BEKQwOoTzL9BWr2ekgYeOS7vVxjYaClof2UuvTquW1WSjL5NZIWhJxk5K7QGscHP4dDn4URAXVvtRAbsd2R8Yj5kuf3aLG/FxSDajkw7DFZGUe7Q+N6fkLq7FLxGTv2Qc3qTJezTt9tS1Ck/ht09f/RbmxZuQp4dHlvN3yRWxkKZm3Vm3wN6c+5qkmDXVOhAZyo4tRIU6t1uFEHDJVlkOpOZ3YdWZpnxrY4a/jabZmBgAa1hzWIusuAsB3V/zZq+orYPCBDTOU4UInuwvZ1JNo74vE4J6EW003xdawSixGbaXbNkskvu7zzU4GNGe2EOFrboW4LflhxdlJkmkH+nmnMRcExVrAAnsARIe48hAhH31TMspL/cFF5H8ce0UDTGhFfuc4Cpm5JKRahl70BCK+uLetW+znTeg0z/nAKI1fr1HvkUqVMIJdVOos3L1FZ2C/8+VvPZO1Bx4CHlAYnLSnjWoD6ZDcYbJx/bwPbICn7R67DdqjkAAEe7Qg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(7416002)(6666004)(356005)(508600001)(2906002)(316002)(86362001)(82310400005)(26005)(44832011)(40460700003)(54906003)(6916009)(7696005)(4326008)(70206006)(70586007)(8676002)(36756003)(8936002)(186003)(16526019)(5660300002)(36860700001)(336012)(81166007)(1076003)(47076005)(426003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 03:40:44.1088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682f6cf5-857a-4548-11da-08da3c6e0447
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2870
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS support has been enhanced with two new features in upcoming uarch:
1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
has been introduced in IBS registers to exploit these features. Define
these new bits into arch/x86/ header.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 arch/x86/include/asm/amd-ibs.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index aabdbb5ab920..f3eb098d63d4 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -29,7 +29,10 @@ union ibs_fetch_ctl {
 			rand_en:1,	/* 57: random tagging enable */
 			fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
 					 *      (needs IbsFetchComp) */
-			reserved:5;	/* 59-63: reserved */
+			l3_miss_only:1,	/* 59: Collect L3 miss samples only */
+			fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
+			fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
+			reserved:2;	/* 62-63: reserved */
 	};
 };
 
@@ -38,14 +41,14 @@ union ibs_op_ctl {
 	__u64 val;
 	struct {
 		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
-			reserved0:1,	/* 16: reserved */
+			l3_miss_only:1,	/* 16: Collect L3 miss samples only */
 			op_en:1,	/* 17: op sampling enable */
 			op_val:1,	/* 18: op sample valid */
 			cnt_ctl:1,	/* 19: periodic op counter control */
 			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
-			reserved1:5,	/* 27-31: reserved */
+			reserved0:5,	/* 27-31: reserved */
 			opcurcnt:27,	/* 32-58: periodic op counter current count */
-			reserved2:5;	/* 59-63: reserved */
+			reserved1:5;	/* 59-63: reserved */
 	};
 };
 
@@ -71,11 +74,12 @@ union ibs_op_data {
 union ibs_op_data2 {
 	__u64 val;
 	struct {
-		__u64	data_src:3,	/* 0-2: data source */
+		__u64	data_src_lo:3,	/* 0-2: data source low */
 			reserved0:1,	/* 3: reserved */
 			rmt_node:1,	/* 4: destination node */
 			cache_hit_st:1,	/* 5: cache hit state */
-			reserved1:57;	/* 5-63: reserved */
+			data_src_hi:2,	/* 6-7: data source high */
+			reserved1:56;	/* 8-63: reserved */
 	};
 };
 
-- 
2.31.1

