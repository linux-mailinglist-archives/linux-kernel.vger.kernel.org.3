Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE2B4CB050
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244814AbiCBUxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244780AbiCBUww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:52:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01357DBD2A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3YdQNtU09LFdeLx+8RqtwL1hK03bUwsWLy6P+HorXuU=; b=tqUgDKuDXvCleY6xLte/WUS9fn
        IqW5Wi0hrtFiycNJOPgtVSfTR6yGK8YIjVm+T5HnlZ2DydgRRNuh9nZNy8vK7OgmcMQxS5UcTud9B
        Rg0lvjR3QakPtbdPdVstufmXRL6ysndsghSIBKUxdCUNxdqvf/J80sLmsVs7ABpAMC4CPejBZAuSb
        xZPEZQVYmwLZvnC3C5u2CVLZPLvS6DeMgrejN9p36Xq97p91KFD5lVdeJpJy751SuhWCjv5oHpu5O
        8VhLAUbT6WcpWESs/InkzszsHpwkeAWhNxjwbiJj+hEQcuGWr06KIbVl4zL+5bVksI4GtU08c8gF3
        GnY4F1qA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPVwg-00AyYg-SO; Wed, 02 Mar 2022 20:51:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 833B630017F;
        Wed,  2 Mar 2022 21:51:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B969203C2E87; Wed,  2 Mar 2022 21:51:36 +0100 (CET)
Date:   Wed, 2 Mar 2022 21:51:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz, ndesaulniers@google.com,
        samitolvanen@google.com, x86@kernel.org
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
Message-ID: <Yh/Y2FHw90m00owK@hirez.programming.kicks-ass.net>
References: <20220224105847.5c899324@gandalf.local.home>
 <20220225103449.6084e5314273556f35107cd9@kernel.org>
 <20220224211919.0612a3f6@rorschach.local.home>
 <20220225192008.d7a4f2b5558fe43c95909777@kernel.org>
 <20220225083647.12ceb54b@gandalf.local.home>
 <1646159447.ngbqgzj71t.naveen@linux.ibm.com>
 <20220301142016.22e787fb@gandalf.local.home>
 <Yh9vF8REB1JlhQCJ@hirez.programming.kicks-ass.net>
 <20220302110138.6d2abcec@gandalf.local.home>
 <20220302144716.1772020c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302144716.1772020c@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 02:47:16PM -0500, Steven Rostedt wrote:
> Note, I just pulled this patch, and I hit this warning:
> 
> WARNING: CPU: 0 PID: 6965 at arch/x86/kernel/kprobes/core.c:205 recover_probed_instruction+0x8f/0xa0
> 
> static unsigned long
> __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
> {
>         struct kprobe *kp;
>         unsigned long faddr;
> 
>         kp = get_kprobe((void *)addr);
>         faddr = ftrace_location(addr);
>         /*
>          * Addresses inside the ftrace location are refused by
>          * arch_check_ftrace_location(). Something went terribly wrong
>          * if such an address is checked here.
>          */
>         if (WARN_ON(faddr && faddr != addr))  <<---- HERE
>                 return 0UL;

Ha! so a bunch of IRC later I figured out how it is possible you hit
this with just the patch on and how I legitimately hit this and what to
do about it.

Your problem seems to be that we got ftrace_location() wrong in that
lookup_rec()'s end argument is inclusive, hence we need:

	lookup_rec(ip, ip + size - 1)

Now, the above thing asserts that:

	ftrace_location(x) == {0, x}

and that is genuinely false in my case, I get x+4 as additional possible
output. So I think I need the below change to go on top of all I have:


diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 7f0ce42f8ff9..4c13406e0bc4 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -198,13 +198,14 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
 
 	kp = get_kprobe((void *)addr);
 	faddr = ftrace_location(addr);
+
 	/*
-	 * Addresses inside the ftrace location are refused by
-	 * arch_check_ftrace_location(). Something went terribly wrong
-	 * if such an address is checked here.
+	 * In case addr maps to sym+0 ftrace_location() might return something
+	 * other than faddr. In that case consider it the same as !faddr.
 	 */
-	if (WARN_ON(faddr && faddr != addr))
-		return 0UL;
+	if (faddr && faddr != addr)
+		faddr = 0;
+
 	/*
 	 * Use the current code if it is not modified by Kprobe
 	 * and it cannot be modified by ftrace.
