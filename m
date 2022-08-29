Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E2A5A42B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiH2Fyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiH2FyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:54:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A75349B61
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 22:53:54 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T5Pi75030943;
        Mon, 29 Aug 2022 05:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DMMQoSGW59S8HVqGPVp9Sh6NT9ihErcxztKupNnvGHg=;
 b=hcnGbBLc2SK2Iz00w6sVEfp0RYnokpKiwVX4KrTt5QHSnHs9MzbCiPLZswyTz0WqIKpP
 GoDKz30A6mAcNYObFzx7sYaxI8hxMNXMXfrkpO2ZaT4KMuolwPmKJ0t2y0IfJInDMRXj
 mW4pBGF3Lgid6Ju73EKsqgaMEl/OsT8/GDA1A8Xg7uEB5MTQspF4S0aUAr65Rzt0mLmx
 04Nghvhq12O49EzsTtApWbwW5PQ9cjdJMy4BUz/8M5YbUWR630OM2b6Esl0L6FcZHrfZ
 A/F+Ed02kkjmictxmB77RvRLQjeyjYFJAbThCMsbj4PWkRmGU6qaPuFhWh7r8TKykZ/q OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8qa4rgwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:53:36 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27T5Z65F004794;
        Mon, 29 Aug 2022 05:53:35 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8qa4rgvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:53:35 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27T5oKi7019913;
        Mon, 29 Aug 2022 05:53:32 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3j7aw8sc5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:53:32 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27T5rUhA37224758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 05:53:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 404614C044;
        Mon, 29 Aug 2022 05:53:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7D8B4C04A;
        Mon, 29 Aug 2022 05:53:26 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.67.34])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Aug 2022 05:53:26 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v2 11/16] objtool: Add --mnop as an option to --mcount
Date:   Mon, 29 Aug 2022 11:22:18 +0530
Message-Id: <20220829055223.24767-12-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829055223.24767-1-sv@linux.ibm.com>
References: <20220829055223.24767-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -6zenzSHSn8_o7RXreWFp9imXGUYP_Zc
X-Proofpoint-GUID: byF6Wya7XmrSC0HYD5S24G_RR3iD9Uoc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290026
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
 scripts/Makefile.lib                    |  1 +
 tools/objtool/builtin-check.c           | 14 ++++++++++++++
 tools/objtool/check.c                   | 19 ++++++++++---------
 tools/objtool/include/objtool/builtin.h |  1 +
 6 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index c7705f749601..99dd33d8bcfa 100644
--- a/Makefile
+++ b/Makefile
@@ -857,7 +857,9 @@ ifdef CONFIG_FTRACE_MCOUNT_USE_CC
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
index f9920f1341c8..a8dd138df637 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -189,6 +189,7 @@ config X86
 	select HAVE_CONTEXT_TRACKING_USER_OFFSTACK	if HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_OBJTOOL_MCOUNT		if HAVE_OBJTOOL
+	select HAVE_NOP_MCOUNT			if HAVE_OBJTOOL_MCOUNT
 	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3fb6a99e78c4..0610078e057a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -234,6 +234,7 @@ objtool_args =								\
 	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
 	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
+	$(if $(CONFIG_HAVE_NOP_MCOUNT), --mnop)				\
 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
 	$(if $(CONFIG_RETHUNK), --rethunk)				\
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 24fbe803a0d3..9bd347d3c244 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -82,6 +82,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN(0, "dry-run", &opts.dryrun, "don't write modifications"),
 	OPT_BOOLEAN(0, "link", &opts.link, "object is a linked object"),
 	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
+	OPT_BOOLEAN(0, "mnop", &opts.mnop, "nop out mcount call sites"),
 	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
@@ -150,6 +151,16 @@ static bool opts_valid(void)
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
@@ -198,6 +209,9 @@ int objtool_run(int argc, const char **argv)
 	if (!file)
 		return 1;
 
+	if (!mnop_opts_valid())
+		return 1;
+
 	if (!link_opts_valid(file))
 		return 1;
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0ecf41ee73f0..3cea58f73878 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1231,17 +1231,18 @@ static void annotate_call_site(struct objtool_file *file,
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
index 42a52f1a0add..0785707c5a92 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -31,6 +31,7 @@ struct opts {
 	bool backup;
 	bool dryrun;
 	bool link;
+	bool mnop;
 	bool module;
 	bool no_unreachable;
 	bool sec_address;
-- 
2.31.1

