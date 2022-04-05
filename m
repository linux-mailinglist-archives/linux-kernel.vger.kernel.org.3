Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1D34F3BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 17:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382122AbiDEMAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 08:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiDEIQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:16:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1946FA3D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=esA02a7oh965kskQzv4SS8tP7F5wpRe9ez3P/VwbZ3A=; b=kIYvLQ5PNZ4kqh3JmglRTIV0u8
        sV10s3bmaS5912V9wJqud/UoqIv6f6s0K37MizNc0BwEmMcj7uIK/WwSm7fSA/Znl1oKEOzxNjVaa
        PTq53BuqJF9WxWJ8UfR109zHnd2bghX5zAXn59RHx/zU8tW3HSTpJE7d2E7slkbVw8KJMwhQqvCIS
        Gcm45cfqQh0z2IBbDOJV020FS3mC7vPh9A2KPA4KXBoU94+OvBRYhDVBXV1hsrzXy3gl74t2j+Jtu
        27bUJkJB9/rQsx0GzCj5c2ZkzDvZk4amPMQlMSr0Ts6YjJxr5TNCBxrqKEV/5cLvZPmqhJo/e9v9j
        6i1P8AIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbeA5-001o5L-3e; Tue, 05 Apr 2022 08:03:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FE80986B5B; Tue,  5 Apr 2022 10:03:35 +0200 (CEST)
Date:   Tue, 5 Apr 2022 10:03:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: vmlinux.o: warning: objtool: stackleak_erase()+0x35: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <20220405080335.GC30877@worktop.programming.kicks-ass.net>
References: <202204042008.sCQbEmVS-lkp@intel.com>
 <202204041125.500C28FD8@keescook>
 <20220404152502.0621caf9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404152502.0621caf9@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 03:25:02PM -0400, Steven Rostedt wrote:
> On Mon, 4 Apr 2022 11:27:47 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > I got CCed on this because of stackleak_erase() triggering, this, but it
> > appears to be an existing issue for other callers too. It looks like
> > __branch_check__() shouldn't be emitting ftrace_likely_update() calls
> > for noinstr functions...
> > 
> > I have no idea how a macro is meant to check for function attributes,
> > though... :(
> 
> Ignore it. It's the branch tracer enabled (that is, every "if ()" is being
> traced).
> 
> Although I still use the branch profiler, I do not believe anyone uses the
> branch tracer. The branch profiler updates an array of counters that tells
> when the branch was true or false, the branch tracer actually traces
> (records an event) for every branch in the system!

\o/

> I think I'll just send a patch to nuke the tracer. I'm sure Peter Zijlstra
> will be happy when I do that. But I still want the profiler, as I find that
> useful.

It'll explode the moment Lai's entry rework goes through. That'll make
us run C code before we switch to the kernel address space, so your
counters will not exist/be-mapped and *BOOM*.


