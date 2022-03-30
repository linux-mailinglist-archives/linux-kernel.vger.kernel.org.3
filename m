Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72464EBA15
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbiC3FYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiC3FYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:24:08 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47487158542
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:22:21 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220330052218epoutp045a4284d1c0fe19ebb9f864bd1ceb2745~hERkzYPtO1819618196epoutp049
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:22:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220330052218epoutp045a4284d1c0fe19ebb9f864bd1ceb2745~hERkzYPtO1819618196epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648617738;
        bh=RDJmuqlXXYxm9LUmr11dkUGLyi8fQN1YQyefFjvtlEE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Y+Zz5S2X3PrpjT9vaM5RcBLwrFCiwyTvq9fWgHHQv9Q3NzP+aivGPyVljAgQwrn3l
         R883CW52HlnUrktzrGkdS0n9ezghPwe8u8KZY3wiR805fNrqkoMHHEZDndtlv0sq0p
         8692FYrFvE5S4Z7k4FbNzSB7vfP6gM0vZ3DJArHA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220330052217epcas1p25791a4462e3e4e1cc49afd0e401ccbcc~hERkOF4M60062400624epcas1p2R;
        Wed, 30 Mar 2022 05:22:17 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.240]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KSvvD3hrlz4x9Pv; Wed, 30 Mar
        2022 05:22:16 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.B0.64085.609E3426; Wed, 30 Mar 2022 14:22:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220330052214epcas1p250cff6b3168a1c9c253e1fe70e68ca8b~hERhO17-b0062400624epcas1p2F;
        Wed, 30 Mar 2022 05:22:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220330052214epsmtrp20694a2aaa812a50637d287736b0fe26d~hERhOE1JP2542825428epsmtrp2g;
        Wed, 30 Mar 2022 05:22:14 +0000 (GMT)
X-AuditID: b6c32a35-9c3ff7000000fa55-ca-6243e906a730
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.CF.24342.609E3426; Wed, 30 Mar 2022 14:22:14 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220330052214epsmtip1463f93b07e7644d512d5ef513d004421~hERhFqgNI1499314993epsmtip1e;
        Wed, 30 Mar 2022 05:22:14 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        s.suk@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] zram_drv: add __GFP_NOWARN flag on call to zs_malloc
Date:   Wed, 30 Mar 2022 14:25:02 +0900
Message-Id: <20220330052502.26072-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmgS7bS+ckg+YdFhZz1q9hs+jePJPR
        ovf9KyaLy7vmsFncW/Of1WLZ1/fsFhtaZrFbLPp7hd1i98ZFbA6cHrMbLrJ47Jx1l91j06pO
        No9Nnyaxe5yY8ZvFo2/LKkaPnZ82s3p83iQXwBGVbZORmpiSWqSQmpecn5KZl26r5B0c7xxv
        amZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdJ+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp
        tSAlp8CsQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj9/s7jAVfeSouzXvI3sDYwd3FyMkhIWAi
        cXbuDbYuRi4OIYEdjBLX9j9kh3A+MUpM/tEKlfnGKPF7/QcmmJavzTNZIRJ7GSX+N/9ihnB+
        MEp8WXmODaSKTUBb4v2CSawgtohAgsSBrRfAipgFOhglOl80gRUJC7hK/JlylhnEZhFQlbhx
        eAMjiM0rYCvx8+VcNoh18hKrNxwAa5YQuMUu8f7zQ1aIhIvE65932CFsYYlXx7dA2VISn9/t
        hWrOlnh68ghQMweQnSPRsEEWwrSXeH/JAsRkFtCUWL9LH6JYUWLn77lgFzAL8Em8+9rDClHN
        K9HRJgRRoibR8uwr1H4Zib//nkHZHhLrWxeD7RQSiJXoOv+KaQKj7CyEBQsYGVcxiqUWFOem
        pxYbFhjCIyk5P3cTIzjJaZnuYJz49oPeIUYmDsZDjBIczEoivB8POicJ8aYkVlalFuXHF5Xm
        pBYfYjQFhtZEZinR5Hxgms0riTc0sTQwMTMysTC2NDZTEuddNe10opBAemJJanZqakFqEUwf
        EwenVAPTwmOCFmZzWRmnPg3Qc9px72Db9z/Kms4HXpvvUr5qcVP82SGxupfJj36dqcpf6MCT
        NK2xb9XLaz38r2Yzffm3zGZF1is+HYOaigbuqh8ftLhX+R9fGct55dmBXdl1NZd2NbzMMfnX
        tUyoUO5yfeGkOf+zZ/6qcpKpuBch1TlVksf/lNJT8/Os/gF9hzu45JSfOp4MDvIJYf/B8XHl
        VI8AVoXDSxQX6ATr56iUWYRd+nXu0ATTe+oqS4PXvc6SOXf42uM/b/KLuWrrtSdvPm+nGnLk
        at6BwLRz3bdzOf+quPaUvZ8UP/mW18IZws07eRzvPMiKf3/p1aUFi27Gxsm3bPf6f+Oq4fTy
        khv3uxeXK7EUZyQaajEXFScCAA5qaVD7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSnC7bS+ckg7cn1CzmrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8Wyr+/ZLTa0zGK3WPT3CrvF7o2L2Bw4PWY3XGTx2DnrLrvHplWd
        bB6bPk1i9zgx4zeLR9+WVYweOz9tZvX4vEkugCOKyyYlNSezLLVI3y6BK2P3+zuMBV95Ki7N
        e8jewNjB3cXIySEhYCLxtXkmaxcjF4eQwG5GidkrFrNBJGQk3px/ytLFyAFkC0scPlwMEhYS
        +MYose5iIojNJqAt8X7BJFYQW0QgReLw6flgc5gF+hglDu99xQSSEBZwlfgz5SwziM0ioCpx
        4/AGRhCbV8BW4ufLuVC75CVWbzjAPIGRZwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k
        /NxNjOCw09Lcwbh91Qe9Q4xMHIyHGCU4mJVEeD8edE4S4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        znuh62S8kEB6YklqdmpqQWoRTJaJg1OqgenAzOkbUiYwT7nJ/uvmd21eGWYjQ/3Ci/s9TG82
        XPW4aiw+Le3R2aYFGYazWPeJvq9kXip/d39Uzuznvz78+vaZberTbasijC7uZRK5dMHVs8zp
        zJ1dNtddHllVpy+YuTGWL+qec42ANRsX78UjHfc3c3bcta19vapwQo3ujsvGQuWecydvisiQ
        mKMQwTvRrUST8djhJYqPzqzY5v9O8nBSS1jIXH/m+wt23bIoFbbr/66UkTddYVnC9/VPTWb+
        7vfRqVPm0BFNeaxQdi88Q2C654knHXotxmvLgztE/GXXmv1a7Lv81Jll3S9/rI5huLly6cmt
        FkJbLdelZ1dGl5pKr4jSXxVYdjvT7I6Ro4gSS3FGoqEWc1FxIgCYU9ChqgIAAA==
X-CMS-MailID: 20220330052214epcas1p250cff6b3168a1c9c253e1fe70e68ca8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220330052214epcas1p250cff6b3168a1c9c253e1fe70e68ca8b
References: <CGME20220330052214epcas1p250cff6b3168a1c9c253e1fe70e68ca8b@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page allocation with GFP_NOIO may fail. And zram can handle this
allocation failure. We do not need to print log for this.

Actually warn_alloc was more restricted by commit 1be334e5c088
("mm/page_alloc.c: ratelimit allocation failure warnings more
aggressively"). To catch other allocation failure, zram can use
__GFP_NOWARN.

This is what I got.

kswapd0: page allocation failure: order:0, mode:0x140000a(GFP_NOIO|__GFP_HIGHMEM|__GFP_MOVABLE), nodemask=(null)
kswapd0 cpuset=/ mems_allowed=0
Call trace:
 dump_backtrace+0x0/0x218
 show_stack+0x14/0x1c
 dump_stack+0xb8/0xf0
 warn_alloc+0x110/0x234
 __alloc_pages_nodemask+0x11c0/0x12a0
 zs_malloc+0x1ac/0x50c
 zram_bvec_rw+0x1a4/0x6a8
 zram_make_request+0x23c/0x328
 generic_make_request+0xe4/0x270
 submit_bio+0x64/0x2a8
 __swap_writepage+0x3a8/0x404
 swap_writepage+0x40/0x4c
 shrink_page_list.llvm.15153564514306699876+0xffc/0x13a0
 shrink_inactive_list+0x2dc/0x710
 shrink_node_memcg+0x394/0x940
 shrink_node+0x194/0x380

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e9474b02012d..c22201da25bb 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1405,6 +1405,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				GFP_NOIO | __GFP_HIGHMEM |
+				__GFP_NOWARN |
 				__GFP_MOVABLE);
 		if (handle)
 			goto compress_again;
-- 
2.17.1

