Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED276596A65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiHQH3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiHQH3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:29:02 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0999E3FA39
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:28:59 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220817072856euoutp02689da2575ff1c9c79985874916f93cf0~MEUGZ1faZ1791417914euoutp02S
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:28:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220817072856euoutp02689da2575ff1c9c79985874916f93cf0~MEUGZ1faZ1791417914euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660721336;
        bh=a1B6QBU92IfBgEiYWUxub5bQWgdRQ520Ci1+QX1ZX3g=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=NzKC5Iykk+NP4BGfN80lQHB8KnSo5mpWDL0vTrc2MqA1Z/enTXQdeFSsgCi0Ntcf9
         2Z5wyr/R9okS14D6fUx6hncHsLWTv/PL3GiWvtpzyqqdIqmBL7ETSLWyE1hJDyqFeU
         q4qG80Ca7IjWBvuuyp4776t+gGmPuG7ew/lsSVlI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220817072855eucas1p2acc0819c2c8862ae7eeacae34c59d1eb~MEUGAaUIp0668506685eucas1p2h;
        Wed, 17 Aug 2022 07:28:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 01.57.09580.7B89CF26; Wed, 17
        Aug 2022 08:28:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220817072855eucas1p1d63c062dfaa56968a50d2572c7d31b0e~MEUFllKjs0374303743eucas1p1c;
        Wed, 17 Aug 2022 07:28:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220817072855eusmtrp26a7f38ee68b50b05b3161b2c6d0e6279~MEUFkjNoF3100331003eusmtrp2g;
        Wed, 17 Aug 2022 07:28:55 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-fd-62fc98b770e1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.81.09038.7B89CF26; Wed, 17
        Aug 2022 08:28:55 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220817072854eusmtip2106bd6d4c9bfba353efa9be2336c3b63~MEUFa5wJD1646316463eusmtip21;
        Wed, 17 Aug 2022 07:28:54 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.74) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 17 Aug 2022 08:28:53 +0100
Message-ID: <fd82adec-1e06-d539-7718-2e08f4999b98@samsung.com>
Date:   Wed, 17 Aug 2022 09:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v10 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
CC:     <snitzer@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <agk@redhat.com>, <damien.lemoal@opensource.wdc.com>,
        <linux-block@vger.kernel.org>, <Johannes.Thumshirn@wdc.com>,
        <bvanassche@acm.org>, <matias.bjorling@wdc.com>, <hare@suse.de>,
        <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>,
        <jaegeuk@kernel.org>, <pankydev8@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dm-devel@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <YvwIvrToFYMDwQoj@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.74]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djPc7rbZ/xJMph1Xd5i/aljzBar7/az
        WUz78JPZ4vfZ88wWe9/NZrXYs2gSk8XK1UeZLJ6sn8Vs8bfrHpPFpEPXGC323tK2uLxrDpvF
        /GVP2S0mtH1ltrgx4SmjxZqbT1ksTtySdhD0uHzF22PnrLvsHpfPlnpsWtXJ5rF5Sb3H7psN
        bB47W++zerzfdxUodLra4/MmOY/2A91MAdxRXDYpqTmZZalF+nYJXBlHui6wF7RwVby5eJCt
        gbGfo4uRk0NCwESibek+NhBbSGAFo8TTPyVdjFxA9hdGiXtr5rBDOJ+BnNaTLDAdf1sWMUEk
        ljNKnGl5wwJXdWXadTYIZxejRP+kPewgLbwCdhK9568xgtgsAqoSb7f+ZYSIC0qcnPkEbKyo
        QKTEmt1nweqFBeIl5nTcBrOZBcQlbj2ZzwRiiwgoS9ydP5MVZAGzwF5miUXn3wNt4+BgE9CS
        aOwEq+cUsJf48KSZEaJXU6J1+2+oOfIS29/OYYZ4QUni6qkT7BB2rcTaY2eg7E+cEqvPhELY
        LhIX7+5ig7CFJV4d3wJVIyPxfyfEPRIC1RJPb/xmBrlHQqAF6OGd68HukRCwlug7kwNR4ygx
        a+VNqDCfxI23ghDn8ElM2jadeQKj6iykkJiF5ONZSD6YheSDBYwsqxjFU0uLc9NTi43zUsv1
        ihNzi0vz0vWS83M3MQJT4+l/x7/uYFzx6qPeIUYmDsZDjBIczEoivIIvfiQJ8aYkVlalFuXH
        F5XmpBYfYpTmYFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYKquefGgzL6HZdtJ694aoUs6
        Dxd0za6L8DMMV6jUj1veE3dsWohgc99WHfvmK5avNjska/xsaE7XXPtTf6n/yy75tro1+fZ/
        +74KWh38u9hNMX3/thPz7tyXnvDres/Ups9vG5o+X023nxh6kdPpa83ECRb9PHud477H2edK
        Pumdcf/s3W/KAutNn0nHWiVV/jrO1vjuo1FX9i/7v8+Ntr5849B20Kjw5pWZQpza8zanyPyd
        eGZNSmNb/u/CKoNw5kUXLC0dOqeeecIqX/Dz7qEzGdxen+Zw/J9szT91oodkmsfiu28Vryw2
        U7A+yLGzNTqDZ1XLxCtmCjrL7h6svfX4362s1EnuNrsWHf363U2JpTgj0VCLuag4EQChxcGd
        /AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xe7rbZ/xJMujax2qx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rsWTSJyWLl6qNMFk/Wz2K2+Nt1j8li0qFrjBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTRYs3NpywWJ25JOwh6XL7i7bFz1l12j8tnSz02repk89i8pN5j980G
        No+drfdZPd7vuwoUOl3t8XmTnEf7gW6mAO4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9
        Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwjXRfYC1q4Kt5cPMjWwNjP0cXIySEhYCLxt2URUxcj
        F4eQwFJGiabNvSwQCRmJT1c+skPYwhJ/rnWxQRR9ZJQ4NWkqI4Szi1Hi5Kq3rCBVvAJ2Er3n
        rzGC2CwCqhJvt/5lhIgLSpyc+QRsqqhApMTDZU1MILawQLzEnI7bYBuYBcQlbj2ZDxYXEVCW
        uDt/JivIAmaBvcwScz6dARskJPCFUeJ6M28XIwcHm4CWRGMnWC+ngL3EhyfNjBBzNCVat/+G
        mikvsf3tHGaID5Qkrp46AfVNrcSr+7sZJzCKzkJy3iwkZ8xCMmoWklELGFlWMYqklhbnpucW
        G+kVJ+YWl+al6yXn525iBKaUbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4BV/8SBLiTUmsrEot
        yo8vKs1JLT7EaAoMo4nMUqLJ+cCkllcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpa
        kFoE08fEwSnVwDT9Xfuh3+JFou+m7rt0zyzPVG23xL7rLs37p39/ZGHqsud9RdzBu1O1iiS/
        MfEce7qi0Gv/f9/Ex6IR/4qzhOd5iHovTNFlsW0y4kkTT5kTZ8U+zeDva6FJ3Z/+6D1oOihp
        s12TYeXuxqY5pu9i2O7Ihd6NttrssvpewZl5P2pa577c/WHRjUUH+HS0nE/UnNu3TuPLMotL
        V5N8Fme8b5i65s2jwBc8W95eOtI/TUF9Sicj6ywx9Q3dTWKdx21nh5+yF7i7UDxq1fZ1lQJB
        q855KYimhTo3u/x05Jt9blL7kpMlb+SWbWz6bTsn1uW6YuVEltJZKyPZWNpL5/+LbvmrGf40
        P+Xrr4nfftkv2fFZiaU4I9FQi7moOBEA39Cu9bIDAAA=
X-CMS-MailID: 20220817072855eucas1p1d63c062dfaa56968a50d2572c7d31b0e
X-Msg-Generator: CA
X-RootMTR: 20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9@eucas1p1.samsung.com>
        <20220811143043.126029-6-p.raghav@samsung.com>
        <YvwIvrToFYMDwQoj@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

On 2022-08-16 23:14, Keith Busch wrote:
> On Thu, Aug 11, 2022 at 04:30:35PM +0200, Pankaj Raghav wrote:
>> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>>  	}
>>  
>>  	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
>> -	if (!is_power_of_2(ns->zsze)) {
>> -		dev_warn(ns->ctrl->device,
>> -			"invalid zone size:%llu for namespace:%u\n",
>> -			ns->zsze, ns->head->ns_id);
>> -		status = -ENODEV;
>> -		goto free_data;
>> -	}
> 
> We used to bail out early if the format wasn't supported, which wouldn't create
> the namespace.
> 
> Now you are relying on blk_revalidate_disk_zones() to report an error for
> invalid format, but the handling for an error there is different: the namespace
> still gets created. I'm not sure if that's a problem, but it's different.
That is right but it is not a problem. Once the block layer supports the
non-po2 zone sizes, we don't need to bail out here because it will be
compatible. If unequal zone sizes are found, block layer will report an
error during blk_revalidate_disk_zones() which is the current behavior anyway.

Other checks such as zone operation support are still in
nvme_update_zone_info() resulting in an early bail out if violated.
