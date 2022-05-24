Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B10532D90
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiEXPcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiEXPcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:32:48 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B2B57144
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:32:42 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220524153238euoutp02d4d0048e8145d002b5615672d9383a01~yFFK_Ib263109131091euoutp02x
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:32:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220524153238euoutp02d4d0048e8145d002b5615672d9383a01~yFFK_Ib263109131091euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653406358;
        bh=NfPLXa8MzeCFzn7Do+5e5emy4Tpw+uyG0dyEtdIcNM8=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=l10lKUkJvBSsIZLiWh2zg+F516W32viZeEejOMZwFhpxfyYhEJPs8L5+P9MsFMP8a
         AAf0J0lavgEI0xnlzZm9KL7xVx0MslYQU2KYXnHAKU7LB4OnJCLecb7caoPSuWvQmd
         PiK7uF7UEB101nIorMcxI6xjl1oTRy7kcTNI7xhw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220524153237eucas1p21713359205fa91bff66c156a8006e9f3~yFFKHPzAz1196811968eucas1p2X;
        Tue, 24 May 2022 15:32:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5E.51.10260.59AFC826; Tue, 24
        May 2022 16:32:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220524153237eucas1p112db24d3a714f392b11ca536f8ad02fc~yFFJt-Xdb1038610386eucas1p13;
        Tue, 24 May 2022 15:32:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220524153237eusmtrp1cdbe1017ebc6f3ec63d9d497e5476fed~yFFJpeED73015730157eusmtrp1C;
        Tue, 24 May 2022 15:32:37 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-03-628cfa95c0ee
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.89.09404.59AFC826; Tue, 24
        May 2022 16:32:37 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220524153237eusmtip2b3fb7136966530549b550fb45623a334~yFFJeMCmc3163231632eusmtip2F;
        Tue, 24 May 2022 15:32:37 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.20) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 24 May 2022 16:32:34 +0100
Message-ID: <6e409447-be78-f189-231f-f39b1e50b91e@samsung.com>
Date:   Tue, 24 May 2022 17:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.9.1
Subject: Re: [PATCH v5 5/7] null_blk: allow non power of 2 zoned devices
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
CC:     kernel test robot <lkp@intel.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <snitzer@redhat.com>, <damien.lemoal@opensource.wdc.com>,
        <hare@suse.de>, <Johannes.Thumshirn@wdc.com>,
        <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <linux-nvme@lists.infradead.org>, <dm-devel@redhat.com>,
        <dsterba@suse.com>, <jiangbo.365@bytedance.com>,
        <linux-kernel@vger.kernel.org>, <gost.dev@samsung.com>,
        <linux-block@vger.kernel.org>, <jaegeuk@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <Yoz4PsQjWzVxz+YO@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.20]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7djPc7pTf/UkGbw8amCx+m4/m8Xvs+eZ
        Lfa+m81qceFHI5PFnkWTmCxWrj7KZPFk/Sxmi54DH1gs/nbdY7I4232N0WLvLW2Ly7vmsFnM
        X/aU3eJV8yM2iydT9rNZ3JjwlNGifeVTNou2jV8ZHYQ8/p1Yw+axeM9LJo/LZ0s9Nq3qZPPo
        nv2PxWPzknqPF5tnMnrsvtnA5rGz9T6rx/t9V9k81m+5CpQ8Xe3xeZOcR/uBbqYAvigum5TU
        nMyy1CJ9uwSujN9zPzAVnBSoeLopoYHxIW8XIyeHhICJxJPJH5m6GLk4hARWMEq0P/zPAuF8
        YZSY//YqVOYzo8TEI5/ZYVp+73rFDpFYDpT4f5EZrury6p2sEM4uRomHa14xgrTwCthJXJyy
        B8xmEVCV6LvznQkiLihxcuYTFhBbVCBCYmXrGzBbWMBDovXUHbB1zALiEreezAerFxHQlNh4
        cDXYNmaBN8wSGw6uBGrg4GAT0JJo7ASr5xQwlTg4dzEjRK+mROv231Bz5CW2v53DDFIuIaAk
        se2XCcQ3tRJrj50B+0ZCoI9L4veLY0wQCReJmVNmQ9nCEq+Ob4F6X0bi9OQeFgi7WuLpjd/M
        EM0tjBL9O9ezQSywlug7kwNR4yjx/eVdqDCfxI23ghDn8ElM2jadeQKj6iykkJiF5ONZSD6Y
        heSDBYwsqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQLT6Ol/x7/uYFzx6qPeIUYmDsZD
        jBIczEoivClhPUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4
        OKUamJQ9j3U5K5/hK34lqH1q5Y5S2zUpjEW/Vjp48m+9f5z//6/Vr+5q8uracR/RdzLsCNh7
        KDptWvWh3hbGjE8Sd48brd5yNLXKQ/122o25SbOfH4kKWRig3WGZ8N7qQ3Xu76PTggWtzq1v
        L8t9kRbnYekh+c6MrdT/7xSRCwtuOmTY7Erv2/jg64RJO61k9zornWlSLrdPvqUg8/zipMRJ
        qlZ/2pL+1SXo705/5CJ4TTBoVVfGzfjNRdz30nfVqv+8/fvK24Qrv9osFy+bIfppVu6XJBN7
        6ebrgS72fS/qL86c/2pH+jVroVMZ7/SvG8uIrLisrRuwY6/G9sycto+pASydUnL7U8/GXP0Z
        xLnRTomlOCPRUIu5qDgRAJlvqloSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsVy+t/xe7pTf/UkGbQ2ClmsvtvPZvH77Hlm
        i73vZrNaXPjRyGSxZ9EkJouVq48yWTxZP4vZoufABxaLv133mCzOdl9jtNh7S9vi8q45bBbz
        lz1lt3jV/IjN4smU/WwWNyY8ZbRoX/mUzaJt41dGByGPfyfWsHks3vOSyePy2VKPTas62Ty6
        Z/9j8di8pN7jxeaZjB67bzaweexsvc/q8X7fVTaP9VuuAiVPV3t83iTn0X6gmymAL0rPpii/
        tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4/fcD0wFJwUq
        nm5KaGB8yNvFyMkhIWAi8XvXK3YQW0hgKaPEzDVaEHEZiU9XPrJD2MISf651sXUxcgHVfGSU
        2DFhIjOEs4tRYsb5eWBVvAJ2Ehen7GEEsVkEVCX67nxngogLSpyc+YQFxBYViJD4tGwCK4gt
        LOAh0XrqDlgvs4C4xK0n88HqRQQ0JTYeXA22gFngDbPEhoMrWSC2TWWS6Dl9AugODg42AS2J
        xk6wZk4BU4mDcxczQgzSlGjd/htqqLzE9rdzmEHKJQSUJLb9MoH4plbi1f3djBMYRWchOW8W
        kjNmIZk0C8mkBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJTz7ZjP7fsYFz56qPeIUYm
        DsZDjBIczEoivClhPUlCvCmJlVWpRfnxRaU5qcWHGE2BYTSRWUo0OR+Y/PJK4g3NDEwNTcws
        DUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpg2h4TKFpwxLb/654zLw43v9e+LOSRK
        iy9Yf8HWI++QdipvTtCrwhU2/z/xntjZV6rJVvZQUyosUvXD4Sr33y8b43yE/k8zM+1ddubD
        Ec5wu5DH7xeZWshEzlO4Jnv81rqIZXl/T7rX8Pxqyno3aV3jwb5/xp90VX54nVhbOpXRwYzZ
        5d6WosNvZwbbbn/VtaOS65rTY8eyD69TOfdy9a8R3yC/d8Jyjft9eQJvWo2iko7w3nLv5Vh8
        dNpNtnUSUyrEzs3JuvagS2mte/1HNReVxk+XdSxWhkv5XakV0v0nkX9g07XynYfnxPQ+mCCa
        tO9Fc6bsjqkdMelLK08ELlY3+exy6n6gyb/l7Odvq81XYinOSDTUYi4qTgQA4f3IIsYDAAA=
X-CMS-MailID: 20220524153237eucas1p112db24d3a714f392b11ca536f8ad02fc
X-Msg-Generator: CA
X-RootMTR: 20220524024108eucas1p26a6384cd77f143bb0fa628f01866e0a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220524024108eucas1p26a6384cd77f143bb0fa628f01866e0a0
References: <20220523161601.58078-6-p.raghav@samsung.com>
        <CGME20220524024108eucas1p26a6384cd77f143bb0fa628f01866e0a0@eucas1p2.samsung.com>
        <202205241034.izkLMTcH-lkp@intel.com>
        <7656fdc2-0511-722e-de6a-c2a2460cb048@samsung.com>
        <Yoz4PsQjWzVxz+YO@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SCC_BODY_URI_ONLY,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/22 17:22, Nathan Chancellor wrote:
>>>         git remote add linux-review https://protect2.fireeye.com/v1/url?k=081be8db-5780d026-081a6394-000babff317b-d12fdca0fccd0493&q=1&e=5ef82219-ef70-445f-a7d0-0ae0a30be69f&u=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux
>>>         git fetch --no-tags linux-review Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220524-011616
>>>         git checkout 3d3c81da0adbd40eb0d2125327b7e227582b2a37
>>>         # save the config file
>>>         mkdir build_dir && cp config build_dir/.config
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>
>>>>> ERROR: modpost: "__hexagon_umoddi3" [drivers/block/null_blk/null_blk.ko] undefined!
>>
>> I am able to apply my patches cleanly against next-20220523, build it
>> without any errors with GCC and boot into it in my x86_64 machine. Not
>> sure why this error is popping up.
> 
> Do a 32-bit build and you'll see it. With GCC 12.1.0, ARCH=i386
> defconfig + CONFIG_BLK_DEV_NULL_BLK=y + CONFIG_BLK_DEV_ZONED=y
> reproduces it for me:
> 
> $ make -skj"$(nproc)" ARCH=i386 defconfig menuconfig all
> ld: drivers/block/null_blk/zoned.o: in function `null_init_zoned_dev':
> zoned.c:(.text+0x112e): undefined reference to `__umoddi3'
> ...
> 
Ah.. I didn't see anything about 32 bit ARCH in the email so it didn't
strike to me that was the problem. It said ARCH=hexagon and I had no
idea what it was. Thanks for reproducing it.
> roundup() does a plain division with a 64-bit dividend, which will cause
> issues with 32-bit architectures. I suspect that you should really be
> using DIV_ROUND_UP_SECTOR_T() for the nr_zones calculation or maybe one
> of the other rounding macros in include/linux/math.h but I am not sure.
> 
That must be it. I will fix it. Thanks Nathan.
> Cheers,
> Nathan
