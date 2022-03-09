Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12924D29CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiCIH5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiCIH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AA7164D28;
        Tue,  8 Mar 2022 23:55:05 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812503;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAOOTVdyFLLSHj+T8SOj7VrTcVBB4+7bSvjpVpQTj/g=;
        b=lLYByy2iHKjsTQPBaa2THUadHuDDPOdd60FD/SSbfFko7x6eydSSzMGgdu9rqjyyLYUldp
        AZKFazz2718ABj19OJTlji26m9VAdlrEbJRpyJU22Aaukrs+74o8Y6mpXgKIrRSaeJz9Ln
        0/J03QdtkYhnoTQiYl68nvZIAEGFQM/w+AAJ+6CHAxp9A5DC1lQ3teo4C3wiRQpiTcpMD7
        iD4oqqkv/19cioLQRJMz2zru+miakvuEq+PmeLEqQXhSSSlgd+rfZOd1Qw2uwsRtg7DO9g
        8rN66pUCtKwY3kvxBZdG2txHPJyjEL6lTxl1cO6hTMCcjTBSFGxKXnUtEo4oaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812503;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAOOTVdyFLLSHj+T8SOj7VrTcVBB4+7bSvjpVpQTj/g=;
        b=5fk2mtUWXd1miOjvYusJiK6AXuLRip2w1xdpXpobGi+BUKcRBjrFFgAGsdjkYwwtv0FJqr
        EfQ7+6VQwcCJIPBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,ftrace: Search for __fentry__ location
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.227581603@infradead.org>
References: <20220308154318.227581603@infradead.org>
MIME-Version: 1.0
Message-ID: <164681250278.16921.12889395224538939746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ee1a8cf8dd0f0b1a2adfb8aedf6c75568a411b0a
Gitweb:        https://git.kernel.org/tip/ee1a8cf8dd0f0b1a2adfb8aedf6c75568a411b0a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:31 +01:00

x86/ibt,ftrace: Search for __fentry__ location

Currently a lot of ftrace code assumes __fentry__ is at sym+0. However
with Intel IBT enabled the first instruction of a function will most
likely be ENDBR.

Change ftrace_location() to not only return the __fentry__ location
when called for the __fentry__ location, but also when called for the
sym+0 location.

Then audit/update all callsites of this function to consistently use
these new semantics.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.227581603@infradead.org
---
 arch/x86/kernel/kprobes/core.c | 11 +-------
 kernel/bpf/trampoline.c        | 20 +++------------
 kernel/kprobes.c               |  8 +-----
 kernel/trace/ftrace.c          | 43 ++++++++++++++++++++++++++-------
 4 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6290712..4d8086a 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -193,17 +193,10 @@ static unsigned long
 __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
 {
 	struct kprobe *kp;
-	unsigned long faddr;
+	bool faddr;
 
 	kp = get_kprobe((void *)addr);
-	faddr = ftrace_location(addr);
-	/*
-	 * Addresses inside the ftrace location are refused by
-	 * arch_check_ftrace_location(). Something went terribly wrong
-	 * if such an address is checked here.
-	 */
-	if (WARN_ON(faddr && faddr != addr))
-		return 0UL;
+	faddr = ftrace_location(addr) == addr;
 	/*
 	 * Use the current code if it is not modified by Kprobe
 	 * and it cannot be modified by ftrace.
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5e7edf9..455f1b4 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -117,18 +117,6 @@ static void bpf_trampoline_module_put(struct bpf_trampoline *tr)
 	tr->mod = NULL;
 }
 
-static int is_ftrace_location(void *ip)
-{
-	long addr;
-
-	addr = ftrace_location((long)ip);
-	if (!addr)
-		return 0;
-	if (WARN_ON_ONCE(addr != (long)ip))
-		return -EFAULT;
-	return 1;
-}
-
 static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 {
 	void *ip = tr->func.addr;
@@ -160,12 +148,12 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 {
 	void *ip = tr->func.addr;
+	unsigned long faddr;
 	int ret;
 
-	ret = is_ftrace_location(ip);
-	if (ret < 0)
-		return ret;
-	tr->func.ftrace_managed = ret;
+	faddr = ftrace_location((unsigned long)ip);
+	if (faddr)
+		tr->func.ftrace_managed = true;
 
 	if (bpf_trampoline_module_get(tr))
 		return -ENOENT;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 94cab8c..6d1e11c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1562,14 +1562,10 @@ static inline int warn_kprobe_rereg(struct kprobe *p)
 
 static int check_ftrace_location(struct kprobe *p)
 {
-	unsigned long ftrace_addr;
+	unsigned long addr = (unsigned long)p->addr;
 
-	ftrace_addr = ftrace_location((unsigned long)p->addr);
-	if (ftrace_addr) {
+	if (ftrace_location(addr) == addr) {
 #ifdef CONFIG_KPROBES_ON_FTRACE
-		/* Given address is not on the instruction boundary */
-		if ((unsigned long)p->addr != ftrace_addr)
-			return -EILSEQ;
 		p->flags |= KPROBE_FLAG_FTRACE;
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 		return -EINVAL;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a4b462b..ae0d9f6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1568,17 +1568,34 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 }
 
 /**
- * ftrace_location - return true if the ip giving is a traced location
+ * ftrace_location - return the ftrace location
  * @ip: the instruction pointer to check
  *
- * Returns rec->ip if @ip given is a pointer to a ftrace location.
- * That is, the instruction that is either a NOP or call to
- * the function tracer. It checks the ftrace internal tables to
- * determine if the address belongs or not.
+ * If @ip matches the ftrace location, return @ip.
+ * If @ip matches sym+0, return sym's ftrace location.
+ * Otherwise, return 0.
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	return ftrace_location_range(ip, ip);
+	struct dyn_ftrace *rec;
+	unsigned long offset;
+	unsigned long size;
+
+	rec = lookup_rec(ip, ip);
+	if (!rec) {
+		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
+			goto out;
+
+		/* map sym+0 to __fentry__ */
+		if (!offset)
+			rec = lookup_rec(ip, ip + size - 1);
+	}
+
+	if (rec)
+		return rec->ip;
+
+out:
+	return 0;
 }
 
 /**
@@ -4962,7 +4979,8 @@ ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 {
 	struct ftrace_func_entry *entry;
 
-	if (!ftrace_location(ip))
+	ip = ftrace_location(ip);
+	if (!ip)
 		return -EINVAL;
 
 	if (remove) {
@@ -5110,11 +5128,16 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *free_hash = NULL;
 	struct dyn_ftrace *rec;
-	int ret = -EBUSY;
+	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	/* See if there's a direct function at @ip already */
+	ret = -EBUSY;
 	if (ftrace_find_rec_direct(ip))
 		goto out_unlock;
 
@@ -5222,6 +5245,10 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry = find_direct_entry(&ip, NULL);
 	if (!entry)
 		goto out_unlock;
