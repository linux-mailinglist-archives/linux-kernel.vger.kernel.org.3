Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDD45A083F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 06:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiHYE7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 00:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiHYE7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 00:59:04 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EAA9DFA5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 21:59:03 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id h67so18778853vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 21:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=N2bysu1FmHAN+YQFb8GQMb75KFadrTOjFxAwoEM6v1I=;
        b=SkMw7N2AQ2gLjqiYeu7GGfCUvJaJz+CQikdXbJW9kRWZoORr+Z29M4+Is0AcGQ954a
         vBiumLEyXbyQ3byhDB+KHNTgOnbdEVEw34w2uVniCuuQnqp8TgshB6skD04os7qxK0w3
         EiopSoB4JL3Gh2+nWQWbDgrdO1c7nOJ8UWANzd9RF4rSapybAnnt+CbNxatJsvhFO4lj
         HtfU5oYeA+P4KI16uQaGW1cHC2EINp1AQ/OVTc1wRdU2bFF8GcfKGz+UOY+VHO5/2+lq
         v+UMf29De5BaYNL1+OWAyrimEo0EC5abaYKE1OjoP/A8aSQ/UzRllmuRVApW+VEfIkc/
         gzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=N2bysu1FmHAN+YQFb8GQMb75KFadrTOjFxAwoEM6v1I=;
        b=PEVARPTbU1tcGu2HBrwl8MLd8sJyjudVWx6k+1134YYwM6s1yXrH16adT1i5VNti8d
         Y1adfyZRhIHvtYHzc5PezmSg7kWD1npZUCjN1kPdZBLCa7S40EIZ4TCV8dHGgRCLXrTj
         aLBZBAMbslBHp/Hd5Myxtb+BlodARgSGMMC2W5MQOByybcEKiLE1Hy1WmjAgZjVxJizt
         RsECLphhlrD9Il+TtlH9beBPMbSwvNVkpxJLk0qFLOs4camCLJDxISKM/uzYCwnQa+t7
         x8KppZH0sMC0OkmBk87htvzpFuOVuK2d07ok0w8YaIQqbpY/TvezfY0qHfUN31aS4KRZ
         WFmg==
X-Gm-Message-State: ACgBeo21MIOgftYKKdfxFIMSx83SrBpqdnOYx9NUZTfevom+rLYPRmnn
        kJETCR+wN2LKAK4ggUsYEWLkjSOtWl+DVcIe3k4PLa1X1c9a+g==
X-Google-Smtp-Source: AA6agR5moiLIPbaxdiTg5KXvqwjq3SKqu4hf0jNR4FJ5/9ra9WNhCXUflM9tvGc2ugs/qdY8nXHLio3fyafaLocJj24=
X-Received: by 2002:a05:6102:3005:b0:390:5c54:7aea with SMTP id
 s5-20020a056102300500b003905c547aeamr859716vsa.50.1661403542879; Wed, 24 Aug
 2022 21:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220824141802.23395-1-mgorman@techsingularity.net>
In-Reply-To: <20220824141802.23395-1-mgorman@techsingularity.net>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 24 Aug 2022 22:58:26 -0600
Message-ID: <CAOUHufbxqn5gjYxnZDLsRtaKgtauFXwL+qq_829Eg5PSJaSPgg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/page_alloc: Leave IRQs enabled for per-cpu page allocations
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
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

On Wed, Aug 24, 2022 at 8:18 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
> allocating from the PCP must not re-enter the allocator from IRQ context.
> In each instance where IRQ-reentrancy is possible, the lock is acquired using
> pcp_spin_trylock_irqsave() even though IRQs are disabled and re-entrancy
> is impossible.
>
> Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
> case at the cost of some IRQ allocations taking a slower path. If the PCP
> lists need to be refilled, the zone lock still needs to disable IRQs but
> that will only happen on PCP refill and drain. If an IRQ is raised when
> a PCP allocation is in progress, the trylock will fail and fallback to
> using the buddy lists directly. Note that this may not be a universal win
> if an interrupt-intensive workload also allocates heavily from interrupt
> context and contends heavily on the zone->lock as a result.

Hi,

This patch caused the following warning. Please take a look.

Thanks.

  WARNING: inconsistent lock state
  6.0.0-dbg-DEV #1 Tainted: G S      W  O
  --------------------------------
  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
  ksoftirqd/2/27 [HC0[0]:SC1[1]:HE0:SE0] takes:
  ffff9ce5002b8c58 (&pcp->lock){+.?.}-{2:2}, at:
free_unref_page_list+0x1ac/0x260
  {SOFTIRQ-ON-W} state was registered at:
    lock_acquire+0xb3/0x190
    _raw_spin_trylock+0x46/0x60
    rmqueue_pcplist+0x42/0x1d0
    rmqueue+0x58/0x590
    get_page_from_freelist+0x2c3/0x510
    __alloc_pages+0x126/0x210
    alloc_page_interleave+0x13/0x90
    alloc_pages+0xfb/0x250
    __get_free_pages+0x11/0x30
    __pte_alloc_kernel+0x1c/0xc0
    vmap_p4d_range+0x448/0x690
    ioremap_page_range+0xdc/0x130
    __ioremap_caller+0x258/0x320
    ioremap_cache+0x17/0x20
    acpi_os_map_iomem+0x12f/0x1d0
    acpi_os_map_memory+0xe/0x10
    acpi_tb_acquire_table+0x42/0x6e
    acpi_tb_validate_temp_table+0x43/0x55
    acpi_tb_verify_temp_table+0x31/0x238
    acpi_reallocate_root_table+0xe6/0x158
    acpi_early_init+0x4f/0xd1
    start_kernel+0x32a/0x44f
    x86_64_start_reservations+0x24/0x26
    x86_64_start_kernel+0x124/0x12b
    secondary_startup_64_no_verify+0xe6/0xeb
  irq event stamp: 961581
  hardirqs last  enabled at (961580): [<ffffffff95b2cde5>]
_raw_spin_unlock_irqrestore+0x35/0x50
  hardirqs last disabled at (961581): [<ffffffff951c1998>]
folio_rotate_reclaimable+0xf8/0x310
  softirqs last  enabled at (961490): [<ffffffff94fa40d8>]
run_ksoftirqd+0x48/0x90
  softirqs last disabled at (961495): [<ffffffff94fa40d8>]
run_ksoftirqd+0x48/0x90

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&pcp->lock);
    <Interrupt>
      lock(&pcp->lock);

   *** DEADLOCK ***

  1 lock held by ksoftirqd/2/27:
   #0: ffff9ce5002adab8 (lock#7){..-.}-{2:2}, at: local_lock_acquire+0x0/0x70

  stack backtrace:
  CPU: 2 PID: 27 Comm: ksoftirqd/2 Tainted: G S      W  O       6.0.0-dbg-DEV #1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x6c/0x9a
   dump_stack+0x10/0x12
   print_usage_bug+0x374/0x380
   mark_lock_irq+0x4a8/0x4c0
   ? save_trace+0x40/0x2c0
   mark_lock+0x137/0x1b0
   __lock_acquire+0x5bf/0x3540
   ? __SCT__tp_func_virtio_transport_recv_pkt+0x7/0x8
   ? lock_is_held_type+0x96/0x130
   ? rcu_read_lock_sched_held+0x49/0xa0
   lock_acquire+0xb3/0x190
   ? free_unref_page_list+0x1ac/0x260
   _raw_spin_lock+0x2f/0x40
   ? free_unref_page_list+0x1ac/0x260
   free_unref_page_list+0x1ac/0x260
   release_pages+0x90a/0xa70
   ? folio_batch_move_lru+0x138/0x190
   ? local_lock_acquire+0x70/0x70
   folio_batch_move_lru+0x147/0x190
   folio_rotate_reclaimable+0x168/0x310
   folio_end_writeback+0x5d/0x200
   end_page_writeback+0x18/0x40
   end_swap_bio_write+0x100/0x2b0
   ? bio_chain+0x30/0x30
   bio_endio+0xd8/0xf0
   blk_update_request+0x173/0x340
   scsi_end_request+0x2a/0x300
   scsi_io_completion+0x66/0x140
   scsi_finish_command+0xc0/0xf0
   scsi_complete+0xec/0x110
   blk_done_softirq+0x53/0x70
   __do_softirq+0x1e2/0x357
   ? run_ksoftirqd+0x48/0x90
   run_ksoftirqd+0x48/0x90
   smpboot_thread_fn+0x14b/0x1c0
   kthread+0xe6/0x100
   ? cpu_report_death+0x50/0x50
   ? kthread_blkcg+0x40/0x40
   ret_from_fork+0x1f/0x30
   </TASK>
