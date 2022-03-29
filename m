Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC58D4EAAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiC2Jrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbiC2Jr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:47:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6036C239328;
        Tue, 29 Mar 2022 02:45:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EA89221639;
        Tue, 29 Mar 2022 09:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648547141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dqucqQN1ALb/6wOF00wF6WHMeIumOZO4cG4WbujdwI=;
        b=s07/9nEeGWPktpdqgBhc2Wjc+x7/izJtcw46LQOkIvL6bL4T+iBeCsNjFabuDbInl1fo2N
        PJWNwisPNwGcdX04IHaCP8bvjoLwobUE5l34XPV7N9FmL5yWjTO2H9CiMDG8sVR2amRpD7
        7RJOb/9sTUSHLjWfGlo75KGuOknz8Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648547141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dqucqQN1ALb/6wOF00wF6WHMeIumOZO4cG4WbujdwI=;
        b=F0AKx8BeZHidsbPcaJQQ7MGyATO5DhAGrn13lFAwnPHcVkscUZnrnMSAfmd7kMklihVBP7
        aoNJ8q0VgrnSnRCA==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E61ACA3B9D;
        Tue, 29 Mar 2022 09:45:40 +0000 (UTC)
Date:   Tue, 29 Mar 2022 10:45:38 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mtosatti@redhat.com, linux-rt-users@vger.kernel.org,
        vbabka@suse.cz, cl@linux.com, paulmck@kernel.org,
        willy@infradead.org
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
Message-ID: <20220329094538.GJ4363@suse.de>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
 <20220303114550.GE4363@suse.de>
 <3c24840e8378c69224974f321ec5c06a36a33dd3.camel@redhat.com>
 <20220325104800.GI4363@suse.de>
 <d21d742154cbd6d2b7546533655810e0bf7dd82f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d21d742154cbd6d2b7546533655810e0bf7dd82f.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 03:51:43PM +0200, Nicolas Saenz Julienne wrote:
> > Now we don't explicitly have this pattern because there isn't an
> > obvious this_cpu_read() for example but it can accidentally happen for
> > counting. __count_zid_vm_events -> __count_vm_events -> raw_cpu_add is
> > an example although a harmless one.
> > 
> > Any of the mod_page_state ones are more problematic though because we
> > lock one PCP but potentially update the per-cpu pcp stats of another CPU
> > of a different PCP that we have not locked and those counters must be
> > accurate.
> 
> But IIUC vmstats don't track pcplist usage (i.e. adding a page into the local
> pcplist doesn't affect the count at all). It is only when interacting with the
> buddy allocator that they get updated. It makes sense for the CPU that
> adds/removes pages from the allocator to do the stat update, regardless of the
> page's journey.
> 

It probably doesn't, I didn't audit it. As I said, it's subtle which is
why I'm wary of relying on accidental safety of getting a per-cpu pointer
that may not be stable. Even if it was ok *now*, I would worry that it
would break in the future. There already has been cases where patches
tried to move vmstats outside the appropriate locking accidentally.

> > It *might* still be safe but it's subtle, it could be easily accidentally
> > broken in the future and it would be hard to detect because it would be
> > very slow corruption of VM counters like NR_FREE_PAGES that must be
> > accurate.
> 
> What does accurate mean here? vmstat consumers don't get accurate data, only
> snapshots.

They are accurate in that they have "Eventual Consistency".
zone_page_state_snapshot exists to get a more accurate count but there is
always some drift but it still is accurate eventually. There is a clear
distinction between VM counters which can be inaccurate they are just to
assist debugging and vmstats like NR_FREE_PAGES that the kernel uses to
make decisions. It potentially gets very problematic if a per-cpu pointer
acquired from one zone gets migrated to another zone and the wrong vmstat
is updated. It *might* still be ok, I haven't audited it but if there is a
possible that two CPUs can be doing a RMW on one per-cpu vmstat structure,
it will corrupt and it'll be difficult to detect.

> And as I comment above you can't infer information about pcplist
> usage from these stats. So, I see no real need for CPU locality when updating
> them (which we're still retaining nonetheless, as per my comment above), the
> only thing that is really needed is atomicity, achieved by disabling IRQs (and
> preemption on RT). And this, even with your solution, is achieved through the
> struct zone's spin_lock (plus a preempt_disable() in RT).
> 

Yes, but under the series I had, I was using local_lock to stabilise what
CPU is being used before acquiring the per-cpu pointer. Strictly speaking,
it doesn't need a local_lock but the local_lock is clearer in terms of
what is being protected and it works with PROVE_LOCKING which already
caught a problematic softirq interaction for me when developing the series.

> All in all, my point is that none of the stats are affected by the change, nor
> have a dependency with the pcplists handling. And if we ever have the need to
> pin vmstat updates to pcplist usage they should share the same pcp structure.
> That said, I'm happy with either solution as long as we get remote pcplist
> draining. So if still unconvinced, let me know how can I help. I have access to
> all sorts of machines to validate perf results, time to review, or even to move
> the series forward.
> 

I also want the remote draining for PREEMPT_RT to avoid interference
of isolated CPUs due to workqueue activity but whatever the solution, I
would be happier if the per-cpu lock is acquired with the CPU stablised
and covers the scope of any vmstat delta updates stored in the per-cpu
structure.  The earliest I will be rebasing my series is 5.18-rc1 as I
see limited value in basing it on 5.17 aiming for a 5.19 merge window.

-- 
Mel Gorman
SUSE Labs
