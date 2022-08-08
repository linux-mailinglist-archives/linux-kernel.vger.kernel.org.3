Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F375058CD12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243956AbiHHRxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243790AbiHHRw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:52:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D461E014
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:52:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h28so8706616pfq.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=S+ALw+zxwoElSdpM2BnSOSVXonKoUHWxzuzIcleCq5I=;
        b=HtjDVsSuInOUTxsxit3SJUQgxt/928sEuPB6aHh/wZ66RG63zi6pf1XnuYd2FzrNNd
         cSBv5nRJaef6324O044wYLr1R5M+8L7QvHJqgn0qmn3uscRnRfdrduYWhF9zE9GlcRJs
         M/W1jHgd1+2M11g0BOuaSaRJQfz72e3bheKjTQbXu3x7rXyHKF+QZhfI2Lb0qUCns/4/
         1NS+jmBIxmmD8MH/ZXzj41rr3fFw17h5Tc4OFPqVNMiL+QdaguzAyt+LQCCwlzvuAOPn
         XJX6i8ut9rePvWDZlhueH0XIBiheRHnsIzOzAt5n8Gu5el2ZszlGBUixWCyW8LGHeqH4
         +uFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=S+ALw+zxwoElSdpM2BnSOSVXonKoUHWxzuzIcleCq5I=;
        b=g4FPDr1Brnc4Is8zI4VAfKNyH6VBG4OvY0ucrMVK3PVYbTnqBl9y48cpoUYcA7DS31
         Ggu9URij8VPDijao3av0qb4InlA1J2BboteuLkZuawNYCh4F3eezSkE4u0sNkBXwvcKG
         yRzSek1oG5p4muiB3ZUVnr5nhVYDfeK9+W3in5pJDs7ebjDaoW1GliUs/olf639Mnuev
         iC4ZXA79qPf1C2FBpPsgB9Zcm6wYwDKUuJuifsTdIupBbFSUxuK69xsDnDQOoYdhGlDp
         /sF8lfCsWXu0JfOhozPjnkFIDBlar3/f1ATSw7hQnQhV8Wmic6DKjP4bD2Z+Q2SaByPn
         amUg==
X-Gm-Message-State: ACgBeo22Qtb77m0tNq6n2HMNtT1nQmzTwUvsDdNIzHFQ8EUyOH+4wwxG
        emrjuy4JOboJGj8Wnoh83xwbecZhTOwy+dfWKK4=
X-Google-Smtp-Source: AA6agR4hs0/7SGPgh69OnUgLRAq+qYs/IyFuxS95p1VUNBFy02OARI+34nG6xFV0M2NDe/pd7rMb1txN7vh7GrO+JkI=
X-Received: by 2002:a63:8848:0:b0:41c:45da:2db9 with SMTP id
 l69-20020a638848000000b0041c45da2db9mr15920424pgd.206.1659981177048; Mon, 08
 Aug 2022 10:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220805184016.2926168-1-alexlzhu@fb.com>
In-Reply-To: <20220805184016.2926168-1-alexlzhu@fb.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Aug 2022 10:52:44 -0700
Message-ID: <CAHbLzkoNQQBZZtm7ts_mLJxn7ShvHRudH0qELOiyTcgcq3kaOg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to /proc/thp_utilization
To:     alexlzhu@fb.com
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
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

On Fri, Aug 5, 2022 at 11:40 AM <alexlzhu@fb.com> wrote:
>
> From: Alexander Zhu <alexlzhu@fb.com>
>
> THPs have historically been enabled on a per application basis due to
> performance increase or decrease depending on how the particular
> application uses physical memory. When THPs are heavily utilized,
> application performance improves due to fewer TLB cache misses.
> It has long been suspected that performance regressions when THP
> is enabled happens due to heavily underutilized anonymous THPs.
>
> Previously there was no way to track how much of a THP is
> actually being used. With this change, we seek to gain visibility
> into the utilization of THPs in order to make more intelligent
> decisions regarding paging.
>
> This change introduces a tool that scans through all of physical
> memory for anonymous THPs and groups them into buckets based
> on utilization. It also includes an interface under
> /proc/thp_utilization.
>
> Utilization of a THP is defined as the percentage of nonzero
> pages in the THP. The worker thread will scan through all
> of physical memory and obtain utilization of all anonymous
> THPs. It will gather this information by periodically scanning
> through all of physical memory for anonymous THPs, group them
> into buckets based on utilization, and report utilization
> information through /proc/thp_utilization.
>
> Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst |   5 +
>  Documentation/filesystems/proc.rst         |  30 ++++
>  include/linux/huge_mm.h                    |   2 +
>  mm/huge_memory.c                           | 167 +++++++++++++++++++++
>  4 files changed, 204 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index c9c37f16eef8..46ebdd8ea0d1 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -297,6 +297,11 @@ To identify what applications are mapping file transparent huge pages, it
>  is necessary to read ``/proc/PID/smaps`` and count the FileHugeMapped fields
>  for each mapping.
>
> +The utilization of transparent hugepages can be viewed by reading
> +``/proc/thp_utilization``. This shows the number of THPs per
> +utilization bucket and the number of zero pages in each bucket. The
> +last two lines show the time and the duration of the last scan.
> +
>  Note that reading the smaps file is expensive and reading it
>  frequently will incur overhead.
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 1bc91fb8c321..bb49e97cc469 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -720,6 +720,7 @@ files are there, and which are missing.
>   sys          See chapter 2
>   sysvipc      Info of SysVIPC Resources (msg, sem, shm)                (2.4)
>   tty         Info of tty drivers
> + thp_utilization             Info on thp utilization
>   uptime       Wall clock since boot, combined idle time of all cpus
>   version      Kernel version
>   video               bttv info of video resources                      (2.4)
> @@ -1158,6 +1159,35 @@ DirectMap4k, DirectMap2M, DirectMap1G
>                Breakdown of page table sizes used in the kernel's
>                identity mapping of RAM
>
> +thp_utilization
> +~~~~~~~~~~~~~~~
> +
> +Provides information on the utilization of Transparent Hugepages. The
> +utilization of a THP is defined as the ratio of non zero filled 4kb
> +pages to the total number of pages in a THP. The buckets are labelled
> +by the range of total utilized 4kb pages with one line per utilization
> +bucket. Each line contains the total number of THPs in that bucket
> +and the total number of zero filled 4kb pages summed over all THPs
> +in that bucket. The last two lines show the timestamp and duration
> +respectively of the most recent scan over all of physical memory.
> +
> +::
> +
> +    > cat /proc/thp_utilization
> +    Utilized[0-50]: 435 217667
> +    Utilized[51-101]: 58 25394
> +    Utilized[102-152]: 51 19605
> +    Utilized[153-203]: 43 14169
> +    Utilized[204-255]: 54 15300
> +    Utilized[256-306]: 55 12537
> +    Utilized[307-357]: 49 8675
> +    Utilized[358-408]: 67 8601
> +    Utilized[409-459]: 82 6259
> +    Utilized[460-512]: 189 2613
> +    Last Scan Time: 1202.83
> +    Last Scan Duration: 70.72

I'm not sure how useful the system level THP utilization is. IMHO the
THP utilization is quite application specific. So the per task stats
might be more useful than system level IMHO.

> +
> +
>  vmallocinfo
>  ~~~~~~~~~~~
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index de29821231c9..0ece9d53ab48 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -196,6 +196,8 @@ bool transparent_hugepage_active(struct vm_area_struct *vma);
>  unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>                 unsigned long len, unsigned long pgoff, unsigned long flags);
>
> +int thp_number_utilized_pages(struct page *page);
> +
>  void prep_transhuge_page(struct page *page);
>  void free_transhuge_page(struct page *page);
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 834f288b3769..a393fa491632 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -30,6 +30,7 @@
>  #include <linux/hashtable.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/page_idle.h>
> +#include <linux/proc_fs.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/oom.h>
>  #include <linux/numa.h>
> @@ -44,6 +45,16 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/thp.h>
>
> +/*
> + * The number of utilization buckets THPs will be grouped in
> + * under /proc/thp_utilization.
> + */
> +#define THP_UTIL_BUCKET_NR 10
> +/*
> + * The number of addresses to scan through on each periodic
> + * run of the scanner that generates /proc/thp_utilization.
> + */
> +#define THP_UTIL_SCAN_SIZE 256
>  /*
>   * By default, transparent hugepage support is disabled in order to avoid
>   * risking an increased memory footprint for applications that are not
> @@ -69,6 +80,52 @@ static atomic_t huge_zero_refcount;
>  struct page *huge_zero_page __read_mostly;
>  unsigned long huge_zero_pfn __read_mostly = ~0UL;
>
> +static void thp_utilization_workfn(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(thp_utilization_work, thp_utilization_workfn);
> +
> +struct thp_scan_info_bucket {
> +       int nr_thps;
> +       int nr_zero_pages;
> +};
> +
> +struct thp_scan_info {
> +       struct thp_scan_info_bucket buckets[THP_UTIL_BUCKET_NR];
> +       struct zone *scan_zone;
> +       struct timespec64 last_scan_duration;
> +       struct timespec64 last_scan_time;
> +       unsigned long pfn;
> +};
> +
> +static struct thp_scan_info thp_scan_proc;
> +static struct thp_scan_info thp_scan;
> +
> +static int thp_utilization_show(struct seq_file *seqf, void *pos)
> +{
> +       int i;
> +       int start;
> +       int end;
> +
> +       for (i = 0; i < THP_UTIL_BUCKET_NR; i++) {
> +               start = i * HPAGE_PMD_NR / THP_UTIL_BUCKET_NR;
> +               end = (i + 1 == THP_UTIL_BUCKET_NR)
> +                          ? HPAGE_PMD_NR
> +                          : ((i + 1) * HPAGE_PMD_NR / THP_UTIL_BUCKET_NR - 1);
> +               /* The last bucket will need to contain 100 */
> +               seq_printf(seqf, "Utilized[%d-%d]: %d %d\n", start, end,
> +                          thp_scan_proc.buckets[i].nr_thps,
> +                          thp_scan_proc.buckets[i].nr_zero_pages);
> +       }
> +       seq_printf(seqf, "Last Scan Time: %lu.%02lu\n",
> +                  (unsigned long)thp_scan_proc.last_scan_time.tv_sec,
> +                  (thp_scan_proc.last_scan_time.tv_nsec / (NSEC_PER_SEC / 100)));
> +
> +       seq_printf(seqf, "Last Scan Duration: %lu.%02lu\n",
> +                  (unsigned long)thp_scan_proc.last_scan_duration.tv_sec,
> +                  (thp_scan_proc.last_scan_duration.tv_nsec / (NSEC_PER_SEC / 100)));
> +
> +       return 0;
> +}
> +
>  bool transparent_hugepage_active(struct vm_area_struct *vma)
>  {
>         /* The addr is used to check if the vma size fits */
> @@ -423,6 +480,9 @@ static int __init hugepage_init(void)
>         if (err)
>                 goto err_slab;
>
> +       proc_create_single("thp_utilization", 0, NULL, &thp_utilization_show);
> +       schedule_delayed_work(&thp_utilization_work, HZ);
> +
>         err = register_shrinker(&huge_zero_page_shrinker);
>         if (err)
>                 goto err_hzp_shrinker;
> @@ -537,6 +597,12 @@ static inline bool is_transparent_hugepage(struct page *page)
>                page[1].compound_dtor == TRANSHUGE_PAGE_DTOR;
>  }
>
> +bool is_anon_transparent_hugepage(struct page *page)
> +{
> +       return PageAnon(page) && is_transparent_hugepage(page);
> +}
> +EXPORT_SYMBOL_GPL(is_anon_transparent_hugepage);
> +
>  static unsigned long __thp_get_unmapped_area(struct file *filp,
>                 unsigned long addr, unsigned long len,
>                 loff_t off, unsigned long flags, unsigned long size)
> @@ -587,6 +653,34 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>
> +int thp_number_utilized_pages(struct page *page)
> +{
> +       unsigned long page_index, page_offset, value;
> +       int thp_nr_utilized_pages = HPAGE_PMD_NR;
> +       int step_size = sizeof(unsigned long);
> +       bool is_all_zeroes;
> +       void *kaddr;
> +
> +       if (!page || !is_anon_transparent_hugepage(page))
> +               return -1;
> +
> +       kaddr = kmap_local_page(page);
> +       for (page_index = 0; page_index < HPAGE_PMD_NR; page_index++) {
> +               is_all_zeroes = true;
> +               for (page_offset = 0; page_offset < PAGE_SIZE; page_offset += step_size) {
> +                       value = *(unsigned long *)(kaddr + page_index * PAGE_SIZE + page_offset);
> +                       if (value != 0) {
> +                               is_all_zeroes = false;
> +                               break;
> +                       }
> +               }
> +               if (is_all_zeroes)
> +                       thp_nr_utilized_pages--;
> +       }
> +       kunmap_local(kaddr);
> +       return thp_nr_utilized_pages;
> +}
> +
>  static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>                         struct page *page, gfp_t gfp)
>  {
> @@ -3167,3 +3261,76 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>         trace_remove_migration_pmd(address, pmd_val(pmde));
>  }
>  #endif
> +
> +static void thp_scan_next_zone(void)
> +{
> +       struct timespec64 current_time;
> +       int i;
> +       bool update_proc;
> +
> +       thp_scan.scan_zone = next_zone(thp_scan.scan_zone);
> +       update_proc = !thp_scan.scan_zone;
> +       thp_scan.scan_zone = update_proc ? (first_online_pgdat())->node_zones
> +                       : thp_scan.scan_zone;
> +       thp_scan.pfn = (thp_scan.scan_zone->zone_start_pfn + HPAGE_PMD_NR - 1)
> +                       & ~(HPAGE_PMD_SIZE - 1);
> +       if (!update_proc)
> +               return;
> +
> +       ktime_get_ts64(&current_time);
> +       thp_scan_proc.last_scan_duration = timespec64_sub(current_time,
> +                                                         thp_scan_proc.last_scan_time);
> +       thp_scan_proc.last_scan_time = current_time;
> +
> +       for (i = 0; i < THP_UTIL_BUCKET_NR; i++) {
> +               thp_scan_proc.buckets[i].nr_thps = thp_scan.buckets[i].nr_thps;
> +               thp_scan_proc.buckets[i].nr_zero_pages = thp_scan.buckets[i].nr_zero_pages;
> +               thp_scan.buckets[i].nr_thps = 0;
> +               thp_scan.buckets[i].nr_zero_pages = 0;
> +       }
> +}
> +
> +static void thp_util_scan(unsigned long pfn_end)
> +{
> +       struct page *page, *head = NULL;
> +       int bucket, num_utilized_pages, current_pfn;
> +       int i;
> +
> +       for (i = 0; i < THP_UTIL_SCAN_SIZE; i++) {
> +               current_pfn = thp_scan.pfn;
> +               thp_scan.pfn += HPAGE_PMD_NR;
> +               if (current_pfn >= pfn_end)
> +                       return;
> +               if (!pfn_valid(current_pfn))
> +                       continue;
> +
> +               page = pfn_to_page(current_pfn);
> +               num_utilized_pages = thp_number_utilized_pages(page);
> +               if (num_utilized_pages < 0)
> +                       continue;
> +
> +               head = compound_head(page);
> +               bucket = num_utilized_pages * THP_UTIL_BUCKET_NR / HPAGE_PMD_NR;
> +               bucket = min(bucket, THP_UTIL_BUCKET_NR - 1);
> +               thp_scan.buckets[bucket].nr_thps++;
> +               thp_scan.buckets[bucket].nr_zero_pages += (HPAGE_PMD_NR - num_utilized_pages);
> +       }
> +}
> +
> +static void thp_utilization_workfn(struct work_struct *work)
> +{
> +       unsigned long pfn_end;
> +
> +       if (!thp_scan.scan_zone)
> +               thp_scan.scan_zone = (first_online_pgdat())->node_zones;
> +
> +       pfn_end = (thp_scan.scan_zone->zone_start_pfn +
> +                       thp_scan.scan_zone->spanned_pages + HPAGE_PMD_NR - 1)
> +                       & ~(HPAGE_PMD_SIZE - 1);
> +       if (!populated_zone(thp_scan.scan_zone) || thp_scan.pfn >= pfn_end)
> +               thp_scan_next_zone();
> +       else
> +               thp_util_scan(pfn_end);
> +
> +       schedule_delayed_work(&thp_utilization_work, HZ);
> +}
> --
> 2.30.2
>
>
