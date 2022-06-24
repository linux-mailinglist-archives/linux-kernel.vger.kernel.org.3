Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF0A55A0BB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiFXSJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiFXSJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:09:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 483A33F33B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:09:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 453271042;
        Fri, 24 Jun 2022 11:09:15 -0700 (PDT)
Received: from [10.57.84.111] (unknown [10.57.84.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 793C93F792;
        Fri, 24 Jun 2022 11:09:13 -0700 (PDT)
Message-ID: <c981692b-af7b-453d-39af-402221e174f5@arm.com>
Date:   Fri, 24 Jun 2022 19:09:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND] perf/marvell_cn10k: Add MPAM support for TAD PMU
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>, Tanmay Jagdale <tanmay@marvell.com>
Cc:     mark.rutland@arm.com, robh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com,
        amitsinght@marvell.com, james.morse@arm.com
References: <20220527185647.3138084-1-tanmay@marvell.com>
 <20220624121435.GA18561@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220624121435.GA18561@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-24 13:14, Will Deacon wrote:
> On Sat, May 28, 2022 at 12:26:47AM +0530, Tanmay Jagdale wrote:
>> The TAD PMU supports following counters that can be filtered by MPAM
>> partition id.
>>      - (0x1a) tad_alloc_dtg : Allocations to DTG.
>>      - (0x1b) tad_alloc_ltg : Allocations to LTG.
>>      - (0x1c) tad_alloc_any : Total allocations to DTG/LTG.
>>      - (0x1d) tad_hit_dtg   : DTG hits.
>>      - (0x1e) tad_hit_ltg   : LTG hits.
>>      - (0x1f) tad_hit_any   : Hit in LTG/DTG.
>>      - (0x20) tad_tag_rd    : Total tag reads.
>>
>> Add a new 'partid' attribute of 16-bits to get the partition id
>> passed from perf tool. This value would be stored in config1 field
>> of perf_event_attr structure.
>>
>> Example:
>> perf stat -e tad/tad_alloc_any,partid=0x12/ <program>
>>
>> - Drop read of TAD_PRF since we don't have to preserve any
>>    bit fields and always write an updated value.
>> - Update register offsets of TAD_PRF and TAD_PFC.
> 
> It would be great if you could document some of this under
> Documentation/admin-guide/perf like many of the other PMU drivers have
> done.

Especially documenting how the user obtains the required partid value to 
pass.

Thanks,
Robin.

>> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
>> ---
>>   drivers/perf/marvell_cn10k_tad_pmu.c | 23 ++++++++++++++++++-----
>>   1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
>> index 282d3a071a67..f552e6bffcac 100644
>> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
>> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
>> @@ -18,10 +18,12 @@
>>   #include <linux/perf_event.h>
>>   #include <linux/platform_device.h>
>>   
>> -#define TAD_PFC_OFFSET		0x0
>> +#define TAD_PFC_OFFSET		0x800
>>   #define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
>> -#define TAD_PRF_OFFSET		0x100
>> +#define TAD_PRF_OFFSET		0x900
>>   #define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
>> +#define TAD_PRF_MATCH_PARTID	(1 << 8)
>> +#define TAD_PRF_PARTID_NS	(1 << 10)
>>   #define TAD_PRF_CNTSEL_MASK	0xFF
>>   #define TAD_MAX_COUNTERS	8
>>   
>> @@ -86,23 +88,32 @@ static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
>>   	struct hw_perf_event *hwc = &event->hw;
>>   	u32 event_idx = event->attr.config;
>>   	u32 counter_idx = hwc->idx;
>> +	u32 partid_filter = 0;
>>   	u64 reg_val;
>> +	u32 partid;
>>   	int i;
>>   
>>   	hwc->state = 0;
>>   
>> +	/* Extract the partid (if any) passed by user */
>> +	partid = event->attr.config1 & 0x3f;
> 
> [...]
> 
>>   PMU_FORMAT_ATTR(event, "config:0-7");
>> +PMU_FORMAT_ATTR(partid, "config1:0-15");
> 
> This doesn't seem to match the mask used above?
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
