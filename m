Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FEB513870
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349232AbiD1PhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiD1PhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:37:02 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36807562FD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:33:45 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220428153339euoutp02cf8df618ca23c99177f0751a5aeba6f7~qGUonqq2N0486404864euoutp02m
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:33:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220428153339euoutp02cf8df618ca23c99177f0751a5aeba6f7~qGUonqq2N0486404864euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651160019;
        bh=5yXFTU7LsTFM7Sb2gkPTwgJWczKZIZBSTUP6BKmlOao=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Gnmg08i6jhkmXbqYBY6Ik3CFDuse37T4vKrlzM2LXdeON53/4L3zJKlwfvdek6DgA
         6jjwb/+azyrkDeP4EQ8KeUZyMhkrq3d7RGt0MZvZ9JRSeHcMZUvt8Qdgzyoql7p7io
         FWyS0LmZpItQ9rYg8J2mKNji8mw+WjxCF8hAgylc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220428153339eucas1p1ea73126c12dcc41ed505a2fdbcbb74df~qGUoQRyOM1670916709eucas1p1s;
        Thu, 28 Apr 2022 15:33:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 99.E1.10260.3D3BA626; Thu, 28
        Apr 2022 16:33:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220428153338eucas1p216944156cb20b727d51d45203db12055~qGUn5xFQE1775417754eucas1p2x;
        Thu, 28 Apr 2022 15:33:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220428153338eusmtrp1cce3757bc47b6fafc3e91e1454560f43~qGUn4fKXD0768807688eusmtrp1p;
        Thu, 28 Apr 2022 15:33:38 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-df-626ab3d3d299
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 14.DD.09522.2D3BA626; Thu, 28
        Apr 2022 16:33:38 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220428153338eusmtip13698ce6f754d75252a8a636d48b9fe08~qGUntgkXs1642816428eusmtip1F;
        Thu, 28 Apr 2022 15:33:38 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.162) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 28 Apr 2022 16:33:35 +0100
Message-ID: <588c073f-0efe-fa38-388f-143ed54afd20@samsung.com>
Date:   Thu, 28 Apr 2022 17:33:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH 02/16] block: add blk_queue_zone_aligned and
 bdev_zone_aligned helper
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <jaegeuk@kernel.org>,
        <axboe@kernel.dk>, <snitzer@kernel.org>, <hch@lst.de>,
        <mcgrof@kernel.org>, <naohiro.aota@wdc.com>, <sagi@grimberg.me>,
        <damien.lemoal@opensource.wdc.com>, <dsterba@suse.com>,
        <johannes.thumshirn@wdc.com>
CC:     <linux-kernel@vger.kernel.org>, <clm@fb.com>,
        <gost.dev@samsung.com>, <chao@kernel.org>, <josef@toxicpanda.com>,
        <jonathan.derrick@linux.dev>, <agk@redhat.com>,
        <kbusch@kernel.org>, <kch@nvidia.com>,
        <linux-nvme@lists.infradead.org>, <jiangbo.365@bytedance.com>,
        <matias.bjorling@wdc.com>, <linux-block@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <df8104aa-ca86-4053-5334-3bc4ff786c61@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.162]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxjOuef29oLUXQqOEzVTalgGbChTl7NJOpZMcnXuO0uMmM2qVz6k
        6FpwzkWpFjEUKgVEu0rUMh3lQ7pCh1DCR8oKbNC5revWMRQJ1B+wCfLhijAc7WWGf8/zvu9z
        3ud5c2gorqBW02mZWZwiU5YhoYLJxq7ZH19yNaTv3+TrDMHmH7ogrrlTROGLE7MQ95Y5CVxS
        pBfiOedtiH/ynSZwVY2DwCNmA8SFHRMk/ldzd7GWOwTx/FA8LrH/BrDXbSBwa38sdtnKKXz1
        a68Q6/JmIPbovAAXdzcIcN3YOIl7+tckRrCuX99iF3pqKbZY/UDI3r5rIVmXM5utr86nWKOq
        DLIN13PYlj9UFKtVP6DY5rODAna8zU2xZqubZHUNFgE7Vf8ce66jgHiP2ROccJDLSDvGKTZK
        9wWnuucnBUdNguN3XINQBfSkBgTRiNmCHl3xERoQTIsZE0ADassSmQZId+UvAU+mACpvdj6V
        OLQmId+oBOhRawl4OuVwGimetACksfy8OEbTIkaKPNp4v5pkolBVsZXyYxETir7/ciTw6ipm
        N7po6AvUw5hkpC88I/BjyESg/pGrAU/hzAUCteqGoZ9AppdAC4WNgQUUE4NO5wv9giBmG7Jd
        qIa8OBqdvTUn5PE6pP72MuQjbECzpQVCHp9EN7v6AnEQ4whGzomvBHzjTWT33qd4HIZGu61L
        grWot7Rw6RZfIK9nDvLiXICKms2U3xBadHG+L4OfeQM5x7oEfHkl8vwdyvtZiUoaL0EdiDIs
        u4VhWWbDsgiGZRGuAbIaRHDZSnkKp9ycyX0Wp5TJldmZKXEHjsjrweI37l3onmkCptGHcXZA
        0MAOEA0l4aLpltT9YtFB2ecnOMWRTxTZGZzSDtbQpCRCdCDtG5mYSZFlcYc57iin+L9L0EGr
        VcT2KUvY4+s71iXazUz5TmN6+63Gveqm12yWt9em/7N+hzRn36nOm6Rr9xPBn8pn6MO18wOO
        npyF0e8uPd/e2oRh5OVtq+xzDNja0Vb5ocj58dCYPqmyo9K7fS5/g+MYlOvfmXzYLlXtevb9
        mfz7m7QV735U6haDE+P3gsyvn2vxWH26GIq0tSW/Yov+PSYhVzK2sUyzR19+pm7vyaQbAyMv
        JOVlU8w9pn591KfJch8XWmO8xgifJOYcspa7pRHRwooV2PmitmCwqmec3bolMi5y8Be0K6Q6
        40av6VRsSNt0c/h5ETRaV3wgGzqe8Opw/KGsvMzHiXWxL4tr5zuFk8ObJaQyVRYfAxVK2X9a
        1CvdNQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsVy+t/xu7qXNmclGRx/aGCx/tQxZovVd/vZ
        LKZ9+MlscXrqWSaLSf0z2C1+nz3PbHHhRyOTxcrVR5ksnqyfxWzRc+ADi8XfrntAsZaHzBZ/
        HhpaTDp0jdHi6dVZTBZ7b2lbXN41h81i/rKn7BYT2r4yW9yY8JTRYuLxzawW616/Z7E4cUva
        Qdzj8hVvj38n1rB5TGx+x+5x/t5GFo/LZ0s9Nq3qZPNY2DCV2WPzknqP3Tcb2Dx6m9+xeexs
        vc/q8X7fVTaP9VuusnhM2LyR1ePzJjmP9gPdTAECUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6
        RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZV/98Yi1YwVpx9/J95gbGGSxdjJwcEgImEkd7
        V7B3MXJxCAksZZRY83QBM0RCRuLTlY/sELawxJ9rXWwQRR8ZJe69/wDVsZtR4nHnVKYuRg4O
        XgE7iRu9hiANLAKqEisnbmEDsXkFBCVOznwCtk1UIELiwe6zrCC2sEC0xIyeJjCbWUBc4taT
        +UwgM0UEpjBJ7J3wmBnEYRY4zSTxr2cb2BlCAh8YJTr7skGWsQloSTR2goU5Bawldk1ZxQwx
        SFOidftvdghbXqJ562yob5Qlfk7uhvqmVuLV/d2MExhFZyG5bxaSO2YhGTULyagFjCyrGEVS
        S4tz03OLDfWKE3OLS/PS9ZLzczcxAhPYtmM/N+9gnPfqo94hRiYOxkOMEhzMSiK8X3ZnJAnx
        piRWVqUW5ccXleakFh9iNAUG0kRmKdHkfGAKzSuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhP
        LEnNTk0tSC2C6WPi4JRqYJLhVt0vVlHx0m6F3eEZHZyX2LdN2nz7mGw2/6KeRAnBmG0ynsLX
        RcVW8S/arP9vr/e6p2zXd1SZvGtxbTPZoq5tyPP9VKLAsqveipfiOKf48xw9lvmZVfKo+iyn
        eTOZni7mqJ8+4ckk9u8NCef3NvwPV1LxKBOd+2hKX23op4vtN1LWrdnlHmlzofX5t0QLq/Qp
        jnbNJQvYbLNzCtz/Xu6ctt1v6m+n94Lf1FX1eX9PMLo0ry1I+IOAg6ZtfFvFzA8HXuXwabxd
        uXTfXP+KgP61Kc4Zq5bFt1zmFrMIvVP4Wcixf6bE57vu903L67e6nDq/vXNS5OTU47sOHNnN
        t1Ts4vewwAD2PWdCjmwylFdiKc5INNRiLipOBABdt7yK6QMAAA==
X-CMS-MailID: 20220428153338eucas1p216944156cb20b727d51d45203db12055
X-Msg-Generator: CA
X-RootMTR: 20220427160258eucas1p19548a7094f67b4c9f340add776f60082
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160258eucas1p19548a7094f67b4c9f340add776f60082
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160258eucas1p19548a7094f67b4c9f340add776f60082@eucas1p1.samsung.com>
        <20220427160255.300418-3-p.raghav@samsung.com>
        <df8104aa-ca86-4053-5334-3bc4ff786c61@acm.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-28 01:52, Bart Van Assche wrote:
> On 4/27/22 09:02, Pankaj Raghav wrote:
>> +static inline bool bdev_zone_aligned(struct block_device *bdev,
>> sector_t sec)
>> +{
>> +    struct request_queue *q = bdev_get_queue(bdev);
>> +
>> +    if (q)
>> +        return blk_queue_zone_aligned(q, sec);
>> +    return false;
>> +}
> 
> Which patch uses this function? I can't find any patch in this series
> that introduces a call to this function.
> 
Initially I used it but at the end I had to remove that patch but I
forgot to remove this function. Thanks for pointing it out. I will fix
it up in the next rev.
> Thanks,
> 
> Bart.
> 
> 
