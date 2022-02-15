Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074B14B704B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbiBOQXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:23:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiBOQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:23:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FAA2716F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:23:02 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B71211F382;
        Tue, 15 Feb 2022 16:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644942180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PP5qeE9JFnGovyDTqncdGm6WXwOmirhuIc8jMfQtNZ4=;
        b=tUNlp0yj1cXY+Wr0Ac3xSm82fXbXZwgl1/+yovXMh7YQkRJK1q3aJdhsn8if4mvQrBRH4q
        eR+/jzLtOi6wofrikiGAcryuuPnYGAzdMQNoF0A7axPQyVs88qfox5aYzmAftemLeJb4Do
        xjVqaTD+WURicSE4GAVE1P0Ku5C5QX4=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9692BA3D6C;
        Tue, 15 Feb 2022 16:23:00 +0000 (UTC)
Date:   Tue, 15 Feb 2022 17:23:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, yaohongbo@linux.alibaba.com,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH] printk: fix softlockup/rcu stall warning without setting
 CONFIG_PREEMPTION
Message-ID: <YgvTZHwKkGcUgWrL@alley>
References: <1644672462-20793-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <YgnHTTn6OFZzcD8C@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgnHTTn6OFZzcD8C@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-14 12:06:53, Sergey Senozhatsky wrote:
> On (22/02/12 21:27), Guanghui Feng wrote:
> >     console_unlock+0x220/0x420
> >     vprintk_emit+0x17c/0x1ac
> >     vprintk_default+0x3c/0x44
> >     vprintk+0x38/0x70
> >     printk+0x64/0x88
> >     dump_task.part.0+0xc4/0xe0
> >     dump_task+0x70/0x74
> >     dump_tasks+0x78/0x90
> >     dump_global_header+0xcc/0xe8
> >     oom_kill_process+0x258/0x274
> >     out_of_memory.part.0+0xb0/0x33c
> >     out_of_memory+0x4c/0xa0
> >     __alloc_pages_may_oom+0x11c/0x1a0
> >     __alloc_pages_slowpath.constprop.0+0x4c0/0x75c
> >     __alloc_pages_nodemask+0x2b4/0x310
> >     alloc_pages_current+0x8c/0x140
> >     get_zeroed_page+0x20/0x50
> >     __pud_alloc+0x40/0x190
> >     copy_pud_range+0x264/0x280
> >     copy_page_range+0xe8/0x204
> >     dup_mmap+0x334/0x434
> >     dup_mm+0x64/0x11c
> >     copy_process+0x5e0/0x11a0
> >     kernel_clone+0x94/0x364
> >     __do_sys_clone+0x54/0x80
> >     __arm64_sys_clone+0x24/0x30
> >     el0_svc_common.constprop.0+0x7c/0x210
> >     do_el0_svc+0x74/0x90
> >     el0_svc+0x24/0x60
> >     el0_sync_handler+0xa8/0xb0
> >     el0_sync+0x140/0x180
> 
> [..]
> 
> > @@ -2716,7 +2716,11 @@ void console_unlock(void)
> >  		if (handover)
> >  			return;
> >
> > +#ifndef CONFIG_PREEMPTION
> > +		if (do_cond_resched || need_resched())
> > +#else
> >  		if (do_cond_resched)
> > +#endif
> >  			cond_resched();
> 
> console_unlock() can be called from atomic context, it should not schedule
> when it cannot do so. That's what console_may_schedule indicates.

Yup. It is even confirmed by the kernel test robot.

Alternative workaround is to disable rcu stall reports in
console_unlock, see the discussion at
https://lore.kernel.org/r/20211111195904.618253-2-wander@redhat.com

I personally do not like these approaches because it hides a problem.
The stall is real. The right solution is to remove the stall by
offloading the console handling into preemptive context (kthreads).
The last version of this approach is discussed at
https://lore.kernel.org/r/20220207194323.273637-1-john.ogness@linutronix.de
I prefer to go this way because it solves the root of the problem.

Best Regards,
Petr
