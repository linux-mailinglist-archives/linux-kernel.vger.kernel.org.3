Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665D952687A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382991AbiEMR3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245080AbiEMR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:29:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2CA70904;
        Fri, 13 May 2022 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652462978; x=1683998978;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WfAKtIEgcPQQDu5S9iUmwG9FChc6zrUrAm3QtXiZGVc=;
  b=eRCs5QryJzu2+HbNsfvM85LW15tr42bql98bubkcjxVtmUo6eRikCmCy
   cbl/aMKwuvUK0X9sJd6KPRElWKsCLtwKQ3i5yQyLNpfT1zMd/yDZ9yQLy
   XjAvncdmpJk59sPJbKRw2TwQcIUrLtIQZaZRcun/QjoXttOteeLxYIxLi
   VXNr2l55319VgyZqyGwvlxSI4Y3WWzJWrptnkwYIXOBVQFT7l2V2emfBD
   Ji+vJT/8JyTqTOKmGkE9X+opuuwZ1J2HrzKkpBU/5rE8bZdy/3CBBCtGC
   qYkt5h1ZCZoMiEYXi6RGUXV19bE9YaIapgZsz+LOsSUKzwVsaPbdZrvP4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270297033"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270297033"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 10:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="573083834"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 13 May 2022 10:29:37 -0700
Received: from [10.252.212.211] (kliang2-MOBL.ccr.corp.intel.com [10.252.212.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C7AA8580A88;
        Fri, 13 May 2022 10:29:35 -0700 (PDT)
Message-ID: <06adb123-0519-4c4a-5c55-0f1729b9cd07@linux.intel.com>
Date:   Fri, 13 May 2022 13:29:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] perf stat: Always keep perf metrics topdown events in
 a group
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com
References: <20220513151554.1054452-1-kan.liang@linux.intel.com>
 <20220513151554.1054452-3-kan.liang@linux.intel.com>
 <CAP-5=fVv-f2JpWxOrHUFa73P-6z8JAR-+dcmL8MfYgLhpxe4zA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVv-f2JpWxOrHUFa73P-6z8JAR-+dcmL8MfYgLhpxe4zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2022 12:32 PM, Ian Rogers wrote:
> On Fri, May 13, 2022 at 8:16 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> If any member in a group has a different cpu mask than the other
>> members, the current perf stat disables group. when the perf metrics
>> topdown events are part of the group, the below <not supported> error
>> will be triggered.
>>
>> $ perf stat -e "{slots,topdown-retiring,uncore_imc_free_running_0/dclk/}" -a sleep 1
>> WARNING: grouped events cpus do not match, disabling group:
>>    anon group { slots, topdown-retiring, uncore_imc_free_running_0/dclk/ }
>>
>>   Performance counter stats for 'system wide':
>>
>>         141,465,174      slots
>>     <not supported>      topdown-retiring
>>       1,605,330,334      uncore_imc_free_running_0/dclk/
>>
>> The perf metrics topdown events must always be grouped with a slots
>> event as leader.
>>
>> With the patch, the topdown events aren't broken from the group for the
>> splitting.
>>
>> $ perf stat -e "{slots,topdown-retiring,uncore_imc_free_running_0/dclk/}" -a sleep 1
>> WARNING: grouped events cpus do not match, disabling group:
>>    anon group { slots, topdown-retiring, uncore_imc_free_running_0/dclk/ }
>>
>>   Performance counter stats for 'system wide':
>>
>>         346,110,588      slots
>>         124,608,256      topdown-retiring
>>       1,606,869,976      uncore_imc_free_running_0/dclk/
>>
>>         1.003877592 seconds time elapsed
> 
> Nice! This is based on:
> https://lore.kernel.org/lkml/20220512061308.1152233-2-irogers@google.com/
> You may end up with a group with the leader having a group count of 1
> (itself). I explicitly zeroed that in the change above, but this may
> be unnecessary. Maybe we should move this code to helper functions for
> sharing and consistency on what the leader count should be.
> 

I think the current code has already did evsel->core.leader->nr_members 
= 0; for the leader. So I don't change it.

Yes, a helper function seems reasonable. I will add it in V2.

Thanks,
Kan
> Thanks,
> Ian
> 
>> Fixes: a9a1790247bd ("perf stat: Ensure group is defined on top of the same cpu mask")
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/builtin-stat.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index a96f106dc93a..af2248868a4f 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -272,8 +272,11 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>>                  }
>>
>>                  for_each_group_evsel(pos, leader) {
>> -                       evsel__set_leader(pos, pos);
>> -                       pos->core.nr_members = 0;
>> +                       if (!evsel__must_be_in_group(pos) && pos != leader) {
>> +                               evsel__set_leader(pos, pos);
>> +                               pos->core.nr_members = 0;
>> +                               leader->core.nr_members--;
>> +                       }
>>                  }
>>                  evsel->core.leader->nr_members = 0;
>>          }
>> --
>> 2.35.1
>>
