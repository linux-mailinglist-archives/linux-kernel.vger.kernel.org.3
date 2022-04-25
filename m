Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1489950D77D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbiDYD2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbiDYD2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:28:09 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B0F240A4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 20:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650857105; x=1682393105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6H+DX6wB5dluX5+X8Xo+lp7NbNiSTNvgwEQInIrh7tc=;
  b=kqV+nfu3iAkMhd+wYmYI70nbFC+M+zDAPrAoeWt+m+YqnRkrgVhYHnqH
   wru1A3Ros2YY+GBINDGlwby7pTlmlPNcLS3OYtIXblfPuMDYdzQg7Jh3W
   rBwmuxCg0ZXB/HyQewDM0lneQEXsCUi3bBwP9J/wtHXLYz6fNttQMkdWh
   j5iWgUm9T7uWNfTtD+hRgPcbEdPCAhQX4ihCi7Pfczfyc7gi0SGPbQcQS
   uTzEZldJi8vQqVVymsuPsz+9kuCTvmEwmcbMCGRHVk5ULtQ60Zc1KjsaX
   qc/NXUxmnl1lX9TMenJMRj7WP/MlEH6Mv+6O0+xPO9T3kuAjdpV5bpIyz
   A==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="198715789"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 11:25:04 +0800
IronPort-SDR: gilY0JFpStybGsPApKfh0vPtmbTJY5a7UUt/XmB0D1G9A15BNe1/7EoxC2io+tTARLjYq1x7ki
 xCRUE0xYlgtFGcJzqghpWUjelPDGcbWEOcvWui4DkIPGwixGBt8gNQKVw5Y4gJ3KCr4Biaf/uW
 ND41RwZTRi4sVCm8tsbgh2mfr2McdYmaX9H/vI1Q6AUaeaNMiRCeTTk6+Q2S9m/NSixA4f7V1V
 IvWBq1E7KDBpkP69vRqEtteDfd0U5zH4KFJDr6DU+QBN8RJmCSwaB6h0O6f/LrTht4JBdVfAg7
 ltaRIfkoaTOHIPS5DWPymnWG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 19:55:18 -0700
IronPort-SDR: ID/hMJhLIrmkN+TgGoi1E2ZJ3Q797Yeh5Pn9d0rYxIh2/CpvLIdtR32hJOJ4qI4Sfa9MMO5cju
 EKY5WQVOfxAeepNlr2dq1EWitzmJUJlqW1YISwpMehSaRGhfz1I91euztO75Whkq65QHIRoKni
 JYPObLFrtpz75oWKccwMvnI8qYQ+JIhXi8UqdRMgDJIB2gGUa02RM5SJJ1/yP/pTNd723WNEe3
 mgY4rJ15QgvO8WoJtCAASOo4HmPC6ad+I189AGIipOV07/6+svwTqjhYRLc7VwJhtEnPh3N3tV
 cpI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 20:25:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kmr4110sKz1SVp1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 20:25:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650857103; x=1653449104; bh=6H+DX6wB5dluX5+X8Xo+lp7NbNiSTNvgwEQ
        InIrh7tc=; b=n7FTrt2afkZdv1iQA70YJ9gBm99tRPAm2GmyyKH8AvZdU7sILi5
        sj0C1hNI1ulqKA+Hub2ZHwZSsQbyQzT0lSrtFE/p+8sAnux7HYrh2JwnHQpacGlk
        mq9mgoEyIgDGGETjislxHgjShOUlNsIGU+K41DF2QlKRh1s1tDZ/ks6aqdpQ0oa4
        XOLk5jnNl1Q0FQoxk01DW7eDYyKXJ+30Jk7epuJPYgDtu3JcEeTlUL2KQsq+pxY+
        fnybPdk5ooxVbkC37rg1y65KpeIX5fr5T/bhoK57m+KPph1PMwfMQJcRI4STNKWI
        udxPBYkwBNQ++dm70jke761V97+0l/inwwg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ULfDe_c4r4Jw for <linux-kernel@vger.kernel.org>;
        Sun, 24 Apr 2022 20:25:03 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kmr3x5b6Kz1Rvlx;
        Sun, 24 Apr 2022 20:25:01 -0700 (PDT)
Message-ID: <3fbadd9f-11dd-9043-11cf-f0839dcf30e1@opensource.wdc.com>
Date:   Mon, 25 Apr 2022 12:24:59 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <dc800086-43c6-1ff2-659e-258cb75649dd@huawei.com>
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

On 4/24/22 11:43, yukuai (C) wrote:
> friendly ping ...
>=20
> =E5=9C=A8 2022/04/15 18:10, Yu Kuai =E5=86=99=E9=81=93:
>> Changes in v3:
>>   - update 'waiters_cnt' before 'ws_active' in sbitmap_prepare_to_wait=
()
>>   in patch 1, in case __sbq_wake_up() see 'ws_active > 0' while
>>   'waiters_cnt' are all 0, which will cause deap loop.
>>   - don't add 'wait_index' during each loop in patch 2
>>   - fix that 'wake_index' might mismatch in the first wake up in patch=
 3,
>>   also improving coding for the patch.
>>   - add a detection in patch 4 in case io hung is triggered in corner
>>   cases.
>>   - make the detection, free tags are sufficient, more flexible.
>>   - fix a race in patch 8.
>>   - fix some words and add some comments.
>>
>> Changes in v2:
>>   - use a new title
>>   - add patches to fix waitqueues' unfairness - path 1-3
>>   - delete patch to add queue flag
>>   - delete patch to split big io thoroughly
>>
>> In this patchset:
>>   - patch 1-3 fix waitqueues' unfairness.
>>   - patch 4,5 disable tag preemption on heavy load.
>>   - patch 6 forces tag preemption for split bios.
>>   - patch 7,8 improve large random io for HDD. We do meet the problem =
and
>>   I'm trying to fix it at very low cost. However, if anyone still thin=
ks
>>   this is not a common case and not worth to optimize, I'll drop them.
>>
>> There is a defect for blk-mq compare to blk-sq, specifically split io
>> will end up discontinuous if the device is under high io pressure, whi=
le
>> split io will still be continuous in sq, this is because:
>>
>> 1) new io can preempt tag even if there are lots of threads waiting.
>> 2) split bio is issued one by one, if one bio can't get tag, it will g=
o
>> to wail.
>> 3) each time 8(or wake batch) requests is done, 8 waiters will be woke=
n up.
>> Thus if a thread is woken up, it will unlikey to get multiple tags.
>>
>> The problem was first found by upgrading kernel from v3.10 to v4.18,
>> test device is HDD with 256 'max_sectors_kb', and test case is issuing=
 1m
>> ios with high concurrency.
>>
>> Noted that there is a precondition for such performance problem:
>> There is a certain gap between bandwidth for single io with
>> bs=3Dmax_sectors_kb and disk upper limit.
>>
>> During the test, I found that waitqueues can be extremly unbalanced on
>> heavy load. This is because 'wake_index' is not set properly in
>> __sbq_wake_up(), see details in patch 3.
>>
>> Test environment:
>> arm64, 96 core with 200 BogoMIPS, test device is HDD. The default
>> 'max_sectors_kb' is 1280(Sorry that I was unable to test on the machin=
e
>> where 'max_sectors_kb' is 256).>>
>> The single io performance(randwrite):
>>
>> | bs       | 128k | 256k | 512k | 1m   | 1280k | 2m   | 4m   |
>> | -------- | ---- | ---- | ---- | ---- | ----- | ---- | ---- |
>> | bw MiB/s | 20.1 | 33.4 | 51.8 | 67.1 | 74.7  | 82.9 | 82.9 |

These results are extremely strange, unless you are running with the
device write cache disabled ? If you have the device write cache enabled,
the problem you mention above would be most likely completely invisible,
which I guess is why nobody really noticed any issue until now.

Similarly, with reads, the device side read-ahead may hide the problem,
albeit that depends on how "intelligent" the drive is at identifying
sequential accesses.

>>
>> It can be seen that 1280k io is already close to upper limit, and it'l=
l
>> be hard to see differences with the default value, thus I set
>> 'max_sectors_kb' to 128 in the following test.
>>
>> Test cmd:
>>          fio \
>>          -filename=3D/dev/$dev \
>>          -name=3Dtest \
>>          -ioengine=3Dpsync \
>>          -allow_mounted_write=3D0 \
>>          -group_reporting \
>>          -direct=3D1 \
>>          -offset_increment=3D1g \
>>          -rw=3Drandwrite \
>>          -bs=3D1024k \
>>          -numjobs=3D{1,2,4,8,16,32,64,128,256,512} \
>>          -runtime=3D110 \
>>          -ramp_time=3D10
>>
>> Test result: MiB/s
>>
>> | numjobs | v5.18-rc1 | v5.18-rc1-patched |
>> | ------- | --------- | ----------------- |
>> | 1       | 67.7      | 67.7              |
>> | 2       | 67.7      | 67.7              |
>> | 4       | 67.7      | 67.7              |
>> | 8       | 67.7      | 67.7              |
>> | 16      | 64.8      | 65.6              |
>> | 32      | 59.8      | 63.8              |
>> | 64      | 54.9      | 59.4              |
>> | 128     | 49        | 56.9              |
>> | 256     | 37.7      | 58.3              |
>> | 512     | 31.8      | 57.9              |

Device write cache disabled ?

Also, what is the max QD of this disk ?

E.g., if it is SATA, it is 32, so you will only get at most 64 scheduler
tags. So for any of your tests with more than 64 threads, many of the
threads will be waiting for a scheduler tag for the BIO before the
bio_split problem you explain triggers. Given that the numbers you show
are the same for before-after patch with a number of threads <=3D 64, I a=
m
tempted to think that the problem is not really BIO splitting...

What about random read workloads ? What kind of results do you see ?

>>
>> Yu Kuai (8):
>>    sbitmap: record the number of waiters for each waitqueue
>>    blk-mq: call 'bt_wait_ptr()' later in blk_mq_get_tag()
>>    sbitmap: make sure waitqueues are balanced
>>    blk-mq: don't preempt tag under heavy load
>>    sbitmap: force tag preemption if free tags are sufficient
>>    blk-mq: force tag preemption for split bios
>>    blk-mq: record how many tags are needed for splited bio
>>    sbitmap: wake up the number of threads based on required tags
>>
>>   block/blk-merge.c         |   8 +-
>>   block/blk-mq-tag.c        |  49 +++++++++----
>>   block/blk-mq.c            |  54 +++++++++++++-
>>   block/blk-mq.h            |   4 +
>>   include/linux/blk_types.h |   4 +
>>   include/linux/sbitmap.h   |   9 +++
>>   lib/sbitmap.c             | 149 +++++++++++++++++++++++++++---------=
--
>>   7 files changed, 216 insertions(+), 61 deletions(-)
>>


--=20
Damien Le Moal
Western Digital Research
