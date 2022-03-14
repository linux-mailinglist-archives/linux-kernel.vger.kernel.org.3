Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AD54D8B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbiCNSC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbiCNSC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:02:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B65D3A1AB;
        Mon, 14 Mar 2022 11:01:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F3141474;
        Mon, 14 Mar 2022 11:01:16 -0700 (PDT)
Received: from [10.57.22.102] (unknown [10.57.22.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9982F3F66F;
        Mon, 14 Mar 2022 11:01:11 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] perf mem: Support HITM for when mem_lvl_num is
 used
To:     Leo Yan <leo.yan@linaro.org>, Ali Saidi <alisaidi@amazon.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org, yao.jin@linux.intel.com,
        Nick.Forrington@arm.com
References: <20220313124427.GB143848@leoy-ThinkPad-X240s>
 <20220313191933.26621-1-alisaidi@amazon.com>
 <20220314063353.GB163961@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <df73fb93-3892-6713-8ebe-bc57a861ec5d@arm.com>
Date:   Mon, 14 Mar 2022 18:00:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220314063353.GB163961@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo, Ali

On 14/03/2022 06:33, Leo Yan wrote:
> On Sun, Mar 13, 2022 at 07:19:33PM +0000, Ali Saidi wrote:
>
> [...]
>
>>>>> +			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L4)) {
>>>> According to a comment in the previous patch, using L4 is specific to Neoverse, right?
>>>>
>>>> Maybe we need to distinguish the Neoverse case from the generic one here as well
>>>>
>>>> if (is_neoverse)
>>>> // treat L4 as llc
>>>> else
>>>> // treat L3 as llc
>>> I personally think it's not good idea to distinguish platforms in the decoding code.
>> I agree here. The more we talk about this, the more I'm wondering if we're
>> spending too much code solving a problem that doesn't exist. I know of no
>> Neoverse systems that actually have 4 cache levels, they all actually have three
>> even though it's technically possible to have four.  I have some doubts anyone
>> will actually build four levels of cache and perhaps the most prudent path here
>> is to assume only three levels (and adjust the previous patch) until someone 
>> actually produces a system with four levels instead of a lot of code that is
>> never actually exercised?
> I am not right person to say L4 cache is not implemented in Neoverse
> platforms; my guess for a "System cache" data source might be L3 or
> L4 and it is a implementation dependent.  Maybe German or Arm mates
> could confirm for this.

I had a look at the TRMs for the N1[1], V1[2] and N2[3] Neoverse cores
(specifically the LL_CACHE_RD pmu events). If we were to assign a number
to the system cache (assuming all caches are implemented):

*For N1*, if L2 and L3 are implemented, system cache would follow at *L4*

*For V1 and N2*, if L2 is implemented, system cache would follow at *L3*
(these don't seem to have the same/similar per-cluster L3 cache from the N1)

There's also room in the PERF_MEM_LVLNUM_* namespace for a SYSTEM value,
if we want to consider that option as well.

[1] https://developer.arm.com/documentation/100616/0401/?lang=en
[2] https://developer.arm.com/documentation/101427/0101/?lang=en
[3] https://developer.arm.com/documentation/102099/0001/?lang=en

>
> Thanks,
> Leo
