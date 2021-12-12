Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0866C471917
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhLLH0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhLLH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:26:25 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB3C061714;
        Sat, 11 Dec 2021 23:26:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 59F42424CD;
        Sun, 12 Dec 2021 07:26:20 +0000 (UTC)
Subject: Re: [PATCH v2 7/8] drivers/perf: arm_pmu: Handle 47 bit counters
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
References: <20211201134909.390490-1-maz@kernel.org>
 <20211201134909.390490-8-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <67468c6c-d799-f407-a3e6-5f86c14af400@marcan.st>
Date:   Sun, 12 Dec 2021 16:26:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211201134909.390490-8-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 22.49, Marc Zyngier wrote:
> The current ARM PMU framework can only deal with 32 or 64bit counters.
> Teach it about a 47bit flavour.
> 
> Yes, this is odd.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/perf/arm_pmu.c       | 2 ++
>   include/linux/perf/arm_pmu.h | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 295cc7952d0e..0a9ed1a061ac 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -109,6 +109,8 @@ static inline u64 arm_pmu_event_max_period(struct perf_event *event)
>   {
>   	if (event->hw.flags & ARMPMU_EVT_64BIT)
>   		return GENMASK_ULL(63, 0);
> +	else if (event->hw.flags & ARMPMU_EVT_47BIT)
> +		return GENMASK_ULL(46, 0);
>   	else
>   		return GENMASK_ULL(31, 0);
>   }
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 2512e2f9cd4e..0407a38b470a 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -26,6 +26,8 @@
>    */
>   /* Event uses a 64bit counter */
>   #define ARMPMU_EVT_64BIT		1
> +/* Event uses a 47bit counter */
> +#define ARMPMU_EVT_47BIT		2
>   
>   #define HW_OP_UNSUPPORTED		0xFFFF
>   #define C(_x)				PERF_COUNT_HW_CACHE_##_x
> 

Reviewed-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
