Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5AC584DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiG2IsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiG2IsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:48:16 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FC267C82
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:48:13 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220729084811euoutp02ff283f5c2f906a6144ec7322a181ac7f~GQI4X0JMP0702707027euoutp02D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:48:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220729084811euoutp02ff283f5c2f906a6144ec7322a181ac7f~GQI4X0JMP0702707027euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659084491;
        bh=J7pf8l02sZv1evRPs/g74/E4T+W0WimSo4Amwk96bHc=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=runBe9DOjcJjKFbe4TBs6r3p6p1GXrjrRvv+v7bR9QSSOEChGy1dzsAmrbOUZPkD+
         GDwAieVRhPb2e0MObsJqlPPIdyZ/ttHrU+7pCsD3w+5opko04b7tEzOSaotdQk/7g3
         9zIiYjlaSwFKXC9v2PWp7qC/idCmjuU/gDOKJO2U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220729084811eucas1p29c708be560495e380d2ba54446086657~GQI4AoB3p3148931489eucas1p2D;
        Fri, 29 Jul 2022 08:48:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 16.90.10067.BCE93E26; Fri, 29
        Jul 2022 09:48:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220729084810eucas1p1e495e9f4378f515ddc42e7fb54690c8c~GQI3oGuWO2521325213eucas1p1q;
        Fri, 29 Jul 2022 08:48:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220729084810eusmtrp1fcf915da651f0bc849b5f10ce7b597ea~GQI3nRaJm3175431754eusmtrp17;
        Fri, 29 Jul 2022 08:48:10 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-4b-62e39ecb5a6f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 30.AB.09095.ACE93E26; Fri, 29
        Jul 2022 09:48:10 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220729084810eusmtip122adeb7211a38b2523b3a9e055ee2d0e~GQI3b6Uya1554515545eusmtip1y;
        Fri, 29 Jul 2022 08:48:10 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.8) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 29 Jul 2022 09:48:08 +0100
Message-ID: <7fe560c6-4078-f89a-892d-d79b52664045@samsung.com>
Date:   Fri, 29 Jul 2022 10:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v8 10/11] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>, <hch@lst.de>,
        <axboe@kernel.dk>, <snitzer@kernel.org>,
        <Johannes.Thumshirn@wdc.com>
CC:     <matias.bjorling@wdc.com>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>,
        <linux-block@vger.kernel.org>, <pankydev8@gmail.com>,
        <bvanassche@acm.org>, <jaegeuk@kernel.org>, <dm-devel@redhat.com>,
        <linux-nvme@lists.infradead.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <2b1ab4ac-a355-dfb4-6ca4-82fe36a38433@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.8]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87qn5z1OMth8XcBi9d1+NotpH34y
        W/w+e57ZYu+72awWexZNYrJYufook8WT9bOYLf523WOy2HtL2+LyrjlsFvOXPWW3mND2ldli
        zc2nLBYnbkk78HlcvuLtsXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j52t91k93u+7ChQ6Xe3x
        eZOcR/uBbqYA7igum5TUnMyy1CJ9uwSujHPb3zMXfOOsWNtxga2B8QV7FyMnh4SAicTCp8eB
        bC4OIYEVjBJNnQ1sEM4XRolTr3czQjifGSXm/97OCtNyfuUhZhBbSGA5o8SZq6VwRTMfL2GD
        SOwE6viZCmLzCthJXNy3nAXEZhFQlZjY2cUIEReUODnzCVhcVCBSYs3us2A3CQtkSByavhZs
        AbOAuMStJ/OZQGwRgR5Gib8QFzELdDBJbNvUDJTg4GAT0JJo7ATr5RRwk2g8dY4doldTonX7
        byhbXmL72znMEA8oSvR/38AGYddKrD12Bux/CYFbnBKzF0yCBoyLxOoHmxghbGGJV8e3QMVl
        JE5P7mGBsKslnt74zQzR3MIo0b9zPRvIQRIC1hJ9Z3IgahwljjyaABXmk7jxVhDiHj6JSdum
        M09gVJ2FFBSzkLw8C8kLs5C8sICRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg8jv9
        7/iXHYzLX33UO8TIxMF4iFGCg1lJhFcg4HGSEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2J
        QgLpiSWp2ampBalFMFkmDk6pBqbqHz2zrgUJ2C+vmMl/oGaf9aozQg4mxkFz3t/hnPniUqis
        oxG7hewlca4ya5ZbxyaJy/5QXh29NsJHhO1b/snbnxPWdwj1GGw+EfZ2f6GzWLWb793VuQVJ
        NzYtOGDrsIHnzd1zHvurTv35vLU02OKCobVa5eqPriFvIp8736i7bTf5lB5jZ/gXp12vuIS+
        VwVNSOXXXmbFoCK+fff/O2eCFh03dJ0vnCq6t5RNJbUydV7nVIWf8UIrL9RklP3yT9k+x2Z2
        9eLHi9g2m+51lVDbnLM6cdrZ966Zds3rcw/tXLtgruNksYUZXqYrvm9t4/m3q/ehqkrYwezb
        kgueHvefdzaAR9zmSozoZwYVA1UlluKMREMt5qLiRADsUhrO7QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsVy+t/xu7qn5j1OMrjbYWqx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLPYsmMVmsXH2UyeLJ+lnMFn+77jFZ7L2lbXF51xw2i/nLnrJbTGj7ymyx
        5uZTFosTt6Qd+DwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we7/ddBQqdrvb4
        vEnOo/1AN1MAd5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexrnt75kLvnFWrO24wNbA+IK9i5GTQ0LAROL8ykPMXYxcHEICSxkllvWeZYRIyEh8
        uvIRqkhY4s+1LjaIoo+MEh+6nrFAODsZJVb9m8UCUsUrYCdxcd9yMJtFQFViYmcXI0RcUOLk
        zCdgcVGBSImHy5qYQGxhgQyJQ9PXMoPYzALiEreezAeLiwj0MEr83c0IsoBZoI1J4nzDRUaI
        bX8YJb69mMzaxcjBwSagJdHYCXYep4CbROOpc+wQgzQlWrf/hrLlJba/ncMM8YKiRP/3DWwQ
        dq3Eq/u7GScwis5Cct8sJHfMQjJqFpJRCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgSm
        jW3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeAUCHicJ8aYkVlalFuXHF5XmpBYfYjQFBtJEZinR
        5Hxg4soriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamCKMLSsb3QK
        FPO8aeU1J0JnVqnUg1nyC1uZ27nTeXKf9spE8BXvqLn2tVRmQpfQuttaN8vvvLxt3q+26G7V
        K6mW8Nmbnp9XvTfLQziy+/w+z+1uJV4X2A/wGotpywmd/mF9rEr3iHOU+9eQxIlv9lsn7zt1
        PeTVBC2dA4kbN73bdPGzwqr/dzwOeH5+8kT+VbMy85YQsatMiu88vD9uj1k2/cz8t0/8NjEV
        BKqENB1OsbjNbHX9ed5n6UnZ9iy7X5fPc3VdW3JuPeu7qQ7OE+M6Zfcdf7BUMEruGuNTy+YX
        j23tGH+Zp9xfNe960lejC5NOrJonemeK7RRDx78BJQVMzOrC6cc/phuVlLpYHX6vxFKckWio
        xVxUnAgAdiWloqQDAAA=
X-CMS-MailID: 20220729084810eucas1p1e495e9f4378f515ddc42e7fb54690c8c
X-Msg-Generator: CA
X-RootMTR: 20220727162256eucas1p284a15532173cce3eca46eee0cee3acdd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162256eucas1p284a15532173cce3eca46eee0cee3acdd
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162256eucas1p284a15532173cce3eca46eee0cee3acdd@eucas1p2.samsung.com>
        <20220727162245.209794-11-p.raghav@samsung.com>
        <2b1ab4ac-a355-dfb4-6ca4-82fe36a38433@opensource.wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  	if (endio) {
>>  		int r = endio(ti, bio, &error);
>>  		switch (r) {
>> @@ -1155,6 +1151,10 @@ static void clone_endio(struct bio *bio)
>>  		}
>>  	}
>>  
>> +	if (static_branch_unlikely(&zoned_enabled) &&
>> +	    unlikely(bdev_is_zoned(bio->bi_bdev)))
>> +		dm_zone_endio(io, bio);
>> +
>>  	if (static_branch_unlikely(&swap_bios_enabled) &&
>>  	    unlikely(swap_bios_limit(ti, bio)))
>>  		up(&md->swap_bios_semaphore);
> 
> This patch seems completely unrelated to the series topic. Is that a bug
> fix ? How do you trigger it ? Our tests do not show any issues here...
> If this triggers only with non power of 2 zone size devices, then this
> should be squashed in patch 8. And patch 9 could also be squashed with
> patch 8 too.
> 
The targets that support zoned devices such as dm-zoned, dm-linear, and
dm-crypt do not have an endio function, and even if they do (such as
dm-flakey), they don't modify the bio->bi_iter.bi_sector of the cloned
bio that is used to update the orig_bio's bi_sector in dm_zone_endio
function.

This path is triggered only for the new target dm-po2zone and not for
npo2 zone size devices in general. I will mention this is a prep patch
for the new target because I wouldn't call it a bug per se.
