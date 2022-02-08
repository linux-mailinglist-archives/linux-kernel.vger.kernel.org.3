Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438EB4ADB9A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378458AbiBHOxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378494AbiBHOxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:53:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AA0C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:53:34 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F23471F383;
        Tue,  8 Feb 2022 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644332012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f95ih45EakqRJXPuXZ/5b7Y6d7i7+Xvu9lsVQNL7GRc=;
        b=dD9bxTc2WbBWSiup81Yel61b1DfvzSfc51mbu3Sv2rHir+wSFsBZdhGZAovmpcMsKZy02w
        ov6+1CV3zEohLdaffHNYAxTYjhRH51YpET2slu/BOkRbnWhXxolAZf8ZePlMb0SkxdprUi
        j2mYZ/blMlw0IF1gGJYLxL3DU4G/27w=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6DAB0A3B90;
        Tue,  8 Feb 2022 14:53:32 +0000 (UTC)
Date:   Tue, 8 Feb 2022 15:53:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH printk v1 10/13] printk: add kthread console printers
Message-ID: <YgKD6X9eiADTnvIi@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220208083620.2736-1-hdanton@sina.com>
 <87v8xpmx9n.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8xpmx9n.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-08 12:14:04, John Ogness wrote:
> On 2022-02-08, Hillf Danton <hdanton@sina.com> wrote:
> > On Mon,  7 Feb 2022 20:49:20 +0106 John Ogness wrote:
> >> Create a kthread for each console to perform console printing. During
> >> normal operation (@system_state == SYSTEM_RUNNING), the kthread
> >> printers are responsible for all printing on their respective
> >> consoles.
> >
> > The code becomes simpler if the kthread is replaced with a workqueue
> > work, given the system workers.
> 
> We do not want multiple console printers blocking each other. We also
> would not want the consoles blocking non-printk work items for extended
> periods of time. So we would likely need a dedicated worker per
> console. I'm not convinced the code would look simpler just by changing
> the deferred work API. But perhaps the kernel community wants to get
> away from manual kthread management in general. (??)
>
> I am now pondering if there is some technical advantages to
> workqueues. I suppose with dedicated workers, you could still easily
> adjust CPU affinities and scheduling policies/priorites from userspace,
> like with kthreads. But is there some advantage over kthreads?

It is true that custom kthread implementation is a bit tricky.
Especially it is easy to create races. Also they are often
not optimal from the resources POV.

But I do not see any big advantage in this case. It would likely
bring more problems than it would solve.

Note that many people rely on debugging kernel via printk() and
consoles. Non-working consoles switch the system into a black box.

My concern is:

  + Workqueues code is very tricky and a lot of operations require
    pool->lock. There is even a hook from the scheduler. It would be
    yet another hard-to-debug layer when messages do not reach
    console. Another source of problems when handling consoles during
    panic. Another source of recursive messages.

  + As John already suggested. We would require rescue kthreads.
    It means that it won't safe any resources. Also rescuers are woken
    via the last idle worker and timer, using another tricky code.

  + There might be real problems to see messages on overloaded
    system. Workqueues have very limited support how to deal with
    it. There are basically only few possibilities: per-CPU workers
    vs. workers limited by a CPU-mask. Normal vs. hi-priority
    workers (nothing in between). The priority could not be
    modified at runtime.


A more realistic approach would be using the kthread_worker API.
It was designed for users that need dedicated kthreads, custom
scheduling policy and priority. It provides a generic loop. The work
items are queued the same way as in the workqueues API.

My mine concern is that the kthread_worker API still uses an internal
lock. And it is yet another layer that might be hard to debug when
printk() does not work.

I would prefer using a custom kthread for now. The main reason
is that it is waken using wake_up_process(). We will have
to deal with very similar problems as with console_lock
(semaphore locking) that uses wake_up_process() as well.

Best Regards,
Petr
