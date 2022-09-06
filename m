Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB56E5ADDA1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiIFC6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiIFC54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:57:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81ABF6BCD7;
        Mon,  5 Sep 2022 19:57:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FEE8139F;
        Mon,  5 Sep 2022 19:57:59 -0700 (PDT)
Received: from [10.162.42.8] (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E43D93F534;
        Mon,  5 Sep 2022 19:57:48 -0700 (PDT)
Message-ID: <d4e24bcc-8974-f835-1d95-4b520413b011@arm.com>
Date:   Tue, 6 Sep 2022 08:27:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 3/4] arm64/perf: Assert all platform event flags are
 within PERF_EVENT_FLAG_ARCH
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org
References: <20220905054239.324029-1-anshuman.khandual@arm.com>
 <20220905054239.324029-4-anshuman.khandual@arm.com>
 <3ad268df-f6fd-a899-ce0e-131b5fdfeae8@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <3ad268df-f6fd-a899-ce0e-131b5fdfeae8@arm.com>
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



On 9/5/22 14:40, James Clark wrote:
>> --- a/include/linux/perf/arm_pmu.h
>> +++ b/include/linux/perf/arm_pmu.h
>> @@ -24,10 +24,11 @@
>>  /*
>>   * ARM PMU hw_event flags
>>   */
>> -/* Event uses a 64bit counter */
>> -#define ARMPMU_EVT_64BIT		1
>> -/* Event uses a 47bit counter */
>> -#define ARMPMU_EVT_47BIT		2
>> +#define ARMPMU_EVT_64BIT		0x00001 /* Event uses a 64bit counter */
>> +#define ARMPMU_EVT_47BIT		0x00002 /* Event uses a 47bit counter */
>> +
> Minor nit:
> 
> I don't think changing the definitions to hex adds anything except more
> noise in the git blame.

The idea here was just to make these five digit hex, in accordance with
PERF_EVENT_FLAG_ARCH mask like the existing x86 platform event flags.
