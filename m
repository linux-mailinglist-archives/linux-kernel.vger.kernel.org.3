Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E3749E15A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbiA0LnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:43:23 -0500
Received: from foss.arm.com ([217.140.110.172]:56436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240724AbiA0LnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:43:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00A7F1FB;
        Thu, 27 Jan 2022 03:43:17 -0800 (PST)
Received: from [10.57.39.22] (unknown [10.57.39.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2A303F7D8;
        Thu, 27 Jan 2022 03:43:14 -0800 (PST)
Message-ID: <1fa70669-146c-7ec6-cee9-4f59751eb334@arm.com>
Date:   Thu, 27 Jan 2022 11:42:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 0/5] topdown with metrics
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        irogers@google.com, ak@linux.intel.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <4fefb1bc-49b2-bc5b-23cd-cd8fabe8c588@huawei.com>
 <20220111150749.13365-1-andrew.kilroy@arm.com>
 <7cd7bd11-4900-81c4-de84-6e5fc63ec87c@huawei.com>
From:   Andrew Kilroy <andrew.kilroy@arm.com>
In-Reply-To: <7cd7bd11-4900-81c4-de84-6e5fc63ec87c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/01/2022 09:26, John Garry wrote:
> On 11/01/2022 15:07, Andrew Kilroy wrote:
>> This patch series adds the ability for the --topdown option to use
>> metrics (defined in json files in the pmu-events directory) to describe
>> how to calculate and determine the output columns for topdown level 1.
>>
>> For this to work, a number of metrics have to be defined for the
>> relevant processor with the MetricGroup name "TopDownL1".  perf will
>> arrange for the events defined in each metric to be collected, and each
>> metric will be displayed in the output, as if
>>
>>    perf stat -M 'TopDownL1' --metric-only -- exampleapp
>>
>> had been used.
>>
>> Topdown was already implemented where certain kernel events are defined.
>> If these kernel events are defined, the new json metrics behaviour is
>> not used.  The json metrics approach is only used if the kernel events
>> are absent.
>>
>> The last patch in the series disables the json metrics behaviour on x86.
>> This is because of concerns that due to SMT it's not straightforward to
>> express the various formulas as json for certain x86 cpus.  See
> 
> I suppose this solution is ok.
> 

Thanks, would you mind giving it a Reviewed-By?

> A concern is that today we only have 1x arm64 platform which actually 
> supports this in mainline.
> 
> Do you have any more which you plan to support?
> 

The Neoverse cores, mainly.

> I think that it's the frontend bound and fetch_bubble event which 
> doesn't have a standard arm solution.
> 
> Note that I do have a series for perf tool which can read arm cpu pmu 
> sysfs events folder to find events which are implemented (I don't think 
> all required events are mandated) and match that against the common arch 
> events JSON, so that we don't need a JSON definition file for each core 
> implementation from all implementators - this would improve scalability. 
> However a concern is that some events - like inst_spec - have imp def 
> meaning, so may not be good to always use by default for all cores metrics.
> 
> Thanks,
> John

Thanks,
Andrew
