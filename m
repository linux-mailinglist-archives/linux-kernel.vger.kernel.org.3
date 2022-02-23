Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4AC4C1556
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbiBWOYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbiBWOX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:23:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386FAB1A87
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:23:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84B061598
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A420DC340F8;
        Wed, 23 Feb 2022 14:23:28 +0000 (UTC)
Date:   Wed, 23 Feb 2022 09:23:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Miroslav Benes <mbenes@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 04/29] x86/livepatch: Validate __fentry__ location
Message-ID: <20220223092327.0c73872d@gandalf.local.home>
In-Reply-To: <20220223074139.161acfd0@rorschach.local.home>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.808810436@infradead.org>
 <20220218210831.u2ugtfr7gxllk4cs@treble>
 <YhYH6FMNh8pMws6Z@hirez.programming.kicks-ass.net>
 <YhYTFhepH/rrUfBc@hirez.programming.kicks-ass.net>
 <20220223074139.161acfd0@rorschach.local.home>
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

On Wed, 23 Feb 2022 07:41:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

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

Now we could do:

	return ip <= (rec->ip + MCOUNT_INSN_SIZE) ? rec->ip : 0;

Since we would want rec->ip if the pointer is before the ftrace
instruction. But we would need to audit all use cases and make sure this is
not called from any hot paths (in a callback).

This will affect kprobes and BPF as they both use ftrace_location() as well.

-- Steve
