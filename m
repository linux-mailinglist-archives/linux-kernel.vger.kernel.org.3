Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4822B4D0E42
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 04:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241869AbiCHDVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 22:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiCHDVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 22:21:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB277F4B;
        Mon,  7 Mar 2022 19:20:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AD98D6E;
        Mon,  7 Mar 2022 19:20:56 -0800 (PST)
Received: from [10.162.17.54] (a077893.blr.arm.com [10.162.17.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC1BA3FA50;
        Mon,  7 Mar 2022 19:20:52 -0800 (PST)
Message-ID: <b177daad-55ec-6e7b-7ca6-a97e93477594@arm.com>
Date:   Tue, 8 Mar 2022 08:50:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] perf: Add irq and exception return branch types
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
References: <1645681014-3346-1-git-send-email-anshuman.khandual@arm.com>
 <10aac3a9-6912-6e47-400e-5c7d8ca9dbcd@arm.com> <YiO0IhoAYmdGNWqd@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YiO0IhoAYmdGNWqd@kernel.org>
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



On 3/6/22 00:34, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 28, 2022 at 03:45:25PM +0000, James Clark escreveu:
>>
>> On 24/02/2022 05:36, Anshuman Khandual wrote:
>>> This expands generic branch type classification by adding two more entries
>>> there in i.e irq and exception return. Also updates the x86 implementation
>>> to process X86_BR_IRET and X86_BR_IRQ records as appropriate. This changes
>>> branch types reported to user space on x86 platform but it should not be a
>>> problem. The possible scenarios and impacts are enumerated here.
>>>
>>> --------------------------------------------------------------------------
>>> | kernel | perf tool |                     Impact                        |
>>> --------------------------------------------------------------------------
>>> |   old  |    old    |  Works as before                                  |
>>> --------------------------------------------------------------------------
>>> |   old  |    new    |  PERF_BR_UNKNOWN is processed                     |
>>> --------------------------------------------------------------------------
>>> |   new  |    old    |  PERF_BR_ERET/IRQ are blocked via old PERF_BR_MAX |
>>> --------------------------------------------------------------------------
>>> |   new  |    new    |  PERF_BR_ERET/IRQ are recognized                  |
>>> --------------------------------------------------------------------------
>>>
>>> When PERF_BR_ERET/IRQ are blocked via old PERF_BR_MAX (new kernel with old
>>> perf tool) the user space might throw up an warning complaining about some
>>> unrecognized branch types being reported, but it is expected. PERF_BR_ERET
>>> and PERF_BR_IRQ branch types will be used for BRBE implementation on arm64
>>> platform.
>>>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>> Cc: Jiri Olsa <jolsa@redhat.com>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-perf-users@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> This applies on v5.17-rc5
>>>
>>> These two new branch types expands generic branch type classification but
>>> still leaves another three entries in 'type' field for later. Please refer
>>> a previous discussion [1] for some further context.
>>>
>>> [1] https://lore.kernel.org/all/1643348653-24367-1-git-send-email-anshuman.khandual@arm.com/
>>>
>>>  arch/x86/events/intel/lbr.c           | 4 ++--
>>>  include/uapi/linux/perf_event.h       | 2 ++
> Please try to avoid lockstep development of kernel and tools/, submit
> patches to the kernel maintainers for the kernel parts, and to the perf
> tools maintainer in separate patches.

Sure, will split this patch into two i.e kernel and user space changes. I have
an updated series which has some more kernel and user space API changes. But I
am wondering if there should be just a single patch updating user space API for
all the preceding kernel changes, or there should be one user space API patch
for each corresponding kernel change ?

> 
> It is important that changes to the API are flagged, for instance via
> tools/perf/check-headers.sh so that opportunity is given for the various
> people involved in perf (u/k) development to see what is going on.

Will run the diff after the series has been applied to demonstrate all the API
changes and update that in the cover letter.
