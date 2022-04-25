Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13C650E97D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244940AbiDYTck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiDYTcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:32:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6179710771F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=awj94s8QiSJk5QQmmIocE0WQKxO9tJBA8flAnToejHg=; b=SmFdvDD4mJo2pKI7CD1gbRKQqj
        Np1t+o4po8Vpok0gKDKfgVbUesNtbuZwJitQASEJit2Y0n3xegqc8sDgJfqtZctsRM/tqF2dJnjsS
        7l1slBliK8pWZotOZJYx8KycoSJhlSC48KIW+GLVZWRw5Zp30WrJkav94Fn5uRd5LVGFxa3dg2ALw
        z6aTkpW4MDT7V6SRk+s5yDKkuHtqlsuMUGFdDiPHKwm/FFn4mnZiOgPnMWucuONRC7OeijqDoBTm7
        rPpE9tC1X83OFpgKwQR0FwX2P30qeB1pps6fRXMC2bCD8BN586uZtGpHsAn6ZXfn8Ye2OoodI2JP1
        sRfpaCVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj4OI-008xx7-QQ; Mon, 25 Apr 2022 19:28:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF0D8980DC6; Mon, 25 Apr 2022 21:28:56 +0200 (CEST)
Date:   Mon, 25 Apr 2022 21:28:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Stephen Zhang <starzhangzsd@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, laijs@linux.alibaba.com,
        lihuafei1@huawei.com, fenghua.yu@intel.com,
        chang.seok.bae@intel.com, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/traps: add CONFIG_BUG to the use of __warn()
Message-ID: <20220425192856.GG2762@worktop.programming.kicks-ass.net>
References: <20220425055935.458583-1-starzhangzsd@gmail.com>
 <7558ae3d-a1fa-6c11-cccd-ad0f65cde25b@intel.com>
 <20220425182456.GL2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425182456.GL2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 08:24:56PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 25, 2022 at 09:05:17AM -0700, Dave Hansen wrote:
> > On 4/24/22 22:59, Stephen Zhang wrote:
> > > --- a/arch/x86/kernel/traps.c
> > > +++ b/arch/x86/kernel/traps.c
> > > @@ -246,7 +246,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> > >  	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
> > >  	if (!ibt_fatal) {
> > >  		printk(KERN_DEFAULT CUT_HERE);
> > > +#ifdef CONFIG_BUG
> > >  		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
> > > +#endif
> > 
> > This really should be done with an #ifdef'd stub in in bug.h, not an
> > #ifdef at every call site.  I assume there was a good reason for not
> > using the normal WARN*() macros.
> 
> I think the idea was to have the pr_err() unconditional, and if you have
> the fancy crap on also print a full backtrace or something.
> 
> But yeah, a few stubs in bug.h ought to make this go away too.

As pointed out by Boris, __warn is actually uncondtionally defined in
panic.c, the below seems to build.

---
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index edb0e2a602a8..ba1f860af38b 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -21,6 +21,12 @@
 #include <linux/panic.h>
 #include <linux/printk.h>
 
+struct warn_args;
+struct pt_regs;
+
+void __warn(const char *file, int line, void *caller, unsigned taint,
+	    struct pt_regs *regs, struct warn_args *args);
+
 #ifdef CONFIG_BUG
 
 #ifdef CONFIG_GENERIC_BUG
@@ -110,11 +116,6 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #endif
 
 /* used internally by panic.c */
-struct warn_args;
-struct pt_regs;
-
-void __warn(const char *file, int line, void *caller, unsigned taint,
-	    struct pt_regs *regs, struct warn_args *args);
 
 #ifndef WARN_ON
 #define WARN_ON(condition) ({						\
