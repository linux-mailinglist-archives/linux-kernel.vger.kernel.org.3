Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51189583E65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiG1MMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiG1ML5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:11:57 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F966A4A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:11:56 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220728121154euoutp0131a01e52093d008ebac5175d135153f5~F-RdownXo0182701827euoutp01A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:11:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220728121154euoutp0131a01e52093d008ebac5175d135153f5~F-RdownXo0182701827euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659010314;
        bh=ReW6TWWOLPxwvSvlUCJFXEfk/gXldI/9UdqGISndCwA=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=qmQj3MZ5HKaUbfeJEsfGJMDgozkSCf4sR1+5nYtdVwJOxgt1sFtH5jdVbAygUBAY3
         85VbrMNOItQR1kaSVccsPRgxWcQ5N8u1a3aEDoNtBVL3GZyU3uwIV8g5pNLr8sNZn3
         uwvV77j8NZqODNuNDKtRdtnR8urlb9woKpS0JVAA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220728121154eucas1p2a483eaeef676eb995683b016b0c0a0c2~F-RdCaIaK2051520515eucas1p2s;
        Thu, 28 Jul 2022 12:11:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EE.96.10067.90D72E26; Thu, 28
        Jul 2022 13:11:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220728121153eucas1p2608d9935422fdb31c3a99a4ea2e765ff~F-RcirRNq2057020570eucas1p2D;
        Thu, 28 Jul 2022 12:11:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220728121153eusmtrp2f526d169df0fc66fd0d18be8b5c1a050~F-RcgtnQX2735727357eusmtrp2u;
        Thu, 28 Jul 2022 12:11:53 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-ce-62e27d09b17a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 11.F4.09095.90D72E26; Thu, 28
        Jul 2022 13:11:53 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220728121153eusmtip125d7a9b3b36b4c1ae55cbba9c4f02230~F-RcWQT1O3030030300eusmtip1X;
        Thu, 28 Jul 2022 12:11:53 +0000 (GMT)
Received: from [106.110.32.100] (106.110.32.100) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 28 Jul 2022 13:11:52 +0100
Message-ID: <eed7d9ee-fd7f-e57c-598e-909dbb0d2380@samsung.com>
Date:   Thu, 28 Jul 2022 14:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/11] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        <damien.lemoal@opensource.wdc.com>, <hch@lst.de>,
        <axboe@kernel.dk>, <snitzer@kernel.org>,
        <Johannes.Thumshirn@wdc.com>
CC:     <matias.bjorling@wdc.com>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>,
        <linux-block@vger.kernel.org>, <pankydev8@gmail.com>,
        <jaegeuk@kernel.org>, <dm-devel@redhat.com>,
        <linux-nvme@lists.infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <7984b969-9025-6b31-2645-da08daeefafb@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djPc7pctY+SDBZOY7RYfbefzWLah5/M
        Fr/Pnme22PtuNqvFnkWTmCxWrj7KZPFk/Sxmi79d95gs9t7Stri8aw6bxfxlT9ktJrR9Zba4
        MeEpo8Wam09ZLE7cknbg97h8xdtj56y77B6Xz5Z6bFrVyeaxeUm9x+6bDWweO1vvs3q833cV
        KHS62uPzJjmP9gPdTAHcUVw2Kak5mWWpRfp2CVwZe9/fYS2YL14x+e1klgbGycJdjJwcEgIm
        EhcnvGPpYuTiEBJYwSjx+EULE4TzhVGi6+cPqMxnRonN+xexwLS86/rNCJFYzijx7/cuNriq
        3a1roPp3M0r8vzGPvYuRg4NXwE7iU5MmiMkioCpxqSEQZBCvgKDEyZlPwIaKCkRKrNl9lh3E
        FhaIl/hxfBEbiM0sIC5x68l8sJEiAkuBlt2+CLaMWWAGk8Txy6vYQIayCWhJNHaCreIUsJa4
        fL0coldTonX7b3YIW16ieetsZogHlCQmzLvPBmHXSqw9doYdZKSEwDNOibWPdkAVuUg82f6V
        EcIWlnh1fAs7hC0j8X8nyEEgdrXE0xu/mSGaWxgl+neuB7tHAuiIvjM5EDWOEgteP2eECPNJ
        3HgrCHEPn8SkbdOZJzCqzkIKillIXp6F5IVZSF5YwMiyilE8tbQ4Nz212CgvtVyvODG3uDQv
        XS85P3cTIzANnv53/MsOxuWvPuodYmTiYDzEKMHBrCTCmxB9P0mINyWxsiq1KD++qDQntfgQ
        ozQHi5I4b3LmhkQhgfTEktTs1NSC1CKYLBMHp1QD0+pz82Ku6OckvN0X+9r+5zFldneDnKPe
        20oOXHz/M+ei3jp55W3q0ZkJV1/YttQqv3fTd3KdmMKp/oLpYYN7NMf2J79288/MYLDs55tR
        FWQdGx1m19uiat3xZee+vZp5fy5xnFfYZdt9LalR27Ow8tEr6xdW/Ln+giJ6glnR7Ffb1t6c
        siW260jGnXAZniLJm8pGwtxRlybmJD6se3z24cNTu7Xmz+h4+P+NzvTH+rOcFm1c4JJ1I/va
        16CnDKfPnrGf6vRh97986Uuv/Ztm7ua6xvHWbf5Uh0mWqru2bnx+mW9/SdLRm3+lZ3bmtS8W
        2n5NnyNpZ/LXW299bd63mMdP2/RlTouvyZzpDD9vTFBiKc5INNRiLipOBABWBeAm8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsVy+t/xu7qctY+SDDZclbZYfbefzWLah5/M
        Fr/Pnme22PtuNqvFnkWTmCxWrj7KZPFk/Sxmi79d95gs9t7Stri8aw6bxfxlT9ktJrR9Zba4
        MeEpo8Wam09ZLE7cknbg97h8xdtj56y77B6Xz5Z6bFrVyeaxeUm9x+6bDWweO1vvs3q833cV
        KHS62uPzJjmP9gPdTAHcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2
        Kak5mWWpRfp2CXoZe9/fYS2YL14x+e1klgbGycJdjJwcEgImEu+6fjN2MXJxCAksZZT40vqa
        DSIhI/Hpykd2CFtY4s+1LjaIoo+MEhse3WKFcHYzSqx6u4y5i5GDg1fATuJTkyaIySKgKnGp
        IRCkl1dAUOLkzCcsILaoQKTEw2VNTCC2sEC8xI/ji8B2MQuIS9x6Mp8JZKQIyBFzZj4Bu4hZ
        YAaTxPHLq8CqhAQ+MEp0HpUFWcAmoCXR2MkOYnIKWEtcvl4OMUdTonX7b3YIW16ieetsZoj7
        lSQmzLsP9VetxKv7uxknMIrOQnLeLCRnzEIyahaSUQsYWVYxiqSWFuem5xYb6hUn5haX5qXr
        JefnbmIEpo5tx35u3sE479VHvUOMTByMhxglOJiVRHgTou8nCfGmJFZWpRblxxeV5qQWH2I0
        BQbRRGYp0eR8YPLKK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpg
        Wmh+55llhdbKTSUXPX8utvzYvmL17VfTDW6fccu5vf25Y5yq22TlN3+fOa9JmL04vtR58dek
        yZO8Z7+7fN6Webfix+XHF0UtL/r1QaVqZbL7PpVXC074qKUdXPJO+9r7K/cbUzKm65+Veljk
        1MusF5iXcShm8rJrSz2X9b9fGzpjPuf5xPZJj5qNbx8rter9VCagxpT962BpE7Pm20Pz7v6Z
        fGARA5fB9ctbt59fcj5O7ISy64a9D6csv72p9avntaf7dDaxHEpRszPebuwxf+O+KtvIiXdP
        yO3WT5p4btb9rm/1Os3///maxZ7Z+eT66kQn9r3N5akdcwrX+jb9eHNnhTl3yblg3rRFUuqh
        pWo8SizFGYmGWsxFxYkAoli54aYDAAA=
X-CMS-MailID: 20220728121153eucas1p2608d9935422fdb31c3a99a4ea2e765ff
X-Msg-Generator: CA
X-RootMTR: 20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9@eucas1p2.samsung.com>
        <20220727162245.209794-3-p.raghav@samsung.com>
        <7984b969-9025-6b31-2645-da08daeefafb@acm.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-28 01:16, Bart Van Assche wrote:
> On 7/27/22 09:22, Pankaj Raghav wrote:
>> Checking if a given sector is aligned to a zone is a common
>> operation that is performed for zoned devices. Add
>> bdev_is_zone_start helper to check for this instead of opencoding it
>> everywhere.
> 
> I can't find the bdev_is_zone_start() function in this patch?
> 
I made the name change from bdev_is_zone_start to bdev_is_zone_aligned
last moment and missed changing it in the commit log.

>> To make this work bdev_get_queue(), bdev_zone_sectors() and
>> bdev_is_zoned() are moved earlier without modifications.
> 
> Can that change perhaps be isolated into a separate patch?
> 
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 3d286a256d3d..1f7e9a90e198 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -570,7 +570,7 @@ static inline blk_status_t
>> blk_check_zone_append(struct request_queue *q,
>>           return BLK_STS_NOTSUPP;
>>         /* The bio sector must point to the start of a sequential zone */
>> -    if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) -
>> 1) ||
>> +    if (!bdev_is_zone_aligned(bio->bi_bdev, bio->bi_iter.bi_sector) ||
>>           !bio_zone_is_seq(bio))
>>           return BLK_STS_IOERR;
> 
> The bdev_is_zone_start() name seems more clear to me than
> bdev_is_zone_aligned(). Has there already been a discussion about which
> name to use for this function?
> 
The reason I did s/bdev_is_zone_start/bdev_is_zone_aligned is that this
name makes more sense for also checking if a given size is a multiple of
zone sectors for e.g., used in PATCH 9:

-		if (len & (zone_sectors - 1)) {
+		if (!bdev_is_zone_aligned(bdev, len)) {

I felt `bdev_is_zone_aligned` fits the use case of checking if the
sector starts at the start of a zone and also check if a given length of
sectors also align with the zone sectors. bdev_is_zone_start does not
make the intention clear for the latter use case IMO.

But I am fine with going back to bdev_is_zone_start if you and Damien
feel strongly otherwise.
>> +        /*
>> +         * Non power-of-2 zone size support was added to remove the
>> +         * gap between zone capacity and zone size. Though it is
>> technically
>> +         * possible to have gaps in a non power-of-2 device, Linux
>> requires
>> +         * the zone size to be equal to zone capacity for non power-of-2
>> +         * zoned devices.
>> +         */
>> +        if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
>> +            pr_warn("%s: Invalid zone capacity for non power of 2
>> zone size",
>> +                disk->disk_name);
> 
> Given the severity of this error, shouldn't the zone capacity and length
> be reported in the error message?
> 
Ok.
> Thanks,
> 
> Bart.
