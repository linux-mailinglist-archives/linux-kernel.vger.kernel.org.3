Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57344D70FC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 22:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbiCLVNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 16:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiCLVNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 16:13:08 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C845F13CA18
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 13:12:01 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id i26so5123661uap.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 13:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmaNFIiscku3tS/xD5UC1C/JgygtKyzM5W8JKBuCT3I=;
        b=cO4+5L7+U0LOD1YIeSj4zNu8poz/0KJ/pC2cXp7RPbF1nkd2snBByuowOKB44Qo7p3
         9zvOyHXjeos24Boge1HzyhWyDMZLAtgjqb1uTrEfaQBThYegpH4JNVbf6ssFHxDF5Th/
         MvsaE57WVZZaWUOZPiaFdCcDAIDsfEK+KAUVIA5bwPSvGOL9ttB2F1pm2728ZWM+zMBy
         Zc1kULeqycAY1dZOxfpDrze/cnO7Fo7GNxlqDwH0pWyHmh6lLuRpbkCtMSx5jd6+OuAs
         RMXyKhhqW//JNLm9c0ekiDL1rhJnnx851kMaD0CiXHkImgiSVTQ4NyISpFXFc2w5zjMz
         UGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmaNFIiscku3tS/xD5UC1C/JgygtKyzM5W8JKBuCT3I=;
        b=UJPXlCmUdaIB19nq5RiQejQd1caTY9n8S2dAK2VmlLilLheCCBephx6BajOVNnTfm4
         8E5xkyXuptB17E5Xy2hwtaWB99LYE7/uIuKOUSB7YSQV9XabwWmzKDlx85xpJmev/hLL
         /4bD4pCwyNJY2GlJ8wq4Xc1/E0tAsTiVVmk5Qj5LMqIs23o6ROOn0EgQDlK9uZxh4xbY
         vhQKJHky5wkR9RY7JZ81d6hTrDsXa7aa49mR80uLtJuHZTtuBj29kq3SY+TXsdjEV0cy
         6WV6W5VBMVyIQZX8we73SfnIhi8EJ7geUDEZINkbaysDeFY2mQNJY+UWXGiJbUjH2TlQ
         xkRg==
X-Gm-Message-State: AOAM530L+gUVDFFPxp1t/KSyQ0u2z1sgMeyZaKdFREpP0CHxD07FkFFg
        5L+ifH43CZo5gnBSTTOs/c9CeskyXMVdSvZvN/gyyg==
X-Google-Smtp-Source: ABdhPJwR0ejiRho0niQPXNJ9GfInLdKiPERuTSORrlU0cz/IQfgXdMuJC63SRpcHmox99ZhbWBpVchHyDxnuT2cBVEo=
X-Received: by 2002:ab0:7a52:0:b0:349:f76d:4cfe with SMTP id
 a18-20020ab07a52000000b00349f76d4cfemr6845942uat.1.1647119520675; Sat, 12 Mar
 2022 13:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com> <20220208081902.3550911-5-yuzhao@google.com>
 <YgV4lZXc6+jhUdsR@cmpxchg.org> <Ygt1qaQM5YobEZK9@google.com>
 <CAGsJ_4wN_CAOsyR3LATE+EUhuV0gO-zhhNiMwEBwyXOp0CbkZg@mail.gmail.com>
 <CAOUHufaUJD8nC6PDVfmkeTwB4BtzBzigxh+V-hfR-_26VwjOPA@mail.gmail.com> <CAGsJ_4zT7gtGSEoAay=VE6x_YZkNKtLymRL94pBnVgKekPzxaQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zT7gtGSEoAay=VE6x_YZkNKtLymRL94pBnVgKekPzxaQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 12 Mar 2022 14:11:49 -0700
Message-ID: <CAOUHufbor4L5OfjNFEMcaM5bXnM9VWXw-LK9A04vP65rkcLNMg@mail.gmail.com>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
To:     Barry Song <21cnbao@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 3:37 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Sat, Mar 12, 2022 at 12:45 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Fri, Mar 11, 2022 at 3:16 AM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > On Tue, Feb 15, 2022 at 10:43 PM Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > On Thu, Feb 10, 2022 at 03:41:57PM -0500, Johannes Weiner wrote:
> > > >
> > > > Thanks for reviewing.
> > > >
> > > > > > +static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
> > > > > > +{
> > > > > > +   unsigned long max_seq = lruvec->lrugen.max_seq;
> > > > > > +
> > > > > > +   VM_BUG_ON(gen >= MAX_NR_GENS);
> > > > > > +
> > > > > > +   /* see the comment on MIN_NR_GENS */
> > > > > > +   return gen == lru_gen_from_seq(max_seq) || gen == lru_gen_from_seq(max_seq - 1);
> > > > > > +}
> > > > >
> > > > > I'm still reading the series, so correct me if I'm wrong: the "active"
> > > > > set is split into two generations for the sole purpose of the
> > > > > second-chance policy for fresh faults, right?
> > > >
> > > > To be precise, the active/inactive notion on top of generations is
> > > > just for ABI compatibility, e.g., the counters in /proc/vmstat.
> > > > Otherwise, this function wouldn't be needed.
> > >
> > > Hi Yu,
> > > I am still quite confused as i am seeing both active/inactive and lru_gen.
> > > eg:
> > >
> > > root@ubuntu:~# cat /proc/vmstat | grep active
> > > nr_zone_inactive_anon 22797
> > > nr_zone_active_anon 578405
> > > nr_zone_inactive_file 0
> > > nr_zone_active_file 4156
> > > nr_inactive_anon 22800
> > > nr_active_anon 578574
> > > nr_inactive_file 0
> > > nr_active_file 4215
> >
> > Yes, this is expected. We have to maintain the ABI, i.e., the
> > *_active/inactive_* counters.
> >
> > > and:
> > >
> > > root@ubuntu:~# cat /sys//kernel/debug/lru_gen
> > >
> > > ...
> > > memcg    36 /user.slice/user-0.slice/user@0.service
> > >  node     0
> > >          20      18820         22           0
> > >          21       7452          0           0
> > >          22       7448          0           0
> > > memcg    33 /user.slice/user-0.slice/user@0.service/app.slice
> > >  node     0
> > >           0    2171452          0           0
> > >           1    2171452          0           0
> > >           2    2171452          0           0
> > >           3    2171452          0           0
> > > memcg    37 /user.slice/user-0.slice/session-1.scope
> > >  node     0
> > >          42      51804     102127           0
> > >          43      18840     275622           0
> > >          44      16104     216805           1
> > >
> > > Does it mean one page could be in both one of the generations and one
> > > of the active/inactive lists?
> >
> > In terms of the data structure, evictable pages are either on
> > lruvec->lists or lrugen->lists.
> >
> > > Do we have some mapping relationship between active/inactive lists
> > > with generations?
> >
> > For the counters, yes -- pages in max_seq and max_seq-1 are counted as
> > active, and the rest are inactive.
> >
> > > We used to put a faulted file page in inactive, if we access it a
> > > second time, it can be promoted
> > > to active. then in recent years, we have also applied this to anon
> > > pages while kernel adds
> > > workingset protection for anon pages. so basically both anon and file
> > > pages go into the inactive
> > > list for the 1st time, if we access it for the second time, they go to
> > > the active list. if we don't access
> > > it any more, they are likely to be reclaimed as they are inactive.
> > > we do have some special fastpath for code section, executable file
> > > pages are kept on active list
> > > as long as they are accessed.
> >
> > Yes.
> >
> > > so all of the above concerns are actually not that correct?
> >
> > They are valid concerns but I don't know any popular workloads that
> > care about them.
>
> Hi Yu,
> here we can get a workload in Kim's patchset while he added workingset
> protection
> for anon pages:
> https://patchwork.kernel.org/project/linux-mm/cover/1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com/

Thanks. I wouldn't call that a workload because it's not a real
application. By popular workloads, I mean applications that the
majority of people actually run on phones, in cloud, etc.

> anon pages used to go to active rather than inactive, but kim's patchset
> moved to use inactive first. then only after the anon page is accessed
> second time, it can move to active.

Yes. To clarify, the A-bit doesn't really mean the first or second
access. It can be many accesses each time it's set.

> "In current implementation, newly created or swap-in anonymous page is
>
> started on the active list. Growing the active list results in rebalancing
> active/inactive list so old pages on the active list are demoted to the
> inactive list. Hence, hot page on the active list isn't protected at all.
>
> Following is an example of this situation.
>
> Assume that 50 hot pages on active list and system can contain total
> 100 pages. Numbers denote the number of pages on active/inactive
> list (active | inactive). (h) stands for hot pages and (uo) stands for
> used-once pages.
>
> 1. 50 hot pages on active list
> 50(h) | 0
>
> 2. workload: 50 newly created (used-once) pages
> 50(uo) | 50(h)
>
> 3. workload: another 50 newly created (used-once) pages
> 50(uo) | 50(uo), swap-out 50(h)
>
> As we can see, hot pages are swapped-out and it would cause swap-in later."
>
> Is MGLRU able to avoid the swap-out of the 50 hot pages?

I think the real question is why the 50 hot pages can be moved to the
inactive list. If they are really hot, the A-bit should protect them.

> since MGLRU
> is putting faulted pages to the youngest generation directly, do we have the
> risk mentioned in Kim's patchset?

There are always risks :) I could imagine a thousand ways to make VM
suffer, but all of them could be irrelevant to how it actually does in
production. So a concrete use case of yours would be much appreciated
for this discussion.
