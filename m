Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BAA52A3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348079AbiEQNoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348033AbiEQNnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:43:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7322B4B851;
        Tue, 17 May 2022 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652795034; x=1684331034;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/CrgiSc59n20HmuyDaVZJ30MmKZxGwlUAzTZtAd8oek=;
  b=OI68qJ2vC6SSrd45+1cAD+WBqZkBX0vBLNuwGqlpVw2uHsj364GQ8UVl
   DDAzVc2hgUvSMz2fPgBNU5GsEQELPODpbRhOTUMKS+W0qpOGf+wuWIRZC
   v4vxNYLihLwP8Sjj2olvv8nVtC6+9Yyty66ENiGuXSlM9r1dHRs0bkkRv
   zUQLdWanWJRKywZBy643eR8HNhTPp4FeYgAz9z58UOqTbldEsG36oKH39
   61JyrBmQ1eyjPSWnY6W0BNYbYXu+hNwitl1fgLD7b4GX+6JyBpyXUlFVv
   5vOX9i6FYtzp6Nk6H/Uzm48nzMyF993IpVAYI8tYiM3IFQoMst2R4Uv76
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="268770233"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="268770233"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 06:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="713856488"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 17 May 2022 06:43:53 -0700
Received: from [10.252.209.74] (kliang2-MOBL.ccr.corp.intel.com [10.252.209.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 58CA558094D;
        Tue, 17 May 2022 06:43:52 -0700 (PDT)
Message-ID: <46c1257c-779f-8473-5531-fcc9f6380da7@linux.intel.com>
Date:   Tue, 17 May 2022 09:43:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V2 2/4] perf stat: Always keep perf metrics topdown events
 in a group
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com
References: <20220516152436.1104757-1-kan.liang@linux.intel.com>
 <20220516152436.1104757-3-kan.liang@linux.intel.com>
 <CAP-5=fUpUtWAME1wCmEycONzSwEe5m76b4jB14M8+B6Ptks3jQ@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUpUtWAME1wCmEycONzSwEe5m76b4jB14M8+B6Ptks3jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2022 11:11 PM, Ian Rogers wrote:
> On Mon, May 16, 2022 at 8:25 AM <kan.liang@linux.intel.com> wrote:
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
>> Factor out evsel__remove_from_group() to only remove the regular events
>> from the group.
>>
>> Remove evsel__must_be_in_group(), since no one use it anymore.
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
>>
>> Fixes: a9a1790247bd ("perf stat: Ensure group is defined on top of the same cpu mask")
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/builtin-stat.c |  7 +++----
>>   tools/perf/util/evlist.c  |  6 +-----
>>   tools/perf/util/evsel.c   | 13 +++++++++++--
>>   tools/perf/util/evsel.h   |  2 +-
>>   4 files changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index a96f106dc93a..75c88c7939b1 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -271,10 +271,9 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>>                          pr_warning("     %s: %s\n", evsel->name, buf);
>>                  }
>>
>> -               for_each_group_evsel(pos, leader) {
>> -                       evsel__set_leader(pos, pos);
>> -                       pos->core.nr_members = 0;
>> -               }
>> +               for_each_group_evsel(pos, leader)
>> +                       evsel__remove_from_group(pos, leader);
>> +
>>                  evsel->core.leader->nr_members = 0;
> 
> This shouldn't be necessary now.

It should point to itself which has been updated in 
evsel__remove_from_group().

I will remove it in V3.

> 
>>          }
>>   }
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index dfa65a383502..7fc544330fea 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -1795,11 +1795,7 @@ struct evsel *evlist__reset_weak_group(struct evlist *evsel_list, struct evsel *
>>                           * them. Some events, like Intel topdown, require being
>>                           * in a group and so keep these in the group.
>>                           */
>> -                       if (!evsel__must_be_in_group(c2) && c2 != leader) {
>> -                               evsel__set_leader(c2, c2);
>> -                               c2->core.nr_members = 0;
>> -                               leader->core.nr_members--;
>> -                       }
>> +                       evsel__remove_from_group(c2, leader);
>>
>>                          /*
>>                           * Set this for all former members of the group
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index b98882cbb286..deb428ee5e50 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -3083,7 +3083,16 @@ bool __weak arch_evsel__must_be_in_group(const struct evsel *evsel __maybe_unuse
>>          return false;
>>   }
>>
>> -bool evsel__must_be_in_group(const struct evsel *evsel)
>> +/*
>> + * Remove an event from a given group (leader).
>> + * Some events, e.g., perf metrics Topdown events,
>> + * must always be grouped. Ignore the events.
>> + */
>> +void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader)
>>   {
>> -       return arch_evsel__must_be_in_group(evsel);
>> +       if (!arch_evsel__must_be_in_group(evsel) && evsel != leader) {
>> +               evsel__set_leader(evsel, evsel);
>> +               evsel->core.nr_members = 0;
>> +               leader->core.nr_members--;
>> +       }
> 
> Should we also have:
> 
> if (leader->core.nr_members == 1)
>       leader->core.nr_members = 0;
> 
> Other wise say:
> 
> {instructions,cycles}
> 
> with a remove of cycles becomes:
> 
> {instructions}, cycles
> 
> rather than the previous:
> 
> instructions,cycles
> 
> Actually, looking at:
> https://lore.kernel.org/lkml/20220512061308.1152233-2-irogers@google.com/
> 
> + /* Reset the leader count if all entries were removed. */
> + if (leader->core.nr_members)
> + leader->core.nr_members = 0;
> 
> is wrong and should be:
> 
> + /* Reset the leader count if all entries were removed. */
> + if (leader->core.nr_members == 1)
> + leader->core.nr_members = 0;
> 

For a perf metrics topdown group, the leader's nr_members must be > 1 
after the reset. We should not clear it.
For the other weak group, the leader's nr_members should equal to 1 
after the reset. We only need to clear it for this case.
I think it makes sense.


Thanks,
Kan
> I'll fix and re-send.
> > Thanks,
> Ian
> 
>>   }
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index a36172ed4cf6..47f65f8e7c74 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -483,7 +483,7 @@ bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>>   bool evsel__is_leader(struct evsel *evsel);
>>   void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
>>   int evsel__source_count(const struct evsel *evsel);
>> -bool evsel__must_be_in_group(const struct evsel *evsel);
>> +void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader);
>>
>>   bool arch_evsel__must_be_in_group(const struct evsel *evsel);
>>
>> --
>> 2.35.1
>>
