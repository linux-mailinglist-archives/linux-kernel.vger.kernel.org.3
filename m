Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E114BEB32
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiBUTOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:14:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiBUTOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:14:35 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DFB21E14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:14:11 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id d21so14059437yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ke23PUdGK4FcuAvDei90P3s7F1wrdynOLCrMWwsI/wg=;
        b=aXHSZWGQkxoFRFnCMTFyA2dDnbtS1/VFo14Ca2ryASSUP1jdInnnH6EN96VkOEkMmc
         etGQf0cCK3iQuGWvG8sS5VG/adkNq0wU/ADUqBwSuMZXH7tdkn5D07ZKIilMQoPyn8Ht
         HeWjsq2u7F7/5BoJNpw1TYSbPNXxy7SS71BjHy25z7gLKZPYu13rItbE0gdzHFS7b4AA
         vYemo9p8P4/YYkJ020QZrK+urswg5RS3EOA0LDgpmtz5x1glAeerpGk4emA4H/OsARCk
         hkdPYTs7NaWkwuB+NoL6TYdvkUSgxr670e56Sc6Op3eX8N7hqziJhlZ5K6/ko4mrSkD3
         dvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ke23PUdGK4FcuAvDei90P3s7F1wrdynOLCrMWwsI/wg=;
        b=RFoGb4bWy5KmJeQh6f4aIWyy4Hf+mMx4D8VpJywOwTVCi5HtIOazxl4tWiEzHTU9rZ
         lu2h4JCIQQCTL/rvoylvM5/6Wk8e/zIf6nLQ4bz0V/3qrQheLdTkB+I19S66yIOiFZI9
         jh834yBK0y24uYzOj6qGaM8/S/AVqp59TPKSWMXosFsZbjzMD6U7WNvHSsPaQJe7YEBU
         RVYOG4MEaYRoi3r8N+ofDEoJb5GVFZfrBoAYVWGP980pH+EfRPLHvSKx9op/U76ekI0j
         5djkY6q0GAnf/ldHoK8KI/nM6ckDA5Pu79rxD/RBMDUFfEm8RASIY183zQ3gLVSVzUrI
         HFmA==
X-Gm-Message-State: AOAM530HH3cIMMAyXoWTbSkADk5ll4qPZSfD5BKVHbMjahvOgVp5kouu
        6/ib+QaDhCWMFjo0lD3J6B02VGR/NLvLFh3y/pBwybJQUeY8R//T
X-Google-Smtp-Source: ABdhPJxZp4gnM7PoQJalBDbWB9quvYUgCmra3noXkgGA6+aPFqXzKEAf0VARbMPidzo9x3QS2Co/5mvsUgctk6/zoQg=
X-Received: by 2002:a25:2693:0:b0:624:50a8:fee9 with SMTP id
 m141-20020a252693000000b0062450a8fee9mr13408336ybm.348.1645470850695; Mon, 21
 Feb 2022 11:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20220219174940.2570901-1-surenb@google.com> <YhNTcM9XtqA1zUUi@dhcp22.suse.cz>
 <YhNsaHLLfvFoxnNu@alley>
In-Reply-To: <YhNsaHLLfvFoxnNu@alley>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 21 Feb 2022 11:13:59 -0800
Message-ID: <CAJuCfpGpApL3PkoZuZ1XNwWsa2wq9pve4KLV36ULeLNXRjzMGg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
To:     Petr Mladek <pmladek@suse.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, peterz@infradead.org, guro@fb.com,
        shakeelb@google.com, minchan@kernel.org, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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

On Mon, Feb 21, 2022 at 2:41 AM 'Petr Mladek' via kernel-team
<kernel-team@android.com> wrote:
>
> On Mon 2022-02-21 09:55:12, Michal Hocko wrote:
> > On Sat 19-02-22 09:49:40, Suren Baghdasaryan wrote:
> > > When page allocation in direct reclaim path fails, the system will
> > > make one attempt to shrink per-cpu page lists and free pages from
> > > high alloc reserves. Draining per-cpu pages into buddy allocator can
> > > be a very slow operation because it's done using workqueues and the
> > > task in direct reclaim waits for all of them to finish before
> > > proceeding. Currently this time is not accounted as psi memory stall.
> > >
> > > While testing mobile devices under extreme memory pressure, when
> > > allocations are failing during direct reclaim, we notices that psi
> > > events which would be expected in such conditions were not triggered.
> > > After profiling these cases it was determined that the reason for
> > > missing psi events was that a big chunk of time spent in direct
> > > reclaim is not accounted as memory stall, therefore psi would not
> > > reach the levels at which an event is generated. Further investigation
> > > revealed that the bulk of that unaccounted time was spent inside
> > > drain_all_pages call.
> >
> > It would be cool to have some numbers here.
> >
> > > Annotate drain_all_pages and unreserve_highatomic_pageblock during
> > > page allocation failure in the direct reclaim path so that delays
> > > caused by these calls are accounted as memory stall.
> >
> > If the draining is too slow and dependent on the current CPU/WQ
> > contention then we should address that. The original intention was that
> > having a dedicated WQ with WQ_MEM_RECLAIM would help to isolate the
> > operation from the rest of WQ activity. Maybe we need to fine tune
> > mm_percpu_wq. If that doesn't help then we should revise the WQ model
> > and use something else. Memory reclaim shouldn't really get stuck behind
> > other unrelated work.
>
> WQ_MEM_RECLAIM causes that one special worker (rescuer) is created for
> the workqueue. It is used _only_ when new workers could not be created
> for some, typically when there is non enough memory. It is just
> a fallback, last resort. It does _not_ speedup processing.
>
> Otherwise, "mm_percpu_wq" is a normal CPU-bound wq. It uses the shared
> per-CPU worker pools. They serialize all work items on a single
> worker. Another worker is used only when a work goes asleep and waits
> for something.
>
> It means that "drain" work is blocked by other work items that are
> using the same worker pool and were queued earlier.

Thanks for the valuable information!

>
>
> You might try to allocate "mm_percpu_wq" with WQ_HIGHPRI flag. It will
> use another shared per-CPU worker pools where the workers have nice
> -20. The "drain" work still might be blocked by another work items
> using the same pool. But it should be faster because the workers
> have higher priority.

This seems like a good first step to try. I'll make this change and
rerun the tests to see how useful this would be.

>
>
> Dedicated kthreads might be needed when the "draining" should not be
> blocked by anything. If you go this way then I suggest to use
> the kthread_worker API, see "linux/kthread.h". It is very similar
> to the workqueues API but it always creates new kthreads.
>
> Just note that kthread_worker API does not maintain per-CPU workers
> on its own. If you need per-CPU workers than you need to
> use kthread_create_worker_on_cpu() for_each_online_cpu().
> And you would need cpu hotplug callbacks to create/destroy
> ktheads. For example, see start_power_clamp_worker().

Got it. Let me try the WQ_HIGHPRI approach first. Let's see if we can
fix this with minimal changes to the current mechanisms.
Thanks,
Suren.

>
> HTH,
> Petr
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
