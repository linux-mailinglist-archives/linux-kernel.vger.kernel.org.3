Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4E1522AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 06:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiEKE15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 00:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiEKE1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 00:27:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F9023B558;
        Tue, 10 May 2022 21:27:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E33E2106F;
        Tue, 10 May 2022 21:27:50 -0700 (PDT)
Received: from [192.168.0.8] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDDF33F5A1;
        Tue, 10 May 2022 21:27:45 -0700 (PDT)
Message-ID: <e207966e-ffb4-a79c-42c6-3fed92fb9669@arm.com>
Date:   Wed, 11 May 2022 09:58:49 +0530
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
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
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

Gentle ping, any updates on this series ?
