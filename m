Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8998510AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355197AbiDZVBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355187AbiDZVBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:01:02 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38564926F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:57:52 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id p1so4433806uak.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acSONY7PP2jxfx8qQHXfWpOHe20HF0xIP8aPzje00+M=;
        b=JpNU2w+DsXQSncx5zG+Ikno8ZWXS25SA6eFSzK6/TW3MxvGsN8ddRCtT/YaZM3xt0F
         gaJJMy5bD4/gXwhwYtaKTdGcwgb5l1EX+cC3STdJCqdoid8BcTt/Ac1JU4mo71qBFscX
         KKf58dnBkUP4FXIcESPAy9AkO25CiIZCUrBcg0mJafNTeTbBgr7j2vFSSyK8c3DSX3GK
         mQoiDCvTyffrIGGuRHAF0SkZgSQ+iYF3+7/VHtflGihitBqY1xEHACdj5DFTMZGpr5aP
         TZ+vU9SHqT0eg6IW8kp0IwNrHi2QNPWmwJhrg5Mro8+0jozhjwgc5ifw9MYPNvDYOhW9
         j0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acSONY7PP2jxfx8qQHXfWpOHe20HF0xIP8aPzje00+M=;
        b=UFdHJ+dxLPSZoCV4RXJXc/4ar4DBGAzOxj8+nBWh/3t+C5/G1vbVteLuP8prlvGBVD
         xzoDAUugLbnR2X5Ttmre+kHTgDfJCJeX8PpHs6ksXz5eJDqiYITaVRoppMgI6gZMIEQl
         SxdB/JhoxIugLbo1QZVnzbX1+1dwp9zPEu/9Qcw9zFbPYo2ArtmE439uaFbrr27e9QeL
         krgRbHbYZG7wDGoEpCjHWPLtxuePW5C5JOSOuSceEPU3XbO6C8TZFWuCyKpkLCupXoTU
         mNuJHbVQWgnu3/Q5Bf0PV01hc1ui8Rpz2GTuRWfzJFWOKJxdjXOcfaUvLRhDsMvhwjcL
         gN5g==
X-Gm-Message-State: AOAM530CAa81x6kL5UPabtGwYi2CYCm1VbNV4ZZgTbWcRGRXXr0eKD/b
        AYeZV49YesaKtVXEAxkHS0t8w+SHG7ScK2kPpui9iQ==
X-Google-Smtp-Source: ABdhPJy5myAb5fqj4bnCfcgkTFURiD2z7LFGeZlFl3dLh4JqOCbjKAEjQx0QB9WUjBvY6m/QWrutDjviJulyK20Kdmk=
X-Received: by 2002:ab0:2008:0:b0:352:2b3a:6bce with SMTP id
 v8-20020ab02008000000b003522b3a6bcemr7833585uak.19.1651006671757; Tue, 26 Apr
 2022 13:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-11-yuzhao@google.com>
 <20220411191627.629f21de83cd0a520ef4a142@linux-foundation.org>
In-Reply-To: <20220411191627.629f21de83cd0a520ef4a142@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 26 Apr 2022 14:57:15 -0600
Message-ID: <CAOUHufbtFj0Hez7wkw3DHGDwo6wudCzCvACt2GfgrFcubW_DYg@mail.gmail.com>
Subject: Re: [PATCH v10 10/14] mm: multi-gen LRU: kill switch
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 8:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  6 Apr 2022 21:15:22 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > Add /sys/kernel/mm/lru_gen/enabled as a kill switch. Components that
> > can be disabled include:
> >   0x0001: the multi-gen LRU core
> >   0x0002: walking page table, when arch_has_hw_pte_young() returns
> >           true
> >   0x0004: clearing the accessed bit in non-leaf PMD entries, when
> >           CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y
> >   [yYnN]: apply to all the components above
> > E.g.,
> >   echo y >/sys/kernel/mm/lru_gen/enabled
> >   cat /sys/kernel/mm/lru_gen/enabled
> >   0x0007
> >   echo 5 >/sys/kernel/mm/lru_gen/enabled
> >   cat /sys/kernel/mm/lru_gen/enabled
> >   0x0005
>
> I'm shocked that this actually works.  How does it work?  Existing
> pages & folios are drained over time or synchrnously?

Basically we have a double-throw way, and once flipped, new (isolated)
pages can only be added to the lists of the current implementation.
Existing pages on the lists of the previous implementation are
synchronously drained (isolated and then re-added), with
cond_resched() of course.

> Supporting
> structures remain allocated, available for reenablement?

Correct.

> Why is it thought necessary to have this?  Is it expected to be
> permanent?

This is almost a must for large scale deployments/experiments.

For deployments, we need to keep fix rollout (high priority) and
feature enabling (low priority) separate. Rolling out multiple
binaries works but will make the process slower and more painful. So
generally for each release, there is only one binary to roll out, and
unless it's impossible, new features are disabled by default. Once a
rollout completes, i.e., reaches enough population and remains stable,
new features are turned on gradually. If something goes wrong with a
new feature, we turn off that feature rather than roll back the
kernel.

Similarly, for A/B experiments, we don't want to use two binaries.


> > NB: the page table walks happen on the scale of seconds under heavy
> > memory pressure, in which case the mmap_lock contention is a lesser
> > concern, compared with the LRU lock contention and the I/O congestion.
> > So far the only well-known case of the mmap_lock contention happens on
> > Android, due to Scudo [1] which allocates several thousand VMAs for
> > merely a few hundred MBs. The SPF and the Maple Tree also have
> > provided their own assessments [2][3]. However, if walking page tables
> > does worsen the mmap_lock contention, the kill switch can be used to
> > disable it. In this case the multi-gen LRU will suffer a minor
> > performance degradation, as shown previously.
> >
> > Clearing the accessed bit in non-leaf PMD entries can also be
> > disabled, since this behavior was not tested on x86 varieties other
> > than Intel and AMD.
> >
> > ...
> >
> > --- a/include/linux/cgroup.h
> > +++ b/include/linux/cgroup.h
> > @@ -432,6 +432,18 @@ static inline void cgroup_put(struct cgroup *cgrp)
> >       css_put(&cgrp->self);
> >  }
> >
> > +extern struct mutex cgroup_mutex;
> > +
> > +static inline void cgroup_lock(void)
> > +{
> > +     mutex_lock(&cgroup_mutex);
> > +}
> > +
> > +static inline void cgroup_unlock(void)
> > +{
> > +     mutex_unlock(&cgroup_mutex);
> > +}
>
> It's a tad rude to export mutex_lock like this without (apparently)
> informing its owner (Tejun).

Looping in Tejun.

> And if we're going to wrap its operations via helper fuctions then
>
> - presumably all cgroup_mutex operations should be wrapped and
>
> - exiting open-coded operations on this mutex should be converted.

I wrapped cgroup_mutex here because I'm not a big fan of #ifdefs
(CONFIG_CGROUPs). Internally for cgroup code, it seems superfluous to
me to use these wrappers, e.g., for developers who work on cgroup
code, they might not be interested in looking up these wrappers.

> > +static bool drain_evictable(struct lruvec *lruvec)
> > +{
> > +     int gen, type, zone;
> > +     int remaining = MAX_LRU_BATCH;
> > +
> > +     for_each_gen_type_zone(gen, type, zone) {
> > +             struct list_head *head = &lruvec->lrugen.lists[gen][type][zone];
> > +
> > +             while (!list_empty(head)) {
> > +                     bool success;
> > +                     struct folio *folio = lru_to_folio(head);
> > +
> > +                     VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
> > +                     VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
> > +                     VM_BUG_ON_FOLIO(folio_is_file_lru(folio) != type, folio);
> > +                     VM_BUG_ON_FOLIO(folio_zonenum(folio) != zone, folio);
>
> So many new BUG_ONs to upset Linus :(

I'll replace them with VM_WARN_ON_ONCE_FOLIO(), based on the previous
discussion.

> > +                     success = lru_gen_del_folio(lruvec, folio, false);
> > +                     VM_BUG_ON(!success);
> > +                     lruvec_add_folio(lruvec, folio);
> > +
> > +                     if (!--remaining)
> > +                             return false;
> > +             }
> > +     }
> > +
> > +     return true;
> > +}
> > +
> >
> > ...
> >
> > +static ssize_t store_enable(struct kobject *kobj, struct kobj_attribute *attr,
> > +                         const char *buf, size_t len)
> > +{
> > +     int i;
> > +     unsigned int caps;
> > +
> > +     if (tolower(*buf) == 'n')
> > +             caps = 0;
> > +     else if (tolower(*buf) == 'y')
> > +             caps = -1;
> > +     else if (kstrtouint(buf, 0, &caps))
> > +             return -EINVAL;
>
> See kstrtobool()

`caps` is not a boolean, hence the plural and the below.

> > +     for (i = 0; i < NR_LRU_GEN_CAPS; i++) {
> > +             bool enable = caps & BIT(i);
> > +
> > +             if (i == LRU_GEN_CORE)
> > +                     lru_gen_change_state(enable);
> > +             else if (enable)
> > +                     static_branch_enable(&lru_gen_caps[i]);
> > +             else
> > +                     static_branch_disable(&lru_gen_caps[i]);
> > +     }
> > +
> > +     return len;
> > +}
