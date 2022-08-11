Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B5158FD3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiHKNSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiHKNRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:17:55 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C24B7B7B9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:17:54 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220811131750euoutp02aa00fcc46760da7cc88a8b75213a2a29~KTNBlMF-d0070600706euoutp02X
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:17:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220811131750euoutp02aa00fcc46760da7cc88a8b75213a2a29~KTNBlMF-d0070600706euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660223870;
        bh=Vun+gxn/6GGUdv/MRPXNdrbElNQFCuft36lThciOU28=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=O4xsWJm4cyq/4Yh0kN11fAjkgj2cpSM80dFLSBVBOmoH2STNgkj2OPqTg8iAx4FJF
         l9dpnOldbBRSZjldGISht50wjzAusMdLbEjOcqpp+FfoKGNU0sexa4LuKrinANrVWT
         JOQhMSV5f/BFc6lCfZceV3BjdlgZebPN6h0hqHcc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220811131750eucas1p198d4a2f1cdb759f30a96e801edc14992~KTNBNGQux1197711977eucas1p1s;
        Thu, 11 Aug 2022 13:17:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.91.10067.E7105F26; Thu, 11
        Aug 2022 14:17:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220811131749eucas1p2456bbf8f8a2538b9ecf9f5be0092b643~KTNA0jRaH1732617326eucas1p2I;
        Thu, 11 Aug 2022 13:17:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220811131749eusmtrp1716c41bc4995b31c4e4725050f35189a~KTNAzmNiZ0860708607eusmtrp14;
        Thu, 11 Aug 2022 13:17:49 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-ba-62f5017e867f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E4.A4.09038.D7105F26; Thu, 11
        Aug 2022 14:17:49 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220811131749eusmtip1985b7f25892c387e44680c1d52d0068c~KTNAppwLl1773117731eusmtip1y;
        Thu, 11 Aug 2022 13:17:49 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.43) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 11 Aug 2022 14:17:47 +0100
Message-ID: <f3ec55d3-f1fe-1875-f8e7-f7c46d89b065@samsung.com>
Date:   Thu, 11 Aug 2022 15:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v9 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <Johannes.Thumshirn@wdc.com>, <snitzer@kernel.org>,
        <axboe@kernel.dk>, <agk@redhat.com>, <hch@lst.de>
CC:     <dm-devel@redhat.com>, <matias.bjorling@wdc.com>,
        <gost.dev@samsung.com>, <linux-kernel@vger.kernel.org>,
        <pankydev8@gmail.com>, <jaegeuk@kernel.org>, <hare@suse.de>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <bvanassche@acm.org>, Damien Le Moal <damien.lemoal@wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <b73143fd-107d-177d-d647-f17a32b9423e@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.43]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7p1jF+TDG5MYbdYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWuxZNInJYuXqo0wWT9bPYrb423UPKHFL2+LyrjlsFvOX
        PWW3mND2ldlizc2nLBYnbkk7CHhcvuLtsXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j52t91k9
        3u+7ChQ6Xe3xeZOcR/uBbqYA7igum5TUnMyy1CJ9uwSujCcb57EWvBKsOHBEtoFxH08XIyeH
        hICJxITrn9m6GLk4hARWMEq0HrwG5XxhlNi2+Cg7hPOZUeLS3kmMMC0zfi5jhUgsZ5T4dXM+
        G1xV76UzUM4uRok3fVeZQVp4BewkJh+/ywJiswioSjQ0z2eFiAtKnJz5BCwuKhApsWb3WaB9
        HBzCAlkSL5/KgISZBcQlbj2ZzwQyU0RgAaPE6wWNYKuZBTYwSXz8384C0sAmoCXR2MkO0sAp
        4CYx7ed2JohmTYnW7b/ZIWx5ie1v5zCDlEsIKElsnMAP8U2txNpjZ8DelBB4xSlx5OFZdoiE
        i8Sz1zvZIGxhiVfHt0DFZSROT+5hgbCrJZ7e+M0M0dzCKNG/cz0bxAJrib4zORA1jhILT/ey
        Q4T5JG68FYQ4h09i0rbpzBMYVWchhcQsJC/PQvLBLCQfLGBkWcUonlpanJueWmyUl1quV5yY
        W1yal66XnJ+7iRGYEE//O/5lB+PyVx/1DjEycTAeYpTgYFYS4S1b9DlJiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA1NX/kPnfwXv2oyrF7ldvhs758xj
        hs6555Zmcsae9zmWY/XRw+DeMoWrZillB//kSbd94XyqqZ2mFlTPekWGpWbe2n3tgsGWZ4TY
        J3TOdJnwx1Jrx5XijjsTbgr2tW03Pabftrxi4i6hgqiiDLUJlavar1f95/kza+viFUsWNiWu
        erZM7G6u0kWhydV1emffbH0Rvbv006Smtmk+hXxTV3xi2+Qp9/d2ZXLY086PdWWHN1VX7dBd
        vWZ359wXBT3bp6utUUv4MK08znQun2qDq4Lu9p1u988fYMiXPtIUmvWyaf6GR8Z7cx9ICWx/
        JhBYsfTENYNJP3LjzC5J7lo2zTCaTZXJWntVssa21ENTn6sosRRnJBpqMRcVJwIAK5QPuvcD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsVy+t/xu7q1jF+TDN690rBYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWuxZNInJYuXqo0wWT9bPYrb423UPKHFL2+LyrjlsFvOX
        PWW3mND2ldlizc2nLBYnbkk7CHhcvuLtsXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j52t91k9
        3u+7ChQ6Xe3xeZOcR/uBbqYA7ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
        JX07m5TUnMyy1CJ9uwS9jCcb57EWvBKsOHBEtoFxH08XIyeHhICJxIyfy1i7GLk4hASWMkp0
        nLzEApGQkfh05SM7hC0s8edaFxtE0UdGidVH1jBBOLsYJbZM7mMGqeIVsJOYfPwuWDeLgKpE
        Q/N8Voi4oMTJmU/A4qICkRIPlzUxgdjCAlkS635OAYszC4hL3HoyH2yoiMACRonXCxrBbmIW
        2MAkcXryTTaQKiGBP4wSk+9rdzFycLAJaEk0doKdxyngJjHt53YmiEGaEq3bf7ND2PIS29/O
        YQYplxBQktg4gR/im1qJV/d3M05gFJ2F5LxZSM6YhWTSLCSTFjCyrGIUSS0tzk3PLTbSK07M
        LS7NS9dLzs/dxAhMI9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8JYt+pwkxJuSWFmVWpQfX1Sa
        k1p8iNEUGEYTmaVEk/OBiSyvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaP
        iYNTqoEpq2F2332RUgvfr/IOz9tf/nnptPtgm3t/QNwJ0WsdEi2m/C8jMisvsga8uHjKKrJJ
        bpPOggnnj/UtXV5Vbm2r37/3+w4R8Wf7Fzp8/b6epy0y+c3E6BnSaxqMK748lHskE7xM+PV9
        dnumjjsi75a9mPTNvMv6OHf4E+0n2SwCDq9mukTMOnNCN2penCn7hh+Tfmw7HF/cdq9TqnrO
        ZfWpYYVPQ64q8DgsvbW06XucUNzvlGMGDA0FUwtSnxq7OjcvPrJmi9zxuT7MglFbfvxe//B8
        R1Vc42XFVDMtxQXTDc5wMprwxK38P7Vi1dmrezYUuucqxPVV+63iLmVLKrFaPZvTnVfnQ5KO
        +VkvhelKLMUZiYZazEXFiQDruVpsrAMAAA==
X-CMS-MailID: 20220811131749eucas1p2456bbf8f8a2538b9ecf9f5be0092b643
X-Msg-Generator: CA
X-RootMTR: 20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094816eucas1p1890ceb4faebaf4f0cdbc9581d1308672@eucas1p1.samsung.com>
        <20220803094801.177490-14-p.raghav@samsung.com>
        <b73143fd-107d-177d-d647-f17a32b9423e@opensource.wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +==========
>> +dm-po2zone
>> +==========
>> +The dm-po2zone device mapper target exposes a zoned block device with a
>> +non-power-of-2(npo2) zone number of sectors as a power-of-2(po2) zone number
> 
> s/zone number of sectors/number of sectors per zone (zone size)
> 
>> +of sectors.
>> +The filesystems that support zoned block devices such as F2FS and BTRFS
>> +assume po2 zone size sectors as the kernel has traditionally only supported
>> +those devices. However, as the kernel now supports zoned block devices with
>> +npo2 zone size sectors, the dm-po2zone target can be used by the filesystems
>> +before adding native support.
> 
> filesystems will not "use" the target. The user has to set up the target first
> and the filesystem will run on top of it. Detail, but rewording this make it
> clear that this is not an automatic thing magically happening.
> 
> Not that your patch series is lacking f2fs and btrfs patches to check for the
> power of 2 zone size of the zoned device. Unless these checks are already in place ?
> 
btrfs already had these checks in place and f2fs patch to allow only po2
zone size was already merged by Jaegeuk.

7f262f737502 ("f2fs: ensure only power of 2 zone sizes are allowed")
>> +
>> +Partial mapping of the underlying device is not supported by this target.
>> +
>> +Algorithm
>> +=========
>> +The device mapper target maps the underlying device's zone size to the
>> +zone capacity and changes the zone size to the nearest po2 number of sectors.
>> +The gap between the zone capacity and the zone size is emulated in the target.
>> +E.g., a zoned block device with a zone size (and capacity) of 3M will have an
>> +equivalent target layout with mapping as follows:
>> +
>> +::
>> +
>> +  0M           3M  4M        6M 8M
>> +  |             |  |          |  |
>> +  +x------------+--+x---------+--+x-------  Target
>> +  |x            |  |x         |  |x
>> +   x               x             x
>> +   x               x             x
>> +   x              x             x
>> +   x             x             x
>> +  |x            |x            |x
>> +  +x------------+x------------+x----------  Device
>> +  |             |             |
>> +  0M           3M            6M
>> +
