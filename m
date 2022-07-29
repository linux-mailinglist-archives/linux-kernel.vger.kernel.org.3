Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D819584CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiG2HwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiG2HwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:52:01 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFEC7E010
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:52:00 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220729075158euoutp01b62efe3cd09f9a6cc27fc0ea46196c0f~GPXzNkVjw2224822248euoutp01L
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:51:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220729075158euoutp01b62efe3cd09f9a6cc27fc0ea46196c0f~GPXzNkVjw2224822248euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659081119;
        bh=7F3cs7WSngu7SKh2CktTP9HXlEZMtUMPJQGhN6EVPcg=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=NOubzGbJFtccncHPld5LSe0m/y4Y41CbNr7OTQ1td7hm+sHjNmWdjvyIKer/P8Bf3
         IGX3XQTNQ6O8jK8HC1Gu2FVoNJHY1fKyAbEgGx1RUP0Ck+xz/S1ALBWbU3ghyQOqIt
         T2uXYF97jQopYWEy5J+eQoVgfgFE1AV3Nnpjq8l8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220729075158eucas1p2e4e5b78421be68c72746bebc8992e543~GPXyvt5sx0916509165eucas1p2w;
        Fri, 29 Jul 2022 07:51:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7B.D1.09580.E9193E26; Fri, 29
        Jul 2022 08:51:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220729075158eucas1p29f800c791e3504b687064ad650d20055~GPXyWDazN0066900669eucas1p2I;
        Fri, 29 Jul 2022 07:51:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220729075158eusmtrp206b4834711a30972e7eadfa2036c7815~GPXyU9g9j0852508525eusmtrp2Z;
        Fri, 29 Jul 2022 07:51:58 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-39-62e3919e652f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CE.22.09095.D9193E26; Fri, 29
        Jul 2022 08:51:57 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220729075157eusmtip1cbac1cd4c0f0b835564fcd7eae868363~GPXyLHmvy1491314913eusmtip1L;
        Fri, 29 Jul 2022 07:51:57 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.8) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 29 Jul 2022 08:51:55 +0100
Message-ID: <a2b40d05-5f1d-0e56-b530-ce6d61be7b8a@samsung.com>
Date:   Fri, 29 Jul 2022 09:51:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v8 05/11] null_blk: allow non power of 2 zoned devices
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "snitzer@kernel.org" <snitzer@kernel.org>,
        "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <bbcfe218-5bae-266c-5712-3489b2eeaaba@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.8]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7djPc7rzJj5OMvhxTsxi9d1+NotpH34y
        W7w/+JjV4vfZ88wWe9/NZrXYs2gSk8XK1UeZLJ6sn8Vs8bfrHpPF3lvaFpd3zWGzmL/sKbvF
        hLavzBY3JjxltFhz8ymLxYlb0g4CHpeveHvsnHWX3ePy2VKPTas62Tw2L6n32H2zgc2jt/kd
        m8fO1vusHu/3XQWKn672+LxJzqP9QDdTAE8Ul01Kak5mWWqRvl0CV8aJY9PZC1okKt4sW8Xa
        wPhcsIuRk0NCwERi5bkW1i5GLg4hgRWMEkuOfWcCSQgJfGGU2LozASLxmVGiYV0jM0zHj94t
        jBCJ5YwS69dOYYPoAKpa3aACkdjJKLHn4AewBK+AncTf6yAdHBwsAqoSU15qQYQFJU7OfMIC
        YosKREqs2X2WHcQWFvCSWHzoHVgrs4C4xK0n88EuEhHQk7h66wY7yHxmgflsEqeeP2cDmckm
        oCXR2AnWywm06u2cKawQvZoSrdt/s0PY8hLb386BekBRov/7BjYIu1Zi7bEzYDMlBF5xSmzb
        +ogRIuEisfPkEXYIW1ji1fEtULaMxP+dEAdJCFRLPL3xmxmiuYVRon/nerCDJASsJfrO5EDU
        OEpceXWcCSLMJ3HjrSDEPXwSk7ZNZ57AqDoLKShmIXl5FpIXZiF5YQEjyypG8dTS4tz01GLj
        vNRyveLE3OLSvHS95PzcTYzAxHj63/GvOxhXvPqod4iRiYPxEKMEB7OSCK9AwOMkId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxSDUzlZr2FsxNetHDHns//
        WN4xJcZsor9PQoSa67pZqh0djwX9v22q+WnO9O3zyd/dmjck0n8tsubJsD5i9nLOVT6TXT8s
        l2T/XKaqv2tj/l57Dt1qzTWuW8xiKi4mRNYxcFu93vNz6vya3rdnF5h8XV08eY2FrumueZ1x
        VjE1mVPfHa3a0zx/ZmNmy9rW0/XHfT482q5YcVph7gkpvwmXzjtffhok8Wy29m4VvnOyh8R+
        niuXapn881S71lr5KXKdV4VfcjvM9Pp9xuHJ+8cFiy1tJJacd5x+5p/zlii5Mv0N4TpsLYUc
        79Tc0rQCnKc7SlzcnmRm9yU0UEnz6/r/1T3MWhKrj61VTI9aXh6jI6vEUpyRaKjFXFScCABZ
        KwqV+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xu7pzJz5OMjjYb2Wx+m4/m8W0Dz+Z
        Ld4ffMxq8fvseWaLve9ms1rsWTSJyWLl6qNMFk/Wz2K2+Nt1j8li7y1ti8u75rBZzF/2lN1i
        QttXZosbE54yWqy5+ZTF4sQtaQcBj8tXvD12zrrL7nH5bKnHplWdbB6bl9R77L7ZwObR2/yO
        zWNn631Wj/f7rgLFT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP
        0Ng81srIVEnfziYlNSezLLVI3y5BL+PEsensBS0SFW+WrWJtYHwu2MXIySEhYCLxo3cLYxcj
        F4eQwFJGieUTVjJDJGQkPl35yA5hC0v8udbFBlH0kVGiY/p3JghnJ6PEszNrwap4Bewk/l4H
        GcXBwSKgKjHlpRZEWFDi5MwnLCC2qECkxMNlTUwgtrCAl8TiQ+/YQGxmAXGJW0/mg8VFBPQk
        rt66wQ4yn1lgPpvE7InfmCGWfWaUeHx2EwvIAjYBLYnGTrC9nEB7386ZwgoxSFOidftvdghb
        XmL72zlQ3yhK9H/fwAZh10q8ur+bcQKj6Cwk981CcscsJKNmIRm1gJFlFaNIamlxbnpusaFe
        cWJucWleul5yfu4mRmBK2Xbs5+YdjPNefdQ7xMjEwXiIUYKDWUmEVyDgcZIQb0piZVVqUX58
        UWlOavEhRlNgGE1klhJNzgcmtbySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQi
        mD4mDk6pBial9F+LOvjePbdsmdf+187ohMjHrVMFpyhPz1kkYzzlzppJ3ln7uHW7C1n2HUu3
        n/jnR3WH7WqXPec9etLPq0ff92f6e/hk3Yfnahp32jXm7Ppy5qVlebTeo2mTuQRrxPL7L/Eb
        b7LLc2RUOhSy9t45oUUsGTIXRJ0yjyctKOFXmZ849e+B6EixA4p+PdtCQmcoKxQoaEydu9pw
        +ndWO/3y1QK7Yp49uZtX+tRNMKbLZb5w3y3hJVappn3Shjq6VXmrMx6rdDu+fKHwtEilyD8u
        dtly0Q1nTafFh+e2F9aVpAQZ7W/68UrrSrfL88ULfZ5s7l/97dTSoOrkDfUucVumr1J7FD7v
        2S/ZEL4iKyWW4oxEQy3mouJEAMBw9K2yAwAA
X-CMS-MailID: 20220729075158eucas1p29f800c791e3504b687064ad650d20055
X-Msg-Generator: CA
X-RootMTR: 20220727162251eucas1p12939ac3864fd8705ae139eb2d1087d8f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162251eucas1p12939ac3864fd8705ae139eb2d1087d8f
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162251eucas1p12939ac3864fd8705ae139eb2d1087d8f@eucas1p1.samsung.com>
        <20220727162245.209794-6-p.raghav@samsung.com>
        <bbcfe218-5bae-266c-5712-3489b2eeaaba@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-27 23:59, Chaitanya Kulkarni wrote:
>> Sequential Write:
>>
>> x-----------------x---------------------------------x---------------------------------x
>> |     IOdepth     |            8                    |            16                   |
>> x-----------------x---------------------------------x---------------------------------x
>> |                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
>> x-----------------x---------------------------------x---------------------------------x
>> | Without patch   |  578     |  2257    |   12.80   |  576     |  2248    |   25.78   |
>> x-----------------x---------------------------------x---------------------------------x
>> |  With patch     |  581     |  2268    |   12.74   |  576     |  2248    |   25.85   |
>> x-----------------x---------------------------------x---------------------------------x
>>
>> Sequential read:
>>
>> x-----------------x---------------------------------x---------------------------------x
>> | IOdepth         |            8                    |            16                   |
>> x-----------------x---------------------------------x---------------------------------x
>> |                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
>> x-----------------x---------------------------------x---------------------------------x
>> | Without patch   |  667     |  2605    |   11.79   |  675     |  2637    |   23.49   |
>> x-----------------x---------------------------------x---------------------------------x
>> |  With patch     |  667     |  2605    |   11.79   |  675     |  2638    |   23.48   |
>> x-----------------x---------------------------------x---------------------------------x
>>
>> Random read:
>>
>> x-----------------x---------------------------------x---------------------------------x
>> | IOdepth         |            8                    |            16                   |
>> x-----------------x---------------------------------x---------------------------------x
>> |                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
>> x-----------------x---------------------------------x---------------------------------x
>> | Without patch   |  522     |  2038    |   15.05   |  514     |  2006    |   30.87   |
>> x-----------------x---------------------------------x---------------------------------x
>> |  With patch     |  522     |  2039    |   15.04   |  523     |  2042    |   30.33   |
>> x-----------------x---------------------------------x---------------------------------x
>>
>> Minor variations are noticed in Sequential write with io depth 8 and
>> in random read with io depth 16. But overall no noticeable differences
>> were noticed
> 
> minor variations in with aspect of the performance ?
> are these documented somewhere ?
> 
The table above documents those minor variations in performance.
> move the large table of performance numbers to the cover letter it looks 
> ugly in the git log...
> 
I could do that.
> 
