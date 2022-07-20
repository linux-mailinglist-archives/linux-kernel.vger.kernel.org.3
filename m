Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE1057BDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbiGTSbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiGTSbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:31:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A16FA02
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4292D6193C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 18:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B46EC341CA;
        Wed, 20 Jul 2022 18:31:48 +0000 (UTC)
Date:   Wed, 20 Jul 2022 14:31:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <20220720143147.4d8a2f8d@gandalf.local.home>
In-Reply-To: <CAHk-=wjdQbdQGKkQxxEcWoUp4SRmBWm=3bS20SbaVe8cLgKLgg@mail.gmail.com>
References: <20220716230344.239749011@linutronix.de>
        <20220720125736.48164a14@gandalf.local.home>
        <CAHk-=wh=Yjy=DmGzzGj-ivyx_w45AHh35eDkpGtajaiO+TX38A@mail.gmail.com>
        <Ytg6UD+0F6zv981o@worktop.programming.kicks-ass.net>
        <20220720135016.3178ffc6@gandalf.local.home>
        <CAHk-=wjdQbdQGKkQxxEcWoUp4SRmBWm=3bS20SbaVe8cLgKLgg@mail.gmail.com>
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

On Wed, 20 Jul 2022 11:07:26 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Jul 20, 2022 at 10:50 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > [    2.464117] missing return thunk: lkdtm_rodata_do_nothing+0x0/0x8-lkdtm_rodata_do_nothing+0x5/0x8: e9 00 00 00 00  
> 
> Well, that looks like a "jmp" instruction that has never been relocated.
> 
> The 'e9' is 'jmp', the four zeros after it are either "I'm jumping to
> the next instruction" or "I haven't been filled in".
> 
> I'm assuming it's the second case.
> 
> That lkdtm_rodata_do_nothing thing is odd, and does
> 
>     OBJCOPYFLAGS_rodata_objcopy.o   := \
>                             --rename-section
> .noinstr.text=.rodata,alloc,readonly,load,contents
> 
> to put the code in an odd section. I'm assuming this hackery is
> related to it then not getting relocated.
> 

Right, because this looks to be some magic being done for testing purposes:

static void lkdtm_EXEC_RODATA(void)
{
        execute_location(dereference_function_descriptor(lkdtm_rodata_do_nothing),
                         CODE_AS_IS);
}

static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
{
        if (!have_function_descriptors())
                return dst;

        memcpy(fdesc, do_nothing, sizeof(*fdesc));
        fdesc->addr = (unsigned long)dst;
        barrier();

        return fdesc;
}

static noinline void execute_location(void *dst, bool write)
{
        void (*func)(void);
        func_desc_t fdesc;
        void *do_nothing_text = dereference_function_descriptor(do_nothing);

        pr_info("attempting ok execution at %px\n", do_nothing_text);
        do_nothing();

        if (write == CODE_WRITE) {
                memcpy(dst, do_nothing_text, EXEC_SIZE);
                flush_icache_range((unsigned long)dst,
                                   (unsigned long)dst + EXEC_SIZE);
        }
        pr_info("attempting bad execution at %px\n", dst);
        func = setup_function_descriptor(&fdesc, dst);
        func();
        pr_err("FAIL: func returned\n");
}

And that appears that it wants to crash, as the code is located in readonly
data.

OBJCOPYFLAGS_rodata_objcopy.o   := \
                        --rename-section .noinstr.text=.rodata,alloc,readonly,load,contents

And because the alternatives fixup tries to write to it, and fails due to
it being readonly, I'm guessing we get this warning.

Thus, is there a way to keep this file from being entered into the
return_sites section?

-- Steve
