Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3E451867A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiECOYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbiECOXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:23:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE8541136
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:20:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 934D51042;
        Tue,  3 May 2022 07:20:14 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55AB63F774;
        Tue,  3 May 2022 07:20:13 -0700 (PDT)
Date:   Tue, 3 May 2022 15:20:06 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, elver@google.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] x86/cpu: Elide KCSAN for cpu_has() and friends
Message-ID: <YnE6Fjums+jTH96Y@lakrids>
References: <20220502110741.951055904@infradead.org>
 <20220502111216.290518605@infradead.org>
 <20220502184747.cr5ssem3g4mel4qq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502184747.cr5ssem3g4mel4qq@treble>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 11:47:47AM -0700, Josh Poimboeuf wrote:
> On Mon, May 02, 2022 at 01:07:43PM +0200, Peter Zijlstra wrote:
> > vmlinux.o: warning: objtool: enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x28: call to __kcsan_check_access() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x24: call to __kcsan_check_access() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> An explanation about *why* this fixes it would help, as I have no idea
> from looking at the patch.

How about something like:

| As x86 uses the <asm-generic/bitops/instrumented-*.h> headers, the
| regular forms of all bitops are instrumented with explicit calls to
| KASAN and KCSAN checks. As these are explicit calls, these are not
| suppressed by the noinstr function attribute.
|
| This can result in calls to those check functions in noinstr code, which
| objtool warns about:
|
| vmlinux.o: warning: objtool: enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section
| vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x28: call to __kcsan_check_access() leaves .noinstr.text section
| vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x24: call to __kcsan_check_access() leaves .noinstr.text section
| vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section
|
| Prevent this by using the arch_*() bitops, which are the underlying
| bitops without explciit instrumentation.

Thanks,
Mark.

> 
> > ---
> >  arch/x86/include/asm/cpufeature.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/arch/x86/include/asm/cpufeature.h
> > +++ b/arch/x86/include/asm/cpufeature.h
> > @@ -51,7 +51,7 @@ extern const char * const x86_power_flag
> >  extern const char * const x86_bug_flags[NBUGINTS*32];
> >  
> >  #define test_cpu_cap(c, bit)						\
> > -	 test_bit(bit, (unsigned long *)((c)->x86_capability))
> > +	 arch_test_bit(bit, (unsigned long *)((c)->x86_capability))
> >  
> >  /*
> >   * There are 32 bits/features in each mask word.  The high bits
> > 
> > 
> 
> -- 
> Josh
> 
