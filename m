Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2DB56879C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiGFMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiGFMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:00:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58899FE1;
        Wed,  6 Jul 2022 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657108846; x=1688644846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lSsbiZV4i1tfq1voLAnABNCQGrd6cW+m6LcWKau0lI8=;
  b=JfbcplSe7ObJwnS1xTwEhqSqtCRcanNrSDStmJDOSf0xkMlrDr3jeqic
   R6BqzNJmmkznGvlBeF7T594WdriP4BHflNtuei8zA7CpiuZdemcgNsn5E
   eDnR1HCK+6iOtpfFtH345FxI98RIWh55cVYFGrDsxWXbR9OUbkO/j10wu
   TrMlHhKij7NgPu46+w4JHBzlxmHVM4sseIt/aroUvQISCaoHf4BL+q8iv
   QvvaoemitnIv8ycetbj/h/TW6pmwxLOiViHZj2FbJfmXh73PDCIUMMdnC
   ejUeNzmahoFPPV7hZBIImIaSO5Cgn8tXGSzAkUl0calTNTJ7X0V8rQc9k
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="345411669"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="345411669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 05:00:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="568041214"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.28.72]) ([10.255.28.72])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 05:00:43 -0700
Message-ID: <4b9d07a2-8d2b-d025-e3da-e2af38a07c67@linux.intel.com>
Date:   Wed, 6 Jul 2022 20:00:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] perf record: Fix "--per-thread" option for hybrid
 machines
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>, acme@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20220702023536.2661899-1-zhengjun.xing@linux.intel.com>
 <9fde1c3a-3fdb-b2b7-7448-8de608853bd2@linux.intel.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <9fde1c3a-3fdb-b2b7-7448-8de608853bd2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/2022 9:22 PM, Liang, Kan wrote:
> 
> 
> On 7/1/2022 10:35 PM, zhengjun.xing@linux.intel.com wrote:
>> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>
>> Commit b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems to
>> collect metadata records") adds a dummy event on hybrid systems to fix 
>> the
>> symbol "unknown" issue when the workload is created in a P-core but runs
>> on an E-core. When "--per-thread" is enabled, the nr_cpus is reduced 
>> to 1,
>>   adding a dummy event is useless for this issue, and it will also cause
> 
> A dummy event is required since a mmap event may be loaded at runtime on 
> any CPU. Thanks Adrian to point it out.
> 

There will be a kernel patch to fix the "mmap fail" issue, I will drop 
this one and continue to fix other "per-thread" issues based on the 
kernel patch.


> Thanks,
> Kan
> 
>> "failed to mmap with 22 (Invalid argument)". This patch stops adding 
>> dummy
>> events when the option "--per-thread" is enabled, then the option can 
>> work
>> on hybrid machines.
>>
>> Before:
>>
>>   # ./perf record -e cycles:u --per-thread  sleep 1
>>   failed to mmap with 22 (Invalid argument)
>>
>> After:
>>
>>   # ./perf record -e cycles:u --per-thread  sleep 1
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.002 MB perf.data (6 samples) ]
>>
>> Fixes: b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems 
>> to collect metadata records")
>> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/builtin-record.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index e1edd4e98358..44ea2dd424fe 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1223,7 +1223,7 @@ static int record__open(struct record *rec)
>>        * of waiting or event synthesis.
>>        */
>>       if (opts->initial_delay || target__has_cpu(&opts->target) ||
>> -        perf_pmu__has_hybrid()) {
>> +        (perf_pmu__has_hybrid() && !opts->target.per_thread)) {
>>           pos = evlist__get_tracking_event(evlist);
>>           if (!evsel__is_dummy_event(pos)) {
>>               /* Set up dummy event. */

-- 
Zhengjun Xing
