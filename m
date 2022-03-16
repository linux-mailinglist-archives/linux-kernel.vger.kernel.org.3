Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F36C4DB719
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350737AbiCPR11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiCPR1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:27:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11010AE66;
        Wed, 16 Mar 2022 10:26:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA3B31476;
        Wed, 16 Mar 2022 10:26:10 -0700 (PDT)
Received: from [10.57.44.7] (unknown [10.57.44.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C82FB3F7D7;
        Wed, 16 Mar 2022 10:26:08 -0700 (PDT)
Message-ID: <73353bec-6949-dd0b-ff1c-a8143e169602@arm.com>
Date:   Wed, 16 Mar 2022 17:26:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V4 04/10] perf: Capture branch privilege information
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
References: <20220315053516.431515-1-anshuman.khandual@arm.com>
 <20220315053516.431515-5-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220315053516.431515-5-anshuman.khandual@arm.com>
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



On 15/03/2022 05:35, Anshuman Khandual wrote:
> Platforms like arm64 could capture privilege level information for all the
> branch records. Hence this adds a new element in the struct branch_entry to
> record the privilege level information, which could be requested through a
> new event.attr.branch_sample_type based flag PERF_SAMPLE_BRANCH_PRIV_SAVE.
> This flag helps user choose whether privilege information is captured.
> 

Reviewed-by: James Clark <james.clark@arm.com>

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
>  include/uapi/linux/perf_event.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index d29280adc3c4..193dba2ecdc1 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -204,6 +204,8 @@ enum perf_branch_sample_type_shift {
>  
>  	PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT	= 17, /* save low level index of raw branch records */
>  
> +	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privilege mode */
> +
>  	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
>  };
>  
> @@ -233,6 +235,8 @@ enum perf_branch_sample_type {
>  
>  	PERF_SAMPLE_BRANCH_HW_INDEX	= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
>  
> +	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
> +
>  	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
>  };
>  
> @@ -271,6 +275,13 @@ enum {
>  	PERF_BR_NEW_MAX,
>  };
>  
> +enum {
> +	PERF_BR_PRIV_UNKNOWN	= 0,
> +	PERF_BR_PRIV_USER	= 1,
> +	PERF_BR_PRIV_KERNEL	= 2,
> +	PERF_BR_PRIV_HV		= 3,
> +};
> +
>  #define PERF_SAMPLE_BRANCH_PLM_ALL \
>  	(PERF_SAMPLE_BRANCH_USER|\
>  	 PERF_SAMPLE_BRANCH_KERNEL|\
> @@ -1386,7 +1397,8 @@ struct perf_branch_entry {
>  		cycles:16,  /* cycle count to last branch */
>  		type:4,     /* branch type */
>  		new_type:4, /* additional branch type */
> -		reserved:36;
> +		priv:3,     /* privilege level */
> +		reserved:33;
>  };
>  
>  union perf_sample_weight {
