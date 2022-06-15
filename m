Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4630254C01A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347161AbiFODV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiFODV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:21:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D05FC4F1E9;
        Tue, 14 Jun 2022 20:21:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84187153B;
        Tue, 14 Jun 2022 20:21:56 -0700 (PDT)
Received: from [192.168.0.146] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F6083F66F;
        Tue, 14 Jun 2022 20:21:50 -0700 (PDT)
Message-ID: <8bfce917-84a6-23a2-d926-a1efa901f4f1@arm.com>
Date:   Wed, 15 Jun 2022 08:51:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V6 6/8] perf/tools: Extend branch type classification
Content-Language: en-US
To:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        acme@kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220610035101.424112-1-anshuman.khandual@arm.com>
 <20220610035101.424112-7-anshuman.khandual@arm.com>
 <e0f29bc9-eae4-e433-2d4e-4dd53e31967d@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <e0f29bc9-eae4-e433-2d4e-4dd53e31967d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/22 22:23, German Gomez wrote:
> Hi Anshuman,
> 
> On 10/06/2022 04:50, Anshuman Khandual wrote:
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
>> index 26d8f0b5ac0d..d29280adc3c4 100644
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
>> @@ -1372,7 +1385,8 @@ struct perf_branch_entry {
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
>> index c689054002cc..d4d581230f23 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -866,7 +866,7 @@ static int print_bstack_flags(FILE *fp, struct branch_entry *br)
>>  		       br->flags.in_tx ? 'X' : '-',
>>  		       br->flags.abort ? 'A' : '-',
>>  		       br->flags.cycles,
>> -		       br->flags.type ? branch_type_name(br->flags.type) : "-");
>> +		       get_branch_type(br));
> (Small comment below regarding this line)
> 
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
> There is a small change of behavior in "perf script --field brstack".
> Unknown branches were printed as "-" before but now it's an empty
> string.

get_branch_type() replaces print output in two different functions.
branch_stack__printf() used to print a space " " for PERF_BR_UNKNOWN,
and print_bstack_flags() used to print a "-" for PERF_BR_UNKNOWN.
When they are factorized via get_branch_type(), one of those print
formats need to be choosen.
