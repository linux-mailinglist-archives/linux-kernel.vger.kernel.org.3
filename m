Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4CE4F8490
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345660AbiDGQJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiDGQJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:09:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDA811C24
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uULevPUPsVL0oswgae523Gc8/vVaWfZTuFpKr5r69E4=; b=nHI8mLdoKtQkPRXjtEiiwcaFYq
        2B3aEzYsP30NvoPQtkl3ajxWl4zmqouFd6zQL3I5pvjPtOTSvUd6WwhxMOExBjdwP4wvpxGSMPhon
        32RT5tNMcGKKf+ANk3H1WaIlKvkBx8q5Oq3ut7ZK556tLvbKzieLi9f6hPYqVSkRiMF2QsGv093fc
        5D9tQbEzJUhghiOQerKe3LBV/kp7mSsW5VRCqCcpKw9uaR7iJVSFvh/P2usr6aoNT6zRxmqwx/i+k
        7K5ytRkQbF5IoL1JlwycsiNTgPh5XNQi11NS/f32pw9GM+SF9pMF4+YGhJS1ciT84//yCTULSYVB6
        1UMUPQKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncUfH-002YFG-2A; Thu, 07 Apr 2022 16:07:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5D039862CF; Thu,  7 Apr 2022 18:07:15 +0200 (CEST)
Date:   Thu, 7 Apr 2022 18:07:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: IBT related objtool warnings
Message-ID: <20220407160715.GB2762@worktop.programming.kicks-ass.net>
References: <314eeced310b07b50b500384741378e59168c36c.camel@intel.com>
 <20220407155106.GL2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407155106.GL2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 05:51:06PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 06, 2022 at 10:43:33PM +0000, Edgecombe, Rick P wrote:
> > Hi,
> > 
> > After commit:
> > ed53a0d97192 x86/alternative: Use .ibt_endbr_seal to seal indirect calls
> > 
> > I am getting objtool "unreachable instruction" warnings.
> > 
> > On one system with gcc 8.4.0:
> > vmlinux.o: warning: objtool: start_secondary()+0x10e: unreachable
> > instruction
> > 
> > On another with gcc 11.2.1:
> > vmlinux.o: warning: objtool: pvh_start_xen()+0x0: unreachable
> > instruction
> > 
> > Let me know if any tests on my end would help.
> 
> This seems to make it go on gcc-11.2 tip/x86/urgent..
> 
> ---
> 
>  arch/x86/entry/entry_64.S    | 3 +++
>  arch/x86/platform/pvh/head.S | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 4faac48ebec5..73d958522b6a 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -337,6 +337,9 @@ SYM_CODE_END(ret_from_fork)
>  
>  	call	\cfunc
>  
> +	/* For some configurations \cfunc ends up being a noreturn. */
> +	REACHABLE
> +
>  	jmp	error_return
>  .endm
>  
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> index 72c1e42d121d..7fe564eaf228 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -50,6 +50,7 @@
>  #define PVH_DS_SEL		(PVH_GDT_ENTRY_DS * 8)
>  
>  SYM_CODE_START_LOCAL(pvh_start_xen)
> +	UNWIND_HINT_EMPTY
>  	cld
>  
>  	lgdt (_pa(gdt))

And this for gcc-8.4

---
 include/linux/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 9cf51e41e697..54dc2f9a2d56 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -167,7 +167,7 @@ static inline int suspend_disable_secondary_cpus(void) { return 0; }
 static inline void suspend_enable_secondary_cpus(void) { }
 #endif /* !CONFIG_PM_SLEEP_SMP */
 
-void cpu_startup_entry(enum cpuhp_state state);
+void __noreturn cpu_startup_entry(enum cpuhp_state state);
 
 void cpu_idle_poll_ctrl(bool enable);
 
