Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EA5475D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244706AbhLOQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:19:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4295 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhLOQTA (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:19:00 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDgNw5L4Zz6H7Nj;
        Thu, 16 Dec 2021 00:16:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 17:18:57 +0100
Received: from [10.47.93.135] (10.47.93.135) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 15 Dec
 2021 16:18:57 +0000
Subject: Re: [PATCH v2] perf list: Display hybrid pmu events with cpu type
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>
CC:     <jolsa@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>,
        <Linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <ak@linux.intel.com>, <kan.liang@intel.com>, <yao.jin@intel.com>
References: <20210903025239.22754-1-yao.jin@linux.intel.com>
 <YW81L7j06Mf13QmC@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <be6e0b56-ba29-a2ee-c153-d5aec102b587@huawei.com>
Date:   Wed, 15 Dec 2021 16:18:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YW81L7j06Mf13QmC@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.135]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 22:14, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 03, 2021 at 10:52:39AM +0800, Jin Yao escreveu:
>> Add a new option '--cputype' to perf-list to display core-only pmu events
>> or atom-only pmu events.
>>
>> Each hybrid pmu event has been assigned with a pmu name, this patch
>> compares the pmu name before listing the result.
>>
>> For example,
>>
>> perf list --cputype atom
>> ...
>> cache:
>>    core_reject_l2q.any
>>         [Counts the number of request that were not accepted into the L2Q because the L2Q is FULL. Unit: cpu_atom]
>> ...
>>
>> The "Unit: cpu_atom" is displayed in the brief description section
>> to indicate this is an atom event.
> Thanks, applied.

It seems that this buggers "perf list" for uncore events on my arm64 
platform.

Before:

./perf list "uncore ddrc"
uncore ddrc:
   act_cmd
  [DDRC active commands. Unit: hisi_sccl,ddrc]
   flux_rcmd
  [DDRC read commands. Unit: hisi_sccl,ddrc]
   flux_rd
  [DDRC total read operations. Unit: hisi_sccl,ddrc]
   flux_wcmd
  [DDRC write commands. Unit: hisi_sccl,ddrc]
   flux_wr
  [DDRC total write operations. Unit: hisi_sccl,ddrc]
   pre_cmd
  [DDRC precharge commands. Unit: hisi_sccl,ddrc]
   rnk_chg
  [DDRC rank commands. Unit: hisi_sccl,ddrc]
   rw_chg
  [DDRC read and write changes. Unit: hisi_sccl,ddrc]


After:

./perf list "uncore ddrc"

uncore ddrc:
   act_cmd
  [DDRC active commands. Unit: hisi_sccl,ddrc]
   act_cmd
  [DDRC active commands. Unit: hisi_sccl,ddrc]
   act_cmd
  [DDRC active commands. Unit: hisi_sccl,ddrc]
   act_cmd
  [DDRC active commands. Unit: hisi_sccl,ddrc]
   act_cmd
  [DDRC active commands. Unit: hisi_sccl,ddrc]
   act_cmd
  [DDRC active commands. Unit: hisi_sccl,ddrc]
   act_cmd
  [DDRC active commands. Unit: hisi_sccl,ddrc]
   act_cmd
  [DDRC active commands. Unit: hisi_sccl,ddrc]
   act_cmd
  [DDRC active commands. Unit: hisi_sccl,dd

Notice how the events are repeated.

And then gets broken even worse later some point before v5.16-rc6 such 
that aliasing gets broken altogether.

./perf list  | grep hisi_sccl | grep act_cmd|  wc -l
16

Good should be 0.

I'll have a look. Obviously we need a test case to stop such breakages.

Thanks,
John
