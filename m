Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFFC4D9076
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343728AbiCNXjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343720AbiCNXjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:39:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B28012617;
        Mon, 14 Mar 2022 16:38:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso444821pjb.0;
        Mon, 14 Mar 2022 16:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4obkUD8+Xm15wKaQvsDfW38K//v1SvAKl3Zz6bdAF8=;
        b=CX0UxRl7yteSgeLkynLXlv/zDjZEe0djx5kWxYBmDLeLdB6pkgl/LH3Rqp+2e7E+ZB
         oDrEhVr82GizbOvFz6pRQl5HczpIMDAxcCZJsLjAowxkvvAteGe50tTBuZuj7fGmgNyW
         Q6jyc5nRJkTCkHHUgYobnEtL85JD8gKf2jjLXzAT+3feDX4QxgKRN9NdpqRa+0v4xfLj
         cWMWDw4M8JyI26GYVxHF14mzq/i2nWjorpSCOfqY+ViN2lFH1073nNxifCCW83lurE4g
         pMP/VSb5E0Qy5yymmk4J6Q0RHZ3RzC4UQX1cPKpB4zBl7uEv/rghiBCVaTVPEE4Sxsun
         ZN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4obkUD8+Xm15wKaQvsDfW38K//v1SvAKl3Zz6bdAF8=;
        b=3Ig71/qoJNTXjLDwaW9Oycw12PUCAGwQm4AL01fRe6lwPfPrnfGy1JeCwVPWtzjnrm
         GN+A2lVzkdSo8FVA8lbT8CAlvhP6gXrST3oRR0nRhVkcci+wp1SwPfts5JR2xSbR8D8p
         5fH5Mg7PNaEDUJpZfiaIUCKx9DP9WdXE6YJhvDxSwpjEnfiEsTzk+OwAy9Ys556yRLmr
         4eIh2Yt4Xmv78Im1QBlzFFpdjca6WHS0cF1EWmgUS6UzL//DB8eOLAD8ZTT8j308tCtT
         qJDXD49Dh+a+YmQNV59P/mwxNPrh7kxxDoyD4EeQzcA00jlXpzsoQIg8DPiFHLsNE8cV
         stoA==
X-Gm-Message-State: AOAM533J3r81UOxsDlrJZNfo6lJdM4FU9egu7FvaDtCLUAUQzm8Api48
        0ReTO1Pq3d2d/9mqWx6z56Y=
X-Google-Smtp-Source: ABdhPJw8yRb7sdUwWB/JBXh4wMyTG4fG1xh0oPeDmrnBqnraMyyeVBHrVOHl/tNSRyifDNvg/Pj6Cw==
X-Received: by 2002:a17:902:dacc:b0:152:268:27d9 with SMTP id q12-20020a170902dacc00b00152026827d9mr25586273plx.76.1647301119933;
        Mon, 14 Mar 2022 16:38:39 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:8d71:31d1:e9fc:88f3])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a00114a00b004f784ba5e6asm15128066pfm.17.2022.03.14.16.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 16:38:39 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     yuzhao@google.com
Cc:     21cnbao@gmail.com, Hi-Angel@yandex.ru, Michael@michaellarabel.com,
        ak@linux.intel.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, axboe@kernel.dk, bgeffon@google.com,
        catalin.marinas@arm.com, corbet@lwn.net, d@chaos-reins.com,
        dave.hansen@linux.intel.com, djbyrne@mtu.edu, hannes@cmpxchg.org,
        hdanton@sina.com, heftig@archlinux.org,
        holger@applied-asynchrony.com, jsbarnes@google.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mhocko@kernel.org, oleksandr@natalenko.name,
        page-reclaim@google.com, riel@surriel.com, rppt@kernel.org,
        sofia.trinh@edi.works, steven@liquorix.net, suleiman@google.com,
        szhai2@cs.rochester.edu, torvalds@linux-foundation.org,
        vbabka@suse.cz, will@kernel.org, willy@infradead.org,
        x86@kernel.org, ying.huang@intel.com
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
Date:   Tue, 15 Mar 2022 12:38:12 +1300
Message-Id: <20220314233812.9011-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAOUHufbN_56UJBkgA2LjAfbTt9nzPOCHaSeS4P3GHcYst+Y+eg@mail.gmail.com>
References: <CAOUHufbN_56UJBkgA2LjAfbTt9nzPOCHaSeS4P3GHcYst+Y+eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 5:45 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Mar 14, 2022 at 5:12 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > > > > >
> > > > > > > We used to put a faulted file page in inactive, if we access it a
> > > > > > > second time, it can be promoted
> > > > > > > to active. then in recent years, we have also applied this to anon
> > > > > > > pages while kernel adds
> > > > > > > workingset protection for anon pages. so basically both anon and file
> > > > > > > pages go into the inactive
> > > > > > > list for the 1st time, if we access it for the second time, they go to
> > > > > > > the active list. if we don't access
> > > > > > > it any more, they are likely to be reclaimed as they are inactive.
> > > > > > > we do have some special fastpath for code section, executable file
> > > > > > > pages are kept on active list
> > > > > > > as long as they are accessed.
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > > so all of the above concerns are actually not that correct?
> > > > > >
> > > > > > They are valid concerns but I don't know any popular workloads that
> > > > > > care about them.
> > > > >
> > > > > Hi Yu,
> > > > > here we can get a workload in Kim's patchset while he added workingset
> > > > > protection
> > > > > for anon pages:
> > > > > https://patchwork.kernel.org/project/linux-mm/cover/1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com/
> > > >
> > > > Thanks. I wouldn't call that a workload because it's not a real
> > > > application. By popular workloads, I mean applications that the
> > > > majority of people actually run on phones, in cloud, etc.
> > > >
> > > > > anon pages used to go to active rather than inactive, but kim's patchset
> > > > > moved to use inactive first. then only after the anon page is accessed
> > > > > second time, it can move to active.
> > > >
> > > > Yes. To clarify, the A-bit doesn't really mean the first or second
> > > > access. It can be many accesses each time it's set.
> > > >
> > > > > "In current implementation, newly created or swap-in anonymous page is
> > > > >
> > > > > started on the active list. Growing the active list results in rebalancing
> > > > > active/inactive list so old pages on the active list are demoted to the
> > > > > inactive list. Hence, hot page on the active list isn't protected at all.
> > > > >
> > > > > Following is an example of this situation.
> > > > >
> > > > > Assume that 50 hot pages on active list and system can contain total
> > > > > 100 pages. Numbers denote the number of pages on active/inactive
> > > > > list (active | inactive). (h) stands for hot pages and (uo) stands for
> > > > > used-once pages.
> > > > >
> > > > > 1. 50 hot pages on active list
> > > > > 50(h) | 0
> > > > >
> > > > > 2. workload: 50 newly created (used-once) pages
> > > > > 50(uo) | 50(h)
> > > > >
> > > > > 3. workload: another 50 newly created (used-once) pages
> > > > > 50(uo) | 50(uo), swap-out 50(h)
> > > > >
> > > > > As we can see, hot pages are swapped-out and it would cause swap-in later."
> > > > >
> > > > > Is MGLRU able to avoid the swap-out of the 50 hot pages?
> > > >
> > > > I think the real question is why the 50 hot pages can be moved to the
> > > > inactive list. If they are really hot, the A-bit should protect them.
> > >
> > > This is a good question.
> > >
> > > I guess it  is probably because the current lru is trying to maintain a balance
> > > between the sizes of active and inactive lists. Thus, it can shrink active list
> > > even though pages might be still "hot" but not the recently accessed ones.
> > >
> > > 1. 50 hot pages on active list
> > > 50(h) | 0
> > >
> > > 2. workload: 50 newly created (used-once) pages
> > > 50(uo) | 50(h)
> > >
> > > 3. workload: another 50 newly created (used-once) pages
> > > 50(uo) | 50(uo), swap-out 50(h)
> > >
> > > the old kernel without anon workingset protection put workload 2 on active, so
> > > pushed 50 hot pages from active to inactive. workload 3 would further contribute
> > > to evict the 50 hot pages.
> > >
> > > it seems mglru doesn't demote pages from the youngest generation to older
> > > generation only in order to balance the list size? so mglru is probably safe
> > > in these cases.
> > >
> > > I will run some tests mentioned in Kim's patchset and report the result to you
> > > afterwards.
> > >
> >
> > Hi Yu,
> > I did find putting faulted pages to the youngest generation lead to some
> > regression in the case ebizzy Kim's patchset mentioned while he tried
> > to support workingset protection for anon pages.
> > i did a little bit modification for rand_chunk() which is probably similar
> > with the modifcation() Kim mentioned in his patchset. The modification
> > can be found here:
> > https://github.com/21cnbao/ltp/commit/7134413d747bfa9ef
> >
> > The test env is a x86 machine in which I have set memory size to 2.5GB and
> > set zRAM to 2GB and disabled external disk swap.
> >
> > with the vanilla kernel:
> > \time -v ./a.out -vv -t 4 -s 209715200 -S 200000
> >
> > so we have 10 chunks and 4 threads, each trunk is 209715200(200MB)
> >
> > typical result:
> >         Command being timed: "./a.out -vv -t 4 -s 209715200 -S 200000"
> >         User time (seconds): 36.19
> >         System time (seconds): 229.72
> >         Percent of CPU this job got: 371%
> >         Elapsed (wall clock) time (h:mm:ss or m:ss): 1:11.59
> >         Average shared text size (kbytes): 0
> >         Average unshared data size (kbytes): 0
> >         Average stack size (kbytes): 0
> >         Average total size (kbytes): 0
> >         Maximum resident set size (kbytes): 2166196
> >         Average resident set size (kbytes): 0
> >         Major (requiring I/O) page faults: 9990128
> >         Minor (reclaiming a frame) page faults: 33315945
> >         Voluntary context switches: 59144
> >         Involuntary context switches: 167754
> >         Swaps: 0
> >         File system inputs: 2760
> >         File system outputs: 8
> >         Socket messages sent: 0
> >         Socket messages received: 0
> >         Signals delivered: 0
> >         Page size (bytes): 4096
> >         Exit status: 0
> >
> > with gen_lru and lru_gen/enabled=0x3:
> > typical result:
> > Command being timed: "./a.out -vv -t 4 -s 209715200 -S 200000"
> > User time (seconds): 36.34
> > System time (seconds): 276.07
> > Percent of CPU this job got: 378%
> > Elapsed (wall clock) time (h:mm:ss or m:ss): 1:22.46
> >            **** 15% time +
> > Average shared text size (kbytes): 0
> > Average unshared data size (kbytes): 0
> > Average stack size (kbytes): 0
> > Average total size (kbytes): 0
> > Maximum resident set size (kbytes): 2168120
> > Average resident set size (kbytes): 0
> > Major (requiring I/O) page faults: 13362810
> >              ***** 30% page fault +
> > Minor (reclaiming a frame) page faults: 33394617
> > Voluntary context switches: 55216
> > Involuntary context switches: 137220
> > Swaps: 0
> > File system inputs: 4088
> > File system outputs: 8
> > Socket messages sent: 0
> > Socket messages received: 0
> > Signals delivered: 0
> > Page size (bytes): 4096
> > Exit status: 0
> >
> > with gen_lru and lru_gen/enabled=0x7:
> > typical result:
> > Command being timed: "./a.out -vv -t 4 -s 209715200 -S 200000"
> > User time (seconds): 36.13
> > System time (seconds): 251.71
> > Percent of CPU this job got: 378%
> > Elapsed (wall clock) time (h:mm:ss or m:ss): 1:16.00
> >          *****better than enabled=0x3, worse than vanilla
> > Average shared text size (kbytes): 0
> > Average unshared data size (kbytes): 0
> > Average stack size (kbytes): 0
> > Average total size (kbytes): 0
> > Maximum resident set size (kbytes): 2120988
> > Average resident set size (kbytes): 0
> > Major (requiring I/O) page faults: 12706512
> > Minor (reclaiming a frame) page faults: 33422243
> > Voluntary context switches: 49485
> > Involuntary context switches: 126765
> > Swaps: 0
> > File system inputs: 2976
> > File system outputs: 8
> > Socket messages sent: 0
> > Socket messages received: 0
> > Signals delivered: 0
> > Page size (bytes): 4096
> > Exit status: 0
> >
> > I can also reproduce the problem on arm64.
> >
> > I am not saying this is going to block mglru from being mainlined. But  I am
> > still curious if this is an issue worth being addressed somehow in mglru.
>
> You've missed something very important: *thoughput* :)
>

noop :-)
in the test case, there are 4 threads. they are searching a key in 10 chunks
of memory. for each chunk, the size is 200MB.
a "random" chunk index is returned for those threads to search. but chunk2
is the hottest, and chunk3, 7, 4 are relatively hotter than others.
static inline unsigned int rand_chunk(void)
{
	/* simulate hot and cold chunk */
	unsigned int rand[16] = {2, 2, 3, 4, 5, 2, 6, 7, 9, 2, 8, 3, 7, 2, 2, 4};
	static int nr = 0;
	return rand[nr++%16];
}

each thread does search_mem():
static unsigned int search_mem(void)
{
	record_t key, *found;
	record_t *src, *copy;
	unsigned int chunk;
	size_t copy_size = chunk_size;
	unsigned int i;
	unsigned int state = 0;

	/* run 160 loops or till timeout */
	for (i = 0; threads_go == 1 && i < 160; i++) {
		chunk = rand_chunk();
		src = mem[chunk];
		...
		copy = alloc_mem(copy_size);
		...
		memcpy(copy, src, copy_size);

		key = rand_num(copy_size / record_size, &state);

		bsearch(&key, copy, copy_size / record_size,
			record_size, compare);

			/* Below check is mainly for memory corruption or other bug */
			if (found == NULL) {
				fprintf(stderr, "Couldn't find key %zd\n", key);
				exit(1);
			}
		}		/* end if ! touch_pages */

		free_mem(copy, copy_size);
	}

	return (i);
}

each thread picks up a chunk, then allocates a new memory and copies the chunk to the
new allocated memory, and searches a key in the allocated memory.

as i have set time to rather big by -S, so each thread actually exits while it
completes 160 loops.
$ \time -v ./ebizzy -t 4 -s $((200*1024*1024)) -S 6000000

so the one who finishes the whole jobs earlier wins in throughput as
well.

> Dollars to doughnuts there was a large increase in throughput -- I
> haven't tried this benchmark but I've seen many reports similar to
> this one.

I have no doubt about this. I am just trying to figure out some potential we can
further achieve in mglru.

Thanks,
Barry
