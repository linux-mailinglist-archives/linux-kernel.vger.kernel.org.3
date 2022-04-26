Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD0A50F79A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347611AbiDZJgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345977AbiDZJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A8149285
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A278F60C43
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349B1C385A4;
        Tue, 26 Apr 2022 08:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650962875;
        bh=KGgpr/qE7e8i8/TT4uGx7oI4jKojK9A+0qh5p9W935o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XPm+F8ILe2J5PO9S7QNt8NoVYK46NXEXjJXFkTMjtiMqb48KhwwqQ1aC/A5cxsNOm
         2oXPAWVHvM+dO335YOYApv0pB7ebxVtqIYIwVrUkjeSw5+kVS9oaJe1izMMt6aRwhm
         vHHJK4TvopkQXA06q+W29TSiB0KQjd7akaGA8w+iM4AHnqgrgvXUND4K5gTSOFL51D
         Wzcyng+vvFfCo8QKBzlzvP41NDLiZAXKUut/0TX+CAMVcLo+rtlhJCWabZA1ws/aSO
         xgl84i4K+H2w5kxKo8W/Og1YvVHGSpIe/1c692FSE4h/yB0H5g0omcxZYWPGKd95ad
         2tKtL3y7m3uPw==
Date:   Tue, 26 Apr 2022 17:47:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-Id: <20220426174749.b5372c5769af7bf901649a05@kernel.org>
In-Reply-To: <YmLlmaXF00hPkOID@lakrids>
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
        <YmLlmaXF00hPkOID@lakrids>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, 22 Apr 2022 18:27:53 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Fri, Apr 22, 2022 at 11:45:41AM -0400, Steven Rostedt wrote:
> > On Fri, 22 Apr 2022 11:12:39 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > As an aside, I'd also love to remove the REGS/!REGs distinction, and always
> > > save a minimum amount of state (like ARGS, but never saving a full pt_regs),
> > > since on arm64 the extra state stored for the REGS case isn't useful (and we
> > > can't reliably capture all of the pt_regs state anyway, so bits of it are made
> > > up or not filled in).
> > 
> > Note, the reason for the addition of REGS was a requirement of kprobes.
> > Because before ftrace, kprobes would be triggered at the start of a
> > function by a breakpoint that would load in all the regs. And for backward
> > compatibility, Masami wanted to make sure that kprobes coming from ftrace
> > had all the regs just like it had when coming from a breakpoint.

Yes. Since this kprobes->ftrace conversion is done by kprobes transparently,
user doesn't know their kprobe handler is called from sw break or ftrace.

> > 
> > IIUC, kprobes is the only reason we have the "regs" variant (all other use
> > cases could get by with the ARGS version).
> 
> I see. FWIW, we don't have KPROBES_ON_FTRACE on arm64.

Right. Since x86 fentry puts the entry on function address, I need such
compatibility.

But on arm64, ftrace leads some preparation instructions, kprobes can put
the sw break on the function address there. And may not need to put the
kprobes on it. So it depends on arch. I would like to keep the kprobes 
available at the function address so that it can trace any registers.
(like debugger usage)

> Also, the same problems apply to KRETPROBES: the synthetic `pstate`
> value is bogus and we don't fill in other bits of the regs (e.g. the PMR
> value), so it's not a "real" pt_regs, and things like
> interrupts_enabled(regs) won't work correctly.

Would you mean the process which kprobes_save/restore_local_irqflag() does?
Is the regs->pstate saved correctly in sw break or ftrace? (sorry, I missed
the context)

> In addition, as
> KRETPROBES only hooks function entry/exit and x9-x17 + x19-x28 are
> meaningless at those times, no-one's going to care what they contain
> anyway.

It depends on what bug they are trying to trace. C source level bug
will not need such information, but assembly level bug (or compiler
level bug) may need such registers. Anyway, this also depends on user.
I just won't like limit the usage.

> The state we can correctly snapshot (and that would be useful)
> is the same as ARGS.
> 
> It'd be nice if KRETPROBES could just use ARGS, but a standard KPROBE
> that traps could provide regs (since it actually gets "real" regs, and
> within a function the other GPRs could be important).

Here, the KRETPROBES means the exit handler, or including entry handler?
Since kretprobes uses a standard kprobe to trap the function entry.

If you talk about fprobes (ftrace probe interface), it will only use the
ftrace. Thus your idea is acceptable for it (because fprobe is different
from kprobes *).

* Of course we have to talk with BPF people so that they will only access
ARGS from BPF program on fprobes.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
