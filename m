Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64FB4FF320
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiDMJQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiDMJQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:16:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C027A286D5;
        Wed, 13 Apr 2022 02:14:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8783F13D5;
        Wed, 13 Apr 2022 02:14:08 -0700 (PDT)
Received: from [10.1.33.136] (e127744.cambridge.arm.com [10.1.33.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BFE93F5A1;
        Wed, 13 Apr 2022 02:14:06 -0700 (PDT)
Subject: Re: [PATCH] perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE
 event
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220413075124.635589-1-leo.yan@linaro.org>
 <c21b3409-a8a0-aae7-7634-5e648f0a49b1@arm.com>
 <20220413084941.GB521036@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <38078438-dbce-690b-ba79-5c3713f97816@arm.com>
Date:   Wed, 13 Apr 2022 10:14:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220413084941.GB521036@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/04/2022 09:49, Leo Yan wrote:
> On Wed, Apr 13, 2022 at 09:15:40AM +0100, German Gomez wrote:
>
> [...]
>
>>>  	if (sort__mode == SORT_MODE__MEMORY) {
>>> +		/*
>>> +		 * FIXUP: prior to kernel 5.18, Arm SPE missed to set
>>> +		 * PERF_SAMPLE_DATA_SRC bit in sample type.  For backward
>>> +		 * compatibility, set the bit if it's an old perf data file.
>>> +		 */
>>> +		evlist__for_each_entry(session->evlist, evsel) {
>>> +			if (strstr(evsel->name, "arm_spe_") &&
>> This didn't work for me when the file recorded "-e arm_spe//" instead of
>> "-e arm_spe_0//". Could you remove the trailing _? With that:
> Sure, will change to "arm_spe".  Just curious, if there any local
> change at your side so we have the different event name?

No local changes. I've always used "arm_spe//" and it always defaults to
"arm_spe_0//". But it's still stored as the former in the data file. I
haven't checked where this default happens though. Isn't it the same for
you?

Thanks,
German
>
>> Tested-by: German Gomez <german.gomez@arm.com>
> Thanks a lot, German!
>
> Leo
