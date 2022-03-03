Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2044CB580
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiCCDmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCCDmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:42:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D73411D7A4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:41:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F111B8219C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BF5C004E1;
        Thu,  3 Mar 2022 03:41:25 +0000 (UTC)
Date:   Wed, 2 Mar 2022 22:41:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/2] tracing: Add sample code for custom trace events
Message-ID: <20220302224124.433ba754@rorschach.local.home>
In-Reply-To: <CAEXW_YQ4id4-GOgYzP_U2BLx8VVKy=RRLQgmV-npHETG5SqL2g@mail.gmail.com>
References: <20220302032414.503960863@goodmis.org>
        <20220302032820.877781830@goodmis.org>
        <CAEXW_YQ4id4-GOgYzP_U2BLx8VVKy=RRLQgmV-npHETG5SqL2g@mail.gmail.com>
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

On Wed, 2 Mar 2022 22:22:30 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> > +#include <linux/trace_events.h>
> > +#include <linux/version.h>
> > +#include <linux/module.h>
> > +#include <linux/sched.h>
> > +#include <trace/events/sched.h>
> > +
> > +#define THIS_SYSTEM "custom_sched"
> > +
> > +#define SCHED_PRINT_FMT                                                        \
> > +       C("prev_prio=%d next_pid=%d next_prio=%d", REC->prev_prio, REC->next_pid, \  
> 
> Probably prev_pid should be included so we know what the previous task was?
> 
> Or are you expecting that a prior sched_switch would have that
> information? If so, then prev_prio is also not needed as the previous
> sched_switch's next_prio would have the prio. That would save even
> more space too..

No, I left it out because it's already recorded in the event:

kworker/u16:2-19213   [005] d..2. 24689.792052: sched_switch: prev_comm=kworker/u16:2 prev_pid=19213 prev_prio=120 prev_state=I ==> next_comm=swapper/5 next_pid=0 next_prio=120

The above is the normal sched_switch event. The prev pid is 19213 which
is equal to common_pid (the first 19213 in that string). As prios can
change, I would not want to drop that anyway.

> 
> > +         REC->next_prio)
> > +
> > +#define SCHED_WAKING_FMT                               \
> > +       C("pid=%d prio=%d", REC->pid, REC->prio)
> > +  
> 
> I think including the target_cpu of a wake up is also really important
> to show where the task is going to be awakened, and maybe we can drop
> prio since a subsequent sched_switch will have the priority in
> next_prio.

True, we can do that.

> 
> [..]
> > +static void __exit trace_sched_exit(void)
> > +{
> > +       trace_set_clr_event(THIS_SYSTEM, "sched_switch", 0);
> > +       trace_set_clr_event(THIS_SYSTEM, "sched_waking", 0);
> > +
> > +       trace_remove_event_call(&sched_switch_call);
> > +       trace_remove_event_call(&sched_waking_call);
> > +}
> > +
> > +module_init(trace_sched_init);
> > +module_exit(trace_sched_exit);
> > +
> > +MODULE_AUTHOR("Steven Rostedt");
> > +MODULE_DESCRIPTION("Custom scheduling events");
> > +MODULE_LICENSE("GPL");
> > +  
> 
> Remove extra lines from the end of the file?
>

Ah, yeah.

Thanks for reviewing.

-- Steve
