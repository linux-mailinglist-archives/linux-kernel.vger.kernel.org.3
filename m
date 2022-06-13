Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA75482CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbiFMJHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiFMJHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:07:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18052E0C1;
        Mon, 13 Jun 2022 02:07:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5368D6E;
        Mon, 13 Jun 2022 02:07:03 -0700 (PDT)
Received: from [10.163.38.134] (unknown [10.163.38.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FEFE3F66F;
        Mon, 13 Jun 2022 02:06:56 -0700 (PDT)
Message-ID: <d74a6068-1193-0d1e-7e7b-28a0be761b9e@arm.com>
Date:   Mon, 13 Jun 2022 14:36:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V6 0/8] perf: Expand perf_branch_entry
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, acme@kernel.org
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220610035101.424112-1-anshuman.khandual@arm.com>
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



On 6/10/22 09:20, Anshuman Khandual wrote:
> Branch Record Buffer Extension (BRBE) implementation on arm64 captures more
> branch type classification which cannot be accommodated in the current perf
> branch record format via perf_branch_entry.type element (4 bit field). Also
> it captures privilege information which does not have a corresponding slot
> in perf_branch_entry. This series expands struct perf_branch_entry, to meet
> both these requirements without breaking the existing user space ABI for
> perf tools.
> 
> All architecture specific branch types added via perf_branch_entry.new_type
> field in [PATCH 3/4] will be used in BRBE implementation on arm64 platform
> later on with the following map.
> 
> #ifdef CONFIG_ARM64
> #define PERF_BR_FIQ		PERF_BR_NEW_ARCH_1
> #define PERF_BR_DEBUG_HALT	PERF_BR_NEW_ARCH_2
> #define PERF_BR_DEBUG_EXIT	PERF_BR_NEW_ARCH_3
> #define PERF_BR_DEBUG_INST	PERF_BR_NEW_ARCH_4
> #define PERF_BR_DEBUG_DATA	PERF_BR_NEW_ARCH_5
> #endif
> 
> This series applies on v5.19-rc1
> 
> perf API
> 
> The series being applied
> 
> - Clean : tools/perf/check-headers.sh
> - Clean : diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
> 
> References
> 
> - BRBE captured branch record information
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers/BRBINF-n--EL1--Branch-Record-Buffer-Information-Register--n-?lang=en
> 
> - BRBE based perf branch stack implementation on arm64 platform
> 
> https://lore.kernel.org/all/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/
> 
> Changes in V6:
> 
> - Process PERF_BR_EXTEND_ABI in perf tools and fetch from perf_branch_entry.new_type
> - Modified the commit message for [PATCH 1/8]
> 
> Changes in V5:
> 
> https://lore.kernel.org/linux-arm-kernel/20220404045046.634522-1-anshuman.khandual@arm.com/
> 
> - Dropped patches [PATCH 1/10] and [PATCH 6/10] related to PERF_BR_[RET|IRQ] - merged
>   via the commit cedd3614e5d9c809 ("perf: Add irq and exception return branch types")
> 
> - Rebased series on v5.18-rc1
> 
> Changes in V4:
> 
> https://lore.kernel.org/all/20220315053516.431515-1-anshuman.khandual@arm.com/
> 
> - Modified the struct branch_flags as required
> - Dropped CONFIG_ARM64 from perf header file to avoid build problem
> - Renamed PERF_BR_NEW_<BRANCH_TYPE> as PERF_BR_ARM64_<BRANCH_TYPE>
> 
> Changes in V3:
> 
> https://lore.kernel.org/all/20220314055857.125421-1-anshuman.khandual@arm.com/
> 
> - Fixed small typo s/privillege/privilege in include/uapi/linux/perf_event.h
> - Added PRIV_SHIFT in __p_branch_sample_type()
> - Added arm64 platform override of the new arch specific branch types
> - Renamed s/PERF_BR_XXX/PERF_BR_PRIV_XXX/ for privilege level branch types
> - Added PERF_BR_PRIV_UNKNOWN as the starting value
> - Expanded perf_branch_entry.priv into a 3 bits field 
> 
> Changes in V2:
> 
> https://lore.kernel.org/all/20220309033642.144769-1-anshuman.khandual@arm.com/
> 
> Cc: Robin Murphy <robin.murphy@arm.com> 
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: James Clark <james.clark@arm.com>
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
> 
> Anshuman Khandual (8):
>   perf: Add system error and not in transaction branch types
>   perf: Extend branch type classification
>   perf: Capture branch privilege information
>   perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform
>   perf/tools: Add system error and not in transaction branch types
>   perf/tools: Extend branch type classification
>   perf/tools: Add branch privilege information request flag
>   perf/tools: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform

I forgot to collect all the "Reviewed-by" tags from James Clark on some
patches (1, 2, 4, 5). Will add them next time around.

- Anshuman
