Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5361A53C4AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbiFCFxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238256AbiFCFxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:53:52 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F2D369D5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 22:53:47 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220603055343epoutp02b3006a4d32280e7dcadcc59b80a1a6dd~1BojiwVmI1029510295epoutp02T
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:53:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220603055343epoutp02b3006a4d32280e7dcadcc59b80a1a6dd~1BojiwVmI1029510295epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654235623;
        bh=2vp+vtxXSovQ07+Thh72i4FtOaP2QjNC2VwRjYZww9g=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cv+YDMrSc1/V9jXeglpYh8egp0XZIRgnrrckFbL6TUeD/AvtkDNm8fw2M2AYGDUFt
         lBjikXTcSiSpBqbt45qa8A/G+MB2vw/NEIf06tDOzmn4+pZFJBwRuyZ1Y3JX/my593
         s2BQVA0Vwbcwl7RwUyjHerxbJyR1PMia77JaN20k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220603055342epcas1p4e4ad24e92599716f6335a9451a56bfae~1Boi-oBgS0033600336epcas1p4P;
        Fri,  3 Jun 2022 05:53:42 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.227]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LDsWV1nKDz4x9Pt; Fri,  3 Jun
        2022 05:53:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.09.10038.6E1A9926; Fri,  3 Jun 2022 14:53:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220603055341epcas1p2dd357326eea0cd818daf6f0db7c2aae1~1BoiYHheo1606816068epcas1p2y;
        Fri,  3 Jun 2022 05:53:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220603055341epsmtrp12261684615051a402126ed0330200330~1BoiXFzXR1836218362epsmtrp1N;
        Fri,  3 Jun 2022 05:53:41 +0000 (GMT)
X-AuditID: b6c32a37-127ff70000002736-b1-6299a1e6b29f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.4A.11276.5E1A9926; Fri,  3 Jun 2022 14:53:41 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220603055341epsmtip1cd40b857968079e4196898519385ac44~1BoiNbcR_0417204172epsmtip1e;
        Fri,  3 Jun 2022 05:53:41 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        avromanov@sberdevices.ru, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        s.suk@samsung.com, ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] zram_drv: add __GFP_NOMEMALLOC not to use
 ALLOC_NO_WATERMARKS
Date:   Fri,  3 Jun 2022 14:57:47 +0900
Message-Id: <20220603055747.11694-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmnu6zhTOTDF5+5rSYs34Nm0X/5f2M
        Ft2bZzJa9L5/xWRxedccNot7a/6zWiz7+p7dYkPLLHaLRX+vsFvs3riIzeLxem4Hbo/ZDRdZ
        PHbOusvusWlVJ5vHpk+T2D1OzPjN4tG3ZRWjx4W1d1k9dn7azOrxeZNcAGdUtk1GamJKapFC
        al5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0LVKCmWJOaVAoYDE4mIl
        fTubovzSklSFjPziElul1IKUnAKzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMmbtVCo4qVTyZ
        95CxgXGNbBcjJ4eEgInEzhfz2boYuTiEBHYwSvR8fsoKkhAS+MQocXd6CETiG6PEo68nmGA6
        vuxbxQiR2Mso0btmNZTzg1Hiavc5sHY2AW2J9wsmgdkiAlUSfx49ZwUpYhaYzygx/9hdli5G
        Dg5hgQCJffe9QEwWAVWJV9tTQExeAVuJPZ8rIHbJS6zecIAZpFNC4CW7xMYDD9khEi4S/85s
        Y4OwhSVeHd8CFZeSeNnfBmVnSzw9eYQZZKaEQI5EwwZZCNNe4v0lCxCTWUBTYv0ufYhiRYmd
        v+cygtjMAnwS7772sEJU80p0tAlBlKhJtDz7ygphy0j8/fcMyvaQ2PX+DRMk1GIlFtybwzyB
        UXYWwoIFjIyrGMVSC4pz01OLDQuM4fGTnJ+7iRGc9rTMdzBOe/tB7xAjEwfjIUYJDmYlEd6y
        eTOThHhTEiurUovy44tKc1KLDzGaAsNqIrOUaHI+MPHmlcQbmlgamJgZmVgYWxqbKYnzrpp2
        OlFIID2xJDU7NbUgtQimj4mDU6qByfvMKvW+NTef6orFzt3B8VPu0p545odC9//eMcuX+PV7
        6oJWVkMr8Sde1lWnnH7/n+fwuT9tS0OjfvUSvtPiM+bt3RRz/MFmvqW+x3J/HWzYfP7EtlAP
        1xBz83mV6wJ1zvc5pvN+vdE1S/3ZyUN9Tu5yci8uaa964vxru92yTW8im25M/ff/gNRF/edz
        gl5yRT7SOeAUGNv99vKnkL1KZmtsdBriVPp5i/c76UWyuym+WMB6c8mF/Z68Th+vnZOQevz5
        3qIs04ML+X2lBCcuSkjRuWhYoffQ8PVhNa2Fh2/cCG/b63Ku5vuBS6lOD7a2Ghulpe8y6//I
        v+WWVPf57sbbumJSavE7Xq6ba+mjsl6JpTgj0VCLuag4EQD1GykRBAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSnO7ThTOTDBYdMbCYs34Nm0X/5f2M
        Ft2bZzJa9L5/xWRxedccNot7a/6zWiz7+p7dYkPLLHaLRX+vsFvs3riIzeLxem4Hbo/ZDRdZ
        PHbOusvusWlVJ5vHpk+T2D1OzPjN4tG3ZRWjx4W1d1k9dn7azOrxeZNcAGcUl01Kak5mWWqR
        vl0CV8bM3SoFR5Uqnsx7yNjAuEa2i5GTQ0LAROLLvlWMXYxcHEICuxklek6+YIVIyEi8Of+U
        pYuRA8gWljh8uBgkLCTwjVFi5Y1QEJtNQFvi/YJJYOUiAg2MEq3vk0DmMAssZZRYdm4tO0hC
        WMBP4vTzn2BzWARUJV5tTwExeQVsJfZ8roDYJC+xesMB5gmMPAsYGVYxSqYWFOem5xYbFhjm
        pZbrFSfmFpfmpesl5+duYgQHo5bmDsbtqz7oHWJk4mA8xCjBwawkwls2b2aSEG9KYmVValF+
        fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzHnjRfVttxe8tjp9P1FxN6
        7tUWvTYytuBd8Ixvi2Ba65eGnoyEkNYoM2v3aH3dt0a21+psOCtiz/6f6p69OyOiTPVWoMLT
        hT9uWTBqFoln1r+6XqzH/6F3xX1NBa5XS542rzz88SuTxiOD392npygtevSk6eKCQxZVWRMi
        3x7WWsR2yPVUt5cLO+dU5aCioi+drPm6a9ue/m+oUTrk9oxvOmt8hMMW4U1flk3wK94U37Zc
        56RyDEvhv1kbd2gsaggInRT74krIRdaOq6/1jb+w+u/LfL78B7u+f18Ql2Gf3//tBqp/jtc4
        RV+MYlLf339V4uhh3hgLSyVRVRX5OYxT1yy/Or1uZ/g1BsYDt5RYijMSDbWYi4oTAZPAd421
        AgAA
X-CMS-MailID: 20220603055341epcas1p2dd357326eea0cd818daf6f0db7c2aae1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603055341epcas1p2dd357326eea0cd818daf6f0db7c2aae1
References: <CGME20220603055341epcas1p2dd357326eea0cd818daf6f0db7c2aae1@epcas1p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic page allocation failure sometimes happened, and most of them
seem to occur during boot time.

<4>[   59.707645] system_server: page allocation failure: order:0, mode:0xa20(GFP_ATOMIC), nodemask=(null),cpuset=foreground-boost,mems_allowed=0
<4>[   59.707676] CPU: 5 PID: 1209 Comm: system_server Tainted: G S O      5.4.161-qgki-24219806-abA236USQU0AVE1 #1
<4>[   59.707691] Call trace:
<4>[   59.707702]  dump_backtrace.cfi_jt+0x0/0x4
<4>[   59.707712]  show_stack+0x18/0x24
<4>[   59.707719]  dump_stack+0xa4/0xe0
<4>[   59.707728]  warn_alloc+0x114/0x194
<4>[   59.707734]  __alloc_pages_slowpath+0x828/0x83c
<4>[   59.707740]  __alloc_pages_nodemask+0x2b4/0x310
<4>[   59.707747]  alloc_slab_page+0x40/0x5c8
<4>[   59.707753]  new_slab+0x404/0x420
<4>[   59.707759]  ___slab_alloc+0x224/0x3b0
<4>[   59.707765]  __kmalloc+0x37c/0x394
<4>[   59.707773]  context_struct_to_string+0x110/0x1b8
<4>[   59.707778]  context_add_hash+0x6c/0xc8
<4>[   59.707785]  security_compute_sid.llvm.13699573597798246927+0x508/0x5d8
<4>[   59.707792]  security_transition_sid+0x2c/0x38
<4>[   59.707804]  selinux_socket_create+0xa0/0xd8
<4>[   59.707811]  security_socket_create+0x68/0xbc
<4>[   59.707818]  __sock_create+0x8c/0x2f8
<4>[   59.707823]  __sys_socket+0x94/0x19c
<4>[   59.707829]  __arm64_sys_socket+0x20/0x30
<4>[   59.707836]  el0_svc_common+0x100/0x1e0
<4>[   59.707841]  el0_svc_handler+0x68/0x74
<4>[   59.707848]  el0_svc+0x8/0xc
<4>[   59.707853] Mem-Info:
<4>[   59.707890] active_anon:223569 inactive_anon:74412 isolated_anon:0
<4>[   59.707890]  active_file:51395 inactive_file:176622 isolated_file:0
<4>[   59.707890]  unevictable:1018 dirty:211 writeback:4 unstable:0
<4>[   59.707890]  slab_reclaimable:14398 slab_unreclaimable:61909
<4>[   59.707890]  mapped:134779 shmem:1231 pagetables:26706 bounce:0
<4>[   59.707890]  free:528 free_pcp:844 free_cma:147
<4>[   59.707900] Node 0 active_anon:894276kB inactive_anon:297648kB active_file:205580kB inactive_file:706488kB unevictable:4072kB isolated(anon):0kB isolated(file):0kB mapped:539116kB dirty:844kB writeback:16kB shmem:4924kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
<4>[   59.707912] Normal free:2112kB min:7244kB low:68892kB high:72180kB active_anon:893140kB inactive_anon:297660kB active_file:204740kB inactive_file:706396kB unevictable:4072kB writepending:860kB present:3626812kB managed:3288700kB mlocked:4068kB kernel_stack:62416kB shadow_call_stack:15656kB pagetables:106824kB bounce:0kB free_pcp:3372kB local_pcp:176kB free_cma:588kB
<4>[   59.707915] lowmem_reserve[]: 0 0
<4>[   59.707922] Normal: 8*4kB (H) 5*8kB (H) 13*16kB (H) 25*32kB (H) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1080kB
<4>[   59.707942] 242549 total pagecache pages
<4>[   59.707951] 12446 pages in swap cache
<4>[   59.707956] Swap cache stats: add 212408, delete 199969, find 36869/71571
<4>[   59.707961] Free swap  = 3445756kB
<4>[   59.707965] Total swap = 4194300kB
<4>[   59.707969] 906703 pages RAM
<4>[   59.707973] 0 pages HighMem/MovableOnly
<4>[   59.707978] 84528 pages reserved
<4>[   59.707982] 49152 pages cma reserved

The kswapd or other reclaim contexts may not prepare enough free pages
for too many atomic allocations occurred in short time. But zram may not
be helpful for this atomic allocation even though zram is used to
reclaim.

To get one zs object for a specific size, zram may allocate serveral
pages. And this can be happened on different class sizes at the same
time. It means zram may consume more pages to reclaim only one page.
This inefficiency may consume all free pages below watmerk min by a
process having PF_MEMALLOC like kswapd.

We can avoid this by adding __GFP_NOMEMALLOC. PF_MEMALLOC process won't
use ALLOC_NO_WATERMARKS.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b8549c61ff2c..39cd1397ed3b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1383,6 +1383,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 
 	handle = zs_malloc(zram->mem_pool, comp_len,
 			__GFP_KSWAPD_RECLAIM |
+			__GFP_NOMEMALLOC |
 			__GFP_NOWARN |
 			__GFP_HIGHMEM |
 			__GFP_MOVABLE);
-- 
2.17.1

