Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA07050A011
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386239AbiDUM4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385925AbiDUM4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:56:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A6C732ED2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:53:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B92B1480;
        Thu, 21 Apr 2022 05:53:51 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3143F3F73B;
        Thu, 21 Apr 2022 05:53:50 -0700 (PDT)
Date:   Thu, 21 Apr 2022 13:53:44 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 0/4] arm64/ftrace: support dynamic trampoline
Message-ID: <YmFT2DtlcQd7k4Tt@lakrids>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:01:28PM +0800, Wang ShaoBo wrote:
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

When I had looked into this in the past, I had assumed we could figure
this out at ftrace_init_nop() time, and adjust rec->ip there.

However, placing code *before* the function entry point will also break
stacktracing and will require adjustment, and I'd been intending to
clean up the stacktrace code first, so I haven't looked at that in a
while.

I'll take a look at the rest of the series shortly.

Thanks,
Mark.

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
> -- 
> 2.25.1
> 
