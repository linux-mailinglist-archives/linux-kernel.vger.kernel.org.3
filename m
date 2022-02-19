Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF484BC792
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbiBSJ7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 04:59:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiBSJ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 04:59:13 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D53939A9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 01:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=84VjdcPH+TY1BeSfeDU3/tQaF+9YpYfo7Rh/g+GHK0w=; b=EwkGNlIDwaUShJjpPLgTMYHEdF
        8/Be9fJCgzyQ1hH20mJHL0PYiTQVScRsc93NuO2tBobAfgfv75txb+Aj9szqxNfwq19xlV25ggCkT
        Bo2Qt6waIyzzh/rU57jSEk6KVn5s71diKc2Zbva7PNActx+nFIxXWULK9MR9pyYTgfa9OAIYyJb/x
        G6pThMfFfe9RXRp6s8U04vjJD22KDYhRtaFb9+fa/2IDPhilnjvrFaQXkYIC5e7K23pN0iqX2p5O4
        SFPPxQVsZA8Jgdf/6MqliI5F555STsrob2v35ylroZWMG0DYP8qP2oE6WWllVIdKw588iAk/8jnkW
        HoymHOPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLMVY-00B36D-N2; Sat, 19 Feb 2022 09:58:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 808A298681B; Sat, 19 Feb 2022 10:58:27 +0100 (CET)
Date:   Sat, 19 Feb 2022 10:58:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Poimboe, Josh" <jpoimboe@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 00/29] x86: Kernel IBT
Message-ID: <20220219095827.GI23216@worktop.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <7a241b81ccd21da02bc27379b0a837c09fe4f135.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a241b81ccd21da02bc27379b0a837c09fe4f135.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 01:29:45AM +0000, Edgecombe, Rick P wrote:
> On Fri, 2022-02-18 at 17:49 +0100, Peter Zijlstra wrote:
> > This is an (almost!) complete Kernel IBT implementation. It's been
> > self-hosting
> > for a few days now. That is, it runs on IBT enabled hardware
> > (Tigerlake) and is
> > capable of building the next kernel.
> > 
> > It is also almost clean on allmodconfig using GCC-11.2.
> > 
> > The biggest TODO item at this point is Clang, I've not yet looked at
> > that.
> 
> Do you need to turn this off before kexec?

Probably... :-) I've never looked at that code though; so I'm not
exactly sure where to put things.

I'm assuming kexec does a hot-unplug of all but the boot-cpu which then
leaves only a single CPU with state in machine_kexec() ? Does the below
look reasonable?

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -638,6 +638,12 @@ static __always_inline void setup_cet(st
 	}
 }
 
+void cet_disable(void)
+{
+	cr4_clear_bits(X86_CR4_CET);
+	wrmsrl(MSR_IA32_S_CET, 0);
+}
+
 /*
  * Some CPU features depend on higher CPUID levels, which may not always
  * be available due to CPUID level capping or broken virtualization
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 33d41e350c79..cf26356db53e 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -72,4 +72,7 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
 #else
 static inline void init_ia32_feat_ctl(struct cpuinfo_x86 *c) {}
 #endif
+
+extern void cet_disable(void);
+
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index f5da4a18070a..29a2a1732605 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -310,6 +310,7 @@ void machine_kexec(struct kimage *image)
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 	hw_breakpoint_disable();
+	cet_disable();
 
 	if (image->preserve_context) {
 #ifdef CONFIG_X86_IO_APIC
