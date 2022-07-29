Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4811E584D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiG2IBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbiG2IBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:01:03 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39082F65F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:01:00 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220729080058euoutp021253d53a6dce3a1f82b9d80f0aedcce1~GPfptluPq2119521195euoutp020
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:00:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220729080058euoutp021253d53a6dce3a1f82b9d80f0aedcce1~GPfptluPq2119521195euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659081658;
        bh=E6lXkBi5RBzNBG22b6pYLRtecimhvNbXZsiuxzLw5pw=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=gdJ6KwEhv6DuwNkrdPCqMEWHOf+aMrF8tMchjUNG4c3Yx5hcBP3ZGD0GEbVG7hiOh
         9FpzDFJg6Ylbd2g+cW5Si+pzUevBRJLRToCPvKBkOkpLPoCz1ceL6pGm33f3VLak/v
         +lPeOSpYI4qElmb8VJwD9aHLaKU0bPqs0cvbCzvs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220729080057eucas1p2bf1e6dbfb1801a86419b17785cb129d3~GPfpOczkL1743317433eucas1p27;
        Fri, 29 Jul 2022 08:00:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7C.D6.10067.9B393E26; Fri, 29
        Jul 2022 09:00:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220729080057eucas1p2d3ab499ae1905a2a1df51a4a81a01723~GPfo06HdV1787517875eucas1p2y;
        Fri, 29 Jul 2022 08:00:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220729080057eusmtrp2c7bf9e55abbeacd657be9b783f9d7b88~GPfoz63Zy1448014480eusmtrp24;
        Fri, 29 Jul 2022 08:00:57 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-a0-62e393b96c7d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CF.03.09038.9B393E26; Fri, 29
        Jul 2022 09:00:57 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220729080057eusmtip1b1ab989d52f0805ddccea4b804ada970~GPfoqr6xS2228922289eusmtip1g;
        Fri, 29 Jul 2022 08:00:57 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.8) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 29 Jul 2022 09:00:54 +0100
Message-ID: <3f817b2f-ee25-c643-8d7a-aa0b543b4ca6@samsung.com>
Date:   Fri, 29 Jul 2022 10:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v8 07/11] dm-zoned: ensure only power of 2 zone sizes
 are allowed
Content-Language: en-US
To:     <dsterba@suse.cz>, <damien.lemoal@opensource.wdc.com>,
        <hch@lst.de>, <axboe@kernel.dk>, <snitzer@kernel.org>,
        <Johannes.Thumshirn@wdc.com>, <matias.bjorling@wdc.com>,
        <gost.dev@samsung.com>, <linux-kernel@vger.kernel.org>,
        <hare@suse.de>, <linux-block@vger.kernel.org>,
        <pankydev8@gmail.com>, <bvanassche@acm.org>, <jaegeuk@kernel.org>,
        <dm-devel@redhat.com>, <linux-nvme@lists.infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220728121548.GE13489@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.8]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7djP87o7Jz9OMmj/am6x+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLxb+/s1jsWTSJyWLl6qNMFk/Wz2K2+Nt1j8li7y1ti8u75rBZzF/2lN1i
        QttXZosbE54yWqy5+ZTF4sQtaQcBj8tXvD12zrrL7nH5bKnHplWdbB6bl9R77L7ZwOaxs/U+
        q8f7fVfZPM4sOMLusfl0tcfnTXIe7Qe6mQJ4orhsUlJzMstSi/TtErgyOk6kFUzirHh8+wNr
        A+ME9i5GDg4JAROJHz9Yuhi5OIQEVjBKtJ84zQjhfGGUON9whQnC+cwoMbH1A5DDCdax9Psf
        NojEckaJN/fXscFVvTh2HaplJ6NEw4pzjCAtvAJ2Em+aDrKB2CwCqhLfzv5ihYgLSpyc+YQF
        xBYViJRYs/ssO4gtLBAusQyql1lAXOLWk/lgQ0UE9jFLvJ35nxnkcjYBLYnGTrB6TgFjiZ75
        s1gg6jUlWrf/Zoew5SW2v53DDHG2okT/9w1sEHatxNpjZ9hBZkoI3OOUWPJvHtRvLhInvk1m
        gbCFJV4d38IOYctI/N85H6qmWuLpjd/MEM0tjBL9O9ezQYLSWqLvTA5EjaPE/Yl7GSHCfBI3
        3gpC3MMnMWnbdGaIMK9ER5vQBEaVWUghMQvJx7OQfDMLyTcLGFlWMYqnlhbnpqcWG+WllusV
        J+YWl+al6yXn525iBCbG0/+Of9nBuPzVR71DjEwcjIcYJTiYlUR4BQIeJwnxpiRWVqUW5ccX
        leakFh9ilOZgURLnTc7ckCgkkJ5YkpqdmlqQWgSTZeLglGpg2r04cnd84ycBC/c/ttmsR9fa
        3Q5eeOgt93GOd10sXb3H/jzKjbwuZfWb6+Bcl21Cz1bXpq8oDovv8BDJYDBUdVysHbBpejGX
        RHrl0hD7gN2NNb79FuZBL27t1LVYt+DlzZ+6i418zx9L/rU4WTB9w9HMHzHaHhKc6+KdVlx4
        sfANY6+q4fQd0W/j6i3qfX+/yM/1awucdX76bvcUl/VXcp6trbcUD3Pz6NG7mcbQeO38kqal
        eQuvnvm7WZLL86xfd/TB80dqlxjfOjhleYb/xpcmO1KfXtfrfmy95J0Jz5vvFnql19dP9VFY
        /9gzVtK+9eiqnofJqV+cdkxz2Lj4aWqi+Sq7q7wCGh/WqqhUK7EUZyQaajEXFScCAHOQKr37
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsVy+t/xu7o7Jz9OMlhzSs5i9d1+NotpH34y
        W/w+e57ZYu+72awWi39/Z7HYs2gSk8XK1UeZLJ6sn8Vs8bfrHpPF3lvaFpd3zWGzmL/sKbvF
        hLavzBY3JjxltFhz8ymLxYlb0g4CHpeveHvsnHWX3ePy2VKPTas62Tw2L6n32H2zgc1jZ+t9
        Vo/3+66yeZxZcITdY/Ppao/Pm+Q82g90MwXwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY
        6hkam8daGZkq6dvZpKTmZJalFunbJehldJxIK5jEWfH49gfWBsYJ7F2MnBwSAiYSS7//Yeti
        5OIQEljKKNF8cSEjREJG4tOVj1BFwhJ/rnVBFX1klLi3dBkjhLOTUeLooousIFW8AnYSb5oO
        soHYLAKqEt/O/oKKC0qcnPmEBcQWFYiUeLisiQnEFhYIl5j8/COYzSwgLnHryXwmkKEiAvuY
        Jd7O/M8MseEFo8ShF/uBujk42AS0JBo7wU7iFDCW6Jk/iwWiWVOidftvdghbXmL72znMEGcr
        SvR/38AGYddKvLq/m3ECo8gsJDfNQrJ7FpJRs5CMWsDIsopRJLW0ODc9t9hIrzgxt7g0L10v
        OT93EyMwdWw79nPLDsaVrz7qHWJk4mA8xCjBwawkwisQ8DhJiDclsbIqtSg/vqg0J7X4EKMp
        MGAmMkuJJucDk1deSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOT
        6DTGf5ftH7+OsephStV+cKTS4nEQn9TzjrIoNU4dz7f+dkavC9ZlRCR1qRSZFYn7PGx651h+
        KDe2bYdnffqS6Ii7H8V3OYR+7E/76dUjWrizwcd99uzZIe9Kg1pWsYXnCF/y0z6dmMxvv7ah
        4SLrwwUcp4XnWMw+dDNjkV34wXy/L2+yz7uZbNqu8KCR9V7gmp4HImYSTfuef7zwtHDi3Iez
        JrdvVHKc+krg646mpayv/fSSHwYJJ8b32v7X26UroOF0OHeaUorlNVXRO2zz+By6M6zlzt6p
        NipMfvPPTC/kPPcy4ynLlY3iE6ucNoXp8HhyzJ8bvrJiw6Qnk6pWLN62qDFxaXViwkRxFiWW
        4oxEQy3mouJEAGk4zn+mAwAA
X-CMS-MailID: 20220729080057eucas1p2d3ab499ae1905a2a1df51a4a81a01723
X-Msg-Generator: CA
X-RootMTR: 20220727162253eucas1p1a5912e0494f6918504cc8ff15ad5d31f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162253eucas1p1a5912e0494f6918504cc8ff15ad5d31f
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162253eucas1p1a5912e0494f6918504cc8ff15ad5d31f@eucas1p1.samsung.com>
        <20220727162245.209794-8-p.raghav@samsung.com>
        <20220728121548.GE13489@twin.jikos.cz>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-28 14:15, David Sterba wrote:
> On Wed, Jul 27, 2022 at 06:22:41PM +0200, Pankaj Raghav wrote:
>> --- a/drivers/md/dm-zoned-target.c
>> +++ b/drivers/md/dm-zoned-target.c
>> @@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>>  				return -EINVAL;
>>  			}
>>  			zone_nr_sectors = bdev_zone_sectors(bdev);
>> +			if (!is_power_of_2(zone_nr_sectors)) {
>> +				ti->error = "Zone size is not power of 2";
> 
> This could print what's the value of zone_nr_sectors
Ok. I will rephrase based on Damien's comment and add the
zone_nr_sectors to be included. Thanks.
> 
>> +				return -EINVAL;
>> +			}
>>  			zoned_dev->zone_nr_sectors = zone_nr_sectors;
>>  			zoned_dev->nr_zones = bdev_nr_zones(bdev);
>>  		}
>> @@ -804,6 +808,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>>  			return -EINVAL;
>>  		}
>>  		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
>> +		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
>> +			ti->error = "Zone size is not power of 2";
> 
> Same
> 
>> +			return -EINVAL;
>> +		}
>>  		zoned_dev->nr_zones = bdev_nr_zones(bdev);
>>  	}
>>  
>> -- 
>> 2.25.1
