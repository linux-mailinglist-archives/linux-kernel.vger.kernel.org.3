Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229204D68F5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351021AbiCKTJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbiCKTJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:09:48 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB77E1B8FF2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:08:44 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b8so8995643pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUBsSaqnRWg4B0uOKbllkHk4Scdppop0KK0xMi3fHF0=;
        b=PAbXkYu6bO5CXr9IedJ6KlSYT41m9t9e0QurfT3ujodBdLBV+DtO/BasHg04X5F54j
         dpjmZViSKc7LwACuQN2p2nVCvDJpi6HPy+bO3hVy8oc7XXFpC67uM7/RbNZJt9DCevJ8
         sR8s6D/vIDBptzP1nURtjV1KEfPhd3twjmLzjCQYXni/j8GfhNXqNrOtyK0wGpeEBfXO
         ubWMK7PLb08B39jxdnlpnf6OBypo8xJ3YyWB3cW0XEmkpsYTWScUoAnuIn4l8tbMtQvr
         f6fdCKZfIme6lT86B3YjtIix1YxCoTL0uJj0/1R847d6bQ/Qvg0kpAQn0k7i3ZJzI1v3
         lD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUBsSaqnRWg4B0uOKbllkHk4Scdppop0KK0xMi3fHF0=;
        b=uDguGBHOYL2o57Ik4KB3U3A1n5BWCAFLcfF64GHqtnjPh79TRYlrzTDoNLjncVHI7e
         oINn3t4j5+ynK2UsgZwKbybhM3bBStk6t+la1AnST9wGLIySH0P+emKfgJdoaxpuZxRo
         O74BbrpdsgO0BQX2FgNYqCYDpw5cb6j3HP0IhM6RGsOdJ+rUaksVFiprgGl9JqGewqtT
         XKZyJ9+Qt1Kn3//efSIQUkhtx5d1a6KwBOgdMGMNgkQaY9jTdAdeu7Nt9SJxsdCKaeb6
         6pPgejPDBj0M2tU6gYEp6aXc6tLZsivukEbhu99/AoNwunTx1L4aWnOGvL3JhwmzAieB
         y7Pg==
X-Gm-Message-State: AOAM533weU2pi+KNqmruS4bLsnUxW5hU3u5KJL0gCOMhQCv4jWz7ll9X
        +UCwWkHMC9Ds3fGrAAQgGQxMD1ZxLRpAjE5f5VM=
X-Google-Smtp-Source: ABdhPJwruMQQDmYQxzHZEyz8v1ZYnPpx8eYxrEgy5L6YvNnSQ/ihIh1qe8rCOQwZEPM/5ttb0ttPENHh8JC6xalucW4=
X-Received: by 2002:a17:90b:4595:b0:1be:db22:8327 with SMTP id
 hd21-20020a17090b459500b001bedb228327mr23402186pjb.99.1647025724268; Fri, 11
 Mar 2022 11:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20220311090119.2412738-1-maobibo@loongson.cn>
In-Reply-To: <20220311090119.2412738-1-maobibo@loongson.cn>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 11 Mar 2022 11:08:32 -0800
Message-ID: <CAHbLzkoiP+uRYGDm+FC_zg-LkPbTMFQ-wSzGMh0RPr-XP4_ciw@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: sched to numa node when collapse huge page
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Fri, Mar 11, 2022 at 1:01 AM Bibo Mao <maobibo@loongson.cn> wrote:
>
> collapse huge page is slow, specially when khugepaged daemon runs
> on different numa node with that of huge page. It suffers from
> huge page copying across nodes, also cache is not used for target
> node. With this patch, khugepaged daemon switches to the same numa
> node with huge page. It saves copying time and makes use of local
> cache better.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  mm/khugepaged.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 131492fd1148..460c285dc974 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -116,6 +116,7 @@ struct khugepaged_scan {
>         struct list_head mm_head;
>         struct mm_slot *mm_slot;
>         unsigned long address;
> +       int node;
>  };
>
>  static struct khugepaged_scan khugepaged_scan = {
> @@ -1066,6 +1067,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>         struct vm_area_struct *vma;
>         struct mmu_notifier_range range;
>         gfp_t gfp;
> +       const struct cpumask *cpumask;
>
>         VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>
> @@ -1079,6 +1081,13 @@ static void collapse_huge_page(struct mm_struct *mm,
>          * that. We will recheck the vma after taking it again in write mode.
>          */
>         mmap_read_unlock(mm);
> +
> +       /* sched to specified node before huage page memory copy */
> +       cpumask = cpumask_of_node(node);
> +       if ((khugepaged_scan.node != node) && !cpumask_empty(cpumask)) {
> +               set_cpus_allowed_ptr(current, cpumask);
> +               khugepaged_scan.node = node;

What if khugepaged was scheduled to the other nodes after this, but
khugepaged_scan.node still equals to node? It seems possible to me
IIUC.

TBH I'm not quite sure if migrating khugepaged is really worth it for
everyone or not. The worst case is the locality of base pages are not
obvious, for example, the base pages may be across all nodes, so you
always get cross nodes memory copy. And khugepaged may get slower if
cpu is contentious.

In addition, I saw MIPS has its own copy_user_highpage(), is it a
contributing factor too?

> +       }
>         new_page = khugepaged_alloc_page(hpage, gfp, node);
>         if (!new_page) {
>                 result = SCAN_ALLOC_HUGE_PAGE_FAIL;
> @@ -2380,6 +2389,7 @@ int start_stop_khugepaged(void)
>                 kthread_stop(khugepaged_thread);
>                 khugepaged_thread = NULL;
>         }
> +       khugepaged_scan.node = NUMA_NO_NODE;
>         set_recommended_min_free_kbytes();
>  fail:
>         mutex_unlock(&khugepaged_mutex);
> --
> 2.31.1
>
>
