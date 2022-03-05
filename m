Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE584CE404
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiCEJuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 04:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiCEJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 04:50:32 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D446B33
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 01:49:42 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id y1so4552874uap.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 01:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXfxpaGzGztotPNKJTsTsiomGMZzwNlkorpTqFh7zdY=;
        b=Uvy8B5wL5vgK0avqv18xOzNigJnTMM0Xc2KfIo3DLR3jZgO0WhYai1M+Y/oxUzyylE
         ad3Cfg9uNyuBgalI+VDIH0MAalmhZ6cZ1uDzPl2lI6ldB4d/ih3BdPHvC6EHzTSdJ1qK
         kSL7ZmDuaGOs34YHhl1E3kpE/DkShWNi6Pgi2VTWcYi4zUaLou7xTFtRq4ePVvYKGT3X
         yAj15fwbm69/o2YA8mW0BKSp7TT885h34Z+3wVmSgh1sBViEJQH1qQLiQMpYuxvmKXBG
         Af7/GubilyZ7rjDWgdky7itu+Mw3xoCOpbPFz4WZixzQZr9ITZQwnBnUqIDqXJcUYff9
         Zwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXfxpaGzGztotPNKJTsTsiomGMZzwNlkorpTqFh7zdY=;
        b=Zn2ARHmC/gQY9i516QeVP/ny4DrX47La5Kqw08kTsJJFHqIg/oa4thSyi9Sv24ESta
         JigHE4qr1YVGL59fKd9pqaCmA+0hOgm2jLeLsX5pMRj/lymSrwKzD0gr9pNxREiDdL6r
         PT6/NoyHtWxHFLaDAnBA7UXbItBF+5esEgFZeX7bmVdd23/n3VQSBYyRMLcyTjWzoMe2
         61XlPY3NOsVmyg104j8SXHHMqjho7xva5z8OtvsN5zFT2abkLl+gsvZ1rub5EatJywnz
         o8sV1LrgD5ZJq+nP2sqacYNW+igVyaGUXMjdNPtIdLfpzDBrSYeuW5He2BSWf3WzJagg
         Btrw==
X-Gm-Message-State: AOAM5334ozapkRD0JS5tmKt4G9AanY0Ijm2zRh0JeoiVcEhwYyS/DXXd
        zscG/EFKnyeb9f2ovAQ5Pbs8GiqR4Cczlu3svNthYQ==
X-Google-Smtp-Source: ABdhPJy8KMJvKdMk2ispNYQEZV7RgLzcjz2DPF0ZzgxMUdailI+sOnka150Wmxvl1ZLj0tqdoxGb686IqXQQRn+c1k8=
X-Received: by 2002:a9f:218e:0:b0:347:6ee5:d182 with SMTP id
 14-20020a9f218e000000b003476ee5d182mr877746uac.112.1646473780926; Sat, 05 Mar
 2022 01:49:40 -0800 (PST)
MIME-Version: 1.0
References: <dd620dbd-6d71-7553-d1e9-95676ff12c82@nutanix.com>
 <YiKsUr1FQwmDP7V0@google.com> <CAOUHufZyrLrkEvFay+FddN5Ve3v_-JvNROHo9hEhsoVuCpwh0Q@mail.gmail.com>
In-Reply-To: <CAOUHufZyrLrkEvFay+FddN5Ve3v_-JvNROHo9hEhsoVuCpwh0Q@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 5 Mar 2022 02:49:29 -0700
Message-ID: <CAOUHufaBi5Js6HXCO3R5nOo-+NiWajmDjM4mpx6H55JWS3auGQ@mail.gmail.com>
Subject: Re: Regression of madvise(MADV_COLD) on shmem?
To:     Minchan Kim <minchan@kernel.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>, dancol@google.com,
        Shakeel Butt <shakeelb@google.com>, sonnyrao@google.com,
        oleksandr@redhat.com, Hillf Danton <hdanton@sina.com>,
        lizeb@google.com, Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 5, 2022 at 2:17 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Fri, Mar 4, 2022 at 5:18 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Fri, Mar 04, 2022 at 05:55:58PM +0000, Ivan Teterevkov wrote:
> > > Hi folks,
> > >
> > > I want to check if there's a regression in the madvise(MADV_COLD) behaviour
> > > with shared memory or my understanding of how it works is inaccurate.
> > >
> > > The MADV_COLD advice was introduced in Linux 5.4 and allowed the users to
> > > mark selected memory ranges as more "inactive" than others, overruling the
> > > default LRU accounting. It helped to preserve the working set of an
> > > application. With more recent kernels, e.g. at least 5.17.0-rc6 and 5.10.42,
> > > MADV_COLD has stopped working as expected. Please take a look at a short
> > > program that demonstrates it:
> > >
> > >     /*
> > >      * madvise(MADV_COLD) demo.
> > >      */
> > >     #include <assert.h>
> > >     #include <stdio.h>
> > >     #include <stdlib.h>
> > >     #include <string.h>
> > >     #include <sys/mman.h>
> > >
> > >     /* Requires the kernel 5.4 or newer. */
> > >     #ifndef MADV_COLD
> > >     #define MADV_COLD 20
> > >     #endif
> > >
> > >     #define GIB(x) ((size_t)(x) << 30)
> > >
> > >     int main(void)
> > >     {
> > >         char *shmem, *zeroes;
> > >         int page_size = getpagesize();
> > >         size_t i;
> > >
> > >         /* Allocate 8 GiB of shared memory. */
> > >         shmem = mmap(/* addr */ NULL,
> > >                      /* length */ GIB(8),
> > >                      /* prot */ PROT_READ | PROT_WRITE,
> > >                      /* flags */ MAP_SHARED | MAP_ANONYMOUS,
> > >                      /* fd */ -1,
> > >                      /* offset */ 0);
> > >         assert(shmem != MAP_FAILED);
> > >
> > >         /* Allocate a zero page for future use. */
> > >         zeroes = calloc(1, page_size);
> > >         assert(zeroes != NULL);
> > >
> > >         /* Put 1 GiB blob at the beginning of the shared memory range. */
> > >         memset(shmem, 0xaa, GIB(1));
> > >
> > >         /* Read memory adjacent to the blob. */
> > >         for (i = GIB(1); i < GIB(8); i = i + page_size) {
> > >             int res = memcmp(shmem + i, zeroes, page_size);
> > >             assert(res == 0);
> > >
> > >             /* Cooldown a zero page and make it "less active" than the blob.
> > >              * Under memory pressure, it'll likely become a reclaim target
> > >              * and thus will help to preserve the blob in memory.
> > >              */
> > >             res = madvise(shmem + i, page_size, MADV_COLD);
> > >             assert(res == 0);
> > >         }
> > >
> > >         /* Let the user check smaps. */
> > >         printf("done\n");
> > >         pause();
> > >
> > >         free(zeroes);
> > >         munmap(shmem, GIB(8));
> > >
> > >         return 0;
> > >     }
> > >
> > > How to run this program:
> > >
> > > 1. Create a "test" cgroup with a memory limit of 3 GiB.
> > >
> > > 1.1. cgroup v1:
> > >
> > >     # mkdir /sys/fs/cgroup/memory/test
> > >     # echo 3G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
> > >
> > > 1.2. cgroup v2:
> > >
> > >     # mkdir /sys/fs/cgroup/test
> > >     # echo 3G > /sys/fs/cgroup/test/memory.max
> > >
> > > 2. Enable at least a 1 GiB swap device.
> > >
> > > 3. Run the program in the "test" cgroup:
> > >
> > >     # cgexec -g memory:test ./a.out
> > >
> > > 4. Wait until it has finished, i.e. has printed "done".
> > >
> > > 5. Check the shared memory VMA stats.
> > >
> > > 5.1. In 5.17.0-rc6 and 5.10.42:
> > >
> > >     # cat /proc/$(pidof a.out)/smaps | grep -A 21 -B 1 8388608
> > >     7f8ed4648000-7f90d4648000 rw-s 00000000 00:01 2055      /dev/zero
> > > (deleted)
> > >     Size:            8388608 kB
> > >     KernelPageSize:        4 kB
> > >     MMUPageSize:           4 kB
> > >     Rss:             3119556 kB
> > >     Pss:             3119556 kB
> > >     Shared_Clean:          0 kB
> > >     Shared_Dirty:          0 kB
> > >     Private_Clean:   3119556 kB
> > >     Private_Dirty:         0 kB
> > >     Referenced:            0 kB
> > >     Anonymous:             0 kB
> > >     LazyFree:              0 kB
> > >     AnonHugePages:         0 kB
> > >     ShmemPmdMapped:        0 kB
> > >     FilePmdMapped:         0 kB
> > >     Shared_Hugetlb:        0 kB
> > >     Private_Hugetlb:       0 kB
> > >     Swap:            1048576 kB
> > >     SwapPss:               0 kB
> > >     Locked:                0 kB
> > >     THPeligible:    0
> > >     VmFlags: rd wr sh mr mw me ms sd
> > >
> > > 5.2. In 5.4.109:
> > >
> > >     # cat /proc/$(pidof a.out)/smaps | grep -A 21 -B 1 8388608
> > >     7fca5f78b000-7fcc5f78b000 rw-s 00000000 00:01 173051      /dev/zero
> > > (deleted)
> > >     Size:            8388608 kB
> > >     KernelPageSize:        4 kB
> > >     MMUPageSize:           4 kB
> > >     Rss:             3121504 kB
> > >     Pss:             3121504 kB
> > >     Shared_Clean:          0 kB
> > >     Shared_Dirty:          0 kB
> > >     Private_Clean:   2072928 kB
> > >     Private_Dirty:   1048576 kB
> > >     Referenced:            0 kB
> > >     Anonymous:             0 kB
> > >     LazyFree:              0 kB
> > >     AnonHugePages:         0 kB
> > >     ShmemPmdMapped:        0 kB
> > >     FilePmdMapped:        0 kB
> > >     Shared_Hugetlb:        0 kB
> > >     Private_Hugetlb:       0 kB
> > >     Swap:                  0 kB
> > >     SwapPss:               0 kB
> > >     Locked:                0 kB
> > >     THPeligible:            0
> > >     VmFlags: rd wr sh mr mw me ms
> > >
> > > There's a noticeable difference in the "Swap" reports so that the older
> > > kernel doesn't swap the blob, but the newer ones do.
> > >
> > > According to ftrace, the newer kernels still call deactivate_page() in
> > > madvise_cold():
> > >
> > > # trace-cmd record -p function_graph -g madvise_cold
> > > # trace-cmd report | less
> > >     a.out-4877  [000]  1485.266106: funcgraph_entry: |  madvise_cold() {
> > >     a.out-4877  [000]  1485.266115: funcgraph_entry: |    walk_page_range()
> > > {
> > >     a.out-4877  [000]  1485.266116: funcgraph_entry: |
> > > __walk_page_range() {
> > >     a.out-4877  [000]  1485.266117: funcgraph_entry: |
> > > madvise_cold_or_pageout_pte_range() {
> > >     a.out-4877  [000]  1485.266118: funcgraph_entry:        0.179 us |
> > > deactivate_page();
> > >
> > > (The irrelevant bits are removed for brevity.)
> > >
> > > It makes me think there may be a regression in MADV_COLD. Please let me know
> > > what do you reckon?
> >
> > Since deactive_page is called, I guess that's not a regression(?) from [1]
> >
> > Then, my random guess that you mentioned "Swap" as regression might be
> > related to "workingset detection for anon page" since kernel changes balancing
> > policy between file and anonymous LRU, which was merged into v5.8.
> > It would be helpful to see if you try it on v5.7 and v5.8.
> >
> > [1] 12e967fd8e4e6, mm: do not allow MADV_PAGEOUT for CoW page
>
> Yes, I noticed this for a while. With commit b518154e59a ("mm/vmscan:
> protect the workingset on anonymous LRU"), anon/shmem pages start on
> the inactive lru, and in this case, deactive_page() is a NOP. Before
> 5.9, anon/shmem pages start on the active lru, deactive_page() moves
> zero pages in the test to the inactive lru and therefore protests the
> "blob".
>
> This should fix the problem for your test case:
>
> diff --git a/mm/swap.c b/mm/swap.c
> index bcf3ac288b56..7fd99f037ca7 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -563,7 +559,7 @@ static void lru_deactivate_file_fn(struct page
> *page, struct lruvec *lruvec)
>
>  static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
>  {
> -       if (PageActive(page) && !PageUnevictable(page)) {
> +       if (!PageUnevictable(page)) {
>                 int nr_pages = thp_nr_pages(page);
>
>                 del_page_from_lru_list(page, lruvec);

Missed one line below:

                ClearPageActive(page);
                ClearPageReferenced(page);
-               add_page_to_lru_list(page, lruvec);
+               add_page_to_lru_list_tail(page, lruvec);

                __count_vm_events(PGDEACTIVATE, nr_pages);
                __count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,

> @@ -677,7 +673,7 @@ void deactivate_file_page(struct page *page)
>   */
>  void deactivate_page(struct page *page)
>  {
> -       if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
> +       if (PageLRU(page) && !PageUnevictable(page)) {
>                 struct pagevec *pvec;
>
>                 local_lock(&lru_pvecs.lock);
>
> I'll leave it to Minchan to decide whether this is worth fixing,
> together with this one:
>
> diff --git a/mm/swap.c b/mm/swap.c
> index bcf3ac288b56..2f142f09c8e1 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -529,10 +529,6 @@ static void lru_deactivate_file_fn(struct page
> *page, struct lruvec *lruvec)
>         if (PageUnevictable(page))
>                 return;
>
> -       /* Some processes are using the page */
> -       if (page_mapped(page))
> -               return;
> -
>         del_page_from_lru_list(page, lruvec);
>         ClearPageActive(page);
>         ClearPageReferenced(page);
