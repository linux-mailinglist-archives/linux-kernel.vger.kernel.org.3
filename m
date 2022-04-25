Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A2E50DEB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiDYLXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbiDYLXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:23:25 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCF7252A1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650885620; x=1682421620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VwxgDF6KxJ/vYHJLtUtghe4K2L20v2/aSUHkS2d3AT8=;
  b=HWL0JhtY52J8zCzuhmJg3NW/wxGjuAn166wWuUpjB7usHBEFiwy6/lNo
   CdzxK6uuukpOUgSkP8JKECVZ+HyBBXz4twVhrIsXoPhXD7Vqc/A4eiwel
   5IUX6EkhkwU4vfY5xj4d34UX860xoZF+mcM6B7vkH3ijfHI0fv0T1o9Lo
   fz5o0ZQRt8tnPPzIan4n1SHottyY0q8Cs78LVFIJFAUHdXAlwlckmWHFi
   qQh3l62HoCyZGGFswxjUiHO3J2UZ3gKP0/mn+h3awLbisQT5O7Vhg2rcj
   8sDLTTx1KT5+D50CCrQ4Yr0kaXBty4ubHQl5qtLy5zaofexjWIlsteEC2
   A==;
X-IronPort-AV: E=Sophos;i="5.90,288,1643644800"; 
   d="scan'208";a="198749677"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 19:20:20 +0800
IronPort-SDR: eY33r78Y2GTd0BLobkQkgs/uH13RTNbohsb6lKOvVs3YONra7Z93fZhR2ZfltAOqFMb7i6rWzU
 ESbcpk6eV+mk0CeKrSJIdEwihmYcQ8UJbozC4FRQ2JS9jYg8qmjyyFk6y8WgUrgoZsOTusXU6i
 N1vp4CgYGjMTfUFvSyYT83hsxUkeGXzk8m4MZkFFR5RB1d89ExiIG82Ng8VUPPA9oFh1C9SzYa
 WlFBaWyurNjqliXyN7pfXq6lJvOTibQ+8wg8oiGdGY+0wFEMVu1LSI86l2f0IVGUFk3YKx7Arq
 OFB0AwNRsX0VFqTDPTTKtLjz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2022 03:50:32 -0700
IronPort-SDR: WwE1G4V1ksgEuTBYKVyMTRzRgDteOVGUGny9W7Zm/pzGsaFB9COJA8BcpCw5fHnPWpf0J/aW0/
 4EIMWuWqoaXEKv1uyOPahiR9L2SAitLtHWh7zYok28my9/0v9/iSQf2mFtcfygxEAYplVJIYln
 91p4dKZvICA2YKrse+CtHaYnaD5BktfCtDP9A29PkfaC5XGUZU/27nmNHRElikCkLOhS+SxuPo
 GoM0/N1J62EPhS/+B3dDi7KLiz7oqKLIXcYuE7ItT+o8kCS+0KV8p4lp6XgUjXA9iBVIVNx29b
 +eI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2022 04:20:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kn2cM5V8Jz1SVnx
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:20:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650885619; x=1653477620; bh=VwxgDF6KxJ/vYHJLtUtghe4K2L20v2/aSUH
        kS2d3AT8=; b=qH0/Jr7Ul7wHJSYwSOE/me6+L25/Xc5Fg0rvh3HX/TQPERG0w4R
        QJxEmrGL8zr/5X1N1ZzbF1gS1JRpFNCyX0GuOhW4PqqhmzmKeFWc2vQ/n9Lek/Ur
        XzJnjE449ihVDSo9B9lnZR6sPqBpNtf/oKoB2ybSx3FwJ+NN68fsVzySHuXbWKxH
        I290j1IvT+Q6lHHEbhh1a0ntgpuOxHQOgtEtARpOwFJuGzNWOQnt4PWWY7PIs3tU
        Iv6hC5oKuxl7LE/P4EBw5p+QXwhNLIW9SJoSFrLRl6Fp785zQWdWa4EXn6Tzvc4k
        rhXcT0OORn91ft3kwZSCXWeDU/4+vE/hESA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NmjsM4t15oU5 for <linux-kernel@vger.kernel.org>;
        Mon, 25 Apr 2022 04:20:19 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kn2cK1hVdz1Rvlx;
        Mon, 25 Apr 2022 04:20:17 -0700 (PDT)
Message-ID: <88d9e8f4-cc5a-4897-f511-8f5b7d9a0acd@opensource.wdc.com>
Date:   Mon, 25 Apr 2022 20:20:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next RFC v3 0/8] improve tag allocation under heavy load
Content-Language: en-US
To:     "yukuai (C)" <yukuai3@huawei.com>, axboe@kernel.dk,
        bvanassche@acm.org, andriy.shevchenko@linux.intel.com,
        john.garry@huawei.com, ming.lei@redhat.com, qiulaibin@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220415101053.554495-1-yukuai3@huawei.com>
 <dc800086-43c6-1ff2-659e-258cb75649dd@huawei.com>
 <3fbadd9f-11dd-9043-11cf-f0839dcf30e1@opensource.wdc.com>
 <63e84f2a-2487-a0c3-cab2-7d2011bc2db4@huawei.com>
 <55e8b04f-0d2f-2ce1-6514-5abd0b67fd48@opensource.wdc.com>
 <6957af40-8720-d74b-5be7-6bcdd9aa1089@huawei.com>
 <237a43f0-3b09-46d0-e73c-57ef51e39590@opensource.wdc.com>
 <c11ebf9e-a232-4a5d-d539-f95f584f220e@huawei.com>
 <2e7969ea-68d0-964a-808e-ee8943de70e3@opensource.wdc.com>
 <35f18afa-0db1-b423-5824-4d5631b0422f@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <35f18afa-0db1-b423-5824-4d5631b0422f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 16:28, yukuai (C) wrote:
> =E5=9C=A8 2022/04/25 15:06, Damien Le Moal =E5=86=99=E9=81=93:
>=20
>>>> By the way, did you check that doing something like:
>>>>
>>>> echo 2048 > /sys/block/sdX/queue/nr_requests
>>>>
>>>> improves performance for your high number of jobs test case ?
>>>
>>> Yes, performance will not degrade when numjobs is not greater than 25=
6
>>> in this case.
>>
>> That is my thinking as well. I am asking if did check that (did you ru=
n it ?).
>=20
> Hi,
>=20
> I'm sure I ran it with 256 jobs before.
>=20
> However, I didn't run it with 512 jobs. And following is the result I
> just tested:

What was nr_requests ? The default 64 ?
If you increase that number, do you see better throughput/more requests
being sequential ?


>=20
> ratio of sequential io: 49.1%
>=20
> Read|Write seek=20
>=20
> cnt 99338, zero cnt 48753=20
>=20
>      >=3D(KB) .. <(KB)     : count       ratio |distribution=20
>               |
>           0 .. 1         : 48753       49.1%=20
> |########################################|
>           1 .. 2         : 0            0.0% |=20
>               |
>           2 .. 4         : 0            0.0% |=20
>               |
>           4 .. 8         : 0            0.0% |=20
>               |
>           8 .. 16        : 0            0.0% |=20
>               |
>          16 .. 32        : 0            0.0% |=20
>               |
>          32 .. 64        : 0            0.0% |=20
>               |
>          64 .. 128       : 4975         5.0% |#####=20
>               |
>         128 .. 256       : 4439         4.5% |####=20
>               |
>         256 .. 512       : 2615         2.6% |###=20
>               |
>         512 .. 1024      : 967          1.0% |#=20
>               |
>        1024 .. 2048      : 213          0.2% |#=20
>               |
>        2048 .. 4096      : 375          0.4% |#=20
>               |
>        4096 .. 8192      : 723          0.7% |#=20
>               |
>        8192 .. 16384     : 1436         1.4% |##=20
>               |
>       16384 .. 32768     : 2626         2.6% |###=20
>               |
>       32768 .. 65536     : 4197         4.2% |####=20
>               |
>       65536 .. 131072    : 6431         6.5% |######=20
>               |
>      131072 .. 262144    : 7590         7.6% |#######=20
>               |
>      262144 .. 524288    : 6433         6.5% |######=20
>               |
>      524288 .. 1048576   : 4583         4.6% |####=20
>               |
>     1048576 .. 2097152   : 2237         2.3% |##=20
>               |
>     2097152 .. 4194304   : 489          0.5% |#=20
>               |
>     4194304 .. 8388608   : 83           0.1% |#=20
>               |
>     8388608 .. 16777216  : 36           0.0% |#=20
>               |
>    16777216 .. 33554432  : 0            0.0% |=20
>               |
>    33554432 .. 67108864  : 0            0.0% |=20
>               |
>    67108864 .. 134217728 : 137          0.1% |#=20
>               |


--=20
Damien Le Moal
Western Digital Research
