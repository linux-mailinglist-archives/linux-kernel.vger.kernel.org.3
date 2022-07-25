Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB07757F7EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 03:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiGYB2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 21:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYB2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 21:28:47 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C311477
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 18:28:45 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220725012842epoutp023620e4673a7b0b3c8ac7bbc32a818572~E7kAjr6zY1283612836epoutp022
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:28:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220725012842epoutp023620e4673a7b0b3c8ac7bbc32a818572~E7kAjr6zY1283612836epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658712522;
        bh=cgqftIejdu4DlnvqSpYYKr2ZM6Zshrmmwe8HB00bCyw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=u+2arY5kO/okjkJpmEFnoUbM48eK+9yQcIYfvkGtexZ/OPSGbApCyqYPQCmHFGrf4
         XGyFkyZXHWwFgIISTBcgavWWRhv8i2L440w2H4sbJM/eTS5ULioV4PjsEgHBqVhCO1
         FLu/bi+fyVCO+QLpT1Q12DVH7N5vuV9eKDUCOVmk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220725012841epcas1p15740c06feed0b4115fc0b9fbc8d25dcb~E7j--GUCw0952409524epcas1p1E;
        Mon, 25 Jul 2022 01:28:41 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.250]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Lrj9h74P1z4x9Q0; Mon, 25 Jul
        2022 01:28:40 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.1C.09657.8C1FDD26; Mon, 25 Jul 2022 10:28:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220725012840epcas1p4ae36f072b813f97fc27d33b46da5bc67~E7j-JBgAA3107531075epcas1p4B;
        Mon, 25 Jul 2022 01:28:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220725012840epsmtrp1518099624fb28788de9ba6d437d24833~E7j-IIQMG0443104431epsmtrp1k;
        Mon, 25 Jul 2022 01:28:40 +0000 (GMT)
X-AuditID: b6c32a35-733ff700000025b9-05-62ddf1c887d2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.02.08802.8C1FDD26; Mon, 25 Jul 2022 10:28:40 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220725012840epsmtip272c4d9d351d60288d6c7cd3d7e8e58de~E7j_8p4We2327023270epsmtip2k;
        Mon, 25 Jul 2022 01:28:40 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     minchan@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
        vbabka@suse.cz, mgorman@techsingularity.net, hannes@cmpxchg.org,
        mhocko@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gh21.hong@samsung.com, ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] page_alloc: fix invalid watemark check on a negative value
Date:   Mon, 25 Jul 2022 10:28:43 +0900
Message-Id: <20220725012843.17115-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmnu6Jj3eTDJ48MLOYs34Nm8X5B7/Y
        LLb8fsNosXqTr0X35pmMFr3vXzFZXN41h83i3pr/rBY7lu5jsnj9bRmzxbKv79ktZjf2MVo8
        Xs/twOtx+M17Zo+ds+6ye2xa1cnmsenTJHaPEzN+s3i833eVzaNvyypGjzMLjrB7bP1l5/F5
        k1wAV1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7Q
        6UoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScArMCveLE3OLSvHS9vNQSK0MDAyNT
        oMKE7Izz9x8zFzTyVezdvomxgXE3dxcjJ4eEgInEltezmbsYuTiEBHYwSqx6NoMJwvnEKNHx
        6CkbhPOZUWJx22nWLkYOsJbeRwkg3UICuxglbj3Sgqj5wSixZu9SRpAEm4C2xPsFk1hBEiIC
        Mxkl5t9YxAKSYBZYzCjx5SFYt7CAt8TDvkksIENZBFQlnuwVATF5BWwl7i3ShrhOXmL1hgNg
        10kItHJIPHl8lBki4SJxYspyVghbWOLV8S3sELaUxMv+Nig7W+LpySPMEDfnSDRskIUw7SXe
        X7IAMZkFNCXW79KHKFaU2Pl7LiPEjXwS7772QD3LK9HRJgRRoibR8uwr1E4Zib//nkHZHhLL
        HhxkhwRIrMTWhh3MExhlZyEsWMDIuIpRLLWgODc9tdiwwBAeQcn5uZsYwSlRy3QH48S3H/QO
        MTJxMB5ilOBgVhLh7Uq7nSTEm5JYWZValB9fVJqTWnyI0RQYVhOZpUST84FJOa8k3tDE0sDE
        zMjEwtjS2ExJnHfVtNOJQgLpiSWp2ampBalFMH1MHJxSDUyKrBy6x8qWb6/VXWrNs7VfIuaG
        of0U/llnPlswr14mOtvhbvCZ9S/yeAPi888uXjDRL9m/ZPY8qZ41yfdEFr/sedwwOy35+V8Z
        lR1BD3bz3jvilKW/UbvSWSE34/NuYeNtLxfuOazpsf/xsXDDutbzNs8PdyzZtDv3n/yZ73Pv
        K7Z97dz/qmy9xzHOCru7+9Lv9F576u18v3+R9KyZOzle+ezdLKC5tcxstmO8k/RM4y1hnOmp
        jY9K8su0WCaZaj9VqImcrpvpMm2p2Mx95ZbKUbcvvTQx3BHLGb5SXr2a437Z5mY1pzgxzmmb
        M1578K98pTZv274ZwmfeyF7Qn8a4p102U0dMdsap3LzZWbxKLMUZiYZazEXFiQDOPJFDEgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvO6Jj3eTDFatlLSYs34Nm8X5B7/Y
        LLb8fsNosXqTr0X35pmMFr3vXzFZXN41h83i3pr/rBY7lu5jsnj9bRmzxbKv79ktZjf2MVo8
        Xs/twOtx+M17Zo+ds+6ye2xa1cnmsenTJHaPEzN+s3i833eVzaNvyypGjzMLjrB7bP1l5/F5
        k1wAVxSXTUpqTmZZapG+XQJXxvn7j5kLGvkq9m7fxNjAuJu7i5GDQ0LARKL3UUIXIyeHkMAO
        RolvN0tAbAkBGYk355+yQJQISxw+XNzFyAVU8o1R4t63aawgNWwC2hLvF0xiBUmICCxklNj5
        /gUziMMssJJR4u3LeYwgVcIC3hIP+yaBTWIRUJV4slcExOQVsJW4t0gbYpe8xOoNB5gnMPIs
        YGRYxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHKhaWjsY96z6oHeIkYmD8RCjBAez
        kghvV9rtJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqY
        orkPqz+o2cbw4ZzcnJxrX2yPxb8x8FvxSedekc6rdbPeLfVkf2/788ltu/bib59rtu+V2cz7
        tdLbKtNEuzM4cE/3pIBHpwwTrsUnM058HXXRd/LbqGV+bT/4wivCS5g+JZVH3HjGreD0X2+a
        3LpVWmpJK2qfbfyyePqT9L3V63f6fWl5OCFoY/TRNqtMK6N5J6dNEV8we+2Wnq3M7y92JYQq
        Ttrqd8YxfN0TP632VQx793t/Tc36d7Jt/rJPhU6mGpXbhc5bff5YvChtlf42r4nHly0Ps2S9
        XLIofZ/XrfJvjzOO/9revuaR0YMl+zRvX5kx7da1LdddntsnaB9Z+CpKXyf/zik3jUm/Cper
        nQ9SYinOSDTUYi4qTgQAjzzRSMMCAAA=
X-CMS-MailID: 20220725012840epcas1p4ae36f072b813f97fc27d33b46da5bc67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725012840epcas1p4ae36f072b813f97fc27d33b46da5bc67
References: <CGME20220725012840epcas1p4ae36f072b813f97fc27d33b46da5bc67@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

To handle the negative value, get the value as long type like
__zone_watermark_ok does.

Reported-by: GyeongHwan Hong <gh21.hong@samsung.com>
Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3df0485..cf667fae132e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3968,11 +3968,12 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 	 * need to be calculated.
 	 */
 	if (!order) {
+		long min = mark;
 		long fast_free;
 
 		fast_free = free_pages;
 		fast_free -= __zone_watermark_unusable_free(z, 0, alloc_flags);
-		if (fast_free > mark + z->lowmem_reserve[highest_zoneidx])
+		if (fast_free > min + z->lowmem_reserve[highest_zoneidx])
 			return true;
 	}
 
-- 
2.17.1

