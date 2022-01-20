Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF2B495240
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376953AbiATQWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:22:33 -0500
Received: from foss.arm.com ([217.140.110.172]:43870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235587AbiATQWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:22:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42D7011B3;
        Thu, 20 Jan 2022 08:22:31 -0800 (PST)
Received: from [10.57.67.151] (unknown [10.57.67.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E36D13F73D;
        Thu, 20 Jan 2022 08:22:28 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/5] topdown with metrics
To:     John Garry <john.garry@huawei.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, ak@linux.intel.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <4fefb1bc-49b2-bc5b-23cd-cd8fabe8c588@huawei.com>
 <20220111150749.13365-1-andrew.kilroy@arm.com>
 <7cd7bd11-4900-81c4-de84-6e5fc63ec87c@huawei.com>
From:   Al Grant <al.grant@foss.arm.com>
Message-ID: <b82a3b6a-ec02-09ff-8630-e7647491470c@foss.arm.com>
Date:   Thu, 20 Jan 2022 16:22:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <7cd7bd11-4900-81c4-de84-6e5fc63ec87c@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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
>> relevant processor with the MetricGroup name "TopDownL1".  perf will
>> arrange for the events defined in each metric to be collected, and each
>> metric will be displayed in the output, as if
>>
>>    perf stat -M 'TopDownL1' --metric-only -- exampleapp
>>
>> had been used.
>>
>> Topdown was already implemented where certain kernel events are defined.
>> If these kernel events are defined, the new json metrics behaviour is
>> not used.  The json metrics approach is only used if the kernel events
>> are absent.
>>
>> The last patch in the series disables the json metrics behaviour on x86.
>> This is because of concerns that due to SMT it's not straightforward to
>> express the various formulas as json for certain x86 cpus.  See
> 
> I suppose this solution is ok.
> 
> A concern is that today we only have 1x arm64 platform which actually supports this in mainline.
> 
> Do you have any more which you plan to support?
> 
> I think that it's the frontend bound and fetch_bubble event which doesn't have a standard arm solution.
> 
> Note that I do have a series for perf tool which can read arm cpu pmu sysfs events folder to find events which are implemented (I don't think all required events are mandated) and match that against the common arch events JSON, so that we don't need a JSON definition file for each core implementation from all implementators - this would improve scalability.However a concern is that some events - like inst_spec - have imp def meaning, so may not be good to always use by default for all cores metrics.

Sadly the sysfs list isn't complete, it only includes the events
discoverable from the PMCEIDx registers, and they only cover the
ranges 0x0000-0x003f and 0x4000-0x403f. Although that covers most
events used in standard metrics, it doesn't cover all. Most CPUs
have many more events besides these, and there are now architected
(common) events in the 0x8000 range.

There's a lot to be said for having the kernel expose the complete
list to userspace via sysfs. It would save each userspace tool
needing its own set of vendor-supplied information. But to get
that complete list, the kernel would need the same vendor
information the userspace tools are using now.

(And your concern about the metrics varying even when the same
events are present, is quite valid.)

Al
