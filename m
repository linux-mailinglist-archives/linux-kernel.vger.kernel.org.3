Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C9A533A18
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbiEYJmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiEYJmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:42:13 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58522651;
        Wed, 25 May 2022 02:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMukFw75M4dICexb3xvsEKcNvlTjfxfkCCHmeYuwiROVUlbw4uSMtVHmID8F3bBquBRlywARSo6A2f4j8l7h4ZUDL/ZHObnEX4ec4LwMJJ722U+2ehyNmi8NKKt9cZRmb2A5x08cK1E/3/89iIRlSrjk4I8RR199Kfv5gi8H3K+2hJOCgfMS5hZXsOMZrU3jbU3ZFRWHmyGWoFl9ZA0YvowcrOb6IOXlIchx2p2BPMguBGnC7UE2PgAOhRPxObw8gHI8e8Cn9R18Z4+d+dtD0Qpfz8Hgwr3/y6xi8j/0Q0Et31ZiGR5aMNs+TwCuMC8oMH5u410n5Av2rJEuigFwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJfXpIxpeMOccYL/x48Px3+t//tkT9knW2nYeGpr1wc=;
 b=Nm4O9+yYqQV2lr/PB0zYzCBf7T/Jo4adqPgJboZlGv2bCdrDFIBZN3S4f9FMQuCCdnQQaaQoUGZqcqruvOxwYS80XWbvmfNm7hG0bpAduFDLaPcdCjyhpjhA30zSjcttcUHc5Vw/0cHcimIKNjcPN3zMnB6ofoOqWR5DPorY0gVtQTyV6QAt/5XyLik59fcuLnV636MwYjacF8Tf/7FS7k9p9El4GMZX1UqBhJYHQXAXemOrpOthE7lPJhYzGpjReY3LRRPO55TXdhfwkfHZe0P8OQEG5BhMyyEjFJWGfy+cxC5bKnZ/2+FFjlY8g6BreAUtYynxD403kPoKSk3ZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJfXpIxpeMOccYL/x48Px3+t//tkT9knW2nYeGpr1wc=;
 b=RNwRkA1sFLl5RSTB7sm4DFx4jL0x+6udJRiKCDZSuLyg2NczTRdPzQsdUWGFLlxvefFo40k1aYhRakF/UwvnUMSian4v0NG1ELlWbu29gocBvjZzS5QgDl+R86y4BacDklRdSgXrDXlhvImCXVedezERfNbD+XRIIHqAkne6mGI=
Received: from MW4P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::25)
 by BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 09:42:06 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::28) by MW4P223CA0020.outlook.office365.com
 (2603:10b6:303:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 09:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:42:05 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:41:52 -0500
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
Subject: [PATCH 01/13] perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Date:   Wed, 25 May 2022 15:09:26 +0530
Message-ID: <20220525093938.4101-2-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 91c09ff5-9c80-49d5-ba99-08da3e32d47a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3192:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB31929516C8B1F0B84D26702CE0D69@BYAPR12MB3192.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +scz1VKPq/dVPt2pfzo/dYLHT/4dySZTMPw0QM1e9BSuAQiE72CWhhPPofWgevEMwydMrOVgDUaVhpv/0TkY9hRgDqfIzsDMXZOr/vO/kX4iipki8Ys+6DuFMzeKyDM3jDvmFcpX+8F0x/ceAvnl8OM6UMPXeKk8BiFrb5OauYpuLzMxhwDB6R/8v4Tdj5JVjs7yl/fhlnDaHUIAEcR6L6zQ4qhWsMlwTMqrKqRaAjR2lFY9jRPJPx7tkRWQIE53bhBLwmpDEFn/VcmQAspR42FF3zi6Ut/vQiL3M8dN0A/L7asMZimBUVUoWUQNJ1COZ6yYgiZy5xQGvnXwgbcjK99bifp8QjzCDgWLfu9IdW+OXZAkF5Oipvqe8vvKE+LnDZVkjpV4wM7stcgNPBoR0M6CCFhC4bcpTf3aaZQCnYE9wLTu9xi07PXp+M8Kr7DkrheFCceV3d+D3lb0prlhM6iBtvVdAXhjqyNgb7T+bVF8Q/tgejKXSkzC8WBxIe1FO8EvEUjKnlKABFE2bJAwZFmgwrjvv6gUnfm/h3bsC74H1MTO2F4KgoLkyuhDlIYxVuwT/fKCuqkX23O5BQf77c5kVmIzwoVe7AsrF6FIeKL6MR/adrwMsP6kPIY0Jovx3RZHnx0o7eNM6qJizIxlW1b5brPgljY7/4G6PMQqGUdD/JPjgWciGw7ziaz9OZgJCS8aRRNfg5Tj4ToHBYvsaanRUoUemvWCfi48G/JUMAY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(16526019)(70206006)(86362001)(4326008)(2616005)(70586007)(186003)(1076003)(7416002)(81166007)(5660300002)(356005)(44832011)(2906002)(8936002)(83380400001)(36860700001)(426003)(40460700003)(6666004)(7696005)(8676002)(26005)(508600001)(82310400005)(110136005)(36756003)(54906003)(316002)(47076005)(83133001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:42:05.8571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c09ff5-9c80-49d5-ba99-08da3e32d47a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PERF_MEM_LVLNUM_EXTN_MEM which can be used to indicate accesses to
extension memory like CXL etc. PERF_MEM_LVL_IO can be used for IO
accesses but it can not distinguish between local and remote IO.
Introduce new field PERF_MEM_LVLNUM_IO which can be clubbed with
PERF_MEM_REMOTE_REMOTE to indicate Remote IO accesses.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 include/uapi/linux/perf_event.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d37629dbad72..1c3157c1be9d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
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

