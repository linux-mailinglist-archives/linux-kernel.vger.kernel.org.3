Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F301B494AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359410AbiATJ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:26:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4433 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359226AbiATJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:26:41 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JfcWM42WHz682sD;
        Thu, 20 Jan 2022 17:23:27 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 20 Jan 2022 10:26:37 +0100
Received: from [10.47.81.141] (10.47.81.141) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 20 Jan
 2022 09:26:37 +0000
Subject: Re: [RFC PATCH v2 0/5] topdown with metrics
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>, <irogers@google.com>, <ak@linux.intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>
References: <4fefb1bc-49b2-bc5b-23cd-cd8fabe8c588@huawei.com>
 <20220111150749.13365-1-andrew.kilroy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7cd7bd11-4900-81c4-de84-6e5fc63ec87c@huawei.com>
Date:   Thu, 20 Jan 2022 09:26:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220111150749.13365-1-andrew.kilroy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.141]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 15:07, Andrew Kilroy wrote:
> This patch series adds the ability for the --topdown option to use
> metrics (defined in json files in the pmu-events directory) to describe
> how to calculate and determine the output columns for topdown level 1.
> 
> For this to work, a number of metrics have to be defined for the
> relevant processor with the MetricGroup name "TopDownL1".  perf will
> arrange for the events defined in each metric to be collected, and each
> metric will be displayed in the output, as if
> 
>    perf stat -M 'TopDownL1' --metric-only -- exampleapp
> 
> had been used.
> 
> Topdown was already implemented where certain kernel events are defined.
> If these kernel events are defined, the new json metrics behaviour is
> not used.  The json metrics approach is only used if the kernel events
> are absent.
> 
> The last patch in the series disables the json metrics behaviour on x86.
> This is because of concerns that due to SMT it's not straightforward to
> express the various formulas as json for certain x86 cpus.  See

I suppose this solution is ok.

A concern is that today we only have 1x arm64 platform which actually 
supports this in mainline.

Do you have any more which you plan to support?

I think that it's the frontend bound and fetch_bubble event which 
doesn't have a standard arm solution.

Note that I do have a series for perf tool which can read arm cpu pmu 
sysfs events folder to find events which are implemented (I don't think 
all required events are mandated) and match that against the common arch 
events JSON, so that we don't need a JSON definition file for each core 
implementation from all implementators - this would improve scalability. 
However a concern is that some events - like inst_spec - have imp def 
meaning, so may not be good to always use by default for all cores metrics.

Thanks,
John
