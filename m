Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4BF528C89
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344540AbiEPSFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344587AbiEPSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:05:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CDCD3A5FC;
        Mon, 16 May 2022 11:05:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 579DBED1;
        Mon, 16 May 2022 11:05:31 -0700 (PDT)
Received: from [10.57.4.89] (unknown [10.57.4.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E369A3F66F;
        Mon, 16 May 2022 11:05:28 -0700 (PDT)
Message-ID: <61141530-7d4a-ed6a-f8b7-933bd550f3c2@arm.com>
Date:   Mon, 16 May 2022 19:05:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 00/20] perf vendors events arm64: Multiple Arm CPUs
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20220510104758.64677-1-nick.forrington@arm.com>
 <YnqJwMfi/bcDmN4H@kernel.org>
 <b1081013-2cd9-f223-8125-d7e51d784f90@huawei.com>
 <eec03f0d-d491-511c-d9b0-694c6d527b38@arm.com>
 <1062b28d-9c7b-89fb-d3bf-519f84029b96@huawei.com>
 <CAP-5=fWYU1hzhGTc6q_u9r82g+rbn18+-i9o0W8sUVyk+t694w@mail.gmail.com>
From:   Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <CAP-5=fWYU1hzhGTc6q_u9r82g+rbn18+-i9o0W8sUVyk+t694w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2022 23:03, Ian Rogers wrote:
> On Thu, May 12, 2022 at 8:53 AM John Garry <john.garry@huawei.com> wrote:
>
> Generally this looks ok:
>
> Reviewed-by: John Garry <john.garry@huawei.com>
>
> If you are feeling particularly helpful then you can add support for any
> events missing to pre-existing core support, like a57-a72.
>
> I'll raise John's "ok" and say this looks great! :-D Some thoughts:

Thanks Ian!

> The mapfile.csv cpuid values don't directly align with:
> https://github.com/ARM-software/data/blob/master/cpus.json
> but this definitely looks deliberate.

Correct - they use different formats.

mapfile.csv uses the MIDR format

https://developer.arm.com/documentation/100442/0100/register-descriptions/aarch64-system-registers/midr-el1--main-id-register--el1

The cpus.json "cpuid" is the implementer and part number from the MIDR 
(the other fields are always fixed in mapfile.csv)
> The new events lack the PMU "Unit" value. The current perf json is
> pretty free form and leads to problems if two PMUs are present.
> Context is here:
> https://lore.kernel.org/lkml/CAP-5=fWRRZsyJZ-gky-FOFz79zW_3r78d_0APpj5sf66HqTpLw@mail.gmail.com/
>
> My idea to rationalize this is to mirror what is already done in
> sysfs, that is the event data is specific to a PMU. As a lot of "Unit"
> values are missing from events on x86 a reasonable guess if the "Unit"
> is missing is to use "cpu". Poking a Google Pixel 4a, I see that all
> PMU data is in "armv8_pmuv3". So for ARM I could guess this is always
> the case, ie all events should belong to armv8_pmuv3. This may not be
> right and could lead to confusion like an event BR_COND_MIS_PRED
> having an alias of "armv8_pmuv3/BR_COND_MIS_PRED/" but it really
> should have some other PMU name in there. I just raise this in case
> there is a fix for this we could incorporate into this patch series,
> maybe "armv8_pmuv3" is always the PMU and my life is easy.

My understanding is that all JSON events under arm64/arm apply to the 
CPU PMU, although there could be 2 (or more) armv8_pmuv3 devices in a 
herterogeneous system (armv8_pmuv3_0, armv8_pmuv3_1, ...) - each with 
different events.

So I don't think static "Unit" data would be helpful, but it should be 
possible to map JSON events to appropriate CPUs with existing data.

e.g. /sys/bus/event_source/devices/armv8_pmuv3_0/cpus shows the CPUs 
associated with a PMU device, and each CPU can be mapped to JSON events 
via the MIDR (as is done already)

Thanks,
Nick

