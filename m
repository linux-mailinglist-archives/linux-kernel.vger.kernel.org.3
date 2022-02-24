Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F564C2462
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 08:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiBXHKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 02:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiBXHKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 02:10:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED0C5230E50;
        Wed, 23 Feb 2022 23:10:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99A7D106F;
        Wed, 23 Feb 2022 23:10:12 -0800 (PST)
Received: from [10.163.48.178] (unknown [10.163.48.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38D7F3F70D;
        Wed, 23 Feb 2022 23:10:08 -0800 (PST)
Subject: Re: [PATCH 1/2] perf: Add more generic branch types
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>
References: <1643348653-24367-1-git-send-email-anshuman.khandual@arm.com>
 <1643348653-24367-2-git-send-email-anshuman.khandual@arm.com>
 <YfpxzKa7JSlimA1i@FVFF77S0Q05N>
 <e9c4eab7-51b4-6794-0d02-2d325c300e33@arm.com>
Message-ID: <25a36640-3061-4c98-4da0-ceb039439f42@arm.com>
Date:   Thu, 24 Feb 2022 12:40:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e9c4eab7-51b4-6794-0d02-2d325c300e33@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/22 11:21 AM, Anshuman Khandual wrote:
> 
> 
> On 2/2/22 5:28 PM, Mark Rutland wrote:
>> Hi Anshuman,
>>
>> On Fri, Jan 28, 2022 at 11:14:12AM +0530, Anshuman Khandual wrote:
>>> This expands generic branch type classification by adding some more entries
>>> , that can still be represented with the existing 4 bit 'type' field. While
>>> here this also updates the x86 implementation with these new branch types.
>> It looks like there's some whitespace damage here.
>>
>> >From a quick scan of the below, I think the "exception return" and "IRQ
>> exception" types are somewhat generic, and could be added now (aside from any
>> bikeshedding over names), but:
> 
> Hi Mark,
> 
> I have sent a patch adding just PERF_BR_ERET and PERF_BR_IRQ which are generic
> enough to be included now. The 'type' field still got 3 more places for future
> use. Hence we should try and include two more branch types, before adding the

The two additional generic branch types could be

- PERF_BR_SERROR (possible arm64 equivalent for x86 MCE)
- PERF_BR_NO_TX  (only missing TX related branch type in perf_branch_entry)

perf_branch_entry.[in_tx | abort] are already available. Also PERF_BR_NO_TX
could be used right away on x86 platform, via X86_BR_NO_TX.

> last entry for ABI expansion (e.g PERF_BR_EXTENDED).

PERF_BR_EXTENDED could help expand into another 4 bits 'new_type' field
following the existing 4 bits 'type' field. Does this sound feasible ?

enum {
        PERF_BR_UNKNOWN         = 0,    /* unknown */
        PERF_BR_COND            = 1,    /* conditional */
        PERF_BR_UNCOND          = 2,    /* unconditional  */
        PERF_BR_IND             = 3,    /* indirect */
        PERF_BR_CALL            = 4,    /* function call */
        PERF_BR_IND_CALL        = 5,    /* indirect function call */
        PERF_BR_RET             = 6,    /* function return */
        PERF_BR_SYSCALL         = 7,    /* syscall */
        PERF_BR_SYSRET          = 8,    /* syscall return */
        PERF_BR_COND_CALL       = 9,    /* conditional function call */
        PERF_BR_COND_RET        = 10,   /* conditional function return */
        PERF_BR_ERET            = 11,   /* exception return */
        PERF_BR_IRQ             = 12,   /* irq */
        PERF_BR_SERROR          = 13,   /* System error */
        PERF_BR_NO_TX           = 14,   /* No transaction */
	PERF_BR_EXTEND_ABI	= 15 	/* Extended ABI */
        PERF_BR_MAX,
};

enum {
       PERF_BR_NEW_FAULT_ALGN          = 0,    /* Alignment fault */
       PERF_BR_NEW_FAULT_DATA          = 1,    /* Data fault */
       PERF_BR_NEW_FAULT_INST          = 2,    /* Inst fault */
       PERF_BR_NEW_ARCH_1              = 3,    /* Architecture specific */
       PERF_BR_NEW_ARCH_2              = 4,    /* Architecture specific */
       PERF_BR_NEW_ARCH_3              = 5,    /* Architecture specific */
       PERF_BR_NEW_ARCH_4              = 6,    /* Architecture specific */
       PERF_BR_NEW_ARCH_5              = 7,    /* Architecture specific */
       PERF_BR_NEW_MAX,
};

#ifdef CONFIG_ARM64
#define PERF_BR_FIQ            PERF_BR_NEW_ARCH_1
#define PERF_BR_DEBUG_HALT     PERF_BR_NEW_ARCH_2
#define PERF_BR_DEBUG_EXIT     PERF_BR_NEW_ARCH_3
#define PERF_BR_DEBUG_INST     PERF_BR_NEW_ARCH_4
#define PERF_BR_DEBUG_DATA     PERF_BR_NEW_ARCH_5
#endif

User space perf tool will look into perf_branch_entry.new_type, only
when (perf_branch_entry.type == PERF_BR_EXTEND_ABI). Older perf tool
on a newer kernel will be safe via old PERF_BR_MAX, and will ignore
[PERF_BR_ERET - PERF_BR_EXTEND_ABI] values possibly with an warning.

- Anshuman
