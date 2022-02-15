Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D5B4B6F14
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiBOOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:39:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiBOOjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:39:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E9E10240E;
        Tue, 15 Feb 2022 06:38:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2E92B81A64;
        Tue, 15 Feb 2022 14:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DDAC340EB;
        Tue, 15 Feb 2022 14:38:50 +0000 (UTC)
Date:   Tue, 15 Feb 2022 09:38:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 09/13] powerpc/ftrace: Implement
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-ID: <20220215093849.556d5444@gandalf.local.home>
In-Reply-To: <1644930705.g64na2kgvd.naveen@linux.ibm.com>
References: <cover.1640017960.git.christophe.leroy@csgroup.eu>
        <5831f711a778fcd6eb51eb5898f1faae4378b35b.1640017960.git.christophe.leroy@csgroup.eu>
        <1644852011.qg7ud9elo2.naveen@linux.ibm.com>
        <1b28f52a-f8b7-6b5c-e726-feac4123517d@csgroup.eu>
        <875ypgo0f3.fsf@mpe.ellerman.id.au>
        <1644930705.g64na2kgvd.naveen@linux.ibm.com>
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

On Tue, 15 Feb 2022 19:06:48 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> As I understand it, the reason ftrace_get_regs() was introduced was to 
> be able to only return the pt_regs, if _all_ registers were saved into 
> it, which we don't do when coming in through ftrace_caller(). See the 
> x86 implementation (commit 02a474ca266a47 ("ftrace/x86: Allow for 
> arguments to be passed in to ftrace_regs by default"), which returns 
> pt_regs conditionally.

I can give you the history of ftrace_caller and ftrace_regs_caller.

ftrace_caller saved just enough as was denoted for gcc mcount trampolines.
The new fentry which happens at the start of the function, whereas mcount
happens after the stack frame is set up, may change the rules on some
architectures.

As for ftrace_regs_caller, that was created for kprobes. As the majority of
kprobes were added at the start of the function, it made sense to hook into
ftrace as the ftrace trampoline call is much faster than taking a
breakpoint interrupt. But to keep compatibility with breakpoint
interrupts, we needed to fill in all the registers, and make it act just
like a breakpoint interrupt.

I've been wanting to record function parameters, and because the ftrace
trampoline must at a minimum save the function parameters before calling
the ftrace callbacks, all the information for those parameters were being
saved but were never exposed to the ftrace callbacks. I created the the
DYNAMIC_FTRACE_WITH_ARGS to expose them. I first just used pt_regs with
just the parameters filled in, but that was criticized as it could be
confusing where the non filled in pt_regs might be used and thinking they
are legitimate. So I created ftrace_regs that would give you just the
function arguments (if DYNAMIC_FTRACE_WITH_ARGS is defined), or it will
give you a full pt_regs, if the caller came from the ftrace_regs_caller. If
not, it will give you a NULL pointer.

The first user to use the args was live kernel patching, as they only need
that and the return pointer.

-- Steve
