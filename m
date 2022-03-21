Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF7B4E2D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350631AbiCUQGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbiCUQGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:06:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1BB1EC53;
        Mon, 21 Mar 2022 09:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kTrt/5pX9PnRnJo5oHL3WG+33ty/9VWvLwvtG9fEbwU=; b=qih6R7TEe0pxJ3/a/75RkzBjxc
        +a1QvWKlo6ZJJprM2R1stVMA7yf1zF4Mo3mzZujtDOjnMAWfzUlkMnBEfk04R0x3maynyzfbX7I/n
        cJzC8KZuwAFyb/ztnVg00qgEuTx+cFLxHMvDksyrnD8LdyL/sOBc6BUqenK3qJYSNSo0SbQ6sMXgD
        LxZZyUK9dIgPePC9k2yPopKt3YJIQlZ1WUMcoWoltXIhvM7ywN8T+kXacUDSsX8GtpifX5I3s0F7t
        Rz19BXeliWl94b64QDKLzJ8BJKcMqO22GU5TwRgxMSgf/tsA7hNNksnuX4gWC9K41T5gKnRDm9+7l
        7EukiD1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWKWF-003AQa-Bv; Mon, 21 Mar 2022 16:04:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3080130031D;
        Mon, 21 Mar 2022 17:04:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC7FA26718E94; Mon, 21 Mar 2022 17:04:28 +0100 (CET)
Date:   Mon, 21 Mar 2022 17:04:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhiramat@kernel.org, ast@kernel.org, hjl.tools@gmail.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <YjiiDFHIQg78QwSb@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
 <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
 <20220321112805.1393f9b9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321112805.1393f9b9@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 11:28:05AM -0400, Steven Rostedt wrote:
> On Mon, 21 Mar 2022 14:04:05 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:

> > Also, folks, I'm thinking we should start to move to __fexit__, if CET
> > SHSTK ever wants to come to kernel land return trampolines will
> > insta-stop working.
> > 
> > Hjl, do you think we could get -mfexit to go along with -mfentry ?

> int funcA () {
> 	[..]
> 	return funcB();
> }

> This currently works with function graph and kretprobe tracing because of
> the shadow stack. Let's say we traced both funcA and funcB
> 
> funcA:
> 	call __fentry__
			push funcA on trace-stack
> 
> 	[..]
> 	jmp funcB
> 
> funcB:
> 	call __fentry__
			push funcB on trace-stack
> 
> 	[..]
	call __fexit__
			pop trace-stack until empty
			  'exit funcB'
			  'exit funcA'

> 	ret

> 
> That is, the current algorithm traces the end of both funcA and funcB
> without issue, because of how the shadow stack works.

And it all works, no? Or what am I missing?
