Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790BB506F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353010AbiDSN6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbiDSN6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:58:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D65AF38BEC;
        Tue, 19 Apr 2022 06:55:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E88E1063;
        Tue, 19 Apr 2022 06:55:47 -0700 (PDT)
Received: from [10.32.36.25] (e121896.Emea.Arm.com [10.32.36.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F03B83F766;
        Tue, 19 Apr 2022 06:55:43 -0700 (PDT)
Message-ID: <d934c6a2-ecc3-48cb-a65f-99f7789af7bc@arm.com>
Date:   Tue, 19 Apr 2022 14:55:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 1/8] perf: Add system error and not in transaction
 branch types
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
 <20220404045046.634522-2-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220404045046.634522-2-anshuman.khandual@arm.com>
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
> This expands generic branch type classification by adding two more entries
> there in i.e system error and not in transaction. This also updates the x86
> implementation to process X86_BR_NO_TX records as appropriate. This changes
> branch types reported to user space on x86 platform but it should not be a
> problem. The possible scenarios and impacts are enumerated here.
> 
> --------------------------------------------------------------------------
> | kernel | perf tool |                     Impact                        |
> --------------------------------------------------------------------------
> |   old  |    old    |  Works as before                                  |
> --------------------------------------------------------------------------
> |   old  |    new    |  PERF_BR_UNKNOWN is processed                     |
> --------------------------------------------------------------------------
> |   new  |    old    |  PERF_BR_NO_TX are blocked via old PERF_BR_MAX    |
> --------------------------------------------------------------------------
> |   new  |    new    |  NO_TX are recognized                             |
> --------------------------------------------------------------------------
> 
> When PERF_BR_NO_TX is blocked via old PERF_BR_MAX (new kernel with old perf
> tool) the user space might throw up an warning complaining about an
> unrecognized branch types being reported, but it's expected. PERF_BR_SERROR
> & PERF_BR_NO_TX branch types will be used for BRBE implementation on arm64
> platform.
> 
> PERF_BR_NO_TX complements 'abort' and 'in_tx' elements in perf_branch_entry
> which represent other transaction states for a given branch record. Because
> this completes the transaction state classification.
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
>  arch/x86/events/intel/lbr.c     | 2 +-
>  include/uapi/linux/perf_event.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index fe1742c4ca49..30dcd18936d5 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1336,7 +1336,7 @@ static int branch_map[X86_BR_TYPE_MAP_MAX] = {
>  	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
>  	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
>  	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
> -	PERF_BR_UNKNOWN,	/* X86_BR_NO_TX */
> +	PERF_BR_NO_TX,		/* X86_BR_NO_TX */
>  	PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
>  	PERF_BR_UNKNOWN,	/* X86_BR_CALL_STACK */
>  	PERF_BR_IND,		/* X86_BR_IND_JMP */
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index d37629dbad72..26d8f0b5ac0d 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -253,6 +253,8 @@ enum {
>  	PERF_BR_COND_RET	= 10,	/* conditional function return */
>  	PERF_BR_ERET		= 11,	/* exception return */
>  	PERF_BR_IRQ		= 12,	/* irq */
> +	PERF_BR_SERROR		= 13,	/* system error */
> +	PERF_BR_NO_TX		= 14,	/* not in transaction */
>  	PERF_BR_MAX,
>  };
>  
