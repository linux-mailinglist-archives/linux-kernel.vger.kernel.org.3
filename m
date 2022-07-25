Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DA757FCB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiGYJw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiGYJw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:52:26 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E073167F9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:52:22 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220725095216epoutp0487e30d94ea26da70980f34a3b72878ae~FCbsSjRoN1657316573epoutp04n
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:52:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220725095216epoutp0487e30d94ea26da70980f34a3b72878ae~FCbsSjRoN1657316573epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658742736;
        bh=1SZSN+URK3fPaUP+8oBcbCaH7+pgUXYqMJcXmpr8nqs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=RnFMCbzIR2Vnuz6qSbcBf13vjvHKXdVMDd8PTQM3DQcJvlla/aYRifNnVWCF0Ivby
         IJNGilPlipO6N4PrAts+WklXW64CYBPS9f+rYGwuXGeEoeXFVfvwXyQyNhMc9Z2qZj
         16Ng2zdlM4T9LIAbV29Qz6K9gRo8VGf/rsESnnSY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220725095215epcas1p30bf348ac3b337b66638d4422dd796729~FCbrSseRB1436114361epcas1p3c;
        Mon, 25 Jul 2022 09:52:15 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.241]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LrwLl2xf4z4x9Q0; Mon, 25 Jul
        2022 09:52:15 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.55.09678.FC76ED26; Mon, 25 Jul 2022 18:52:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220725095214epcas1p1cc2019c792560da07d673809a3fc7ef3~FCbqhhizu2036020360epcas1p1-;
        Mon, 25 Jul 2022 09:52:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220725095214epsmtrp122086ac3523b47fc40b9ce78431eac60~FCbqgoIjW1354513545epsmtrp1L;
        Mon, 25 Jul 2022 09:52:14 +0000 (GMT)
X-AuditID: b6c32a39-e67ff700000025ce-a1-62de67cf6dc2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.35.08905.EC76ED26; Mon, 25 Jul 2022 18:52:14 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220725095214epsmtip2a03a41b1c28accef45748067fba52612~FCbqUYN2t3171331713epsmtip2v;
        Mon, 25 Jul 2022 09:52:14 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     minchan@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
        vbabka@suse.cz, mgorman@techsingularity.net, hannes@cmpxchg.org,
        mhocko@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gh21.hong@samsung.com, ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v2] page_alloc: fix invalid watemark check on a negative
 value
Date:   Mon, 25 Jul 2022 18:52:12 +0900
Message-Id: <20220725095212.25388-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTV/d8+r0kg/N9QhZz1q9hszj/4Beb
        xZbfbxgtVm/ytejePJPRovf9KyaLy7vmsFncW/Of1WLH0n1MFq+/LWO2WPb1PbvF7MY+RovH
        67kdeD0Ov3nP7LFz1l12j02rOtk8Nn2axO5xYsZvFo/3+66yefRtWcXocWbBEXaPrb/sPD5v
        kgvgisq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6
        XUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFagV5yYW1yal66Xl1piZWhgYGQK
        VJiQnbFo9xaWgn7Bik2N59kaGPv4uhg5OSQETCR2vP/G0sXIxSEksINRomHnC1YI5xOjxK4F
        +6Gcb4wSjw7dZYZp6Vy/lBkisZdR4vDWRWwQzg9GiYc951lAqtgEtCXeL5gE1i4iMJNRYv6N
        RWAJZoHFjBJfHiaA2MICARJLzk9lA7FZBFQlJj95BraCV8BWYu/2fnaIdfISqzccAFsnIdDK
        IfFg2RlGiISLxMTnO1kgbGGJV8e3QDVISbzsb4OysyWenjwC1MwBZOdINGyQhTDtJd5fsgAx
        mQU0Jdbv0ocoVpTY+XsuI8SVfBLvvvawQlTzSnS0CUGUqEm0PPvKCmHLSPz99wzK9pB4fX8m
        I0i5kECsRPPG8AmMsrMQ5i9gZFzFKJZaUJybnlpsWGAKj6Pk/NxNjODEqGW5g3H62w96hxiZ
        OBgPMUpwMCuJ8Hal3U4S4k1JrKxKLcqPLyrNSS0+xGgKDKyJzFKiyfnA1JxXEm9oYmlgYmZk
        YmFsaWymJM67atrpRCGB9MSS1OzU1ILUIpg+Jg5OqQamPT1ML3OnGidsYl1vfsDrv89mlx3a
        MbHX5b7rb/227sX+9eniFzU0fkvK2C3XE8m7c2Sz87Ou6+7mp3l/N0Q4CO9J22W0uu70kqXc
        /bllf9w79I7IHGvZbz6rTOgFT6d253Lvj0tu36i7dXK+QnGGNUPKtoMzPKL0o80OetofeH/E
        uV5VUlmjc/UVEf0dC3c1Or+bZV36b+qETZWtsq+TnN3vNdzjjUq1zNpt8DWwNrX+VGj/zbzp
        mbr/LR8c4p77LlpCnJexKPalacmcy+62sbNmR9UvXMmgvP/siYPqy/iiYy9J7r/49u92qeN2
        r7Ru2wbGvHxY8OzoqUT5GwGHLHu/xibYnTSYoir2a5u1EktxRqKhFnNRcSIAIwZLkRUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSvO659HtJBlO+G1nMWb+GzeL8g19s
        Flt+v2G0WL3J16J780xGi973r5gsLu+aw2Zxb81/VosdS/cxWbz+tozZYtnX9+wWsxv7GC0e
        r+d24PU4/OY9s8fOWXfZPTat6mTz2PRpErvHiRm/WTze77vK5tG3ZRWjx5kFR9g9tv6y8/i8
        SS6AK4rLJiU1J7MstUjfLoErY9HuLSwF/YIVmxrPszUw9vF1MXJySAiYSHSuX8rcxcjFISSw
        m1Fi0779bBAJGYk355+ydDFyANnCEocPF0PUfGOUeHXsGxNIDZuAtsT7BZNYQRIiAgsZJXa+
        fwE2iVlgJaPE25fzGEGqhAX8JJYumscKYrMIqEpMfvKMGcTmFbCV2Lu9nx1im7zE6g0HmCcw
        8ixgZFjFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcsFqaOxi3r/qgd4iRiYPxEKME
        B7OSCG9X2u0kId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODil
        Gpjm1/lbrts2u4Sd77dX9R3R1+z32VfU79/+vnu74i3eb+2BEtEic+SEeT6qNUh0vtl8caJA
        KFuOwZYWS+boGsVbXh/ylK99XXh6TtLs9y94BLg1XgQuZjF/Hq3Vt1ghluPdDU6Tec8Z2k/u
        ShY4oSj7yixPgHP5ScNTT/cmv92yMmPivJfHrj2+yF/J//y627sl+7pL5N0D4msq1JqMeCP9
        fTmj5NUcex9XZj8UDvGUcZPVy3J9rLdM5N1/1p//TiXOtbU8y7rUvXRR69Sz96ofMUc/Uc9e
        dO3AVUXDDVaet1cwhnILL/txMrHKd5Fo7cEA+wczFkz9NmdzU4TN19eZ/Vr9ySdL9/scWcr2
        8YQSS3FGoqEWc1FxIgAhUwPdxwIAAA==
X-CMS-MailID: 20220725095214epcas1p1cc2019c792560da07d673809a3fc7ef3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725095214epcas1p1cc2019c792560da07d673809a3fc7ef3
References: <CGME20220725095214epcas1p1cc2019c792560da07d673809a3fc7ef3@epcas1p1.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a report that a task is waiting at the
throttle_direct_reclaim. The pgscan_direct_throttle in vmstat was
increasing.

This is a bug where zone_watermark_fast returns true even when the free
is very low. The commit f27ce0e14088 ("page_alloc: consider highatomic
reserve in watermark fast") changed the watermark fast to consider
highatomic reserve. But it did not handle a negative value case which
can be happened when reserved_highatomic pageblock is bigger than the
actual free.

If watermark is considered as ok for the negative value, allocating
contexts for order-0 will consume all free pages without direct reclaim,
and finally free page may become depleted except highatomic free.

Then allocating contexts may fall into throttle_direct_reclaim. This
symptom may easily happen in a system where wmark min is low and other
reclaimers like kswapd does not make free pages quickly.

Handle the negative case by using MIN.

Fixes: f27ce0e14088 ("page_alloc: consider highatomic reserve in watermark fast")
Reported-by: GyeongHwan Hong <gh21.hong@samsung.com>
Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
v2: use explicit code suggested by Mel Gorman
v1: use signed min
---

 mm/page_alloc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3df0485..b5b14b78c4fd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3968,11 +3968,15 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 	 * need to be calculated.
 	 */
 	if (!order) {
-		long fast_free;
+		long usable_free;
+		long reserved;
 
-		fast_free = free_pages;
-		fast_free -= __zone_watermark_unusable_free(z, 0, alloc_flags);
-		if (fast_free > mark + z->lowmem_reserve[highest_zoneidx])
+		usable_free = free_pages;
+		reserved = __zone_watermark_unusable_free(z, 0, alloc_flags);
+
+		/* reserved may over estimate high-atomic reserves. */
+		usable_free -= min(usable_free, reserved);
+		if (usable_free > mark + z->lowmem_reserve[highest_zoneidx])
 			return true;
 	}
 
-- 
2.17.1

