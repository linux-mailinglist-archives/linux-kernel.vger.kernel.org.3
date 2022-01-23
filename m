Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C839497620
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbiAWWsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiAWWsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:48:38 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF77AC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 14:48:38 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y17so3460924plg.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 14:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=k+IWLGaQh6aDZOBXI4bmi02taB1vvDIkWuoFDwP7/Ho=;
        b=bZbnD45FO5ZZ4F5NXNe63D7tyF/aRbfsHgVW8icGYq6F7MyrwBikRkG4gOA7dxDuBi
         51ption67YihOG2MTeBtGqHdOHByRkRoLiuBGhXBgA1WAE+CCDTaeKekfpBdoADQSZ3U
         objCA3gScNifflYAg/nYhssW3fui487dfYB4rnezMFw1ntdqKi2wUJKNGKPUqiKnxpwX
         JD5Of7+aqZ3XjVC6z/MZARA0fOhLzgiNi6/uGogyPZ8nYtfrD088bzzoycEHNa443tuy
         tXonBRrXFIHwMerlSpi9aPD3bSVYwg1x0JkiH73XNz2k7nLiiNlulgvLpTd+Sg8Fj7C7
         XDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=k+IWLGaQh6aDZOBXI4bmi02taB1vvDIkWuoFDwP7/Ho=;
        b=WoEJhn27ChzAeMPzqm6odVxDQqJPSP0UF7HCYxsBVDL9JAvtAqG31bC8GwsxdUA1vo
         jpjWBvy3vjvNmxLD0wMD5BRTjw4P4332tWBSoJWgm34ORmU/igKxhCtiE/eJ82Cypt3z
         KYnVZqM/Xcy2rGuR7f65dH2VIPt8h570OksFccA5euMItt7af5kX/eGWlRxaGnHwXD+a
         Mejy+A3hZVMwQLHu3IFt9gOOlPvunc0dXBJErkCiBB7wQMUa593wL59LS+eJvriqcNG+
         cIV8CBvgqEl+baV5f4XzQyILsR91UQ9nMBXPYv31ZDeN2WZ/WrUXRDYFVSuKrj68D0uw
         JWfQ==
X-Gm-Message-State: AOAM5311y8esxvr0hVZzX9m33dBQ7wlkgBkRQvBL5zYnCELFYd9yFcGq
        mSmAbtroYWJOs4IH70kbD8ouNw==
X-Google-Smtp-Source: ABdhPJwejoO02J7M+0Drg5UYaP5lmcJcKccVFkEGF7BzgB00XogAk49mPRJYQ0kQUk5tOCa5IIMXiA==
X-Received: by 2002:a17:90b:164e:: with SMTP id il14mr3749055pjb.84.1642978117775;
        Sun, 23 Jan 2022 14:48:37 -0800 (PST)
Received: from [2620:15c:29:204:e422:4914:e809:839f] ([2620:15c:29:204:e422:4914:e809:839f])
        by smtp.gmail.com with ESMTPSA id b2sm14079640pfv.134.2022.01.23.14.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:48:36 -0800 (PST)
Date:   Sun, 23 Jan 2022 14:48:35 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     SeongJae Park <sj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
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
In-Reply-To: <20220119133110.24901-1-sj@kernel.org>
Message-ID: <7afca3b5-626a-8356-aa73-b378f5aa7a3c@google.com>
References: <20220119133110.24901-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="447496086-1972156286-1642978116=:236780"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--447496086-1972156286-1642978116=:236780
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 19 Jan 2022, SeongJae Park wrote:

> User-space Policy or In-kernel Policy?  Both.
> =============================================
> 
> When discussing about a sort of kernel involved system efficiency
> optimizations, I show two kinds of people who have slightly different opinions.
> The first party prefer to implement only simple but efficient mechanisms in the
> kernel and export it to user space, so that users can make smart user space
> policy.  Meanwhile, the second party prefer the kernel just works.  I agree
> with both parties.
> 

Thanks for starting this discussion, SeongJae, and kicking it off with all 
of your roadmap thoughts.  It's very helpful.

I would love for this to turn into an active discussion amongst those 
people who are currently looking into using DAMON for their set of 
interests and also those who are investigating how its current set of 
support can be adapated for their use cases.

For discussion on where the kernel and userspace boundary lies for policy 
decisions, I think it depends heavily on (1) the specific subcomponent of 
the mm subsystem being discussed, I don't think this boundary will be the 
same for all areas (and can/will evolve over time), and (2) the difference  
between the base out-of-the-box behavior that Linux provides for everybody 
and the elaborate support that some users need for efficiency or 
performance.  This is going to be very different for things like hugepage 
optimizations and memory compaction, for example.

> I think the first opinion makes sense as there are some valuable information
> that only user space can know.  I think only such approaches could achieve the
> ultimate efficiency in such cases.
> I also agree to the second party, though, because there could be some people
> who don't have special information that only their applications know, or
> resources to do the additional work.  In-kernel simple policies will be still
> beneficial for some users even though those are sub-optimal compared to the
> highly tuned user space policy, if it provides some extent of efficiency gain
> and no regressions for most cases.
> 
> I'd like to help both.  For the reason, I made DAMON as an in-kernel mechanism
> for both user and kernel-space policies.  It provides highly tunable general
> user space interface to help the first party.  It also provides in-kernel
> policies which built on top of DAMON using its kernel-space API for specific
> common use cases with conservative default parameters that assumed to incur no
> regression but some extent of benefits in most cases, namely DAMON-based
> proactive reclamation.  I will continue pursuing the two ways.
> 

Are you referring only to root userspace here or are you including 
non-root userspace?

Imagine a process that is willing to accept the cpu overhead for doing thp 
collapse for portions of its memory in process context rather than waiting 
for khugepaged and that we had a mechanism (discussed later) for doing 
that in the kernel.  The non-root user in this case would need the ability 
to monitor regions of its own heap, for example, and disregard others.  
The malloc implementation wants to answer the question of "what regions of 
my heap are accessed very frequently?" so that we can do hugepage 
optimizations.

Do you see that the user will have the ability to fork off a DAMON context 
to do this monitoring for their own heap?  kdamond could be attached to a 
cpu cgroup to charge the cpu overhead for doing this monitoring and the 
time spent applying any actions to that memory to that workload on a 
multi-tenant machine.

I think it would be useful to discuss the role of non-root userspace for 
future DAMON support.

> Imaginable DAMON-based Policies
> ===============================
> 
> I'd like to start from listing some imaginable data access-aware operation
> policies that I hope to eventually be made.  The list will hopefully shed light
> on how DAMON should be evolved to efficiently support the policies.
> 
> DAMON-based Proactive LRU-pages (de)Activation
> ----------------------------------------------
> 
> The reclamation mechanism which selects reclaim target using the
> active/inactive LRU lists sometimes doesn't work well.  According to my
> previous work, providing access pattern-based hints can significantly improve
> the performance under memory pressure[1,2].
> 
> Proactive reclamation is known to be useful for many memory intensive systems,
> and now we have a DAMON-based implementation of it[3].  However, the proactive
> reclamation wouldn't be so welcome to some systems having high cost of I/O.
> Also, even though the system runs proactive reclamation, memory pressure can
> still occasionally triggered.
> 
> My idea for helping this situation is manipulating the orders of pages in LRU
> lists using DAMON-provided monitoring results.  That is, making DAMON
> proactively finds hot/cold memory regions and moves pages of the hot regions to
> the head of the active list, while moving pages of the cold regions to the tail
> of the inactive list.  This will help eventual reclamation under memory
> pressure to evict cold pages first, so incur less additional page faults.
> 

Let's add Johannes Weiner <hannes@cmpxchg.org> into this discussion as 
well since we had previously discussed persistent background ordering of 
the lru lists based on hotness and coldness of memory before.  This 
discussion had happened before DAMON was merged upstream, so that DAMON 
has landed it is likely an area that he's interested in.

One gotcha with the above might be the handling of MADV_FREE memory that 
we want to lazily free under memory pressure.  Userspace has indicated 
that we can free this memory whenever necessary, so the kernel 
implementation moves this memory to the inactive lru regardless of any 
hotness or coldness of the memory.  In other words, this memory *can* have 
very high access frequencies in the short-term and then it's madvised with 
MADV_FREE by userspace to free if we encounter memory pressure.  It seems 
like this needs to override the DAMON-provided monitoring results since 
userspace just knows better in certain scenarios.

> [1] https://www.usenix.org/conference/hotstorage19/presentation/park
> [2] https://linuxplumbersconf.org/event/4/contributions/548/
> [3] https://docs.kernel.org/admin-guide/mm/damon/reclaim.html
> 
> DAMON-based THP Coalesce/Split
> ------------------------------
> 
> THP is know to significantly improve performance, but also increase memory
> footprint[1].  We can minimize the memory overhead while preserving the
> performance benefit by asking DAMON to provide MADV_HUGEPAGE-like hints for hot
> memory regions of >= 2MiB size, and MADV_NOHUGEPAGE-like hints for cold memory
> regions.  Our experimental user space policy implementation[2] of this idea
> removes 76.15% of THP memory waste while preserving 51.25% of THP speedup in
> total.
> 

This is a very interesting area to explore, and turns out to be very 
timely as well.  We'll soon be proposing the MADV_COLLAPSE support that we 
discussed here[1] and was well received.

One thought here is that with DAMON we can create a scheme to apply a 
DAMOS_COLLAPSE action on very hot memory in the monitoring region that 
would simply call into the new MADV_COLLAPSE code to allow us to do a 
synchronous collapse in process context.  With the current DAMON support, 
this seems very straight-forward once we have MADV_COLLAPSE.

[1] https://lore.kernel.org/all/d098c392-273a-36a4-1a29-59731cdf5d3d@google.com/

> [1] https://www.usenix.org/conference/osdi16/technical-sessions/presentation/kwon
> [2] https://damonitor.github.io/doc/html/v34/vm/damon/eval.html
> 
> DAMON-based Tiered Memory (Pro|De)motion
> ----------------------------------------
> 
> In tiered memory systems utilizing DRAM and PMEM[1], we can promote hot pages to
> DRAM and demote cold pages to PMEM using DAMON.  A patch for allowing
> access-aware demotion user space policy development is already submitted[2] by
> Baolin.
> 

Thanks for this, it's very useful.  Is it possible to point to any data on 
how responsive the promotion side can be to recent memory accesses?  It 
seems like we'll need to promote that memory quite quickly to not suffer 
long-lived performance degradations if we're treating DRAM and PMEM as 
schedulable memory.

DAMON provides us with a framework so that we have complete control over 
the efficiency of scanning PMEM for possible promotion candidates.  But 
I'd be very interested in seeing any data from Baolin (or anybody else) on 
just how responsive the promotion side can be.

> [1] https://www.intel.com/content/www/us/en/products/details/memory-storage/optane-memory.html
> [2] https://lore.kernel.org/linux-mm/cover.1640171137.git.baolin.wang@linux.alibaba.com/
> 
> DAMON-based Proactive Compaction
> --------------------------------
> 
> Compaction uses migration scanner to find migration source pages.  Hot pages
> would be more likely to be unmovable compared to cold pages, so it would be
> better to try migration of cold pages first.  DAMON could be used here.  That
> is, proactively monitoring accesses via DAMON and start compaction so that the
> migration scanner scan cold memory ranges first.  I should admit I'm not
> familiar with compaction code and I have no PoC data for this but just the
> groundless idea, though.
> 

Is compaction enlightenment for DAMON a high priority at this point, or 
would AutoNUMA be a more interesting candidate?

Today, AutoNUMA works with a sliding window setting page tables to have 
PROT_NONE permissions so that we induce a page fault and can determine 
which cpu is accessing potentially remote memory (task_numa_work()).  If 
that's happening, we can migrate the memory to the home NUMA node so that 
we can avoid those remote memory accesses and the increased latency that 
it induces.

Idea: if we enlightened task_numa_work() to prioritize hot memory using 
DAMON, it *seems* like this would be most effective rather than relying on 
a sliding window.  We want to migrate memory that is frequently being 
accessed to reduce the remote memory access latency, we only get a minimal 
improvement (mostly only node balancing) for memory that is rarely 
accessed.

I'm somewhat surprised this isn't one of the highest priorities, actually, 
for being enlightened with DAMON support, so it feels like I'm missing 
something obvious.

Let's also add Dave Hansen <dave.hansen@linux.intel.com> into the thread 
for the above two sections (memory tiering and AutoNUMA) because I know 
he's thought about both.

> How We Can Implement These
> --------------------------
> 
> Implementing most of the above mentioned policies wouldn't be too difficult
> because we have DAMON-based Operation Schemes (DAMOS).  That is, we will need
> to implement some more DAMOS action for each policy.  Some existing kernel
> functions can be reused.  Such actions would include LRU (de)activation, THP
> coalesce/split hints, memory (pro|de)motion, and cold pages first scanning
> compaction.  Then, supporting those actions with the user space interface will
> allows implementing user space policies.  If we find reasonably good default
> DAMOS parameters and some kernel side control mechanism, we can further make
> those as kernel policies in form of, say, builtin modules.
> 
> How DAMON Should Be Evolved For Supporting Those
> ================================================
> 
> Let's discuss what kind of changes in DAMON will be needed to efficiently
> support above mentioned policies.
> 
> Simultaneously Monitoring Different Types of Address Spaces
> -----------------------------------------------------------
> 
> It would be better to run all the above mentioned policies simultaneously on
> single system.  As some policies such as LRU-pages (de)activation would better
> to run on physical address space while some policies such as THP coalesce/split
> would need to run on virtual address spaces, DAMON should support concurrently
> monitoring different address spaces.  We can always do this by creating one
> DAMON context for each address space and running those.  However, as the
> address spaces will conflict, each other will be interfered.  Current idea for
> avoiding this is allowing multiple DAMON contexts to run on a single thread,
> forcing them to have same monitoring contexts.
> 
> Online Parameters Updates
> -------------------------
> 
> Someone would also want to dynamically turn on/off and/or tune each policy.
> This is impossible with current DAMON, because it prohibits updating any
> parameter while it is running.  We disallow the online parameters update
> mainly because we want to avoid doing additional synchronization between the
> running kdamond and the parameters updater.  The idea for supporting the use
> case while avoiding the additional synchronization is, allowing users to pause
> DAMON and update parameters while it is paused.
> 
> A Better DAMON interface
> ------------------------
> 
> DAMON is currently exposing its major functionality to the user space via the
> debugfs.  After all, DAMON is not for only debugging.  Also, this makes the
> interface depends on debugfs unnecessarily, and considered unreliable.  Also,
> the interface is quite unflexible for future interface extension.  I admit it
> was not a good choice.
> 
> It would be better to implement another reliable and easily extensible
> interface, and deprecate the debugfs interface.  The idea is exposing the
> interface via sysfs using hierarchical Kobjects under mm_kobject.  For example,
> the usage would be something like below:
> 
>     # cd /sys/kernel/mm/damon
>     # echo 1 > nr_kdamonds
>     # echo 1 > kdamond_1/contexts/nr_contexts
>     # echo va > kdamond_1/contexts/context_1/target_type
>     # echo 1 > kdamond_1/contexts/context_1/targets/nr_targets
>     # echo $(pidof <workload>) > \
>                     kdamond_1/contexts/context_1/targets/target_1/pid
>     # echo Y > monitor_on
> 
> The underlying files hierarchy could be something like below.
> 
>     /sys/kernel/mm/damon/
>     │ monitor_on
>     │ kdamonds
>     │ │ nr_kdamonds
>     │ │ kdamond_1/
>     │ │ │ kdamond_pid
>     │ │ │ contexts
>     │ │ │ │ nr_contexts
>     │ │ │ │ context_1/
>     │ │ │ │ │ target_type (va | pa)
>     │ │ │ │ │ attrs/
>     │ │ │ │ │ │ intervals/sampling,aggr,update
>     │ │ │ │ │ │ nr_regions/min,max
>     │ │ │ │ │ targets/
>     │ │ │ │ │ │ nr_targets
>     │ │ │ │ │ │ target_1/
>     │ │ │ │ │ │ │ pid
>     │ │ │ │ │ │ │ init_regions/
>     │ │ │ │ │ │ │ │ region1/
>     │ │ │ │ │ │ │ │ │ start,end
>     │ │ │ │ │ │ │ │ ...
>     │ │ │ │ │ │ ...
>     │ │ │ │ │ schemes/
>     │ │ │ │ │ │ nr_schemes
>     │ │ │ │ │ │ scheme_1/
>     │ │ │ │ │ │ │ action
>     │ │ │ │ │ │ │ target_access_pattern/
>     │ │ │ │ │ │ │ │ sz/min,max
>     │ │ │ │ │ │ │ │ nr_accesses/min,max
>     │ │ │ │ │ │ │ │ age/min,max
>     │ │ │ │ │ │ │ quotas/
>     │ │ │ │ │ │ │ │ ms,bytes,reset_interval
>     │ │ │ │ │ │ │ │ prioritization_weights/
>     │ │ │ │ │ │ │ │   sz,nr_accesses,age
>     │ │ │ │ │ │ │ watermarks/
>     │ │ │ │ │ │ │   metric,check_interval,high,mid,low
>     │ │ │ │ │ │ │ stats/
>     │ │ │ │ │ │ │ │ quota_exceeds
>     │ │ │ │ │ │ │ │ tried/nr,sz
>     │ │ │ │ │ │ │ │ applied/nr,sz
>     │ │ │ │ │ │ │ ...
>     │ │ │ │ ...
>     │ │ ...
> 
> More DAMON Future Works
> =======================
> 
> In addition to above mentioned things, there are many works to do.  It would be
> better to extend DAMON for more use cases and address spaces support, including
> page granularity, idleness only, read/write only, page cache only, and cgroups
> monitoring supports.
> 

Cgroup support is very interesting so that we do not need to constantly 
maintain a list of target_ids when a job forks new processes.  We've 
discussed the potential for passing a cgroup inode as the target rather 
than pid for virtual address monitoring that would operate over the set of 
processes attached to that cgroup hierarchy.  Is this what you imagine for 
cgroup support or something more elaborate (or something different 
entirely :)?

> Also it would be valuable to improve the accuracy of monitoring, using some
> adaptive monitoring attributes tuning or some new fancy idea[1].
> 
> DAMOS could also be improved by utilizing its own autotuning feature, for
> example, by monitoring PSI and other metrics related to the given action.
> 
> [1] https://linuxplumbersconf.org/event/11/contributions/984/
> 

I'd like to add another topic here: DAMON based monitoring for virtualized 
workloads.  Today, it seems like you'd need to run DAMON in the guest to 
be able to describe its working set.  Monitoring the hypervisor process 
is inadequate because it will reveal the first access to the guest owned 
memory but not the accesses done by the guest itself.  So it seems like 
the *current* support for virtual address monitoring is insufficient 
unless the guest is enlightened to do DAMON monitoring itself.

What about unenlightened guests?  An idea is a third DAMON monitoring mode 
that monitors accesses in the EPT.  Have you thought about this before or 
other ways to monitor memory access for an *unenlightened* guest?  Would 
love to have a discussion on this.
--447496086-1972156286-1642978116=:236780--
