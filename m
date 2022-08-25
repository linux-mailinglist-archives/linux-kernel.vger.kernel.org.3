Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3628E5A0C41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbiHYJJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiHYJJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:09:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BDA8991B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:09:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1C26035030;
        Thu, 25 Aug 2022 09:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661418576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FC9ZzorKRbzCpL4rSSj3usfAXS4dbIHwnPUXUNOYQ90=;
        b=ZzDVDpPDMJ4tuPva04ysDGKG8yOh1rwvE5W9wKFj4xIw4x11UhiSUcw/sEt9Ko5duqxCCO
        Xo0+SirsRzh6Fl/MQTpfT1rmo+BUS5JFBY2trpMGsMYWDkm9Y7FVaXkpoRnboSqCKiVRA1
        Qm7KIFhA1xdyoLgbcVsHn2ez5JXgsYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661418576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FC9ZzorKRbzCpL4rSSj3usfAXS4dbIHwnPUXUNOYQ90=;
        b=0Z/032uRPn7qe7C+uqLy/Fs/BZxUohEantR1Y7ZV42bAGXrSi1ZfD8XUD85vFGAQVESSoT
        hsvd7kKFZec5cwCQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8280D2C141;
        Thu, 25 Aug 2022 09:09:34 +0000 (UTC)
Date:   Thu, 25 Aug 2022 10:09:32 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Peng Wang <rocking@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: select waker's cpu for wakee on sync wakeup
Message-ID: <20220825090932.4cfxvt4ktm24guur@suse.de>
References: <1508aa17d1a169077c8d8d8c22d2bd529101af0e.1661313074.git.rocking@linux.alibaba.com>
 <20220824084614.kykmtbhyawcei67z@suse.de>
 <093acf40-9e57-d011-d90b-ea216700edc3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <093acf40-9e57-d011-d90b-ea216700edc3@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 02:45:05PM +0800, Peng Wang wrote:
> On 24/08/2022 16:46, , Mel Gorman wrote:
> > On Wed, Aug 24, 2022 at 12:37:50PM +0800, Peng Wang wrote:
> > > On sync wakeup, waker is about to sleep, and if it is the only
> > > running task, wakee can get warm data on waker's cpu.
> > > 
> > > Unixbench, schbench, and hackbench are tested on
> > > Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz (192 logic CPUs)
> > > 
> > > Unixbench get +20.7% improvement with full threads mainly
> > > because of the pipe-based context switch and fork test.
> > > 
> > > No obvious impact on schbench.
> > > 
> > > This change harms hackbench with lower concurrency, while gets improvement
> > > when concurrency increases.
> > > 
> > 
> > Note that historically patches in this direction have been hazardous because
> > it makes a key assumption "sync wakers always go to sleep in the near future"
> > when the sync hint is not that reliable. Networking from a brief glance
> > still uses sync wakeups where wakers could have a 1:N relationship between
> > work producers and work consumers that would then stack multiple tasks on
> > one CPU for multiple consumers. The workloads mentioned in the changelog
> > are mostly strictly-synchronous wakeups (i.e. the waker definitely goes
> > to sleep almost immediately) and benefit from this sort of patch but it's
> > not necessarily a universal benefit.
> 
> Hi, Mel
> 
> Thanks for your clarification.
> 
> Besides these benchmarks, I also find a similar strictly-synchronous wakeup
> case [1].
> 
> [1]https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1478754.html
> 

Yep, but it falls under the same heading, sometimes the caller knows it's
a strict sync wakeup but not always.

> > 
> > Note that most of these hazards occurred *LONG* before I was paying much
> > attention to how the scheduler behaved so I cannot state "sync is still
> > unreliable" with absolute certainty. However, long ago there was logic
> > that tried to track the accuracy of the sync hint that was ultimately
> > abandoned by commit e12f31d3e5d3 ("sched: Remove avg_overlap"). AFAIK,
> > the sync hint is still not 100% reliable and while stacking sync works
> > for some workloads, it's likely to be a regression magnet for network
> > intensive workloads or client/server workloads like databases where
> > "synchronous wakeups are not always synchronous".
> > 
> Yes, you are right. Perhaps in such situation, a strong contract from user
> is a better alternative than struggling with the weak hint in kernel.
> 

Even the kernel doesn't always know if a wakeup is really sync or not
because it lacks valuable context and the number of tasks on the runqueue is
insufficient if there are multiple wakeups in quick succession. At best,
there could be two WF_SYNC hints and hope every caller gets it right
(hint, they won't because even if it's right once, cargo cult copying
will eventually get it wrong and there is an API explosion issue such as
wake_up_interruptible_*). A user hint would be tricky. Core libraries
couldn't use it because it has no idea if the linked application wants
a strictly sync wakeup or not, a core library couldn't tell given just
a pthread_mute_t for example. Even if it was true at one point in time,
it might not be true later if the application design changed leading to
application bugs being blamed on the kernel for poor placement decisions.

-- 
Mel Gorman
SUSE Labs
