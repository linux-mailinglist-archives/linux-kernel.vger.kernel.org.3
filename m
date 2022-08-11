Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BF058FCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbiHKMtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiHKMtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:49:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D73F90C7A;
        Thu, 11 Aug 2022 05:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c23tGYEufZ8VII+Z437WH5L7lbQ9By9U8pqz9rUEIYqwwPPnU29i2O8qAGBdqAxkhpewMktklaK53QNwIa1Kp2eY+FrCd+pZZUWrFYOnCU0Texnk1oR4cXMm/0AHZUe+A2zBo/FBctyPzYKmz2TuOLkFLMfaoxrRo2LRVvKXzUggGNByKwTbVnV/mlzp/IB0vKVU2VRjRVryAkipV6Z5juHKSr8b7rVTqRnBQ6CvGSUBp/+qWk+eJNYmvcwb7EArn1f+NAef0a/zIF4bjm/tEe0vWxzi4lhRRjQptrVjQh+zUN1F/b1zQOT8GF/VJkjhiho1BThCRveICbfzEnkKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJkb4zZ6v/xGwPLK7YyD4jii5d461pZFtjNUvdB5twg=;
 b=Wq5Hricz+kBnvWYZp3lqLWIGXX7rTYzBOcXQEEyFQVtNWzJ0dUiTioeHLUQSCzospXeedKwuHj7nkyp+oqDmHmY9kmEZCV/Hw/wTXHaW4ZC+ahmg9lYSqMDXooFkCfQTHRe/b/HxgOLQ5ALqCrdwn9h293ghppgTVCxV2+EmFlKGe4tTTJoEoCuPqbdUNDP2gvC/INd53m03hpWFhiLW9LFk9BljFSfs9Ty2YiCucpznlmOWM7N2hxOqQ/Oz/0LhFw323u0wqzNPsltBp2Ga+E9iMyoR1CEBaXPM9CBKueN/j5EoWiTg8olT4u7z1DeLib7eN9ucVpSF3+w09NdysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJkb4zZ6v/xGwPLK7YyD4jii5d461pZFtjNUvdB5twg=;
 b=Qq6PZWvf0ZW7F00RmpNKULIywFQ4coxMT/baiuGpi0HW6siQwZJ3wmYQ+EISPWuvM80kMUixcub7NXk543pehruTYE8/i90fQMYTgUOI/08PTgTqUbvNtsGAN7crfXI4fFc2o8hWKoNedNSjpz8xOmz6HlEoxzlkFYbZcpG4YEo=
Received: from MW4PR03CA0246.namprd03.prod.outlook.com (2603:10b6:303:b4::11)
 by CH2PR12MB4937.namprd12.prod.outlook.com (2603:10b6:610:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 11 Aug
 2022 12:49:00 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::fc) by MW4PR03CA0246.outlook.office365.com
 (2603:10b6:303:b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Thu, 11 Aug 2022 12:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:48:59 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:48:52 -0500
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
Subject: [PATCH 4/4] perf session: Show branch speculation info in raw dump
Date:   Thu, 11 Aug 2022 18:16:49 +0530
Message-ID: <1b95e0aaedfb167c6780761aaecd08ce93c1c765.1660217326.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0942bbe3-33b1-4d1c-4aac-08da7b97dc85
X-MS-TrafficTypeDiagnostic: CH2PR12MB4937:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JT37nxO1owwImY2160AGc0rvcS+xWw84v71GUMjqeFuSkLSIez5e2kxp4t5a1RObCpYxFFeIfWgrK8swLrhh6+8ELpyzTIILV5DjvnlJVY2zdDElenj8tgP4ssAFXhdfaVL73+NsH/5qJVbaRIz9DNcq2d5j74TzDRtZAkqEvZPQO2zTmWxq8yks5ofw9GFXyYdR/Yot/P/kEQ76QYZqHu5vM9ZRMjrD2apWHTuFZjhwZEKLP0NZKIxqs/H/TZJna/rDvDyGeKAiyCVF1VDLBut2eRMboZyE9FpAv+xriCEj5y5l+aauL+5NJuRSWncLep7TajuEImQppDf+3i3c9nuI5FZEjes7hPqec2XQZI0Drqkxs5LLkZvTEP5Ckne4v5rZirK3Fvs5zCdA8F08rfsYiVZiY77hRIU5kFeMgHexTEjBc/eqYfVJBkpD4N1bcHttmzwaLb0AqryfhFdpl8v77Rq1rQ/drLtRMIl6xQRLJxn7NQf6L/L+vXpjaPNDLf+sWgiKbWr6gruy+6X0zb89kGsuM4U91TQyCndu+5mNum2TZynIMf6KoCPpv5SFAbEpzUIJ2FJ8mBzGqDdlM0FFAwWoLe5LX/TCyIwbdMOwz2qr8ftp1l/ZeE/3z1Sr3wk5+xpMiiVjdTwgATBVTXA0TjNhXIf0NrWdeZ8ii87HfYNBZWM34zKvbKG0F83kIMgmajuGl47sbOTUTrYhHVfOe03nKk1K3O9SvyKGpfqfVFmFHjkyrB078H7oVynWVDQLKGhawIAmGYP0/sA4PoVIum4YUy4u8wQZgGJUyuLZ6upePYbXfBTekPReUwVdlRkFBvcI+GIqbgZTs/fx7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(40470700004)(36840700001)(46966006)(7696005)(44832011)(2906002)(7416002)(336012)(6666004)(41300700001)(426003)(47076005)(16526019)(186003)(82310400005)(82740400003)(83380400001)(356005)(81166007)(26005)(2616005)(8936002)(4326008)(36756003)(70206006)(40460700003)(70586007)(110136005)(54906003)(316002)(478600001)(8676002)(40480700001)(36860700001)(5660300002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:48:59.4628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0942bbe3-33b1-4d1c-4aac-08da7b97dc85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4937
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the branch speculation info if provided by the branch recording
hardware feature. This can be useful for optimizing code further.

E.g.

  $ perf record -j any,u ./test_branch
  $ perf report --dump-raw-trace

Before:

  [...]
  8380958377610 0x40b178 [0x1b0]: PERF_RECORD_SAMPLE(IP, 0x2): 7952/7952: 0x4f851a period: 48973 addr: 0
  ... branch stack: nr:16
  .....  0: 00000000004b52fd -> 00000000004f82c0 0 cycles  P   0
  .....  1: ffffffff8220137c -> 00000000004b52f0 0 cycles M    0
  .....  2: 000000000041d1c4 -> 00000000004b52f0 0 cycles  P   0
  .....  3: 00000000004e7ead -> 000000000041d1b0 0 cycles M    0
  .....  4: 00000000004e7f91 -> 00000000004e7ead 0 cycles  P   0
  .....  5: 00000000004e7ea8 -> 00000000004e7f70 0 cycles  P   0
  .....  6: 00000000004e7e52 -> 00000000004e7e98 0 cycles M    0
  .....  7: 00000000004e7e1f -> 00000000004e7e40 0 cycles M    0
  .....  8: 00000000004e7f60 -> 00000000004e7df0 0 cycles  P   0
  .....  9: 00000000004e7f58 -> 00000000004e7f60 0 cycles M    0
  ..... 10: 000000000041d85d -> 00000000004e7f50 0 cycles  P   0
  ..... 11: 000000000043306a -> 000000000041d840 0 cycles  P   0
  ..... 12: ffffffff8220137c -> 0000000000433040 0 cycles M    0
  ..... 13: 000000000041e4a1 -> 0000000000433040 0 cycles  P   0
  ..... 14: ffffffff8220137c -> 000000000041e490 0 cycles M    0
  ..... 15: 000000000041d89b -> 000000000041e487 0 cycles  P   0
   ... thread: test_branch:7952
   ...... dso: /data/sandipan/test_branch
  [...]

After:

  [...]
  8380958377610 0x40b178 [0x1b0]: PERF_RECORD_SAMPLE(IP, 0x2): 7952/7952: 0x4f851a period: 48973 addr: 0
  ... branch stack: nr:16
  .....  0: 00000000004b52fd -> 00000000004f82c0 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  .....  1: ffffffff8220137c -> 00000000004b52f0 0 cycles M    0  NON_SPEC_CORRECT_PATH
  .....  2: 000000000041d1c4 -> 00000000004b52f0 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  .....  3: 00000000004e7ead -> 000000000041d1b0 0 cycles M    0  NON_SPEC_CORRECT_PATH
  .....  4: 00000000004e7f91 -> 00000000004e7ead 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  .....  5: 00000000004e7ea8 -> 00000000004e7f70 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  .....  6: 00000000004e7e52 -> 00000000004e7e98 0 cycles M    0  SPEC_CORRECT_PATH
  .....  7: 00000000004e7e1f -> 00000000004e7e40 0 cycles M    0  NON_SPEC_CORRECT_PATH
  .....  8: 00000000004e7f60 -> 00000000004e7df0 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  .....  9: 00000000004e7f58 -> 00000000004e7f60 0 cycles M    0  NON_SPEC_CORRECT_PATH
  ..... 10: 000000000041d85d -> 00000000004e7f50 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  ..... 11: 000000000043306a -> 000000000041d840 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  ..... 12: ffffffff8220137c -> 0000000000433040 0 cycles M    0  NON_SPEC_CORRECT_PATH
  ..... 13: 000000000041e4a1 -> 0000000000433040 0 cycles  P   0  NON_SPEC_CORRECT_PATH
  ..... 14: ffffffff8220137c -> 000000000041e490 0 cycles M    0  NON_SPEC_CORRECT_PATH
  ..... 15: 000000000041d89b -> 000000000041e487 0 cycles  P   0  NON_SPEC_CORRECT_PATH
   ... thread: test_branch:7952
   ...... dso: /data/sandipan/test_branch
  [...]

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/util/session.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 98e16659a149..39ba4a21aa42 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1172,7 +1172,7 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 		struct branch_entry *e = &entries[i];
 
 		if (!callstack) {
-			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x %s\n",
+			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x %s %s\n",
 				i, e->from, e->to,
 				(unsigned short)e->flags.cycles,
 				e->flags.mispred ? "M" : " ",
@@ -1180,7 +1180,8 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 				e->flags.abort ? "A" : " ",
 				e->flags.in_tx ? "T" : " ",
 				(unsigned)e->flags.reserved,
-				e->flags.type ? branch_type_name(e->flags.type) : "");
+				e->flags.type ? branch_type_name(e->flags.type) : "",
+				e->flags.spec ? branch_spec_desc(e->flags.spec) : "");
 		} else {
 			if (i == 0) {
 				printf("..... %2"PRIu64": %016" PRIx64 "\n"
-- 
2.34.1

