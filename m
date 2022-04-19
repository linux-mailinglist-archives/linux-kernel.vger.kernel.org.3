Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11095506F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345983AbiDSOEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiDSOEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:04:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 650C539145;
        Tue, 19 Apr 2022 07:01:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2269E1063;
        Tue, 19 Apr 2022 07:01:37 -0700 (PDT)
Received: from [10.32.36.25] (e121896.Emea.Arm.com [10.32.36.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 250543F766;
        Tue, 19 Apr 2022 07:01:33 -0700 (PDT)
Message-ID: <bfd96c4a-ae39-da29-b785-76b2308cd4ff@arm.com>
Date:   Tue, 19 Apr 2022 15:01:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 6/8] perf/tools: Extend branch type classification
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, acme@kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220404045046.634522-1-anshuman.khandual@arm.com>
 <20220404045046.634522-7-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220404045046.634522-7-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2022 05:50, Anshuman Khandual wrote:
> This updates the perf tool with generic branch type classification with new
> ABI extender place holder i.e PERF_BR_EXTEND_ABI, the new 4 bit branch type
> field i.e perf_branch_entry.new_type, new generic page fault related branch
> types and some arch specific branch types as added earlier in the kernel.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  tools/include/uapi/linux/perf_event.h | 16 +++++++++++++++-
>  tools/perf/util/branch.c              |  3 ++-
>  tools/perf/util/branch.h              |  3 ++-
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 26d8f0b5ac0d..d29280adc3c4 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -255,9 +255,22 @@ enum {
>  	PERF_BR_IRQ		= 12,	/* irq */
>  	PERF_BR_SERROR		= 13,	/* system error */
>  	PERF_BR_NO_TX		= 14,	/* not in transaction */
> +	PERF_BR_EXTEND_ABI	= 15,	/* extend ABI */
>  	PERF_BR_MAX,
>  };
>  
> +enum {
> +	PERF_BR_NEW_FAULT_ALGN		= 0,    /* Alignment fault */
> +	PERF_BR_NEW_FAULT_DATA		= 1,    /* Data fault */
> +	PERF_BR_NEW_FAULT_INST		= 2,    /* Inst fault */
> +	PERF_BR_NEW_ARCH_1		= 3,    /* Architecture specific */
> +	PERF_BR_NEW_ARCH_2		= 4,    /* Architecture specific */
> +	PERF_BR_NEW_ARCH_3		= 5,    /* Architecture specific */
> +	PERF_BR_NEW_ARCH_4		= 6,    /* Architecture specific */
> +	PERF_BR_NEW_ARCH_5		= 7,    /* Architecture specific */
> +	PERF_BR_NEW_MAX,
> +};
> +
>  #define PERF_SAMPLE_BRANCH_PLM_ALL \
>  	(PERF_SAMPLE_BRANCH_USER|\
>  	 PERF_SAMPLE_BRANCH_KERNEL|\
> @@ -1372,7 +1385,8 @@ struct perf_branch_entry {
>  		abort:1,    /* transaction abort */
>  		cycles:16,  /* cycle count to last branch */
>  		type:4,     /* branch type */
> -		reserved:40;
> +		new_type:4, /* additional branch type */
> +		reserved:36;
>  };
>  
>  union perf_sample_weight {
> diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
> index abc673347bee..4bd52de0527c 100644
> --- a/tools/perf/util/branch.c
> +++ b/tools/perf/util/branch.c
> @@ -53,7 +53,8 @@ const char *branch_type_name(int type)
>  		"ERET",
>  		"IRQ",
>  		"SERROR",
> -		"NO_TX"
> +		"NO_TX",
> +		"EXTEND_ABI"

Hi Anshuman,

I still think it's best to make this change a bit more transparent to the internals
of perf and to users. For example if they dump the file, they'll see "EXTEND_ABI"
printed out, but what they really want to see is whatever the branch type is,
including the new types.

The same goes for any function that accesses the branch type (if there is one),
it should just return the final type and skip the details about EXTEND_ABI.

If that was done I don't think you'd need to add that string because as it would
never get printed.

Thanks
James

>  	};
>  
>  	if (type >= 0 && type < PERF_BR_MAX)
> diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
> index 17b2ccc61094..37b6ed546c46 100644
> --- a/tools/perf/util/branch.h
> +++ b/tools/perf/util/branch.h
> @@ -24,7 +24,8 @@ struct branch_flags {
>  			u64 abort:1;
>  			u64 cycles:16;
>  			u64 type:4;
> -			u64 reserved:40;
> +			u64 new_type:4;
> +			u64 reserved:36;
>  		};
>  	};
>  };
