Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD7357FCAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiGYJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGYJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:48:05 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD0A15FE5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:48:04 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220725094801epoutp0322a7cb8db8e3f2e4f897b3770545a5f1~FCX_Sx0eI2005120051epoutp032
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:48:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220725094801epoutp0322a7cb8db8e3f2e4f897b3770545a5f1~FCX_Sx0eI2005120051epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658742481;
        bh=wN47N0l07O7MAWdO3cN497k56Uj7xG0e3YGYi/xkoUw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=NpDgQHcz6r37/PQHs7XIIyIbRbrPGnfymEuFezujn/tJk6kDq7ehSei9JNRKp2tlK
         RfrxpP23jGydPrM92ac229iJGL0MR8aT4Bf/w18YuDiPIEoAvqnmkJpfJvfOIO+nhG
         92vhuMtGSc5KTI9WFgMGgL5HqcpaGiJMahxs+I1o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220725094800epcas1p4eb7604aaf9f2eec55a96e33964f7f265~FCX9ne55n0774707747epcas1p4t;
        Mon, 25 Jul 2022 09:48:00 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.224]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LrwFr1McNz4x9Pq; Mon, 25 Jul
        2022 09:48:00 +0000 (GMT)
X-AuditID: b6c32a38-5adff700000027db-ba-62de66d009e3
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.79.10203.0D66ED26; Mon, 25 Jul 2022 18:48:00 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] page_alloc: fix invalid watemark check on a negative
 value
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Jaewon Kim <jaewon31.kim@samsung.com>
CC:     "minchan@kernel.org" <minchan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GyeongHwan Hong <gh21.hong@samsung.com>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220725084204.52kdi6jyjhytzudm@techsingularity.net>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220725094759epcms1p6b3940f68126bd9b3d9a4e4c1ad4b0aa2@epcms1p6>
Date:   Mon, 25 Jul 2022 18:47:59 +0900
X-CMS-MailID: 20220725094759epcms1p6b3940f68126bd9b3d9a4e4c1ad4b0aa2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmru6FtHtJBkeXs1nMWb+GzeL8g19s
        Fi8PaVps+f2G0WL1Jl+L7s0zGS16379isri8aw6bxb01/1ktdizdx2Tx+tsyZotlX9+zW8xu
        7GO0eLye24HP4/Cb98weO2fdZffYtKqTzWPTp0nsHidm/GbxeL/vKptH35ZVjB5nFhxh99j6
        y87j8ya5AK6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBd
        t8wcoPOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQVmBXrFibnFpXnpenmpJVaG
        BgZGpkCFCdkZO3pOMBbskKxo3vqevYHxskgXIyeHhICJxPupnaxdjFwcQgI7GCW6b7QydzFy
        cPAKCEr83SEMUiMsECjx98sGFhBbSEBJ4uyPK+wQcV2Jpu7VYHE2AW2J9wsmsYLYIgKhErs2
        v2ABmcks8INZonnWA3aIZbwSM9qfskDY0hLbl29lBLE5BZwkXvy4zgYRF5W4ufotO4z9/th8
        RghbRKL13llmCFtQ4sHP3VBxKYlz3ceZQG6WEIiQeLFHHSKcI/F+5xxWCNtc4tmGFrCRvAK+
        Ep/3HQd7kUVAVWL2LDmITheJt7PLQSqYBeQltr+dA1bBLKApsX6XPsQQRYmdv+cywvzRsPE3
        OzqbWYBP4t3XHlaY+I55T5ggbDWJlmdfoeIyEn//PWOdwKg0CxHMs5AsnoWweAEj8ypGsdSC
        4tz01GLDAhN4zCbn525iBCdjLYsdjHPfftA7xMjEwXiIUYKDWUmEtyvtdpIQb0piZVVqUX58
        UWlOavEhRlOghycyS4km5wPzQV5JvKGJpYGJmZGJhbGlsZmSOG/v1NOJQgLpiSWp2ampBalF
        MH1MHJxSDUyV9w90lEiZ7is5rbDtisGp9PltrutXzaqWmzr3/m61an69qso3Kx12vgg8On16
        6/P0bfp7GL7xPnk/71HusWVF7w8wnVHaquC03P/NZrWXP3aeVDv6QVjo25KNnhNPbdUv/KnB
        7isopHue+1l3hYLUs9hVG33dJK53Z/KofqwyPrg2nLn27fwVZpKdUvzbc7NZV83LmH1VUyzN
        7k/7aZf76cdbVm65enTtGZPzLIeNuD4rS918GiO1IXzJXfcV4du8w3bs7n7qZ+L6mc95i4D9
        nElmu27zdsXI/v/Cf5a5O2+C7QyRh5nml0+Zn+NOKb2td/JVV3z3L4aqGXce5Uc+M5piwLnm
        0/VSB9vCGtVsJZbijERDLeai4kQA0u2vjU8EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725012840epcas1p4ae36f072b813f97fc27d33b46da5bc67
References: <20220725084204.52kdi6jyjhytzudm@techsingularity.net>
        <20220725012843.17115-1-jaewon31.kim@samsung.com>
        <CGME20220725012840epcas1p4ae36f072b813f97fc27d33b46da5bc67@epcms1p6>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Jul 25, 2022 at 10:28:43AM +0900, Jaewon Kim wrote:
>> There was a report that a task is waiting at the
>> throttle_direct_reclaim. The pgscan_direct_throttle in vmstat was
>> increasing.
>> 
>> This is a bug where zone_watermark_fast returns true even when the free
>> is very low. The commit f27ce0e14088 ("page_alloc: consider highatomic
>> reserve in watermark fast") changed the watermark fast to consider
>> highatomic reserve. But it did not handle a negative value case which
>> can be happened when reserved_highatomic pageblock is bigger than the
>> actual free.
>> 
>> If watermark is considered as ok for the negative value, allocating
>> contexts for order-0 will consume all free pages without direct reclaim,
>> and finally free page may become depleted except highatomic free.
>> 
>> Then allocating contexts may fall into throttle_direct_reclaim. This
>> symptom may easily happen in a system where wmark min is low and other
>> reclaimers like kswapd does not make free pages quickly.
>> 
>> To handle the negative value, get the value as long type like
>> __zone_watermark_ok does.
>> 
>> Reported-by: GyeongHwan Hong <gh21.hong@samsung.com>
>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>
>Add
>
>Fixes: f27ce0e14088 ("page_alloc: consider highatomic reserve in watermark fast")

I will add the Fixes.

>
>The fix is fine as-is but it's not immediately obvious why this
>can wrap negative as it depends on an implementation detail of
>__zone_watermark_unusable_free.  The variable copy just to change the sign
>could get accidentally "fixed" later as a micro-optimisation (same if the
>type of mark was changed) so maybe leave a comment like
>
>                /* unusable may over-estimate high-atomic reserves */
>
>Otherwise
>
>Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thank you for your Ack
Yes leaving comment will be helpful. Actually let me take your patch.
I think this but is obvious and fix is sipmle, I can resubmit right away.

>
>The problem could also be made explicit with something like below. I know
>you are copying the logic of __zone_watermark_ok but I don't think min
>can go negative there.

The min in __zone_watermark_ok is positive because mark is always unsigned.
But I think free_pages in __zone_watermark_ok can go negative because of the
same reason.

>
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index 934d1b5a5449..f8f50a2aa43e 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -4048,11 +4048,15 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
> 	 * need to be calculated.
> 	 */
> 	if (!order) {
>-		long fast_free;
>+		long usable_free;
>+		long reserved;
> 
>-		fast_free = free_pages;
>-		fast_free -= __zone_watermark_unusable_free(z, 0, alloc_flags);
>-		if (fast_free > mark + z->lowmem_reserve[highest_zoneidx])
>+		usable_free = free_pages;
>+		reserved = __zone_watermark_unusable_free(z, 0, alloc_flags);
>+
>+		/* reserved may over estimate high-atomic reserves. */
>+		usable_free -= min(usable_free, reserved);
>+		if (usable_free > mark + z->lowmem_reserve[highest_zoneidx])
> 			return true;
> 	}
> 
>-- 
>Mel Gorman
>SUSE Labs

