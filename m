Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238FE4C15C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbiBWOue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiBWOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:50:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA6AB54EE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/XIKglpkGJlUxAF3I7Y0mwOt86MlFbcHCmVyR6whTEo=; b=CB4uwLoyqapFooLZALyq6YMNbu
        OfMF8pF3zJgFq27GNvuKGf4M8ArU8l/W3Js/NjK0FjuYy0ZYgKjlMQYUaOGvMBaFCWt60j4OFqMd9
        QEI9qeVElRQdAFDfDpewTdXqaE53+yP2rBq+1JKrPSo4NmfYh/8eSvRq8HoeIQBV0TE0pwC1gxsrS
        Z1bMqAioWR5v61Z6cItnSasNvwe1PWtOptz+6H3wdCPShBwnzpew5M5zp7TnHdhM2yJYW1sZbc+o8
        HoaaOaXHZlDcuZR5qJfHnHTFB/0cKKOmHtKVxIzLpXVrLplMPde5XugIIyvh5AlHaoOzb98RcN1sg
        UsjtKH7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMsxb-003qBM-9E; Wed, 23 Feb 2022 14:49:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 57FC930045A;
        Wed, 23 Feb 2022 15:49:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C5EC20C40DAE; Wed, 23 Feb 2022 15:49:41 +0100 (CET)
Date:   Wed, 23 Feb 2022 15:49:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Miroslav Benes <mbenes@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 04/29] x86/livepatch: Validate __fentry__ location
Message-ID: <YhZJhSD3QyNSG/bP@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.808810436@infradead.org>
 <20220218210831.u2ugtfr7gxllk4cs@treble>
 <YhYH6FMNh8pMws6Z@hirez.programming.kicks-ass.net>
 <YhYTFhepH/rrUfBc@hirez.programming.kicks-ass.net>
 <20220223074139.161acfd0@rorschach.local.home>
 <20220223092327.0c73872d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223092327.0c73872d@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:23:27AM -0500, Steven Rostedt wrote:
> On Wed, 23 Feb 2022 07:41:39 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
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

		if (!offset)

> > > +		rec = lookup_rec(ip - offset, (ip - offset) + size);
> > > +	}
> > > +  
> > 
> > Please create a new function for this. Perhaps find_ftrace_location().
> > 
> > ftrace_location() is used to see if the address given is a ftrace
> > nop or not. This change will make it always return true.
> 
> Now we could do:
> 
> 	return ip <= (rec->ip + MCOUNT_INSN_SIZE) ? rec->ip : 0;

I don't see the point of that MCOUNT_INSN_SIZE there, I've done the
above. If +0 then find the entry, wherever it may be.

> Since we would want rec->ip if the pointer is before the ftrace
> instruction. But we would need to audit all use cases and make sure this is
> not called from any hot paths (in a callback).
> 
> This will affect kprobes and BPF as they both use ftrace_location() as well.

Yes, I already fixed kprobes, still trying to (re)discover how to run
the bpf-selftests, that stuff is too painful :-(
