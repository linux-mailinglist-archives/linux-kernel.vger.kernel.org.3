Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901C851AD3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377288AbiEDSuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352734AbiEDSug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:50:36 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECEE140FE
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:46:59 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220504184655euoutp01f8a76b1eb9016c6e68878630c55f4220~r_1F6GIaK2538325383euoutp01t
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:46:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220504184655euoutp01f8a76b1eb9016c6e68878630c55f4220~r_1F6GIaK2538325383euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651690015;
        bh=QW3cLWpBJkzfWe1x2FW4quPvDQbAoy4RiBj5X+kWFa4=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=TmkYX3mqTZBp0Z+WZOfu42hwLPdLpFUluvxsT5DRrgv6El354pFj1MiHyC8Qea5ib
         6ldsOgMLp4vweCAvrjmoHeEJsUj/nlzvj2BLPooVglZTkFF1XJxUca0zOEKS6kvrEz
         VYHrulG2grOaJwDts50BZu8UNx8cO+573KfBFyR8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220504184655eucas1p1df3a8d11dd3d8a8de89a2064dc3afb6d~r_1FR7oCQ1842118421eucas1p1A;
        Wed,  4 May 2022 18:46:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C7.FF.09887.E1AC2726; Wed,  4
        May 2022 19:46:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220504184654eucas1p12690d7da7df67e21dc347b4c0f84f403~r_1EkTkjB2247422474eucas1p1W;
        Wed,  4 May 2022 18:46:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220504184654eusmtrp20e7d6549392a9adade0f308525738d82~r_1EjP-J33190631906eusmtrp2M;
        Wed,  4 May 2022 18:46:54 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-3a-6272ca1eb13e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.3A.09404.E1AC2726; Wed,  4
        May 2022 19:46:54 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220504184654eusmtip12c62d7628b73df7545fbbbdda5c4c2b1~r_1EVioUp2790327903eusmtip1I;
        Wed,  4 May 2022 18:46:54 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.170) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 4 May 2022 19:46:51 +0100
Message-ID: <61a72147-292f-b1d0-fbfd-5b34d71a69a0@samsung.com>
Date:   Wed, 4 May 2022 20:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH 04/16] block: allow blk-zoned devices to have
 non-power-of-2 zone size
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
In-Reply-To: <c76334a9-3d10-ed3c-f4d1-d856f67928e6@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.170]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7djP87pyp4qSDNYstbZYf+oYs8Xqu/1s
        FtM+/GS2OD31LJPFpP4Z7Ba/z55ntrjwo5HJYs+iSUwWK1cfZbJ4sn4Ws0XPgQ8sFn+77gHF
        Wh4yW/x5aGgx6dA1RounV2cxWey9pW1xedccNov5y56yW0xo+8pscWPCU0aLicc3s1qse/2e
        xeLELWkHCY/LV7w9/p1Yw+Yxsfkdu8f5extZPC6fLfXYtKqTzWNhw1Rmj81L6j1232xg8+ht
        fsfmsbP1PqvH+31X2TzWb7nK4rH5dLXHhM0bWT0+b5ILEIzisklJzcksSy3St0vgyli96hpz
        wWveipedX1gaGFdwdzFyckgImEhs/z6FDcQWEljBKLHlmVgXIxeQ/QXI3vCEFcL5zCgxe84V
        VpiOu+u+M0IkljNKPOlbyQRX1df4mhnC2cUoMefGJhaQFl4BO4kZT1cyg9gsAioSa468gYoL
        Spyc+QTMFhWIkJg26wzYIcICMRJruxeCxZkFxCVuPZkPtkFEYC6TROfMq+wgDrPAYyaJP4f3
        AjkcHGwCWhKNnewgDZwC1hLT9zxhhWjWlGjd/psdwpaXaN46mxniB2WJyTeuMEHYtRJrj50B
        mykhcJJLYtKRdlaQmRICLhIvZztD1AhLvDq+hR3ClpH4v3M+VG+1xNMbv5khelsYJfp3rmeD
        6LWW6DuTA1HjKPFveQtUmE/ixltBiHP4JCZtm848gVF1FlJQzELy8iwkH8xC8sECRpZVjOKp
        pcW56anFRnmp5XrFibnFpXnpesn5uZsYgSn59L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRFe56UF
        SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5kzM3JAoJpCeWpGanphakFsFkmTg4pRqYZi58tG3C
        TYMPPWwCK1fElkWyV5qut9+bu6wgi1/83Mpm94Dzpc9MFG5nNEhFJn51zz8ix2woHFu+QUtl
        5y2Fsmw3c9ul5mf0Npy7pWu85OvCO/Xfwxln+Ly4olGn+XjaJ1Wxhvccql90bmUvrFhne9T0
        bYZBf1zeiROnwxsVJE6xX1hb9FaoLf6P9I4ZZtkzrRXz5j4w0/6y1MnmAENb69EMxfN+bhJb
        +kX4PB4YM2wXF4x578+uzHc4+2KLiXR+qWtBQHxl/5knm8KmCEo9bEg9V/yxX7JnTuj1ZXpn
        umZZphe49NS3NW1+E/Uxr5F/Ghvb78UOh8XLZNqfHd1Q8TlCZqbivV51Ja2SECWW4oxEQy3m
        ouJEANddwlY4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsVy+t/xu7pyp4qSDLbc5LBYf+oYs8Xqu/1s
        FtM+/GS2OD31LJPFpP4Z7Ba/z55ntrjwo5HJYs+iSUwWK1cfZbJ4sn4Ws0XPgQ8sFn+77gHF
        Wh4yW/x5aGgx6dA1RounV2cxWey9pW1xedccNov5y56yW0xo+8pscWPCU0aLicc3s1qse/2e
        xeLELWkHCY/LV7w9/p1Yw+Yxsfkdu8f5extZPC6fLfXYtKqTzWNhw1Rmj81L6j1232xg8+ht
        fsfmsbP1PqvH+31X2TzWb7nK4rH5dLXHhM0bWT0+b5ILEIzSsynKLy1JVcjILy6xVYo2tDDS
        M7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy1i96hpzwWveipedX1gaGFdwdzFyckgI
        mEjcXfedsYuRi0NIYCmjxPF3x1ggEjISn658ZIewhSX+XOtigyj6yCix4PNyFghnF6NE7/td
        bCBVvAJ2EjOermQGsVkEVCTWHHnDAhEXlDg58wmYLSoQIfFg91lWEFtYIEZibfdCsDizgLjE
        rSfzmUCGigjMZZLonHkVbLWQwAdGifaXYNuYBR4zSfw5vBcowcHBJqAl0dgJVsMpYC0xfc8T
        VohBmhKt23+zQ9jyEs1bZzNDvKAsMfnGFSYIu1bi1f3djBMYRWchuW8WkjtmIRk1C8moBYws
        qxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJT2bZjP7fsYFz56qPeIUYmDsZDjBIczEoivM5L
        C5KEeFMSK6tSi/Lji0pzUosPMZoCA2kis5Rocj4wmeaVxBuaGZgamphZGphamhkrifN6FnQk
        CgmkJ5akZqemFqQWwfQxcXBKNTAtTAjSihFtZqmx0rh22ppv6bKiE/vvXxZKWBziovbov/r+
        eZzprgbh+3QOJ+ybcXLyJ9bpx58p/ym+H/efZxrLRqalZxKXtJVf5J23sK370OctJ3czXqi9
        l71r39RPJ16c2hkrWWV00OCkrKLxpNt7Lfj/h5dIGpUkMnQn+t8UiPi97MzECT6WGozvC68I
        FnDmhXpNMvjXZVNyfXKNUMdfC9WXLZ95v77+e6GVQ0pDh2vbJrusgxWOshNtF/dt5tCS+9X7
        MW3xxo+bTDb0KVvNP7xmdeKtZX83+Pa225g0Hno9MeaLo+xR8bvxazVC/OaaL9q3Olii/sX1
        vWcO6t8y8+WwdJD/UPCmVO6l/vZUJZbijERDLeai4kQApiWVyO4DAAA=
X-CMS-MailID: 20220504184654eucas1p12690d7da7df67e21dc347b4c0f84f403
X-Msg-Generator: CA
X-RootMTR: 20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a@eucas1p1.samsung.com>
        <20220427160255.300418-5-p.raghav@samsung.com>
        <c76334a9-3d10-ed3c-f4d1-d856f67928e6@suse.de>
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

Hi Hannes,
	Somehow your message did not go through the mailing list. Maybe you hit
reply instead of reply all?

I have added your reviewed-by tag in the other commits based on your
response. Thanks.

Anyway, my response to this email below:

On 2022-05-04 18:59, Hannes Reinecke wrote:
> On 4/27/22 09:02, Pankaj Raghav wrote:
>> zone size (%llu)\n",
>> -                disk->disk_name, zone->len);
>> +        if (zone->len == 0) {
>> +            pr_warn("%s: Invalid zoned device size",
>> +                disk->disk_name);
>>               return -ENODEV;
>>           }
>>             args->zone_sectors = zone->len;
>> -        args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
>> +        args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
> 
> This is a different calculation than the one you're using in the first
> patch. Can you please add a helper such that both are using the same
> calculation?
>
So this calculation is actually doing a roundup to the nearest zone
number operation and not just a division that is done in the block layer
helper such as bdev_zone_no(). Note the `zone->len - 1` added to the
capacity. This is done to take into account also the last unequal zone
size, if present.

Another thing to note is that block layer helpers cannot be used here
because at this point we haven't set the chunk sectors and we are still
in the revalidation callback.

Maybe some comments on top of this will help to avoid any confusion?
What do you think? And, I am not aware of any generic helper in math.h
that does this operation for both 32 and 64 bit architecture.

Regards,
Pankaj
