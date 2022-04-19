Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1BD506F91
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbiDSN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbiDSN7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:59:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 414AF38BEA;
        Tue, 19 Apr 2022 06:56:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 047E31063;
        Tue, 19 Apr 2022 06:56:30 -0700 (PDT)
Received: from [10.32.36.25] (e121896.Emea.Arm.com [10.32.36.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC7023F766;
        Tue, 19 Apr 2022 06:56:26 -0700 (PDT)
Message-ID: <d73b0dbf-9878-2c1f-5246-79de08da97d4@arm.com>
Date:   Tue, 19 Apr 2022 14:56:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 2/8] perf: Extend branch type classification
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
 <20220404045046.634522-3-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220404045046.634522-3-anshuman.khandual@arm.com>
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
> branch_entry.type now has ran out of space to accommodate more branch types
> classification. This will prevent perf branch stack implementation on arm64
> (via BRBE) to capture all available branch types. Extending this bit field
> i.e branch_entry.type [4 bits] is not an option as it will break user space
> ABI both for little and big endian perf tools.
> 
> Extend branch classification with a new field branch_entry.new_type via a
> new branch type PERF_BR_EXTEND_ABI in branch_entry.type. Perf tools which
> could decode PERF_BR_EXTEND_ABI, will then parse branch_entry.new_type as
> well.
> 
> branch_entry.new_type is a 4 bit field which can hold upto 16 branch types.
> The first three branch types will hold various generic page faults followed
> by five architecture specific branch types, which can be overridden by the
> platform for specific use cases. These architecture specific branch types
> gets overridden on arm64 platform for BRBE implementation.
> 
> New generic branch types
> 
> - PERF_BR_NEW_FAULT_ALGN
> - PERF_BR_NEW_FAULT_DATA
> - PERF_BR_NEW_FAULT_INST
> 
> New arch specific branch types
> 
> - PERF_BR_NEW_ARCH_1
> - PERF_BR_NEW_ARCH_2
> - PERF_BR_NEW_ARCH_3
> - PERF_BR_NEW_ARCH_4
> - PERF_BR_NEW_ARCH_5
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

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  include/uapi/linux/perf_event.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 26d8f0b5ac0d..d29280adc3c4 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
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
