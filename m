Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA355AAE0E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiIBMFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbiIBMFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:05:15 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4B92ED6D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:05:06 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220902120504euoutp02ecebfcf0cfc59c24e8893ebf7fb07514~RCZxv67Wo0225102251euoutp02s
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 12:05:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220902120504euoutp02ecebfcf0cfc59c24e8893ebf7fb07514~RCZxv67Wo0225102251euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662120305;
        bh=ksjAwLWGNl6eTSiZxyGsY95CwqFsiCy8PT3NAtpouPk=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=ZdAULa+sVWkVAlKdMrAZldam0SB8LFmNKXQ7rPuMQQ2oMsEwWZD+KoixVKpPO17Uz
         qsHJc76ANkAMrCQ55CsUbey/jigu3/7RDvm8GZmlDTHgfiLv75u1SfyGRkZ5YdbE6Y
         HyR+ggnpkFMw9W0+r5o0ojEZN3QVH3IJwPhNjT5k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220902120504eucas1p124b40b28956f8aa1e5c36afa91283ea9~RCZxURROJ2730127301eucas1p1W;
        Fri,  2 Sep 2022 12:05:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C4.5E.19378.071F1136; Fri,  2
        Sep 2022 13:05:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220902120503eucas1p15a51efdda30e44ecc7b93e5e990e3249~RCZwyYJ0h0807808078eucas1p1i;
        Fri,  2 Sep 2022 12:05:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220902120503eusmtrp2b35aa3ab5c6b82570eaeb872404b2f55~RCZwxZ7ae0472204722eusmtrp2T;
        Fri,  2 Sep 2022 12:05:03 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-7e-6311f170f347
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.94.07473.F61F1136; Fri,  2
        Sep 2022 13:05:03 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220902120503eusmtip1ee0971ca79428ee096867b3b155cb72a~RCZwnOMVF0453604536eusmtip1-;
        Fri,  2 Sep 2022 12:05:03 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.27) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Sep 2022 13:05:02 +0100
Message-ID: <6906b295-f043-2f6c-8860-216b07ab86df@samsung.com>
Date:   Fri, 2 Sep 2022 14:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v12 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To:     <agk@redhat.com>, <snitzer@kernel.org>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <hch@lst.de>
CC:     <pankydev8@gmail.com>, <Johannes.Thumshirn@wdc.com>,
        <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <hare@suse.de>, <jaegeuk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <matias.bjorling@wdc.com>,
        <gost.dev@samsung.com>, <bvanassche@acm.org>,
        <linux-nvme@lists.infradead.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220823121859.163903-14-p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.27]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djP87oFHwWTDR60SlqsP3WM2WL13X42
        i2kffjJb/D57ntmitf0bk8Xed7NZLfYsmsRksXL1USaLJ+tnMVv87boHlLilbXF51xw2i/nL
        nrJbTGj7ymyx5uZTFosTt6QdBDwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we
        7/ddBQqdrvb4vEnOo/1AN1MAdxSXTUpqTmZZapG+XQJXxvFPT5kL2rkqtvx6ztzAOIOji5GT
        Q0LAROLNpI/MILaQwApGiY/rgOJcQPYXRon5+6YwQjifGSVWt7xlh+k4fvYCO0RiOaPEgRkv
        WOGqXs49zQbh7GSUWHv+AthgXgE7iRcP97GA2CwCKhKrf71lgogLSpyc+QQsLioQKbFm91mw
        FcIC2RJL+46D2cwC4hK3nswHqxcRKJS4O+kUE8gCZoFzTBI3OzqBVnNwsAloSTR2gtVzCthI
        fH7QywrRqynRuv031Bx5ie1v5zBDvKAkcXLZSiYIu1Zi7bEzUK/d45R49dsNZKSEgIvElpXQ
        MBKWeHV8C1SJjMT/nfOhWqslnt74zQxyjoRAC6NE/871bBC91hJ9Z3Igahwl9i84zwwR5pO4
        8VYQ4ho+iUnbpjNPYFSdhRQQs5A8PAvJA7OQPLCAkWUVo3hqaXFuemqxcV5quV5xYm5xaV66
        XnJ+7iZGYDo8/e/41x2MK1591DvEyMTBeIhRgoNZSYR36mGBZCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8yZkbEoUE0hNLUrNTUwtSi2CyTBycUg1MJc22xz3X+dumbHbez24vamzR+GpnUNZq
        3uKpR0texyz5Xix75t6sj7Nmh8nlrJnD28PIcv2jg9Lb3yKN5x3PXZx/J4Pv6Y3uVQaHXZ1L
        3uVt6F8dEDRxh8GmJXHXPZTjVvyzdfkyf4KNjt1n7nWc6mmbTCxf7Uqt/PrkoBqPdSin+v7Z
        q7ry6lYVK37/pLHT5/xT7z/m2Su9V1eenH/b4XLH+tbfNYs73guLRejqRzt8bij5L35ZlP8f
        f+1UV8NDbe0LMqOSGjTOG7+Y0Hb+x4tS96NVjVHRAdyN3tr7mWu1bH118vivnVqfkDunX+Hu
        /euPP7B2X5s3ef+uTqb8rcuVFbzn31FYVM8l8rpXiaU4I9FQi7moOBEAYdOZT/YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsVy+t/xu7r5HwWTDSa+N7FYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWuxZNInJYuXqo0wWT9bPYrb423UPKHFL2+LyrjlsFvOX
        PWW3mND2ldlizc2nLBYnbkk7CHhcvuLtsXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j52t91k9
        3u+7ChQ6Xe3xeZOcR/uBbqYA7ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
        JX07m5TUnMyy1CJ9uwS9jOOfnjIXtHNVbPn1nLmBcQZHFyMnh4SAicTxsxfYuxi5OIQEljJK
        TGuYzQyRkJH4dOUjO4QtLPHnWhcbRNFHRol9V+9CdexklPi4+yBYB6+AncSLh/tYQGwWARWJ
        1b/eMkHEBSVOznwCFhcViJR4uKwJLC4skC2xtO842AZmAXGJW0/mg8VFBAol7k46xQSygFng
        HJPEzY5OVohtBxglFi5fC5Th4GAT0JJo7ARr5hSwkfj8oJcVYpCmROv231BD5SW2v50D9Y6S
        xMllK5kg7FqJV/d3M05gFJ2F5L5ZSO6YhWTULCSjFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dL
        zs/dxAhMJduO/dy8g3Heq496hxiZOBgPMUpwMCuJ8E49LJAsxJuSWFmVWpQfX1Sak1p8iNEU
        GEgTmaVEk/OBySyvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoHp
        qGkqe+Yrn+lXVaa525ofc1W4/nrj6bKDr7mfamjvjLOb0NlZoX4sLfbrwgkC4oUtenYTJab7
        3TieraZYa6Fd4x7ua/VM49pZ9lmVNjq/9e8xFM1ctGC1QmVH9Hq2aTucI/sj3GRPXNTn7vvC
        3+Pk0plok273/kri8fQ/1dws889VXnH8Uit8VTTw1Ym5XK51ztxsS/Tkb3T1Bp1NXFbyR22i
        8dwzK7/9UZlxRzX2X0Yc14KGgzf7TA0em1x+dmNbv95EYfHC+KgLniqrI5odVCe+4DIUvOT+
        5VC2yiz/ZzVl9YpRDQdDnqp/E3SxDnJelyDX56U4X+1U2b+XcYwTl9yzfOEqUb7jcv/lLiWW
        4oxEQy3mouJEAH4bd6euAwAA
X-CMS-MailID: 20220902120503eucas1p15a51efdda30e44ecc7b93e5e990e3249
X-Msg-Generator: CA
X-RootMTR: 20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de
References: <20220823121859.163903-1-p.raghav@samsung.com>
        <CGME20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de@eucas1p1.samsung.com>
        <20220823121859.163903-14-p.raghav@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-23 14:18, Pankaj Raghav wrote:

> +static int dm_po2z_iterate_devices(struct dm_target *ti,
> +				   iterate_devices_callout_fn fn, void *data)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +	sector_t len = dmh->nr_zones * dmh->zone_size;
> +
> +	return fn(ti, dmh->dev, 0, len, data);
> +}
> +
> +static struct target_type dm_po2z_target = {
> +	.name = "po2zone",
> +	.version = { 1, 0, 0 },
> +	.features = DM_TARGET_ZONED_HM | DM_TARGET_EMULATED_ZONES,

This target also supports DM_TARGET_NOWAIT feature flag. I will add it in
the next version.

> +	.map = dm_po2z_map,
> +	.end_io = dm_po2z_end_io,
> +	.report_zones = dm_po2z_report_zones,
> +	.iterate_devices = dm_po2z_iterate_devices,
> +	.module = THIS_MODULE,
> +	.io_hints = dm_po2z_io_hints,
> +	.ctr = dm_po2z_ctr,
> +};
> +
> +static int __init dm_po2z_init(void)
> +{
> +	return dm_register_target(&dm_po2z_target);
> +}
> +
> +static void __exit dm_po2z_exit(void)
> +{
> +	dm_unregister_target(&dm_po2z_target);
> +}
> +
> +/* Module hooks */
> +module_init(dm_po2z_init);
> +module_exit(dm_po2z_exit);
> +
> +MODULE_DESCRIPTION(DM_NAME "power-of-2 zoned target");
> +MODULE_AUTHOR("Pankaj Raghav <p.raghav@samsung.com>");
> +MODULE_LICENSE("GPL");
> +
