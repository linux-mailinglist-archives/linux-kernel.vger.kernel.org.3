Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E89F5AFF95
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiIGIvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIGIuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:50:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8BE72860;
        Wed,  7 Sep 2022 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M9ffSCcPAJFL/NG3iecTA6XnLuNGeYKgtteM2yRjbw8=; b=RkCkoGesMVEcRNleJvacW27ZN9
        eY6mqXlLytLmnVTUKkvVx8upYmP36N0nVMK6OGviCGk0MrGxxqvCKFQ2sVRWckFQAB5ga87K5lECr
        7m0wErxJQXSkUWe0P3Qq31N3F9tBcfUN2tNLtWayNUzwxQGjlG35NgtA8f1SDxw4a6Bx/48ySEszA
        KPjszB/XFsGfcyya0D92vkgmt8MBtS9AeDfzrSfDWIxuZ8jnpXh+c9RTwBZWtiuuZHUMtPsReO5PX
        Cud2D6l2SHerN+rFL9hFmy6zneagpc7A2yy9HT/ovVqtGCSOiWRuqX7kFvwVUvfahUbviFXUq9k90
        gaDEFQVA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVql3-00APB3-3s; Wed, 07 Sep 2022 08:50:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C72E130013F;
        Wed,  7 Sep 2022 10:50:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DD9B20134FB3; Wed,  7 Sep 2022 10:50:03 +0200 (CEST)
Date:   Wed, 7 Sep 2022 10:50:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Kees Cook <keescook@chromium.org>,
        Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
Message-ID: <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net>
References: <20220902213750.1124421-1-morbo@google.com>
 <20220902213750.1124421-3-morbo@google.com>
 <202209022251.B14BD50B29@keescook>
 <CAGG=3QXpK+bFOSYZkdNNFGzNfgJSSADGTRWYRv6z0vfBAgQvWQ@mail.gmail.com>
 <CAKwvOdm+kVTrqMrSPHwTa0NrG9qwTcFkGnikjYjk0ctFGBfeRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm+kVTrqMrSPHwTa0NrG9qwTcFkGnikjYjk0ctFGBfeRA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:00:07PM -0700, Nick Desaulniers wrote:
> On Sun, Sep 4, 2022 at 11:02 PM Bill Wendling <morbo@google.com> wrote:
> >
> > On Sat, Sep 3, 2022 at 12:18 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Sep 02, 2022 at 09:37:50PM +0000, Bill Wendling wrote:
> > > > [...]
> > > >         callq   *pv_ops+536(%rip)
> > >
> > > Do you know which pv_ops function is this? I can't figure out where
> > > pte_offset_kernel() gets converted into a pv_ops call....
> > >
> > This one is _paravirt_ident_64, I believe. I think that the original
> > issue Nathan was seeing was with another seemingly innocuous function.
> 
> _paravirt_ident_64 is marked noinstr, which makes me suspect that it
> really needs to not be touched at all by the compiler for
> these...special features.

My source tree sayeth:

  u64 notrace _paravirt_ident_64(u64 x)

And that function is only ever called at boot, after alternatives runs
it's patched with:

  mov %_ASM_ARG1, %_ASM_AX

Anyway, if you want to take it away from the compiler, something like
so should do.


diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 7ca2d46c08cc..8922e2887779 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -80,11 +80,16 @@ static unsigned paravirt_patch_call(void *insn_buff, const void *target,
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
-/* identity function, which can be inlined */
-u64 notrace _paravirt_ident_64(u64 x)
-{
-	return x;
-}
+extern u64 _paravirt_ident_64(u64 x);
+asm (".pushsection .entry.text, \"ax\"\n"
+     ".global _paravirt_ident_64\n"
+     "_paravirt_ident_64:\n\t"
+     ASM_ENDBR
+     "mov %" _ASM_ARG1 ", %" _ASM_AX "\n\t"
+     ASM_RET
+     ".size _paravirt_ident_64, . - _paravirt_ident_64\n\t"
+     ".type _paravirt_ident_64, @function\n\t"
+     ".popsection");
 #endif
 
 DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
