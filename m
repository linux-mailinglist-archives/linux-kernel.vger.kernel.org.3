Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAA4531950
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiEWTD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiEWTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:00:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7022AA5A9F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:42:45 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NHj7fH011166;
        Mon, 23 May 2022 17:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=P4XKBce5J3OnxLwUOJjJ3acpK2WPdu09+T/PIMImZc8=;
 b=TRMtHkvxJqzs0AG4fzuT1APbI3vCz1csGrNuaSoh7/WVZgem4kCX9bqJ7xAeeleOdgCA
 +mxH4TTV8f1OUnKXfkJ/5llsiH5O1jCEgp2re1uxrIuztcbyrOjgxYz48Z6iUJlVPeoe
 jomzcSCXMFn4I0xzOvOL66YtkbgDudWMgOf+AgEuQKrFAFRF2KCxYf36KTOGHFZqSZtF
 pC9zssMdtXt9EBqj8f4YPqPHmpNED0ZWIE25U3aBuXakTSfqQN3Apwl31VibaPlbQQHU
 3LcFEzCI48c565tR9tA5LwYfkLwT07qAu09wIndQhrZVrRiZUsSVaVbMvWa4r5nu6gpB 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8exn05fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 17:56:06 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24NHkAxW012730;
        Mon, 23 May 2022 17:56:05 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8exn05f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 17:56:05 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24NHh58u011631;
        Mon, 23 May 2022 17:56:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3g6qq93jq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 17:56:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24NHtDLK31195612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 17:55:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA0055204E;
        Mon, 23 May 2022 17:56:00 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.16.198])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D546F5204F;
        Mon, 23 May 2022 17:55:57 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, mbenes@suse.cz, aik@ozlabs.ru,
        mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        rostedt@goodmis.org, naveen.n.rao@linux.vnet.ibm.com,
        sv@linux.ibm.com
Subject: [RFC PATCH 1/4] objtool: Add --mnop as an option to --mcount
Date:   Mon, 23 May 2022 23:25:45 +0530
Message-Id: <20220523175548.922671-2-sv@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220523175548.922671-1-sv@linux.ibm.com>
References: <20220523175548.922671-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uChw7Y5RZjncb0nPFAS_b_ekcCoyPD56
X-Proofpoint-GUID: D1WkZO3huPy2hLVgdyTwuzQeSJBk9k_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_07,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures can select HAVE_NOP_MCOUNT if they choose
to nop out mcount call sites. If that config option is
selected, then --mnop is passed as an option to objtool,
along with --mcount.

Also, make sure that --mnop can be passed as an option
to objtool only when --mcount is passed.

Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 Makefile                                |  4 +++-
 arch/x86/Kconfig                        |  1 +
 scripts/Makefile.build                  |  1 +
 tools/objtool/builtin-check.c           | 14 ++++++++++++++
 tools/objtool/check.c                   | 19 ++++++++++---------
 tools/objtool/include/objtool/builtin.h |  1 +
 6 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 250707647359..acaf88e3c694 100644
--- a/Makefile
+++ b/Makefile
@@ -851,7 +851,9 @@ ifdef CONFIG_FTRACE_MCOUNT_USE_CC
   endif
 endif
 ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
-  CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT
+  ifdef CONFIG_HAVE_NOP_MCOUNT
+    CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT
+  endif
 endif
 ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
   ifdef CONFIG_HAVE_C_RECORDMCOUNT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1847d6e974a1..4a41bfb644f0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -189,6 +189,7 @@ config X86
 	select HAVE_CONTEXT_TRACKING_OFFSTACK	if HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_OBJTOOL_MCOUNT		if HAVE_OBJTOOL
+	select HAVE_NOP_MCOUNT			if HAVE_OBJTOOL_MCOUNT
 	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ac8167227bc0..2e0c3f9c1459 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -231,6 +231,7 @@ objtool_args =								\
 	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
 	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
+	$(if $(CONFIG_HAVE_NOP_MCOUNT), --mnop)				\
 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
 	$(if $(CONFIG_SLS), --sls)					\
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index f4c3a5091737..b05e2108c0c3 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -80,6 +80,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN(0, "dry-run", &opts.dryrun, "don't write modifications"),
 	OPT_BOOLEAN(0, "link", &opts.link, "object is a linked object"),
 	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
+	OPT_BOOLEAN(0, "mnop", &opts.mnop, "nop out mcount call sites"),
 	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
@@ -142,6 +143,16 @@ static bool opts_valid(void)
 	return false;
 }
 
+static bool mnop_opts_valid(void)
+{
+	if (opts.mnop && !opts.mcount) {
+		ERROR("--mnop requires --mcount");
+		return false;
+	}
+
+	return true;
+}
+
 static bool link_opts_valid(struct objtool_file *file)
 {
 	if (opts.link)
@@ -185,6 +196,9 @@ int objtool_run(int argc, const char **argv)
 	if (!file)
 		return 1;
 
+	if (!mnop_opts_valid())
+		return 1;
+
 	if (!link_opts_valid(file))
 		return 1;
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 190b2f6e360a..056302d58e23 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1175,17 +1175,18 @@ static void annotate_call_site(struct objtool_file *file,
 	if (opts.mcount && sym->fentry) {
 		if (sibling)
 			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
+		if (opts.mnop) {
+			if (reloc) {
+				reloc->type = R_NONE;
+				elf_write_reloc(file->elf, reloc);
+			}
 
-		if (reloc) {
-			reloc->type = R_NONE;
-			elf_write_reloc(file->elf, reloc);
-		}
-
-		elf_write_insn(file->elf, insn->sec,
-			       insn->offset, insn->len,
-			       arch_nop_insn(insn->len));
+			elf_write_insn(file->elf, insn->sec,
+				       insn->offset, insn->len,
+				       arch_nop_insn(insn->len));
 
-		insn->type = INSN_NOP;
+			insn->type = INSN_NOP;
+		}
 
 		list_add_tail(&insn->call_node, &file->mcount_loc_list);
 		return;
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 280ea18b7f2b..71ed3152a18e 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -29,6 +29,7 @@ struct opts {
 	bool backup;
 	bool dryrun;
 	bool link;
+	bool mnop;
 	bool module;
 	bool no_unreachable;
 	bool sec_address;
-- 
2.25.1

