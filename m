Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F02254DF18
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376610AbiFPK3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiFPK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:28:58 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B725DA65
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:28:56 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220616102854euoutp01b96a8dcf4e8877af8fc81ce371d76a9c~5Exin2S9v1670116701euoutp01J
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:28:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220616102854euoutp01b96a8dcf4e8877af8fc81ce371d76a9c~5Exin2S9v1670116701euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655375334;
        bh=PeyUtqdx+y3aUFcAHiPZOAT0rWZohdyPt4V0xngM98M=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=M36uwlQ7b9i14CE3O4o4pnN0UH2w4xAKlP5wuabyFZW847WE8L019Kdbt5boRTVJ1
         ACTfZoL4Yr2PyaemwZCdTJcmXw3cF+o4p/lwZddtoZj0qYu3JjoGT+K7g0d53+jiBI
         fxZsMMsnivgskWcGnWkXVGz8YDUrjRTe98jBrb24=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220616102854eucas1p28d84911385a41f5d0c5b61050ff913f3~5ExiMhGOf1431814318eucas1p24;
        Thu, 16 Jun 2022 10:28:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5D.CE.10067.6E50BA26; Thu, 16
        Jun 2022 11:28:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220616102853eucas1p14f7747a8a646b23d68310ba45e0e4bed~5ExhxAD3R1626416264eucas1p1f;
        Thu, 16 Jun 2022 10:28:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220616102853eusmtrp2e56ce9309829d1d15872a0fef861251a~5Exhv54v-1339413394eusmtrp2h;
        Thu, 16 Jun 2022 10:28:53 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-e7-62ab05e6f479
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E3.A8.09095.5E50BA26; Thu, 16
        Jun 2022 11:28:53 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220616102853eusmtip1b59df1eccc24e951d0f3918da805ea15~5Exhk_UlM3259832598eusmtip1O;
        Thu, 16 Jun 2022 10:28:53 +0000 (GMT)
Received: from [192.168.1.12] (106.210.248.244) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 16 Jun 2022 11:28:46 +0100
Message-ID: <92c922ed-cc04-6e55-9c12-81a43332b318@samsung.com>
Date:   Thu, 16 Jun 2022 12:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.9.1
Subject: Re: [PATCH v7 13/13] dm: add non power of 2 zoned target
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, <hch@lst.de>,
        <snitzer@redhat.com>, <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>
CC:     <bvanassche@acm.org>, <linux-kernel@vger.kernel.org>,
        <jiangbo.365@bytedance.com>, <hare@suse.de>, <pankydev8@gmail.com>,
        <dm-devel@redhat.com>, <jonathan.derrick@linux.dev>,
        <gost.dev@samsung.com>, <dsterba@suse.com>, <jaegeuk@kernel.org>,
        <linux-nvme@lists.infradead.org>, <Johannes.Thumshirn@wdc.com>,
        <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <0480d917-94e5-20ab-514c-bb1374a8d9c4@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.244]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZduznOd1nrKuTDC78Z7VYfbefzWLah5/M
        Fr/Pnme2aG3/xmSx991sVosLPxqZLPYsmsRksXL1USaLJ+tnMVv0HPjAYvG36x5QrOUhs8Xe
        W9oWl3fNYbOYv+wpu8Wam09ZLN7emc5i0bbxK6ODkMflK94e/06sYfPYOesuu8fmFVoel8+W
        emxa1cnmsbBhKrPH5iX1HrtvNgDlW++zerzfd5XNY/2Wqywem09Xe3zeJOfRfqCbKYA/issm
        JTUnsyy1SN8ugSvj46lHzAWNvBVrpz9mamDcx9nFyMkhIWAi8WrLMaYuRi4OIYEVjBI3rlyF
        cr4wStw8vR7K+cwo8WTrbSCHA6zl10ptiPhyRommL3cQim5tf8EM4exilJh3/i0zSAevgJ3E
        jcn2IPtYBFQlJj//wgxi8woISpyc+YQFxBYViJBY2fqGBaRcWMBRoulEEkiYWUBc4taT+WDz
        RQRaGYHqb7CAOMwCLcwSXfsfgs1nE9CSaOxkB2ngBOq91NXFCNGsKdG6/Tc7hC0vsf3tHGaI
        B5Ql/u1khni/VmLtsTPsEPZMLompTfkQtovErmnnWCFsYYlXx7dA1chI/N8Jcg+IXS3x9MZv
        sHclBFoYJfp3rmeDmG8t0XcmB6LGUWJVyxNGiDCfxI23ghDX8ElM2jadeQKj6iykgJiF5ONZ
        SB6YheSBBYwsqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQIT6el/x7/sYFz+6qPeIUYm
        DsZDjBIczEoivGbBK5OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yZnbkgUEkhPLEnNTk0tSC2C
        yTJxcEo1MBXMO/v1jbl2bt31FxM2rJE9s0jl4VOrSYcvtfEnxIeIyq5h3qW3/F2zvmvslW+/
        /a5f253skZMo5MlbLVeyWWn+Ee7SQ4cuLraVe1H+aFt+2beTdVMfP3D2Mr044SsDo3i0KO+C
        228EdJvPsjXHX5y44eX6V6aqUQ4Ptuz3WF12I3Aea2JR5yQtpvubS6vCvHLz+pa+qbMP+OBw
        YrLGT84Jeb86l6samJXLbzt89lze6XeNie/qPnnqFPFPOVKXsFPpezP7lsXGS8/vydjYs+fl
        uxJp88XPi/YvzMifbcvDKFczPXP/yqs/72zV/lAyx3LKhe5TP/ddEKk0cuHV1/sgv7BlraDR
        /blskeeXHbVQYinOSDTUYi4qTgQAWSLBrBMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsVy+t/xu7pPWVcnGaxdpGax+m4/m8W0Dz+Z
        LX6fPc9s0dr+jcli77vZrBYXfjQyWexZNInJYuXqo0wWT9bPYrboOfCBxeJv1z2gWMtDZou9
        t7QtLu+aw2Yxf9lTdos1N5+yWLy9M53Fom3jV0YHIY/LV7w9/p1Yw+axc9Zddo/NK7Q8Lp8t
        9di0qpPNY2HDVGaPzUvqPXbfbADKt95n9Xi/7yqbx/otV1k8Np+u9vi8Sc6j/UA3UwB/lJ5N
        UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gx1OPmAsa
        eSvWTn/M1MC4j7OLkYNDQsBE4tdK7S5GLg4hgaWMEhtPnmXrYuQEistIfLrykR3CFpb4c60L
        LC4k8JFR4s9Bcwh7F6PE7LMFIHN4Bewkbky2BwmzCKhKTH7+hRnE5hUQlDg58wkLiC0qECHx
        adkEVpByYQFHiaYTSSBhZgFxiVtP5jOBnCAi0Moo8WbbLRYQh1mghVmia/9DZojjvjNKXHyz
        lQWkm01AS6KxE+w2TqBBl7q6GCEmaUq0bv/NDmHLS2x/O4cZ4kdliX87mSFeqZV4dX834wRG
        0VlIzpuF5I5ZSCbNQjJpASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMDks+3Yz807GOe9
        +qh3iJGJg/EQowQHs5IIr1nwyiQh3pTEyqrUovz4otKc1OJDjKbAMJrILCWanA9Mf3kl8YZm
        BqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUwruv15P3nP+Fga9/n0piq5
        d0yLv9ntkeDIX833rIrZjuGTKJfJPut3r5ju5Ijbn7gqM3Vl7hTm8iXhb+3fsa+xKs4IiWjY
        fvntrsRLK8zvHJV3WLW28Oiun4/fX98dLn9L6urtJI+e8wbRdtNZN/y4l3ljjdXMGRw69+w3
        9AaUW28zSPI6oXNJ4O5aofNT4xJqdsvvUH5tPvHhPOEjov4MYl9PB6571rO5ZVvEH6ktZ5Z8
        PF3+3M6k9gnzDCvDPxMKFt60eR3qKVzA3vTzSNCLTcrNEndCufR3hd9KShHo6r7zYul9/sL/
        8R9qKyZ9yZtzcNsWDoWXCz/pRQUsW2Tfkz5ZbUffnn5O38U5QYqflFiKMxINtZiLihMBLOYv
        9McDAAA=
X-CMS-MailID: 20220616102853eucas1p14f7747a8a646b23d68310ba45e0e4bed
X-Msg-Generator: CA
X-RootMTR: 20220615102011eucas1p220368db4a186181b1927dea50a79e5d4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615102011eucas1p220368db4a186181b1927dea50a79e5d4
References: <20220615101920.329421-1-p.raghav@samsung.com>
        <CGME20220615102011eucas1p220368db4a186181b1927dea50a79e5d4@eucas1p2.samsung.com>
        <20220615101920.329421-14-p.raghav@samsung.com>
        <0480d917-94e5-20ab-514c-bb1374a8d9c4@infradead.org>
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

On 2022-06-15 21:54, Randy Dunlap wrote:
> Hi--
> 
> On 6/15/22 03:19, Pankaj Raghav wrote:
> 
>> ---
>>  drivers/md/Kconfig                |   9 +
>>  drivers/md/Makefile               |   2 +
>>  drivers/md/dm-zone.c              |   9 +
>>  drivers/md/dm-zoned-npo2-target.c | 268 ++++++++++++++++++++++++++++++
>>  4 files changed, 288 insertions(+)
>>  create mode 100644 drivers/md/dm-zoned-npo2-target.c
>>
>> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
>> index 998a5cfdb..773314536 100644
>> --- a/drivers/md/Kconfig
>> +++ b/drivers/md/Kconfig
>> @@ -518,6 +518,15 @@ config DM_FLAKEY
>>  	help
>>  	 A target that intermittently fails I/O for debugging purposes.
>>  
>> +config DM_ZONED_NPO2
>> +	tristate "Zoned non power of 2 target"
> 
> 	         "Zoned non-power-of-2 target"
> 
>> +	depends on BLK_DEV_DM
>> +	depends on BLK_DEV_ZONED
>> +	help
>> +	A target that converts a zoned device with non power of 2 zone size to
> 
> 	                                           non-power-of-2 zone size to
> 
>> +	be power of 2. This is done by introducing gaps in between the zone
>> +	capacity and the power of 2 zone size.
> 
> All help text should be indented with one tab and 2 spaces
> according to Documentation/process/coding-style.rst.
> 
>> +
>>  config DM_VERITY
>>  	tristate "Verity target support"
>>  	depends on BLK_DEV_DM
> 
> [snip]
> 
>> +
>> +MODULE_DESCRIPTION(DM_NAME " non power 2 zoned target");
> 
>                                 non-power-of-2
> 
>> +MODULE_AUTHOR("Pankaj Raghav <p.raghav@samsung.com>");
>> +MODULE_LICENSE("GPL");
>> +
> 
Thanks Randy. Fixed.
