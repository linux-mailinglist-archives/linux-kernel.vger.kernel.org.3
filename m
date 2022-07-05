Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BE35662B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiGEFVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGEFU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:20:59 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3781C12624
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 22:20:58 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3137316bb69so97640547b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 22:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCVzYAf8Ry1kx4tzjm0xtpxQrKLwUnpUZ/IpIuvVBsw=;
        b=UrY7H/FILQyfAI3YTBmbcC8oSf5c2vzX3aM39AELofS+pvpGy/pJSpvDGWk7ow8aCq
         sPb1XK2ww9lwq0a9S+FoUcj/llLHkEUKUs4HZ5OdQE0HncGnn/eAhg0rXbiVr6HlOGfR
         MyJAVWBNU/lU35hcX3+GWbkaItFU2MYqUBGXYX10JFkBRrZNWV21od3zZy9c/j0RIwvX
         MIApigCo9D6zlHgMe11q2chkmGZxtLjWHeqVy/FkNZK4DifeaRGQ2fmyi+vjVZYU8uF7
         1psqitj/046dkLAKwDs9/bLo3XRwv1c4FXV5qKQlfWqvej6KMLhrROp1RA1GFwFmZAGQ
         uJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCVzYAf8Ry1kx4tzjm0xtpxQrKLwUnpUZ/IpIuvVBsw=;
        b=2NmUMA61yb8PZJmXhQlKLKb2xfpMQiNBfC4AazZvNGjKCOUICrVc7RFeU6tMUBXl2V
         Rl7XTtOxFl7oiQHRb1Rjvkixi706T3d4xGmM2InAZtu/sRPKHbtDUw1qYDkSJRV5Jj5D
         SUp6yOWr3FHzwInKj89A0bxqo6J3JcE8TqM1zkV6ZJ0ANWIXFLxYsMg5p+6F6yDQeRTY
         WBxuJiVmrvJ/cC3mJ+U1/N/6SpR1zbNJm7Y4AiTucV6WsksiY759diAMl/xpTMR7RVob
         RA2rLs2Hiz1EpRKimMq7s9snNgZxjLpQaPYsJIvaFgHj8gtIYKmSFUD6PRCacJRD+yMy
         IbcQ==
X-Gm-Message-State: AJIora+WH3OZTlStK9L9o0kjkdamfDCnSNjxdJjKzptkZqyQKlUrfRQ1
        DJKmIYXMTHOypldtrYeWrZA+xIVhxR/pEfVg6OpYIw==
X-Google-Smtp-Source: AGRyM1sMifOPi8MloaMBhNhfVAE0Y5BcKvecu2CtTb+I9/WgbR9lJMpe4XF8OZvBqDLUvay5IQzt8wfWDxZV47IIIa0=
X-Received: by 2002:a81:f0d:0:b0:31c:8860:c59f with SMTP id
 13-20020a810f0d000000b0031c8860c59fmr14279076ywp.31.1656998457400; Mon, 04
 Jul 2022 22:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220705034841.40931-1-ligang.bdlg@bytedance.com>
In-Reply-To: <20220705034841.40931-1-ligang.bdlg@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 5 Jul 2022 13:20:19 +0800
Message-ID: <CAMZfGtX+1rVOCCVotpdPpPQ6qE=0BARghqabPw2owr-eJbCRCA@mail.gmail.com>
Subject: Re: [PATCH v2] mm, hugetlb: skip irrelevant nodes in show_free_areas()
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 11:49 AM Gang Li <ligang.bdlg@bytedance.com> wrote:
>
> show_free_areas() allows to filter out node specific data which is
> irrelevant to the allocation request. But hugetlb_show_meminfo() still
> show hugetlb on all nodes, which is redundant and unnecessary.

s/show/shows/g

>
> Use show_mem_node_skip() to skip irrelevant nodes. And replace
> hugetlb_show_meminfo() with hugetlb_show_meminfo_node(nid).
>
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
> v2: replace hugetlb_show_meminfo() with hugetlb_show_meminfo_node(nid) to avoid
>     exporting show_mem_node_skip.
> ---
>  include/linux/hugetlb.h |  4 ++--
>  mm/hugetlb.c            | 21 ++++++++-------------
>  mm/page_alloc.c         | 10 ++++++++--
>  3 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 29c4d0883d36..21795e62398b 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -155,7 +155,7 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
>                           struct page *ref_page, zap_flags_t zap_flags);
>  void hugetlb_report_meminfo(struct seq_file *);
>  int hugetlb_report_node_meminfo(char *buf, int len, int nid);
> -void hugetlb_show_meminfo(void);
> +void hugetlb_show_meminfo_node(int nid);
>  unsigned long hugetlb_total_pages(void);
>  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>                         unsigned long address, unsigned int flags);
> @@ -301,7 +301,7 @@ static inline int hugetlb_report_node_meminfo(char *buf, int len, int nid)
>         return 0;
>  }
>
> -static inline void hugetlb_show_meminfo(void)
> +static inline void hugetlb_show_meminfo_node(int nid)
>  {
>  }
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ca081078e814..c87049c4126e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4490,22 +4490,17 @@ int hugetlb_report_node_meminfo(char *buf, int len, int nid)
>                              nid, h->surplus_huge_pages_node[nid]);
>  }
>
> -void hugetlb_show_meminfo(void)
> +void hugetlb_show_meminfo_node(int nid)
>  {
>         struct hstate *h;
> -       int nid;
>
> -       if (!hugepages_supported())
> -               return;

It is better not to delete this, I know you want to lower the overhead
for users when
!hugepages_supported(). However, it is not a common case and not a hot path.

> -
> -       for_each_node_state(nid, N_MEMORY)
> -               for_each_hstate(h)
> -                       pr_info("Node %d hugepages_total=%u hugepages_free=%u hugepages_surp=%u hugepages_size=%lukB\n",
> -                               nid,
> -                               h->nr_huge_pages_node[nid],
> -                               h->free_huge_pages_node[nid],
> -                               h->surplus_huge_pages_node[nid],
> -                               huge_page_size(h) / SZ_1K);
> +       for_each_hstate(h)
> +               pr_info("Node %d hugepages_total=%u hugepages_free=%u hugepages_surp=%u hugepages_size=%lukB\n",

It is better to use printk here. Two reasons.

 1) To keep consistent with the print in show_free_areas().
 2) If we want to introduce the macro "#define pr_fmt(fmt) "HugeTLB: "
fmt" to hugetlb.c
    in the future, the print here will not be affected.

> +                       nid,
> +                       h->nr_huge_pages_node[nid],
> +                       h->free_huge_pages_node[nid],
> +                       h->surplus_huge_pages_node[nid],
> +                       huge_page_size(h) / SZ_1K);
>  }
>
>  void hugetlb_report_usage(struct seq_file *m, struct mm_struct *mm)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2eb6ad5a650a..684c2e410923 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6014,7 +6014,7 @@ static void show_migration_types(unsigned char type)
>  void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>  {
>         unsigned long free_pcp = 0;
> -       int cpu;
> +       int cpu, nid;
>         struct zone *zone;
>         pg_data_t *pgdat;
>
> @@ -6202,7 +6202,13 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
>                 printk(KERN_CONT "= %lukB\n", K(total));
>         }
>
> -       hugetlb_show_meminfo();
> +       if (hugepages_supported()) {

As I said above, embed this check into hugetlb_show_meminfo_node().

> +               for_each_node_state(nid, N_MEMORY) {

Please use for_each_online_node here.

Thanks.

> +                       if (show_mem_node_skip(filter, nid, nodemask))
> +                               continue;
> +                       hugetlb_show_meminfo_node(nid);
> +               }
> +       }
>
>         printk("%ld total pagecache pages\n", global_node_page_state(NR_FILE_PAGES));
>
> --
> 2.20.1
>
