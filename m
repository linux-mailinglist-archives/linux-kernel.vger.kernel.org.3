Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841904FAA1A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiDISNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbiDISMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:12:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86791AE4A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 11:10:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1354ED1;
        Sat,  9 Apr 2022 11:10:40 -0700 (PDT)
Received: from wubuntu (unknown [10.57.74.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48DE63F718;
        Sat,  9 Apr 2022 11:10:38 -0700 (PDT)
Date:   Sat, 9 Apr 2022 19:10:36 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        chris.hyser@oracle.com, pkondeti@codeaurora.org,
        Valentin.Schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        Wei Wang <wvw@google.com>
Subject: Re: [PATCH 0/6] Add latency_nice priority
Message-ID: <20220409181036.v4mm3q2rotctbxb3@wubuntu>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <7a7e1e21-df3d-4623-d9cd-51f5272919d5@arm.com>
 <CAKfTPtC36OLqrQ57bnGDi93N+3Ozk5cX-+KHHTWHkwCGp=z4gA@mail.gmail.com>
 <20220401121525.flngciwjtkn3mwlv@airbuntu>
 <CAKfTPtD7YntSV+fJkdwZxX0iO52hL0SxZ9G5hZTBSyZf6hMYRQ@mail.gmail.com>
 <20220409170841.upcimeak2ch3aj35@wubuntu>
 <20220409132829.16b03d69@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220409132829.16b03d69@rorschach.local.home>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/22 13:28, Steven Rostedt wrote:
> On Sat, 9 Apr 2022 18:08:41 +0100
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> > One other corner case to consider if you're working on next version is what
> > should happen when there are multiple tasks of the same priority on the rq. RT
> > scheduler will push/pull tasks to ensure the task will get to run ASAP if
> > there's another cpu at lower priority is available. Seems a lot of complexity
> > to add to CFS, but at the same time if 2 important tasks require low latency
> > are on the same rq, one of them will suffer without introducing the ability to
> > migrate one of them where it can get to run sooner.
> 
> Instead of having the greedy algorithm of the RT push/pull logic, how
> hard would it be to have the load balancer know of these tasks, and try
> to keep them on different CPUs? When two are queued on the same CPU,

Oh yeah I didn't think we need to replicate push/pull. Load balancer will need
to know about it when it moves task so that it avoids placing two of these asks
on the same cpu.

> could it be possible to just trigger load balancing and let it do the
> work?

I think the other part will need to be at wake up when we decide the CPU.

If we trigger the load balancing instead then it'd behave like a push/pull?

All these paths are already complex though. So we need to carefully analyze the
trade-offs. Maybe we don't need to deliver such level of service after all. It
needs more thinking and experimenting.

Thanks

--
Qais Yousef
