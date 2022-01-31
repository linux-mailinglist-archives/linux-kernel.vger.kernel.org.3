Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4164A4B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380169AbiAaQPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:15:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33706 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380155AbiAaQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:15:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBE6561476
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20E4C340E8;
        Mon, 31 Jan 2022 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643645731;
        bh=G5/GmnawyvfTAg9GUIMN0hKNa026wpa5vaEuo9gDPfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=e73+7woxqza6LWtdM61+itEc+f5+RWVIjG1X5OC5XQtI1c4pGI4lVv2vP48VP6H6F
         wO08n1bN3dqWuq0pJagm6qbKW150nvzoJp4whIAtg7eVYmGCuZvyrR6pqaCjYiyKtL
         8x9ExQT4O6LiBMk0gyg6mpLF3JIw2mkeLqkScqNC7wmOhKMmUkQ+1QCMHvyZ589eFG
         v+IeVP6AfN1BFKf+TxEg1RdmcaJ8yRYOogbOyf5oCsZeJguJkSeQK2584PFCvq63aq
         aUPbr/wKRSV0Bj4qdqKS2zbsAQluU+3ApMKGbdL9auGe7nEBlUKkgNmYfUo5MeOiRe
         42YMvHOj82snw==
From:   SeongJae Park <sj@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     SeongJae Park <sj@kernel.org>, Zach O'Keefe <zokeefe@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan.Cameron@huawei.com, amit@kernel.org,
        benh@kernel.crashing.org, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, foersleo@amazon.de,
        gthelen@google.com, markubo@amazon.de, shakeelb@google.com,
        baolin.wang@linux.alibaba.com, guoqing.jiang@linux.dev,
        xhao@linux.alibaba.com, hanyihao@vivo.com, changbin.du@gmail.com,
        kuba@kernel.org, rongwei.wang@linux.alibaba.com,
        rikard.falkeborn@gmail.com, geert@linux-m68k.org,
        kilobyte@angband.pl, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PLAN] Some humble ideas for DAMON future works
Date:   Mon, 31 Jan 2022 16:15:25 +0000
Message-Id: <20220131161525.34962-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <bcc8d9a0-81d-5f34-5e4-fcc28eb7ce@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 13:30:26 -0800 (PST) David Rientjes <rientjes@google.com> wrote:

> On Fri, 28 Jan 2022, SeongJae Park wrote:
> 
> > > > I think the first opinion makes sense as there are some valuable information
> > > > that only user space can know.  I think only such approaches could achieve the
> > > > ultimate efficiency in such cases.
> > > > I also agree to the second party, though, because there could be some people
> > > > who don't have special information that only their applications know, or
> > > > resources to do the additional work.  In-kernel simple policies will be still
> > > > beneficial for some users even though those are sub-optimal compared to the
> > > > highly tuned user space policy, if it provides some extent of efficiency gain
> > > > and no regressions for most cases.
> > > > 
> > > > I'd like to help both.  For the reason, I made DAMON as an in-kernel mechanism
> > > > for both user and kernel-space policies.  It provides highly tunable general
> > > > user space interface to help the first party.  It also provides in-kernel
> > > > policies which built on top of DAMON using its kernel-space API for specific
> > > > common use cases with conservative default parameters that assumed to incur no
> > > > regression but some extent of benefits in most cases, namely DAMON-based
> > > > proactive reclamation.  I will continue pursuing the two ways.
> > > > 
> > > 
> > > Are you referring only to root userspace here or are you including 
> > > non-root userspace?
> > > 
> > > Imagine a process that is willing to accept the cpu overhead for doing thp 
> > > collapse for portions of its memory in process context rather than waiting 
> > > for khugepaged and that we had a mechanism (discussed later) for doing 
> > > that in the kernel.  The non-root user in this case would need the ability 
> > > to monitor regions of its own heap, for example, and disregard others.  
> > > The malloc implementation wants to answer the question of "what regions of 
> > > my heap are accessed very frequently?" so that we can do hugepage 
> > > optimizations.
> > > 
> > > Do you see that the user will have the ability to fork off a DAMON context 
> > > to do this monitoring for their own heap?  kdamond could be attached to a 
> > > cpu cgroup to charge the cpu overhead for doing this monitoring and the 
> > > time spent applying any actions to that memory to that workload on a 
> > > multi-tenant machine.
> > > 
> > > I think it would be useful to discuss the role of non-root userspace for 
> > > future DAMON support.
> > 
> > Interesting points.  I haven't considered about the case in detail so far, but
> > I think your idea definitely makes sense.  I was also thinking we might end up
> > having DAMON syscalls in future.  It might make more sense to be used as the
> > interface for the non-root userspace.
> > 
> 
> Yeah, non-root userspace having access to an interface so that it can 
> construct a heat map of its own memory would be useful if we are not able 
> to fork off a DAMON context of our own.
> 
> One potential benefit of managing the DAMON context by non-root userspace 
> itself is that we can confine the monitoring overhead to only regions of 
> interest.  A malloc implementation may not be interested even in some 
> areas of its own heap, for example, because we can make assumptions.  Two 
> possibilities that I can think of: (1) portions of a malloc arena that 
> pack many small objects together so the likelihood of at least one access 
> during a sampling period is high, so not necessary to monitor for certain 
> schemes and (2) the malloc implementaton wants to make hints that some 
> areas of its heap are more interesting than others to monitor because of 
> application specific behavior.
> 
> Supporting only a non-root interface to generate a heat map may otherwise 
> incur unnecessary monitoring overhead.  And if non-root userspace can't 
> fork off its own context, this monitoring overhead seems like it would be 
> charged to the system as a whole and that might not be desired.

Agreed, this makes sense to me.

> 
> > > > DAMON-based Proactive LRU-pages (de)Activation
> > > > ----------------------------------------------
> > > > 
> > > > The reclamation mechanism which selects reclaim target using the
> > > > active/inactive LRU lists sometimes doesn't work well.  According to my
> > > > previous work, providing access pattern-based hints can significantly improve
> > > > the performance under memory pressure[1,2].
> > > > 
> > > > Proactive reclamation is known to be useful for many memory intensive systems,
> > > > and now we have a DAMON-based implementation of it[3].  However, the proactive
> > > > reclamation wouldn't be so welcome to some systems having high cost of I/O.
> > > > Also, even though the system runs proactive reclamation, memory pressure can
> > > > still occasionally triggered.
> > > > 
> > > > My idea for helping this situation is manipulating the orders of pages in LRU
> > > > lists using DAMON-provided monitoring results.  That is, making DAMON
> > > > proactively finds hot/cold memory regions and moves pages of the hot regions to
> > > > the head of the active list, while moving pages of the cold regions to the tail
> > > > of the inactive list.  This will help eventual reclamation under memory
> > > > pressure to evict cold pages first, so incur less additional page faults.
> > > > 
> > > 
> > > Let's add Johannes Weiner <hannes@cmpxchg.org> into this discussion as 
> > > well since we had previously discussed persistent background ordering of 
> > > the lru lists based on hotness and coldness of memory before.  This 
> > > discussion had happened before DAMON was merged upstream, so that DAMON 
> > > has landed it is likely an area that he's interested in.
> > > 
> > > One gotcha with the above might be the handling of MADV_FREE memory that 
> > > we want to lazily free under memory pressure.  Userspace has indicated 
> > > that we can free this memory whenever necessary, so the kernel 
> > > implementation moves this memory to the inactive lru regardless of any 
> > > hotness or coldness of the memory.  In other words, this memory *can* have 
> > > very high access frequencies in the short-term and then it's madvised with 
> > > MADV_FREE by userspace to free if we encounter memory pressure.  It seems 
> > > like this needs to override the DAMON-provided monitoring results since 
> > > userspace just knows better in certain scenarios.
> > 
> > Interesting case.  Similarly, some of our customers told us that they don't
> > want DAMON_RECLAIM to affect some special processes that managing their memory
> > in their highly optimized way.  To deal with this kind of situations, I'm
> > thinking about adding a sort of deny-list to DAMON-based Operation Schemes.
> > With that, users would be able to specify to which memory region (e.g., memory
> > regions of specific process, cgroup, pfn range, ...) each scheme shouldn't
> > apply its action.  So, in this case, the program would be able to avoid DAMON's
> > interference by adding the region to apply 'MADV_FREE' to the deny-list of
> > relevant DAMON-based operation scheme before calling 'madvise()'.
> > 
> 
> Correct me if I'm wrong, but the reason that DAMON_RECLAIM uses paddr is 
> because it can track unmapped memory that is otherwise not accessible if 
> using virtual address space monitoring.
> 
> Deny-lists might be hard, it seems, if we need to continually manipulate 
> the set of pids or set of cgroups that are opt-in and opt-out of 
> DAMON_RECLAIM without restructuring the entire cgroup hierarchy into 
> top-level damon_reclaimable and damon_unreclaimable cgroups :)
> 
> One idea might be to reimplement DAMON_RECLAIM to use virtual addresss 
> space monitoring, but I might be missing some of the details that preclude 
> this.  It would *seem* that DAMON_RECLAIM could be a context composed of 
> multiple targets that are opt-in, whether pids or cgroups, to being 
> reclaimed and amongst them there could be a prioritization scheme to 
> indicate which targets we want to reclaim from more or less aggressively.  
> 
> A secondary target could provide paddr monitoring but only for unmapped 
> memory that would not be scanned by the virtual address space monitors and 
> this would have its own prioritization scheme that can be compared with 
> the other targets.
> 
> But I feel like I'm missing something more fundamental about why 
> DAMON_RECLAIM must be paddr and we then need to support deny-lists that 
> might be more flexibly handled if done with virtual address space scanning 
> with a set of targets that opt-in.

DAMON_RECLAIM is an in-kernel policy for users who know their system is running
memory intensive workloads but don't want to do special memory optimization
works, and therefore just want the kernel to work a little bit better.
Therefore, I assume DAMON_RECLAIM users wouldn't want complex tuning, but might
have a few exceptional requests.  So the denylist would have only a few items
in it and hence would not so difficult to be used.  For them, asking the opt-in
list might be some additional works that they don't really want.

In contrast, the situation would be different for users who knows their
workloads well and willing to do specialized tuning.  For them, the
re-implementation of DAMON_RECLAIM in the way you suggested would make more
sense, and almost already available (making DAMON works against only unmapped
memory is currently not supported).  Actually, such user space-driven
specialized DAMON-based policies implementations are encouraged for such users.
If in-kernel DAMON-based policies like DAMON_RECLAIM or DAMON-based LRU
(de)activation are only bothering them, it would be better to simply turn off
those and implement alternatives for their situation.

As mentioned above, I want DAMON to be helpful for both two groups.

> 
> > > > DAMON-based THP Coalesce/Split
> > > > ------------------------------
> > > > 
> > > > THP is know to significantly improve performance, but also increase memory
> > > > footprint[1].  We can minimize the memory overhead while preserving the
> > > > performance benefit by asking DAMON to provide MADV_HUGEPAGE-like hints for hot
> > > > memory regions of >= 2MiB size, and MADV_NOHUGEPAGE-like hints for cold memory
> > > > regions.  Our experimental user space policy implementation[2] of this idea
> > > > removes 76.15% of THP memory waste while preserving 51.25% of THP speedup in
> > > > total.
> > > > 
> > > 
> > > This is a very interesting area to explore, and turns out to be very 
> > > timely as well.  We'll soon be proposing the MADV_COLLAPSE support that we 
> > > discussed here[1] and was well received.
> > > 
> > > One thought here is that with DAMON we can create a scheme to apply a 
> > > DAMOS_COLLAPSE action on very hot memory in the monitoring region that 
> > > would simply call into the new MADV_COLLAPSE code to allow us to do a 
> > > synchronous collapse in process context.  With the current DAMON support, 
> > > this seems very straight-forward once we have MADV_COLLAPSE.
> > > 
> > > [1] https://lore.kernel.org/all/d098c392-273a-36a4-1a29-59731cdf5d3d@google.com/
> > 
> > I also agree the synchronous and speedy THP collapse/split will be helpful for
> > application-specific usage, and what you described above is almost same to what
> > I'm planning to do.  Looking forward to MADV_COLLAPSE patch!
> > 
> 
> Adding Zach O'Keefe <zokeefe@google.com> who should be sending this out 
> shortly.  We'll be interested in your code review.

Looking forward to the patch! :)

> 
> > BTW, I'm also interested in the system-wide long term usage of the policy; the
> > slow speed of khugepaged seems not a big problem for the case.  I also recently
> > started thinking it might be more simple and make more sense to do the
> > proactive works for only collapse or split instead of doing those together,
> > depending on the system's THP setup.
> > 
> > For example, if '/sys/kernel/mm/transparent_hugepage/enabled' is set as
> > 'always', we could simply find cold memory regions and mark those with
> > NOHUGEPAGE hints to reduce THP internal fragmentation caused memory bloat,
> > under memory pressure.  If the file is set as 'madvise', we could find hot
> > memory regions and mark those with HUGEPAGE hints to reduce TLB misses, while
> > free memory ratio of the system is big.
> > 
> 
> Ah, yes, this is a slightly different motivation.  Our use of 
> max_ptes_none == 0 fixes the memory bloat problem for us :)  With 
> MADV_COLLAPSE, however, this perhaps may be better handled by a userspace 
> collapser instead of khugepaged since we can inform userspace of job 
> priorities and those that can or cannot handle the memory bloat.  In other 
> words, we no longer need to be lockd into a single max_ptes_none value for 
> the entire system if we are to explore a userspace collapser.

That makes sense.  Thank you for the clarification.

> 
> > > 
> > > > [1] https://www.usenix.org/conference/osdi16/technical-sessions/presentation/kwon
> > > > [2] https://damonitor.github.io/doc/html/v34/vm/damon/eval.html
> > > > 
[...]
> > > > 
> > > > DAMON-based Proactive Compaction
> > > > --------------------------------
> > > > 
> > > > Compaction uses migration scanner to find migration source pages.  Hot pages
> > > > would be more likely to be unmovable compared to cold pages, so it would be
> > > > better to try migration of cold pages first.  DAMON could be used here.  That
> > > > is, proactively monitoring accesses via DAMON and start compaction so that the
> > > > migration scanner scan cold memory ranges first.  I should admit I'm not
> > > > familiar with compaction code and I have no PoC data for this but just the
> > > > groundless idea, though.
> > > > 
> > > 
> > > Is compaction enlightenment for DAMON a high priority at this point, or 
> > > would AutoNUMA be a more interesting candidate?
> > > 
> > > Today, AutoNUMA works with a sliding window setting page tables to have 
> > > PROT_NONE permissions so that we induce a page fault and can determine 
> > > which cpu is accessing potentially remote memory (task_numa_work()).  If 
> > > that's happening, we can migrate the memory to the home NUMA node so that 
> > > we can avoid those remote memory accesses and the increased latency that 
> > > it induces.
> > 
> > I might missing something from your point, but what I hope to achieve with this
> > is faster and more successful defragmentation, not reduction of remote-NUMA
> > accesses.  Applying DAMON for enlightening AutoNUMA is also an interesting
> > idea, though.
> > 
> 
> Yeah, sorry, I conflated your proactive compaction topic with AutoNUMA :/
> 
> I'm not sure that I fully understand the point about hot pages being more 
> likely to be unmovable.  There may be optimizations possible in migrating 
> cold pages first, but I don't believe hotness implies that a page becomes 
> fully unmovable as a result of its access frequency.

Agreed.  This is only in a brainstorming level without any data.

> 
> > > Idea: if we enlightened task_numa_work() to prioritize hot memory using 
> > > DAMON, it *seems* like this would be most effective rather than relying on 
> > > a sliding window.  We want to migrate memory that is frequently being 
> > > accessed to reduce the remote memory access latency, we only get a minimal 
> > > improvement (mostly only node balancing) for memory that is rarely 
> > > accessed.
> > > 
> > > I'm somewhat surprised this isn't one of the highest priorities, actually, 
> > > for being enlightened with DAMON support, so it feels like I'm missing 
> > > something obvious.
> > > 
> > > Let's also add Dave Hansen <dave.hansen@linux.intel.com> into the thread 
> > > for the above two sections (memory tiering and AutoNUMA) because I know 
> > > he's thought about both.
> > 
> > AutoNUMA would need to know not only how frequently the memory regions is
> > accessed, but also which CPUs are how frequently accessing the memory regions.
> > Currently, DAMON doesn't provide the CPU-related information.  I think DAMON
> > could be extended for the case, by using the page fault mechanism as its basic
> > access check primitive instead of Accessed bits.  It would doable as DAMON is
> > designed to support such extension, but would need some additional efforts.
> > 
> 
> Yeah, I meant that we keep the current mechanism that allows AutoNUMA to 
> determine its optimal node by setting ptes to have PROT_NONE and inducing 
> a page fault so that we can determine the cpu, and thereby its NUMA node, 
> that is accessing it.
> 
> The idea for DAMON enlightenment here is that we can do better than the 
> simple sliding window that AutoNUMA currently uses.  In other words, 
> prefer to set hot memory to have PROT_NONE so that we can optimize the 
> node placement of frequently accessed memory first rather than simply 
> iterating through memory as though it all has the same access frequency 
> setting PROT_NONE.
> 
> This would need some more complexities, though, since the same memory 
> might consistently be hot and then we've succeeded in doing nothing but 
> inducing non-stop page faults for very hot memory :)

Agreed, thank you for the clarification!  I think that makes sense, and it
would require some additional works as you also mentioned.  Nevertheless, I
believe it's doable.  And I think we might be able to control the page fault
overhead using some sampling techniques.  Also, we might be able to use not
only PROT_NONE, but with the Accessed bits for further monitoring overhead
reduction.


Thanks,
SJ

[...]
