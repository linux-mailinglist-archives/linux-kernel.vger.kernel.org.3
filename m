Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232194D16E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345524AbiCHMKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiCHMKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:10:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1743E340EE;
        Tue,  8 Mar 2022 04:09:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC230139F;
        Tue,  8 Mar 2022 04:09:33 -0800 (PST)
Received: from [10.57.40.166] (unknown [10.57.40.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7609C3FA5D;
        Tue,  8 Mar 2022 04:09:32 -0800 (PST)
Message-ID: <937810c4-a752-18ec-523d-fc4c9f2d75c7@arm.com>
Date:   Tue, 8 Mar 2022 12:09:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] perf script: Output branch sample type
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, acme@kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     german.gomez@arm.com, leo.yan@linaro.com,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220307171917.2555829-1-james.clark@arm.com>
 <20220307171917.2555829-5-james.clark@arm.com>
 <3b6007ef-1ad8-c495-26aa-7974af8faefa@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <3b6007ef-1ad8-c495-26aa-7974af8faefa@arm.com>
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



On 08/03/2022 05:22, Anshuman Khandual wrote:
> 
> 
> On 3/7/22 22:49, James Clark wrote:
>> The type info is saved when using '-j save_type'. Output this in perf
> 
> Mentioning PERF_SAMPLE_BRANCH_CALL_STACK here as well might be better.
> 
>> script so it can be accessed by other tools or for debugging.
>>
>> It's appended to the end of the list of fields so any existing tools
>> that split on / and access fields via an index are not affected. Also
>> output '-' instead of 'N/A' when the branch type isn't saved because /
>> is used as a field separator.
> 
> Did not get it. Why 'N/A' should have been used anyway ?

N/A would be printed if branch type isn't saved because then branch type == 0.
N/A is the name that's assigned to the 0 entry of the branch type name list.

> 
>>
>> Entries before this change look like this:
>>
>>   0xaaaadb350838/0xaaaadb3507a4/P/-/-/0
>>
>> And afterwards like this:
>>
>>   0xaaaadb350838/0xaaaadb3507a4/P/-/-/0/CALL
>>
>> or this if no type info is saved:
>>
>>   0x7fb57586df6b/0x7fb5758731f0/P/-/-/143/-
> 
> 143 ?

Just random output from my laptop probably. It's not supposed to match up
with the previous entries, it's a new run and a new set of output.

> 
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/builtin-script.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index fac2e9470926..5e4a262a6825 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -859,11 +859,12 @@ mispred_str(struct branch_entry *br)
>>  
>>  static int print_bstack_flags(FILE *fp, struct branch_entry *br)
>>  {
>> -	return fprintf(fp, "/%c/%c/%c/%d ",
>> +	return fprintf(fp, "/%c/%c/%c/%d/%s ",
>>  		       mispred_str(br),
>>  		       br->flags.in_tx ? 'X' : '-',
>>  		       br->flags.abort ? 'A' : '-',
>> -		       br->flags.cycles);
>> +		       br->flags.cycles,
>> +		       br->flags.type ? branch_type_name(br->flags.type) : "-");
>>  }
>>  
>>  static int perf_sample__fprintf_brstack(struct perf_sample *sample,
> 
> 
> LGTM but as mentioned before, I hope this does not affect any existing
> parsing tools.

It's possible for this perf script change. But any parser would have to be splitting on
/ and spaces and indexing into the result so I can't see how it's possible to make a parser
that wouldn't handle an entry appended to the end.

I imagine someone could have an assert that checks the number of results after the split on /.
But if they added that I'm assuming they were thinking of the possibility that extra entries
could be added so handle it properly.
