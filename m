Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C0B5223A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348796AbiEJSRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241609AbiEJSRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:17:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B721A7D1B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:13:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so2839644pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=89mc+F3C89QRpIXv+3CREeayukHxq0NE/oSUKuC5Jdg=;
        b=ks7Gabclb8CM0RM7dDLvohbelK4HdBErQ1SwzXfGzDHBdUTVoAwKwr3HvFAUBT30Ya
         HdNmwfnG4hYgtWkHjyy7Ni0TxLFq42Gf1YquF9d7MLVsram6xrV4VDwIsPSQfDONIAwn
         xKtJDiJEn6g3+MbGYaBJp6J7WzdiTmVoU5Ks/vzEMg0DsQbdNmkgnmTv6uYENGt6CoP4
         ui09JmdkMRN3iLA/rYds/PBwnFhM2YGd3TGGB8Yo/a97h+mSeFSAAU7CyJdOwTQUTv6+
         G4H5zBLXQ6M3mZtx1fQV4AuzzOzkEsnjAyVVwu+VLH0z2aoxW8DZWgGxiOImbHd1Bj5+
         kzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=89mc+F3C89QRpIXv+3CREeayukHxq0NE/oSUKuC5Jdg=;
        b=yoLty1cRKuek4+/lq1uHnzsSUpDgRx+qtkAK11TnQ/Vcj/iRW9fR8l9BsWb/Yc4b2A
         VTlZ2iISc3dhsk9tuhthkO31lYU2WLxCRZ/4NfaYq8wlv+iOAcS0uP4OJnrsx7L8cR2L
         ce3dGrxAIXbYrwiU3zEN6XEYngcxW2HTBgUG3GvrNlUCP8MUk7WKXZGasmbi1u2c3jFe
         9PLx2dncRecvqRPMDwP1OVnQ4UqGVxV3Ni0I9V7FI93qubMTEbRrEFMQA02JBjyCgP08
         CEdBTB4ed+KB/3gCedyFppi23UQNNDrx3C/qaSC/OE6JZ+5/ic3XT2hiL+2V1STxpSRu
         5zQA==
X-Gm-Message-State: AOAM532aVDw2rj/rSLA9SECpqiVFb4E2qRUH1vsRUdjEgC/AvPbkNR4l
        8mTW+ZrJ1CLNgRd+pVGXiXlsJga23ms=
X-Google-Smtp-Source: ABdhPJzaAtrw45oMAbtttFRKUqtwzfmtNbQwlV7PxdcyDTiaH8NoGuaA4q8qB2l4uKjEMDNiKJdv1Q==
X-Received: by 2002:a17:903:110c:b0:15f:f15:30ec with SMTP id n12-20020a170903110c00b0015f0f1530ecmr11372428plh.162.1652206387970;
        Tue, 10 May 2022 11:13:07 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:c98a:65b0:edca:b69a])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709026bc800b0015e8d4eb2c9sm2313024plt.275.2022.05.10.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:13:07 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 10 May 2022 11:13:05 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 0/6] Drain remote per-cpu directly v2
Message-ID: <YnqrMckyHH3qvkdv@google.com>
References: <20220509130805.20335-1-mgorman@techsingularity.net>
 <Ynk6O4WAut0Ejl7Z@google.com>
 <20220510092733.GE3441@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510092733.GE3441@techsingularity.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 10:27:33AM +0100, Mel Gorman wrote:
> On Mon, May 09, 2022 at 08:58:51AM -0700, Minchan Kim wrote:
> > On Mon, May 09, 2022 at 02:07:59PM +0100, Mel Gorman wrote:
> > > Changelog since v1
> > > o Fix unsafe RT locking scheme
> > > o Use spin_trylock on UP PREEMPT_RT
> > 
> > Mel,
> > 
> > 
> > Is this only change from previous last version which has some
> > delta you fixed based on Vlastimil and me?
> > 
> 
> Full diff is below although it can also be generated by
> comparing the mm-pcpdrain-v1r8..mm-pcpdrain-v2r1 branches in
> https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/

I took the delta when I started testing so the testing result
would be valid. Thanks.

> 
> > And is it still RFC?
> > 
> 
> It's still RFC because it's a different approach to Nicolas' series and
> I want at least his Acked-by before taking the RFC label out and sending
> it to Andrew.
> 
> > Do you have some benchmark data?
> > 
> 
> Yes, but as reclaim is not fundamentally altered the main difference
> in behavious is that work is done inline instead of being deferred to a
> workqueue. That means in some cases, system CPU usage of a task will be
> higher because it's paying the cost directly.

Sure but the reclaim path is already expensive so I doubt we could
see the sizable measurement on the system CPU usage.

What I wanted to see was whether we have regression due to adding
spin_lock/unlock instructions in hot path. Due to squeeze it to
a cacheline, I expected the regression would be just marginal.

> 
> The workloads I used just hit reclaim directly to make sure it's
> functionally not broken. There is no change in page aging decisions,
> only timing of drains. I didn't check interference of a heavy workload
> interfering with a CPU-bound workload running on NOHZ CPUs as I assumed
> both you and Nicolas had a test case ready to use.

The my workload is not NOHZ CPUs but run apps under heavy memory
pressure so they goes to direct reclaim and be stuck on drain_all_pages
until work on workqueue run.

unit: nanosecond
max(dur)        avg(dur)                count(dur)
166713013       487511.77786438033      1283

From traces, system encountered the drain_all_pages 1283 times and
worst case was 166ms and avg was 487us.

The other problem was alloc_contig_range in CMA. The PCP draining
takes several hundred millisecond sometimes though there is no
memory pressure or a few of pages to be migrated out but CPU were
fully booked.

Your patch perfectly removed those wasted time.

> 
> The main one I paid interest to was a fault latency benchmark in
> the presense of heavy reclaim called stutterp. It simulates a simple
> workload. One part uses a lot of anonymous memory, a second measures mmap
> latency and a third copies a large file.  The primary metric is checking
> for mmap latency. It was originally put together to debug interactivity
> issues on a desktop in the presense of heavy IO where the desktop
> applications were being pushed to backing storage.
> 
> stutterp
>                               5.18.0-rc1             5.18.0-rc1
>                                  vanilla       mm-pcpdrain-v2r1
> 1st-qrtle mmap-4      15.9557 (   0.00%)     15.4045 (   3.45%)
> 1st-qrtle mmap-6      10.8025 (   0.00%)     11.1204 (  -2.94%)
> 1st-qrtle mmap-8      16.9338 (   0.00%)     17.0595 (  -0.74%)
> 1st-qrtle mmap-12     41.4746 (   0.00%)      9.4003 (  77.33%)
> 1st-qrtle mmap-18     47.7123 (   0.00%)    100.0275 (-109.65%)
> 1st-qrtle mmap-24     17.7098 (   0.00%)     16.9633 (   4.22%)
> 1st-qrtle mmap-30     69.2565 (   0.00%)     38.2205 (  44.81%)
> 1st-qrtle mmap-32     49.1295 (   0.00%)     46.8819 (   4.57%)
> 3rd-qrtle mmap-4      18.4706 (   0.00%)     17.4799 (   5.36%)
> 3rd-qrtle mmap-6      11.4526 (   0.00%)     11.5567 (  -0.91%)
> 3rd-qrtle mmap-8      19.5903 (   0.00%)     19.0046 (   2.99%)
> 3rd-qrtle mmap-12     50.3095 (   0.00%)     25.3254 (  49.66%)
> 3rd-qrtle mmap-18     67.3319 (   0.00%)    147.6404 (-119.27%)
> 3rd-qrtle mmap-24     41.3779 (   0.00%)     84.4035 (-103.98%)
> 3rd-qrtle mmap-30    127.1375 (   0.00%)    148.8884 ( -17.11%)
> 3rd-qrtle mmap-32     79.7423 (   0.00%)    182.3042 (-128.62%)
> Max-99    mmap-4      46.9123 (   0.00%)     49.7731 (  -6.10%)
> Max-99    mmap-6      42.5414 (   0.00%)     16.6173 (  60.94%)
> Max-99    mmap-8      43.1237 (   0.00%)     23.3478 (  45.86%)
> Max-99    mmap-12     62.8025 (   0.00%)   1947.3862 (-3000.81%)
> Max-99    mmap-18  27936.8695 (   0.00%)    232.7122 (  99.17%)
> Max-99    mmap-24 204543.9436 (   0.00%)   5805.2478 (  97.16%)
> Max-99    mmap-30   2350.0289 (   0.00%)  10300.6344 (-338.32%)
> Max-99    mmap-32  56164.2271 (   0.00%)   7789.7526 (  86.13%)
> Max       mmap-4     840.3468 (   0.00%)   1137.4462 ( -35.35%)
> Max       mmap-6  255233.3996 (   0.00%)  91304.0952 (  64.23%)
> Max       mmap-8  210910.6497 (   0.00%) 117931.0796 (  44.08%)
> Max       mmap-12 108268.9537 (   0.00%) 319971.6910 (-195.53%)
> Max       mmap-18 608805.3195 (   0.00%) 197483.2205 (  67.56%)
> Max       mmap-24 327697.5605 (   0.00%) 382842.5356 ( -16.83%)
> Max       mmap-30 688684.5335 (   0.00%) 669992.7705 (   2.71%)
> Max       mmap-32 396842.0114 (   0.00%) 415978.2539 (  -4.82%)
> 
>                   5.18.0-rc1  5.18.0-rc1
>                      vanillamm-pcpdrain-v2r1
> Duration User        1438.08     1637.21
> Duration System     12267.41    10307.96
> Duration Elapsed     3929.70     3443.53
> 
> 
> It's a mixed bag but this workload is always a mixed bag and it's stressing
> reclaim.  At some points, latencies are worse, in others better. Overall,
> it completed faster and this was on a 1-socket machine.
> 
> On a 2-socket machine, the overall completions times were worse
> 
>                   5.18.0-rc1  5.18.0-rc1
>                      vanillamm-pcpdrain-v2r1
> Duration User        3713.75     2899.90
> Duration System    303507.56   378909.94
> Duration Elapsed    15444.59    19067.40
> 
> In general this type of workload is variable given the nature of what it
> does and can give different results on each execution. When originally
> designed, it was to deal with stalls lasting several seconds to reduce
> them to the sub-millisecond range.
> 
> The intent of the series is switching out-of-line work to in-line so
> what it should be measuring is interference effects and not straight-line
> performance and I haven't written a specific test case yet. When writing
> the series initially, it was to investigate if the PCP could be lockless
> and failing that, if disabling IRQs could be avoided in the common case.
> It just turned out that part of that made remote draining possible and
> I focused closer on that because it's more important.
> 
> > I'd like to give Acked-by/Tested-by(even though there are a few
> > more places to align with new fields name in 1/6)
> 
> Which ones are of concern?
> 
> Some of the page->lru references I left alone in the init paths simply
> because in those contexts, the page wasn't on a buddy or PCP list. In
> free_unref_page_list the page is not on the LRU, it's just been isolated
> from the LRU. In alloc_pages_bulk, it's not on a buddy, pcp or LRU list
> and is just a list placeholder so I left it alone. In
> free_tail_pages_check the context was a page that was likely previously
> on a LRU.

Just nits: all are list macros.

free_pcppages_bulk's list_last_entry should be pcp_list.

mark_free_pages's list_for_each_entry should be buddy_list

__rmqueue_pcplist's list_first_enty should be pcp_list.

> 
> > since I have
> > tested these patchset in my workload and didn't spot any other
> > problems.
> > 
> 
> Can you describe this workload, is it available anywhere and does it
> require Android to execute?

I wrote down above. It runs on Android but I don't think it's
android specific issue but anyone could see such a long latency
from PCP draining once one of cores are monopolized by higher
priority processes or too many pending kworks.

> 
> If you have positive results, it would be appreciated if you could post
> them or just note in a Tested-by/Acked-by that it had a measurable impact
> on the reclaim/cma path.

Sure.

All patches in this series.

Tested-by: Minchan Kim <minchan@kernel.org>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.
