Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185614D6B7E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 01:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiCLAlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 19:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiCLAlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 19:41:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21423241B78
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 16:40:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C903CB80F91
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DBAC340E9;
        Sat, 12 Mar 2022 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647045644;
        bh=rIspAVW+lHYp0djF3IVWFDQH2VFxaJS8HGNJbIZ1Fio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vsPXBm2ovwqjqLfwFerKwP6kBpAmPnBMVIV0Qo7ctA18MMiUJ68+VmQlRYvi6zQ9A
         z247vGDqulqI+mLL6lqu1DdC82uJSKMf6R1jWOZNoRqaXJejbaNsYatr5MCA+nh3f0
         BQCFBQSRLFFmB9j7CHIg1qd2/b6JpPJz6fuCrzv8=
Date:   Fri, 11 Mar 2022 16:40:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v5] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Message-Id: <20220311164043.e5e4f3bcac2b472792085f47@linux-foundation.org>
In-Reply-To: <YisJ5SLBijAbcwHD@linutronix.de>
References: <YhUI1wUtV8yguijO@fuller.cnet>
        <YhUKRzEKxMvlGQ5n@fuller.cnet>
        <YiI+a9gTr/UBCf0X@fuller.cnet>
        <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
        <Yin7hDxdt0s/x+fp@fuller.cnet>
        <20220310182326.5b375da6b86e95f7e71acd90@linux-foundation.org>
        <YisJ5SLBijAbcwHD@linutronix.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 09:35:49 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> + sched division
> 
> On 2022-03-10 18:23:26 [-0800], Andrew Morton wrote:
> > On Thu, 10 Mar 2022 10:22:12 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > > On systems that run FIFO:1 applications that busy loop,
> > > any SCHED_OTHER task that attempts to execute
> > > on such a CPU (such as work threads) will not
> > > be scheduled, which leads to system hangs.
> …
> > 
> > Permitting a realtime thread to hang the entire system warrants a
> > -stable backport, I think.  That's just rude.
> 
> I'm not sure if someone is not willingly breaking the system. Based on
> my experience, a thread with an elevated priority (that FIFO, RR or DL)
> should not hog the CPU. A normal user (!root && !CAP_SYS_NICE) can't
> increase the priority of the task.
> To avoid a system hangup there is sched_rt_runtime_us which ensures that
> all RT threads are throttled once the RT class exceed a certain amount
> of runtime. This has been relaxed a little on systems with more CPUs so
> that the RT runtime can be shared but this sharing (RT_RUNTIME_SHARE)
> has been disabled by default a while ago. That safe switch
> (sched_rt_runtime_us) can be disabled and is usually disabled on RT
> system since the RT tasks usually run longer especially in corner cases.

Does all this apply if the kernel is non-preemptible?

Marcelo, do you know how the offending system bypassed the failsafe?


