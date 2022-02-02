Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ADC4A7065
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbiBBL56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:57:58 -0500
Received: from foss.arm.com ([217.140.110.172]:54014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232566AbiBBL55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:57:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B2221FB;
        Wed,  2 Feb 2022 03:57:57 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EA673F718;
        Wed,  2 Feb 2022 03:57:55 -0800 (PST)
Date:   Wed, 2 Feb 2022 11:57:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/2] perf: Expand perf_branch_entry.type
Message-ID: <Yfpxv9+TP9rP72wL@FVFF77S0Q05N>
References: <1643348653-24367-1-git-send-email-anshuman.khandual@arm.com>
 <1643348653-24367-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643348653-24367-3-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 11:14:13AM +0530, Anshuman Khandual wrote:
> Current perf_branch_entry.type is a 4 bits field just enough to accommodate
> 16 generic branch types. This is insufficient to accommodate platforms like
> arm64 which has much more branch types.

It would be good to mention BRBE specifically here, along with specific values
and a rought intro, e.g.

| The Arm Branch Record Buffer Extension (BRBE) distinguishes $N types of
| branch/exception/return: <rough summary here>. There's not enough space to
| describe these all in perf_branch_entry.type, as this is a 4-bit field.

That way reviewers (and anyone looking at the patch in future) have a lot more
rationale to work with. A rough summary of the distinct branch types would be
*really* helpful.

> Lets just expands this field into a 6 bits one, which can now hold 64 generic
> branch types.

Is it safe (ABI-wise) to extend a bit-field like this? Does that break any
combination of old/new userspace and old/new kernel? I'm not sure how bit
fields are managed w.r.t. endianness, but normally extending a field would
break BE, so this seems suspicious.

I suspect we might need to allocate a *separate* field for new values, and
possibly reserve a value in the existing field to say "go look at the new
field".

Do you have any rationale for 64 values specifically? e.g. is that mostly for
future extensibility? How many will we need for Arm's BRBE?

Do those types fall into a hierarchy, that we could split across separate
fields?

> This also adds more generic branch types.

This feels like ti should be in a separate/subsequent patch. If nothing else
that aids bisectability if changing the size of the field breaks anything.

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/uapi/linux/perf_event.h       | 10 ++++++++--
>  tools/include/uapi/linux/perf_event.h | 10 ++++++++--
>  tools/perf/util/branch.c              |  8 +++++++-
>  tools/perf/util/branch.h              |  4 ++--
>  4 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index b91d0f575d0c..361fdc6b87a0 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -256,6 +256,12 @@ enum {
>  	PERF_BR_FIQ		= 13,	/* fiq */
>  	PERF_BR_DEBUG_HALT	= 14,	/* debug halt */
>  	PERF_BR_DEBUG_EXIT	= 15,	/* debug exit */
> +	PERF_BR_DEBUG_INST	= 16,	/* instruciton debug */
> +	PERF_BR_DEBUG_DATA	= 17,	/* data debug */

This is really unclear. What is "instruction debug" vs "data debug" ?

Are there meant for breakpoint/watchpoint exceptions? HW breakpoints vs BRK
instructions?

> +	PERF_BR_FAULT_ALGN	= 18,	/* alignment fault */
> +	PERF_BR_FAULT_DATA	= 19,	/* data fault */
> +	PERF_BR_FAULT_INST	= 20,	/* instruction fault */

There are many other potential faults a CPU could take; are these specifically
what Arm's BRBE provides?

> +	PERF_BR_SERROR		= 21,	/* system error */

This is really arm-specific; IIUC the closest thing on x86 is an MCE.

>  	PERF_BR_MAX,
>  };
>  
> @@ -1370,8 +1376,8 @@ struct perf_branch_entry {
>  		in_tx:1,    /* in transaction */
>  		abort:1,    /* transaction abort */
>  		cycles:16,  /* cycle count to last branch */
> -		type:4,     /* branch type */
> -		reserved:40;
> +		type:6,     /* branch type */

As above, is this a safe-change ABI-wise?

Thanks,
Mark.

> +		reserved:38;
>  };
>  
>  union perf_sample_weight {
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 1882054e8684..9a82b8aaed93 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -256,6 +256,12 @@ enum {
>  	PERF_BR_FIQ		= 13,	/* fiq */
>  	PERF_BR_DEBUG_HALT	= 14,	/* debug halt */
>  	PERF_BR_DEBUG_EXIT	= 15,	/* debug exit */
> +	PERF_BR_DEBUG_INST	= 16,	/* instruciton debug */
> +	PERF_BR_DEBUG_DATA	= 17,	/* data debug */
> +	PERF_BR_FAULT_ALGN	= 18,	/* alignment fault */
> +	PERF_BR_FAULT_DATA	= 19,	/* data fault */
> +	PERF_BR_FAULT_INST	= 20,	/* instruction fault */
> +	PERF_BR_SERROR		= 21,	/* system error */
>  	PERF_BR_MAX,
>  };
>  
> @@ -1370,8 +1376,8 @@ struct perf_branch_entry {
>  		in_tx:1,    /* in transaction */
>  		abort:1,    /* transaction abort */
>  		cycles:16,  /* cycle count to last branch */
> -		type:4,     /* branch type */
> -		reserved:40;
> +		type:6,     /* branch type */
> +		reserved:38;
>  };
>  
>  union perf_sample_weight {
> diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
> index 74e5e67b1779..1e216ea2e2a8 100644
> --- a/tools/perf/util/branch.c
> +++ b/tools/perf/util/branch.c
> @@ -54,7 +54,13 @@ const char *branch_type_name(int type)
>  		"IRQ",
>  		"FIQ",
>  		"DEBUG_HALT",
> -		"DEBUG_EXIT"
> +		"DEBUG_EXIT",
> +		"DEBUG_INST",
> +		"DEBUG_DATA",
> +		"FAULT_ALGN",
> +		"FAULT_DATA",
> +		"FAULT_INST",
> +		"SERROR"
>  	};
>  
>  	if (type >= 0 && type < PERF_BR_MAX)
> diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
> index 17b2ccc61094..875d99abdc36 100644
> --- a/tools/perf/util/branch.h
> +++ b/tools/perf/util/branch.h
> @@ -23,8 +23,8 @@ struct branch_flags {
>  			u64 in_tx:1;
>  			u64 abort:1;
>  			u64 cycles:16;
> -			u64 type:4;
> -			u64 reserved:40;
> +			u64 type:6;
> +			u64 reserved:38;
>  		};
>  	};
>  };
> -- 
> 2.25.1
> 
