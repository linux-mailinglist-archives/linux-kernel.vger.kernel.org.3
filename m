Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935604FB8F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345021AbiDKKHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345013AbiDKKGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:06:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F37CDAE74
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:04:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B4A1169E;
        Mon, 11 Apr 2022 03:04:34 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.9.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CC9A3F5A1;
        Mon, 11 Apr 2022 03:04:33 -0700 (PDT)
Date:   Mon, 11 Apr 2022 11:04:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Al Grant <al.grant@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: Validate single/group leader events
Message-ID: <YlP9KgIZ1PW64tn9@FVFF77S0Q05N>
References: <20220408203330.4014015-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408203330.4014015-1-robh@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Apr 08, 2022 at 03:33:30PM -0500, Rob Herring wrote:
> In the case where there is only a cycle counter available (i.e.
> PMCR_EL0.N is 0) and an event other than CPU cycles is opened, the open
> should fail as the event can never possibly be scheduled. However, the
> event validation when an event is opened is skipped when the group
> leader is opened. Fix this by always validating the group leader events.
> 
> Reported-by: Al Grant <al.grant@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

This looks obviously correct to me, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Just to check, have you tested this (e.g. by running on a platform with
PMCR_EL0.N == 0, or hacking the PMU probing to report just the cycle counter)

Thanks,
Mark.

> ---
>  drivers/perf/arm_pmu.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 9694370651fa..59d3980b8ca2 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -400,6 +400,9 @@ validate_group(struct perf_event *event)
>  	if (!validate_event(event->pmu, &fake_pmu, leader))
>  		return -EINVAL;
>  
> +	if (event == leader)
> +		return 0;
> +
>  	for_each_sibling_event(sibling, leader) {
>  		if (!validate_event(event->pmu, &fake_pmu, sibling))
>  			return -EINVAL;
> @@ -489,12 +492,7 @@ __hw_perf_event_init(struct perf_event *event)
>  		local64_set(&hwc->period_left, hwc->sample_period);
>  	}
>  
> -	if (event->group_leader != event) {
> -		if (validate_group(event) != 0)
> -			return -EINVAL;
> -	}
> -
> -	return 0;
> +	return validate_group(event);
>  }
>  
>  static int armpmu_event_init(struct perf_event *event)
> -- 
> 2.32.0
> 
