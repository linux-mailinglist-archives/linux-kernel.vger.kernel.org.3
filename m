Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A49150A48C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390288AbiDUPp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390347AbiDUPpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:45:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09BE49250
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4D6E5CE2420
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE24C385A5;
        Thu, 21 Apr 2022 15:42:03 +0000 (UTC)
Date:   Thu, 21 Apr 2022 11:42:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <20220421114201.21228eeb@gandalf.local.home>
In-Reply-To: <YmF0xYpTMoWOIl00@lakrids>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
        <20220316100132.244849-4-bobo.shaobowang@huawei.com>
        <YmFXrBG5AmX3+4f8@lakrids>
        <20220421100639.03c0d123@gandalf.local.home>
        <YmF0xYpTMoWOIl00@lakrids>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 16:14:13 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> > Let's say you have 10 ftrace_ops registered (with bpf and kprobes this can
> > be quite common). But each of these ftrace_ops traces a function (or
> > functions) that are not being traced by the other ftrace_ops. That is, each
> > ftrace_ops has its own unique function(s) that they are tracing. One could
> > be tracing schedule, the other could be tracing ksoftirqd_should_run
> > (whatever).  
> 
> Ok, so that's when messing around with bpf or kprobes, and not generally
> when using plain old ftrace functionality under /sys/kernel/tracing/
> (unless that's concurrent with one of the former, as per your other
> reply) ?

It's any user of the ftrace infrastructure, which includes kprobes, bpf,
perf, function tracing, function graph tracing, and also affects instances.

> 
> > Without this change, because the arch does not support dynamically
> > allocated trampolines, it means that all these ftrace_ops will be
> > registered to the same trampoline. That means, for every function that is
> > traced, it will loop through all 10 of theses ftrace_ops and check their
> > hashes to see if their callback should be called or not.  
> 
> Sure; I can see how that can be quite expensive.
> 
> What I'm trying to figure out is who this matters to and when, since the
> implementation is going to come with a bunch of subtle/fractal
> complexities, and likely a substantial overhead too when enabling or
> disabling tracing of a patch-site. I'd like to understand the trade-offs
> better.
> 
> > With dynamically allocated trampolines, each ftrace_ops will have their own
> > trampoline, and that trampoline will be called directly if the function
> > is only being traced by the one ftrace_ops. This is much more efficient.
> > 
> > If a function is traced by more than one ftrace_ops, then it falls back to
> > the loop.  
> 
> I see -- so the dynamic trampoline is just to get the ops? Or is that
> doing additional things?

It's to get both the ftrace_ops (as that's one of the parameters) as well
as to call the callback directly. Not sure if arm is affected by spectre,
but the "loop" function is filled with indirect function calls, where as
the dynamic trampolines call the callback directly.

Instead of:

  bl ftrace_caller

ftrace_caller:
  [..]
  bl ftrace_ops_list_func
  [..]


void ftrace_ops_list_func(...)
{
	__do_for_each_ftrace_ops(op, ftrace_ops_list) {
		if (ftrace_ops_test(op, ip)) // test the hash to see if it
					     //	should trace this
					     //	function.
			op->func(...);
	}
}

It does:

  bl dyanmic_tramp

dynamic_tramp:
  [..]
  bl func  // call the op->func directly!


Much more efficient!


> 
> There might be a middle-ground here where we patch the ftrace_ops
> pointer into a literal pool at the patch-site, which would allow us to
> handle this atomically, and would avoid the issues with out-of-range
> trampolines.

Have an example of what you are suggesting?

-- Steve
