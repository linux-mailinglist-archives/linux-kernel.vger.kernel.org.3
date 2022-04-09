Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52934FA9F0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242866AbiDIRar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiDIRan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0651E83036
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:28:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00A7C60DE3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 17:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B653CC385A4;
        Sat,  9 Apr 2022 17:28:30 +0000 (UTC)
Date:   Sat, 9 Apr 2022 13:28:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
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
Message-ID: <20220409132829.16b03d69@rorschach.local.home>
In-Reply-To: <20220409170841.upcimeak2ch3aj35@wubuntu>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
        <7a7e1e21-df3d-4623-d9cd-51f5272919d5@arm.com>
        <CAKfTPtC36OLqrQ57bnGDi93N+3Ozk5cX-+KHHTWHkwCGp=z4gA@mail.gmail.com>
        <20220401121525.flngciwjtkn3mwlv@airbuntu>
        <CAKfTPtD7YntSV+fJkdwZxX0iO52hL0SxZ9G5hZTBSyZf6hMYRQ@mail.gmail.com>
        <20220409170841.upcimeak2ch3aj35@wubuntu>
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

On Sat, 9 Apr 2022 18:08:41 +0100
Qais Yousef <qais.yousef@arm.com> wrote:

> One other corner case to consider if you're working on next version is what
> should happen when there are multiple tasks of the same priority on the rq. RT
> scheduler will push/pull tasks to ensure the task will get to run ASAP if
> there's another cpu at lower priority is available. Seems a lot of complexity
> to add to CFS, but at the same time if 2 important tasks require low latency
> are on the same rq, one of them will suffer without introducing the ability to
> migrate one of them where it can get to run sooner.

Instead of having the greedy algorithm of the RT push/pull logic, how
hard would it be to have the load balancer know of these tasks, and try
to keep them on different CPUs? When two are queued on the same CPU,
could it be possible to just trigger load balancing and let it do the
work?

-- Steve
