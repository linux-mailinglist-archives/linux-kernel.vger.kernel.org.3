Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8CA531681
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243878AbiEWSsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243556AbiEWSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:47:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A35515A3EF
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:32:17 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NHhqKh036599;
        Mon, 23 May 2022 17:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ms0Kxs5WFlKOM/c7mHMVDHIyjlDme/vsziM3okoM1ew=;
 b=WOzwPbOTkv7H60jp04JGUBRmGEc0Uj+VrTsKTCszvznBmgVsPFu3H+zUrF2qHYKUelHi
 GdYByF5YYEbC6a1ArzskmVOlGK4VBU3YLdo/75pL7BobCrI7PzB+7XlQ5u1BnhEI4ERF
 INAAx1igzNJ8OUHB+o9gvLQlQAlX6J9+6+Fl7gZ/Ex3dVA9Xm8vBr4bM0Z8i64lt4f7v
 HrUeiZ8vfgOlTd2YJqKq3wbunDGLC239MI9sQJrCveQZrOFOSUBcx9azNV2eORL0RiDd
 SsDMC6ywATpvDwWsVCqskcaFcJr7XcqGFbi5jUzzoMLqtfuE+lfKDlfbtzI/EULYah0q vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8ex38605-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 17:56:15 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24NHliPC006665;
        Mon, 23 May 2022 17:56:15 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8ex385y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 17:56:14 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24NHiINL032721;
        Mon, 23 May 2022 17:56:12 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3g6qq9anjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 17:56:12 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24NHu9fQ27394372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 17:56:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB3BD52050;
        Mon, 23 May 2022 17:56:09 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.16.198])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 182D15204E;
        Mon, 23 May 2022 17:56:06 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, mbenes@suse.cz, aik@ozlabs.ru,
        mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        rostedt@goodmis.org, naveen.n.rao@linux.vnet.ibm.com,
        sv@linux.ibm.com
Subject: [RFC PATCH 3/4] objtool/powerpc: Enable objtool to be built on ppc
Date:   Mon, 23 May 2022 23:25:47 +0530
Message-Id: <20220523175548.922671-4-sv@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220523175548.922671-1-sv@linux.ibm.com>
References: <20220523175548.922671-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iJJgpiJkKPhpPgj1QMImz7q8HqYu8mXO
X-Proofpoint-ORIG-GUID: XRjVD49JreGGfIwC_ec9yGERDtl8niL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_07,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds [stub] implementations for required
functions, inorder to enable objtool build on powerpc.

Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 arch/powerpc/Kconfig                          |  1 +
 tools/objtool/arch/powerpc/Build              |  2 +
 tools/objtool/arch/powerpc/decode.c           | 73 +++++++++++++++++++
 .../arch/powerpc/include/arch/cfi_regs.h      | 11 +++
 tools/objtool/arch/powerpc/include/arch/elf.h |  8 ++
 .../arch/powerpc/include/arch/endianness.h    |  9 +++
 .../arch/powerpc/include/arch/special.h       | 21 ++++++
 tools/objtool/arch/powerpc/special.c          | 19 +++++
 8 files changed, 144 insertions(+)
 create mode 100644 tools/objtool/arch/powerpc/Build
 create mode 100644 tools/objtool/arch/powerpc/decode.c
 create mode 100644 tools/objtool/arch/powerpc/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/powerpc/include/arch/elf.h
 create mode 100644 tools/objtool/arch/powerpc/include/arch/endianness.h
 create mode 100644 tools/objtool/arch/powerpc/include/arch/special.h
 create mode 100644 tools/objtool/arch/powerpc/special.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 174edabb74fa..732a3f91ee5e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -232,6 +232,7 @@ config PPC
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
 	select HAVE_OPTPROBES
+	select HAVE_OBJTOOL			if PPC64
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
diff --git a/tools/objtool/arch/powerpc/Build b/tools/objtool/arch/powerpc/Build
new file mode 100644
index 000000000000..d24d5636a5b8
--- /dev/null
+++ b/tools/objtool/arch/powerpc/Build
@@ -0,0 +1,2 @@
+objtool-y += decode.o
+objtool-y += special.o
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
new file mode 100644
index 000000000000..e3b77a6ce357
--- /dev/null
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <objtool/check.h>
+#include <objtool/elf.h>
+#include <objtool/arch.h>
+#include <objtool/warn.h>
+#include <objtool/builtin.h>
+
+unsigned long arch_dest_reloc_offset(int addend)
+{
+	return addend;
+}
+
+bool arch_callee_saved_reg(unsigned char reg)
+{
+	return false;
+}
+
+int arch_decode_hint_reg(u8 sp_reg, int *base)
+{
+	return 0;
+}
+
+const char *arch_nop_insn(int len)
+{
+	return NULL;
+}
+
+const char *arch_ret_insn(int len)
+{
+	return NULL;
+}
+
+int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
+			    unsigned long offset, unsigned int maxlen,
+			    unsigned int *len, enum insn_type *type,
+			    unsigned long *immediate,
+			    struct list_head *ops_list)
+{
+	u32 insn;
+
+	*immediate = 0;
+	memcpy(&insn, sec->data->d_buf+offset, 4);
+	*len = 4;
+	*type = INSN_OTHER;
+
+	return 0;
+}
+
+unsigned long arch_jump_destination(struct instruction *insn)
+{
+	return insn->offset +  insn->immediate;
+}
+
+void arch_initial_func_cfi_state(struct cfi_init_state *state)
+{
+	int i;
+
+	for (i = 0; i < CFI_NUM_REGS; i++) {
+		state->regs[i].base = CFI_UNDEFINED;
+		state->regs[i].offset = 0;
+	}
+
+	/* initial CFA (call frame address) */
+	state->cfa.base = CFI_SP;
+	state->cfa.offset = 0;
+
+	/* initial LR (return address) */
+	state->regs[CFI_RA].base = CFI_CFA;
+	state->regs[CFI_RA].offset = 0;
+}
diff --git a/tools/objtool/arch/powerpc/include/arch/cfi_regs.h b/tools/objtool/arch/powerpc/include/arch/cfi_regs.h
new file mode 100644
index 000000000000..59638ebeafc8
--- /dev/null
+++ b/tools/objtool/arch/powerpc/include/arch/cfi_regs.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _OBJTOOL_CFI_REGS_H
+#define _OBJTOOL_CFI_REGS_H
+
+#define CFI_BP 1
+#define CFI_SP CFI_BP
+#define CFI_RA 32
+#define CFI_NUM_REGS 33
+
+#endif
diff --git a/tools/objtool/arch/powerpc/include/arch/elf.h b/tools/objtool/arch/powerpc/include/arch/elf.h
new file mode 100644
index 000000000000..3c8ebb7d2a6b
--- /dev/null
+++ b/tools/objtool/arch/powerpc/include/arch/elf.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _OBJTOOL_ARCH_ELF
+#define _OBJTOOL_ARCH_ELF
+
+#define R_NONE R_PPC_NONE
+
+#endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/arch/powerpc/include/arch/endianness.h b/tools/objtool/arch/powerpc/include/arch/endianness.h
new file mode 100644
index 000000000000..7c362527da20
--- /dev/null
+++ b/tools/objtool/arch/powerpc/include/arch/endianness.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ARCH_ENDIANNESS_H
+#define _ARCH_ENDIANNESS_H
+
+#include <endian.h>
+
+#define __TARGET_BYTE_ORDER __LITTLE_ENDIAN
+
+#endif /* _ARCH_ENDIANNESS_H */
diff --git a/tools/objtool/arch/powerpc/include/arch/special.h b/tools/objtool/arch/powerpc/include/arch/special.h
new file mode 100644
index 000000000000..ffef9ada7133
--- /dev/null
+++ b/tools/objtool/arch/powerpc/include/arch/special.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _PPC_ARCH_SPECIAL_H
+#define _PPC_ARCH_SPECIAL_H
+
+#define EX_ENTRY_SIZE 8
+#define EX_ORIG_OFFSET 0
+#define EX_NEW_OFFSET 4
+
+#define JUMP_ENTRY_SIZE 16
+#define JUMP_ORIG_OFFSET 0
+#define JUMP_NEW_OFFSET 4
+#define JUMP_KEY_OFFSET 8
+
+#define ALT_ENTRY_SIZE 12
+#define ALT_ORIG_OFFSET 0
+#define ALT_NEW_OFFSET 4
+#define ALT_FEATURE_OFFSET 8
+#define ALT_ORIG_LEN_OFFSET 10
+#define ALT_NEW_LEN_OFFSET 11
+
+#endif /* _PPC_ARCH_SPECIAL_H */
diff --git a/tools/objtool/arch/powerpc/special.c b/tools/objtool/arch/powerpc/special.c
new file mode 100644
index 000000000000..e3e75cbab858
--- /dev/null
+++ b/tools/objtool/arch/powerpc/special.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <string.h>
+
+#include <objtool/special.h>
+#include <objtool/builtin.h>
+
+
+bool arch_support_alt_relocation(struct special_alt *special_alt,
+				 struct instruction *insn,
+				 struct reloc *reloc)
+{
+	return false;
+}
+
+struct reloc *arch_find_switch_table(struct objtool_file *file,
+				    struct instruction *insn)
+{
+	return NULL;
+}
-- 
2.25.1

