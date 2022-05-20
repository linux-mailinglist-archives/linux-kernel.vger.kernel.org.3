Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3088A52EE80
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350468AbiETOw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244321AbiETOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:52:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5220116D48B;
        Fri, 20 May 2022 07:52:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ADE51477;
        Fri, 20 May 2022 07:52:20 -0700 (PDT)
Received: from [10.57.7.229] (unknown [10.57.7.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6431D3F73D;
        Fri, 20 May 2022 07:52:16 -0700 (PDT)
Message-ID: <f2b243a7-5736-1f84-c284-29219fac585d@arm.com>
Date:   Fri, 20 May 2022 15:52:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 0/2] perf: arm64: Tools support for Dwarf unwinding
 through SVE functions
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, leo.yan@linaro.org, mathieu.poirier@linaro.org,
        john.garry@huawei.com, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220517102005.3022017-1-james.clark@arm.com>
 <YoO4Hiue7PmJ9KOS@kernel.org> <995099d3-a170-69dc-d12e-c9b2e4753f35@arm.com>
 <YoeKZFXO6zqFaqme@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <YoeKZFXO6zqFaqme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/05/2022 13:32, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 20, 2022 at 12:46:24PM +0100, German Gomez escreveu:
>>
>> On 17/05/2022 15:58, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, May 17, 2022 at 11:20:01AM +0100, James Clark escreveu:
>>>> Changes since v1:
>>>>
>>>>   * Split patchset into kernel side and Perf tool changes
>>> Thanks, now I'll wait for the kernel side to be merged.
>>>
>>> - Arnaldo
>>>  
>>
>> Hi,
>>
>> I think we also need to fix the below import (it's trying to import the
>> perf_regs.h from the kernel, not the tools/ dir).
> 
> Sure, that is why it is important to do a:
> 
> make -C tools/perf build-test
> 

Oops thanks, I will submit another version with a fix for this included.

James

> before posting patches, as it will do, among other tests, a detached tarball test using:
> 
> ⬢[acme@toolbox perf-urgent]$ make help | grep perf
>   perf-tar-src-pkg    - Build perf-5.18.0-rc7.tar source tarball
>   perf-targz-src-pkg  - Build perf-5.18.0-rc7.tar.gz source tarball
>   perf-tarbz2-src-pkg - Build perf-5.18.0-rc7.tar.bz2 source tarball
>   perf-tarxz-src-pkg  - Build perf-5.18.0-rc7.tar.xz source tarball
>   perf-tarzst-src-pkg - Build perf-5.18.0-rc7.tar.zst source tarball
> ⬢[acme@toolbox perf-urgent]$
> 
> That will pick just what is in tools/perf/MANIFEST and that doesn´t
> include the kernel headers, just what is in tools/ then building with
> this patchkit would fail.
> 
> To recap:
> 
> ⬢[acme@toolbox perf-urgent]$ make perf-tarxz-src-pkg
>   TAR
>   PERF_VERSION = 5.18.rc7.gc645054ef517
> ⬢[acme@toolbox perf-urgent]$ ls -la perf-5.18.0-rc7.tar.xz
> -rw-r--r--. 1 acme acme 2364832 May 20 09:32 perf-5.18.0-rc7.tar.xz
> ⬢[acme@toolbox perf-urgent]$ tar tvf perf-5.18.0-rc7.tar.xz | tail
> -rw-rw-r-- root/root      7364 2022-05-20 09:32 perf-5.18.0-rc7/tools/perf/util/vdso.c
> -rw-rw-r-- root/root       639 2022-05-20 09:32 perf-5.18.0-rc7/tools/perf/util/vdso.h
> -rw-rw-r-- root/root      1793 2022-05-20 09:32 perf-5.18.0-rc7/tools/perf/util/zlib.c
> -rw-rw-r-- root/root      2672 2022-05-20 09:32 perf-5.18.0-rc7/tools/perf/util/zstd.c
> drwxrwxr-x root/root         0 2022-05-20 09:32 perf-5.18.0-rc7/tools/scripts/
> -rw-rw-r-- root/root      1091 2022-05-20 09:32 perf-5.18.0-rc7/tools/scripts/Makefile.arch
> -rw-rw-r-- root/root      5905 2022-05-20 09:32 perf-5.18.0-rc7/tools/scripts/Makefile.include
> -rw-rw-r-- root/root      5288 2022-05-20 09:32 perf-5.18.0-rc7/tools/scripts/utilities.mak
> -rw-r--r-- acme/acme        41 2022-05-20 09:32 perf-5.18.0-rc7/HEAD
> -rw-r--r-- acme/acme        46 2022-05-20 09:32 perf-5.18.0-rc7/PERF-VERSION-FILE
> ⬢[acme@toolbox perf-urgent]$
> 
> - Arnaldo
>  
>> diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
>> index 15f60fd09424..014d82159656 100644
>> --- a/tools/perf/util/libunwind/arm64.c
>> +++ b/tools/perf/util/libunwind/arm64.c
>> @@ -24,7 +24,7 @@
>>  #include "unwind.h"
>>  #include "libunwind-aarch64.h"
>>  #define perf_event_arm_regs perf_event_arm64_regs
>> -#include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
>> +#include <../../../arch/arm64/include/uapi/asm/perf_regs.h>
>>  #undef perf_event_arm_regs
>>  #include "../../arch/arm64/util/unwind-libunwind.c"
>>
> 
