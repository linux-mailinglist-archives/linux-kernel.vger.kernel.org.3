Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3514C62C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiB1GH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiB1GHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:07:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB46B5C36F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:07:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D88BB80E25
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330F4C340E7;
        Mon, 28 Feb 2022 06:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646028431;
        bh=qyBB/Qnf5VtZLdtQuEPQsjVHBfbCH4s2psJLLtXb/Mk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S9c7dG7KdXwrdacTTpMMUUXyKOMzPJu1LWVsjjqosnj8hSIyReZcc8kiWu++f+TNE
         balnjtJ7+E5bn82gBpKWpZb6uVBkQVxPLyxwChgO+0u90rh2QmWdKF6bFH5mKIzCyA
         TG+fnNMeSvLjv+/Ijc2AyX9Xx1gxOFVJzQN90QTuR/bmOhTJaDfWeWIacpnfvtVdR+
         HZKcgGXGRcl1IXq9BntTjm3pgJ7uNpci+GvT68nxyLf4aXZvKJLLBcnnJp+qduajv1
         iDnbhwCgs29SKTYCYdNHW1Zpx6en8zy2A8f/TOI3xFFUzOHJq0YUn7a78AXM9t5hFu
         sNfaXAEQzqv8g==
Date:   Mon, 28 Feb 2022 15:07:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-Id: <20220228150705.aab2d654b973109bab070ffe@kernel.org>
In-Reply-To: <20220224151322.892372059@infradead.org>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.892372059@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

So, instead of this change, can you try below?
This introduce the arch_adjust_kprobe_addr() and use it in the kprobe_addr()
so that it can handle the case that user passed the probe address in 
_text+OFFSET format.

From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Mon, 28 Feb 2022 15:01:48 +0900
Subject: [PATCH] x86: kprobes: Skip ENDBR instruction probing

This adjust the kprobe probe address to skip the ENDBR and put the kprobe
next to the ENDBR so that the kprobe doesn't disturb IBT.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |  7 +++++++
 include/linux/kprobes.h        |  2 ++
 kernel/kprobes.c               | 11 ++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 745f42cf82dc..a90cfe50d800 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -52,6 +52,7 @@
 #include <asm/insn.h>
 #include <asm/debugreg.h>
 #include <asm/set_memory.h>
+"include <asm/ibt.h>
 
 #include "common.h"
 
@@ -301,6 +302,12 @@ static int can_probe(unsigned long paddr)
 	return (addr == paddr);
 }
 
+/* If the x86 support IBT (ENDBR) it must be skipped. */
+kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr)
+{
+	return (kprobe_opcode_t *)skip_endbr((void *)addr);
+}
+
 /*
  * Copy an instruction with recovering modified instruction by kprobes
  * and adjust the displacement if the instruction uses the %rip-relative
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 19b884353b15..485d7832a613 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -384,6 +384,8 @@ static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
 }
 
 kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
+kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr);
+
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 94cab8c9ce56..312f10e85c93 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1488,6 +1488,15 @@ bool within_kprobe_blacklist(unsigned long addr)
 	return false;
 }
 
+/*
+ * If the arch supports the feature like IBT which will put a trap at
+ * the entry of the symbol, it must be adjusted in this function.
+ */
+kprobe_opcode_t *__weak arch_adjust_kprobe_addr(unsigned long addr)
+{
+	return (kprobe_opcode_t *)addr;
+}
+
 /*
  * If 'symbol_name' is specified, look it up and add the 'offset'
  * to it. This way, we can specify a relative address to a symbol.
@@ -1506,7 +1515,7 @@ static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
 			return ERR_PTR(-ENOENT);
 	}
 
-	addr = (kprobe_opcode_t *)(((char *)addr) + offset);
+	addr = arch_adjust_kprobe_addr((unsigned long)addr + offset);
 	if (addr)
 		return addr;
 
-- 
2.25.1


On Thu, 24 Feb 2022 15:51:53 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> With IBT on, sym+0 is no longer the __fentry__ site.
> 
> NOTE: the architecture has a special case and *does* allow placing an
> INT3 breakpoint over ENDBR in which case #BP has precedence over #CP
> and as such we don't need to disallow probing these instructions.
> 
> NOTE: irrespective of the above; there is a complication in that
> direct branches to functions are rewritten to not execute ENDBR, so
> any breakpoint thereon might miss lots of actual function executions.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/kprobes/core.c |   11 +++++++++++
>  kernel/kprobes.c               |   15 ++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -1156,3 +1162,8 @@ int arch_trampoline_kprobe(struct kprobe
>  {
>  	return 0;
>  }
> +
> +bool arch_kprobe_on_func_entry(unsigned long offset)
> +{
> +	return offset <= 4*HAS_KERNEL_IBT;
> +}
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -67,10 +67,19 @@ static bool kprobes_all_disarmed;
>  static DEFINE_MUTEX(kprobe_mutex);
>  static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
>  
> -kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
> -					unsigned int __unused)
> +kprobe_opcode_t * __weak kprobe_lookup_name(const char *name, unsigned int offset)
>  {
> -	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
> +	kprobe_opcode_t *addr = NULL;
> +
> +	addr = ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +	if (addr && !offset) {
> +		unsigned long faddr = ftrace_location((unsigned long)addr);
> +		if (faddr)
> +			addr = (kprobe_opcode_t *)faddr;
> +	}
> +#endif
> +	return addr;
>  }
>  
>  /*
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
