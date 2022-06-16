Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0291454DEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376331AbiFPKJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiFPKJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:09:50 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3275E5D1A4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:09:47 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220616100945euoutp01f9c521d0c8aa61d3e55c05273b8a1686~5Eg0ormVo2835528355euoutp01B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:09:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220616100945euoutp01f9c521d0c8aa61d3e55c05273b8a1686~5Eg0ormVo2835528355euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655374185;
        bh=SNZKke2AUzG3V8CFrqXh/S1Uz32bt9gnCWWev1s381g=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=qvbb4SK/9smZywa6v/TDbYBXZG9Q/QlL4HhdW4hT7CvAZ4VdHXE2Y/QtBgmYLtbqn
         LB2k7afcx/ZQl9xKj0xMQ+iKI+mNSQc0IQuKvHGJgme6dM6y2xNQii2DibxFaHNtU8
         WohBjVmQmtMCTPVGOXjEMH/ZeFp4GG3/wo9hh8Y8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220616100945eucas1p16ff092593c3eb81dd46a4cf3be3997aa~5Eg0SG-ds0058100581eucas1p1j;
        Thu, 16 Jun 2022 10:09:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B3.8D.09580.9610BA26; Thu, 16
        Jun 2022 11:09:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220616100944eucas1p15c06e5002e0f2cd08babcd1217fd63c6~5Egz281Dc0058100581eucas1p1i;
        Thu, 16 Jun 2022 10:09:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220616100944eusmtrp1c6ff48f087ed07ae172bf766a0ec7b31~5Egz2GWCJ0211102111eusmtrp1i;
        Thu, 16 Jun 2022 10:09:44 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-52-62ab0169c443
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B6.16.09038.8610BA26; Thu, 16
        Jun 2022 11:09:44 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220616100944eusmtip12c538773222f85799ce3294eb6f54db1~5EgzpPmzg1755917559eusmtip16;
        Thu, 16 Jun 2022 10:09:44 +0000 (GMT)
Received: from [192.168.1.12] (106.210.248.244) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 16 Jun 2022 11:09:38 +0100
Message-ID: <e04db101-5628-2a1d-6b5c-997090484d7d@samsung.com>
Date:   Thu, 16 Jun 2022 12:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.9.1
Subject: Re: [dm-devel] [PATCH v7 02/13] block: allow blk-zoned devices to
 have non-power-of-2 zone size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <hch@lst.de>,
        <snitzer@redhat.com>, <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>
CC:     <pankydev8@gmail.com>, <gost.dev@samsung.com>,
        <jiangbo.365@bytedance.com>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <dm-devel@redhat.com>, <jonathan.derrick@linux.dev>,
        <Johannes.Thumshirn@wdc.com>, <dsterba@suse.com>,
        <jaegeuk@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <857c444a-02b9-9cef-0c5b-2ecdb2fd46f6@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.244]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7djP87qZjKuTDBa0CFisvtvPZjHtw09m
        i99nzzNb7H03m9Xiwo9GJouVq48yWTxZP4vZoufABxaLv133gGItD4FKbmlbXN41h81i/rKn
        7BY3JjxltFhz8ymLRdvGr4wOAh6Xr3h7/Duxhs1j56y77B6Xz5Z6bFrVyeaxsGEqs8fmJfUe
        u282AOVa77N6vN93lc1j/ZarLB6fN8l5tB/oZgrgjeKySUnNySxLLdK3S+DK2P/yO2PBPKGK
        J5vusTYwNvN3MXJySAiYSLQ8aWLrYuTiEBJYwSjx+N9uFgjnC6PEgh2HWCGcz4wSjY8eMsO0
        NKx8wAyRWM4o8eP+VXa4qrVv/0P172KUeDPpFytIC6+AncTuvv9ALRwcLAKqErt3FkCEBSVO
        znzCAmKLCkRIrGx9wwJSIiyQJTFnZjxImFlAXOLWk/lMICNFBFoZJY5O3A3mMAvcY5JoO3Od
        EaSBTUBLorGTHaSBU8BaYsmpO8wQzZoSrdt/s0PY8hLNW2eDnSAhoCzxbyfUM7USa4+dAbtf
        QuAbp8TEb21sEAkXiUM916BsYYlXx7ewQ9gyEqcn97BA2NUST2/8ZoZobmGU6N+5ng1igbVE
        35kciBpHiScXOqHCfBI33gpCnMMnMWnbdOYJjKqzkEJiFpKXZyH5YBaSDxYwsqxiFE8tLc5N
        Ty02zkst1ytOzC0uzUvXS87P3cQITJSn/x3/uoNxxauPeocYmTgYDzFKcDArifCaBa9MEuJN
        SaysSi3Kjy8qzUktPsQozcGiJM6bnLkhUUggPbEkNTs1tSC1CCbLxMEp1cBk+m6K/6UVngb8
        Aqxpu2ax7ryitXPexT/LZ2iFXJs+xfDokc1KRh612hqpG52SrQ0233jE2+h2ZXaC9axgixfV
        8xjsbrs7ZHBpeqX+r/omdD3punX+7KD8r07Xvs5nfbat5bVT7i63n5rT3h0tUvjwbq2zvJt0
        ib4rl/SJBCvBAwJi3Zmia8XYwyYJLG2rkDvUdssp3bjd6OG9c4ecLlZfra9rTVCL2xB/abpz
        +uLXT6IztvUnKtROjvoq8ii3ea98tqRMxKPG6kOfFR/v5Oo1zEtLvLVwf8tqPW4tTx8OD8bN
        j6w/GvIo3+mNDZ40uTxL8CFz6d2Qb9sSJucf/9gzZ/I/lrWzz9/Wja0ov6fEUpyRaKjFXFSc
        CABNZ45nAwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xu7oZjKuTDNauMLBYfbefzWLah5/M
        Fr/Pnme22PtuNqvFhR+NTBYrVx9lsniyfhazRc+BDywWf7vuAcVaHgKV3NK2uLxrDpvF/GVP
        2S1uTHjKaLHm5lMWi7aNXxkdBDwuX/H2+HdiDZvHzll32T0uny312LSqk81jYcNUZo/NS+o9
        dt9sAMq13mf1eL/vKpvH+i1XWTw+b5LzaD/QzRTAG6VnU5RfWpKqkJFfXGKrFG1oYaRnaGmh
        Z2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsf/ld8aCeUIVTzbdY21gbObvYuTkkBAwkWhY
        +YC5i5GLQ0hgKaPEvXV3WCASMhKfrnxkh7CFJf5c62KDKPrIKLHjwQWojl2MEvu2bwCr4hWw
        k9jd9x8owcHBIqAqsXtnAURYUOLkzCdgQ0UFIiQ+LZvAClIiLJAlMWdmPEiYWUBc4taT+Uwg
        I0UEWhklbq/8wgriMAvcY5J49ekbK8SyD4wS109cBVvAJqAl0dgJtpdTwFpiyak7zBCTNCVa
        t/9mh7DlJZq3zgYrlxBQlvi3kxnimVqJV/d3M05gFJ2F5LxZSO6YhWTSLCSTFjCyrGIUSS0t
        zk3PLTbSK07MLS7NS9dLzs/dxAhML9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8JoFr0wS4k1J
        rKxKLcqPLyrNSS0+xGgKDKKJzFKiyfnABJdXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliS
        mp2aWpBaBNPHxMEp1cDEcbjl5B8W68Jee/8/r69LMV4LKkrYuXZ29ceFv/5LMfR15ducvXjq
        d/66y4VLeStOla89tF1VlltKfk3htsKHXtXVCxSs+cUuf3x/6+iZix+kT16alGfgumOVCuu8
        r1NWiQZsOpD7qupVs07t1LLTXTdf38u6JK0W2rW57rHonYa9n5QF9y2ovmz/ZtHeEI6TP8y1
        iqyX2jutM5s0qcLRyHBZj3d2fKdkNf/klSqX9nNOPGZzfmJzcP1vu4uLPD8mBv7UfqKXrsgW
        YLWq7enr17Ompp64brDf6Wbss+ezdVi0a2cEek9fLtXsYSt0Qb1nkfi199VPf7567XiE871U
        y7eHx6cJ1XW+mmH9UyedT4mlOCPRUIu5qDgRABEoH/e4AwAA
X-CMS-MailID: 20220616100944eucas1p15c06e5002e0f2cd08babcd1217fd63c6
X-Msg-Generator: CA
X-RootMTR: 20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb
References: <20220615101920.329421-1-p.raghav@samsung.com>
        <CGME20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb@eucas1p1.samsung.com>
        <20220615101920.329421-3-p.raghav@samsung.com>
        <857c444a-02b9-9cef-0c5b-2ecdb2fd46f6@acm.org>
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-15 22:28, Bart Van Assche wrote:
isk_name, zone->len);
>> +        if (zone->len == 0) {
>> +            pr_warn("%s: Invalid zone size", disk->disk_name);
>> +            return -ENODEV;
>> +        }
>> +
>> +        /*
>> +         * Don't allow zoned device with non power_of_2 zone size with
>> +         * zone capacity less than zone size.
>> +         */
> 

> Please change "power_of_2" into "power-of-2".
> 
Ok.
>> +        if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
>> +            pr_warn("%s: Invalid zone capacity for non power of 2
>> zone size",
>> +                disk->disk_name);
>>               return -ENODEV;
>>           }
> 
> The above check seems wrong to me. I don't see why devices that report a
> capacity that is less than the zone size should be rejected.
> 
This was brought up by Damien during previous reviews. The argument was
that the reason to allow non power-of-2 zoned device is to remove the
gaps between zone size and zone capacity. Allowing a npo2 zone size with
a different capacity, even though it is technically possible, it does
not make any practical sense. That is why this check was introduced.
Does that answer your question?
>> +        /*
>> +         * Division is used to calculate nr_zones for both power_of_2
>> +         * and non power_of_2 zone sizes as it is not in the hot path.
>> +         */
> 
> Shouldn't the above comment be moved to the patch description? I'm not
> sure whether having such a comment in the source code is valuable.
> 
Yeah, I will remove it. Maybe it is very obvious at this point.
>> +static inline sector_t blk_queue_offset_from_zone_start(struct
>> request_queue *q,
>> +                            sector_t sec)
>> +{
>> +    sector_t zone_sectors = blk_queue_zone_sectors(q);
>> +    u64 remainder = 0;
>> +
>> +    if (!blk_queue_is_zoned(q))
>> +        return false;
> 
> "return false" should only occur in functions returning a boolean. This
> function returns type sector_t.
> 
Good catch. It was a copy paste mistake. Fixed it.
> Thanks,
> 
> Bart.
