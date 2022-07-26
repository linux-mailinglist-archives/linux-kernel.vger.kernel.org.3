Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77704581056
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiGZJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiGZJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:50:37 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4DC1ADA6;
        Tue, 26 Jul 2022 02:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=plrt28d2jmNTXoMbxu+vZ/2uLGRkrgD3ZIbANkDKEvw=; b=j7V/dY/QBbYtUTiMt9KviWnJ6U
        71oODiVdS9SpAKvMWFSNQiJRIs7fIDW1QwjbyGd9gL40JoYFIm8DjYoOKrtjwTSJ82X42oh9GmPbm
        XVR7tMPrLSflxNBaCPMNYGZ1dd1A6VajuSij4MDVDQlprSoDSBYlNeyiZ+9Gj0h0kbZKqA0CNFqIV
        n2HNltEjO/+rravhaSCr6vIAiPb0CfZc7R34sbQMC8zZx4FetCOJs3+Tlocir5KKtOmMDZ+FX5Yq8
        uPsG+Z++gj/Fv4TTyAXCAJ+AhRRI58ZJyhLuUK6Dk5qbcOfwl/gplYRfIsWsy6/ttd3DEYjIxrQlN
        zPI2LMMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33566)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oGHCA-0003wb-DY; Tue, 26 Jul 2022 10:49:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oGHBx-00017g-HI; Tue, 26 Jul 2022 10:49:29 +0100
Date:   Tue, 26 Jul 2022 10:49:29 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, ardb@kernel.org,
        will@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, arnd@arndb.de, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        ast@kernel.org, linyujun809@huawei.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/5] ARM: stacktrace: Allow stack trace saving for
 non-current tasks
Message-ID: <Yt+4qSeIM0WbjcJj@shell.armlinux.org.uk>
References: <20220712021527.109921-1-lihuafei1@huawei.com>
 <20220712021527.109921-4-lihuafei1@huawei.com>
 <CACRpkdYvOjfmf=Z3pGfD-UPxfTc9PXtOyw2x+ptYiSy=gmGnpQ@mail.gmail.com>
 <1288c73b-cf29-707d-47cb-4e2737300a29@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288c73b-cf29-707d-47cb-4e2737300a29@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 05:12:39PM +0800, Li Huafei wrote:
> 
> 
> On 2022/7/18 17:07, Linus Walleij wrote:
> > On Tue, Jul 12, 2022 at 4:18 AM Li Huafei <lihuafei1@huawei.com> wrote:
> > 
> >> The current ARM implementation of save_stack_trace_tsk() does not allow
> >> saving stack trace for non-current tasks, which may limit the scenarios
> >> in which stack_trace_save_tsk() can be used. Like other architectures,
> >> or like ARM's unwind_backtrace(), we can leave it up to the caller to
> >> ensure that the task that needs to be unwound is not running.
> >>
> >> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> > 
> > That sounds good, but:
> > 
> >>         if (tsk != current) {
> >> -#ifdef CONFIG_SMP
> >> -               /*
> >> -                * What guarantees do we have here that 'tsk' is not
> >> -                * running on another CPU?  For now, ignore it as we
> >> -                * can't guarantee we won't explode.
> >> -                */
> >> -               return;
> >> -#else
> >> +               /* task blocked in __switch_to */
> > 
> > The commit text is not consistent with the comment you are removing.
> > 
> > The commit is talking about "non-current" tasks which is one thing,
> > but the code is avoiding any tasks under SMP because they may be
> > running on another CPU. So you need to update the commit
> > message to say something like "non-current or running on another CPU".
> > 
> > If this condition will be checked at call sites in following patches,
> > then mention
> > that in the commit as well, so we know the end result is that we do
> > not break it,
> 
> The generic code stack_trace_save_tsk() does not have this check, and by
> 'caller' I mean the caller of stack_trace_save_tsk(), expecting the
> 'caller' to ensure that the task is not running. So in effect this check
> has been dropped and there is no more guarantee. Sorry for not
> clarifying the change here.

Can you prove in every case that the thread we're being asked to unwind
is not running? I don't think you can.

There are things like proc_pid_stack() in procfs and the stack traces
in sysrq-t which have attempted to unwind everything whether it's
running or not.

So no, there is no guarantee that the thread is blocked in
__switch_to().

> But can we assume that the user should know that the stacktrace is
> unreliable for a task that is running on another CPU? If not, I should
> remove this patch and keep the check.

It's not about "unreliable" stack traces, it's about the unwinder
killing the kernel.

The hint is this:

                frame.fp = thread_saved_fp(tsk);
                frame.sp = thread_saved_sp(tsk);
                frame.lr = 0;           /* recovered from the stack */
                frame.pc = thread_saved_pc(tsk);

These access the context saved by the scheduler when the task is
sleeping. When the thread is running, these saved values will be
the state when the thread last slept. However, with the thread
running, the stack could now contain any data what so ever, and
could change at any moment.

Whether the unwind-table unwinder is truely safe in such a
situation is unknown - we try to ensure that it won't do anything
stupid, but proving that is a hard task, and we've recently had
issues with the unwinder even without that.

So, allowing this feels like we're opening the door to DoS attacks
from userspace, where userspace sits there reading /proc/*/stack of
some thread running on a different CPU waiting for the kernel to
oops itself, possibly holding a lock, resulting in the system
dying.

These decisions need to be made by architecture code not generic
code, particularly where the method of unwinding is architecture
specific and thus may have criteria defining when its safe to do so.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
