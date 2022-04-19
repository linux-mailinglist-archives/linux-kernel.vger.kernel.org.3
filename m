Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC388506F89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbiDSOAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiDSOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:00:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB85938D88;
        Tue, 19 Apr 2022 06:58:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8170106F;
        Tue, 19 Apr 2022 06:58:05 -0700 (PDT)
Received: from [10.32.36.25] (e121896.Emea.Arm.com [10.32.36.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C76403F766;
        Tue, 19 Apr 2022 06:58:02 -0700 (PDT)
Message-ID: <cfd80315-ff94-1394-f194-be9eec0d9202@arm.com>
Date:   Tue, 19 Apr 2022 14:58:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 5/8] perf/tools: Add system error and not in
 transaction branch types
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
 <20220404045046.634522-6-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220404045046.634522-6-anshuman.khandual@arm.com>
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
> This updates the perf tool with generic branch type classification with two
> new branch types i.e system error (PERF_BR_SERROR) and not in transaction
> (PERF_BR_NO_TX) which got updated earlier in the kernel. This also updates
> corresponding branch type strings in branch_type_name().
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
>  tools/include/uapi/linux/perf_event.h | 2 ++
>  tools/perf/util/branch.c              | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index d37629dbad72..26d8f0b5ac0d 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -253,6 +253,8 @@ enum {
>  	PERF_BR_COND_RET	= 10,	/* conditional function return */
>  	PERF_BR_ERET		= 11,	/* exception return */
>  	PERF_BR_IRQ		= 12,	/* irq */
> +	PERF_BR_SERROR		= 13,	/* system error */
> +	PERF_BR_NO_TX		= 14,	/* not in transaction */
>  	PERF_BR_MAX,
>  };
>  
> diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
> index a9a909db8cc7..abc673347bee 100644
> --- a/tools/perf/util/branch.c
> +++ b/tools/perf/util/branch.c
> @@ -51,7 +51,9 @@ const char *branch_type_name(int type)
>  		"COND_CALL",
>  		"COND_RET",
>  		"ERET",
> -		"IRQ"
> +		"IRQ",
> +		"SERROR",
> +		"NO_TX"
>  	};
>  
>  	if (type >= 0 && type < PERF_BR_MAX)
