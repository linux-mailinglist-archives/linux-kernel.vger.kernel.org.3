Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1524F50EEE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242549AbiDZCxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiDZCxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:53:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844F5222BF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:49:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b15so16652993pfm.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGAx5TP6E+vFvjaPxhYu9IBA2KbCco9Opl8nE6JlHZY=;
        b=TveONqNNTAMKRK3L5GedChuTwratL2NBA5QmxDHEPJFdUx05XPxL7uzHbRQY1k0VP+
         QGH4vuhM4l6pRcU6c0G34VDTbDUmPHxvv/2QcICPqvaF2aOfkmv5iDhxDdpNFG2PzDzj
         pVqxylha350zoMW4sh2LSwIKCi5PJEAchJAFFeCM5Acuy2sM+GxRmKsNJmNPFojYgmX1
         Tq/Bm1NlqR15AOfXiapXAZ9YImmAVAuDwPA54qd2TKhq011xasmBS0UWXvJ2iYsjQXZ0
         elsIdKj+CrA5a+ZyziFasVwk+CJcf0z/2JppV5lGCAXx4HLyAoOxvDhbhfY9cGW42Y/S
         qEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGAx5TP6E+vFvjaPxhYu9IBA2KbCco9Opl8nE6JlHZY=;
        b=gZZ2amL2Z62JSS2p6JUHw58SC3Wc3ob3B9d08brZTzQP/s68ETRAL8F0zdDGrUns3U
         ChWMIBbviHlcjs6epzMVsmEqi7S8XqW8p7tA7bn5D6NKjl202ySNqs8surEXQxcmeCni
         BNV0e/BsRq0C6k+P0smjFWi3AK4O/ARuWdyJOdGSGO+Laf+VIVaVu+J/1dRtgiZwLa86
         d02B5i0aYZPRQL5CXmPZnju3cliSw7ghEyAhkahN+5Z9cwxJm44TvCbNe5PGasTWZ6M4
         2sSM8DdF+qovYX3kqWQ4U6ixitfGp8wq5RPhVI8iB1ssF2fk/LtwDXzA8x2toKZzTN6M
         C/+w==
X-Gm-Message-State: AOAM532sTswkmGKkaLCdCNI3A6LlVZthhpUVmaoP4gYWiNKeTXAeG9Gh
        BBTfFf9J8J3iBP34JY8EACcRP0+Qz0VMobMe6Tp9MsIc7N8RJg==
X-Google-Smtp-Source: ABdhPJxuQRhkzahWKLzhvbzo8kOU6fZ3ZFG6NDOaZbwPYeIG96+3TCV/J6Ekta0ZZ7sN6E0Awm1X0rw0AMHSXRG8k3A=
X-Received: by 2002:a63:89c7:0:b0:3ab:1f12:f807 with SMTP id
 v190-20020a6389c7000000b003ab1f12f807mr9017915pgd.180.1650941396751; Mon, 25
 Apr 2022 19:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220420095906.27349-1-mgorman@techsingularity.net>
In-Reply-To: <20220420095906.27349-1-mgorman@techsingularity.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 25 Apr 2022 19:49:46 -0700
Message-ID: <CAJuCfpH=U9E-46wZgKEYQZVKjw=2qq_KXDRF=tqDBvqpR+BBbg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Drain remote per-cpu directly
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 2:59 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> per-cpu lists drain support" -- avoid interference of a high priority
> task due to a workqueue item draining per-cpu page lists. While many
> workloads can tolerate a brief interruption, it may be cause a real-time
> task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> the draining in non-deterministic.
>
> Currently an IRQ-safe local_lock protects the page allocator per-cpu lists.
> The local_lock on its own prevents migration and the IRQ disabling protects
> from corruption due to an interrupt arriving while a page allocation is
> in progress. The locking is inherently unsafe for remote access unless
> the CPU is hot-removed.
>
> This series adjusts the locking. A spin-lock is added to struct
> per_cpu_pages to protect the list contents while local_lock_irq continues
> to prevent migration and IRQ reentry. This allows a remote CPU to safely
> drain a remote per-cpu list.
>
> This series is a partial series. Follow-on work would allow the
> local_irq_save to be converted to a local_irq to avoid IRQs being
> disabled/enabled in most cases. However, there are enough corner cases
> that it deserves a series on its own separated by one kernel release and
> the priority right now is to avoid interference of high priority tasks.
>
> Patch 1 is a cosmetic patch to clarify when page->lru is storing buddy pages
>         and when it is storing per-cpu pages.
>
> Patch 2 shrinks per_cpu_pages to make room for a spin lock. Strictly speaking
>         this is not necessary but it avoids per_cpu_pages consuming another
>         cache line.
>
> Patch 3 is a preparation patch to avoid code duplication.
>
> Patch 4 is a simple micro-optimisation that improves code flow necessary for
>         a later patch to avoid code duplication.
>
> Patch 5 uses a spin_lock to protect the per_cpu_pages contents while still
>         relying on local_lock to prevent migration, stabilise the pcp
>         lookup and prevent IRQ reentrancy.
>
> Patch 6 remote drains per-cpu pages directly instead of using a workqueue.

This quite possibly solves the issue I was trying to fix in
https://lore.kernel.org/all/20220225012819.1807147-1-surenb@google.com.
I will give it a try and see how it looks.
Thanks!

>
>  include/linux/mm_types.h |   5 +
>  include/linux/mmzone.h   |  12 +-
>  mm/page_alloc.c          | 333 ++++++++++++++++++++++++---------------
>  3 files changed, 222 insertions(+), 128 deletions(-)
>
> --
> 2.34.1
>
>
