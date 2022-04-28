Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E33513BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351346AbiD1THp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 15:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242171AbiD1THn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:07:43 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EE2BAB8D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 12:04:26 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220428190421euoutp01c1c2df23434df1b5a3ab4a4422641f7d~qJMmenPdI0497304973euoutp01K
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:04:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220428190421euoutp01c1c2df23434df1b5a3ab4a4422641f7d~qJMmenPdI0497304973euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651172661;
        bh=Ka1t7no9jjgUcfH8S2WwXx8TxVIF3T9cqY0GZcM1HQs=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=QNiptTeMbhbENQ7lqTSzyfCjI6ePPmJJUXrEVqNpOIq54KQXAb+EGst0UqkqqH8o9
         dzvq0PQZvOqIiO/1nSydB4HJW4PZCKsDmJpnfVBQUqD/X7nKYW779JXUuoyiXFt0Yc
         h0N0Vdpzgq//VPvy3jx0daVCdFpSvY5nOVALX+v0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220428190420eucas1p2697d4e084b5620b5a545de03882e0b69~qJMlOzo5d0353803538eucas1p2l;
        Thu, 28 Apr 2022 19:04:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8C.8C.10009.435EA626; Thu, 28
        Apr 2022 20:04:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220428190419eucas1p27c883bc99b03909b2590aa28b08f8efe~qJMk0fbyr0370603706eucas1p2S;
        Thu, 28 Apr 2022 19:04:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220428190419eusmtrp293b0a0cd417e1aa523f302732b47f2f6~qJMky7PiZ0718707187eusmtrp2w;
        Thu, 28 Apr 2022 19:04:19 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-41-626ae5346cac
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FF.0F.09404.335EA626; Thu, 28
        Apr 2022 20:04:19 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220428190419eusmtip14d451737adfaf87d199d4216331b65c2~qJMkmfsEc2896528965eusmtip1b;
        Thu, 28 Apr 2022 19:04:19 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.162) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 28 Apr 2022 20:04:17 +0100
Message-ID: <c1fe810a-d796-f76b-5df1-8222b36e906e@samsung.com>
Date:   Thu, 28 Apr 2022 21:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH 04/16] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jaegeuk@kernel.org>, <axboe@kernel.dk>, <snitzer@kernel.org>,
        <hch@lst.de>, <mcgrof@kernel.org>, <naohiro.aota@wdc.com>,
        <sagi@grimberg.me>, <dsterba@suse.com>,
        <johannes.thumshirn@wdc.com>
CC:     <linux-kernel@vger.kernel.org>, <clm@fb.com>,
        <gost.dev@samsung.com>, <chao@kernel.org>, <josef@toxicpanda.com>,
        <jonathan.derrick@linux.dev>, <agk@redhat.com>,
        <kbusch@kernel.org>, <kch@nvidia.com>,
        <linux-nvme@lists.infradead.org>, <bvanassche@acm.org>,
        <jiangbo.365@bytedance.com>, <matias.bjorling@wdc.com>,
        <linux-block@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <eeb86052-399c-a79b-32ab-1ed1b2d05e07@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.162]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0xTVxjNfe/19VFTffxoeiOLM0WSjTm0CTHXzcFMiHlEExlRY8bcLPQF
        urVAWhnDDQaRH1KclEoZdiWumwOGRWhhOCBsWDNASq2mYABFZVDnIC1sQCzBdaM8XPjvnO98
        5/u+c3MpPOw7cjulyDrDqrNkSgkpIDr7V1xvxnk+TtvbOxSOWof6cXRtsopEtQsrOHIYnBjS
        V9Xx0arThaO7/mIM/XjtNwzNtBpxdKFvgUD/aB+t1UqmcPRiSor09vsAeUaNGOqdeAO5u00k
        utLg4SNd2TKOxnQegKoH2nno+tw8gQYnIt8VM+6Rw0xg0EIy1ed8fMb1yEowbmcuY2uuIBlz
        kQFn2q9+yfSMF5HMV+d8JNNV+pjHzP8ySjKtHaMEo2u38phF2w6mvK8SS6bfFxyQs0rFp6x6
        T/xpQabbaiFyikM/e/h9OVkEeoRaEEJBOg5W1E0SWiCgwugmAC01hg2yBKDWvrBBFteItox4
        aZnq7uZzQiOAQ0s2/v9dI382kBzpAfBp1S1cCyhKSMfD+03RQTdBR8N2i4UXxEI6FN6+PLM+
        VUSfhLXGYTKIw+kPYEuleb2O02I4MXMFC86MoFcBdN/x8YIEp6cx+OJWLz+4gKRjYHEFP2gI
        oQ/B8Ro3jzO/DktvrPI5/Cq84TXhXIQouHKpks/hAtjSP7yeANI3BdDV18HjhEQ4/dxHcjgc
        zg50bBhegf92BS8K4s+hZ2wV58wlAFZ1tZLBgyD9Nrw4rOR6DsJAY8lGeSsc84Zy92yF+s6v
        cR2INm56C+OmzMZNEYybInwLiGYgZnM1qgxWI81i82I1MpUmNysjNj1bZQNr39gRGPj7Z1A/
        +1esHWAUsANI4ZII4VJPZlqYUC7LP8uqsz9S5ypZjR1EUoRELExXtMnC6AzZGfYTls1h1S9V
        jArZXoTV7XvwBYxOKOycLy00HNtdsKXpcmKg/KfrosT6o3H3bA4gVptOESvSb0hFA88vjpC/
        I7rQfPOe+NnE88LMBMP51ANHrPpjY66DJ8SHxAkitBvtnDtSYO460fsHtl/x+8KTxMFTl7yL
        9ftU0NQGnG/5ycezrmFt0sUn/iFlrXUyzyE7fXevaJc2JmCuTBVIR1Ly929ZoJL1yRqeoK2s
        RTq5J91kNuxaPvmDZvFoxNkq+XnTHPWaazpNmdNwm2hKcaRsOxzVeOf4rwHxeH7Kg5pOSdyz
        q9Uf1tb4ct6TeeVJKuhN2pEXH7W87WlsqVL90J0e6fTn644Ls+la285UCaHJlEljcLVG9h/5
        2UuXNQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsVy+t/xu7rGT7OSDC5ONLZYf+oYs8Xqu/1s
        FtM+/GS2OD31LJPFpP4Z7Ba/z55ntrjwo5HJYuXqo0wWT9bPYrboOfCBxeJv1z2gWMtDZos/
        Dw0tJh26xmjx9OosJou9t7QtLu+aw2Yxf9lTdosJbV+ZLW5MeMpoMfH4ZlaLda/fs1icuCXt
        IO5x+Yq3x78Ta9g8Jja/Y/c4f28ji8fls6Uem1Z1snksbJjK7LF5Sb3H7psNbB69ze/YPHa2
        3mf1eL/vKpvH+i1XWTwmbN7I6vF5k5xH+4FupgCBKD2bovzSklSFjPziElulaEMLIz1DSws9
        IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MyxvXsBQ0ClbcWdzO1sC4m7eLkZNDQsBE4uGu
        XexdjFwcQgJLGSUeL5rLDpGQkfh05SOULSzx51oXG0TRR0aJw+93QnXsZpR4ffMjYxcjBwev
        gJ3EtRWqIA0sAqoSm9esYQWxeQUEJU7OfMICYosKREg82H0WLC4sECOxtnshWJxZQFzi1pP5
        TCAzRQR+M0pcPveOFcRhFnjMJPHn8F6obUCZ2cfOMINsYxPQkmjsBDuPU8BN4uaUy6wQkzQl
        Wrf/Zoew5SW2v53DDPGCssTPyd1Q79RKvLq/m3ECo+gsJAfOQnLILCSjZiEZtYCRZRWjSGpp
        cW56brGRXnFibnFpXrpecn7uJkZgCtt27OeWHYwrX33UO8TIxMF4iFGCg1lJhPfL7owkId6U
        xMqq1KL8+KLSnNTiQ4ymwFCayCwlmpwPTKJ5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6Ykl
        qdmpqQWpRTB9TBycUg1Mza8kbMS2/eIJmj6d+X/W7dJ87czPCQ8urvItd7u5taDJ07rQLMb+
        Rp32tfVf5j5anuyj9fnqlU8fUtd5MVmc38TgfvxxrXGaPne38UrNG7X9X9WfLrJjqapL2Vf/
        /sr8fWpLb7+M2rh/oaC7eKfNjI2ZRYf1gt9N8jBbH72t5U3smrLF+k2ad0yMDnc+cNmXX8Ov
        2/7cOLzpZJiLxf9dE3ouXt24PUip79yrHwseFwQafbgwKezNpO83XV45PXPX9vr4eCf3W8bs
        T+2PHB/Wmi7r3BC9gsHuoVl49AH1S3x8S3a5JfhfDrp8NiNnicY/J9WYHSv/lnybd1KPYff9
        XXvWvS4TVpWQ+Vjfs6x+jRJLcUaioRZzUXEiAGA0BFrqAwAA
X-CMS-MailID: 20220428190419eucas1p27c883bc99b03909b2590aa28b08f8efe
X-Msg-Generator: CA
X-RootMTR: 20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a@eucas1p1.samsung.com>
        <20220427160255.300418-5-p.raghav@samsung.com>
        <eeb86052-399c-a79b-32ab-1ed1b2d05e07@opensource.wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-28 01:37, Damien Le Moal wrote:
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 937bb6b86331..850caf311064 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -634,8 +634,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>>  		return BLK_STS_NOTSUPP;
>>  
>>  	/* The bio sector must point to the start of a sequential zone */
>> -	if (pos & (blk_queue_zone_sectors(q) - 1) ||
>> -	    !blk_queue_zone_is_seq(q, pos))
>> +	if (!blk_queue_zone_aligned(q, pos) || !blk_queue_zone_is_seq(q, pos))
> 
> blk_queue_zone_aligned() is a little confusing since "aligned" is also
> used for write-pointer aligned. I would rename this helper
> 
> blk_queue_is_zone_start()
> 
> or something like that.
> 
That is a good idea and definitely a better name that
blk_queue_zone_aligned. I will fix it.

>>  	/*
>> @@ -489,14 +489,14 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>>  	 * smaller last zone.
>>  	 */
>>  	if (zone->start == 0) {
>> -		if (zone->len == 0 || !is_power_of_2(zone->len)) {
>> -			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
>> -				disk->disk_name, zone->len);
>> +		if (zone->len == 0) {
>> +			pr_warn("%s: Invalid zoned device size",
>> +				disk->disk_name);
> 
> The message is weird now. Please change it to "Invalid zone size".
> 
Ok.
> Also, the entire premise of this patch series is that it is hard for
> people to support the unusable sectors between zone capacity and zone end
> for drives with a zone capacity smaller than the zone size.
> 
> Yet, here you do not check that zone capacity == zone size for drives that
> do not have a zone size equal to a power of 2 number of sectors. This
> means that we can still have drives with ZC < ZS AND ZS not equal to a
> power of 2. So from the point of view of your arguments, no gains at all.
> Any thoughts on this ?
> 
That is a good point. Instead of implicitly assuming npo2 drives to have
ZC == ZS, it is better to be explicit during bringup. Thanks. As Luis
mentioned, I will add this condition in the next revision.
