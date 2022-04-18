Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652EE504CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiDRGuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiDRGt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:49:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A27CDDC1;
        Sun, 17 Apr 2022 23:47:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06A1AED1;
        Sun, 17 Apr 2022 23:47:20 -0700 (PDT)
Received: from [192.168.225.231] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C62B3F7B4;
        Sun, 17 Apr 2022 23:47:14 -0700 (PDT)
Message-ID: <a304d9e4-2632-1ba9-249f-1d87c90f82de@arm.com>
Date:   Mon, 18 Apr 2022 12:17:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V5 0/8] perf: Expand perf_branch_entry
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
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
 <f469f253-9ccc-d55b-731d-3ecc8d685104@arm.com>
In-Reply-To: <f469f253-9ccc-d55b-731d-3ecc8d685104@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/22 11:16, Anshuman Khandual wrote:
> 
> 
> On 4/4/22 10:20, Anshuman Khandual wrote:
>> Branch Record Buffer Extension (BRBE) implementation on arm64 captures more
>> branch type classification which cannot be accommodated in the current perf
>> branch record format via perf_branch_entry.type element (4 bit field). Also
>> it captures privilege information which does not have a corresponding slot
>> in perf_branch_entry. This series expands struct perf_branch_entry, to meet
>> both these requirements without breaking the existing user space ABI for
>> perf tools.
>>
>> All architecture specific branch types added via perf_branch_entry.new_type
>> field in [PATCH 3/4] will be used in BRBE implementation on arm64 platform
>> later on with the following map.
>>
>> #ifdef CONFIG_ARM64
>> #define PERF_BR_FIQ		PERF_BR_NEW_ARCH_1
>> #define PERF_BR_DEBUG_HALT	PERF_BR_NEW_ARCH_2
>> #define PERF_BR_DEBUG_EXIT	PERF_BR_NEW_ARCH_3
>> #define PERF_BR_DEBUG_INST	PERF_BR_NEW_ARCH_4
>> #define PERF_BR_DEBUG_DATA	PERF_BR_NEW_ARCH_5
>> #endif
>>
>> This actually combines following patches and series into a single series.
>>
>> - https://lore.kernel.org/all/1642998653-21377-12-git-send-email-anshuman.khandual@arm.com/
>> - https://lore.kernel.org/all/1643348653-24367-1-git-send-email-anshuman.khandual@arm.com/
>> - https://lore.kernel.org/all/1645681014-3346-1-git-send-email-anshuman.khandual@arm.com/
>>
>> This series applies on v5.18-rc1
>>
>> perf API
>>
>> The series being applied
>>
>> - Clean : tools/perf/check-headers.sh
>> - Clean : diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
>>
>> Todo
>>
>> - Update perf report tool to process PERF_BR_EXTEND_ABI (when available),
>>   then fetch and report branch types from perf_branch_entry.new_type field.
>>
>> References
>>
>> - BRBE captured branch record information
>>
>> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers/BRBINF-n--EL1--Branch-Record-Buffer-Information-Register--n-?lang=en
>>
>> - BRBE based perf branch stack implementation on arm64 platform
>>
>> https://lore.kernel.org/all/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/
>>
>> Changes in V5:
>>
>> - Dropped patches [PATCH 1/10] and [PATCH 6/10] related to PERF_BR_[RET|IRQ] - merged
>>   via the commit cedd3614e5d9c809 ("perf: Add irq and exception return branch types")
>>
>> - Rebased series on v5.18-rc1
> 
> Gentle ping, any updates on this series ?

Gentle ping, any updates on this series ?

I have posted BRBE RFC V2 accommodating all these new perf ABI changes being
proposed here. I would really appreciate reviews and/or suggestions on this
series, which is essential and also prerequisite for the BRBE driver itself.

https://lore.kernel.org/all/20220412115455.293119-1-anshuman.khandual@arm.com/

- Anshuman
