Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7227C4CE165
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 01:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiCEATW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 19:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCEATT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:19:19 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E8713DD4;
        Fri,  4 Mar 2022 16:18:29 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z16so8946900pfh.3;
        Fri, 04 Mar 2022 16:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=saZ72BekMK8qsFjf6iFKP3QgKwC49DlwyTRsuhEWNlU=;
        b=gwam8yL2b++JszTOUvQ0ZXj+nmxn/AeosTKqj5LA+ZurbbaluVNjYpt7294X4BayxN
         fhIu4Q6MVn9byBvLRMHn1RIACp028V8aYo/yJLOt18QDujL5aTCc//jGMpZrHImdAZuo
         AYSRaWYQEYtw8WRXSVcZAr9gXGbw4qZ+BnkfHI3QvfzMVzYbb1uY64tsIxe0idkL8U6/
         IRIn9/mY/fL+fDvJACGZ3r879hn5ZNmsMiUhriRE0yJ0yZp+ytAZrEYH80MmKBtP55kD
         PetQ7yC5W7lc5P/VnrAZCAJ2dfpxg++d/Vj4hupboS65MQ0Kq+F04aSbwM0vvilleeQx
         XS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=saZ72BekMK8qsFjf6iFKP3QgKwC49DlwyTRsuhEWNlU=;
        b=zw9KEHNRokkqCGzBRM0i5/jkFYfm3sCXKanMyC902sIwnO/SHT3nZUoMI9EIssdx3T
         MwMSI+Ounz/LpPw2jo//pAMULw5vEjixu6uwrFecxTOQ7djJhkjYWqJU80+5fxh/MPb6
         P3mi1jl5DcqXni/GTvsJpdRYfpz0wH6W9df9DlY/z5stSziSmQcpFXVXFaKN4OMimjpa
         7/pIvqr1syuLW8hkZwGBw1mu1wyFA8rxqn+RH69IfTH+mej2PNXBfJg0hkBeCSZxP4Ns
         jYPRRDFwzayiXvyLH/EhfCPMlSsIYfMx9ZQIElY2cCTSV7xG+sbaKLzL+YWkoFLL6o01
         8LmA==
X-Gm-Message-State: AOAM530QrshpgoSZwL2Pg3DswBobUrvNttueWs78yUJt6oXFYN/D5nBc
        gSOf2YJfb/mG/XJBzy1ttj8=
X-Google-Smtp-Source: ABdhPJwZvhbbHcXl8W9nWnyHp4jwWRWthrOgPp66Ud7SEJtRpKdsfE59ysfxLrdisS3itYKLLWgulQ==
X-Received: by 2002:a65:6901:0:b0:378:8154:e2bf with SMTP id s1-20020a656901000000b003788154e2bfmr725432pgq.401.1646439509059;
        Fri, 04 Mar 2022 16:18:29 -0800 (PST)
Received: from google.com ([2620:15c:211:201:b771:f8fb:2968:865c])
        by smtp.gmail.com with ESMTPSA id n22-20020a056a0007d600b004f11e614565sm7021714pfu.189.2022.03.04.16.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 16:18:28 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 4 Mar 2022 16:18:26 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mhocko@suse.com, hannes@cmpxchg.org, timmurray@google.com,
        joel@joelfernandes.org, surenb@google.com, dancol@google.com,
        shakeelb@google.com, sonnyrao@google.com, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: Regression of madvise(MADV_COLD) on shmem?
Message-ID: <YiKsUr1FQwmDP7V0@google.com>
References: <dd620dbd-6d71-7553-d1e9-95676ff12c82@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd620dbd-6d71-7553-d1e9-95676ff12c82@nutanix.com>
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

On Fri, Mar 04, 2022 at 05:55:58PM +0000, Ivan Teterevkov wrote:
> Hi folks,
> 
> I want to check if there's a regression in the madvise(MADV_COLD) behaviour
> with shared memory or my understanding of how it works is inaccurate.
> 
> The MADV_COLD advice was introduced in Linux 5.4 and allowed the users to
> mark selected memory ranges as more "inactive" than others, overruling the
> default LRU accounting. It helped to preserve the working set of an
> application. With more recent kernels, e.g. at least 5.17.0-rc6 and 5.10.42,
> MADV_COLD has stopped working as expected. Please take a look at a short
> program that demonstrates it:
> 
>     /*
>      * madvise(MADV_COLD) demo.
>      */
>     #include <assert.h>
>     #include <stdio.h>
>     #include <stdlib.h>
>     #include <string.h>
>     #include <sys/mman.h>
> 
>     /* Requires the kernel 5.4 or newer. */
>     #ifndef MADV_COLD
>     #define MADV_COLD 20
>     #endif
> 
>     #define GIB(x) ((size_t)(x) << 30)
> 
>     int main(void)
>     {
>         char *shmem, *zeroes;
>         int page_size = getpagesize();
>         size_t i;
> 
>         /* Allocate 8 GiB of shared memory. */
>         shmem = mmap(/* addr */ NULL,
>                      /* length */ GIB(8),
>                      /* prot */ PROT_READ | PROT_WRITE,
>                      /* flags */ MAP_SHARED | MAP_ANONYMOUS,
>                      /* fd */ -1,
>                      /* offset */ 0);
>         assert(shmem != MAP_FAILED);
> 
>         /* Allocate a zero page for future use. */
>         zeroes = calloc(1, page_size);
>         assert(zeroes != NULL);
> 
>         /* Put 1 GiB blob at the beginning of the shared memory range. */
>         memset(shmem, 0xaa, GIB(1));
> 
>         /* Read memory adjacent to the blob. */
>         for (i = GIB(1); i < GIB(8); i = i + page_size) {
>             int res = memcmp(shmem + i, zeroes, page_size);
>             assert(res == 0);
> 
>             /* Cooldown a zero page and make it "less active" than the blob.
>              * Under memory pressure, it'll likely become a reclaim target
>              * and thus will help to preserve the blob in memory.
>              */
>             res = madvise(shmem + i, page_size, MADV_COLD);
>             assert(res == 0);
>         }
> 
>         /* Let the user check smaps. */
>         printf("done\n");
>         pause();
> 
>         free(zeroes);
>         munmap(shmem, GIB(8));
> 
>         return 0;
>     }
> 
> How to run this program:
> 
> 1. Create a "test" cgroup with a memory limit of 3 GiB.
> 
> 1.1. cgroup v1:
> 
>     # mkdir /sys/fs/cgroup/memory/test
>     # echo 3G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
> 
> 1.2. cgroup v2:
> 
>     # mkdir /sys/fs/cgroup/test
>     # echo 3G > /sys/fs/cgroup/test/memory.max
> 
> 2. Enable at least a 1 GiB swap device.
> 
> 3. Run the program in the "test" cgroup:
> 
>     # cgexec -g memory:test ./a.out
> 
> 4. Wait until it has finished, i.e. has printed "done".
> 
> 5. Check the shared memory VMA stats.
> 
> 5.1. In 5.17.0-rc6 and 5.10.42:
> 
>     # cat /proc/$(pidof a.out)/smaps | grep -A 21 -B 1 8388608
>     7f8ed4648000-7f90d4648000 rw-s 00000000 00:01 2055      /dev/zero
> (deleted)
>     Size:            8388608 kB
>     KernelPageSize:        4 kB
>     MMUPageSize:           4 kB
>     Rss:             3119556 kB
>     Pss:             3119556 kB
>     Shared_Clean:          0 kB
>     Shared_Dirty:          0 kB
>     Private_Clean:   3119556 kB
>     Private_Dirty:         0 kB
>     Referenced:            0 kB
>     Anonymous:             0 kB
>     LazyFree:              0 kB
>     AnonHugePages:         0 kB
>     ShmemPmdMapped:        0 kB
>     FilePmdMapped:         0 kB
>     Shared_Hugetlb:        0 kB
>     Private_Hugetlb:       0 kB
>     Swap:            1048576 kB
>     SwapPss:               0 kB
>     Locked:                0 kB
>     THPeligible:    0
>     VmFlags: rd wr sh mr mw me ms sd
> 
> 5.2. In 5.4.109:
> 
>     # cat /proc/$(pidof a.out)/smaps | grep -A 21 -B 1 8388608
>     7fca5f78b000-7fcc5f78b000 rw-s 00000000 00:01 173051      /dev/zero
> (deleted)
>     Size:            8388608 kB
>     KernelPageSize:        4 kB
>     MMUPageSize:           4 kB
>     Rss:             3121504 kB
>     Pss:             3121504 kB
>     Shared_Clean:          0 kB
>     Shared_Dirty:          0 kB
>     Private_Clean:   2072928 kB
>     Private_Dirty:   1048576 kB
>     Referenced:            0 kB
>     Anonymous:             0 kB
>     LazyFree:              0 kB
>     AnonHugePages:         0 kB
>     ShmemPmdMapped:        0 kB
>     FilePmdMapped:        0 kB
>     Shared_Hugetlb:        0 kB
>     Private_Hugetlb:       0 kB
>     Swap:                  0 kB
>     SwapPss:               0 kB
>     Locked:                0 kB
>     THPeligible:            0
>     VmFlags: rd wr sh mr mw me ms
> 
> There's a noticeable difference in the "Swap" reports so that the older
> kernel doesn't swap the blob, but the newer ones do.
> 
> According to ftrace, the newer kernels still call deactivate_page() in
> madvise_cold():
> 
> # trace-cmd record -p function_graph -g madvise_cold
> # trace-cmd report | less
>     a.out-4877  [000]  1485.266106: funcgraph_entry: |  madvise_cold() {
>     a.out-4877  [000]  1485.266115: funcgraph_entry: |    walk_page_range()
> {
>     a.out-4877  [000]  1485.266116: funcgraph_entry: |
> __walk_page_range() {
>     a.out-4877  [000]  1485.266117: funcgraph_entry: |
> madvise_cold_or_pageout_pte_range() {
>     a.out-4877  [000]  1485.266118: funcgraph_entry:        0.179 us |
> deactivate_page();
> 
> (The irrelevant bits are removed for brevity.)
> 
> It makes me think there may be a regression in MADV_COLD. Please let me know
> what do you reckon?

Since deactive_page is called, I guess that's not a regression(?) from [1]

Then, my random guess that you mentioned "Swap" as regression might be
related to "workingset detection for anon page" since kernel changes balancing
policy between file and anonymous LRU, which was merged into v5.8.
It would be helpful to see if you try it on v5.7 and v5.8.

[1] 12e967fd8e4e6, mm: do not allow MADV_PAGEOUT for CoW page
