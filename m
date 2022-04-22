Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136F150BF25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiDVSBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiDVR7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:59:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F859F9573
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:56:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 816BA1063;
        Fri, 22 Apr 2022 10:28:00 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF4C63F73B;
        Fri, 22 Apr 2022 10:27:58 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:27:53 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <YmLlmaXF00hPkOID@lakrids>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
 <20220316100132.244849-4-bobo.shaobowang@huawei.com>
 <YmFXrBG5AmX3+4f8@lakrids>
 <20220421100639.03c0d123@gandalf.local.home>
 <YmF0xYpTMoWOIl00@lakrids>
 <20220421114201.21228eeb@gandalf.local.home>
 <YmGF/OpIhAF8YeVq@lakrids>
 <20220421130648.56b21951@gandalf.local.home>
 <YmJ/l4vJoEpFt68l@FVFF77S0Q05N>
 <20220422114541.34d71ad9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422114541.34d71ad9@gandalf.local.home>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:45:41AM -0400, Steven Rostedt wrote:
> On Fri, 22 Apr 2022 11:12:39 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > As an aside, I'd also love to remove the REGS/!REGs distinction, and always
> > save a minimum amount of state (like ARGS, but never saving a full pt_regs),
> > since on arm64 the extra state stored for the REGS case isn't useful (and we
> > can't reliably capture all of the pt_regs state anyway, so bits of it are made
> > up or not filled in).
> 
> Note, the reason for the addition of REGS was a requirement of kprobes.
> Because before ftrace, kprobes would be triggered at the start of a
> function by a breakpoint that would load in all the regs. And for backward
> compatibility, Masami wanted to make sure that kprobes coming from ftrace
> had all the regs just like it had when coming from a breakpoint.
> 
> IIUC, kprobes is the only reason we have the "regs" variant (all other use
> cases could get by with the ARGS version).

I see. FWIW, we don't have KPROBES_ON_FTRACE on arm64.

Also, the same problems apply to KRETPROBES: the synthetic `pstate`
value is bogus and we don't fill in other bits of the regs (e.g. the PMR
value), so it's not a "real" pt_regs, and things like
interrupts_enabled(regs) won't work correctly. In addition, as
KRETPROBES only hooks function entry/exit and x9-x17 + x19-x28 are
meaningless at those times, no-one's going to care what they contain
anyway. The state we can correctly snapshot (and that would be useful)
is the same as ARGS.

It'd be nice if KRETPROBES could just use ARGS, but a standard KPROBE
that traps could provide regs (since it actually gets "real" regs, and
within a function the other GPRs could be important).

Thanks,
Mark.
