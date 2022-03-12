Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480004D6E37
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 11:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiCLKi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 05:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCLKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:38:53 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5049610E052;
        Sat, 12 Mar 2022 02:37:47 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2dc348dab52so118544557b3.6;
        Sat, 12 Mar 2022 02:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1bd0GMikTEkuWaHRWz8cZoWjC5BnF6mI6Xq7ESbeM0=;
        b=D5OAwynWbOtXSOPxCNmXI21wxYKK8tWl5p9WpcvhaONPNhxVPy6WSAHKu8jz0JjHoL
         I3It/QS1ORaXhjqTkIwzmV4SQr/ckkJ8LARMq+c7lVonj3nEsSLExLmSyJSp6LPHvJ/J
         5l8Mh7bTmzVqHbUEtVpGgm7LNmxIN3kH99B3qif7NNptdxElHmEAp94HbOuPeYIecqWY
         /84AzZ9sR8BknA5s7dWlz1/jXVWHVOSh+RsADR8/Ic1oxQypGsgJ/uBKsGiVXYGpSvSF
         eD1lyMR3eMkGER8PgKH2mCAPXDkAlsYudANaLxiw0HaXMwYZPpvGu1wmAwAB/P3QV9GN
         2OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1bd0GMikTEkuWaHRWz8cZoWjC5BnF6mI6Xq7ESbeM0=;
        b=Ri1FNPpQpu7U+QmkuLBwEK3/HDPfKDr17Xdr90njByvuQwyUnjZUF+JSeHHHmKOs78
         O5MO0C3OlC6yya/uhjZVr3OdYW6Sfdq+EI+XQYXkNnZ8/O+qmbVgkSZX+s84zDtMHaGW
         N2bWs1SdHTxza5ZaK7C53P6ww50q81YDqb9yJ3JdpYYAsOHGDVUfd4hV7tyk1wFhooQj
         1EY9bF1oZO4KuMnEzWQaLZNb5rIX859vCFWRJa0SAYRNYsFRQVUnXicRyEH6swhZseY3
         bKfG9CjduYTtE4gUKkPU9GFarUrK8MHPOBqRK7bJERwnOUiqdVmbMyLQ1YtUBOZbdd/C
         55BQ==
X-Gm-Message-State: AOAM531HDEVoU//tFJN1xnE92IwiY2pXmzT0lC9pM6RBNA+GSaLHWWCu
        U/Wiu2DFiI87Pr3ojmlXZJWZd0ipMdj01DGTeYY=
X-Google-Smtp-Source: ABdhPJzg7xAB7h8JW4bHsV019kKs7xGRffKUSBEupdCX+zGWN1izM4TaZn6FHw5ryHhJTcpFCl2QEYhz/1eV8RSpszk=
X-Received: by 2002:a81:1658:0:b0:2dc:5e3b:488d with SMTP id
 85-20020a811658000000b002dc5e3b488dmr11866621yww.399.1647081466454; Sat, 12
 Mar 2022 02:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com> <20220208081902.3550911-5-yuzhao@google.com>
 <YgV4lZXc6+jhUdsR@cmpxchg.org> <Ygt1qaQM5YobEZK9@google.com>
 <CAGsJ_4wN_CAOsyR3LATE+EUhuV0gO-zhhNiMwEBwyXOp0CbkZg@mail.gmail.com> <CAOUHufaUJD8nC6PDVfmkeTwB4BtzBzigxh+V-hfR-_26VwjOPA@mail.gmail.com>
In-Reply-To: <CAOUHufaUJD8nC6PDVfmkeTwB4BtzBzigxh+V-hfR-_26VwjOPA@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 12 Mar 2022 23:37:35 +1300
Message-ID: <CAGsJ_4zT7gtGSEoAay=VE6x_YZkNKtLymRL94pBnVgKekPzxaQ@mail.gmail.com>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
To:     Yu Zhao <yuzhao@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 12:45 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Fri, Mar 11, 2022 at 3:16 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Tue, Feb 15, 2022 at 10:43 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Thu, Feb 10, 2022 at 03:41:57PM -0500, Johannes Weiner wrote:
> > >
> > > Thanks for reviewing.
> > >
> > > > > +static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
> > > > > +{
> > > > > +   unsigned long max_seq = lruvec->lrugen.max_seq;
> > > > > +
> > > > > +   VM_BUG_ON(gen >= MAX_NR_GENS);
> > > > > +
> > > > > +   /* see the comment on MIN_NR_GENS */
> > > > > +   return gen == lru_gen_from_seq(max_seq) || gen == lru_gen_from_seq(max_seq - 1);
> > > > > +}
> > > >
> > > > I'm still reading the series, so correct me if I'm wrong: the "active"
> > > > set is split into two generations for the sole purpose of the
> > > > second-chance policy for fresh faults, right?
> > >
> > > To be precise, the active/inactive notion on top of generations is
> > > just for ABI compatibility, e.g., the counters in /proc/vmstat.
> > > Otherwise, this function wouldn't be needed.
> >
> > Hi Yu,
> > I am still quite confused as i am seeing both active/inactive and lru_gen.
> > eg:
> >
> > root@ubuntu:~# cat /proc/vmstat | grep active
> > nr_zone_inactive_anon 22797
> > nr_zone_active_anon 578405
> > nr_zone_inactive_file 0
> > nr_zone_active_file 4156
> > nr_inactive_anon 22800
> > nr_active_anon 578574
> > nr_inactive_file 0
> > nr_active_file 4215
>
> Yes, this is expected. We have to maintain the ABI, i.e., the
> *_active/inactive_* counters.
>
> > and:
> >
> > root@ubuntu:~# cat /sys//kernel/debug/lru_gen
> >
> > ...
> > memcg    36 /user.slice/user-0.slice/user@0.service
> >  node     0
> >          20      18820         22           0
> >          21       7452          0           0
> >          22       7448          0           0
> > memcg    33 /user.slice/user-0.slice/user@0.service/app.slice
> >  node     0
> >           0    2171452          0           0
> >           1    2171452          0           0
> >           2    2171452          0           0
> >           3    2171452          0           0
> > memcg    37 /user.slice/user-0.slice/session-1.scope
> >  node     0
> >          42      51804     102127           0
> >          43      18840     275622           0
> >          44      16104     216805           1
> >
> > Does it mean one page could be in both one of the generations and one
> > of the active/inactive lists?
>
> In terms of the data structure, evictable pages are either on
> lruvec->lists or lrugen->lists.
>
> > Do we have some mapping relationship between active/inactive lists
> > with generations?
>
> For the counters, yes -- pages in max_seq and max_seq-1 are counted as
> active, and the rest are inactive.
>
> > We used to put a faulted file page in inactive, if we access it a
> > second time, it can be promoted
> > to active. then in recent years, we have also applied this to anon
> > pages while kernel adds
> > workingset protection for anon pages. so basically both anon and file
> > pages go into the inactive
> > list for the 1st time, if we access it for the second time, they go to
> > the active list. if we don't access
> > it any more, they are likely to be reclaimed as they are inactive.
> > we do have some special fastpath for code section, executable file
> > pages are kept on active list
> > as long as they are accessed.
>
> Yes.
>
> > so all of the above concerns are actually not that correct?
>
> They are valid concerns but I don't know any popular workloads that
> care about them.

Hi Yu,
here we can get a workload in Kim's patchset while he added workingset
protection
for anon pages:
https://patchwork.kernel.org/project/linux-mm/cover/1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com/
anon pages used to go to active rather than inactive, but kim's patchset
moved to use inactive first. then only after the anon page is accessed
second time, it can move to active.

"In current implementation, newly created or swap-in anonymous page is

started on the active list. Growing the active list results in rebalancing
active/inactive list so old pages on the active list are demoted to the
inactive list. Hence, hot page on the active list isn't protected at all.

Following is an example of this situation.

Assume that 50 hot pages on active list and system can contain total
100 pages. Numbers denote the number of pages on active/inactive
list (active | inactive). (h) stands for hot pages and (uo) stands for
used-once pages.

1. 50 hot pages on active list
50(h) | 0

2. workload: 50 newly created (used-once) pages
50(uo) | 50(h)

3. workload: another 50 newly created (used-once) pages
50(uo) | 50(uo), swap-out 50(h)

As we can see, hot pages are swapped-out and it would cause swap-in later."

Is MGLRU able to avoid the swap-out of the 50 hot pages? since MGLRU
is putting faulted pages to the youngest generation directly, do we have the
risk mentioned in Kim's patchset?

Thanks
Barry
