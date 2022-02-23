Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD01C4C1538
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241473AbiBWORN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbiBWORI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:17:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7665911C24
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:16:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09246B81EAD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ED6C340E7;
        Wed, 23 Feb 2022 14:16:34 +0000 (UTC)
Date:   Wed, 23 Feb 2022 09:16:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 04/29] x86/livepatch: Validate __fentry__ location
Message-ID: <20220223091632.50cb79a7@gandalf.local.home>
In-Reply-To: <YhY/NpGRq8Dv4etZ@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
        <20220218171408.808810436@infradead.org>
        <20220218210831.u2ugtfr7gxllk4cs@treble>
        <YhYH6FMNh8pMws6Z@hirez.programming.kicks-ass.net>
        <YhYTFhepH/rrUfBc@hirez.programming.kicks-ass.net>
        <20220223074139.161acfd0@rorschach.local.home>
        <YhY/NpGRq8Dv4etZ@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 15:05:42 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Feb 23, 2022 at 07:41:39AM -0500, Steven Rostedt wrote:
> > On Wed, 23 Feb 2022 11:57:26 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -1578,7 +1578,23 @@ unsigned long ftrace_location_range(unsi
> > >   */
> > >  unsigned long ftrace_location(unsigned long ip)
> > >  {
> > > -	return ftrace_location_range(ip, ip);
> > > +	struct dyn_ftrace *rec;
> > > +	unsigned long offset;
> > > +	unsigned long size;
> > > +
> > > +	rec = lookup_rec(ip, ip);
> > > +	if (!rec) {
> > > +		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
> > > +			goto out;
> > > +
> > > +		rec = lookup_rec(ip - offset, (ip - offset) + size);
> > > +	}
> > > +  
> > 
> > Please create a new function for this. Perhaps find_ftrace_location().
> > 
> > ftrace_location() is used to see if the address given is a ftrace
> > nop or not. This change will make it always return true.
> >   
> 
> # git grep ftrace_location
> arch/powerpc/include/asm/livepatch.h:#define klp_get_ftrace_location klp_get_ftrace_location
> arch/powerpc/include/asm/livepatch.h:static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
> arch/powerpc/include/asm/livepatch.h:   return ftrace_location_range(faddr, faddr + 16);
> arch/powerpc/kernel/kprobes.c:          faddr = ftrace_location_range((unsigned long)addr,
> arch/x86/kernel/kprobes/core.c: faddr = ftrace_location(addr);
> arch/x86/kernel/kprobes/core.c:  * arch_check_ftrace_location(). Something went terribly wrong
> include/linux/ftrace.h:unsigned long ftrace_location(unsigned long ip);
> include/linux/ftrace.h:unsigned long ftrace_location_range(unsigned long start, unsigned long end);
> include/linux/ftrace.h:static inline unsigned long ftrace_location(unsigned long ip)
> kernel/bpf/trampoline.c:static int is_ftrace_location(void *ip)
> kernel/bpf/trampoline.c:        addr = ftrace_location((long)ip);
> kernel/bpf/trampoline.c:        ret = is_ftrace_location(ip);
> kernel/kprobes.c:               unsigned long faddr = ftrace_location((unsigned long)addr);
> kernel/kprobes.c:static int check_ftrace_location(struct kprobe *p)
> kernel/kprobes.c:       ftrace_addr = ftrace_location((unsigned long)p->addr);
> kernel/kprobes.c:       ret = check_ftrace_location(p);
> kernel/livepatch/patch.c:#ifndef klp_get_ftrace_location
> kernel/livepatch/patch.c:static unsigned long klp_get_ftrace_location(unsigned long faddr)
> kernel/livepatch/patch.c:       return ftrace_location(faddr);
> kernel/livepatch/patch.c:                       klp_get_ftrace_location((unsigned long)func->old_func);
> kernel/livepatch/patch.c:                       klp_get_ftrace_location((unsigned long)func->old_func);
> kernel/trace/ftrace.c: * ftrace_location_range - return the first address of a traced location
> kernel/trace/ftrace.c:unsigned long ftrace_location_range(unsigned long start, unsigned long end)
> kernel/trace/ftrace.c: * ftrace_location - return true if the ip giving is a traced location
> kernel/trace/ftrace.c:unsigned long ftrace_location(unsigned long ip)
> kernel/trace/ftrace.c:  ret = ftrace_location_range((unsigned long)start,
> kernel/trace/ftrace.c:  if (!ftrace_location(ip))
> kernel/trace/ftrace.c:  ip = ftrace_location(ip);
> kernel/trace/ftrace.c:  ip = ftrace_location(ip);
> kernel/trace/trace_kprobe.c:     * Since ftrace_location_range() does inclusive range check, we need
> kernel/trace/trace_kprobe.c:    return !ftrace_location_range(addr, addr + size - 1);
> 
> and yet almost every caller takes the address it returns...

And they check if the returned value is 0 or not. If it is zero, it lets
them know it isn't an ftrace location.

-- Steve
