Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B359D4D58D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345962AbiCKD0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345934AbiCKD0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:26:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB7BBC5D8F;
        Thu, 10 Mar 2022 19:25:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 205A514BF;
        Thu, 10 Mar 2022 19:25:42 -0800 (PST)
Received: from [10.163.34.78] (unknown [10.163.34.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9704D3F7D8;
        Thu, 10 Mar 2022 19:25:37 -0800 (PST)
Message-ID: <d69ff24e-ae65-c900-715f-c951e7795a79@arm.com>
Date:   Fri, 11 Mar 2022 08:55:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 4/8] perf: Capture branch privilege information
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org
Cc:     suzuki.poulose@arm.com, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220309033642.144769-1-anshuman.khandual@arm.com>
 <20220309033642.144769-5-anshuman.khandual@arm.com>
 <6dc9a4e5-8f74-dfb5-d9f6-60e9d6b65146@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <6dc9a4e5-8f74-dfb5-d9f6-60e9d6b65146@arm.com>
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



On 3/10/22 15:51, James Clark wrote:
> 
> 
> On 09/03/2022 03:36, Anshuman Khandual wrote:
>> Platforms like arm64 could capture privilege level information for all the
>> branch records. Hence this adds a new element in the struct branch_entry to
>> record the privilege level information, which could be requested through a
>> new event.attr.branch_sample_type based flag PERF_SAMPLE_BRANCH_PRIV_SAVE.
>> This flag helps user choose whether privilege information is captured.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  include/uapi/linux/perf_event.h | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index d29280adc3c4..0e96e2017f68 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -204,6 +204,8 @@ enum perf_branch_sample_type_shift {
>>  
>>  	PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT	= 17, /* save low level index of raw branch records */
>>  
>> +	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privillege mode */
>> +
>>  	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
>>  };
>>  
>> @@ -233,6 +235,8 @@ enum perf_branch_sample_type {
>>  
>>  	PERF_SAMPLE_BRANCH_HW_INDEX	= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
>>  
>> +	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
>> +
>>  	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
>>  };
>>  
>> @@ -271,6 +275,12 @@ enum {
>>  	PERF_BR_NEW_MAX,
>>  };
>>  
>> +enum {
>> +	PERF_BR_USER	= 0,
>> +	PERF_BR_KERNEL	= 1,
>> +	PERF_BR_HV	= 2,
>> +};
> 
> 0 should be "PERF_BR_PRIV_UNKNOWN" so userspace knows if it was not enabled
> otherwise it will look like all samples are PERF_BR_USER when actually
> priv type recording was just disabled.

Makes sense.

> 
> I think it's not even always possible to go backwards from a sample to
> work out what the event attributes were so this can be interpreted (taking
> all of perf script and every corner case into account).
> 
> Starting at 0=UNKNOWN is consistent with the other fields and makes parsing
> it a whole lot easier.

Fair enough, will start the enum with PERF_BR_PRIV_UNKNOWN and expand the
field 'perf_branch_entry.priv' to 3 bits instead, in order to accommodate
any future needs regarding other captured privilege levels.

> 
> James
> 
>> +
>>  #define PERF_SAMPLE_BRANCH_PLM_ALL \
>>  	(PERF_SAMPLE_BRANCH_USER|\
>>  	 PERF_SAMPLE_BRANCH_KERNEL|\
>> @@ -1386,7 +1396,8 @@ struct perf_branch_entry {
>>  		cycles:16,  /* cycle count to last branch */
>>  		type:4,     /* branch type */
>>  		new_type:4, /* additional branch type */
>> -		reserved:36;
>> +		priv:2,     /* privilege level */
>> +		reserved:34;
>>  };
>>  
>>  union perf_sample_weight {
