Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F008B4DB343
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356027AbiCPOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbiCPOaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:30:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EBC41323
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A95EBB81BE7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F33EC340E9;
        Wed, 16 Mar 2022 14:29:07 +0000 (UTC)
Date:   Wed, 16 Mar 2022 10:29:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <zengshun.wu@outlook.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH -next v2 0/4] arm64/ftrace: support dynamic
 trampoline
Message-ID: <20220316102905.3e3b5358@gandalf.local.home>
In-Reply-To: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
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

On Wed, 16 Mar 2022 18:01:28 +0800
Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:

> This implements dynamic trampoline in ARM64, as reference said, we
> complete whole design of supporting long jump in dynamic trampoline:
> 
>    .text section:
>      funcA:         |    funcA():        funcB():|
>       `->  +-----+  |    |   ...         mov x9  |
>            | ... |  |    |   adrp   <-   bl  <>  |
>            | nop |  |    |   mov
>            | nop |  |    |   br   x16 ---+
>      funcB | nop |  |                    | ftrace_(regs_)caller_tramp:
>       `->  +-----+  |                    `--> +---------------------+
>            | nop |  |                         | ...                 |
>            | nop |  |       ftrace callsite   +---------------------+
>            | ... |  |                `----->  | PLT entry:          |
>            | nop |  |                         |       adrp          |
>            | nop |  |                         |       add           |
>     funcC: | nop |  | ftrace graph callsite   |       br   x16      |
>       `->  +-----+  |                `----->  +---------------------+
>            | nop |  |                         | ...                 |
>            | nop |  |                         +---------------------+
> 
> But there is still a tricky problem that is how to adjust tracing ip,
> waiting to be solved:
> 
> For ARM64, somecases there may be extra instructions inserted into the
> head of tracable functions(but not all) by compiler, for instance BTI[1].
> 
> This dump vmlinux with CONFIG_BTI=y:
> 
> (1) function gic_handle_irq has bti in its head, so we adjust rec->ip+=5 to last nop
>     ffffffc0080100e0:       d53cd042        mrs     x2, tpidr_el2
>             ...
>     ffffffc0080100f0:       d503201f        nop     //__mcount_loc tells the rec->ip
>     ffffffc0080100f4:       d503201f        nop
>     ffffffc0080100f8:       d503201f        nop
> 
>     ffffffc0080100fc <gic_handle_irq>:
>     ffffffc0080100fc:       d503245f        bti     c
>     ffffffc008010100:       d503201f        nop
>     ffffffc008010104:       d503201f        nop     //we adjust origin rec->ip+5 to here
>     ffffffc008010108:       d503233f        paciasp
> (2) name_to_dev_t.part.0 do not has bti in its head, so we should adjust rec->ip+=4 to last nop
>     ffff8000080137d4:       d503201f        nop
>     ffff8000080137d8:       d503201f        nop
>     ffff8000080137dc:       d503201f        nop
>     
>     ffff8000080137e0 <name_to_dev_t.part.0>:
>     ffff8000080137e0:       d503201f        nop
>     ffff8000080137e4:       d503201f        nop
>     ffff8000080137e8:       d503233f        paciasp
> 
> So at this time we have no idea to identify rec->ip for each tracable function.

This looks like the same issue that Peter Zijlstra is handling for IBT on
x86, which I think can be useful for you too.

  https://lore.kernel.org/all/20220308153011.021123062@infradead.org/

Specifically this patch:

  https://lore.kernel.org/all/20220308154318.227581603@infradead.org/

Which modifies the ftrace_location() to return the rec->ip if you pass in
the ip of the function and kallsyms returns that the ip passed in has an
offset of zero.

-- Steve

> 
> we are looking forward to follow-up discussions.
> 
> References:
> [1] https://developer.arm.com/documentation/100076/0100/a64-instruction-set-reference/a64-general-instructions/bti
> [2] https://lore.kernel.org/linux-arm-kernel/20200109142736.1122-1-cj.chengjian@huawei.com/
> 
> Cheng Jian (4):
>   arm64: introduce aarch64_insn_gen_load_literal
>   arm64/ftrace: introduce ftrace dynamic trampoline entrances
>   arm64/ftrace: support dynamically allocated trampolines
>   arm64/ftrace: implement long jump for dynamic trampolines
> 
>  arch/arm64/Makefile              |   2 +-
>  arch/arm64/include/asm/ftrace.h  |  10 +-
>  arch/arm64/include/asm/insn.h    |   6 +
>  arch/arm64/include/asm/module.h  |   9 +
>  arch/arm64/kernel/entry-ftrace.S |  88 ++++++--
>  arch/arm64/kernel/ftrace.c       | 366 ++++++++++++++++++++++++++++---
>  arch/arm64/kernel/module-plts.c  |  50 +++++
>  arch/arm64/lib/insn.c            |  49 +++++
>  8 files changed, 532 insertions(+), 48 deletions(-)
> 

