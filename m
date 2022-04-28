Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997CC5138B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349377AbiD1PoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiD1PoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:44:14 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F82871A3F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:40:59 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220428154057euoutp01b85ad61d8a66078a736f97d1a1a62db8~qGbAfGLEZ0525905259euoutp01I
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:40:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220428154057euoutp01b85ad61d8a66078a736f97d1a1a62db8~qGbAfGLEZ0525905259euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651160457;
        bh=qIVZ/5njtCJ4cvDF1PdJLxdRJvf7JhCQtVuD5bV6nVw=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=BcN9X/wPcuysc3dPQd+NHeeh+Sj2MY26EZte4EcjNi+h2fAU3U2nIZW6NyXY6YxIG
         kYCMPW/oK0IlXiJ7XyvbWz0VpHW7RvDytkwXZNudlB+Rn9q42Ii628nI/gtquoKt3h
         UzyB+1qN7S9dEMZCxBVkirKFuzcj4PUR7l37wfq8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220428154057eucas1p1859b8d27035473774fc5196cf65d872b~qGbAEihw82372423724eucas1p1D;
        Thu, 28 Apr 2022 15:40:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FC.C2.10260.985BA626; Thu, 28
        Apr 2022 16:40:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220428154056eucas1p19857af33432f0b85c5288f6da6c94689~qGa-taHyJ2297022970eucas1p1p;
        Thu, 28 Apr 2022 15:40:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220428154056eusmtrp2c132a078b183a559f95cc0004977defe~qGa-sRNyG1849218492eusmtrp2I;
        Thu, 28 Apr 2022 15:40:56 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-39-626ab589cc99
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A2.95.09404.885BA626; Thu, 28
        Apr 2022 16:40:56 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220428154056eusmtip2ca9440e07c68c7a304db9fdf2ba6a044~qGa-avJns0625606256eusmtip2X;
        Thu, 28 Apr 2022 15:40:56 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.162) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 28 Apr 2022 16:40:54 +0100
Message-ID: <858a5977-e54a-dfa2-c627-56db113128f0@samsung.com>
Date:   Thu, 28 Apr 2022 17:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH 03/16] block: add bdev_zone_no helper
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
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
In-Reply-To: <652c33b5-1d85-e356-05b9-7bd84b768143@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.162]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7djP87qdW7OSDO6tY7NYf+oYs8Xqu/1s
        FtM+/GS2OD31LJPFpP4Z7Ba/z55ntrjwo5HJYuXqo0wWT9bPYrboOfCBxeJv1z2gWMtDZos/
        Dw0tJh26xmjx9OosJou9t7QtLu+aw2Yxf9lTdosJbV+ZLW5MeMpoMfH4ZlaLda/fs1icuCXt
        IO5x+Yq3x78Ta9g8Jja/Y/c4f28ji8fls6Uem1Z1snksbJjK7LF5Sb3H7psNbB69ze/YPHa2
        3mf1eL/vKpvH+i1XWTwmbN7I6vF5k5xH+4FupgCBKC6blNSczLLUIn27BK6M69OmsRX0sFV0
        dfSyNjC+Yuli5OSQEDCReLf0NVsXIxeHkMAKRokT316yQjhfGCWeb33ADOF8ZpT4Nu8CO0zL
        i42PoRLLGSU+317KglC1ZzsThLObUeLN1y4mkBZeATuJR3ung7WzCKhKrO9eABUXlDg58wnY
        JaICERLTZp1hA7GFBSwl3vz8DVbDLCAucevJfLChIgK/GSUun3sHdiGzwGMmiT+H9wJN5eBg
        E9CSaOwEW8Ap4Cbx7NdrZohmTYnW7b/ZIWx5ie1v5zBD/KAs8XNyN9Q/tRJrj51hB5kpIXCQ
        S2Lh3+tsEAkXiT/zVzJB2MISr45vgWqQkfi/cz5UvFri6Y3fzBDNLYwS/TvXs4EcJCFgLdF3
        JgeixlGit/s9M0SYT+LGW0GIe/gkJm2bzjyBUXUWUljMQvLzLCQvzELywgJGllWM4qmlxbnp
        qcXGeanlesWJucWleel6yfm5mxiB6fj0v+NfdzCuePVR7xAjEwfjIUYJDmYlEd4vuzOShHhT
        EiurUovy44tKc1KLDzFKc7AoifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTAZLGjy2f57Um6p
        mNyd/cxijXJpAZGKajrMX7wX8aW9PV4T+0KzZfJXBp7Iw8+F50gdlz3/JMG5rVzUcvXvq38P
        Gj2e1n22fO018el8V7tXzlhcc0FhK9+GKVb6rROVzsl9XeT78pzLv+45LbKz1ea0/hauDYoN
        Tnki7Dv/wu2SCOdepju7Lk73Mc+p+R3DlN9rU3jyyxrbc9M/TPeOnjbRMK1T+cqiRUKOT6Us
        f3ubvYtiWvR8ge/t9kdN8/+7rPRQP/F5klbzxT/7ddYoJ4jPSF/5tLyuZdOewkc39HexMXiU
        F4oJ3XnfMefjuidt0Vld37MXHHP3O+AlF3vISNJG49K0+Vly+dM/HTPiD5mkxFKckWioxVxU
        nAgA06GIhzYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsVy+t/xe7odW7OSDPr3qlmsP3WM2WL13X42
        i2kffjJbnJ56lsliUv8MdovfZ88zW1z40chksXL1USaLJ+tnMVv0HPjAYvG36x5QrOUhs8Wf
        h4YWkw5dY7R4enUWk8XeW9oWl3fNYbOYv+wpu8WEtq/MFjcmPGW0mHh8M6vFutfvWSxO3JJ2
        EPe4fMXb49+JNWweE5vfsXucv7eRxePy2VKPTas62TwWNkxl9ti8pN5j980GNo/e5ndsHjtb
        77N6vN93lc1j/ZarLB4TNm9k9fi8Sc6j/UA3U4BAlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
        kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G9WnT2Ap62Cq6OnpZGxhfsXQxcnJICJhIvNj4
        mLmLkYtDSGApo8STq+vZIBIyEp+ufGSHsIUl/lzrYoMo+sgoceXbd0YIZzejxJYd7awgVbwC
        dhKP9k4H62ARUJVY372ACSIuKHFy5hOwdaICERIPdp8FqxcWsJR48/M3WA2zgLjErSfzmUCG
        igj8ZpS4fO4dK4jDLPCYSeLP4b3sEOuAMvuP9AKN4uBgE9CSaOwE28Yp4Cbx7NdrZohJmhKt
        23+zQ9jyEtvfzmGG+EFZ4ufkbqh/aiVe3d/NOIFRdBaSA2chOWQWklGzkIxawMiyilEktbQ4
        Nz232EivODG3uDQvXS85P3cTIzCJbTv2c8sOxpWvPuodYmTiYDzEKMHBrCTC+2V3RpIQb0pi
        ZVVqUX58UWlOavEhRlNgKE1klhJNzgem0bySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU
        7NTUgtQimD4mDk6pBibLkJXKSrWTFa0nFt661z7nT1wax+3r77YJiL6Z0K6p/6dRNHV/x9oW
        N6evN0631hixHnmTe7rQ6bvt6oi9r4z/8q36PkF+6RJFraDzGRuDFkStXfjLeO2ez9t75uj8
        nRKuy5z7uncuP8vyk3/4clbpLz/7U7LYYU18FWPF17nShQ1CAou/2Tf/VO8425Oo57lD/IM8
        x9SADwtS7vctO+LZuTC3xvmoaHrK+ZbmDe9zPHg2bvXcOTvIKyHqlOZtYS6rPZv+Pv7DZivS
        Vlrg5TM9eRW/puqtvxsLUj6WfjErXpcq0v3Ci039S+4WfccZ16v79s/o2fnyzcvrf115DQ21
        n03cZPbkh/E74Tw7Wz8lluKMREMt5qLiRADl6meT6wMAAA==
X-CMS-MailID: 20220428154056eucas1p19857af33432f0b85c5288f6da6c94689
X-Msg-Generator: CA
X-RootMTR: 20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38@eucas1p2.samsung.com>
        <20220427160255.300418-4-p.raghav@samsung.com>
        <652c33b5-1d85-e356-05b9-7bd84b768143@opensource.wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022-04-28 01:31, Damien Le Moal wrote:

>> +static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
>> +{
>> +	struct request_queue *q = bdev_get_queue(bdev);
>> +
>> +	if (q)
> 
> q is never NULL. So this can be simplified to:
> 
That is a good point. I just noticed it in the bdev_get_queue() function
that q can never be NULL. I will fix it up.

All the functions `bdev*` have this pattern, so probably they could be
simplified as well in the future.
> 	return blk_queue_zone_no(bdev_get_queue(bdev), sector);
> 
>> +		return blk_queue_zone_no(q, sec);
>> +	return 0;
>> +}
>> +
>>  static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>>  {
>>  	struct request_queue *q = bdev_get_queue(bdev);
> 
> 
