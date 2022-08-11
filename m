Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25958FC78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiHKMii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiHKMif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:38:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0FD5245E;
        Thu, 11 Aug 2022 05:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4raxouhj3+vy+0d7dgpSedEijZ5vRcdMmwtjfchkHV+c7XEiclBoFwlfUCR1go4F5OYT4x6G9AwEk3CjIKn8pdt23MJZ0+Q4NWZtS4yhXuIGluS1qatHkfp+w2WyL11HGeqzzF4fGXmU5NEgKdDbwG0O7wyvQjio59j/MmUW+xq8HeRloZXnE5lMQgL65BIoybQpkCAB1G/F3feEnqLNlhvNLj5sCIRsdX3KPs42/AMG9XWRA+sUg4qBK8FjT3MrAX0GZ8vCHMWkzlCcrMlOTZ9xKUavdY68vspSamfQ+Uv02HFRUQ8Vo2xtKw7apnO6W/OfGTPEwJxUcn1A91ttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0F3Qt7+frbXmBj+cK0wsc3uIDhXET7lHywC5bF9h910=;
 b=AY0XBIqfXTOGcCb9TC3ptzAYwYBcyA4sFI0FTXjQQqv2v3YsNxoepuEHHgshrbe+XX7n/FyTg99hb7tEyhdjdkxsRz1a/i4eCj2deYfEdsONRLIIcbGnIlCzV6YcbroFtC0lvYE6qZSHfeFMxBvE6Sy1vyB6PZSbIhhChjEQPl5yPRlu3e5Jrt22Z3k6bibtNsU4OcUTAFCboAjpF59IEGBEnhj17CkhgLsYoeRI9FuIeHHkaMEtEIXvFMYA6wbPINo1uwQEc05wafAUuK4ZchqXpNO4hLr6UYUB5WtjdqmsASrDBCi1tEjMxgXg48W6pnO2PnmmZuscZAxkGSZSFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0F3Qt7+frbXmBj+cK0wsc3uIDhXET7lHywC5bF9h910=;
 b=lLrHrAEQrYJ7Vy/czC4XumppGqAP0rR/Z/0llezxc6Tr8ZIBtdZwPq6slJEykOtZWUnD+imGWZYyEzROVYuZYvX6EAby9PppXg7g8DmtT+GGT/LY+Pf2jTKX9Dy0qtrSpbL+YU24qcncayXKuxI34S9H3muJCMBBvHHRtgn24bc=
Received: from MW4PR04CA0189.namprd04.prod.outlook.com (2603:10b6:303:86::14)
 by BL0PR12MB5540.namprd12.prod.outlook.com (2603:10b6:208:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 12:38:32 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::28) by MW4PR04CA0189.outlook.office365.com
 (2603:10b6:303:86::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Thu, 11 Aug 2022 12:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:38:32 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:37:34 -0500
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
Subject: [PATCH 10/13] perf/x86: Make branch classifier fusion-aware
Date:   Thu, 11 Aug 2022 17:59:58 +0530
Message-ID: <b6bb0abaa8a54c0b6d716344700ee11a1793d709.1660211399.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1139e959-7de1-42ef-6c56-08da7b9666b4
X-MS-TrafficTypeDiagnostic: BL0PR12MB5540:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZmisqu5837xjngcH5kUyIzdaxdbHRWW849hRPVcqJIdI4woGznBxGDnZKtxDhX0aMh/bkENPPzVD6PymexkpudeI2fh8XbvTdmLNVzqR6XWB23Z1JQa6B+XzZwqqJtIe4LGQTz+OFI6e2MKxTYPBq+fU7csvRK/kXial892N+jgfc4NMc6buQMbTKI0OTV4CSv3OVk2qyjdUFpgAZ5JEKq5Wwer0p3tsh/C7eKAj4d09Ucy3lFMYMhOVFNPZ4dsvxxzBwWKD0tAmBGAGC9+LW2wpWeM2101YuPJag/UouePEjAglGpNtQz0DS5Kaaj3VKM2QH3EmVZ0f9oq4oklJnL8NGo/t6tIJfXYUEnMYY0vGzmffsvb8e0MRXJo8m6cjBRgNcPUFMhAaj4duLdk60nr08WsyrVKbXz7Aa9e9xR/bm8r9nynNzfrV1wNl49QvV4APENn0t7G886/D75FyaeqbH7hZd287138FOXyLUJHlC/SL6YAIWLgqPPe5uBUhyaWr4HWWT5d3SeQOWFPE91z0NpSG7X5cDpREnaf+ejKPokd7sketu7EhNl9dT5cr5ctYQfWFurMdXjL63/a7v8534xiqxn+prrBr5C0+IT6gg8HYSnbMapkkpqYYFcVWZc5QllorFoWvp7gLr1krz6SryLeMzLxqAEJwBRohFx64z5z4M8JBFcwvG44gLuheHsO+Qw0QsMKteSc7O+NVcF3v3+amT37bIS6JOEXXpFQkIn+4TV/TSQeSi7wf1xgSM/4l0RdCc+n/+YAZaO23OgcDJJ81y+LAKIqwAWz0i7DB3moKuYpLzNEtqiLwJ7ETLjJE++LVUrQyzTK4a6JGyJErYPjHFwS/F8bRptGI4M+T2OD7BJlRxlXAG8MDnLYc4JbPW+w0Cq2GqMEg+efPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(40470700004)(46966006)(36840700001)(26005)(41300700001)(478600001)(54906003)(316002)(40480700001)(4326008)(40460700003)(82310400005)(2906002)(70586007)(110136005)(70206006)(8676002)(44832011)(7416002)(8936002)(5660300002)(82740400003)(36756003)(36860700001)(86362001)(16526019)(81166007)(356005)(426003)(2616005)(47076005)(336012)(186003)(6666004)(7696005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:38:32.2101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1139e959-7de1-42ef-6c56-08da7b9666b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5540
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With branch fusion and other optimizations, branch sampling hardware in
some processors can report a branch from address that points to an
instruction preceding the actual branch by several bytes.

In such cases, the classifier cannot determine the branch type which leads
to failures such as with the recently added test from commit b55878c90ab9
("perf test: Add test for branch stack sampling"). Branch information is
also easier to consume and annotate if branch from addresses always point
to branch instructions.

Add a new variant of the branch classifier that can account for instruction
fusion. If fusion is expected and the current branch from address does not
point to a branch instruction, it attempts to find the first branch within
the next (MAX_INSN_SIZE - 1) bytes and if found, additionally provides the
offset between the reported branch from address and the address of the
expected branch instruction.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/perf_event.h |   2 +
 arch/x86/events/utils.c      | 169 +++++++++++++++++++++--------------
 2 files changed, 102 insertions(+), 69 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8ac8f9e6affb..eb6227630244 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1269,6 +1269,8 @@ enum {
 
 int common_branch_type(int type);
 int branch_type(unsigned long from, unsigned long to, int abort);
+int branch_type_fused(unsigned long from, unsigned long to, int abort,
+		      int *offset);
 
 ssize_t x86_event_sysfs_show(char *page, u64 config, u64 event);
 ssize_t intel_event_sysfs_show(char *page, u64 config);
diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
index a32368945462..e013243f360c 100644
--- a/arch/x86/events/utils.c
+++ b/arch/x86/events/utils.c
@@ -3,6 +3,68 @@
 
 #include "perf_event.h"
 
+static int decode_branch_type(struct insn *insn)
+{
+	int ext;
+
+	if (insn_get_opcode(insn))
+		return X86_BR_ABORT;
+
+	switch (insn->opcode.bytes[0]) {
+	case 0xf:
+		switch (insn->opcode.bytes[1]) {
+		case 0x05: /* syscall */
+		case 0x34: /* sysenter */
+			return X86_BR_SYSCALL;
+		case 0x07: /* sysret */
+		case 0x35: /* sysexit */
+			return X86_BR_SYSRET;
+		case 0x80 ... 0x8f: /* conditional */
+			return X86_BR_JCC;
+		}
+		return X86_BR_NONE;
+	case 0x70 ... 0x7f: /* conditional */
+		return X86_BR_JCC;
+	case 0xc2: /* near ret */
+	case 0xc3: /* near ret */
+	case 0xca: /* far ret */
+	case 0xcb: /* far ret */
+		return X86_BR_RET;
+	case 0xcf: /* iret */
+		return X86_BR_IRET;
+	case 0xcc ... 0xce: /* int */
+		return X86_BR_INT;
+	case 0xe8: /* call near rel */
+		if (insn_get_immediate(insn) || insn->immediate1.value == 0) {
+			/* zero length call */
+			return X86_BR_ZERO_CALL;
+		}
+		fallthrough;
+	case 0x9a: /* call far absolute */
+		return X86_BR_CALL;
+	case 0xe0 ... 0xe3: /* loop jmp */
+		return X86_BR_JCC;
+	case 0xe9 ... 0xeb: /* jmp */
+		return X86_BR_JMP;
+	case 0xff: /* call near absolute, call far absolute ind */
+		if (insn_get_modrm(insn))
+			return X86_BR_ABORT;
+
+		ext = (insn->modrm.bytes[0] >> 3) & 0x7;
+		switch (ext) {
+		case 2: /* near ind call */
+		case 3: /* far ind call */
+			return X86_BR_IND_CALL;
+		case 4:
+		case 5:
+			return X86_BR_IND_JMP;
+		}
+		return X86_BR_NONE;
+	}
+
+	return X86_BR_NONE;
+}
+
 /*
  * return the type of control flow change at address "from"
  * instruction is not necessarily a branch (in case of interrupt).
@@ -13,14 +75,22 @@
  * If a branch type is unknown OR the instruction cannot be
  * decoded (e.g., text page not present), then X86_BR_NONE is
  * returned.
+ *
+ * While recording branches, some processors can report the "from"
+ * address to be that of an instruction preceding the actual branch
+ * when instruction fusion occurs. If fusion is expected, attempt to
+ * find the type of the first branch instruction within the next
+ * MAX_INSN_SIZE bytes and if found, provide the offset between the
+ * reported "from" address and the actual branch instruction address.
  */
-int branch_type(unsigned long from, unsigned long to, int abort)
+static int get_branch_type(unsigned long from, unsigned long to, int abort,
+			   bool fused, int *offset)
 {
 	struct insn insn;
 	void *addr;
-	int bytes_read, bytes_left;
+	int bytes_read, bytes_left, insn_offset;
 	int ret = X86_BR_NONE;
-	int ext, to_plm, from_plm;
+	int to_plm, from_plm;
 	u8 buf[MAX_INSN_SIZE];
 	int is64 = 0;
 
@@ -83,77 +153,27 @@ int branch_type(unsigned long from, unsigned long to, int abort)
 	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
 #endif
 	insn_init(&insn, addr, bytes_read, is64);
-	if (insn_get_opcode(&insn))
-		return X86_BR_ABORT;
+	ret = decode_branch_type(&insn);
+	insn_offset = 0;
 
-	switch (insn.opcode.bytes[0]) {
-	case 0xf:
-		switch (insn.opcode.bytes[1]) {
-		case 0x05: /* syscall */
-		case 0x34: /* sysenter */
-			ret = X86_BR_SYSCALL;
-			break;
-		case 0x07: /* sysret */
-		case 0x35: /* sysexit */
-			ret = X86_BR_SYSRET;
-			break;
-		case 0x80 ... 0x8f: /* conditional */
-			ret = X86_BR_JCC;
-			break;
-		default:
-			ret = X86_BR_NONE;
-		}
-		break;
-	case 0x70 ... 0x7f: /* conditional */
-		ret = X86_BR_JCC;
-		break;
-	case 0xc2: /* near ret */
-	case 0xc3: /* near ret */
-	case 0xca: /* far ret */
-	case 0xcb: /* far ret */
-		ret = X86_BR_RET;
-		break;
-	case 0xcf: /* iret */
-		ret = X86_BR_IRET;
-		break;
-	case 0xcc ... 0xce: /* int */
-		ret = X86_BR_INT;
-		break;
-	case 0xe8: /* call near rel */
-		if (insn_get_immediate(&insn) || insn.immediate1.value == 0) {
-			/* zero length call */
-			ret = X86_BR_ZERO_CALL;
+	/* Check for the possibility of branch fusion */
+	while (fused && ret == X86_BR_NONE) {
+		/* Check for decoding errors */
+		if (insn_get_length(&insn) || !insn.length)
 			break;
-		}
-		fallthrough;
-	case 0x9a: /* call far absolute */
-		ret = X86_BR_CALL;
-		break;
-	case 0xe0 ... 0xe3: /* loop jmp */
-		ret = X86_BR_JCC;
-		break;
-	case 0xe9 ... 0xeb: /* jmp */
-		ret = X86_BR_JMP;
-		break;
-	case 0xff: /* call near absolute, call far absolute ind */
-		if (insn_get_modrm(&insn))
-			return X86_BR_ABORT;
 
-		ext = (insn.modrm.bytes[0] >> 3) & 0x7;
-		switch (ext) {
-		case 2: /* near ind call */
-		case 3: /* far ind call */
-			ret = X86_BR_IND_CALL;
+		insn_offset += insn.length;
+		bytes_read -= insn.length;
+		if (bytes_read < 0)
 			break;
-		case 4:
-		case 5:
-			ret = X86_BR_IND_JMP;
-			break;
-		}
-		break;
-	default:
-		ret = X86_BR_NONE;
+
+		insn_init(&insn, addr + insn_offset, bytes_read, is64);
+		ret = decode_branch_type(&insn);
 	}
+
+	if (offset)
+		*offset = insn_offset;
+
 	/*
 	 * interrupts, traps, faults (and thus ring transition) may
 	 * occur on any instructions. Thus, to classify them correctly,
@@ -179,6 +199,17 @@ int branch_type(unsigned long from, unsigned long to, int abort)
 	return ret;
 }
 
+int branch_type(unsigned long from, unsigned long to, int abort)
+{
+	return get_branch_type(from, to, abort, false, NULL);
+}
+
+int branch_type_fused(unsigned long from, unsigned long to, int abort,
+		      int *offset)
+{
+	return get_branch_type(from, to, abort, true, offset);
+}
+
 #define X86_BR_TYPE_MAP_MAX	16
 
 static int branch_map[X86_BR_TYPE_MAP_MAX] = {
-- 
2.34.1

