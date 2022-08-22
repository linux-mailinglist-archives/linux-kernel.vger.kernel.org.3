Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B43759BD5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiHVKIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiHVKIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:08:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59AF012A97;
        Mon, 22 Aug 2022 03:08:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C1C113D5;
        Mon, 22 Aug 2022 03:08:49 -0700 (PDT)
Received: from [10.57.17.196] (unknown [10.57.17.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3E773F718;
        Mon, 22 Aug 2022 03:08:43 -0700 (PDT)
Message-ID: <f64f6cbf-73cf-e59a-5f6d-7303125bee66@arm.com>
Date:   Mon, 22 Aug 2022 11:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] perf: python: Fix build when PYTHON_CONFIG is user
 supplied
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220728093946.1337642-1-james.clark@arm.com>
 <CAP-5=fXnR=LSk-bO02V7HzWTTCrsbnM1w63_YYqSMEgy0vM-PQ@mail.gmail.com>
 <YuLi14u3DQ+ShH9w@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <YuLi14u3DQ+ShH9w@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/07/2022 20:26, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 28, 2022 at 09:37:32AM -0700, Ian Rogers escreveu:
>> On Thu, Jul 28, 2022 at 2:40 AM James Clark <james.clark@arm.com> wrote:
>>>
>>> The previous change to Python autodetection had a small mistake where
>>> the auto value was used to determine the Python binary, rather than the
>>> user supplied value. The Python binary is only used for one part of the
>>> build process, rather than the final linking, so it was producing
>>> correct builds in most scenarios, especially when the auto detected
>>> value matched what the user wanted, or the system only had a valid set
>>> of Pythons.
>>>
>>> Change it so that the Python binary path is derived from either the
>>> PYTHON_CONFIG value or PYTHON value, depending on what is specified by
>>> the user. This was the original intention.
>>>
>>> This error was spotted in a build failure an odd cross compilation
>>> environment after commit 4c41cb46a732fe82 ("perf python: Prefer
>>> python3") was merged.
>>>
>>> Fixes: 630af16eee495f58 ("perf tools: Use Python devtools for version autodetection rather than runtime")
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>
>> Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks, applied.

Hi Arnaldo,

I couldn't find this change in any of your branches. Do you know if it
got dropped somehow or was there an issue with it?

Thanks
James

> 
> - Arnaldo
> 
>  
>> Thanks,
>> Ian
>>
>>> ---
>>>  tools/perf/Makefile.config | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>>> index d3c254c0f5c6..a69da9f34486 100644
>>> --- a/tools/perf/Makefile.config
>>> +++ b/tools/perf/Makefile.config
>>> @@ -265,7 +265,7 @@ endif
>>>  # defined. get-executable-or-default fails with an error if the first argument is supplied but
>>>  # doesn't exist.
>>>  override PYTHON_CONFIG := $(call get-executable-or-default,PYTHON_CONFIG,$(PYTHON_AUTO))
>>> -override PYTHON := $(call get-executable-or-default,PYTHON,$(subst -config,,$(PYTHON_AUTO)))
>>> +override PYTHON := $(call get-executable-or-default,PYTHON,$(subst -config,,$(PYTHON_CONFIG)))
>>>
>>>  grep-libs  = $(filter -l%,$(1))
>>>  strip-libs  = $(filter-out -l%,$(1))
>>> --
>>> 2.28.0
>>>
> 
