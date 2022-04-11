Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CDE4FB353
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 07:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244794AbiDKFrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 01:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244783AbiDKFrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:47:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCD9E6391;
        Sun, 10 Apr 2022 22:45:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86FE1ED1;
        Sun, 10 Apr 2022 22:45:33 -0700 (PDT)
Received: from [10.163.38.140] (unknown [10.163.38.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9EEF3F5A1;
        Sun, 10 Apr 2022 22:45:27 -0700 (PDT)
Message-ID: <f469f253-9ccc-d55b-731d-3ecc8d685104@arm.com>
Date:   Mon, 11 Apr 2022 11:16:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V5 0/8] perf: Expand perf_branch_entry
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, acme@kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220404045046.634522-1-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220404045046.634522-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/22 10:20, Anshuman Khandual wrote:
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
> This actually combines following patches and series into a single series.
> 
> - https://lore.kernel.org/all/1642998653-21377-12-git-send-email-anshuman.khandual@arm.com/
> - https://lore.kernel.org/all/1643348653-24367-1-git-send-email-anshuman.khandual@arm.com/
> - https://lore.kernel.org/all/1645681014-3346-1-git-send-email-anshuman.khandual@arm.com/
> 
> This series applies on v5.18-rc1
> 
> perf API
> 
> The series being applied
> 
> - Clean : tools/perf/check-headers.sh
> - Clean : diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
> 
> Todo
> 
> - Update perf report tool to process PERF_BR_EXTEND_ABI (when available),
>   then fetch and report branch types from perf_branch_entry.new_type field.
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
> Changes in V5:
> 
> - Dropped patches [PATCH 1/10] and [PATCH 6/10] related to PERF_BR_[RET|IRQ] - merged
>   via the commit cedd3614e5d9c809 ("perf: Add irq and exception return branch types")
> 
> - Rebased series on v5.18-rc1

Gentle ping, any updates on this series ?
