Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870424DBA38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347035AbiCPVij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245675AbiCPVig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:38:36 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3F036E3D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:37:18 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id 62so1648672vsx.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2124ojqHQ17VIC93b3HGTmLk/RUApcZD8WLRKykmFU=;
        b=oO9Rw/zYoCrUFci0Cd+I2trOyvdj+YmSt75GiyEX/Czqum8l0pNZJ+61CB/Dk1qgBO
         kA+g/RH73xQCSPt1Tuz0yZ8ACQvHfHJtM1amcTSikfM0F8yeyONAybG2ZfhgU9wY0WIw
         anIL2b1mT9jOcrRj0WEuxpHbxujCPNCHrHlwyqXmO468yiiz3qnRyyor2r1zT0uDm4ir
         2n+cwnH6mHR10PGhfq0koH5xywT7HATReSQMpZxfFA5E5ZRs6zuPodKu1DJOGw+u37Ik
         MBgK3xeqiHImVn89y/8qGfWU7moXbiNuV/pwZ5omwZ1SZ/c5MCyKWdP0DvvIn2/9PCjU
         HlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2124ojqHQ17VIC93b3HGTmLk/RUApcZD8WLRKykmFU=;
        b=q06mIoKzNn+fAzNPiyEG2KDMwcXcWLo0GJ+3NO0S55eeX/ddzXGFGaxvvbMEl9EQLH
         TbvbElQIW+9M3MdfRwVIJh2T+VWzUy8TbK7aqGvGxBTHfieBB2JxwGaH2hmn0dEHhKpy
         X/TsnyF9SOua132SOIlGQg0Ia+WCSzKzQcWPbET+LZrgXuZ0+94sCy2GORYx64F//lKu
         017QO+Oj6+7M6U5gTcUuP4+jyhBFAi3rf6UnA6p+3halE+zlHkni0BKt4JZZZA3AGYVq
         RcUD++Wyc6zF9cjStJiBiws3UMSofp0RdOJVK43cPeTOMAmHotY53TF/1CZ15paxEZEd
         PMoA==
X-Gm-Message-State: AOAM532QMrgZoS7Z3xM379SxgMU1JeLgpOJDu8myqfw0QhyKftpdSdCs
        vUTq53ezk7JqXMtIswtumnjMdTnksC+RulAEu/sdPg==
X-Google-Smtp-Source: ABdhPJyoibWhp7j3cyGKGuapzVbp9pPfcuKW3yK+aST9VYeNuLH/r3B4PAUaweFbHhL4W735Lq/WmHWVDQsa4/G/w8k=
X-Received: by 2002:a05:6102:f0c:b0:320:9156:732f with SMTP id
 v12-20020a0561020f0c00b003209156732fmr782836vss.6.1647466637814; Wed, 16 Mar
 2022 14:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAOUHufbN_56UJBkgA2LjAfbTt9nzPOCHaSeS4P3GHcYst+Y+eg@mail.gmail.com>
 <20220314233812.9011-1-21cnbao@gmail.com> <CAOUHufa9eY44QadfGTzsxa2=hEvqwahXd7Canck5Gt-N6c4UKA@mail.gmail.com>
 <CAGsJ_4zvj5rmz7DkW-kJx+jmUT9G8muLJ9De--NZma9ey0Oavw@mail.gmail.com>
 <CAGsJ_4zZc0oFSmBKAN77vm7VstQH=ieaQ0cfyvcMi3OQRrEpSg@mail.gmail.com>
 <CAOUHufau34de-FmdBxNHpWWUUuN4DxT1fci9aX8Uc+RAfVXwXw@mail.gmail.com>
 <CAGsJ_4waTOj=zzC+gZAVMW5SQ_b9UWcXjKv3oj57s-YysTQmPw@mail.gmail.com>
 <CAOUHufZV-f6-7T+ZFBVHUJjGn6HfeKoVdPxiOCG2PmxxXbWVZA@mail.gmail.com> <CAGsJ_4xn6PowAGOaXOoQiuqq8nyOZ=HxfYKDfXZN7xzo9krfxQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xn6PowAGOaXOoQiuqq8nyOZ=HxfYKDfXZN7xzo9krfxQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 16 Mar 2022 15:37:06 -0600
Message-ID: <CAOUHufYaa+1S_sDmFSPJTkVym75EpFy1yPtXdobTjdGDzmk3Kg@mail.gmail.com>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
To:     Barry Song <21cnbao@gmail.com>
Cc:     Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Michael Larabel <Michael@michaellarabel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Carr <d@chaos-reins.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Rik van Riel <riel@surriel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 12:06 AM Barry Song <21cnbao@gmail.com> wrote:

< snipped>
> > The cost is not the point; the fairness is:
> >
> > 1) Ramdisk is fair to both LRU algorithms.
> > 2) Zram punishes the LRU algorithm that chooses incompressible pages.
> > IOW, this algorithm needs to compress more pages in order to save the
> > same amount of memory.
>
> I see your point. but my point is that with higher I/O cost to swap
> in and swap out pages,  more major faults(lower hit ratio) will
> contribute to the loss of final performance.
>
> So for the particular case, if we move to a real disk as a swap
> device, we might see the same result as zRAM I was using
> since you also reported more page faults.

If we wanted to talk about I/O cost, we would need to consider the
number of writes and writeback patterns as well. The LRU algorithm
that *unconsciously* picks more clean pages has an advantage because
writes are usually slower than reads. Similarly, the LRU algorithm
that *unconsciously* picks a cluster of cold pages that later would be
faulted in together also has the advantage because sequential reads
are faster than random reads. Do we want to go into this rabbit hole?
I think not. That's exactly why I suggested we focus on the fairness.
But, just outta curiosity, MGLRU was faster when swapping to a slow
MMC disk.

# mmc cid read /sys/class/mmc_host/mmc1/mmc1:0001
type: 'MMC'
manufacturer: 'SanDisk-Toshiba Corporation' ''
product: 'DA4064' 1.24400152
serial: 0x00000000
manfacturing date: 2006 aug

# baseline + THP=never
0 records/s
real 872.00 s
user 51.69 s
sys  483.09 s

    13.07%  __memcpy_neon
    11.37%  __pi_clear_page
     9.35%  _raw_spin_unlock_irq
     5.52%  mod_delayed_work_on
     5.17%  _raw_spin_unlock_irqrestore
     3.95%  do_raw_spin_lock
     3.87%  rmqueue_pcplist
     3.60%  local_daif_restore
     3.17%  free_unref_page_list
     2.74%  zap_pte_range
     2.00%  handle_mm_fault
     1.19%  do_anonymous_page

# MGLRU + THP=never
0 records/s
real 821.00 s
user 44.45 s
sys  428.21 s

    13.28%  __memcpy_neon
    12.78%  __pi_clear_page
     9.14%  _raw_spin_unlock_irq
     5.95%  _raw_spin_unlock_irqrestore
     5.08%  mod_delayed_work_on
     4.45%  do_raw_spin_lock
     3.86%  local_daif_restore
     3.81%  rmqueue_pcplist
     3.32%  free_unref_page_list
     2.89%  zap_pte_range
     1.89%  handle_mm_fault
     1.10%  do_anonymous_page

# baseline + THP=madvise
0 records/s
real 1341.00 s
user 68.15 s
sys  681.42 s

    12.33%  __memcpy_neon
    11.78%  _raw_spin_unlock_irq
     8.79%  __pi_clear_page
     7.63%  mod_delayed_work_on
     5.49%  _raw_spin_unlock_irqrestore
     3.23%  local_daif_restore
     3.00%  do_raw_spin_lock
     2.83%  rmqueue_pcplist
     2.21%  handle_mm_fault
     2.00%  zap_pte_range
     1.51%  free_unref_page_list
     1.33%  do_swap_page
     1.17%  do_anonymous_page

# MGLRU + THP=madvise
0 records/s
real 1315.00 s
user 60.59 s
sys  620.56 s

    12.34%  __memcpy_neon
    12.17%  _raw_spin_unlock_irq
     9.33%  __pi_clear_page
     7.33%  mod_delayed_work_on
     6.01%  _raw_spin_unlock_irqrestore
     3.27%  local_daif_restore
     3.23%  do_raw_spin_lock
     2.98%  rmqueue_pcplist
     2.12%  handle_mm_fault
     2.04%  zap_pte_range
     1.65%  free_unref_page_list
     1.27%  do_swap_page
     1.11%  do_anonymous_page
