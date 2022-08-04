Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035D6589862
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiHDHaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiHDH35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:29:57 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18838220F7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:29:53 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220804072948euoutp025d0ddbf2e71d6d56d5efece254d2dc46~IE8J5UGV62160821608euoutp02c
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:29:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220804072948euoutp025d0ddbf2e71d6d56d5efece254d2dc46~IE8J5UGV62160821608euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659598188;
        bh=jnUbqqxtqKEs3eL1T2tnuuExSbUm+xevcGXFz+W0Zjs=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=b5bVjBr8G5YaEgeMlRi5OLilr0xgnA+lQ2jxpgYHrxAx/3zdRwhaGsjyEv71yCfsQ
         C+h5PxZDvI8OMZCQgcMyfaigIMcUAkw9vEAFceTQog27ZMVbXJiW0WXM34tMrISsap
         XTUq9/wzWzI91w0TNMwcbfuf3D2RbrEpT7lGVo/4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220804072948eucas1p121431348dc2c1518f5e4162314d7e198~IE8JgzTTM2410624106eucas1p1N;
        Thu,  4 Aug 2022 07:29:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 90.6F.10067.C657BE26; Thu,  4
        Aug 2022 08:29:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220804072947eucas1p13d72273f427549e045227443a1b5986e~IE8JH1r-i3015830158eucas1p1-;
        Thu,  4 Aug 2022 07:29:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220804072947eusmtrp2d9ed2aef8f7f26f182d2f638ed0d03fa~IE8JG9fZC2908429084eusmtrp2a;
        Thu,  4 Aug 2022 07:29:47 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-7a-62eb756c783f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5E.9C.09038.B657BE26; Thu,  4
        Aug 2022 08:29:47 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220804072947eusmtip10cdd8d8afa4cf74d25a908afe0f498aa~IE8I7rQ8t1783017830eusmtip1S;
        Thu,  4 Aug 2022 07:29:47 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.112) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 4 Aug 2022 08:29:45 +0100
Message-ID: <73f35f39-9637-056e-91b9-ee6b2c104977@samsung.com>
Date:   Thu, 4 Aug 2022 09:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [dm-devel] [PATCH v9 05/13] nvme: zns: Allow ZNS drives that
 have non-power_of_2 zone size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <Johannes.Thumshirn@wdc.com>,
        <snitzer@kernel.org>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <agk@redhat.com>, <hch@lst.de>
CC:     <pankydev8@gmail.com>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <jaegeuk@kernel.org>, <matias.bjorling@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <2616b59b-8c6b-a482-a396-d9408fa461a3@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.112]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djPc7o5pa+TDM4/4bRYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1Wrj7KZPFk/Sxmi79d95gs9t7Stri8aw6bxfxlT9ktJrR9Zba4
        MeEpo8Wam09ZLE7cknbg97h8xdtj56y77B6Xz5Z6bFrVyeaxeUm9x+6bDWweO1vvs3q833eV
        zePzJjmP9gPdTAFcUVw2Kak5mWWpRfp2CVwZl54dYyk4x1Kx8OVx5gbGJ8xdjBwcEgImEvv/
        mnUxcnEICaxglJjztoUZwvnCKNE3/T4ThPOZUWLXm8OsXYycYB1vrh1ihUgsZ5TYefoxWAKs
        asXdaIjELkaJhVsfMIMkeAXsJHZN+cgGYrMIqEj0Xd3BChEXlDg58wkLiC0qECmxZvdZdhBb
        WCBTYunaxUwgNrOAuMStJ/PBzhAR2M4o8f7XHTCHWaCNSWLuni3sIF+wCWhJNHaCNXMKWEu8
        XPIHqllTonX7b3YIW16ieetsZogXlCWObJ/LDmHXSqw9doYdZKaEwC1Oib+nV7FAJFwkNpzu
        ZYOwhSVeHd8C1SAj8X/nfCYIu1ri6Y3fzBDNLYwS/TvXs0GC1Vqi70wORI2jxOKZM1ghwnwS
        N94KQtzDJzFp23TmCYyqs5DCYhaSn2cheWEWkhcWMLKsYhRPLS3OTU8tNspLLdcrTswtLs1L
        10vOz93ECEyAp/8d/7KDcfmrj3qHGJk4GA8xSnAwK4nwrrB8nSTEm5JYWZValB9fVJqTWnyI
        UZqDRUmcNzlzQ6KQQHpiSWp2ampBahFMlomDU6qByflaG++t/LYdK458+38yfr4i1zlpQU8T
        0d07b3w5IW3I5/3QoXe9W5Vx4svEaGvGhv6qbwFMcWoTJ0v9i/eaUnUq993xJtN8vsO/WhOC
        WjTzVbbsWpHZ4pTcNS9a97/ttSsLPdw+tfF1bxOcGTFX98aEGBf9I5nCLHsnV06u2Ppv3s7t
        J2a4TdSUX9Gw5fZ07oULpGfcW3BnynrZxE0Fy40Xcdq5pcbpaFlvvff3n5I4/+9jK/4qfL/R
        O5Pb2+mwWhRL+5mHy2c7bVPiu8m/zjyabcmXQ9sc53HJPQivZG6Vy7zY8ixv+gbZeqfIbJkC
        l7rI5TU7BTi+m74wMUtTfnpK9e7T/q8/0mtun5P1VmIpzkg01GIuKk4EABJBtL3vAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsVy+t/xu7rZpa+TDBYt1rFYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1Wrj7KZPFk/Sxmi79d95gs9t7Stri8aw6bxfxlT9ktJrR9Zba4
        MeEpo8Wam09ZLE7cknbg97h8xdtj56y77B6Xz5Z6bFrVyeaxeUm9x+6bDWweO1vvs3q833eV
        zePzJjmP9gPdTAFcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5
        mWWpRfp2CXoZl54dYyk4x1Kx8OVx5gbGJ8xdjJwcEgImEm+uHWLtYuTiEBJYyihxaecKqISM
        xKcrH9khbGGJP9e62CCKPjJKNJ74AuXsYpQ4s3I7C0gVr4CdxK4pH9lAbBYBFYm+qztYIeKC
        EidnPgGrERWIlHi4rIkJxBYWyJTYtecmI4jNLCAucevJfCaQoSIC2xkl3v+6A+YwC7QxSczd
        s4UdYt0HRomjfSuAHA4ONgEticZOsPs4BawlXi75wwQxSVOidftvdghbXqJ562yof5Qljmyf
        C/VPrcSr+7sZJzCKzkJy4Cwkh8xCMmoWklELGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525i
        BKaObcd+btnBuPLVR71DjEwcjIcYJTiYlUR4V1i+ThLiTUmsrEotyo8vKs1JLT7EaAoMpYnM
        UqLJ+cDklVcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwJR18u2q
        GvbkpZx9JWxh2csEjyXldhTsZMiK/aOrma9bVyd8yaK6nC/hY32lu7TcY7usyMmKz+1sRSSn
        84S/uvLNnSOgaKWNxt6Fuc0r74Znbfj2/fqVqd7WTFqBK3jvv+F67/6050bqSqWiXRFz37ge
        1LkgWBI3v8td8kSg6ZftC/wXllqdbPX7+GRZi8ve2fJnf89mqokMFKyWmNreJSTpae4cde3r
        Pl0PEcN4hw07VqUzLGq6xvhci/MO9/QM5oX5vd2TXs1/tFDp270raxQjbBsvd/jeqihqkpBe
        q+syp1nukaP/WslbRfnOwfsyyzwE7Z/s2+Ycu19Wr33Rh7r/tsGeTbVvrtaHKQYqsRRnJBpq
        MRcVJwIA5SgUHaYDAAA=
X-CMS-MailID: 20220804072947eucas1p13d72273f427549e045227443a1b5986e
X-Msg-Generator: CA
X-RootMTR: 20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527@eucas1p1.samsung.com>
        <20220803094801.177490-6-p.raghav@samsung.com>
        <2616b59b-8c6b-a482-a396-d9408fa461a3@acm.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 2022-08-03 19:22, Bart Van Assche wrote:
> On 8/3/22 02:47, Pankaj Raghav wrote:
>> -    sector &= ~(ns->zsze - 1);
>> +    /*
>> +     * Round down the sector value to the nearest zone start
>> +     */
>> +    div64_u64_rem(sector, ns->zsze, &remainder);
>> +    sector -= remainder;
> 
> Could bdev_offset_from_zone_start() be used here?
> 
We call this function during blk_revalidate_disk_zones() to evaluate the
chunk sectors. So we can't call bdev_offset_from_zone_start() from here
as the chunk_sectors will not be initialized yet :)
