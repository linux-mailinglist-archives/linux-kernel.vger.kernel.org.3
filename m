Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7BF584CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiG2Hqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiG2Hqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:46:30 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24A882101
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:45:34 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220729074530euoutp02eab4dd344704ce42ef88ee38b8591029~GPSJxNyXw0435204352euoutp02v
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:45:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220729074530euoutp02eab4dd344704ce42ef88ee38b8591029~GPSJxNyXw0435204352euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659080730;
        bh=2JvP5q4s3KFrEayk/Q9vM7n8LVWKGMn9/c9LOwESMTw=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=jvCNwCH5AfMdg/nWkZy+l0jGwXj6X+oO9J4qnnAyfYG759yzITtJbKcnOIaTtQhpJ
         gGTKKpXWzVs0ENN+7BePiAvaASbguCAasAfC0/800lffL4043CScJwXQ6tcmMR2q8C
         ZGVpM125N4lFoz8LI4dCL+qYQHOsr+JLdOJJndh8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220729074530eucas1p21ea3c19a45c637ef3d9ea2e96196ecd6~GPSJa76JX1134011340eucas1p2Z;
        Fri, 29 Jul 2022 07:45:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 80.93.10067.A1093E26; Fri, 29
        Jul 2022 08:45:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220729074530eucas1p270ac45caf3b18a52191551f8a743fa6d~GPSJFi8cZ2146621466eucas1p2q;
        Fri, 29 Jul 2022 07:45:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220729074530eusmtrp1b27a38390c4717b0777540433b641bf0~GPSJEg2ci2539025390eusmtrp1J;
        Fri, 29 Jul 2022 07:45:30 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-4a-62e3901aeb7b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 85.80.09038.A1093E26; Fri, 29
        Jul 2022 08:45:30 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220729074529eusmtip264c47380f46b3f8f37950cd2d57efb12~GPSI7HuWE0719907199eusmtip2D;
        Fri, 29 Jul 2022 07:45:29 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.8) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 29 Jul 2022 08:45:27 +0100
Message-ID: <4f6f9ea5-fac6-598d-fcaa-3cb24cb2d935@samsung.com>
Date:   Fri, 29 Jul 2022 09:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v8 04/11] nvmet: Allow ZNS target to support
 non-power_of_2 zone sizes
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>, <hch@lst.de>,
        <axboe@kernel.dk>, <snitzer@kernel.org>,
        <Johannes.Thumshirn@wdc.com>
CC:     <matias.bjorling@wdc.com>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>,
        <linux-block@vger.kernel.org>, <pankydev8@gmail.com>,
        <bvanassche@acm.org>, <jaegeuk@kernel.org>, <dm-devel@redhat.com>,
        <linux-nvme@lists.infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <137b8772-a2cc-f195-1c0d-476214fabd52@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.8]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djPc7pSEx4nGWzeLGWx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLPYsmMVmsXH2UyeLJ+lnMFn+77jFZ7L2lbXF51xw2i/nLnrJbTGj7ymxx
        Y8JTRos1N5+yWJy4Je3A73H5irfHzll32T0uny312LSqk81j85J6j903G9g8drbeZ/V4v+8q
        UOh0tcfnTXIe7Qe6mQK4o7hsUlJzMstSi/TtErgy7vx/zlawlqNi99ab7A2Md9m6GDk5JARM
        JKYvncfcxcjFISSwglHi45E9bBDOF0aJhY83sUI4nxkltr9eD9eyqG8OE0RiOaNE29GtzHBV
        04/OYodwdjJKnD34kwmkhVfATqL3yUbGLkYODhYBVYnlHU4QYUGJkzOfsIDYogKREmt2n2UH
        sYUFYiQO7TvGDGIzC4hL3HoyH2yMiEAPo8Tf3Ywg85kF1jFJtB69zgYyk01AS6Kxkx3E5BRw
        k7hwTRCiVVOidftvdghbXmL72znMEA8oSvR/3wD1TK3E2mNnwE6WEHjEKTF10ht2iISLxJ+O
        F4wQtrDEq+NboOIyEqcn97BA2NUST2/8ZoZobmGU6N+5HuweCQFrib4zORA1jhK3O1exQIT5
        JG68hbqNT2LStunMExhVZyGFxCwkH89C8sIsJC8sYGRZxSieWlqcm55abJSXWq5XnJhbXJqX
        rpecn7uJEZgGT/87/mUH4/JXH/UOMTJxMB5ilOBgVhLhFQh4nCTEm5JYWZValB9fVJqTWnyI
        UZqDRUmcNzlzQ6KQQHpiSWp2ampBahFMlomDU6qByVxoTnbkSfY1HyRjjsZHC8c5NHK5JVbP
        1lppd8B47dUsZ0uF7buTzX3luFa9dmn6wrDWVCSII7RLduWqHZrLTq2TVDDnd3bli2t+KyZq
        6eXx1O2xw0FBN4YqvY4MK4Xfs/xCIl6IP/V+wqI9r2v2J1bhzzuXiMSdlokx5kl95HUkpndi
        g5dGlq7HzmKxX0cbrnP7GoskqzxlWan9KUvh/F+mziOiP6fK9USszFFa9+6Hj2P9RM/+NJ+j
        k2tLZ6fNaeBP2aPSHOzi8vXKq1dhrXzivBIqkofmPZnx4Ocm9YKOL9pKvjNPrfJTXXFuSfUF
        wVSuV3aPElwkyyPv14grluSyVb251vko/+Dql0osxRmJhlrMRcWJAArgzZzyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsVy+t/xe7pSEx4nGXzazGyx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLPYsmMVmsXH2UyeLJ+lnMFn+77jFZ7L2lbXF51xw2i/nLnrJbTGj7ymxx
        Y8JTRos1N5+yWJy4Je3A73H5irfHzll32T0uny312LSqk81j85J6j903G9g8drbeZ/V4v+8q
        UOh0tcfnTXIe7Qe6mQK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1s
        UlJzMstSi/TtEvQy7vx/zlawlqNi99ab7A2Md9m6GDk5JARMJBb1zWHqYuTiEBJYyiixe/di
        qISMxKcrH9khbGGJP9e6wOJCAh8ZJebfqIewdzJK7OnnAbF5Bewkep9sZOxi5OBgEVCVWN7h
        BBEWlDg58wkLiC0qECnxcFkTE4gtLBAjcWjfMWYQm1lAXOLWk/lgcRGBHkaJv7sZQe5hFljH
        JNF69DobxHG/GSXmPPwKtoBNQEuisZMdxOQUcJO4cE0QYo6mROv23+wQtrzE9rdzmCHOV5To
        /74B6q1aiVf3dzNOYBSdheS8WUjOmIVk1CwkoxYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P
        3cQITBzbjv3csoNx5auPeocYmTgYDzFKcDArifAKBDxOEuJNSaysSi3Kjy8qzUktPsRoCgyi
        icxSosn5wNSVVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAtCCN
        4yzz8SWbsivOi2UUPt29712/WOD5tgVvdni80OdNYbpVuU3NXZGr8carlTWNIef5Tb7Mu3k2
        4YZlx9e1KRkfjn2qMzmpLnPN8ajpi40iSY8/zLSw0Pw7c8M8npOqOys+aESmxBSeLznToa2t
        uLmCybLj8OUHqww2sd87cnPaHDOP5HSuBw/EjrxYsJv9/P8iy/O/rrXq11vfqO9+bxf28wqX
        IMfRgPQs3ZM5Pb8mdN9qvjy3Ke2vfsSye6xmHUXvWZxPCT6SXvv6kqi4n9T7D1xaqsKRS0XF
        Dxeeei5+QSb3rsiRnS4q80q2OD5aITUrK9j89Cpuiyebt3o5a/3Y+njNgos3m+a/XFrZ76XE
        UpyRaKjFXFScCABRZxy8pQMAAA==
X-CMS-MailID: 20220729074530eucas1p270ac45caf3b18a52191551f8a743fa6d
X-Msg-Generator: CA
X-RootMTR: 20220727162250eucas1p133e8a814fee934f7161866122ef93273
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162250eucas1p133e8a814fee934f7161866122ef93273
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162250eucas1p133e8a814fee934f7161866122ef93273@eucas1p1.samsung.com>
        <20220727162245.209794-5-p.raghav@samsung.com>
        <137b8772-a2cc-f195-1c0d-476214fabd52@opensource.wdc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-28 05:09, Damien Le Moal wrote:

>>  }
> 
> This change should go into patch 3. Otherwise, adding patch 3 only will
> break the nvme target zone code.
> 
Ok.
>>  
>>  static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 1be805223026..d1ef9b9552ed 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1350,6 +1350,11 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>>  	return BLK_ZONED_NONE;
>>  }
>>  
>> +static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
>> +{
>> +	return disk_zone_no(bdev->bd_disk, sec);
>> +}
>> +
> 
> This should go into a prep patch before patch 3.
> 
Bart commented in the earlier versions to see the new helpers along with
its usage instead of having it separately in a prep patch.

>>  static inline int queue_dma_alignment(const struct request_queue *q)
>>  {
>>  	return q ? q->dma_alignment : 511;
> 
> 
