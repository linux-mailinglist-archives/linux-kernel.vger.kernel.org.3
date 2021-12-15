Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B9D475F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhLORe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:34:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4297 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhLORe5 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:34:57 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDj4Z2zBFz6H7jn;
        Thu, 16 Dec 2021 01:32:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 15 Dec 2021 18:34:55 +0100
Received: from [10.47.93.135] (10.47.93.135) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 15 Dec
 2021 17:34:54 +0000
Subject: Re: [PATCH v2] perf list: Display hybrid pmu events with cpu type
From:   John Garry <john.garry@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <jolsa@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>,
        <Linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <ak@linux.intel.com>, <kan.liang@intel.com>,
        "irogers@google.com" <irogers@google.com>
References: <20210903025239.22754-1-yao.jin@linux.intel.com>
 <YW81L7j06Mf13QmC@kernel.org>
 <be6e0b56-ba29-a2ee-c153-d5aec102b587@huawei.com>
Message-ID: <2bf7048d-2c20-8d3f-1b37-18a4056490a3@huawei.com>
Date:   Wed, 15 Dec 2021 17:34:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <be6e0b56-ba29-a2ee-c153-d5aec102b587@huawei.com>
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

On 15/12/2021 16:18, John Garry wrote:

- yao.jin@linux.intel.com, yao.jin@intel.com

Both these author addresses bounce for me :(

And it's not just my arm64 platform which is damaged, but also my x86 
broadwell machine - uncore aliasing for perf list is broken

Before snippet:
unc_cbo_cache_lookup.any_es
[Unit: uncore_cbox L3 Lookup any request that access cache and found 
line in E or S-state]
unc_cbo_cache_lookup.any_i
[Unit: uncore_cbox L3 Lookup any request that access cache and found 
line in I-state]

After snippet:
unc_cbo_cache_lookup.any_es
[Unit: uncore_cbox L3 Lookup any request that access cache and found 
line in E or S-state]
unc_cbo_cache_lookup.any_es
[Unit: uncore_cbox L3 Lookup any request that access cache and found 
line in E or S-state]
unc_cbo_cache_lookup.any_i
[Unit: uncore_cbox L3 Lookup any request that access cache and found 
line in I-state]
unc_cbo_cache_lookup.any_i
[Unit: uncore_cbox L3 Lookup any request that access cache and found 
line in I-state]

Notice how the events are repeated (twice, for each cbox PMU) after, 
when they should not be.

This seems to be the broken code added in print_pmu_events():

 > qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 > for (j = 0; j < len; j++) {
 > /* Skip duplicates */
 > - if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name))
 > - continue;
 > + if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name)) {
 > + if (!aliases[j].pmu || !aliases[j - 1].pmu ||
 > + !strcmp(aliases[j].pmu, aliases[j - 1].pmu)) {
 > + continue;
 > + }
 > + }

Anyone an idea on the !strcmp(aliases[j].pmu, aliases[j - 1].pmu) check 
or how to fix it?

Thanks,
John
