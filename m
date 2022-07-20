Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CF857B6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiGTMuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240604AbiGTMum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:50:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792672A70B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P7OGlEo0f4NPfbw6CNnrOlcfGnGBeVJ5/cXY1HeGBK4=; b=W6fRInLWvmypStI1rDrhN/4aaX
        qO7u5h9DX5l7jO9sIL9pQoTfpottHTtkudzpIKt76TZA58R/3PDePSgHcleCSdFu9WIS10Vdk5Q6m
        0hjJBUipyrsqpHcEuYpkiNotSknGbfofDkuzGHrV1T9x1TAUCGbhUUQRyG+hORJ5raONC0fkKxE2g
        MFoMZFoQ0zfgCSnj95jFcsUNX4sCHFrQygvPErC34xURjSjCrzOIRmtqUEM9ks+8rHdyBqn9XmG4O
        WBJ3xe8xU+W8Tf+FWYEvLf3tg1CtUMYK1+LRsrrbQwzlGkMHK2J6mjk0FTbzZxqemtEPHuRDYoQJM
        O/V6ljXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oE99d-005K9M-8U; Wed, 20 Jul 2022 12:50:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A9DA980BBE; Wed, 20 Jul 2022 14:50:15 +0200 (CEST)
Date:   Wed, 20 Jul 2022 14:50:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        bristot@redhat.com, vschneid@redhat.com, cmetcalf@ezchip.com,
        mgorman@suse.de, bsegall@google.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com
Subject: Re: [PATCH] nohz/full, sched/rt: Fix missed tick-reenabling bug in
 dequeue_task_rt
Message-ID: <Ytf6B19HjYGPvJZ/@worktop.programming.kicks-ass.net>
References: <20220628092259.330171-1-nsaenzju@redhat.com>
 <a508ce3c711ebac73695af98a5d17187e22e74cb.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a508ce3c711ebac73695af98a5d17187e22e74cb.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 07:18:42PM +0200, Nicolas Saenz Julienne wrote:
> On Tue, 2022-06-28 at 11:22 +0200, Nicolas Saenz Julienne wrote:
> > dequeue_task_rt() only decrements 'rt_rq->rt_nr_running' after having
> > called sched_update_tick_dependency() preventing it from re-enabling the
> > tick on systems that no longer have pending SCHED_RT tasks but have
> > multiple runnable SCHED_OTHER tasks:
> > 
> >   dequeue_task_rt()
> >     dequeue_rt_entity()
> >       dequeue_rt_stack()
> >         dequeue_top_rt_rq()
> > 	  sub_nr_running()	// decrements rq->nr_running
> > 	    sched_update_tick_dependency()
> > 	      sched_can_stop_tick()	// checks rq->rt.rt_nr_running,
> > 	      ...
> >         __dequeue_rt_entity()
> >           dec_rt_tasks()	// decrements rq->rt.rt_nr_running
> > 	  ...
> > 
> > Every other scheduler class performs the operation in the opposite
> > order, and sched_update_tick_dependency() expects the values to be
> > updated as such. So avoid the misbehaviour by inverting the order in
> > which the above operations are performed in the RT scheduler.
> > 
> > Fixes: 76d92ac305f2 ("sched: Migrate sched to use new tick dependency mask model")
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> > ---
> 
> Ping :)

Thanks! got stuck in the retbleed backlog :/
