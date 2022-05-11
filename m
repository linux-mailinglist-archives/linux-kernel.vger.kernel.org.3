Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7632D5235A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbiEKOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240207AbiEKOe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:34:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BAB6A02A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:34:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B0C8B82073
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D091C34113;
        Wed, 11 May 2022 14:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652279696;
        bh=t7NtYe4g+ZzXlwVJbcVCuf8BrT1ifHZjftu0dkcPeDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=To96SnoomjvJcuaMcVymixOJKBqwvB0ITJ+cp+vmiv8nwaFwLDwKSKJ/Sr+oLcrR5
         TyQh9/nvJJtSIxdnQPCdaQkXOAxZGiMSemQmOsGMGmspApEEZuYY8eAnpZHNiEOJh2
         bpiKc+VpbVcbtRQravcMqQ5F7cgSyzOiRHSxmdTqw60/TuZmyFIZBBWuWltVhIg/wk
         DWH8JzHRc0JiNYk0Ox5rmApFMwqjD6cTikfNyrQ6dFkNv1TD3RrveXHQtpdMY7apuK
         beMKIK9UmoQYfJqU/T3YtjEQTPCtKKJJ5fFRo6WpIPsD7RtQngDab7O2rctMyb20+M
         ti4O54qXJ/VNg==
Date:   Wed, 11 May 2022 23:34:50 +0900
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
Message-Id: <20220511233450.40136cdf6a53eb32cd825be8@kernel.org>
In-Reply-To: <20220510104446.6d23b596@gandalf.local.home>
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
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 10:44:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 May 2022 18:10:12 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > >
> > > This was suggested by both Peter Zijlstra and Thomas Gleixner when I
> > > introduced FTRACE_WITH_ARGS, where all functions can now get the arguments
> > > from fregs, but not the full pt_regs.  
> > 
> > Hmm, I thought the ftrace_get_regs() is the all-or-nothing interface, or
> > is there any way to get the arguments from fregs?
> 
> Not yet generically. But that can easily be added. If you look at x86 live
> patching, since it is arch specific, it just took the regs parameter
> directly, knowing that the args were already set up. That is, ftrace_regs is
> just a wrapper around pt_regs with just the regs for the arguments and stack
> initialized. If you get regs from ftrace_get_regs(fregs) it will return
> NULL if it wasn't full set of regs. But we can add generic functions to get
> the parameters.
> 
> That is, we can create a ftrace_get_kernel_argument() function that takes
> fregs instead of pt_regs, and produce the same thing as
> regs_get_kernel_argument().
> 
> x86 live kernel patching has this:
> 
> arch/x86/include/asm/ftrace.h:
> 
>  #define ftrace_instruction_pointer_set(fregs, _ip)     \
>        do { (fregs)->regs.ip = (_ip); } while (0)
> 
> 
> arch/x86/include/asm/livepatch.h:
> 
>  static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
>  {
>         ftrace_instruction_pointer_set(fregs, ip);
>  }
> 
> Where fregs is not a full set of regs.

OK, so fregs::regs will have a subset of pt_regs, and accessibility of
the registers depends on the architecture. If we can have a checker like

ftrace_regs_exist(fregs, reg_offset)

kprobe on ftrace or fprobe user (BPF) can filter user's requests.
I think I can introduce a flag for kprobes so that user can make a
kprobe handler only using a subset of registers. 
Maybe similar filter code is also needed for BPF 'user space' library
because this check must be done when compiling BPF.

Thank you,


> > 
> > > If a ftrace_ops has the REGS flag set
> > > (using ftrace_regs_caller), the ftrace_get_regs(fregs) will return the
> > > pt_regs, or it will return NULL if ftrace_regs_caller was not used.
> > > 
> > > This way the same parameter can provide full pt_regs or a subset, and have
> > > an generic interface to tell the difference.  
> > 
> > If it can provide a partial (subset of) pt_regs, that could be good for me
> > too, since at least kprobe-events on ftrace can check the traced register
> > is in the subset or not and reject it if it doesn't saved.
> 
> That's exactly the use case for ftrace_regs.
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
