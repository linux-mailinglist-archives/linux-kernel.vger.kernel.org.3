Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C94E4D1B8E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347802AbiCHPVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347753AbiCHPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:21:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F104DF4A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:20:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AEE961587
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 15:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF91C340EC;
        Tue,  8 Mar 2022 15:20:08 +0000 (UTC)
Date:   Tue, 8 Mar 2022 10:20:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alex Sverdlin <alexander.sverdlin@nokia.com>,
        Abel Vesa <abelvesa@linux.com>, Rabin Vincent <rabin@rab.in>,
        Colin Cross <ccross@android.com>
Subject: Re: ftrace bug
Message-ID: <20220308102007.6c6618e7@gandalf.local.home>
In-Reply-To: <62c01368-b67f-66af-2e31-d62f4df75b61@broadcom.com>
References: <9a86b2c9-1009-1683-442e-61c5a7dc8cf3@broadcom.com>
        <20220307082450.641ed866@gandalf.local.home>
        <62c01368-b67f-66af-2e31-d62f4df75b61@broadcom.com>
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

[ Adding ARM folks (and those that touched the ftrace ARM port) as I don't
  know the ARM code ]

On Tue, 8 Mar 2022 11:53:35 +0100
Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> On 3/7/2022 2:24 PM, Steven Rostedt wrote:
> > On Mon, 7 Mar 2022 12:26:45 +0100
> > Arend van Spriel <arend.vanspriel@broadcom.com> wrote:
> >   
> >> Hi Steven,
> >>
> >> I wanted to use FTRACE on an ARM platform and I hit the following
> >> warning which results in ftrace bug. This happens upon loading a module.
> >> Looking up the warning I suspect the branch target is too far off. The
> >> module is quite large and therefor not loaded in the modules section. Is
> >> there a way to exclude a module. In ftrace_module_init I see a check for
> >> !mod->num_ftrace_callsites. Is there a way to avoid creating ftrace
> >> callsites in a module?  
> > 
> > Are you sure it's the size. Just want to make sure that's the reason before
> > going with different solutions.  
> 
> Interpreting the warning statement in insn.c and given the fact that the 
> module is loaded at 0xe3xxxxxx instead of kernel module space at 
> 0xbfxxxxxx I made this assumption, but ....
> 
> >>
> >> Regards,
> >> Arend
> >>
> >> ------------[ cut here ]------------
> >>
> >> WARNING: CPU: 2 PID: 1525 at arch/arm/kernel/insn.c:47
> >> __arm_gen_branch+0x70/0x78
> >>
> >> CPU: 2 PID: 1525 Comm: insmod Tainted: P                  4.19.183 #2
> >>
> >> Hardware name: Generic DT based system
> >>
> >> [<c02139e4>] (unwind_backtrace) from [<c020d4f8>] (show_stack+0x20/0x24)
> >>
> >> [<c020d4f8>] (show_stack) from [<c0922aec>] (dump_stack+0x98/0xac)
> >>
> >> [<c0922aec>] (dump_stack) from [<c0919b98>] (__warn.part.0+0xcc/0xe8)
> >>
> >> [<c0919b98>] (__warn.part.0) from [<c0919d4c>]
> >> (warn_slowpath_null+0x54/0x74)
> >> [<c0919d4c>] (warn_slowpath_null) from [<c021225c>]
> >> (__arm_gen_branch+0x70/0x78)
> >> [<c021225c>] (__arm_gen_branch) from [<c02120e4>]
> >> (ftrace_make_nop+0x64/0xec)
> >> [<c02120e4>] (ftrace_make_nop) from [<c02ac2b0>]
> >> (ftrace_process_locs+0x370/0x4b4)
> >>
> >> [<c02ac2b0>] (ftrace_process_locs) from [<c02af538>]
> >> (ftrace_module_init+0x38/0x3c)
> >>
> >> [<c02af538>] (ftrace_module_init) from [<c02a47d8>]
> >> (load_module+0x18d0/0x2570)
> >> [<c02a47d8>] (load_module) from [<c02a56f8>]
> >> (sys_finit_module+0xe0/0xf8)
> >> [<c02a56f8>] (sys_finit_module) from [<c0201000>]
> >> (ret_fast_syscall+0x0/0x58)
> >> Exception stack(0xd9b1bfa8 to 0xd9b1bff0)
> >>
> >> bfa0:                   01170228 00000000 00000003 01170228 00000000
> >> beb7ceb3
> >> bfc0: 01170228 00000000 beb7cdc4 0000017b 00127010 00000000 00000000
> >> 00000000
> >> bfe0: beb7cc38 beb7cc28 0001a0dc 00012890
> >>
> >> ---[ end trace f48808a851a4544a ]---
> >>
> >> ------------[ cut here ]------------
> >>
> >> WARNING: CPU: 2 PID: 1525 at kernel/trace/ftrace.c:2034
> >> ftrace_bug+0xfc/0x394  
> > 
> > Three should be more content after the "cut here" that is very relevant (I
> > hate that cut here, because I constantly need to tell people to show me
> > more :-p I need to add a "ftrace bug cut here" line.)
> > 
> > 
> > Could you show me the output right after that.  
> 
> ... here is the output I think you were looking for:
> 
> ftrace failed to modify 
> 
> [<a82ca82d>] (suspected corrupt symbol) 

Is the above "suspected corrupt symbol" kernel output? I don't see it in my
tree. What version of the kernel is this.

I'm guessing the above address a82ca82d is where it is trying to modify,
and is not in the symbol table. So something looks to be messed up.

> 
>   actual:   63:17:16:eb 

The above is what it found in that location.

Perhaps others have ideas.

-- Steve

> 
> Initializing ftrace call sites 
> 
> ftrace record flags: 2000000 
> 
>   (0) 
> 
>   expected tramp: c0211b88 
> 
> ftrace failed to modify 
> 
> [<6c88ec64>] (suspected corrupt symbol) 
> 
>   actual:   72:ab:08:eb 
> 
> Initializing ftrace call sites 
> 
> ftrace record flags: 2000000 
> 
>   (0) 
> 
>   expected tramp: c0211b88 
> 
> ftrace failed to modify 
> 
> [<b1ed303a>] (suspected corrupt symbol) 
> 
>   actual:   04:12:04:eb 
> 
> Initializing ftrace call sites 
> 
> ftrace record flags: 2000000 
> 
>   (0) 
> 
>   expected tramp: c0211b88 
> 
> ftrace failed to modify 
> 
> [<eb2fee66>] (suspected corrupt symbol) 
> 
>   actual:   d6:7e:00:eb 
> 
> Initializing ftrace call sites 
> 
> ftrace record flags: 2000000 
> 
>   (0) 
> 
>   expected tramp: c0211b88
> 
> Regards,
> Arend

