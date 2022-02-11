Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155CC4B1F09
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347456AbiBKHKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:10:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiBKHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:10:40 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E310BE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:10:36 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jw4Wv3Nrfz9sSM;
        Fri, 11 Feb 2022 08:10:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yTxWIXmlT5-Z; Fri, 11 Feb 2022 08:10:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jw4Wv2TT8z9sSL;
        Fri, 11 Feb 2022 08:10:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 458638B77D;
        Fri, 11 Feb 2022 08:10:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Q4bSTk25yc2C; Fri, 11 Feb 2022 08:10:35 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.91])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 092C78B764;
        Fri, 11 Feb 2022 08:10:34 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21B7AO6T932225
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 08:10:24 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21B7ANFf932224;
        Fri, 11 Feb 2022 08:10:23 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] tracing: uninline trace_trigger_soft_disabled() partly
Date:   Fri, 11 Feb 2022 08:10:18 +0100
Message-Id: <69ce0986a52d026d381d612801d978aa4f977460.1644563295.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644563417; l=5360; s=20211009; h=from:subject:message-id; bh=nsVOPgQ/VILyuZtJIJ1cz9Nxfvb9oYMbT+t6RSmXbik=; b=Mk6ESt49ixVTwBdq5Wt4ygVO8lguwgmvrFghLBIOo+IzDctLv8Z2d3Gm0WucNyJR1589VwSmiDGu HsiW238ADjRuviaUvmMYheX5f9DJROVuD2aDaUU5tCsFnvVQPQfU
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a powerpc32 build with CONFIG_CC_OPTIMISE_FOR_SIZE, the inline
keyword is not honored and trace_trigger_soft_disabled() appears
approx 50 times in vmlinux.

Adding -Winline to the build, the following message appears:

	./include/linux/trace_events.h:712:1: error: inlining failed in call to 'trace_trigger_soft_disabled': call is unlikely and code size would grow [-Werror=inline]

That function is rather big for an inlined function:

	c003df60 <trace_trigger_soft_disabled>:
	c003df60:	94 21 ff f0 	stwu    r1,-16(r1)
	c003df64:	7c 08 02 a6 	mflr    r0
	c003df68:	90 01 00 14 	stw     r0,20(r1)
	c003df6c:	bf c1 00 08 	stmw    r30,8(r1)
	c003df70:	83 e3 00 24 	lwz     r31,36(r3)
	c003df74:	73 e9 01 00 	andi.   r9,r31,256
	c003df78:	41 82 00 10 	beq     c003df88 <trace_trigger_soft_disabled+0x28>
	c003df7c:	38 60 00 00 	li      r3,0
	c003df80:	39 61 00 10 	addi    r11,r1,16
	c003df84:	4b fd 60 ac 	b       c0014030 <_rest32gpr_30_x>
	c003df88:	73 e9 00 80 	andi.   r9,r31,128
	c003df8c:	7c 7e 1b 78 	mr      r30,r3
	c003df90:	41 a2 00 14 	beq     c003dfa4 <trace_trigger_soft_disabled+0x44>
	c003df94:	38 c0 00 00 	li      r6,0
	c003df98:	38 a0 00 00 	li      r5,0
	c003df9c:	38 80 00 00 	li      r4,0
	c003dfa0:	48 05 c5 f1 	bl      c009a590 <event_triggers_call>
	c003dfa4:	73 e9 00 40 	andi.   r9,r31,64
	c003dfa8:	40 82 00 28 	bne     c003dfd0 <trace_trigger_soft_disabled+0x70>
	c003dfac:	73 ff 02 00 	andi.   r31,r31,512
	c003dfb0:	41 82 ff cc 	beq     c003df7c <trace_trigger_soft_disabled+0x1c>
	c003dfb4:	80 01 00 14 	lwz     r0,20(r1)
	c003dfb8:	83 e1 00 0c 	lwz     r31,12(r1)
	c003dfbc:	7f c3 f3 78 	mr      r3,r30
	c003dfc0:	83 c1 00 08 	lwz     r30,8(r1)
	c003dfc4:	7c 08 03 a6 	mtlr    r0
	c003dfc8:	38 21 00 10 	addi    r1,r1,16
	c003dfcc:	48 05 6f 6c 	b       c0094f38 <trace_event_ignore_this_pid>
	c003dfd0:	38 60 00 01 	li      r3,1
	c003dfd4:	4b ff ff ac 	b       c003df80 <trace_trigger_soft_disabled+0x20>

However it is located in a hot path so inlining it is important.
But forcing inlining of the entire function by using __always_inline
leads to increasing the text size by approx 20 kbytes.

Instead, split the fonction in two parts, one part with the likely
fast path, flagged __always_inline, and a second part out of line.

With this change, on a powerpc32 with CONFIG_CC_OPTIMISE_FOR_SIZE
vmlinux text increases by only 1,4 kbytes, which is partly
compensated by a decrease of vmlinux data by 7 kbytes.

On ppc64_defconfig which has CONFIG_CC_OPTIMISE_FOR_SPEED, this
change reduces vmlinux text by more than 30 kbytes.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Keep the likely path inline and force it.
---
 include/linux/trace_events.h        | 22 ++++++++++++----------
 kernel/trace/trace_events_trigger.c | 14 ++++++++++++++
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 70c069aef02c..dcea51fb60e2 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -699,6 +699,8 @@ event_triggers_post_call(struct trace_event_file *file,
 
 bool trace_event_ignore_this_pid(struct trace_event_file *trace_file);
 
+bool __trace_trigger_soft_disabled(struct trace_event_file *file);
+
 /**
  * trace_trigger_soft_disabled - do triggers and test if soft disabled
  * @file: The file pointer of the event to test
@@ -708,20 +710,20 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file);
  * triggers that require testing the fields, it will return true,
  * otherwise false.
  */
-static inline bool
+static __always_inline bool
 trace_trigger_soft_disabled(struct trace_event_file *file)
 {
 	unsigned long eflags = file->flags;
 
-	if (!(eflags & EVENT_FILE_FL_TRIGGER_COND)) {
-		if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
-			event_triggers_call(file, NULL, NULL, NULL);
-		if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
-			return true;
-		if (eflags & EVENT_FILE_FL_PID_FILTER)
-			return trace_event_ignore_this_pid(file);
-	}
-	return false;
+	if (likely(!(eflags & (EVENT_FILE_FL_TRIGGER_MODE |
+			       EVENT_FILE_FL_SOFT_DISABLED |
+			       EVENT_FILE_FL_PID_FILTER))))
+		return false;
+
+	if (likely(eflags & EVENT_FILE_FL_TRIGGER_COND))
+		return false;
+
+	return __trace_trigger_soft_disabled(file);
 }
 
 #ifdef CONFIG_BPF_EVENTS
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index d00fee705f9c..55de490e25ca 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -84,6 +84,20 @@ event_triggers_call(struct trace_event_file *file,
 }
 EXPORT_SYMBOL_GPL(event_triggers_call);
 
+bool __trace_trigger_soft_disabled(struct trace_event_file *file)
+{
+	unsigned long eflags = file->flags;
+
+	if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
+		event_triggers_call(file, NULL, NULL, NULL);
+	if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
+		return true;
+	if (eflags & EVENT_FILE_FL_PID_FILTER)
+		return trace_event_ignore_this_pid(file);
+	return false;
+}
+EXPORT_SYMBOL_GPL(__trace_trigger_soft_disabled);
+
 /**
  * event_triggers_post_call - Call 'post_triggers' for a trace event
  * @file: The trace_event_file associated with the event
-- 
2.34.1

