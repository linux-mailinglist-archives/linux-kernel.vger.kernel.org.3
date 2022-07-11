Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED66570B25
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiGKUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKUKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:10:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08AADE80
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DB72615B7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF73EC34115;
        Mon, 11 Jul 2022 20:10:39 +0000 (UTC)
Date:   Mon, 11 Jul 2022 16:10:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sched/rt: fix bad task migration for rt tasks
Message-ID: <20220711161037.06b8c1ea@gandalf.local.home>
In-Reply-To: <m2v8s7mg78.fsf@gmail.com>
References: <20220708211755.73637-1-schspa@gmail.com>
        <20220708172614.14191089@gandalf.local.home>
        <m2v8s7mg78.fsf@gmail.com>
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

On Sat, 09 Jul 2022 05:32:25 +0800
Schspa Shi <schspa@gmail.com> wrote:

> >> +++ b/kernel/sched/rt.c
> >> @@ -1998,11 +1998,14 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
> >>  			 * the mean time, task could have
> >>  			 * migrated already or had its affinity changed.
> >>  			 * Also make sure that it wasn't scheduled on its rq.
> >> +			 * It is possible the task has running for a while,  
> >
> > I don't understand the "running for a while" part. That doesn't make sense.
> >  
> 
> When I say "run for a while" I mean as long as the task has
> run capability, we should check the migrate disabled flag again.
> 
> > The only way this can happen is that it was scheduled, set
> > "migrate_disabled" and then got preempted where it's no longer on the run
> > queue.  
> 
> Yes, it is the only case.

Can we then change the comment, as the "running for a while" is not clear
to what the issue is, and honestly, sounds misleading.

-- Steve
