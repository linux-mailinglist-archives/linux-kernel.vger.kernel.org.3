Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B4D4C1512
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241366AbiBWOGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiBWOGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:06:44 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC1B12E2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TInI1bTa3WtJGe7Yb0i+t+irNmd/vVHxW/Lm6/QdUw4=; b=S1WFhR5iO5nxQhe/++sN/hnX2s
        SwoQTex+i0+jbRGBj0WPrMh2UFMhQyw7LTq2Sh2iUTFohjfcD8C6QeMOH5mvxjtVqOhG2qyiKBiuo
        L2szfFr97mZk4Nyo/xCWFwWLQzSlza9Uac3voRP1l5LcgsxtRyl92yv/n7FX+afp4xhv8yteGebhb
        OvHFed76I9RezQgdorwjnsOR3KbIBbjAG67Dp8a1Wy60zB5rr0W3s3G9s9w7tPUouNkF48Iu9fw6+
        4S1ss3kdKgUlnJKrHKsYXgsmGfzNhGz6CzliEzzXTbJ0ihpgkoFU2WKkVD/bzV9WSzfGS1gMw0Mqk
        D/N0i2tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMsH2-00CHVD-Ks; Wed, 23 Feb 2022 14:05:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 54B75300296;
        Wed, 23 Feb 2022 15:05:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13B29285736C2; Wed, 23 Feb 2022 15:05:42 +0100 (CET)
Date:   Wed, 23 Feb 2022 15:05:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 04/29] x86/livepatch: Validate __fentry__ location
Message-ID: <YhY/NpGRq8Dv4etZ@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.808810436@infradead.org>
 <20220218210831.u2ugtfr7gxllk4cs@treble>
 <YhYH6FMNh8pMws6Z@hirez.programming.kicks-ass.net>
 <YhYTFhepH/rrUfBc@hirez.programming.kicks-ass.net>
 <20220223074139.161acfd0@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223074139.161acfd0@rorschach.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 07:41:39AM -0500, Steven Rostedt wrote:
> On Wed, 23 Feb 2022 11:57:26 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -1578,7 +1578,23 @@ unsigned long ftrace_location_range(unsi
> >   */
> >  unsigned long ftrace_location(unsigned long ip)
> >  {
> > -	return ftrace_location_range(ip, ip);
> > +	struct dyn_ftrace *rec;
> > +	unsigned long offset;
> > +	unsigned long size;
> > +
> > +	rec = lookup_rec(ip, ip);
> > +	if (!rec) {
> > +		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
> > +			goto out;
> > +
> > +		rec = lookup_rec(ip - offset, (ip - offset) + size);
> > +	}
> > +
> 
> Please create a new function for this. Perhaps find_ftrace_location().
> 
> ftrace_location() is used to see if the address given is a ftrace
> nop or not. This change will make it always return true.
> 

# git grep ftrace_location
arch/powerpc/include/asm/livepatch.h:#define klp_get_ftrace_location klp_get_ftrace_location
arch/powerpc/include/asm/livepatch.h:static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
arch/powerpc/include/asm/livepatch.h:   return ftrace_location_range(faddr, faddr + 16);
arch/powerpc/kernel/kprobes.c:          faddr = ftrace_location_range((unsigned long)addr,
arch/x86/kernel/kprobes/core.c: faddr = ftrace_location(addr);
arch/x86/kernel/kprobes/core.c:  * arch_check_ftrace_location(). Something went terribly wrong
include/linux/ftrace.h:unsigned long ftrace_location(unsigned long ip);
include/linux/ftrace.h:unsigned long ftrace_location_range(unsigned long start, unsigned long end);
include/linux/ftrace.h:static inline unsigned long ftrace_location(unsigned long ip)
kernel/bpf/trampoline.c:static int is_ftrace_location(void *ip)
kernel/bpf/trampoline.c:        addr = ftrace_location((long)ip);
kernel/bpf/trampoline.c:        ret = is_ftrace_location(ip);
kernel/kprobes.c:               unsigned long faddr = ftrace_location((unsigned long)addr);
kernel/kprobes.c:static int check_ftrace_location(struct kprobe *p)
kernel/kprobes.c:       ftrace_addr = ftrace_location((unsigned long)p->addr);
kernel/kprobes.c:       ret = check_ftrace_location(p);
kernel/livepatch/patch.c:#ifndef klp_get_ftrace_location
kernel/livepatch/patch.c:static unsigned long klp_get_ftrace_location(unsigned long faddr)
kernel/livepatch/patch.c:       return ftrace_location(faddr);
kernel/livepatch/patch.c:                       klp_get_ftrace_location((unsigned long)func->old_func);
kernel/livepatch/patch.c:                       klp_get_ftrace_location((unsigned long)func->old_func);
kernel/trace/ftrace.c: * ftrace_location_range - return the first address of a traced location
kernel/trace/ftrace.c:unsigned long ftrace_location_range(unsigned long start, unsigned long end)
kernel/trace/ftrace.c: * ftrace_location - return true if the ip giving is a traced location
kernel/trace/ftrace.c:unsigned long ftrace_location(unsigned long ip)
kernel/trace/ftrace.c:  ret = ftrace_location_range((unsigned long)start,
kernel/trace/ftrace.c:  if (!ftrace_location(ip))
kernel/trace/ftrace.c:  ip = ftrace_location(ip);
kernel/trace/ftrace.c:  ip = ftrace_location(ip);
kernel/trace/trace_kprobe.c:     * Since ftrace_location_range() does inclusive range check, we need
kernel/trace/trace_kprobe.c:    return !ftrace_location_range(addr, addr + size - 1);

and yet almost every caller takes the address it returns...
