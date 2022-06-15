Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C1F54D4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346644AbiFOWtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346327AbiFOWtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:49:06 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507DA562F6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:49:03 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220615224857euoutp0164027e7cd6429099f3a042c2080e893b~47OZn9phh2026520265euoutp01E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:48:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220615224857euoutp0164027e7cd6429099f3a042c2080e893b~47OZn9phh2026520265euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655333337;
        bh=t2cw2PCj7LTTLNLTQ1fYy1Hln0IPcYhTGB+2Q5Mllf4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=X+1uazeOHgIyGK6FP8tiouYpZ2OOBZMs5HN/+pypunUn94rT4V1D3LdWvVCCROJR0
         +85d17XTbI0q0IfJDWCjabamyEqHeCzu7kC1oGu7jBTjvOeA2MhrDYJPbD39WfUzzh
         FbcJLM/rgUcK7+liwy0zCZXhCFGVbBzDGkpNNY5Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220615224856eucas1p29313a2d2f1c6c5b6c473fdb222817b73~47OYu05fd0620306203eucas1p2E;
        Wed, 15 Jun 2022 22:48:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 30.4A.09664.8D16AA26; Wed, 15
        Jun 2022 23:48:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220615224855eucas1p1ea6d90c23ec9423dfe04b267f6dddd2a~47OYUlrKX0461204612eucas1p1U;
        Wed, 15 Jun 2022 22:48:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615224855eusmtrp23cc0ff8ed30659e6c54a51352e185f26~47OYT5pCZ2395323953eusmtrp2D;
        Wed, 15 Jun 2022 22:48:55 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-13-62aa61d850d7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.02.09038.7D16AA26; Wed, 15
        Jun 2022 23:48:55 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220615224855eusmtip16d1540e8c893e161bd3af3cc473bdf99~47OXthaeq0680406804eusmtip1H;
        Wed, 15 Jun 2022 22:48:55 +0000 (GMT)
Message-ID: <e1c73640-3f29-bf57-b98d-84b1800cf4e3@samsung.com>
Date:   Thu, 16 Jun 2022 00:48:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220613125622.18628-8-mgorman@techsingularity.net>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djP87o3ElclGazfKWIxZ/0aNounn/pY
        LC7vmsNmcW/Nf1aLHUv3MVm8/raM2WJjzyRWi8kvVzBazG7sY3Tg9FiwqdRj06pONo9Nnyax
        e5yY8ZvF4/2+q2weZxYcYffY+svO4/MmuQCOKC6blNSczLLUIn27BK6Ms2fbmApWC1es+DqJ
        sYHxMX8XIyeHhICJxL8d/1m6GLk4hARWMEo8773FDJIQEvjCKDHlVixE4jOjRNe+6exdjBxg
        HReWyULElzNKvNt5Dqr7I6PErQlLWEC6eQXsJO5uus0GYrMIqEp83vqbHSIuKHFy5hOwGlGB
        JIn521pZQWxhgUCJlvfHwOqZBcQlbj2ZzwRiiwhEStw4s4URZAGzQBuTxIT7t8Aa2AQMJbre
        doE1cAo4Sqx9sIIFolleYvvbOcwgDRIC7ZwS53c9ZId41EXiwvW/jBC2sMSr41ug4jIS/3eC
        bAN5LV/i7wxjiHCFxLXXa5ghbGuJO+d+sYGUMAtoSqzfpQ8RdpSYP2UOK0Qnn8SNt4IQF/BJ
        TNo2nRkizCvR0SYEUa0mMev4OridBy9cYp7AqDQLKVBmIXl+FpJfZiHsXcDIsopRPLW0ODc9
        tdgwL7Vcrzgxt7g0L10vOT93EyMwWZ3+d/zTDsa5rz7qHWJk4mA8xCjBwawkwmsWvDJJiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA1ON+adJx1fN1/L3
        ftHp/Xyh8eVX1av2hRtXXA2O4sy9kMtzYvXV3iXPON7e+cB/M6fjrpe7d9Nn63W1u21MRXhP
        OioY9Dzz18z6nGOyYvKH9E88Da/ePtU2/Lu3kWOK0tdD9vv/hD+OvBR+e37vpE+3f85evvJW
        lOoU4e+y6XFZcyQ0+vx2HdhTxHP0Wbfx7AY/rXV+V7gFf1asWlPnc7utdk6FLbdCumBA4v22
        y4cjejc93250WS7pTG9Ht7/pse27JT8vW7/JZj/3hrIVEmzWx6do3do+44sAnwGjyU/jGI49
        RyJ27mpcE/yQ7VOHYUfaUi0/tnzRou6jDCKVru/z5qeeYu65GPTl+NJjzlFKLMUZiYZazEXF
        iQDm61vVxQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7rXE1clGextM7WYs34Nm8XTT30s
        Fpd3zWGzuLfmP6vFjqX7mCxef1vGbLGxZxKrxeSXKxgtZjf2MTpweizYVOqxaVUnm8emT5PY
        PU7M+M3i8X7fVTaPMwuOsHts/WXn8XmTXABHlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYml
        nqGxeayVkamSvp1NSmpOZllqkb5dgl7G2bNtTAWrhStWfJ3E2MD4mL+LkYNDQsBE4sIy2S5G
        Lg4hgaWMEq83z2PsYuQEistInJzWwAphC0v8udbFBlH0nlHi68TpYAleATuJu5tus4HYLAKq
        Ep+3/maHiAtKnJz5hAXEFhVIkpi3dzXYUGGBQImW98fA6pkFxCVuPZnPBGKLCERK3Js6mxlk
        AbNAG5PE460HGEGuExIolzh+tBikhk3AUKLrbRdYL6eAo8TaBytYIOaYSXRt7WKEsOUltr+d
        wzyBUWgWkjNmIVk3C0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG6LZjP7fs
        YFz56qPeIUYmDsZDjBIczEoivGbBK5OEeFMSK6tSi/Lji0pzUosPMZoCw2Iis5Rocj4wReSV
        xBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTAJfVqR2u76uO/1Zu1P
        Bydc5xU8vcur7NGZhHPHukp2ar/RnCjMePOTinuOyZpwg0mLtmbtX5/9K5c3+IN8QmK56Wl1
        iZCEHWm56Zc6WmadCit9mDqna1nxg3I5ruOV8wWLNZaGR0ULex658PvWquz5Uhd6WnLfRGvs
        u/LIb4XqX4dfcSc4WtVZZ8o+cYhlVlLYb8m7+su81mKrjN/MScaXLt94qXF2/VRt7zi2jtLO
        vLTVN9N/dSi8zrvyy3dLu8Btx7/nX5kuY3jwX2ll47dnG1gLVm1hPHz0d6Ahe1aRyM4bFqnN
        bhuevvhn18rx8DpbudAGwVNNFT4tX38tXeg0sTuoQ2b7C8OSN3Ocbz1QYinOSDTUYi4qTgQA
        yOfuY1kDAAA=
X-CMS-MailID: 20220615224855eucas1p1ea6d90c23ec9423dfe04b267f6dddd2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615224855eucas1p1ea6d90c23ec9423dfe04b267f6dddd2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615224855eucas1p1ea6d90c23ec9423dfe04b267f6dddd2a
References: <20220613125622.18628-1-mgorman@techsingularity.net>
        <20220613125622.18628-8-mgorman@techsingularity.net>
        <CGME20220615224855eucas1p1ea6d90c23ec9423dfe04b267f6dddd2a@eucas1p1.samsung.com>
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On 13.06.2022 14:56, Mel Gorman wrote:
> struct per_cpu_pages is no longer strictly local as PCP lists can be
> drained remotely using a lock for protection. While the use of local_lock
> works, it goes against the intent of local_lock which is for "pure
> CPU local concurrency control mechanisms and not suited for inter-CPU
> concurrency control" (Documentation/locking/locktypes.rst)
>
> local_lock protects against migration between when the percpu pointer is
> accessed and the pcp->lock acquired. The lock acquisition is a preemption
> point so in the worst case, a task could migrate to another NUMA node
> and accidentally allocate remote memory. The main requirement is to pin
> the task to a CPU that is suitable for PREEMPT_RT and !PREEMPT_RT.
>
> Replace local_lock with helpers that pin a task to a CPU, lookup the
> per-cpu structure and acquire the embedded lock. It's similar to local_lock
> without breaking the intent behind the API. It is not a complete API
> as only the parts needed for PCP-alloc are implemented but in theory,
> the generic helpers could be promoted to a general API if there was
> demand for an embedded lock within a per-cpu struct with a guarantee
> that the per-cpu structure locked matches the running CPU and cannot use
> get_cpu_var due to RT concerns. PCP requires these semantics to avoid
> accidentally allocating remote memory.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

This patch landed in linux next-20220614 as commit 54bcdc6744e3 
("mm/page_alloc: replace local_lock with normal spinlock"). 
Unfortunately it causes some serious issues when some kernel debugging 
options (CONFIG_PROVE_LOCKING and CONFIG_DEBUG_ATOMIC_SLEEP) are 
enabled. I've observed this on various ARM 64bit and 32bit boards.

In the logs I see lots of errors like:

BUG: sleeping function called from invalid context at 
./include/linux/sched/mm.h:274

BUG: scheduling while atomic: systemd-udevd/288/0x00000002

BUG: sleeping function called from invalid context at mm/filemap.c:2647

however there are also a fatal ones like:

Unable to handle kernel paging request at virtual address 00000000017a87b4


The issues seems to be a bit random. Looks like memory trashing. 
Reverting $subject on top of current linux-next fixes all those issues.


Let me know if how I can help debugging this.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

