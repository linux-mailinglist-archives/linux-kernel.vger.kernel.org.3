Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E606E59576A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiHPKCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiHPKCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:02:06 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF1FC877A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:02:41 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220816080235euoutp0144f491b0d112eddf954beab6ab8e5d5b~LxIMq31ck0597405974euoutp01e
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:02:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220816080235euoutp0144f491b0d112eddf954beab6ab8e5d5b~LxIMq31ck0597405974euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660636955;
        bh=w+UeNKFPkWuzxd2gXXq4NTrE0Bz4wmcfIlzmDBOFbwQ=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=RAR1wRHu/BOFrAZmorCEpSM25V699cyBQtLPd69h0FXvshEQxlSaKx/gjdVWQ20Cp
         +FQPly9vQ/mSkIcOax1fsW3h7PmR3/oPsL7/pbrf0qte37ScWjYTmwxnWdDAFtt+oF
         4yrusIBitn8qORdscYpwxOjswQhyn8Onn0Fp09Y8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220816080234eucas1p1944800b3870bef434c619543e727f2d8~LxIMQJt2H0475004750eucas1p1F;
        Tue, 16 Aug 2022 08:02:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DE.46.09580.A1F4BF26; Tue, 16
        Aug 2022 09:02:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220816080234eucas1p2ec04f60bad4888c708d7c57f5aab5d47~LxIL0Fflp2135521355eucas1p2u;
        Tue, 16 Aug 2022 08:02:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220816080234eusmtrp2222f44d8dffbb9c0cbd291bd2fceb90b~LxILy-Wxp1663716637eusmtrp2D;
        Tue, 16 Aug 2022 08:02:34 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-80-62fb4f1a8245
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D8.4F.09095.A1F4BF26; Tue, 16
        Aug 2022 09:02:34 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220816080234eusmtip2b83e83d28d6f473c7506bda77a4da005~LxILlzw4B1996419964eusmtip2c;
        Tue, 16 Aug 2022 08:02:34 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.18) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 16 Aug 2022 09:02:31 +0100
Message-ID: <dfb3bb5d-404c-90d9-5fa5-ee62639057bf@samsung.com>
Date:   Tue, 16 Aug 2022 10:02:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v10 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <snitzer@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <agk@redhat.com>
CC:     <linux-block@vger.kernel.org>, <Johannes.Thumshirn@wdc.com>,
        <bvanassche@acm.org>, <matias.bjorling@wdc.com>, <hare@suse.de>,
        <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>,
        <jaegeuk@kernel.org>, <pankydev8@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dm-devel@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Joel Granados <j.granados@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <d4735d9e-31b6-0872-82a7-acbbd0cb5af5@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.18]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87pS/r+TDJ4s0rVYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWuxZNInJYuXqo0wWT9bPYrb423UPKHFL2+LyrjlsFvOX
        PWW3mND2ldlizc2nLBYnbkk7CHhcvuLtsXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j52t91k9
        3u+7ChQ6Xe3xeZOcR/uBbqYA7igum5TUnMyy1CJ9uwSujEendzEX3OGqeN1zjLmB8TtbFyMn
        h4SAicSbMz2MXYxcHEICKxglXu89wwLhfGGU+Ny5FSrzmVFi44oTzDAtu5YuYoJILGeUmPPi
        ODtc1enD3cwQzi6gzIYORpAWXgE7ies/noO1swioSmw7/oYJIi4ocXLmExYQW1QgUmLN7rNA
        kzg4hAWyJSZ22ICEmQXEJW49mQ+2TUSggVFi+v4tYA6zwA8miS2fpjGBNLAJaEk0doL1cgq4
        SXxeEg/RqynRuv03O4QtL7H97RyoD5QkFrbdgQZArcTaY2fAHpAQeMYpsaJnE1TCRWLr7RNQ
        trDEq+Nb2CFsGYn/O+czQdjVEk9v/GaGaG5hlOjfuZ4N5AgJAWuJvjM5EDWOQD/eggrzSdx4
        KwhxD5/EpG3TmScwqs5CColZSF6eheSFWUheWMDIsopRPLW0ODc9tdg4L7Vcrzgxt7g0L10v
        OT93EyMwJZ7+d/zrDsYVrz7qHWJk4mA8xCjBwawkwiv44keSEG9KYmVValF+fFFpTmrxIUZp
        DhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBqZi6+OqnsE5F3y+qb/Xzxc7Ybyg0vGo2uoS
        n2tHXkQpfLCY95+9XfZC3znWBvGKF1XS4vsjjr41e2zKs2HSv3krpnhNzcjNOXXt85vJaaG7
        1Bn2vmCW3flZ26WlgmmOalz886X6p/W6du77ucm83WOGTtZzgasntLa9WnJP79rFxABBP5/a
        ALakXG3XHH+7Td2MP9wyJjRerfIvf6X7r+DFa2PbR8+Y7Wayp+beVPe++mnNv//OUe2/a11M
        tkjlLnyaEs3mWJywUTB24vLNWjtq5kYceVwwbfpuz03HHrUwyxpnFjX3zfvYtl7l+4qLO4/d
        /tSlKCh8+cQfri2317+5dLy910z2wXpth4TJP28osRRnJBpqMRcVJwIABKxREvgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsVy+t/xe7pS/r+TDHpfclusP3WM2WL13X42
        i2kffjJb/D57ntmitf0bk8Xed7NZLfYsmsRksXL1USaLJ+tnMVv87boHlLilbXF51xw2i/nL
        nrJbTGj7ymyx5uZTFosTt6QdBDwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we
        7/ddBQqdrvb4vEnOo/1AN1MAd5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGp
        kr6dTUpqTmZZapG+XYJexqPTu5gL7nBVvO45xtzA+J2ti5GTQ0LARGLX0kVMXYxcHEICSxkl
        Zj39zgyRkJH4dOUjO4QtLPHnWhdYg5DAR0aJWwvdIRp2MUqsunsPrIFXwE7i+o/nYDaLgKrE
        tuNvmCDighInZz5hAbFFBSIlHi5rAopzcAgLZEtM7LABCTMLiEvcejIf7AgRgQZGien7t4A5
        zAI/mCS2fJrGBLH5LZNE74p0kGY2AS2Jxk52EJNTwE3i85J4iDmaEq3bf7ND2PIS29/OgfpF
        SWJh2x2oh2slXt3fzTiBUXQWkutmITljFpJRs5CMWsDIsopRJLW0ODc9t9hQrzgxt7g0L10v
        OT93EyMwiWw79nPzDsZ5rz7qHWJk4mA8xCjBwawkwiv44keSEG9KYmVValF+fFFpTmrxIUZT
        YBBNZJYSTc4HprG8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQam
        ksR3Gy/v4Yy4Ivb65+78ouD3rY9SjepzNr5YckT9DktxhGi63AEODsHvPUs1/9v/NL1rrye1
        UScw8P8Ssd+3ZT9tmehls8RBj8dqttwiVzlJRfva5eZuU+/khwuvcDv99dKhRbsO1cSvqTYQ
        FHlQEPe/kPP72iLNEM5TKd5387vmdv2+F8jypObkbbcyvlWLUj7PW2i5IuDTWYGqd7vdn9h3
        /fjMcqL++C6Rn1MMNum6ve6awvP5wj2JGydl303/XLt/TsVmx9xK57PPO+t/L72ZvfHK7PO2
        6x7f78hawlPvxv1xyjpBC/fy6CPy29rvTnb5VXFIbtPdjTyfTh9a0eW7Nncql+Bttmrtvedu
        rlBiKc5INNRiLipOBACnkEk0qwMAAA==
X-CMS-MailID: 20220816080234eucas1p2ec04f60bad4888c708d7c57f5aab5d47
X-Msg-Generator: CA
X-RootMTR: 20220811143058eucas1p247291685ffff7a75186947fd30b5c13f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143058eucas1p247291685ffff7a75186947fd30b5c13f
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143058eucas1p247291685ffff7a75186947fd30b5c13f@eucas1p2.samsung.com>
        <20220811143043.126029-14-p.raghav@samsung.com>
        <bb4ab1f2-7e16-15a7-58b1-d37f6f3822fd@opensource.wdc.com>
        <b98ab80d-1bc0-a378-d438-09ef8b375836@samsung.com>
        <d4735d9e-31b6-0872-82a7-acbbd0cb5af5@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I think this is way better. But I would still reorganize this like this:
> 
> static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
> {
>         struct dm_po2z_target *dmh = ti->private;
>         int split_io_pos;
> 
>         bio_set_dev(bio, dmh->dev->bdev);
> 
>         if (op_is_zone_mgmt(bio_op(bio)))
>                 return dm_po2z_remap_sector(dmh, bio);
> 
>         if (!bio_sectors(bio))
>                 return DM_MAPIO_REMAPPED;
> 
>         /*
>          * Read operation on the emulated zone area (between zone capacity
>          * and zone size) will fill the bio with zeroes. Any other operation
>          * in the emulated area should return an error.
>          */
>         if (!bio_in_emulated_zone_area(dmh, bio, &split_io_pos))
>                 return dm_po2z_remap_sector(dmh, bio);
> 
>         if (bio_op(bio) == REQ_OP_READ) {
>                 if (split_io_pos > 0) {
>                         dm_accept_partial_bio(bio, split_io_pos);
>                         return dm_po2z_remap_sector(dmh, bio);
>                 }
>                 return dm_po2z_read_zeroes(bio);
>         }
> 
>         return DM_MAPIO_KILL;
> }
> 
> I find the code easier to follow this way.
> 
I agree. It is definitely easier to follow. I will make these changes
and send the next version soon.
> 
> 
