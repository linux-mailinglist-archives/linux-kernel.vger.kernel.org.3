Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE25251CA8D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385827AbiEEUa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384863AbiEEUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:30:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBA32BB37;
        Thu,  5 May 2022 13:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651782436; x=1683318436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7CEnqxibNRVUdp/GgjeTzmjH1M+XSXCHZAEWsycer/E=;
  b=jutqGZKDN/1tp9ZztpuLkU2bqpdK3cVpACBV/Yp1Wus+jxjonGWWtP60
   cWwtdrWora8108yWJMrFoFDFgXx6u+NYHLoAknTNqxumb9WfmhgrOxHjj
   E+zoDJS6JQqQSzdhFWQj2QJV0qf/h1u4tIcsqv9/D9du4OiHGRihApgGW
   9Isb2daic7lGv9Wl54wDxfmZ54aD410Ryo/HTVqiviAzi+4GZNMmwFlPf
   2QxMdFR6r3k9wgs/CkFOH8PI/h/yxeVHeYXU8+q7TcTbQylpNq1PKae1j
   2CAmpad+BNgic/BZyyc388j+Y7quJSrz8hRC3bmy0Vv14F5gL1Kclx1nh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248777171"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="248777171"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 13:27:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="568760994"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 05 May 2022 13:27:15 -0700
Received: from [10.252.209.228] (kliang2-MOBL.ccr.corp.intel.com [10.252.209.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0DD3A5808EF;
        Thu,  5 May 2022 13:27:12 -0700 (PDT)
Message-ID: <f1c212e3-c1fd-4a2d-0dfe-bc913d4f4f36@linux.intel.com>
Date:   Thu, 5 May 2022 16:27:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] perf test: Add basic stat and topdown group test
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
References: <20220505043846.3165303-1-irogers@google.com>
 <20220505043846.3165303-2-irogers@google.com>
 <cb6065af-7e3f-53fa-5d82-67be04ca833f@linux.intel.com>
 <CAP-5=fV6Sj3PMjVBYtCRZUXXrwOJC9ETffQYscvcgJZ7gm2tFw@mail.gmail.com>
 <e11e873c-6e61-5d50-ba6a-a99045e486bc@linux.intel.com>
 <CAP-5=fUGDkVS6zYUkeYWHMrgkX50Fao0iSKs95Yvyts+wUxpxQ@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUGDkVS6zYUkeYWHMrgkX50Fao0iSKs95Yvyts+wUxpxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/2022 2:35 PM, Ian Rogers wrote:
> On Thu, May 5, 2022 at 11:19 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>> On 5/5/2022 11:22 AM, Ian Rogers wrote:
>>> On Thu, May 5, 2022 at 5:12 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>> On 5/5/2022 12:38 AM, Ian Rogers wrote:
>>>>> Add a basic stat test.
>>>>> Add two tests of grouping behavior for topdown events. Topdown events
>>>>> are special as they must be grouped with the slots event first.
>>>>>
>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>> ---
>>>>>     tools/perf/tests/shell/stat.sh | 65 ++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 65 insertions(+)
>>>>>     create mode 100755 tools/perf/tests/shell/stat.sh
>>>>>
>>>>> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
>>>>> new file mode 100755
>>>>> index 000000000000..80869ea6debc
>>>>> --- /dev/null
>>>>> +++ b/tools/perf/tests/shell/stat.sh
>>>>> @@ -0,0 +1,65 @@
>>>>> +#!/bin/sh
>>>>> +# perf stat tests
>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>> +
>>>>> +set -e
>>>>> +
>>>>> +err=0
>>>>> +test_default_stat() {
>>>>> +  echo "Basic stat command test"
>>>>> +  if ! perf stat true 2>&1 | egrep -q "Performance counter stats for 'true':"
>>>>> +  then
>>>>> +    echo "Basic stat command test [Failed]"
>>>>> +    err=1
>>>>> +    return
>>>>> +  fi
>>>>> +  echo "Basic stat command test [Success]"
>>>>> +}
>>>>> +
>>>>> +test_topdown_groups() {
>>>>> +  # Topdown events must be grouped with the slots event first. Test that
>>>>> +  # parse-events reorders this.
>>>>> +  echo "Topdown event group test"
>>>>> +  if ! perf stat -e '{slots,topdown-retiring}' true > /dev/null 2>&1
>>>>> +  then
>>>>> +    echo "Topdown event group test [Skipped event parsing failed]"
>>>>> +    return
>>>>> +  fi
>>>>> +  if perf stat -e '{slots,topdown-retiring}' true 2>&1 | egrep -q "<not supported>"
>>>>> +  then
>>>>> +    echo "Topdown event group test [Failed events not supported]"
>>>>> +    err=1
>>>>> +    return
>>>>> +  fi
>>>>> +  if perf stat -e '{topdown-retiring,slots}' true 2>&1 | egrep -q "<not supported>"
>>>>> +  then
>>>>> +    echo "Topdown event group test [Failed slots not reordered first]"
>>>>> +    err=1
>>>>> +    return
>>>>> +  fi
>>>>> +  echo "Topdown event group test [Success]"
>>>>> +}
>>>>> +
>>>>> +test_topdown_weak_groups() {
>>>>> +  # Weak groups break if the perf_event_open of multiple grouped events
>>>>> +  # fails. Breaking a topdown group causes the events to fail. Test a very large
>>>>> +  # grouping to see that the topdown events aren't broken out.
>>>>> +  echo "Topdown weak groups test"
>>>>> +  if ! perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,topdown-retiring},branch-instructions,branch-misses,bus-cycles,cache-misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,baclears.any,ARITH.DIVIDER_ACTIVE' true > /dev/null 2>&1
>>>>> +  then
>>>>> +    echo "Topdown weak groups test [Skipped event parsing failed]"
>>>>> +    return
>>>>> +  fi
>>>>> +  if perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,baclears.any,ARITH.DIVIDER_ACTIVE}:W' true 2>&1 | egrep -q "<not supported>"
>>>>> +  then
>>>>> +    echo "Topdown weak groups test [Failed events not supported]"
>>>>> +    err=1
>>>>> +    return
>>>>> +  fi
>>>>> +  echo "Topdown weak groups test [Success]"
>>>>> +}
>>>>> +
>>>>
>>>> Should we check the existence of the slots event before the test?
>>>> The perf metrics feature only be available on the new platform after
>>>> ICL. It doesn't work on Atom.
>>>>
>>>> Also, I think the test may fails on the hybrid platform, since big core
>>>> and small core have different formula for the topdown. I think we should
>>>> avoid the test for the hybrid platform for now.
>>>> +Zhengjun, who is fixing the topdown gap for the hybrid platform. I
>>>> think he may take care of the hybrid support later.
>>>
>>> Thanks Kan, the test filters out systems that don't support the events
>>> and silently skips the test. The main purpose of the test is to make
>>> sure the somewhat complicated grouping operations for Icelake have
>>> some coverage. Adding more coverage for hybrid would be great, but not
>>> something I think gates this change.
>>>
>>
>> Sure, we can add the coverage for hybrid later. But please make sure the
>> test can filter out both the systems which doesn't support perf metircs
>> and the hybrid system.
>>
>> Thanks,
>> Kan
> 
> If the test fails on hybrid then that feels like value add :-) 

Indeed. The test case is valid.

Could you please use architecture events to replace the 
baclears.any,ARITH.DIVIDER_ACTIVE?
It's not guaranteed that the two events are supported for the future 
platforms.

I use the duplicated cache-misses,cache-references events to replace 
baclears.any,ARITH.DIVIDER_ACTIVE and tested on the ADL. The results 
look good.

./perf stat -e 
'{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,cache-misses,cache-references}:W' 
true
WARNING: events in group from different hybrid PMUs!

  Performance counter stats for 'true':

          3,603,798      cpu_core/slots/
            480,506      cpu_core/topdown-bad-spec/ #     13.3% bad 
speculation
      <not counted>      cpu_atom/topdown-bad-spec/ 
                 (0.00%)
            833,819      cpu_core/topdown-be-bound/ #     23.0% backend 
bound
      <not counted>      cpu_atom/topdown-be-bound/ 
                 (0.00%)
          1,483,916      cpu_core/topdown-fe-bound/ #     41.0% frontend 
bound
      <not counted>      cpu_atom/topdown-fe-bound/ 
                 (0.00%)
            819,687      cpu_core/topdown-retiring/ #     22.7% retiring
      <not counted>      cpu_atom/topdown-retiring/ 
                 (0.00%)
            151,010      cpu_core/branch-instructions/
      <not counted>      cpu_atom/branch-instructions/ 
                    (0.00%)
              4,402      cpu_core/branch-misses/
      <not counted>      cpu_atom/branch-misses/ 
                (0.00%)
          1,456,308      cpu_core/bus-cycles/
      <not counted>      cpu_atom/bus-cycles/ 
                (0.00%)
              1,132      cpu_core/cache-misses/
      <not counted>      cpu_atom/cache-misses/ 
                (0.00%)
             14,226      cpu_core/cache-references/
      <not counted>      cpu_atom/cache-references/ 
                 (0.00%)
            600,633      cpu_core/cpu-cycles/
      <not counted>      cpu_atom/cpu-cycles/ 
                (0.00%)
            737,806      cpu_core/instructions/
      <not counted>      cpu_atom/instructions/ 
                (0.00%)
                  0      cpu_core/mem-loads/
      <not counted>      cpu_atom/mem-loads/ 
                (0.00%)
            120,151      cpu_core/mem-stores/
      <not counted>      cpu_atom/mem-stores/ 
                (0.00%)
          1,456,308      cpu_core/ref-cycles/
      <not counted>      cpu_atom/ref-cycles/ 
                (0.00%)
      <not counted>      cpu_core/cache-misses/ 
                (0.00%)
      <not counted>      cpu_atom/cache-misses/ 
                (0.00%)
      <not counted>      cpu_core/cache-references/ 
                 (0.00%)
      <not counted>      cpu_atom/cache-references/ 
                 (0.00%)

        0.001518955 seconds time elapsed

        0.001531000 seconds user
        0.000000000 seconds sys

Thanks,
Kan
> We
> genuinely have broken grouping functions. We could just add to the
> test a skip if /sys/devices/cpu_core and /sys/devices/cpu_atom
> directories exist (making assumptions on where sysfs is mounted). I'm
> not yet able to test on Alderlake hence not wanting to have a lot of
> untested code.
> 
> Thanks,
> Ian
> 
>>> Thanks,
>>> Ian
>>>
>>>> Thanks,
>>>> Kan
>>>>> +test_default_stat
>>>>> +test_topdown_groups
>>>>> +test_topdown_weak_groups
>>>>> +exit $err
