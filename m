Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C519F533A22
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbiEYJnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241348AbiEYJnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:43:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A3AE64;
        Wed, 25 May 2022 02:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GROUqNCCvZSqyFomHC2Rj4j97wVAcdQCYcwCXclwKTZv+CeRaO4RAUZcAOAlEs1wOtXgzn71qkR5c/1T09z8a/Du7+Zup4qA7216F1KGz4SjqSJHabmv9CZ0Kx7cNxhHPhrgy0nuVxCq1Jz755AOPgU75lAub4HkaPCrUXiT5/uvrCVw1T5nqniogZXNN2yikzWVE0mHSn9mEjkHAPLJ+sXDunyxoBqitjvfV4uo57OFn5Iu9St1qAqBn6hmA+2u7pajai7FnUrFS2u2HfJGQX8Ef6lZw7LWG1mtGxLms67b/8FDCPOecWum6bEjfZ0qacmef1iiuiNdZVytUCz2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENR+4LziaII21f+R93QY4LuJOSI3+go4bQDIz8S65gE=;
 b=ivRX4YafFidaGUNErcSxSj8jAuwhiF1vN6gVE/3cbWrXqMjX9DGWaGz0Uj3WC84AU1VfJz61X4bfNNG0KQlYO+NKXBWe4x4IaTZMiTSdT4ty/hOACiktcvvNuSrXFMqIXFDKG2pqkAk6dce6nS37fTjw41z5BAgWJc/ue8OrlGF6pgAA1KCqBBYTr2pouo+XLMedVEpTPOxXf+j2rI33DTBOyAlkwp8piZj44QavUmRFjC9Tmj96qsxouxFwY3q+Mf6lePYdVjDf7XWUU6ZbqpMlASoH1dgNt7HEc4k4fv6wCzCLHhwVkDu15sD+EtAghVLJ39wkm6YOCIgkkNOvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENR+4LziaII21f+R93QY4LuJOSI3+go4bQDIz8S65gE=;
 b=I2uqHdVI1ConkQY4Q6CtO5MPH5Mu6H6HWr35mEhFwOcIeXjS+hpefJQHkKjd1GzY1t5SfkCcEuGnG2Nu7PxXFA4oDkinFY1jTYGwfP6u3lt1VOxl1sTzvqqMRLLbeSVY6iBcOu+O0+LM8hJrFoGQRCCHJTVB9CZs7RGY6NBCx5M=
Received: from MWHPR17CA0084.namprd17.prod.outlook.com (2603:10b6:300:c2::22)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 09:43:21 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::1c) by MWHPR17CA0084.outlook.office365.com
 (2603:10b6:300:c2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 09:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:43:21 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:43:09 -0500
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
Subject: [PATCH 07/13] perf tool: Sync include/uapi/linux/perf_event.h header
Date:   Wed, 25 May 2022 15:09:32 +0530
Message-ID: <20220525093938.4101-8-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525093938.4101-1-ravi.bangoria@amd.com>
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72a3b10b-e8e3-4aef-d2ae-08da3e330165
X-MS-TrafficTypeDiagnostic: CY4PR12MB1815:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1815EB0527AAC3A3896EF17CE0D69@CY4PR12MB1815.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TU53N56dj4mx0rsLp+gEEtrnfq7n4pYjCVrPjQys2x7Aq8RpHJGt8ScGCUD5HnfSZOVrUWXPNf3O5agivJNw9/fLlIBs/4u3g43yE+ReOdqfl/CsMI4moyiTGFXh/RQ+RdW2rPIJkWMZ1k+SzjAosxzxuZRoEs/4gSio0cHk6ik+QOpV6sVAO+YwzRTya6fBwc3XR62pf5B4K9OAy4q3ac+oNW7+0bNOyZ81lSGkDIzxI8RCmA2p0agNeGDZDEaiFpwLEcvWZbDcYG+3IqnwaiJ9RbWyssnudsGhmbDTxzCuc0f59+CXZFiOKo7xYYO8yMvhplzE51fkkZyFk1ATHmZ8ioRQFMH30FdnkuLiDYiVF5f0A8iZRU0l7C8ZvB9x5mrZ35IxA80aHyj55sKiBgKgLUy4Pp4y8CML3wvhOL17gQPkSTKklY+u+DbNMOGUcHRsOxKKQrQnvdSavdFuVs/94iZPAHT5Nk3FkiM1t7z8aBk3pvLmLYHfPWNm+OP5Rj34xN3mvfZHWw1MpaX/pt0ey1/Yn7et1v6QPeZdS3vjk4vg6ZF4jOo5r0H1u/pqAZki7D9AWaIQt+vnmWBC4qVoO6xC7ioOKCxcDd3rhiHiwcWsNwZdl7QNf5bSePUQzK9rr3+hjTcNDXF0sOUQUpZjY/ZWs2M4kuUQFepTZz0XZhsCEOTS/30mz3Rf+eflK+RX9KPTBfYBdG4f1Zr1MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7416002)(5660300002)(4326008)(8676002)(83380400001)(2616005)(70586007)(47076005)(40460700003)(70206006)(110136005)(426003)(186003)(6666004)(54906003)(1076003)(36860700001)(8936002)(16526019)(336012)(508600001)(82310400005)(2906002)(36756003)(356005)(86362001)(316002)(81166007)(7696005)(44832011)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:43:21.2176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a3b10b-e8e3-4aef-d2ae-08da3e330165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two new fields for mem_lvl_num has been introduced: PERF_MEM_LVLNUM_IO
and PERF_MEM_LVLNUM_EXTN_MEM. Kernel header already contains those
definitions. Sync them into tools header as well.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/include/uapi/linux/perf_event.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index d37629dbad72..1c3157c1be9d 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1292,7 +1292,9 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0xa available */
+/* 5-0x8 available */
+#define PERF_MEM_LVLNUM_EXTN_MEM 0x9 /* Extension memory */
+#define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
 #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
 #define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
-- 
2.31.1

