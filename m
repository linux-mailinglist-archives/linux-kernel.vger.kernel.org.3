Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092E3511500
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiD0Kls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiD0Klq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:41:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8035F3614A6;
        Wed, 27 Apr 2022 03:20:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8576214BF;
        Wed, 27 Apr 2022 03:16:23 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CE3D3F774;
        Wed, 27 Apr 2022 03:16:19 -0700 (PDT)
Message-ID: <99352dbe-c7dd-73da-3e48-807dcaea3e91@arm.com>
Date:   Wed, 27 Apr 2022 11:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V1] arm64: perf: Change PMCR write to read-modify-write
Content-Language: en-GB
To:     Srinivasarao Pathipati <quic_spathi@quicinc.com>, will@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1651053105-11557-1-git-send-email-quic_spathi@quicinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1651053105-11557-1-git-send-email-quic_spathi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-27 10:51, Srinivasarao Pathipati wrote:
> Preserve the bitfields of PMCR_EL0 during PMU reset.
> Reset routine should set only PMCR.C, PMCR.P and PMCR.LC fields only
> to reset the counters. Other fields should not be changed
> as they could be set before PMU initialization and their value must
> be preserved even after reset.

No. We also want to ensure PMCR.E and PMCR.D are set to 0, for example. 
Given that nearly all the writeable fields in PMCR reset to an 
architecturally UNKNOWN value, preserving that is clearly nonsense. 
What's your *real* motivation here?

Thanks,
Robin.

> Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
> ---
>   arch/arm64/kernel/perf_event.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cb69ff1..9e22326 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1047,7 +1047,7 @@ static void armv8pmu_reset(void *info)
>   	if (armv8pmu_has_long_event(cpu_pmu))
>   		pmcr |= ARMV8_PMU_PMCR_LP;
>   
> -	armv8pmu_pmcr_write(pmcr);
> +	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | pmcr);
>   }
>   
>   static int __armv8_pmuv3_map_event(struct perf_event *event,
