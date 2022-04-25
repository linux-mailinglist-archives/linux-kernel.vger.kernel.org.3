Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1711A50D965
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiDYG0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiDYG0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:26:15 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6049D42A1D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650867791; x=1682403791;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FAjNHRxeb61JiRWgIAjgXIeb5RjQpYlMhOuifFyoE44=;
  b=UbZGOdCw/U7V7AtRQi7HYQ64T4G0WMjcLlWRxO72aCFtocdodQ8mPd2U
   1By1SrdmUb9w6vc8+GoXbmCfRbYcFCl/uEpZ+v3XpdKCQITz1afspCRGo
   XdUTn6vx0+3vQ6PddY+rq5TDcWhQOFx6N+tw62l++vff2yvllG715S6kD
   nphu314Q2ShJh4SjIQoL41Y+5QqfPX0BBSdOcp+KKMNWgLAUIfsg0cjnn
   K8R8xUcKO1BpKRPi2PgV4Jr4nYQOB3ElF0eybVfqnseugVJM1P53m2a/A
   EtD3y19JPQ4xdbqXoSe8Hqg+1IdLs+2aQsxMwKEejebZWLjYDCy1bT3MT
   A==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="198727104"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 14:23:11 +0800
IronPort-SDR: lgJPDOTlJ3M8UzbBHdZrlx6FoFWEEiW6nTAocI2qns4C//rStkGDKXREpzsk0TKjSmlvxIsbwr
 yZ3u/TcQzpAh7NPv26/vSBZWWhlTQamO8PcQqwXW7OiZXkhR3iqUip9tPrAorYi3m/KoyT4IgT
 qnkVKBFGwE5dlBoEQ8TPXIJX47RhRNISGDSSABWepsak2tmsWTHEJZVGbneYPbtcC4VHG7VsGv
 YUDRbw/d2Qq8coQmvcaEIGt2Vo/FnK3e8TRWKUKydkZxJH1Tu+M4K03jjDf8kMRtvWHRQ1Yopy
 H6AL1F064O6jtsxxmufGVy/w
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 22:53:24 -0700
IronPort-SDR: ZNmMvKgxTLQxSxFbZDsJv3ri38y7v0Wpdw+ifs2dUfS5esLYX+pTrbKH09PPyn1COwgc3mGOWo
 PMb1MEBfVO9IKHjXbXpr3uuIskvYgDi8xD+Y+Z/dXLw+Uc4C1J0QjVD/hNxmAHSMEcPMWKnp+t
 ZCKwOgTAdrSmSdxw0xmRfuiyfIFW8L6VseYj+CrmayGzQT9iZwoMz+ge0HvkCTRONoADUhykAl
 YazYgqiY7AY7mLolYkfER9IZUd5XClwuhM4OOtzKQDwsVgihbcgnWEnV4BG7iyB3UAibJ+CmvL
 RTU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 23:23:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kmw1W0Rlsz1SVp2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:23:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650867789; x=1653459790; bh=FAjNHRxeb61JiRWgIAjgXIeb5RjQpYlMhOu
        ifFyoE44=; b=JbT+r0RvdeBH5fPi3s/fAst0s5SdHfHa2giDn8/AVooVJqkiI5f
        +mfNPCOtlIiD6HUaU6WZ4Jil1Qmm4dr38kCeYenebu1gMG/nRLhfLu1LcUf7MIUe
        cyMMUIKj2w+s3O1hG5tst5+x4UuxwwePsdO7t/NCNXdnHAFo+fHlVgcUT/TG+KNY
        1OVcxkKiuSnBtX4p1thyzJmF1YfERSexGUoFxl1gkjEcVMtFDcB6RLdOr/t8n8WS
        ZBi64HyIrlXkozzX2ZcWrHJ7Vp2VIkqIilHw4Dwub+pWwzBdx1CH3Adbq441OLWB
        0m5FJ8HcnMcFE6xL1L7VbO6n9RcxK/eoWmg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OSqnhhbtl0zl for <linux-kernel@vger.kernel.org>;
        Sun, 24 Apr 2022 23:23:09 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kmw1S1Btpz1Rvlx;
        Sun, 24 Apr 2022 23:23:07 -0700 (PDT)
Message-ID: <55e8b04f-0d2f-2ce1-6514-5abd0b67fd48@opensource.wdc.com>
Date:   Mon, 25 Apr 2022 15:23:06 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <63e84f2a-2487-a0c3-cab2-7d2011bc2db4@huawei.com>
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

On 4/25/22 15:14, yukuai (C) wrote:
> =E5=9C=A8 2022/04/25 11:24, Damien Le Moal =E5=86=99=E9=81=93:
>> On 4/24/22 11:43, yukuai (C) wrote:
>>> friendly ping ...
>>>
>>> =E5=9C=A8 2022/04/15 18:10, Yu Kuai =E5=86=99=E9=81=93:
>>>> Changes in v3:
>>>>    - update 'waiters_cnt' before 'ws_active' in sbitmap_prepare_to_w=
ait()
>>>>    in patch 1, in case __sbq_wake_up() see 'ws_active > 0' while
>>>>    'waiters_cnt' are all 0, which will cause deap loop.
>>>>    - don't add 'wait_index' during each loop in patch 2
>>>>    - fix that 'wake_index' might mismatch in the first wake up in pa=
tch 3,
>>>>    also improving coding for the patch.
>>>>    - add a detection in patch 4 in case io hung is triggered in corn=
er
>>>>    cases.
>>>>    - make the detection, free tags are sufficient, more flexible.
>>>>    - fix a race in patch 8.
>>>>    - fix some words and add some comments.
>>>>
>>>> Changes in v2:
>>>>    - use a new title
>>>>    - add patches to fix waitqueues' unfairness - path 1-3
>>>>    - delete patch to add queue flag
>>>>    - delete patch to split big io thoroughly
>>>>
>>>> In this patchset:
>>>>    - patch 1-3 fix waitqueues' unfairness.
>>>>    - patch 4,5 disable tag preemption on heavy load.
>>>>    - patch 6 forces tag preemption for split bios.
>>>>    - patch 7,8 improve large random io for HDD. We do meet the probl=
em and
>>>>    I'm trying to fix it at very low cost. However, if anyone still t=
hinks
>>>>    this is not a common case and not worth to optimize, I'll drop th=
em.
>>>>
>>>> There is a defect for blk-mq compare to blk-sq, specifically split i=
o
>>>> will end up discontinuous if the device is under high io pressure, w=
hile
>>>> split io will still be continuous in sq, this is because:
>>>>
>>>> 1) new io can preempt tag even if there are lots of threads waiting.
>>>> 2) split bio is issued one by one, if one bio can't get tag, it will=
 go
>>>> to wail.
>>>> 3) each time 8(or wake batch) requests is done, 8 waiters will be wo=
ken up.
>>>> Thus if a thread is woken up, it will unlikey to get multiple tags.
>>>>
>>>> The problem was first found by upgrading kernel from v3.10 to v4.18,
>>>> test device is HDD with 256 'max_sectors_kb', and test case is issui=
ng 1m
>>>> ios with high concurrency.
>>>>
>>>> Noted that there is a precondition for such performance problem:
>>>> There is a certain gap between bandwidth for single io with
>>>> bs=3Dmax_sectors_kb and disk upper limit.
>>>>
>>>> During the test, I found that waitqueues can be extremly unbalanced =
on
>>>> heavy load. This is because 'wake_index' is not set properly in
>>>> __sbq_wake_up(), see details in patch 3.
>>>>
>>>> Test environment:
>>>> arm64, 96 core with 200 BogoMIPS, test device is HDD. The default
>>>> 'max_sectors_kb' is 1280(Sorry that I was unable to test on the mach=
ine
>>>> where 'max_sectors_kb' is 256).>>
>>>> The single io performance(randwrite):
>>>>
>>>> | bs       | 128k | 256k | 512k | 1m   | 1280k | 2m   | 4m   |
>>>> | -------- | ---- | ---- | ---- | ---- | ----- | ---- | ---- |
>>>> | bw MiB/s | 20.1 | 33.4 | 51.8 | 67.1 | 74.7  | 82.9 | 82.9 |
>>
>> These results are extremely strange, unless you are running with the
>> device write cache disabled ? If you have the device write cache enabl=
ed,
>> the problem you mention above would be most likely completely invisibl=
e,
>> which I guess is why nobody really noticed any issue until now.
>>
>> Similarly, with reads, the device side read-ahead may hide the problem=
,
>> albeit that depends on how "intelligent" the drive is at identifying
>> sequential accesses.
>>
>>>>
>>>> It can be seen that 1280k io is already close to upper limit, and it=
'll
>>>> be hard to see differences with the default value, thus I set
>>>> 'max_sectors_kb' to 128 in the following test.
>>>>
>>>> Test cmd:
>>>>           fio \
>>>>           -filename=3D/dev/$dev \
>>>>           -name=3Dtest \
>>>>           -ioengine=3Dpsync \
>>>>           -allow_mounted_write=3D0 \
>>>>           -group_reporting \
>>>>           -direct=3D1 \
>>>>           -offset_increment=3D1g \
>>>>           -rw=3Drandwrite \
>>>>           -bs=3D1024k \
>>>>           -numjobs=3D{1,2,4,8,16,32,64,128,256,512} \
>>>>           -runtime=3D110 \
>>>>           -ramp_time=3D10
>>>>
>>>> Test result: MiB/s
>>>>
>>>> | numjobs | v5.18-rc1 | v5.18-rc1-patched |
>>>> | ------- | --------- | ----------------- |
>>>> | 1       | 67.7      | 67.7              |
>>>> | 2       | 67.7      | 67.7              |
>>>> | 4       | 67.7      | 67.7              |
>>>> | 8       | 67.7      | 67.7              |
>>>> | 16      | 64.8      | 65.6              |
>>>> | 32      | 59.8      | 63.8              |
>>>> | 64      | 54.9      | 59.4              |
>>>> | 128     | 49        | 56.9              |
>>>> | 256     | 37.7      | 58.3              |
>>>> | 512     | 31.8      | 57.9              |
>>
>> Device write cache disabled ?
>>
>> Also, what is the max QD of this disk ?
>>
>> E.g., if it is SATA, it is 32, so you will only get at most 64 schedul=
er
>> tags. So for any of your tests with more than 64 threads, many of the
>> threads will be waiting for a scheduler tag for the BIO before the
>> bio_split problem you explain triggers. Given that the numbers you sho=
w
>> are the same for before-after patch with a number of threads <=3D 64, =
I am
>> tempted to think that the problem is not really BIO splitting...
>>
>> What about random read workloads ? What kind of results do you see ?
>=20
> Hi,
>=20
> Sorry about the misleading of this test case.
>=20
> This testcase is high concurrency huge randwrite, it's just for the
> problem that split bios won't be issued continuously, which is the
> root cause of the performance degradation as the numjobs increases.
>=20
> queue_depth is 32, and numjobs is 64, thus when numjobs is not greater
> than 8, performance is fine, because the ratio of sequential io should
> be 7/8. However, as numjobs increases, performance is worse because
> the ratio is lower. For example, when numjobs is 512, the ratio of
> sequential io is about 20%.

But with 512 jobs, you will get only 64 jobs only with IOs in the queue.
All other jobs will be waiting for a scheduler tag before being able to
issue their large BIO. No ?

It sounds like the set of scheduler tags should be a bit more elastic:
always allow BIOs from a split of a large BIO to be submitted (that is to
get a scheduler tag) even if that causes a temporary excess of the number
of requests beyond the default number of scheduler tags. Doing so, all
fragments of a large BIOs can be queued immediately. From there, if the
scheduler operates correctly, all the requests from the large BIOs split
would be issued in sequence to the device.


>=20
> patch 6-8 will let split bios still be issued continuously under high
> pressure.
>=20
> Thanks,
> Kuai
>=20


--=20
Damien Le Moal
Western Digital Research
