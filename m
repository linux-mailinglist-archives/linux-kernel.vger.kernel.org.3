Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14D347D2A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbhLVNI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:08:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4321 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbhLVNIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:08:24 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JJtqM4dLQz67kgW;
        Wed, 22 Dec 2021 21:05:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 14:08:22 +0100
Received: from [10.195.32.222] (10.195.32.222) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 13:08:21 +0000
Subject: Re: [PATCH] perf pmu: Fix event list for uncore PMUs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <irogers@google.com>, <kan.liang@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
 <YcGJJ2g+i5qWea7d@krava> <bbf9c0b4-c048-3adf-5282-2355aa648acf@huawei.com>
 <YcGf/d5PPqqyXxUW@krava> <43e185f6-9fa7-6ae1-e4fd-c90c6a50f68f@huawei.com>
 <YcI9twHCIiFyUDOu@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d987a1a9-3c3f-9efb-24c7-22e18d8d63e4@huawei.com>
Date:   Wed, 22 Dec 2021 13:08:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YcI9twHCIiFyUDOu@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.32.222]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2021 20:48, Arnaldo Carvalho de Melo wrote:
>> Now thinking a bit more I am not confident that this patch is a full fix.
>>
>> arm have heterogeneous CPU systems as well - which are not "hybrid" - and I
>> need to ensure that aliasing is still working properly there, as I think
>> that this following check would stop removing duplicates there:
>>
>> +	/* uncore PMUs */
>> +	if (!alias_a->is_cpu && !alias_b->is_cpu)
>> +		return true;
>> +	return false;
> I was about to process this, do you think its better to revert the
> original patch while this gets fixed?

I think that the v2 should now be ok.

@jirka, can you kindly help to check that?

BTW, my patch is based on v5.16-rc5 . I assumed that I would need to be 
based on acme/perf/urgent, but that seems to be based on 5.15

Thanks,
John

