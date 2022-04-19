Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453B6506F88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344509AbiDSOAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiDSOAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:00:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1CC838BEA;
        Tue, 19 Apr 2022 06:57:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CCE71063;
        Tue, 19 Apr 2022 06:57:18 -0700 (PDT)
Received: from [10.32.36.25] (e121896.Emea.Arm.com [10.32.36.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 929F53F766;
        Tue, 19 Apr 2022 06:57:15 -0700 (PDT)
Message-ID: <35dfe8a7-c31a-3e28-7429-f81753d0089a@arm.com>
Date:   Tue, 19 Apr 2022 14:57:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 4/8] perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on
 arm64 platform
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
 <20220404045046.634522-5-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220404045046.634522-5-anshuman.khandual@arm.com>
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
> BRBE captured branch types will overflow perf_branch_entry.type and generic
> branch types in perf_branch_entry.new_type. So override each available arch
> specific branch type in the following manner to comprehensively process all
> reported branch types in BRBE.
> 
> PERF_BR_ARM64_FIQ            PERF_BR_NEW_ARCH_1
> PERF_BR_ARM64_DEBUG_HALT     PERF_BR_NEW_ARCH_2
> PERF_BR_ARM64_DEBUG_EXIT     PERF_BR_NEW_ARCH_3
> PERF_BR_ARM64_DEBUG_INST     PERF_BR_NEW_ARCH_4
> PERF_BR_ARM64_DEBUG_DATA     PERF_BR_NEW_ARCH_5
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  include/uapi/linux/perf_event.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 193dba2ecdc1..4cf1c8e22cab 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -282,6 +282,12 @@ enum {
>  	PERF_BR_PRIV_HV		= 3,
>  };
>  
> +#define PERF_BR_ARM64_FIQ		PERF_BR_NEW_ARCH_1
> +#define PERF_BR_ARM64_DEBUG_HALT	PERF_BR_NEW_ARCH_2
> +#define PERF_BR_ARM64_DEBUG_EXIT	PERF_BR_NEW_ARCH_3
> +#define PERF_BR_ARM64_DEBUG_INST	PERF_BR_NEW_ARCH_4
> +#define PERF_BR_ARM64_DEBUG_DATA	PERF_BR_NEW_ARCH_5
> +
>  #define PERF_SAMPLE_BRANCH_PLM_ALL \
>  	(PERF_SAMPLE_BRANCH_USER|\
>  	 PERF_SAMPLE_BRANCH_KERNEL|\
