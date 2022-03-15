Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7344D93A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbiCOFUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiCOFUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:20:05 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE36E49259
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:18:53 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id h30so19539170vsq.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQ4s1Cs1PYIUp2I/UfX3RvWGgFlp/nmvG0ltHXDQ20A=;
        b=pSkmmQvgb6qbxXPD3fz2L2wIItb40hAt+YZp7yp6GteDSwgvw6ysIZG5QTI0gCnjZg
         zhmy6t5fAkZ6Hq+lKQIZu+gjLAX4D3EWBJ38hTy0snaozg6kepFKJQY1eH+r2R0p8xjM
         qZ2eEEi3U2Nkf+Rps0gUhFBw1wWmM938U8PVmIZH93T65JSTGx4zGDd/42fU/jDZEFSg
         A4KJM/+nbP3wISZvmsThBTseWmDSsDudrySDQCBYll/TKWfZyJAP5r8y1EANam7zI4qa
         TZIcEw2PE90wReh4pnmaUk9r6yMCNRPCJAoP/0MsXMHXocMjqcAtHpOdromcbVhCO7J7
         KbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQ4s1Cs1PYIUp2I/UfX3RvWGgFlp/nmvG0ltHXDQ20A=;
        b=bWT/tjAstv0YZ5/2c4zt6A6V0ALq4sAiiUzig4lSsVo3JOs2TXZhUDmoGpOxvx85nx
         cOJ6V8j1csWbexVGY8zS54JR8ZwsFaePdemSH8SZXMZEYQ0HwGZJKE6NlTo2m/PNpc0g
         a4cIa6ujBgVX2+CHTshAkQgKiaS89QnK+CwLg1QTogGpktSNjuE++pKEOANwe1WmxFTY
         puCUHiB96dxjmvkD2DvxRLGjHeU09ZRk5P62+RMixA0ZW0BJAhendvvuBBY9m1Q27SiZ
         4AtlI8CoL3W7LraOgzupkRyhXzPoIxBCTzmDJJninP4zDL5kZYoeuMIHIhdbW/Uv0sJf
         5rEw==
X-Gm-Message-State: AOAM530PVRDNR0CgbUXczEyuob9SFkJpYNDNbg6hJS/jfA6HF+TGRwKK
        mAoxGpu4qzsFqpodtxac031TAR2vlHjrnph2RRmISA==
X-Google-Smtp-Source: ABdhPJxRCLI+XzTkOGBD32RZvA0uP+nlRtuzicwgGt6d0/NgNbEWM4QWSiQUTXWAAU23DHNGXqjZdqnpwtNw6XsODCY=
X-Received: by 2002:a05:6102:f0c:b0:320:9156:732f with SMTP id
 v12-20020a0561020f0c00b003209156732fmr11239709vss.6.1647321532771; Mon, 14
 Mar 2022 22:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOUHufbN_56UJBkgA2LjAfbTt9nzPOCHaSeS4P3GHcYst+Y+eg@mail.gmail.com>
 <20220314233812.9011-1-21cnbao@gmail.com>
In-Reply-To: <20220314233812.9011-1-21cnbao@gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 14 Mar 2022 23:18:41 -0600
Message-ID: <CAOUHufa9eY44QadfGTzsxa2=hEvqwahXd7Canck5Gt-N6c4UKA@mail.gmail.com>
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

On Mon, Mar 14, 2022 at 5:38 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Tue, Mar 15, 2022 at 5:45 AM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Mon, Mar 14, 2022 at 5:12 AM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > > > > >
> > > > > > > > We used to put a faulted file page in inactive, if we access it a
> > > > > > > > second time, it can be promoted
> > > > > > > > to active. then in recent years, we have also applied this to anon
> > > > > > > > pages while kernel adds
> > > > > > > > workingset protection for anon pages. so basically both anon and file
> > > > > > > > pages go into the inactive
> > > > > > > > list for the 1st time, if we access it for the second time, they go to
> > > > > > > > the active list. if we don't access
> > > > > > > > it any more, they are likely to be reclaimed as they are inactive.
> > > > > > > > we do have some special fastpath for code section, executable file
> > > > > > > > pages are kept on active list
> > > > > > > > as long as they are accessed.
> > > > > > >
> > > > > > > Yes.
> > > > > > >
> > > > > > > > so all of the above concerns are actually not that correct?
> > > > > > >
> > > > > > > They are valid concerns but I don't know any popular workloads that
> > > > > > > care about them.
> > > > > >
> > > > > > Hi Yu,
> > > > > > here we can get a workload in Kim's patchset while he added workingset
> > > > > > protection
> > > > > > for anon pages:
> > > > > > https://patchwork.kernel.org/project/linux-mm/cover/1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com/
> > > > >
> > > > > Thanks. I wouldn't call that a workload because it's not a real
> > > > > application. By popular workloads, I mean applications that the
> > > > > majority of people actually run on phones, in cloud, etc.
> > > > >
> > > > > > anon pages used to go to active rather than inactive, but kim's patchset
> > > > > > moved to use inactive first. then only after the anon page is accessed
> > > > > > second time, it can move to active.
> > > > >
> > > > > Yes. To clarify, the A-bit doesn't really mean the first or second
> > > > > access. It can be many accesses each time it's set.
> > > > >
> > > > > > "In current implementation, newly created or swap-in anonymous page is
> > > > > >
> > > > > > started on the active list. Growing the active list results in rebalancing
> > > > > > active/inactive list so old pages on the active list are demoted to the
> > > > > > inactive list. Hence, hot page on the active list isn't protected at all.
> > > > > >
> > > > > > Following is an example of this situation.
> > > > > >
> > > > > > Assume that 50 hot pages on active list and system can contain total
> > > > > > 100 pages. Numbers denote the number of pages on active/inactive
> > > > > > list (active | inactive). (h) stands for hot pages and (uo) stands for
> > > > > > used-once pages.
> > > > > >
> > > > > > 1. 50 hot pages on active list
> > > > > > 50(h) | 0
> > > > > >
> > > > > > 2. workload: 50 newly created (used-once) pages
> > > > > > 50(uo) | 50(h)
> > > > > >
> > > > > > 3. workload: another 50 newly created (used-once) pages
> > > > > > 50(uo) | 50(uo), swap-out 50(h)
> > > > > >
> > > > > > As we can see, hot pages are swapped-out and it would cause swap-in later."
> > > > > >
> > > > > > Is MGLRU able to avoid the swap-out of the 50 hot pages?
> > > > >
> > > > > I think the real question is why the 50 hot pages can be moved to the
> > > > > inactive list. If they are really hot, the A-bit should protect them.
> > > >
> > > > This is a good question.
> > > >
> > > > I guess it  is probably because the current lru is trying to maintain a balance
> > > > between the sizes of active and inactive lists. Thus, it can shrink active list
> > > > even though pages might be still "hot" but not the recently accessed ones.
> > > >
> > > > 1. 50 hot pages on active list
> > > > 50(h) | 0
> > > >
> > > > 2. workload: 50 newly created (used-once) pages
> > > > 50(uo) | 50(h)
> > > >
> > > > 3. workload: another 50 newly created (used-once) pages
> > > > 50(uo) | 50(uo), swap-out 50(h)
> > > >
> > > > the old kernel without anon workingset protection put workload 2 on active, so
> > > > pushed 50 hot pages from active to inactive. workload 3 would further contribute
> > > > to evict the 50 hot pages.
> > > >
> > > > it seems mglru doesn't demote pages from the youngest generation to older
> > > > generation only in order to balance the list size? so mglru is probably safe
> > > > in these cases.
> > > >
> > > > I will run some tests mentioned in Kim's patchset and report the result to you
> > > > afterwards.
> > > >
> > >
> > > Hi Yu,
> > > I did find putting faulted pages to the youngest generation lead to some
> > > regression in the case ebizzy Kim's patchset mentioned while he tried
> > > to support workingset protection for anon pages.
> > > i did a little bit modification for rand_chunk() which is probably similar
> > > with the modifcation() Kim mentioned in his patchset. The modification
> > > can be found here:
> > > https://github.com/21cnbao/ltp/commit/7134413d747bfa9ef
> > >
> > > The test env is a x86 machine in which I have set memory size to 2.5GB and
> > > set zRAM to 2GB and disabled external disk swap.
> > >
> > > with the vanilla kernel:
> > > \time -v ./a.out -vv -t 4 -s 209715200 -S 200000
> > >
> > > so we have 10 chunks and 4 threads, each trunk is 209715200(200MB)
> > >
> > > typical result:
> > >         Command being timed: "./a.out -vv -t 4 -s 209715200 -S 200000"
> > >         User time (seconds): 36.19
> > >         System time (seconds): 229.72
> > >         Percent of CPU this job got: 371%
> > >         Elapsed (wall clock) time (h:mm:ss or m:ss): 1:11.59
> > >         Average shared text size (kbytes): 0
> > >         Average unshared data size (kbytes): 0
> > >         Average stack size (kbytes): 0
> > >         Average total size (kbytes): 0
> > >         Maximum resident set size (kbytes): 2166196
> > >         Average resident set size (kbytes): 0
> > >         Major (requiring I/O) page faults: 9990128
> > >         Minor (reclaiming a frame) page faults: 33315945
> > >         Voluntary context switches: 59144
> > >         Involuntary context switches: 167754
> > >         Swaps: 0
> > >         File system inputs: 2760
> > >         File system outputs: 8
> > >         Socket messages sent: 0
> > >         Socket messages received: 0
> > >         Signals delivered: 0
> > >         Page size (bytes): 4096
> > >         Exit status: 0
> > >
> > > with gen_lru and lru_gen/enabled=0x3:
> > > typical result:
> > > Command being timed: "./a.out -vv -t 4 -s 209715200 -S 200000"
> > > User time (seconds): 36.34
> > > System time (seconds): 276.07
> > > Percent of CPU this job got: 378%
> > > Elapsed (wall clock) time (h:mm:ss or m:ss): 1:22.46
> > >            **** 15% time +
> > > Average shared text size (kbytes): 0
> > > Average unshared data size (kbytes): 0
> > > Average stack size (kbytes): 0
> > > Average total size (kbytes): 0
> > > Maximum resident set size (kbytes): 2168120
> > > Average resident set size (kbytes): 0
> > > Major (requiring I/O) page faults: 13362810
> > >              ***** 30% page fault +
> > > Minor (reclaiming a frame) page faults: 33394617
> > > Voluntary context switches: 55216
> > > Involuntary context switches: 137220
> > > Swaps: 0
> > > File system inputs: 4088
> > > File system outputs: 8
> > > Socket messages sent: 0
> > > Socket messages received: 0
> > > Signals delivered: 0
> > > Page size (bytes): 4096
> > > Exit status: 0
> > >
> > > with gen_lru and lru_gen/enabled=0x7:
> > > typical result:
> > > Command being timed: "./a.out -vv -t 4 -s 209715200 -S 200000"
> > > User time (seconds): 36.13
> > > System time (seconds): 251.71
> > > Percent of CPU this job got: 378%
> > > Elapsed (wall clock) time (h:mm:ss or m:ss): 1:16.00
> > >          *****better than enabled=0x3, worse than vanilla
> > > Average shared text size (kbytes): 0
> > > Average unshared data size (kbytes): 0
> > > Average stack size (kbytes): 0
> > > Average total size (kbytes): 0
> > > Maximum resident set size (kbytes): 2120988
> > > Average resident set size (kbytes): 0
> > > Major (requiring I/O) page faults: 12706512
> > > Minor (reclaiming a frame) page faults: 33422243
> > > Voluntary context switches: 49485
> > > Involuntary context switches: 126765
> > > Swaps: 0
> > > File system inputs: 2976
> > > File system outputs: 8
> > > Socket messages sent: 0
> > > Socket messages received: 0
> > > Signals delivered: 0
> > > Page size (bytes): 4096
> > > Exit status: 0
> > >
> > > I can also reproduce the problem on arm64.
> > >
> > > I am not saying this is going to block mglru from being mainlined. But  I am
> > > still curious if this is an issue worth being addressed somehow in mglru.
> >
> > You've missed something very important: *thoughput* :)
> >
>
> noop :-)
> in the test case, there are 4 threads. they are searching a key in 10 chunks
> of memory. for each chunk, the size is 200MB.
> a "random" chunk index is returned for those threads to search. but chunk2
> is the hottest, and chunk3, 7, 4 are relatively hotter than others.
> static inline unsigned int rand_chunk(void)
> {
>         /* simulate hot and cold chunk */
>         unsigned int rand[16] = {2, 2, 3, 4, 5, 2, 6, 7, 9, 2, 8, 3, 7, 2, 2, 4};

This is sequential access, not what you claim above, because you have
a repeating sequence.

In this case MGLRU is expected to be slower because it doesn't try to
optimize it, as discussed before [1]. The reason is, with a manageable
complexity, we can only optimize so many things. And MGLRU chose to
optimize (arguably) popular workloads, since, AFAIK, no real-world
applications streams anon memory.

To verify this is indeed sequential access, you could make rand[]
larger, e.g., 160, with the same portions of 2s, 3s, 4s, etc, but
their positions are random. The following change shows MGLRU is ~20%
faster on my Snapdragon 7c + 2.5G DRAM + 2GB zram.

 static inline unsigned int rand_chunk(void)
 {
        /* simulate hot and cold chunk */
-       unsigned int rand[16] = {2, 2, 3, 4, 5, 2, 6, 7, 9, 2, 8, 3,
7, 2, 2, 4};
+       unsigned int rand[160] = {
+               2, 4, 7, 3, 4, 2, 7, 2, 7, 8, 6, 9, 7, 6, 5, 4,
+               6, 2, 6, 4, 2, 9, 2, 5, 5, 4, 7, 2, 7, 7, 5, 2,
+               4, 4, 3, 3, 2, 4, 2, 2, 5, 2, 4, 2, 8, 2, 2, 3,
+               2, 2, 2, 2, 2, 8, 4, 2, 2, 4, 2, 2, 2, 2, 3, 2,
+               8, 5, 2, 2, 3, 2, 8, 2, 6, 2, 4, 8, 5, 2, 9, 2,
+               8, 7, 9, 2, 4, 4, 3, 3, 2, 8, 2, 2, 3, 3, 2, 7,
+               7, 5, 2, 2, 8, 2, 2, 2, 5, 2, 4, 3, 2, 3, 6, 3,
+               3, 3, 9, 4, 2, 3, 9, 7, 7, 6, 2, 2, 4, 2, 6, 2,
+               9, 7, 7, 7, 9, 3, 4, 2, 3, 2, 7, 3, 2, 2, 2, 6,
+               8, 3, 7, 6, 2, 2, 2, 4, 7, 2, 5, 7, 4, 7, 9, 9,
+       };
        static int nr = 0;
-       return rand[nr++%16];
+       return rand[nr++%160];
 }

Yet better, you could use some standard benchmark suites, written by
reputable organizations, e.g., memtier, YCSB, to generate more
realistic distributions, as I've suggested before [2].

>         static int nr = 0;
>         return rand[nr++%16];
> }
>
> each thread does search_mem():
> static unsigned int search_mem(void)
> {
>         record_t key, *found;
>         record_t *src, *copy;
>         unsigned int chunk;
>         size_t copy_size = chunk_size;
>         unsigned int i;
>         unsigned int state = 0;
>
>         /* run 160 loops or till timeout */
>         for (i = 0; threads_go == 1 && i < 160; i++) {

I see you've modified the original benchmark. But with "-S 200000",
should this test finish within an hour instead of the following?
    Elapsed (wall clock) time (h:mm:ss or m:ss): 1:11.59

>                 chunk = rand_chunk();
>                 src = mem[chunk];
>                 ...
>                 copy = alloc_mem(copy_size);
>                 ...
>                 memcpy(copy, src, copy_size);
>
>                 key = rand_num(copy_size / record_size, &state);
>
>                 bsearch(&key, copy, copy_size / record_size,
>                         record_size, compare);
>
>                         /* Below check is mainly for memory corruption or other bug */
>                         if (found == NULL) {
>                                 fprintf(stderr, "Couldn't find key %zd\n", key);
>                                 exit(1);
>                         }
>                 }               /* end if ! touch_pages */
>
>                 free_mem(copy, copy_size);
>         }
>
>         return (i);
> }
>
> each thread picks up a chunk, then allocates a new memory and copies the chunk to the
> new allocated memory, and searches a key in the allocated memory.
>
> as i have set time to rather big by -S, so each thread actually exits while it
> completes 160 loops.
> $ \time -v ./ebizzy -t 4 -s $((200*1024*1024)) -S 6000000

Ok, you actually used "-S 6000000".

[1] https://lore.kernel.org/linux-mm/YhNJ4LVWpmZgLh4I@google.com/
[2] https://lore.kernel.org/linux-mm/YgggI+vvtNvh3jBY@google.com/
