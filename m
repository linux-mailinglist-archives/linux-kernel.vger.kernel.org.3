Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08ED524C50
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353511AbiELMCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353504AbiELMCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:02:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA822A898
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C00761F08
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8604C385B8;
        Thu, 12 May 2022 12:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652356956;
        bh=GddqpRN5crcgCx8YyYPEmUnEbQms5XbDgQpHleOXt5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A+3EACV/vZh+KTHIPAul+vmmzBm0FXizErZwBy2TdJ1Oo+tb0HvILt8g/Bplz/t0s
         HL5J0EXAC97h07CHoUz2lITPDdH8uKNYN+4Z6cJldpva19dBWNhqdtLrAgKNdKrtiw
         bKsxxNRUdR7YOF5AdxxxjfR5GQg9UM82s6w2Zx6p7J1iwh4KpZAv6HhRB9XoC2mGRf
         dwLK09QuNhuXaAG1JgsWkZZmsl/2snI6eTr69D4RxEt1EOv1hKWY9/knM0shAapyjK
         NQCL+a6F7QA816IVXm3hr4JsTbfqjZ3uF4/xiQcYDVrfCj8bt9hTGtQGjhL8l574je
         Na6lcWWmBbK+A==
Date:   Thu, 12 May 2022 21:02:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-Id: <20220512210231.f9178a98f20a37981b1e89e3@kernel.org>
In-Reply-To: <20220511111207.25d1a693@gandalf.local.home>
References: <YmFXrBG5AmX3+4f8@lakrids>
        <20220421100639.03c0d123@gandalf.local.home>
        <YmF0xYpTMoWOIl00@lakrids>
        <20220421114201.21228eeb@gandalf.local.home>
        <YmGF/OpIhAF8YeVq@lakrids>
        <20220421130648.56b21951@gandalf.local.home>
        <YmJ/l4vJoEpFt68l@FVFF77S0Q05N>
        <20220422114541.34d71ad9@gandalf.local.home>
        <YmLlmaXF00hPkOID@lakrids>
        <20220426174749.b5372c5769af7bf901649a05@kernel.org>
        <YnJUTuOIX9YoJq23@FVFF77S0Q05N>
        <20220505121538.04773ac98e2a8ba17f675d39@kernel.org>
        <20220509142203.6c4f2913@gandalf.local.home>
        <20220510181012.d5cba23a2547f14d14f016b9@kernel.org>
        <20220510104446.6d23b596@gandalf.local.home>
        <20220511233450.40136cdf6a53eb32cd825be8@kernel.org>
        <20220511111207.25d1a693@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 11:12:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 11 May 2022 23:34:50 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > OK, so fregs::regs will have a subset of pt_regs, and accessibility of
> > the registers depends on the architecture. If we can have a checker like
> > 
> > ftrace_regs_exist(fregs, reg_offset)
> 
> Or something. I'd have to see the use case.
> 
> > 
> > kprobe on ftrace or fprobe user (BPF) can filter user's requests.
> > I think I can introduce a flag for kprobes so that user can make a
> > kprobe handler only using a subset of registers. 
> > Maybe similar filter code is also needed for BPF 'user space' library
> > because this check must be done when compiling BPF.
> 
> Is there any other case without full regs that the user would want anything
> other than the args, stack pointer and instruction pointer?

For the kprobes APIs/events, yes, it needs to access to the registers
which is used for local variables when probing inside the function body.
However at the function entry, I think almost no use case. (BTW, pstate
is a bit special, that may show the actual processor-level status
(context), so for the debugging, user might want to read it.)

Thus the BPF use case via fprobes, I think there is no usecase.
My concern is that the BPF may allow user program to access any
field of pt_regs. Thus if the user miss-programmed, they may see
a wrong value (I guess the fregs is not zero-filled) for unsaved
registers.

> That is, have a flag that says "only_args" or something, that says they
> will only get the registers for arguments, a stack pointer, and the
> instruction pointer (note, the fregs may not have the instruction pointer
> as that is passed to the the caller via the "ip" parameter. If the fregs
> needs that, we can add a "ftrace_regs_set_ip()" before calling the
> callback registered to the fprobe).

Yes, that is what I'm thinking. If "only_args" flag is set, BPF runtime
must check the user program. And if it finds the program access the
unsaved registers, it should stop executing.

BTW, "what register is saved" can be determined statically, thus I think
we just need the offset for checking (for fprobe usecase, since it will
set the ftrace_ops flag by itself.)


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
