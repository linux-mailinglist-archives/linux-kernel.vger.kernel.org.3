Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1105E4F51EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454929AbiDFC1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243774AbiDEVTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:19:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5017E15D380
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:59:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c23so234528plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 13:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ir90/ehZQY+wZoZPaeLh10ytdSEi+dbd6tS/abe+rt4=;
        b=J4Nhvgr1FO62x943DLcJTl0Jjjp3VyNlHbfgMDfkqShHMBGgLPlnUtZo9brDhvkFDg
         nggzZYvIb+9PCqiWGuaBlfAqMtM36uQmLTvCAMbxh+S+edvSjHJrs6uZM2vftK3AlRG3
         vV8jxErSEhYoscDz8m8k+mU6CWajSv+d3T6QG8KzjhplHYoA1hFBRuTbwmb746LxHSog
         ldCIHwFyJo0lsCjUEcecHXEBiyZ7cTaCAAb2MKTarDMtpRe84+d1xSUhkuNXnzMaJDsy
         h8QRZ+Z6ZfzdzkMkibXUPifO4ER1daJjMlVSmwxUnNRR8tq5gc4iLe4anAHuPIfFcf3b
         Atzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ir90/ehZQY+wZoZPaeLh10ytdSEi+dbd6tS/abe+rt4=;
        b=WU5gK3LfOSgN6rUmik/ngJuXC3lLy6Tp7LN7NCz6bcc9pe7mVxZdJzzcDGJ37jxLI+
         aFPj8QtwfshfNb/aWkL0qTlgQdg+FtMs+ZpZ293qJn/kIhwnJMS8UOmAnO/ypB5YwiLw
         AMrzAdY/8Dz5hl1m1fbsMgqjK9IsTTZdKZkKNa1cV6IN86KF7dWkyRmvql/L+YZvG9Jv
         7mnD0/MUl+ZEJyxOEcx0nufFs4OqwJDRIT2/Suw/og1UMbRflrB19OtkcDd9geU8qEMD
         aqt0ju7Ct6CD7CNGSmQhGCVfgeqpPD2iQhHgV/wVaWWQtVDJM5D7pmXQ5hddZnpktSsz
         BxZw==
X-Gm-Message-State: AOAM5330+9o+KlqpBGH/6wd8JnH8wYkIB+WgPG/usDWQbUSkvNH2b5v7
        bmNYI809ePmPDzsVKB28aPHtACcc/CD3GpgcFX4=
X-Google-Smtp-Source: ABdhPJz6Q6kDQINwI5ynGqCU0z/9Kj/zGeig7sz9Nu9dCD5gESHSzN5CpNuVPrlZpOZLcrbC7CniQ1a/1NXszXOQGCY=
X-Received: by 2002:a17:90a:5296:b0:1ca:78cc:7172 with SMTP id
 w22-20020a17090a529600b001ca78cc7172mr6261625pjh.99.1649192351065; Tue, 05
 Apr 2022 13:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220402072103.5140-1-hdanton@sina.com> <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area> <YktCKVbChtC+YjOk@carbon.dhcp.thefacebook.com>
 <20220405051710.GW1609613@dread.disaster.area> <Ykxv1j9dxlz1BS5N@carbon.dhcp.thefacebook.com>
In-Reply-To: <Ykxv1j9dxlz1BS5N@carbon.dhcp.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 5 Apr 2022 13:58:59 -0700
Message-ID: <CAHbLzko=bjLhhJXjcs0Uh-g3x9vV1gQZjEU2JqxVehqSb1UGkQ@mail.gmail.com>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Dave Chinner <david@fromorbit.com>,
        Hillf Danton <hdanton@sina.com>, MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 9:36 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Tue, Apr 05, 2022 at 03:17:10PM +1000, Dave Chinner wrote:
> > On Mon, Apr 04, 2022 at 12:08:25PM -0700, Roman Gushchin wrote:
> > > On Mon, Apr 04, 2022 at 11:09:48AM +1000, Dave Chinner wrote:
> > > > i.e. the amount of work that shrinkers need to do in a periodic scan
> > > > is largerly determined by the rate of shrinkable cache memory usage
> > > > growth rather than memory reclaim priority as it is now. Hence there
> > > > needs to be different high level "shrinker needs to do X amount of
> > > > work" calculation for periodic reclaim than there is now.
> > > >
> > > > e.g. we calculate a rolling average of the size of the cache and a
> > > > rate of change over a series of polling operations (i.e. calling
> > > > ->scan_count) and then when sustained growth is detected we start
> > > > trying to shrink the cache to limit the rate of growth of the cache.
> > > >
> > > > If the cache keeps growing, then it's objects are being repeatedly
> > > > referenced and it *should* keep growing. If it's one-off objects
> > > > that are causing the growth of the cache and so objects are being
> > > > reclaimed by the shrinker, then matching the periodic shrink scan to
> > > > the growth rate will substantially reduce the rate of growth of that
> > > > cache.
> > >
> > > A clever idea!
> > >
> > > It seems like we need to add some stats to the list_lru API or maybe to
> > > the shrinker API (and let list_lru to use it).
> > > E.g. total/scanned/reclaimed, maybe with a time decay
> > >
> > > I'm also thinking about:
> > > 1) adding a sysfs/debugfs interface to expose shrinkers current size and
> > >    statistics, with an ability to call into the reclaim manually.
> >
> > I've thought about it, too, and can see where it could be useful.
> > However, when I consider the list_lru memcg integration, I suspect
> > it becomes a "can't see the forest for the trees" problem. We're
> > going to end up with millions of sysfs objects with no obvious way
> > to navigate, iterate or search them if we just take the naive "sysfs
> > object + stats per list_lru instance" approach.
>
> Ok, I'll try to master something and share patches. I assume it would be useful
> to have statistics and be able to trigger a reclaim of a particular shrinker
> without creating a real memory pressure. I anticipate many interesting
> findings in the implementation of individual shrinkers...
>
> >
> > Also, if you look at commit 6a6b7b77cc0f mm: ("list_lru: transpose the
> > array of per-node per-memcg lru lists") that went into 5.18-rc1,
> > you'll get an idea of the amount of memory overhead just tracking
> > the list_lru x memcg infrastructure consumes at scale:
> >
> >     I had done a easy test to show the optimization.  I create 10k memory
> >     cgroups and mount 10k filesystems in the systems.  We use free command to
> >     show how many memory does the systems comsumes after this operation (There
> >     are 2 numa nodes in the system).
> >
> >             +-----------------------+------------------------+
> >             |      condition        |   memory consumption   |
> >             +-----------------------+------------------------+
> >             | without this patchset |        24464 MB        |
> >             +-----------------------+------------------------+
> >             |     after patch 1     |        21957 MB        | <--------+
> >             +-----------------------+------------------------+          |
> >             |     after patch 10    |         6895 MB        |          |
> >             +-----------------------+------------------------+          |
> >             |     after patch 12    |         4367 MB        |          |
> >             +-----------------------+------------------------+          |
> >                                                                         |
> >             The more the number of nodes, the more obvious the effect---+
>
> Yes, I know, I've reviewed this patchset. However, 10k cgroups _and_ 10k
> mounts look a bit artificial. It's hard to believe that there are 100M
> LRUs containing hot objects. If most of them are cold, it's actually
> a question how to efficiently reclaim them and free the wasted memory.
>
> >
> > If we now add sysfs objects and stats arrays to each of the
> > list_lrus that we initiate even now on 5.18-rc1, we're going to
> > massively blow out the memory footprint again.
>
> sysfs can be a config option, it doesn't have to be enabled in prod.
> But I agree, because of memory constraints we're very limited in the size
> of statistics which can be used for reclaim decisions.
>
> >
> > So, nice idea, but I'm not sure we can make it useful and not
> > consume huge amounts of memory....
> >
> > What might be more useful is a way of getting the kernel to tell us
> > what the, say, 20 biggest slab caches are in the system and then
> > provide a way to selectively shrink them. We generally don't really
> > care about tiny caches, just the ones consuming all the memory. This
> > isn't my idea - Kent has been looking at this because of how useless
> > OOM kill output is for debugging slab cache based OOM triggers. See
> > this branch for an example:
> >
> > https://evilpiepirate.org/git/bcachefs.git/log/?h=shrinker_to_text
> >
> > Even a sysfs entry that you echo a number into and it returns
> > the "top N" largest LRU lists. echo -1 into it and it returns every
> > single one if you want all the information.
> >
> > The whole "one sysfs file, one value" architecture falls completely
> > apart when we might have to indexing *millions* of internal
> > structures with many parameters per structure...
>
> It's a good point, I need to think what can we do here.
>
> Actually, if it's so hard and inefficient for a sysfs interface,
> it also means it's inefficient for the reclaim path. So if we have
> an ability to quickly find beefy LRU lists worth shrinking, it might
> improve the reclaim efficiency too.
>
> Actually, thinking of reducing the memory footprint, it would be great
> to combine LRU's belonging to different superblocks (of the same type).
> Pagecache analogy: we have an LRU for all pagecache pages, it's not
> per-file or per-sb. Not sure how easy/viable it is.
>
> >
> > > 2) formalizing a reference bit/counter API on the shrinkers level, so that
> > >    shrinker users can explicitly mark objects (re)-"activation".
> >
> > Not 100% certain what you are refering to here - something to do
> > with active object rotation? Or an active/inactive list split with period
> > demotion like we have for the page LRUs? Or workingset refault
> > detection? Can you explain in more detail?
>
> It's a vague thinking at this point, but you got me right, I was thinking about
> all the listed ideas above. In general I'm trying to understand whether
> the existing model is sufficient for a more or less effective management
> of hot/cold objects and if we can improve it borrowing some ideas from
> the page reclaim code.
> Shadow entries would be great but likely not possible because of the memory
> footprint.
>
> >
> > > 3) _maybe_ we need to change the shrinkers API from a number of objects to
> > >    bytes, so that releasing a small number of large objects can compete with
> > >    a releasing on many small objects. But I'm not sure.
> >
> > I think I suggested something similar a long time ago. We have
> > shrinkers that track things other than slab objects. e.g. IIRC the
> > ttm graphics allocator shrinker tracks sets of pages and frees
> > pages, not slab objects. The XFS buffer cache tracks variable sized
> > objects, from 512 bytes to 64KB in length, so the amount of memory
> > it frees is variable even if the number of handles it scans and
> > reclaims is fixed and consistent. Other subsystems have different
> > "non object" shrinker needs as well.
>
> It's true for many objects, because it's not unusual for kernel objects
> to have attached kmallocs or pin other objects in the memory. Unlikely
> we can be 100% accurate, but we might improve the "smoothness" of the
> reclaim process.
>
> >
> > The long and short of it is that two shrinkers might have the same
> > object count, but one might free 10x the amount of memory than the
> > other for the same amount of shrinking work. Being able to focus
> > reclaim work on caches that can free a lot of memory much more
> > quickly would be a great idea.
>
> Right. It's also about "bytes freed/seeks" ratio. Why would we reclaim
> expensive small objects if there are big and cheap.
>
> >
> > It also means that a shrinker that scans a fragmented slab can keep
> > going until a set number of slab pages have been freed, rather than
> > a set number of slab objects. We can push reclaim of fragmented slab
> > caches much harder when necessary if we are reclaiming by freed byte
> > counts...
>
> I thought about it, but it's tricky. If all slabs are almost full (fragmentation
> is low), we want to shrink aggressively, otherwise we end up allocating
> more slabs and fragmenting more memory. If slabs are almost empty (fragmentation
> is very high), we also want to shrink more aggressively with a hope to release
> physical memory, as you said. But setting a target in pages is dangerous: slab caches
> can be merged or slab pages can be pinned by objects belonging to a different
> memory cgroup, so it might be not possible to reclaim pages no matter how hard
> we're trying.

Yeah, I agree it actually doesn't make too much sense to return the
number of reclaimed objects. Other part of vmscan returns the number
of base pages, the sizes of slab objects are varied, it may be much
smaller than a page, for example, dentry may be 192 bytes.

Another problem which doesn't help the feedback loop is even though
bytes is returned instead of the number of objects, it doesn't mean
that much memory is actually freed and available for allocation. IMHO
the number of really freed pages should be returned (I do understand
it is not that easy for now), and returning 0 should be fine. The
current logic (returning the number of objects) may feed up something
over-optimistic. I, at least, experienced once or twice that a
significant amount of slab caches were shrunk, but actually 0 pages
were freed actually. TBH the new slab controller may make it worse
since the page may be pinned by the objects from other memcgs.

>
> >
> > So, yeah, byte-count based reclaim definitely has merit compared to
> > what we currently do. It's more generic and more flexible...
>
> Great, I'm glad we're on the same page here.
>
> Thank you for the answers, I think it's a really useful discussion!
>
> Roman
>
