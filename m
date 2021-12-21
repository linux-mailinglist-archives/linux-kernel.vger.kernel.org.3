Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4947BE03
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhLUKOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:14:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4311 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhLUKOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:14:46 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JJC2L22JSz67Mww;
        Tue, 21 Dec 2021 18:12:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Tue, 21 Dec 2021 11:14:43 +0100
Received: from [10.195.32.222] (10.195.32.222) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 10:14:43 +0000
Subject: Re: [PATCH] perf pmu: Fix event list for uncore PMUs
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
 <YcGJJ2g+i5qWea7d@krava> <bbf9c0b4-c048-3adf-5282-2355aa648acf@huawei.com>
 <YcGf/d5PPqqyXxUW@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <43e185f6-9fa7-6ae1-e4fd-c90c6a50f68f@huawei.com>
Date:   Tue, 21 Dec 2021 10:14:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YcGf/d5PPqqyXxUW@krava>
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

On 21/12/2021 09:35, Jiri Olsa wrote:
> On Tue, Dec 21, 2021 at 09:10:37AM +0000, John Garry wrote:
>> On 21/12/2021 07:58, Jiri Olsa wrote:
>>>> +	/* Different names -> never duplicates */
>>>> +	if (strcmp(alias_a->name, alias_b->name))
>>>> +		return false;
>>>> +	if (!alias_a->pmu)
>>>> +		return true;
>>>> +	if (!alias_b->pmu)
>>>> +		return true;
>>> nit could be:
>>>
>>> 	if (!alias_a->pmu || !alias_b->pmu)
>>> 		return true;
>>>
>>> would be great to have more comments explaining the check
>>>
>>
>> This is just a sanity check that both strings are non-NULL as we do a
>> strcmp() next. So would this be better:
>>
>> if (!alias_a->pmu || !alias_b->pmu || !strcmp(alias_a->pmu, alias_b->pmu))
>> 	return true
>>
>> ?
>>
>> It will spill a line.
> 
> sure, it cought my eye because the is_cpu check later is done on
> the same line, so I started wondering what's the difference ;-)
> 

Now thinking a bit more I am not confident that this patch is a full fix.

arm have heterogeneous CPU systems as well - which are not "hybrid" - 
and I need to ensure that aliasing is still working properly there, as I 
think that this following check would stop removing duplicates there:

+	/* uncore PMUs */
+	if (!alias_a->is_cpu && !alias_b->is_cpu)
+		return true;
+	return false;

Thanks,
John

