Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4641B51AD60
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356537AbiEDS7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377496AbiEDS71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:59:27 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD9F205C5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:55:50 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220504185548euoutp02803129409bd7312afd58a09ef14bfea7~r_81_Pgl-0224602246euoutp02f
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:55:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220504185548euoutp02803129409bd7312afd58a09ef14bfea7~r_81_Pgl-0224602246euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651690548;
        bh=pV5YDy3++3X3MIupEP5BQJa/D3ldEEIqyW1PGs7g3LA=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=C3mf37JL/98r6HpZXFXFDzi6CbVZsUgFhhKhfG+aC3QAHzRFeg7jzb3DJrWoEP//i
         0eJ6BRa+4cHGNBRT7v+V7WSmxqcMjq0Ma5UdpOar7E+7fY+D+lg7qEtEn2FgbIhjfe
         5Ru6i3ozTKmV1tf/FR9AfRbN2m6x08gINc2ePWe4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220504185547eucas1p240580c93fa3c9f495030f24c99f7b036~r_81jWyOU1535315353eucas1p2J;
        Wed,  4 May 2022 18:55:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0C.F6.10260.33CC2726; Wed,  4
        May 2022 19:55:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220504185546eucas1p12c80ccf80fe52669eb1885bb3623e43c~r_80e8r-31641116411eucas1p1_;
        Wed,  4 May 2022 18:55:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220504185546eusmtrp1cdb0bb539189f8416727ea413859b749~r_80dRlTq0429604296eusmtrp1L;
        Wed,  4 May 2022 18:55:46 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-54-6272cc339050
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A5.5A.09404.23CC2726; Wed,  4
        May 2022 19:55:46 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220504185546eusmtip2dbec558b1150776064b3f6539435b137~r_80SYl9S2194821948eusmtip2d;
        Wed,  4 May 2022 18:55:46 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.170) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 4 May 2022 19:55:43 +0100
Message-ID: <3f4717f9-ab7f-0caa-3809-0ab14629e5c8@samsung.com>
Date:   Wed, 4 May 2022 20:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH 05/16] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
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
In-Reply-To: <6a1c06e8-bedd-47b0-2a3f-9c51468fc029@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.170]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxjNe+/t7aWz7FLZeEUDs7AfuAgy5nz3EcacP+4yNIsyZSNOS7kD
        RimspeI0ZmWIEeL4KJFpOwJ0Ih+iWGAIpTBSQgFbVqR0Q5w4hLrJN0O3GTpcy50J/845zzlP
        nvPmpXBRNRlIpcqzWIVcIhOTAqLV8sS+PcqmSNzxcDASNd604OjK3SISlS0+wZH1/CCGNEUX
        +Ghl0I6joX9yMGTSazBUd6UXQ1ONWhyd614k0L8F4x7t9ASO3BORSGP+GSCXU4uhzrFXkMP4
        HYkqLrv4qPjMYxyNFrsAKulr5qFrMwsE6h/bHAMZx8gHzGp/A8mU5M7zGfu4gWAcgyqmqT6f
        ZKrU53Gm+dJXTMdtNcl8kztPMu1593jMQpeTZBpbnATTbD3JFDcbeMxyU9CHfp8I3k5iZanH
        WEVE9FFByv2ZOZDZBY/3Wc4QamD0LwA+FKRfg6af7HgBEFAiuhbAihvtPI48AtC5VM/zukT0
        MoC3f419lvit3I1xeg2ArsldXMDj6dFXYhwxAjhtncW9LiEdDXvGl9YSBB0K7yzl8zjdDw5c
        nCK8+AU6HpZpbaQXb6QToHFsYE3H6QA4NlWxttSfLsdg/kUn30twehKD7p5OD6Eokt4Gc/L5
        3oAP/RZcvTOPc+EwmHdjhc/hYJj7gw7nKoTA0tERjMOn4FWLbW0npHsFsCT37P+DPXD4YTXg
        8EY43dfC5/AWaC09R3D4JHSNruBc+DSARe2NpPcg6Lmi0CbjPO/C3vI5gpN94eicH3ePL9S0
        fosXg5e1695Cu66zdl0F7boKlYCoBwGsSpmezCqj5Gx2uFKSrlTJk8OlGelNwPOTrat9j9tA
        7fRSuBlgFDADSOFif+F71ZmJImGS5MsTrCLjiEIlY5VmsJkixAFCaep1iYhOlmSxaSybySqe
        TTHKJ1CNfboqnRyqK3seD2+7HitSd29tzco7tKAL0++emx1tkB6IvlCX0HL4VlRImio+rC1U
        kh2iY2YUoeYjB4Mqnzp8/rq2e7+jISXwLHFiZb/po51V99UFBUE1h56LyXh9j76wOKfk/ZtV
        X+fEfxZsP2iJ7P1xl0m/T9W9PJj41NQfF7Hh496mBanu+N593bPyTt6bxt9LH6Qd3jAsH6jY
        MR6hfLCTXd2bkx1za8RiMJjiYhMeYTVb7+qb1Prlso57yS0TiSG/DP2Rl/9O6NX2jmOFfwaT
        /C1dp46m1L5xQPxF0ou+Quurs1FViUUBle44SqcxfP5919/2kU3bZYvuIJtZM7XpJcOwmFCm
        SCK34Qql5D/LGIyuOAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsVy+t/xe7pGZ4qSDD4u1bBYf+oYs8Xqu/1s
        FtM+/GS2OD31LJPFpP4Z7Ba/z55ntrjwo5HJYs+iSUwWK1cfZbJ4sn4Ws0XPgQ8sFn+77gHF
        Wh4yW/x5aGgx6dA1RounV2cxWey9pW1xedccNov5y56yW0xo+8pscWPCU0aLicc3s1qse/2e
        xeLELWkHCY/LV7w9/p1Yw+Yxsfkdu8f5extZPC6fLfXYtKqTzWNhw1Rmj81L6j1232xg8+ht
        fsfmsbP1PqvH+31X2TzWb7nK4rH5dLXHhM0bWT0+b5ILEIzSsynKLy1JVcjILy6xVYo2tDDS
        M7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy3j0+i1jwT6JiuPH2lgaGHeJdDFyckgI
        mEg8mPuHqYuRi0NIYCmjxNeDy9kgEjISn658ZIewhSX+XOtigyj6yCixf3UjM4Szi1HiVMsn
        sA5eATuJw/c+MoHYLAIqErc/drJCxAUlTs58wgJiiwpESDzYfRYsLiwQLbHr1kmwOLOAuMSt
        J/PBzhARmMsk0TnzKjvEhg+MEjs2d4I5zAKPmST+HN4L5HBwsAloSTR2gt3HKWAt8e/2O2aI
        SZoSrdt/s0PY8hLNW2czQ/ygLDH5xhUmCLtW4tX93YwTGEVnITlwFpJDZiEZNQvJqAWMLKsY
        RVJLi3PTc4uN9IoTc4tL89L1kvNzNzECk9m2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrzOSwuS
        hHhTEiurUovy44tKc1KLDzGaAkNpIrOUaHI+MJ3mlcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJ
        pCeWpGanphakFsH0MXFwSjUwtdvGnbuffm+OVkZfxS31+m0fP2eHnVXZqXfKvD1+m3mGu3Kh
        bcFbBsNW8U/86hp9F/rSi20Pm/nuPf68Ztvm5wZbDZb8UbBPZ5Xi2lASbVB9MEshxe2bBl+3
        0uNq10gdg8nsZ+Y56R2zyfI78j/k0JL7G2cqPt3wo/jucQ1dxwTDDf32VXtW3eqP/nFq/YPl
        It1s7zeIVUbs+T5v2Zscozm7PfTqy4smvtR0cessNyys99/FJpkSGaX+eyd7eNrsX5smW+Rs
        W/3A0kmyMXKrzrLOhQkrbYX4jt0RFq2YzWmi1jtni2WDts6uL7JK/gcmTTh4SK7Z6X73BFvG
        gnOZWgkx7muczX9wzzt05poSS3FGoqEWc1FxIgA0vWi47wMAAA==
X-CMS-MailID: 20220504185546eucas1p12c80ccf80fe52669eb1885bb3623e43c
X-Msg-Generator: CA
X-RootMTR: 20220427160301eucas1p147d0dced70946e20dd2dd046b94b8224
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160301eucas1p147d0dced70946e20dd2dd046b94b8224
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160301eucas1p147d0dced70946e20dd2dd046b94b8224@eucas1p1.samsung.com>
        <20220427160255.300418-6-p.raghav@samsung.com>
        <6a1c06e8-bedd-47b0-2a3f-9c51468fc029@suse.de>
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-04 19:03, Hannes Reinecke wrote:
> On 4/27/22 09:02, Pankaj Raghav wrote:
>> Remove the condition which disallows non-power_of_2 zone size ZNS drive
>> to be updated and use generic method to calculate number of zones
>> instead of relying on log and shift based calculation on zone size.
>>
>> The power_of_2 calculation has been replaced directly with generic
>> calculation without special handling. Both modified functions are not
>> used in hot paths, they are only used during initialization &
>> revalidation of the ZNS device.
>>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
     }
>>         ns->zsze = nvme_lba_to_sect(ns,
>> le64_to_cpu(id->lbafe[lbaf].zsze));
>> -    if (!is_power_of_2(ns->zsze)) {
>> -        dev_warn(ns->ctrl->device,
>> -            "invalid zone size:%llu for namespace:%u\n",
>> -            ns->zsze, ns->head->ns_id);
>> -        status = -ENODEV;
>> -        goto free_data;
>> -    }
>>         blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
>>       blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>> @@ -129,7 +122,7 @@ static void *nvme_zns_alloc_report_buffer(struct
>> nvme_ns *ns,
>>                      sizeof(struct nvme_zone_descriptor);
>>         nr_zones = min_t(unsigned int, nr_zones,
>> -             get_capacity(ns->disk) >> ilog2(ns->zsze));
>> +             div64_u64(get_capacity(ns->disk), ns->zsze));
>>   
> Same here; please add a helper calculating the number of zones for a
> given disk.
> 
I am already  using the div64_u64 helper and this is not done again
anywhere in the nvme zns driver. I am not sure if having a separate
helper for this will add value. And this is not in the hot path, so no
need for special handling.
>>       bufsize = sizeof(struct nvme_zone_report) +
>>           nr_zones * sizeof(struct nvme_zone_descriptor);
>> @@ -197,7 +190,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns,
>> sector_t sector,
>>       c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>>       c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>>   -    sector &= ~(ns->zsze - 1);
>> +    sector = rounddown(sector, ns->zsze);
>>       while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>>           memset(report, 0, buflen);
>>   
> Please be a bit more consistent. In the previous patches you always had
> a condition to check if it's a power_of_2 zone size, but here you are
> using the same calculation for each disk.
> So please use the check in all locations, or add a comment why the
> generic calculation is okay to use here.
> 
That is a good point. I have mentioned that in my commit log that I am
not having any special handling because these calculations are not in
the hot path.

Maybe adding comments is better for clarity. I will also do it for your
previous comment.

I will queue this up for my next revision. Thanks.
> Cheers,
> 
> Hannes
