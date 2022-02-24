Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5871B4C2F66
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiBXPUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiBXPSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462E9159280
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gyQOZ/OewxIV9rsoR2cpSRnntRDVjwTBBtcxSpgojPk=; b=G8mxPQm3NU7ZV/zLjmPmTh333F
        ltP75Fc9ZTdxk0Ikc5JZd86lcWO8ZFrnZFSiHXyUwBH7v95v794zZiqTjtHlYMRXYobsTu0JClaao
        HMjQV4MWpw8i7eRG464mRlWHYxRIxfspn/F2CQI46Evm47hJw69zjug3h2IT9fXkmGRCikzCDqpg2
        N/OdKOQq63tzHJ6Xsr7VYxD+5ecckOPM5EJtRa5mm+wiFJEtAlOyDCVgCCZVeaxjuJ7bHLgUJR86d
        T2YpACOUwA+7V9EnNjxJUsDrIKq1tzDRZWxpd58btziLmHhoqkEEmI2QGEmKEso0Ke5AAwXyZamGD
        iaM/rNKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs3-00CeLh-Nl; Thu, 24 Feb 2022 15:17:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38BAA301A96;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 59AA02B354785; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151322.892372059@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:51:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
References: <20220224145138.952963315@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With IBT on, sym+0 is no longer the __fentry__ site.

NOTE: the architecture has a special case and *does* allow placing an
INT3 breakpoint over ENDBR in which case #BP has precedence over #CP
and as such we don't need to disallow probing these instructions.

NOTE: irrespective of the above; there is a complication in that
direct branches to functions are rewritten to not execute ENDBR, so
any breakpoint thereon might miss lots of actual function executions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/kprobes/core.c |   11 +++++++++++
 kernel/kprobes.c               |   15 ++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1156,3 +1162,8 @@ int arch_trampoline_kprobe(struct kprobe
 {
 	return 0;
 }
+
+bool arch_kprobe_on_func_entry(unsigned long offset)
+{
+	return offset <= 4*HAS_KERNEL_IBT;
+}
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -67,10 +67,19 @@ static bool kprobes_all_disarmed;
 static DEFINE_MUTEX(kprobe_mutex);
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
 
-kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
-					unsigned int __unused)
+kprobe_opcode_t * __weak kprobe_lookup_name(const char *name, unsigned int offset)
 {
-	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
+	kprobe_opcode_t *addr = NULL;
+
+	addr = ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
+#ifdef CONFIG_KPROBES_ON_FTRACE
+	if (addr && !offset) {
+		unsigned long faddr = ftrace_location((unsigned long)addr);
+		if (faddr)
+			addr = (kprobe_opcode_t *)faddr;
+	}
+#endif
+	return addr;
 }
 
 /*


