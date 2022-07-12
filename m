Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D5571591
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiGLJTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiGLJT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:19:27 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4EC29CB3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:19:25 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220712091923epoutp046661bf4f274a511baee369b5be2bbf94~BCmRNT-lH3147931479epoutp04j
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:19:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220712091923epoutp046661bf4f274a511baee369b5be2bbf94~BCmRNT-lH3147931479epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657617563;
        bh=S4sWA7zpUxXQxa89UcMXHDfRa3Uo+V+0HHoj21c47ls=;
        h=From:To:Cc:Subject:Date:References:From;
        b=af3Qne0fYzJY56jPLx168ctUBFJggh3DBZ0HiXN2gxrtHvDh53FsW5Zuwx09Dytl2
         kk152BIzGlZhGNgVr/2Kypg3W5MYCnlyXfB1ZiPoBrdwUZy+w6wMTGDHIvlcMlXWXU
         kYiDL/wFSfMuyteJNJl/o03F2AYgd8jmHpbr+UbM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220712091923epcas2p2d8c9949b628b4b6e4153660b8e8a77a8~BCmQ3UYbS0377803778epcas2p2I;
        Tue, 12 Jul 2022 09:19:23 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.70]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LhwDp6CqMz4x9Px; Tue, 12 Jul
        2022 09:19:22 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.BD.09650.A9C3DC26; Tue, 12 Jul 2022 18:19:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220712091922epcas2p34d7c89f02780afa58950b103a62eb59a~BCmP5wUjE1861318613epcas2p38;
        Tue, 12 Jul 2022 09:19:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220712091922epsmtrp26f3397e855bb57a8d27fd5e227f08c28~BCmP49ybx0221702217epsmtrp2P;
        Tue, 12 Jul 2022 09:19:22 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-86-62cd3c9a4cc5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.23.08905.A9C3DC26; Tue, 12 Jul 2022 18:19:22 +0900 (KST)
Received: from perf.dsn.sec.samsung.com (unknown [10.229.95.91]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220712091922epsmtip216614efb6837191bae4945185bdb719f~BCmPwWW292457724577epsmtip2C;
        Tue, 12 Jul 2022 09:19:22 +0000 (GMT)
From:   Youngmin Nam <youngmin.nam@samsung.com>
To:     arnd@arndb.de, jstultz@google.com, tglx@linutronix.de
Cc:     sboyd@kernel.org, linux-kernel@vger.kernel.org,
        youngmin.nam@samsung.com, chanho61.park@samsung.com,
        hajun.sung@samsung.com, hosung0.kim@samsung.com,
        d7271.choe@samsung.com
Subject: [PATCH] time: correct the prototype of ns_to_kernel_old_timeval and
 ns_to_timespec64
Date:   Tue, 12 Jul 2022 18:47:15 +0900
Message-Id: <20220712094715.2918823-1-youngmin.nam@samsung.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTXHeWzdkkg89/9S3+TjrGbnF5v7bF
        tb0T2S2a9l9itvh6/RG7xZ8TG9ksLu+aw2bx79pGFovNm6YyWyw+8Indgcvj969JjB4LNpV6
        bFrVyebx7tw5do++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
        MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6g
        V5yYW1yal66Xl1piZWhgYGQKVJiQnXH9QitTwXeRioetjxgbGD8LdjFyckgImEgsW3KXtYuR
        i0NIYAejxMent1ggnE+MErd3rWMBqRIS+MYo0fZRAKajve8XO0TRXkaJ+2++sUE4XxklVn/e
        zQxSxSagK7HtxD/GLkYODhEBS4lb/T4gNcwCWxglWiedYAaJCwvES3S90wApZxFQldh6cREb
        iM0rYC8x5+UTJpASCQF5iT+vBCDCghInZz4Bu4cZKNy8dTYzyEgJgbfsEhf3/2CGOM5F4ufn
        b+wQtrDEq+NboGwpic/v9rJB2MUST84uZYRobmCU2L34NQtEwlhi1rN2sJuZBTQl1u/Sh7hB
        WeLILai9fBIdh/+yQ4R5JTrahCAa1SR+TdnACGHLAA1cAXWNh8TNkweYIUEYK9F2aDnzBEb5
        WUi+mYXkm1kIexcwMq9iFEstKM5NTy02KjCCR2lyfu4mRnDK1HLbwTjl7Qe9Q4xMHIyHGCU4
        mJVEeP+cPZUkxJuSWFmVWpQfX1Sak1p8iNEUGLwTmaVEk/OBSTuvJN7QxNLAxMzM0NzI1MBc
        SZzXK2VDopBAemJJanZqakFqEUwfEwenVAOT9pzgiaqeSa8zI9q+R8z8mzaFK85my/IJHNsC
        4pvdDp24WH96aUln1Zy7U0J33S0QfVyReGb//trNP/32NL3+/XK+6lHpS446wXbTtddotfZF
        zpl2+55W8YHboY+dw8T/9qU/UDtw+oDmtWde18p8t+enl9YaL1U6pDFXqc3kwB578dm3c2Zt
        TInWMI/YUMK5+GsxT8Ore/xbi3e98n9xV3f7TuGZrduYe/zn20rtt+hKUKkIYNyy4vG5DTcn
        XOsQLn804em57YdSG1+6zhQ2+3C0Pdv47dndReatqdeex1ue06sWsJ08c7XszLQHzYce78yY
        de1KRsqaY16m25Mcow8ueRMxP///ws1zH50341JiKc5INNRiLipOBADpzyVRIgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSvO4sm7NJBjdXCFn8nXSM3eLyfm2L
        a3snsls07b/EbPH1+iN2iz8nNrJZXN41h83i37WNLBabN01ltlh84BO7A5fH71+TGD0WbCr1
        2LSqk83j3blz7B59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVcf1CK1PBd5GKh62PGBsYPwt2
        MXJySAiYSLT3/WLvYuTiEBLYzSgxf9YDJoiEjMTtlZdZIWxhifstR8BsIYHPjBJ9Z2RAbDYB
        XYltJ/4xgtgiArYSH5bNAxvELLCHUeLb3HlgDcICsRLn7k1mAbFZBFQltl5cxAZi8wrYS8x5
        +QRoGQfQAnmJP68EIMKCEidnPgErZwYKN2+dzTyBkW8WktQsJKkFjEyrGCVTC4pz03OLDQsM
        81LL9YoTc4tL89L1kvNzNzGCA1lLcwfj9lUf9A4xMnEwHmKU4GBWEuH9c/ZUkhBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MudFTYgQzrjlpOhStcQpR
        z3j2b+oCU9WYvZ4bVRfmftY9ks394cKcApt1vnPStnBOX7Np02UOr7rojufdXRqMIQKpm7N2
        rTwi36K87v5z7+ZH/rKrLES5FkwNFLRwb3tUXZUsK5BXdkPHhXWW3nXf2asNZ0+ws3eO8red
        9Or54hVfjh8/MK3i7qyPz7jtf/8yu6XGzbf5oOxsy2VzXszilHh3oFb04MMTbmyFP6MjzLtk
        rk2dMmHXbK6VU0Wvyd47ybnmlCbH/GSGnvcvA0SFa3Z4PlVbufhx3VzZG+m3n9zae8VptcaR
        79lyh+Ju7ql/XW87xyDCnNFM4nZv5r188fzFf6Rb9oXrSO7Ysmj9GiWW4oxEQy3mouJEAD26
        Dc3TAgAA
X-CMS-MailID: 20220712091922epcas2p34d7c89f02780afa58950b103a62eb59a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220712091922epcas2p34d7c89f02780afa58950b103a62eb59a
References: <CGME20220712091922epcas2p34d7c89f02780afa58950b103a62eb59a@epcas2p3.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ns_to_kernel_old_timeval() definition,
the function argument is defined with const identifier in kernel/time/time.c,
but the prototype in include/linux/time32.h looks different.

- The function is defined in kernel/time/time.c as below:
struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)

- The function is decalared in include/linux/time32.h as below:
extern struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec);

Because the variable of arithmethic types isn't modified in the calling scope,
there's no need to mark arguments as const.
And there is a review in Link[1] why it was omitted during review stage,
so they should be matched.

Likewise, we can remove the "const" keyword in both definition and declaration
of ns_to_timespec64() as it was metentined below Link[2] and Link[3].

Link[1]: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1637458.html
Link[2]: https://lore.kernel.org/all/20220531064346.51677-1-chanho61.park@samsung.com/T/
Link[3]: https://lore.kernel.org/lkml/CAK8P3a3nknJgEDESGdJH91jMj6R_xydFqWASd8r5BbesdvMBgA@mail.gmail.com
Fixes: a84d1169164b ("y2038: Introduce struct __kernel_old_timeval")
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 include/linux/time64.h | 2 +-
 kernel/time/time.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index 81b9686a2079..ee021da0966e 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -142,7 +142,7 @@ static inline s64 timespec64_to_ns(const struct timespec64 *ts)
  *
  * Returns the timespec64 representation of the nsec parameter.
  */
-extern struct timespec64 ns_to_timespec64(const s64 nsec);
+extern struct timespec64 ns_to_timespec64(s64 nsec);
 
 /**
  * timespec64_add_ns - Adds nanoseconds to a timespec64
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 29923b20e0e4..526257b3727c 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -449,7 +449,7 @@ time64_t mktime64(const unsigned int year0, const unsigned int mon0,
 }
 EXPORT_SYMBOL(mktime64);
 
-struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
+struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec)
 {
 	struct timespec64 ts = ns_to_timespec64(nsec);
 	struct __kernel_old_timeval tv;
@@ -503,7 +503,7 @@ EXPORT_SYMBOL(set_normalized_timespec64);
  *
  * Returns the timespec64 representation of the nsec parameter.
  */
-struct timespec64 ns_to_timespec64(const s64 nsec)
+struct timespec64 ns_to_timespec64(s64 nsec)
 {
 	struct timespec64 ts = { 0, 0 };
 	s32 rem;
-- 
2.34.0

