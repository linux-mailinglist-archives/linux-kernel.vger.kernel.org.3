Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94854C01B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243535AbiFODWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiFODWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:22:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F0614035;
        Tue, 14 Jun 2022 20:22:38 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LN9Yt2fw4zjY96;
        Wed, 15 Jun 2022 11:21:06 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 11:22:09 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 11:22:08 +0800
Subject: Re: [RFC 09/13] perf kwork: Add workqueue report support
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <20220613094605.208401-1-yangjihong1@huawei.com>
 <20220613094605.208401-10-yangjihong1@huawei.com>
 <CAM9d7cijyKgCt7su96yM9OWgHP5Hh1UMQh+iBskO+m+rb_y5ww@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <81afcdb8-0bbf-a28b-d944-770ca3de0397@huawei.com>
Date:   Wed, 15 Jun 2022 11:22:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cijyKgCt7su96yM9OWgHP5Hh1UMQh+iBskO+m+rb_y5ww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/6/15 5:54, Namhyung Kim wrote:
> On Mon, Jun 13, 2022 at 2:48 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Implements workqueue report function.
>>
>> test case:
>>
>>    # perf kwork -k workqueue rep
>>
>>      Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
>>     ---------------------------------------------------------------------------------------------------------------------------
>>      (w)0xffffffff83e09fa0     | 0001 |   2152.678 ms |       194 |     12.376 ms |    2059361.546621 s |    2059361.558997 s |
>>      (w)0xffff888332fea180     | 0000 |     17.125 ms |       301 |      1.018 ms |    2059358.441070 s |    2059358.442089 s |
>>      (w)0xffff8881035a83d8     | 0007 |      7.556 ms |         3 |      3.212 ms |    2059362.614643 s |    2059362.617855 s |
>>      (w)0xffff888102fc14a0     | 0002 |      7.080 ms |         5 |      1.962 ms |    2059365.421753 s |    2059365.423714 s |
>>      (w)0xffffffff82f7da00     | 0000 |      4.277 ms |         7 |      3.778 ms |    2059360.851063 s |    2059360.854841 s |
>>      (w)0xffffffff8305d680     | 0006 |      1.796 ms |         1 |      1.796 ms |    2059360.046818 s |    2059360.048613 s |
>>      (w)0xffff8883339e9040     | 0005 |      1.659 ms |         2 |      1.619 ms |    2059361.266051 s |    2059361.267670 s |
>>      (w)0xffff888333de9040     | 0007 |      1.121 ms |         5 |      0.783 ms |    2059368.238059 s |    2059368.238842 s |
>>      (w)0xffff888332fe9040     | 0000 |      0.990 ms |         4 |      0.911 ms |    2059359.604075 s |    2059359.604986 s |
>>      (w)0xffff8883331e9040     | 0001 |      0.244 ms |         6 |      0.046 ms |    2059362.689277 s |    2059362.689323 s |
>>      (w)0xffff888102e44400     | 0007 |      0.239 ms |         2 |      0.137 ms |    2059363.117537 s |    2059363.117674 s |
>>      (w)0xffff8883333ea180     | 0002 |      0.141 ms |         5 |      0.049 ms |    2059365.423784 s |    2059365.423833 s |
>>      (w)0xffffffff83062f28     | 0006 |      0.084 ms |         2 |      0.047 ms |    2059358.208033 s |    2059358.208080 s |
>>      (w)0xffffffff8305ca48     | 0003 |      0.078 ms |         2 |      0.041 ms |    2059361.071371 s |    2059361.071412 s |
>>      (w)0xffff8883337e9040     | 0004 |      0.062 ms |         1 |      0.062 ms |    2059362.605723 s |    2059362.605785 s |
>>      (w)0xffff8881035a81e8     | 0001 |      0.056 ms |         1 |      0.056 ms |    2059363.118231 s |    2059363.118287 s |
>>      (w)0xffff8883335e9040     | 0003 |      0.026 ms |         1 |      0.026 ms |    2059358.573397 s |    2059358.573423 s |
>>      (w)0xffffffff83062e70     | 0006 |      0.023 ms |         1 |      0.023 ms |    2059368.398864 s |    2059368.398888 s |
>>      (w)0xffffffff83e06480     | 0002 |      0.000 ms |         1 |      0.000 ms |    2059359.986792 s |    2059359.986792 s |
> 
> Using "function" in the tracepoint and symbolizing it would be
> far more intuitive.
> 
OK，This is a simplified version that will be improved in the next 
version, and I'd like to add the following features:
1. Supports the kthread profile.
2. Save runtime and latency in kernel using ebpf(similar to "perf 
record: Implement off-cpu profiling with BPF") . This reduces the number 
of interruptions caused by writing files to hard disks, which is closer 
to the actual scenario.


This RFC is sent to discuss to see if this function is useful to the 
community and can be accepted by the community. :)



Thanks,
Jihong

.
