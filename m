Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D094C4954
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiBYPmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiBYPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:42:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C939218CFA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=phinr280VwVKDmruUSSbdEFgvjKjzBhxTPX5a18+nqo=; b=NWqMEhjSBZd+SzYk3ksCdgAeEM
        AiCjDimVWZ8gqSaOFkzlyKkvWrDQIro3WHm4TrgRAkS6RJqKQ6eU9UM1A8ecH5s3R2ah14fXtVS0O
        9oiwzUKqLjMBQyHZV0U1HCCbTh0BCmC4X9c9uxdVrm6wig4agLT+nw8YlPpCN73IIcmhKgT+/WwkC
        3tTapt+1XbdRws7z+5fVv0+Ili4jdSMWlzygXbiT2+5OPieayimVT7oZ+C5/ZWTBTGwHBDfK4fe/A
        Fg4AOZ4BWZ0qPP/3zItElErPDXgOTrVbE9ez3TqlE/URnW8+qZO5+DpLSbCcxCG18nshwMn+p8VuM
        p968mcDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNcia-00CzlY-CO; Fri, 25 Feb 2022 15:41:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AFCA9300296;
        Fri, 25 Feb 2022 16:41:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93C13200AB1A1; Fri, 25 Feb 2022 16:41:15 +0100 (CET)
Date:   Fri, 25 Feb 2022 16:41:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <Yhj4myrr0X6USU3+@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.892372059@infradead.org>
 <20220225103215.77080de0b3edd0fa2839b8fa@kernel.org>
 <YhizfwoddLwWWl2J@hirez.programming.kicks-ass.net>
 <20220225224249.cbabe82e530758cdb28e65e9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225224249.cbabe82e530758cdb28e65e9@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 10:42:49PM +0900, Masami Hiramatsu wrote:

> OK, this sounds like kp->addr should be "call fentry" if there is ENDBR.
> 
> > 
> > This patch takes the approach that sym+0 means __fentry__, irrespective
> > of where it might actually live. I *think* that's more or less
> > consistent with what other architectures do; specifically see
> > arch/powerpc/kernel/kprobes.c:kprobe_lookup_name(). I'm not quite sure
> > what ARM64 does when it has BTI on (which is then very similar to what
> > we have here).
> 
> Yeah, I know the powerpc does such thing, but I think that is not what
> user expected. I actually would like to fix that, because in powerpc
> and other non-x86 case (without BTI/IBT), the instructions on sym+0 is
> actually executed.
> 
> > 
> > What do you think makes most sense here?
> 
> Are there any way to distinguish the "preparing instructions" (part of
> calling mcount) and this kind of trap instruction online[1]? If possible,
> I would like to skip such traps, but put the probe on preparing
> instructions.

None that exist, but we could easily create one. See also my email here:

  https://lkml.kernel.org/r/Yhj1oFcTl2RnghBz@hirez.programming.kicks-ass.net

That skip_endbr() function is basically what you're looking for; it just
needs a better name and a Power/ARM64 implementation to get what you
want, right?

The alternative 'hack' I've been contemplating is (ab)using
INT_MIN/INT_MAX offset for __fentry__ and __fexit__ points (that latter
is something we'll probably have to grow when CET-SHSTK or backward-edge
CFI gets to be done, because then ROP tricks as used by function-graph
and kretprobes are out the window).

That way sym+[0..size) is still a valid reference to the actual
instruction in the symbol, but sym+INT_MIN will hard map to __fentry__
while sym+INT_MAX will get us __fexit__.
