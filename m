Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC604BFE18
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiBVQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiBVQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:07:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35EB3F9F94
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:07:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 030571063;
        Tue, 22 Feb 2022 08:07:08 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A255C3F70D;
        Tue, 22 Feb 2022 08:07:06 -0800 (PST)
Date:   Tue, 22 Feb 2022 16:07:04 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
        songmuchun@bytedance.com, qirui.001@bytedance.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/ftrace: Make function graph use ftrace directly
Message-ID: <YhUKKOF/ZP167ueN@lakrids>
References: <20220222130049.81284-1-zhouchengming@bytedance.com>
 <20220222105218.28e3d5aa@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222105218.28e3d5aa@gandalf.local.home>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 10:52:18AM -0500, Steven Rostedt wrote:
> On Tue, 22 Feb 2022 21:00:49 +0800
> Chengming Zhou <zhouchengming@bytedance.com> wrote:
> 
> > As we do in commit 0c0593b45c9b ("x86/ftrace: Make function graph
> > use ftrace directly"), we don't need special hook for graph tracer,
> > but instead we use graph_ops:func function to install return_hooker.
> > 
> > Since commit 3b23e4991fb6 ("arm64: implement ftrace with regs") add
> > implementation for FTRACE_WITH_REGS on arm64, we can easily adopt
> > the same optimization on arm64.
> 
> Note. Ideally we want it to hook with DYNAMIC_FTARCE_WITH_ARGS, and not
> FTRACE_WITH_REGS. If arm64 is like x86_64, saving all regs at every
> function call has a bit more overhead than saving the minimum. The
> DYNAMIC_FTRACE_WITH_ARGS, means that the minimum is still saved, but now
> exposes the arguments and the stack pointer, which function_graph_tracer
> needs.

FWIW, I'd been meaning to take a look at that.

On arm64 we can't really create a full pt_regs without taking an
exception because there's a bunch of stuff in pt_regs that we can only
snapshot at an exception boundary (e.g. PSTATE, which is what Arm calls
the internal processor flags). I'd wanted to look at whether we could
implement FTRACE_WITH_ARGS without FTRACE_WITH_REGS.

For kprobes & kreprobes we snapshot the real flags at function entry
time and give made up values at function return time, which is less
than ideal because there'll be spurious differences in the flags across
the two.

It might be worth a chat at plumbers about how we could align this a bit
better (e.g. with k(ret)probes having an args-only mode too).

Thanks,
Mark.
