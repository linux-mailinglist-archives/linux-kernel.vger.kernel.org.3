Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29C05ACD4B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbiIEIAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbiIEIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:00:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA4552CC85;
        Mon,  5 Sep 2022 01:00:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBE59ED1;
        Mon,  5 Sep 2022 01:00:40 -0700 (PDT)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A0DD3F73D;
        Mon,  5 Sep 2022 01:00:28 -0700 (PDT)
Message-ID: <613c9f12-dcd4-d78c-f0a3-dc0c5231a17a@arm.com>
Date:   Mon, 5 Sep 2022 13:30:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V7 6/8] perf/tools: Extend branch type classification
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, mark.rutland@arm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220824044822.70230-1-anshuman.khandual@arm.com>
 <20220824044822.70230-7-anshuman.khandual@arm.com>
 <Yw59CkHUVbfrHdkh@kernel.org> <9b1a8ebd-0562-f104-7439-308282f7fb52@arm.com>
 <YxI99uLvpgAZjm2r@kernel.org> <YxJBh3wvAGol+Ekq@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YxJBh3wvAGol+Ekq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/22 23:16, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 02, 2022 at 02:31:34PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Sep 01, 2022 at 10:37:24AM +0530, Anshuman Khandual escreveu:
>>> On 8/31/22 02:41, Arnaldo Carvalho de Melo wrote:
>>>> Strange:
>>>>
>>>>   75     8.89 ubuntu:20.04-x-powerpc64el    : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1~20.04)
>>>>         inlined from 'branch_type_stat_display' at util/branch.c:152:4:
>>>>     /usr/powerpc64le-linux-gnu/include/bits/stdio2.h:100:10: error: '%8s' directive argument is null [-Werror=format-overflow=]
>>>>       100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
>>>>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>       101 |    __va_arg_pack ());
>>>>           |    ~~~~~~~~~~~~~~~~~
>>>>
>>>
>>> Indeed. But this new code block here looks exact same like the previous and existing one
>>> i.e with branch_new_name() and PERF_BR_NEW_MAX. The complain is that - '%8s' directive
>>> argument is NULL. This warning might just be a false positive [1], because of a compiler
>>> problem on powerpc64el ? But please do let me know if something needs to be changed here
>>> to avoid this warning.
>>>
>>> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90036
>>>
>>
>> So, I tried not returning NULL in the functions that are ultimately
>> called, but that didn't help, so I'll try just disabling that specific
>> warning for this specific file.
> 
> Got it building:

Thanks Arnaldo, I guess all the tool changes in this series, along with this
build will land in linux-next later for more test coverage.

> 
>     23.68 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
> BUILD_TARBALL_HEAD=b0f700972d9d0c9b8e73f69ccf0e56d74c580d71
> 
> With:
> 
>>From b0f700972d9d0c9b8e73f69ccf0e56d74c580d71 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Fri, 2 Sep 2022 14:35:26 -0300
> Subject: [PATCH 1/1] perf build: Avoid false positive with
>  -Werror=format-overflow= with gcc 10.3.0 on powerpc
> 
> When building with gcc 10.3.0 on powerpc this is happening:
> 
>    75     8.89 ubuntu:20.04-x-powerpc64el    : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1~20.04)
>          inlined from 'branch_type_stat_display' at util/branch.c:152:4:
>      /usr/powerpc64le-linux-gnu/include/bits/stdio2.h:100:10: error: '%8s' directive argument is null [-Werror=format-overflow=]
>        100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
>            |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        101 |    __va_arg_pack ());
>            |    ~~~~~~~~~~~~~~~~~
> 
> Looks related to:
> 
>   [10/11/12/13 Regression] false positive: directive argument is null [-Werror=format-overflow=]
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90036
> 
> So lets disable this just for the util/branch.o file.
> 
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Link: http://lore.kernel.org/lkml/YxI99uLvpgAZjm2r@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/Build | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 8fd6dc8de5210336..20a5524e88a04d44 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -223,6 +223,10 @@ CFLAGS_llvm-utils.o += -DPERF_INCLUDE_DIR="BUILD_STR($(perf_include_dir_SQ))"
>  # avoid compiler warnings in 32-bit mode
>  CFLAGS_genelf_debug.o  += -Wno-packed
>  
> +# avoid false positive when building with gcc 10.3.0 on powerpc
> +# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90036
> +CFLAGS_branch.o += -Wno-format-overflow
> +
>  $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
>  	$(call rule_mkdir)
>  	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c \
