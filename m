Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F2256AA14
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiGGRxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiGGRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD48213D2E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 10:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5662F620B7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 17:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93487C3411E;
        Thu,  7 Jul 2022 17:53:30 +0000 (UTC)
Date:   Thu, 7 Jul 2022 13:53:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: fix bad task migration for rt tasks
Message-ID: <20220707135329.08cf74b0@gandalf.local.home>
In-Reply-To: <20220707165014.77127-1-schspa@gmail.com>
References: <20220707165014.77127-1-schspa@gmail.com>
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

On Fri,  8 Jul 2022 00:50:14 +0800
Schspa Shi <schspa@gmail.com> wrote:

> Please refer to the following scenarios.

I'm not sure this is what is happening. Do you have a trace to back this up?

> 
>            CPU0                                  CPU1
> ------------------------------------------------------------------
> push_rt_task
>   check is_migration_disabled(next_task)
>                                         task not running and
>                                         migration_disabled == 0
>   find_lock_lowest_rq(next_task, rq);
>     _double_lock_balance(this_rq, busiest);
>       raw_spin_rq_unlock(this_rq);
>       double_rq_lock(this_rq, busiest);
>         <<wait for busiest rq>>
>                                             <wakeup>

Here's the problem I have. next_task is queued on CPU0, (otherwise CPU0
would not be pushing it). As CPU0 is currently running push_rt_task, how
did next_task start running to set its migrate_disable flag?

Even if it was woken up on another CPU and ran there, by setting
migrate_disable, it would not be put back to CPU0, because its
migrate_disable flag is set (if it is, then there's the bug).

After releasing the rq lock and retaking it, we check that the next_task is
still the next task on CPU0 to push.


>                                         task become running
>                                         migrate_disable();
>                                           <context out>
>   deactivate_task(rq, next_task, 0);
>   set_task_cpu(next_task, lowest_rq->cpu);
>     WARN_ON_ONCE(is_migration_disabled(p));
>       ---------OOPS-------------

I don't see how this can happen.

-- Steve
