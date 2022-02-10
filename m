Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F534B08CD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbiBJIsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:48:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbiBJIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:48:12 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391FCB66
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:48:10 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4JvVkw43N4z9sSM;
        Thu, 10 Feb 2022 09:48:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MCQPRHll6k6O; Thu, 10 Feb 2022 09:48:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4JvVkw3Dhzz9sSL;
        Thu, 10 Feb 2022 09:48:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EA508B77C;
        Thu, 10 Feb 2022 09:48:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 53PVx_MlJM8w; Thu, 10 Feb 2022 09:48:08 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.71])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2300E8B764;
        Thu, 10 Feb 2022 09:48:08 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21A8lw7w789978
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 09:47:58 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21A8lu0e789976;
        Thu, 10 Feb 2022 09:47:56 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] tracing: uninline trace_trigger_soft_disabled()
Date:   Thu, 10 Feb 2022 09:47:52 +0100
Message-Id: <38191e96ec6d331662ee7278e26edb79cdf95402.1644482771.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644482871; l=4293; s=20211009; h=from:subject:message-id; bh=0ikX0I/PAgk97rfnNInvwA+PgYwBfQox2cMpbtSZ6Ls=; b=FD6nvkSjGigqA6HAqMi+GmsqFQxyu2gZpOrJB42IzHASsLP5456dsykns0jxGjPIvD8CQHR5XPI8 lcKdEBCcAxD/Ddw6kmStm22XjJnTict6Ac6NqQdAm9GS2Yb2x2yq
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

On a ppc32 build with CONFIG_CC_OPTIMISE_FOR_SIZE,
trace_trigger_soft_disabled() appears more than 50 times in vmlinux.

That function is rather big for an inlined function, and
it doesn't benefit much from inlining as its only parameter
is a pointer to a struct in memory:

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

It doesn't benefit much from inlining as its only parameter is a
pointer to a struct in memory so no constant folding is involved.

Uninline it and move it into kernel/trace/trace_events_trigger.c

It reduces the size of vmlinux by approximately 10 kbytes.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/trace_events.h        | 16 +---------------
 kernel/trace/trace_events_trigger.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 70c069aef02c..23dc8a12008b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -708,21 +708,7 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file);
  * triggers that require testing the fields, it will return true,
  * otherwise false.
  */
-static inline bool
-trace_trigger_soft_disabled(struct trace_event_file *file)
-{
-	unsigned long eflags = file->flags;
-
-	if (!(eflags & EVENT_FILE_FL_TRIGGER_COND)) {
-		if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
-			event_triggers_call(file, NULL, NULL, NULL);
-		if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
-			return true;
-		if (eflags & EVENT_FILE_FL_PID_FILTER)
-			return trace_event_ignore_this_pid(file);
-	}
-	return false;
-}
+bool trace_trigger_soft_disabled(struct trace_event_file *file);
 
 #ifdef CONFIG_BPF_EVENTS
 unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index d00fee705f9c..41b766bc56b9 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -84,6 +84,22 @@ event_triggers_call(struct trace_event_file *file,
 }
 EXPORT_SYMBOL_GPL(event_triggers_call);
 
+bool trace_trigger_soft_disabled(struct trace_event_file *file)
+{
+	unsigned long eflags = file->flags;
+
+	if (!(eflags & EVENT_FILE_FL_TRIGGER_COND)) {
+		if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
+			event_triggers_call(file, NULL, NULL, NULL);
+		if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
+			return true;
+		if (eflags & EVENT_FILE_FL_PID_FILTER)
+			return trace_event_ignore_this_pid(file);
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(trace_trigger_soft_disabled);
+
 /**
  * event_triggers_post_call - Call 'post_triggers' for a trace event
  * @file: The trace_event_file associated with the event
-- 
2.34.1

