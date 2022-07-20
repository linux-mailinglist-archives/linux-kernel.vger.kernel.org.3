Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E8A57BE49
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiGTTLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiGTTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:11:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B089457265
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59866B821D0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 19:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E7EC341CB;
        Wed, 20 Jul 2022 19:11:24 +0000 (UTC)
Date:   Wed, 20 Jul 2022 15:11:23 -0400
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
Message-ID: <20220720151123.0e5bf61e@gandalf.local.home>
In-Reply-To: <CAHk-=wjinvfNvp9kQBgiaON1HJtmnfmytruRGR5WmkM4m+ZRVg@mail.gmail.com>
References: <20220716230344.239749011@linutronix.de>
        <20220720125736.48164a14@gandalf.local.home>
        <CAHk-=wh=Yjy=DmGzzGj-ivyx_w45AHh35eDkpGtajaiO+TX38A@mail.gmail.com>
        <Ytg6UD+0F6zv981o@worktop.programming.kicks-ass.net>
        <20220720135016.3178ffc6@gandalf.local.home>
        <CAHk-=wjdQbdQGKkQxxEcWoUp4SRmBWm=3bS20SbaVe8cLgKLgg@mail.gmail.com>
        <20220720143147.4d8a2f8d@gandalf.local.home>
        <CAHk-=wjinvfNvp9kQBgiaON1HJtmnfmytruRGR5WmkM4m+ZRVg@mail.gmail.com>
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

On Wed, 20 Jul 2022 11:43:37 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So unless somebody has some one-liner workaround, I really suspect the
> fix is to remove all this. The amount of hackery to make it work in
> the first place is kind of disgusting anyway.
> 
> Since this was a WARN_ONCE(), can you make sure that with this case
> removed, nothing else triggers?

Actually, this fixes it too:

(and this config boots to completion without warnings).

I'll add this to my full test suite and see if it finishes.

-- Steve

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1f40dad30d50..2dd61d8594f4 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -25,6 +25,7 @@ endif
 ifdef CONFIG_RETHUNK
 RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
 RETPOLINE_CFLAGS	+= $(RETHUNK_CFLAGS)
+export RETHUNK_CFLAGS
 endif
 
 export RETPOLINE_CFLAGS
diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 2e0aa74ac185..fd96ac1617f7 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -16,7 +16,7 @@ lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
 KASAN_SANITIZE_rodata.o		:= n
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
-CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
+CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO) $(RETHUNK_CFLAGS)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
