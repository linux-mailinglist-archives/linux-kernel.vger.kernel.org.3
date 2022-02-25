Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB784C42B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbiBYKra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239152AbiBYKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:47:27 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7D12655B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X2IS+w8Tap35XsPPF35XLygTWfgyN1T/5BqmEqmAz8Q=; b=WLFBqwgMlwjKsG1V3m8CnYPzNm
        P2G8f55YdlBc3F6bH3W7E0EEJS+rQ09VsnXIzP3kC75wRVZstONfQGODS90bom1IUmSnJssdNtHXN
        NczCuXaYsZk3JAlWIarg2yg037ftwr3OrrSMI+JXLsyR5mhEO7Pk4sEr2sltKHD5zkKXa0l4EjFFC
        ddv6BUyMXv8I74a1iJzHIs7mfkNOedv2+5KIjgtC7HhlYAO6CMHKHdUDVMSXVdiVMAYXvUkvuearY
        60nCE0JVFvi/6HI+oWit7hhPWKYMtpwcBuYzcxEKj4Umuw4f+eqY8OJwuAC36gpJLei8lfpNHS+lN
        iTZQx9kA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNY7E-00Cw0a-Tv; Fri, 25 Feb 2022 10:46:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A459300472;
        Fri, 25 Feb 2022 11:46:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29CD32C69540B; Fri, 25 Feb 2022 11:46:23 +0100 (CET)
Date:   Fri, 25 Feb 2022 11:46:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <YhizfwoddLwWWl2J@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.892372059@infradead.org>
 <20220225103215.77080de0b3edd0fa2839b8fa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225103215.77080de0b3edd0fa2839b8fa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 10:32:15AM +0900, Masami Hiramatsu wrote:
> Hi Peter,
> 
> On Thu, 24 Feb 2022 15:51:53 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > With IBT on, sym+0 is no longer the __fentry__ site.
> > 
> > NOTE: the architecture has a special case and *does* allow placing an
> > INT3 breakpoint over ENDBR in which case #BP has precedence over #CP
> > and as such we don't need to disallow probing these instructions.
> 
> Does this mean we can still putting a probe on sym+0??

I'm not sure... Possibly not. I'm not sure if there's an ABI that
by-passes kprobes_lookup_name(). Arguably you could give it a direct
address instead of a name and still hit the ENDBR I think. But the ABI
surface of this thing it too big for me to easily tell.

> If so, NAK this patch, since the KPROBES_ON_FTRACE is not meaning
> to accelerate the function entry probe, but just allows user to
> put a probe on 'call _mcount' (which can be modified by ftrace).
> 
> func:
>   endbr  <- sym+0  : INT3 is used. (kp->addr = func+0)
>   nop5   <- sym+4? : ftrace is used. (kp->addr = func+4?)
>   ...
> 
> And anyway, in some case (e.g. perf probe) symbol will be a basement
> symbol like '_text' and @offset will be the function addr - _text addr
> so that we can put a probe on local-scope function.
> 
> If you think we should not probe on the endbr, we should treat the
> pair of endbr and nop5 (or call _mcount) instructions as a virtual
> single instruction. This means kp->addr should point sym+0, but use
> ftrace to probe.
> 
> func:
>   endbr  <- sym+0  : ftrace is used. (kp->addr = func+0)
>   nop5   <- sym+4? : This is not able to be probed.
>   ...

Well, it's all a bit crap :/

This patch came from kernel/trace/trace_kprobe.c selftest failing at
boot. That tries to set a kprobe on kprobe_trace_selftest_target which
the whole kprobe machinery translates into
kprobe_trace_selftest_target+0 and then not actually hitting the fentry.

IOW, that selftest seems to hard-code/assume +0 matches __fentry__,
which just isn't true in general (arm64, powerpc are architectures that
come to mind) and now also might not be true on x86.

Calling the selftest broken works for me and I'll drop the patch.


Note that with these patches:

 - Not every function starts with ENDBR; the compiler is free to omit
   this instruction if it can determine the function address is never
   taken (and as such there's never an indirect call to it).

 - If there is an ENDBR, not every function entry will actually execute
   it. This first instruction is used exclusively as an indirect entry
   point. All direct calls should be to the next instruction.

 - If there was an ENDBR, it might be turned into a 4 byte UD1
   instruction to ensure any indirect call *will* fail.

Given all that, kprobe users are in a bit of a bind. Determining the
__fentry__ point basically means they *have* to first read the function
assembly to figure out where it is.

This patch takes the approach that sym+0 means __fentry__, irrespective
of where it might actually live. I *think* that's more or less
consistent with what other architectures do; specifically see
arch/powerpc/kernel/kprobes.c:kprobe_lookup_name(). I'm not quite sure
what ARM64 does when it has BTI on (which is then very similar to what
we have here).

What do you think makes most sense here?
