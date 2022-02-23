Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4BD4C17D0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbiBWPzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbiBWPzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:55:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7450AC1169
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wae+FGiQL84cnKIPPUfv0beqX1lkpHwyU5NZ2Bnju3w=; b=iU9tH1RxPkGojcCpOrKP4DkX2s
        obi2vhFPUhxv4tv5uqyqJgDYemZLqWhSiNab7zdbIKjM/w4T1sxSieODYH7giwXSJWIaV/wmVJ9a9
        f3nqkdlX+soANh0+z7hnOiytPNanGJJdI3Quo3YCF3hgI5RBtFcN+CkRcEGrCzKCEQSO7KAHM/JC0
        vq4ifIVUjAUR1+mF6tfoTyrxlPuVS2+lmbGFsn5NjxquFnUSaQLnGTWJM2PVsKPOTvCQT/H8767nX
        kH2gG9yJxbwYEikXdYp+qHV5uTJnsFq6jTphmBqjvHvTS9/e+/qRHUOunOnn5KknDlTXYrJS2fOIR
        /tL7HNOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMty5-003t2V-6O; Wed, 23 Feb 2022 15:54:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 071FC300454;
        Wed, 23 Feb 2022 16:54:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A386120C7CF24; Wed, 23 Feb 2022 16:54:14 +0100 (CET)
Date:   Wed, 23 Feb 2022 16:54:14 +0100
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
Message-ID: <YhZYpnlCQpz3m5ds@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.808810436@infradead.org>
 <20220218210831.u2ugtfr7gxllk4cs@treble>
 <YhYH6FMNh8pMws6Z@hirez.programming.kicks-ass.net>
 <YhYTFhepH/rrUfBc@hirez.programming.kicks-ass.net>
 <20220223074139.161acfd0@rorschach.local.home>
 <20220223092327.0c73872d@gandalf.local.home>
 <YhZJhSD3QyNSG/bP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhZJhSD3QyNSG/bP@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 03:49:41PM +0100, Peter Zijlstra wrote:

> > Since we would want rec->ip if the pointer is before the ftrace
> > instruction. But we would need to audit all use cases and make sure this is
> > not called from any hot paths (in a callback).
> > 
> > This will affect kprobes and BPF as they both use ftrace_location() as well.
> 
> Yes, I already fixed kprobes, still trying to (re)discover how to run
> the bpf-selftests, that stuff is too painful :-(

Ok, I think I managed... I'm obviously hitting the WARN_ON_ONCE() in
is_ftrace_location(). Funnily, no dead kernel, so that's something I
suppose.

Now, I'm trying to make sense of that code, but all that !ftrace_managed
code scares me to death.

At the very least __bpf_arch_text_poke() needs a bunch of help. Let me
go prod it with something sharp to see what falls out ...
