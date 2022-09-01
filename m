Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55055A8D12
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiIAFHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiIAFHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:07:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 020FA112EC7;
        Wed, 31 Aug 2022 22:07:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA834D6E;
        Wed, 31 Aug 2022 22:07:38 -0700 (PDT)
Received: from [10.162.43.7] (unknown [10.162.43.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 610963F71A;
        Wed, 31 Aug 2022 22:07:27 -0700 (PDT)
Message-ID: <9b1a8ebd-0562-f104-7439-308282f7fb52@arm.com>
Date:   Thu, 1 Sep 2022 10:37:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V7 6/8] perf/tools: Extend branch type classification
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, mark.rutland@arm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220824044822.70230-1-anshuman.khandual@arm.com>
 <20220824044822.70230-7-anshuman.khandual@arm.com>
 <Yw59CkHUVbfrHdkh@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Yw59CkHUVbfrHdkh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/22 02:41, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 24, 2022 at 10:18:20AM +0530, Anshuman Khandual escreveu:
>> This updates the perf tool with generic branch type classification with new
>> ABI extender place holder i.e PERF_BR_EXTEND_ABI, the new 4 bit branch type
>> field i.e perf_branch_entry.new_type, new generic page fault related branch
>> types and some arch specific branch types as added earlier in the kernel.
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
>>  tools/include/uapi/linux/perf_event.h | 16 ++++++++-
>>  tools/perf/builtin-script.c           |  2 +-
>>  tools/perf/util/branch.c              | 52 ++++++++++++++++++++++++++-
>>  tools/perf/util/branch.h              |  6 +++-
>>  tools/perf/util/session.c             |  2 +-
>>  5 files changed, 73 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index 146c137ff0c1..0f7c7ce29899 100644
>> --- a/tools/include/uapi/linux/perf_event.h
>> +++ b/tools/include/uapi/linux/perf_event.h
>> @@ -255,9 +255,22 @@ enum {
>>  	PERF_BR_IRQ		= 12,	/* irq */
>>  	PERF_BR_SERROR		= 13,	/* system error */
>>  	PERF_BR_NO_TX		= 14,	/* not in transaction */
>> +	PERF_BR_EXTEND_ABI	= 15,	/* extend ABI */
>>  	PERF_BR_MAX,
>>  };
>>  
>> +enum {
>> +	PERF_BR_NEW_FAULT_ALGN		= 0,    /* Alignment fault */
>> +	PERF_BR_NEW_FAULT_DATA		= 1,    /* Data fault */
>> +	PERF_BR_NEW_FAULT_INST		= 2,    /* Inst fault */
>> +	PERF_BR_NEW_ARCH_1		= 3,    /* Architecture specific */
>> +	PERF_BR_NEW_ARCH_2		= 4,    /* Architecture specific */
>> +	PERF_BR_NEW_ARCH_3		= 5,    /* Architecture specific */
>> +	PERF_BR_NEW_ARCH_4		= 6,    /* Architecture specific */
>> +	PERF_BR_NEW_ARCH_5		= 7,    /* Architecture specific */
>> +	PERF_BR_NEW_MAX,
>> +};
>> +
>>  #define PERF_SAMPLE_BRANCH_PLM_ALL \
>>  	(PERF_SAMPLE_BRANCH_USER|\
>>  	 PERF_SAMPLE_BRANCH_KERNEL|\
>> @@ -1375,7 +1388,8 @@ struct perf_branch_entry {
>>  		abort:1,    /* transaction abort */
>>  		cycles:16,  /* cycle count to last branch */
>>  		type:4,     /* branch type */
>> -		reserved:40;
>> +		new_type:4, /* additional branch type */
>> +		reserved:36;
>>  };
>>  
>>  union perf_sample_weight {
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 13580a9c50b8..585171479876 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -877,7 +877,7 @@ static int print_bstack_flags(FILE *fp, struct branch_entry *br)
>>  		       br->flags.in_tx ? 'X' : '-',
>>  		       br->flags.abort ? 'A' : '-',
>>  		       br->flags.cycles,
>> -		       br->flags.type ? branch_type_name(br->flags.type) : "-");
>> +		       get_branch_type(br));
>>  }
>>  
>>  static int perf_sample__fprintf_brstack(struct perf_sample *sample,
>> diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
>> index abc673347bee..6d962b0a4532 100644
>> --- a/tools/perf/util/branch.c
>> +++ b/tools/perf/util/branch.c
>> @@ -21,7 +21,10 @@ void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
>>  	if (flags->type == PERF_BR_UNKNOWN || from == 0)
>>  		return;
>>  
>> -	st->counts[flags->type]++;
>> +	if (flags->type == PERF_BR_EXTEND_ABI)
>> +		st->new_counts[flags->new_type]++;
>> +	else
>> +		st->counts[flags->type]++;
>>  
>>  	if (flags->type == PERF_BR_COND) {
>>  		if (to > from)
>> @@ -36,6 +39,25 @@ void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
>>  		st->cross_4k++;
>>  }
>>  
>> +const char *branch_new_type_name(int new_type)
>> +{
>> +	const char *branch_new_names[PERF_BR_NEW_MAX] = {
>> +		"FAULT_ALGN",
>> +		"FAULT_DATA",
>> +		"FAULT_INST",
>> +		"ARCH_1",
>> +		"ARCH_2",
>> +		"ARCH_3",
>> +		"ARCH_4",
>> +		"ARCH_5"
>> +	};
>> +
>> +	if (new_type >= 0 && new_type < PERF_BR_NEW_MAX)
>> +		return branch_new_names[new_type];
>> +
>> +	return NULL;
>> +}
>> +
>>  const char *branch_type_name(int type)
>>  {
>>  	const char *branch_names[PERF_BR_MAX] = {
>> @@ -62,6 +84,17 @@ const char *branch_type_name(int type)
>>  	return NULL;
>>  }
>>  
>> +const char *get_branch_type(struct branch_entry *e)
>> +{
>> +	if (e->flags.type == PERF_BR_UNKNOWN)
>> +		return "";
>> +
>> +	if (e->flags.type == PERF_BR_EXTEND_ABI)
>> +		return branch_new_type_name(e->flags.new_type);
>> +
>> +	return branch_type_name(e->flags.type);
>> +}
>> +
>>  void branch_type_stat_display(FILE *fp, struct branch_type_stat *st)
>>  {
>>  	u64 total = 0;
>> @@ -108,6 +141,15 @@ void branch_type_stat_display(FILE *fp, struct branch_type_stat *st)
>>  				100.0 *
>>  				(double)st->counts[i] / (double)total);
>>  	}
>> +
>> +	for (i = 0; i < PERF_BR_NEW_MAX; i++) {
>> +		if (st->new_counts[i] > 0)
>> +			fprintf(fp, "\n%8s: %5.1f%%",
>> +				branch_new_type_name(i),
>> +				100.0 *
>> +				(double)st->new_counts[i] / (double)total);
>> +	}
>> +
> Strange:
> 
>   75     8.89 ubuntu:20.04-x-powerpc64el    : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1~20.04)
>         inlined from 'branch_type_stat_display' at util/branch.c:152:4:
>     /usr/powerpc64le-linux-gnu/include/bits/stdio2.h:100:10: error: '%8s' directive argument is null [-Werror=format-overflow=]
>       100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       101 |    __va_arg_pack ());
>           |    ~~~~~~~~~~~~~~~~~
> 

Indeed. But this new code block here looks exact same like the previous and existing one
i.e with branch_new_name() and PERF_BR_NEW_MAX. The complain is that - '%8s' directive
argument is NULL. This warning might just be a false positive [1], because of a compiler
problem on powerpc64el ? But please do let me know if something needs to be changed here
to avoid this warning.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90036

- Anshuman
