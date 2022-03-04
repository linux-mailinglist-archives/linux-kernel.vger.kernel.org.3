Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148184CD0E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiCDJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiCDJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:12:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2899E1A39EE;
        Fri,  4 Mar 2022 01:11:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFCE41424;
        Fri,  4 Mar 2022 01:11:26 -0800 (PST)
Received: from [10.57.42.166] (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 789483F73D;
        Fri,  4 Mar 2022 01:11:25 -0800 (PST)
Message-ID: <bfe873a2-4dbb-8ad0-5089-61ccf6a10eeb@arm.com>
Date:   Fri, 4 Mar 2022 09:11:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] perf: Set build-id using build-id header on new mmap
 records
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        coresight@lists.linaro.org, Denis Nikitin <denik@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220224171955.862983-1-james.clark@arm.com>
 <20220224171955.862983-2-james.clark@arm.com> <YhwAPrOP/ky4HLfC@krava>
 <3dc14ad9-8ce1-a2e3-3bab-953b79af82be@arm.com> <YiCoSbYHDF8jesxp@krava>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <YiCoSbYHDF8jesxp@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/03/2022 11:36, Jiri Olsa wrote:
> On Wed, Mar 02, 2022 at 04:20:00PM +0000, James Clark wrote:
>>
>>
>> On 27/02/2022 22:50, Jiri Olsa wrote:
>>> On Thu, Feb 24, 2022 at 05:19:55PM +0000, James Clark wrote:
>>>> MMAP records that occur after the build-id header is parsed do not have
>>>> their build-id set even if the filename matches an entry from the
>>>> header. Set the build-id on these dsos as long as the MMAP record
>>>> doesn't have its own build-id set.
>>>>
>>>> This fixes an issue with off target analysis where the local version of
>>>> a dso is loaded rather than one from ~/.debug via a build-id.
>>>
>>> nice catch :)
>>>
>>>>
>>>> Reported-by: Denis Nikitin <denik@chromium.org>
>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>>> ---
>>>>  tools/perf/util/dso.h    |  1 +
>>>>  tools/perf/util/header.c |  1 +
>>>>  tools/perf/util/map.c    | 16 ++++++++++++++--
>>>>  3 files changed, 16 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>>>> index 011da3924fc1..3a9fd4d389b5 100644
>>>> --- a/tools/perf/util/dso.h
>>>> +++ b/tools/perf/util/dso.h
>>>> @@ -167,6 +167,7 @@ struct dso {
>>>>  	enum dso_load_errno	load_errno;
>>>>  	u8		 adjust_symbols:1;
>>>>  	u8		 has_build_id:1;
>>>> +	u8		 header_build_id:1;
>>>>  	u8		 has_srcline:1;
>>>>  	u8		 hit:1;
>>>>  	u8		 annotate_warned:1;
>>>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>>>> index 6da12e522edc..571d73d4f976 100644
>>>> --- a/tools/perf/util/header.c
>>>> +++ b/tools/perf/util/header.c
>>>> @@ -2200,6 +2200,7 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>>>>  
>>>>  		build_id__init(&bid, bev->data, size);
>>>>  		dso__set_build_id(dso, &bid);
>>>> +		dso->header_build_id = 1;
>>>>  
>>>>  		if (dso_space != DSO_SPACE__USER) {
>>>>  			struct kmod_path m = { .name = NULL, };
>>>> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
>>>> index 1803d3887afe..4ae91e491e23 100644
>>>> --- a/tools/perf/util/map.c
>>>> +++ b/tools/perf/util/map.c
>>>> @@ -127,7 +127,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>>>>  
>>>>  	if (map != NULL) {
>>>>  		char newfilename[PATH_MAX];
>>>> -		struct dso *dso;
>>>> +		struct dso *dso, *header_bid_dso;
>>>>  		int anon, no_dso, vdso, android;
>>>>  
>>>>  		android = is_android_lib(filename);
>>>> @@ -185,7 +185,19 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>>>>  
>>>>  		if (build_id__is_defined(bid))
>>>>  			dso__set_build_id(dso, bid);
>>>> -
>>>> +		else {
>>>
>>> nit please add { } to the if clause as well
>>>
>>>> +			/*
>>>> +			 * If the mmap event had no build ID, search for an existing dso from the
>>>> +			 * build ID header by name. Otherwise only the dso loaded at the time of
>>>> +			 * reading the header will have the build ID set and all future mmaps will
>>>> +			 * have it missing.
>>>> +			 */
>>>> +			header_bid_dso = __dsos__find(&machine->dsos, filename, false);
>>>
>>> is this 'perf top' safe? I think dso should be added in the
>>> same thread, but please check and add comment why we don't
>>> need locking in here
>>
>> Seems like there are multiple synthesize_threads_workers using the same machine->dsos object so
>> I think locking is needed.
>>
>> At first I thought of doing this:
>>
>>   diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
>>   index 4ae91e491e23..b87b81e3d41c 100644
>>   --- a/tools/perf/util/map.c
>>   +++ b/tools/perf/util/map.c
>>   @@ -192,7 +192,9 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>>                            * reading the header will have the build ID set and all future mmaps will
>>                            * have it missing.
>>                            */
>>   +                       down_read(&machine->dsos.lock);
>>                           header_bid_dso = __dsos__find(&machine->dsos, filename, false);
>>   +                       up_read(&machine->dsos.lock);
>>                           if (header_bid_dso && header_bid_dso->header_build_id) {
>>                                   dso__set_build_id(dso, &header_bid_dso->bid);
>>                                   dso->header_build_id = 1;
>>
>> But then I was wondering why it doesn't need a write lock all the way from machine__findnew_dso_id() to
>> dso__put()? At the moment there are writes to the dso like dso__set_loaded(), dso->nsinfo = nsi and
>> dso__set_build_id(), so another thread could find the dso in a partially constructed state.
> 
> I think that's fine, machine__findnew_dso_id takes the dso ref so
> the real 'release' is when the machine object goes down at dsos__purge
> 
>>
>> Not sure if this is an issue currently without my patch, but at least with it they would have to be found
>> with header_build_id already set to 1 otherwise it will mess things up.
> 
> as for the partial changes I think it's also fine, because it happens
> at separate places.. we'd need to investigate specific example to see
> if there's a problem
> 
>>
>> Extending the write lock outside of machine__findnew_dso_id() is difficult because it already
>> releases it before it returns. Does it need to be changed so that machine__findnew_dso_id() takes all the
>> arguments needed to construct it inside the lock?
> 
> the change above should do it.. as for top threads I don't think
> it actually matters because there's events processing and hists
> processing, and I did not find them clashing in this.. but there's
> some setup session code that touches this, so it's better to be safe

Ok yes I think I agree. The header flag isn't important for perf top so having it all
constructed in place isn't necessary.

I've submitted v2 with this change.

Thanks for the review.

> 
> thanks,
> jirka
