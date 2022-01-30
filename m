Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA264A3A61
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiA3Vaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiA3Va3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:30:29 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A5DC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:30:29 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 192so11227986pfz.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=lqFu7BmhrOkJA+Blf96Rt/K2yKJ/150CC8tV6sy/6sA=;
        b=FKzFpgmozi7g52+31GKwPvFxRgcKObcGrVkGZ8dY/csdfhAV4YZvmlXD2bq75D/FzZ
         bcW91eEChboChPczfe1QeAGhH5NsveRnlipS6ku3VMnMZLxus6y1uZXxzRWU8xZojoIm
         XOxnS1ADkBu8Bu9eSA9S6rGpw+WnmBCuhlHbI4fXQiCe4sjyxqx/NkejLoYlFk0k7SpN
         B9z0IlFxuCVRFvMTPXbOy9+Y1LgA2MS0TlmddG+5tQhXTVTBUmr+2QNBsp5Hp94Fk5tm
         RE12kZBH5Nx8xz1PF2sBtz8qHyHFCN/HS2kk1m+OaxOiCWIy1vXxYFbO4cM8JF3MCi8/
         boOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=lqFu7BmhrOkJA+Blf96Rt/K2yKJ/150CC8tV6sy/6sA=;
        b=WvfheepUnrOCkLL02ZyWkA2YkNY99hKQw04Buf2FegFvWe2RSoRAjBvw0FfyR5tApN
         gVExIc2Gj/qPt+2AESmbxM+cYIM2KDsxp5IpKVF+Ya8r4bWHBaKOzf9GaM6f5vuerSnG
         YZeMvTAXFfQ7WBcCzxSDFNYEiRUAgA99jr5nk6JIRVbTq95pCg25pe3+hfp22BioaFBN
         q88GYxfba18Rf6fXq6np+RH8mkFvZH+GzhupAKBkyR32KMjrfgfqFDoZAhNGSE12XDAx
         p8dk4n/n5hRx91/9hHVCJJk9tQBDpZcVgmqgzKJUPvgXpWUh5Uo04aNldJUUiKBZkyeC
         sn/A==
X-Gm-Message-State: AOAM532axbt8rmqLtA8tMkel2MCQkl3Xpf7sMfK56Drfh0UsPh3vlrgD
        DnfjE1CW9fkFtiehzgmNRAiECA==
X-Google-Smtp-Source: ABdhPJyHiuyAnZ13dAP7PZ5THWLsJHK/EKFYmvLqmqYtkGtowD3zkweb5/9A/8K9+KnH9L0mLlusFw==
X-Received: by 2002:a63:d848:: with SMTP id k8mr14691119pgj.164.1643578228030;
        Sun, 30 Jan 2022 13:30:28 -0800 (PST)
Received: from [2620:15c:29:204:2b97:ce13:593d:973d] ([2620:15c:29:204:2b97:ce13:593d:973d])
        by smtp.gmail.com with ESMTPSA id z22sm7325890pfe.42.2022.01.30.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:30:27 -0800 (PST)
Date:   Sun, 30 Jan 2022 13:30:26 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     SeongJae Park <sj@kernel.org>, Zach O'Keefe <zokeefe@google.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
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
In-Reply-To: <20220128134146.5379-1-sj@kernel.org>
Message-ID: <bcc8d9a0-81d-5f34-5e4-fcc28eb7ce@google.com>
References: <20220128134146.5379-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="447496086-1039519115-1643578227=:713143"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--447496086-1039519115-1643578227=:713143
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 28 Jan 2022, SeongJae Park wrote:

> > > I think the first opinion makes sense as there are some valuable information
> > > that only user space can know.  I think only such approaches could achieve the
> > > ultimate efficiency in such cases.
> > > I also agree to the second party, though, because there could be some people
> > > who don't have special information that only their applications know, or
> > > resources to do the additional work.  In-kernel simple policies will be still
> > > beneficial for some users even though those are sub-optimal compared to the
> > > highly tuned user space policy, if it provides some extent of efficiency gain
> > > and no regressions for most cases.
> > > 
> > > I'd like to help both.  For the reason, I made DAMON as an in-kernel mechanism
> > > for both user and kernel-space policies.  It provides highly tunable general
> > > user space interface to help the first party.  It also provides in-kernel
> > > policies which built on top of DAMON using its kernel-space API for specific
> > > common use cases with conservative default parameters that assumed to incur no
> > > regression but some extent of benefits in most cases, namely DAMON-based
> > > proactive reclamation.  I will continue pursuing the two ways.
> > > 
> > 
> > Are you referring only to root userspace here or are you including 
> > non-root userspace?
> > 
> > Imagine a process that is willing to accept the cpu overhead for doing thp 
> > collapse for portions of its memory in process context rather than waiting 
> > for khugepaged and that we had a mechanism (discussed later) for doing 
> > that in the kernel.  The non-root user in this case would need the ability 
> > to monitor regions of its own heap, for example, and disregard others.  
> > The malloc implementation wants to answer the question of "what regions of 
> > my heap are accessed very frequently?" so that we can do hugepage 
> > optimizations.
> > 
> > Do you see that the user will have the ability to fork off a DAMON context 
> > to do this monitoring for their own heap?  kdamond could be attached to a 
> > cpu cgroup to charge the cpu overhead for doing this monitoring and the 
> > time spent applying any actions to that memory to that workload on a 
> > multi-tenant machine.
> > 
> > I think it would be useful to discuss the role of non-root userspace for 
> > future DAMON support.
> 
> Interesting points.  I haven't considered about the case in detail so far, but
> I think your idea definitely makes sense.  I was also thinking we might end up
> having DAMON syscalls in future.  It might make more sense to be used as the
> interface for the non-root userspace.
> 

Yeah, non-root userspace having access to an interface so that it can 
construct a heat map of its own memory would be useful if we are not able 
to fork off a DAMON context of our own.

One potential benefit of managing the DAMON context by non-root userspace 
itself is that we can confine the monitoring overhead to only regions of 
interest.  A malloc implementation may not be interested even in some 
areas of its own heap, for example, because we can make assumptions.  Two 
possibilities that I can think of: (1) portions of a malloc arena that 
pack many small objects together so the likelihood of at least one access 
during a sampling period is high, so not necessary to monitor for certain 
schemes and (2) the malloc implementaton wants to make hints that some 
areas of its heap are more interesting than others to monitor because of 
application specific behavior.

Supporting only a non-root interface to generate a heat map may otherwise 
incur unnecessary monitoring overhead.  And if non-root userspace can't 
fork off its own context, this monitoring overhead seems like it would be 
charged to the system as a whole and that might not be desired.

> > > DAMON-based Proactive LRU-pages (de)Activation
> > > ----------------------------------------------
> > > 
> > > The reclamation mechanism which selects reclaim target using the
> > > active/inactive LRU lists sometimes doesn't work well.  According to my
> > > previous work, providing access pattern-based hints can significantly improve
> > > the performance under memory pressure[1,2].
> > > 
> > > Proactive reclamation is known to be useful for many memory intensive systems,
> > > and now we have a DAMON-based implementation of it[3].  However, the proactive
> > > reclamation wouldn't be so welcome to some systems having high cost of I/O.
> > > Also, even though the system runs proactive reclamation, memory pressure can
> > > still occasionally triggered.
> > > 
> > > My idea for helping this situation is manipulating the orders of pages in LRU
> > > lists using DAMON-provided monitoring results.  That is, making DAMON
> > > proactively finds hot/cold memory regions and moves pages of the hot regions to
> > > the head of the active list, while moving pages of the cold regions to the tail
> > > of the inactive list.  This will help eventual reclamation under memory
> > > pressure to evict cold pages first, so incur less additional page faults.
> > > 
> > 
> > Let's add Johannes Weiner <hannes@cmpxchg.org> into this discussion as 
> > well since we had previously discussed persistent background ordering of 
> > the lru lists based on hotness and coldness of memory before.  This 
> > discussion had happened before DAMON was merged upstream, so that DAMON 
> > has landed it is likely an area that he's interested in.
> > 
> > One gotcha with the above might be the handling of MADV_FREE memory that 
> > we want to lazily free under memory pressure.  Userspace has indicated 
> > that we can free this memory whenever necessary, so the kernel 
> > implementation moves this memory to the inactive lru regardless of any 
> > hotness or coldness of the memory.  In other words, this memory *can* have 
> > very high access frequencies in the short-term and then it's madvised with 
> > MADV_FREE by userspace to free if we encounter memory pressure.  It seems 
> > like this needs to override the DAMON-provided monitoring results since 
> > userspace just knows better in certain scenarios.
> 
> Interesting case.  Similarly, some of our customers told us that they don't
> want DAMON_RECLAIM to affect some special processes that managing their memory
> in their highly optimized way.  To deal with this kind of situations, I'm
> thinking about adding a sort of deny-list to DAMON-based Operation Schemes.
> With that, users would be able to specify to which memory region (e.g., memory
> regions of specific process, cgroup, pfn range, ...) each scheme shouldn't
> apply its action.  So, in this case, the program would be able to avoid DAMON's
> interference by adding the region to apply 'MADV_FREE' to the deny-list of
> relevant DAMON-based operation scheme before calling 'madvise()'.
> 

Correct me if I'm wrong, but the reason that DAMON_RECLAIM uses paddr is 
because it can track unmapped memory that is otherwise not accessible if 
using virtual address space monitoring.

Deny-lists might be hard, it seems, if we need to continually manipulate 
the set of pids or set of cgroups that are opt-in and opt-out of 
DAMON_RECLAIM without restructuring the entire cgroup hierarchy into 
top-level damon_reclaimable and damon_unreclaimable cgroups :)

One idea might be to reimplement DAMON_RECLAIM to use virtual addresss 
space monitoring, but I might be missing some of the details that preclude 
this.  It would *seem* that DAMON_RECLAIM could be a context composed of 
multiple targets that are opt-in, whether pids or cgroups, to being 
reclaimed and amongst them there could be a prioritization scheme to 
indicate which targets we want to reclaim from more or less aggressively.  

A secondary target could provide paddr monitoring but only for unmapped 
memory that would not be scanned by the virtual address space monitors and 
this would have its own prioritization scheme that can be compared with 
the other targets.

But I feel like I'm missing something more fundamental about why 
DAMON_RECLAIM must be paddr and we then need to support deny-lists that 
might be more flexibly handled if done with virtual address space scanning 
with a set of targets that opt-in.

> > > DAMON-based THP Coalesce/Split
> > > ------------------------------
> > > 
> > > THP is know to significantly improve performance, but also increase memory
> > > footprint[1].  We can minimize the memory overhead while preserving the
> > > performance benefit by asking DAMON to provide MADV_HUGEPAGE-like hints for hot
> > > memory regions of >= 2MiB size, and MADV_NOHUGEPAGE-like hints for cold memory
> > > regions.  Our experimental user space policy implementation[2] of this idea
> > > removes 76.15% of THP memory waste while preserving 51.25% of THP speedup in
> > > total.
> > > 
> > 
> > This is a very interesting area to explore, and turns out to be very 
> > timely as well.  We'll soon be proposing the MADV_COLLAPSE support that we 
> > discussed here[1] and was well received.
> > 
> > One thought here is that with DAMON we can create a scheme to apply a 
> > DAMOS_COLLAPSE action on very hot memory in the monitoring region that 
> > would simply call into the new MADV_COLLAPSE code to allow us to do a 
> > synchronous collapse in process context.  With the current DAMON support, 
> > this seems very straight-forward once we have MADV_COLLAPSE.
> > 
> > [1] https://lore.kernel.org/all/d098c392-273a-36a4-1a29-59731cdf5d3d@google.com/
> 
> I also agree the synchronous and speedy THP collapse/split will be helpful for
> application-specific usage, and what you described above is almost same to what
> I'm planning to do.  Looking forward to MADV_COLLAPSE patch!
> 

Adding Zach O'Keefe <zokeefe@google.com> who should be sending this out 
shortly.  We'll be interested in your code review.

> BTW, I'm also interested in the system-wide long term usage of the policy; the
> slow speed of khugepaged seems not a big problem for the case.  I also recently
> started thinking it might be more simple and make more sense to do the
> proactive works for only collapse or split instead of doing those together,
> depending on the system's THP setup.
> 
> For example, if '/sys/kernel/mm/transparent_hugepage/enabled' is set as
> 'always', we could simply find cold memory regions and mark those with
> NOHUGEPAGE hints to reduce THP internal fragmentation caused memory bloat,
> under memory pressure.  If the file is set as 'madvise', we could find hot
> memory regions and mark those with HUGEPAGE hints to reduce TLB misses, while
> free memory ratio of the system is big.
> 

Ah, yes, this is a slightly different motivation.  Our use of 
max_ptes_none == 0 fixes the memory bloat problem for us :)  With 
MADV_COLLAPSE, however, this perhaps may be better handled by a userspace 
collapser instead of khugepaged since we can inform userspace of job 
priorities and those that can or cannot handle the memory bloat.  In other 
words, we no longer need to be lockd into a single max_ptes_none value for 
the entire system if we are to explore a userspace collapser.

> > 
> > > [1] https://www.usenix.org/conference/osdi16/technical-sessions/presentation/kwon
> > > [2] https://damonitor.github.io/doc/html/v34/vm/damon/eval.html
> > > 
> > > DAMON-based Tiered Memory (Pro|De)motion
> > > ----------------------------------------
> > > 
> > > In tiered memory systems utilizing DRAM and PMEM[1], we can promote hot pages to
> > > DRAM and demote cold pages to PMEM using DAMON.  A patch for allowing
> > > access-aware demotion user space policy development is already submitted[2] by
> > > Baolin.
> > > 
> > 
> > Thanks for this, it's very useful.  Is it possible to point to any data on 
> > how responsive the promotion side can be to recent memory accesses?  It 
> > seems like we'll need to promote that memory quite quickly to not suffer 
> > long-lived performance degradations if we're treating DRAM and PMEM as 
> > schedulable memory.
> > 
> > DAMON provides us with a framework so that we have complete control over 
> > the efficiency of scanning PMEM for possible promotion candidates.  But 
> > I'd be very interested in seeing any data from Baolin (or anybody else) on 
> > just how responsive the promotion side can be.
> 
> Totally agreed.  I think the idea makes some sense, but it's useless without
> data.  This was in my TODO list since the beginning of DAMON, but I was too
> lazy to do that.  I even couldn't start the test environment setup survey yet.
> Also, this is not yet prioritized among other tasks in my TODO list.  If anyone
> could provide any PoC results or easy-to-start DRAM/PMEM test machine setup
> instructions, it would be great.  Long story short, I don't have any data.  Any
> data or help will be welcome.
> 
> > 
> > > [1] https://www.intel.com/content/www/us/en/products/details/memory-storage/optane-memory.html
> > > [2] https://lore.kernel.org/linux-mm/cover.1640171137.git.baolin.wang@linux.alibaba.com/
> > > 
> > > DAMON-based Proactive Compaction
> > > --------------------------------
> > > 
> > > Compaction uses migration scanner to find migration source pages.  Hot pages
> > > would be more likely to be unmovable compared to cold pages, so it would be
> > > better to try migration of cold pages first.  DAMON could be used here.  That
> > > is, proactively monitoring accesses via DAMON and start compaction so that the
> > > migration scanner scan cold memory ranges first.  I should admit I'm not
> > > familiar with compaction code and I have no PoC data for this but just the
> > > groundless idea, though.
> > > 
> > 
> > Is compaction enlightenment for DAMON a high priority at this point, or 
> > would AutoNUMA be a more interesting candidate?
> > 
> > Today, AutoNUMA works with a sliding window setting page tables to have 
> > PROT_NONE permissions so that we induce a page fault and can determine 
> > which cpu is accessing potentially remote memory (task_numa_work()).  If 
> > that's happening, we can migrate the memory to the home NUMA node so that 
> > we can avoid those remote memory accesses and the increased latency that 
> > it induces.
> 
> I might missing something from your point, but what I hope to achieve with this
> is faster and more successful defragmentation, not reduction of remote-NUMA
> accesses.  Applying DAMON for enlightening AutoNUMA is also an interesting
> idea, though.
> 

Yeah, sorry, I conflated your proactive compaction topic with AutoNUMA :/

I'm not sure that I fully understand the point about hot pages being more 
likely to be unmovable.  There may be optimizations possible in migrating 
cold pages first, but I don't believe hotness implies that a page becomes 
fully unmovable as a result of its access frequency.

> > Idea: if we enlightened task_numa_work() to prioritize hot memory using 
> > DAMON, it *seems* like this would be most effective rather than relying on 
> > a sliding window.  We want to migrate memory that is frequently being 
> > accessed to reduce the remote memory access latency, we only get a minimal 
> > improvement (mostly only node balancing) for memory that is rarely 
> > accessed.
> > 
> > I'm somewhat surprised this isn't one of the highest priorities, actually, 
> > for being enlightened with DAMON support, so it feels like I'm missing 
> > something obvious.
> > 
> > Let's also add Dave Hansen <dave.hansen@linux.intel.com> into the thread 
> > for the above two sections (memory tiering and AutoNUMA) because I know 
> > he's thought about both.
> 
> AutoNUMA would need to know not only how frequently the memory regions is
> accessed, but also which CPUs are how frequently accessing the memory regions.
> Currently, DAMON doesn't provide the CPU-related information.  I think DAMON
> could be extended for the case, by using the page fault mechanism as its basic
> access check primitive instead of Accessed bits.  It would doable as DAMON is
> designed to support such extension, but would need some additional efforts.
> 

Yeah, I meant that we keep the current mechanism that allows AutoNUMA to 
determine its optimal node by setting ptes to have PROT_NONE and inducing 
a page fault so that we can determine the cpu, and thereby its NUMA node, 
that is accessing it.

The idea for DAMON enlightenment here is that we can do better than the 
simple sliding window that AutoNUMA currently uses.  In other words, 
prefer to set hot memory to have PROT_NONE so that we can optimize the 
node placement of frequently accessed memory first rather than simply 
iterating through memory as though it all has the same access frequency 
setting PROT_NONE.

This would need some more complexities, though, since the same memory 
might consistently be hot and then we've succeeded in doing nothing but 
inducing non-stop page faults for very hot memory :)

> > 
> > > How We Can Implement These
> > > --------------------------
> > > 
> > > Implementing most of the above mentioned policies wouldn't be too difficult
> > > because we have DAMON-based Operation Schemes (DAMOS).  That is, we will need
> > > to implement some more DAMOS action for each policy.  Some existing kernel
> > > functions can be reused.  Such actions would include LRU (de)activation, THP
> > > coalesce/split hints, memory (pro|de)motion, and cold pages first scanning
> > > compaction.  Then, supporting those actions with the user space interface will
> > > allows implementing user space policies.  If we find reasonably good default
> > > DAMOS parameters and some kernel side control mechanism, we can further make
> > > those as kernel policies in form of, say, builtin modules.
> > > 
> > > How DAMON Should Be Evolved For Supporting Those
> > > ================================================
> > > 
> > > Let's discuss what kind of changes in DAMON will be needed to efficiently
> > > support above mentioned policies.
> > > 
> > > Simultaneously Monitoring Different Types of Address Spaces
> > > -----------------------------------------------------------
> > > 
> > > It would be better to run all the above mentioned policies simultaneously on
> > > single system.  As some policies such as LRU-pages (de)activation would better
> > > to run on physical address space while some policies such as THP coalesce/split
> > > would need to run on virtual address spaces, DAMON should support concurrently
> > > monitoring different address spaces.  We can always do this by creating one
> > > DAMON context for each address space and running those.  However, as the
> > > address spaces will conflict, each other will be interfered.  Current idea for
> > > avoiding this is allowing multiple DAMON contexts to run on a single thread,
> > > forcing them to have same monitoring contexts.
> > > 
> > > Online Parameters Updates
> > > -------------------------
> > > 
> > > Someone would also want to dynamically turn on/off and/or tune each policy.
> > > This is impossible with current DAMON, because it prohibits updating any
> > > parameter while it is running.  We disallow the online parameters update
> > > mainly because we want to avoid doing additional synchronization between the
> > > running kdamond and the parameters updater.  The idea for supporting the use
> > > case while avoiding the additional synchronization is, allowing users to pause
> > > DAMON and update parameters while it is paused.
> > > 
> > > A Better DAMON interface
> > > ------------------------
> > > 
> > > DAMON is currently exposing its major functionality to the user space via the
> > > debugfs.  After all, DAMON is not for only debugging.  Also, this makes the
> > > interface depends on debugfs unnecessarily, and considered unreliable.  Also,
> > > the interface is quite unflexible for future interface extension.  I admit it
> > > was not a good choice.
> > > 
> > > It would be better to implement another reliable and easily extensible
> > > interface, and deprecate the debugfs interface.  The idea is exposing the
> > > interface via sysfs using hierarchical Kobjects under mm_kobject.  For example,
> > > the usage would be something like below:
> > > 
> > >     # cd /sys/kernel/mm/damon
> > >     # echo 1 > nr_kdamonds
> > >     # echo 1 > kdamond_1/contexts/nr_contexts
> > >     # echo va > kdamond_1/contexts/context_1/target_type
> > >     # echo 1 > kdamond_1/contexts/context_1/targets/nr_targets
> > >     # echo $(pidof <workload>) > \
> > >                     kdamond_1/contexts/context_1/targets/target_1/pid
> > >     # echo Y > monitor_on
> > > 
> > > The underlying files hierarchy could be something like below.
> > > 
> > >     /sys/kernel/mm/damon/
> > >     │ monitor_on
> > >     │ kdamonds
> > >     │ │ nr_kdamonds
> > >     │ │ kdamond_1/
> > >     │ │ │ kdamond_pid
> > >     │ │ │ contexts
> > >     │ │ │ │ nr_contexts
> > >     │ │ │ │ context_1/
> > >     │ │ │ │ │ target_type (va | pa)
> > >     │ │ │ │ │ attrs/
> > >     │ │ │ │ │ │ intervals/sampling,aggr,update
> > >     │ │ │ │ │ │ nr_regions/min,max
> > >     │ │ │ │ │ targets/
> > >     │ │ │ │ │ │ nr_targets
> > >     │ │ │ │ │ │ target_1/
> > >     │ │ │ │ │ │ │ pid
> > >     │ │ │ │ │ │ │ init_regions/
> > >     │ │ │ │ │ │ │ │ region1/
> > >     │ │ │ │ │ │ │ │ │ start,end
> > >     │ │ │ │ │ │ │ │ ...
> > >     │ │ │ │ │ │ ...
> > >     │ │ │ │ │ schemes/
> > >     │ │ │ │ │ │ nr_schemes
> > >     │ │ │ │ │ │ scheme_1/
> > >     │ │ │ │ │ │ │ action
> > >     │ │ │ │ │ │ │ target_access_pattern/
> > >     │ │ │ │ │ │ │ │ sz/min,max
> > >     │ │ │ │ │ │ │ │ nr_accesses/min,max
> > >     │ │ │ │ │ │ │ │ age/min,max
> > >     │ │ │ │ │ │ │ quotas/
> > >     │ │ │ │ │ │ │ │ ms,bytes,reset_interval
> > >     │ │ │ │ │ │ │ │ prioritization_weights/
> > >     │ │ │ │ │ │ │ │   sz,nr_accesses,age
> > >     │ │ │ │ │ │ │ watermarks/
> > >     │ │ │ │ │ │ │   metric,check_interval,high,mid,low
> > >     │ │ │ │ │ │ │ stats/
> > >     │ │ │ │ │ │ │ │ quota_exceeds
> > >     │ │ │ │ │ │ │ │ tried/nr,sz
> > >     │ │ │ │ │ │ │ │ applied/nr,sz
> > >     │ │ │ │ │ │ │ ...
> > >     │ │ │ │ ...
> > >     │ │ ...
> > > 
> > > More DAMON Future Works
> > > =======================
> > > 
> > > In addition to above mentioned things, there are many works to do.  It would be
> > > better to extend DAMON for more use cases and address spaces support, including
> > > page granularity, idleness only, read/write only, page cache only, and cgroups
> > > monitoring supports.
> > > 
> > 
> > Cgroup support is very interesting so that we do not need to constantly 
> > maintain a list of target_ids when a job forks new processes.  We've 
> > discussed the potential for passing a cgroup inode as the target rather 
> > than pid for virtual address monitoring that would operate over the set of 
> > processes attached to that cgroup hierarchy.  Is this what you imagine for 
> > cgroup support or something more elaborate (or something different 
> > entirely :)?
> 
> You're correct.  That's my current idea.
> 
> > 
> > > Also it would be valuable to improve the accuracy of monitoring, using some
> > > adaptive monitoring attributes tuning or some new fancy idea[1].
> > > 
> > > DAMOS could also be improved by utilizing its own autotuning feature, for
> > > example, by monitoring PSI and other metrics related to the given action.
> > > 
> > > [1] https://linuxplumbersconf.org/event/11/contributions/984/
> > > 
> > 
> > I'd like to add another topic here: DAMON based monitoring for virtualized 
> > workloads.  Today, it seems like you'd need to run DAMON in the guest to 
> > be able to describe its working set.  Monitoring the hypervisor process 
> > is inadequate because it will reveal the first access to the guest owned 
> > memory but not the accesses done by the guest itself.  So it seems like 
> > the *current* support for virtual address monitoring is insufficient 
> > unless the guest is enlightened to do DAMON monitoring itself.
> > 
> > What about unenlightened guests?  An idea is a third DAMON monitoring mode 
> > that monitors accesses in the EPT.  Have you thought about this before or 
> > other ways to monitor memory access for an *unenlightened* guest?  Would 
> > love to have a discussion on this.
> 
> We're checking guest-internal accesses via 'mmu_notifier_clear_young()', and I
> confirmed[1] it allows DAMON on host to collect data accesses in KVM/QEMU
> guests.  I'm not heavily testing/using the case, though.
> 
> [1] https://lore.kernel.org/linux-mm/CALvZod61Dx4emiV5H73mQcFN6WvmD4A2Z=sRfmN2qpBh3R-_kQ@mail.gmail.com/
> 
> Thank you again for above greatful comments, David.  If you have more
> questions/comments, or you find anything I'm missing, please let me know.
> 
> 
> Thanks,
> SJ
> 
--447496086-1039519115-1643578227=:713143--
