Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B39B4A862D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351167AbiBCO1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:27:33 -0500
Received: from foss.arm.com ([217.140.110.172]:49602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238689AbiBCO1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:27:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F10761063;
        Thu,  3 Feb 2022 06:27:31 -0800 (PST)
Received: from [10.57.89.13] (unknown [10.57.89.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B20853F774;
        Thu,  3 Feb 2022 06:27:30 -0800 (PST)
Message-ID: <8d2fc78e-f061-daa1-b266-ef84d5dd316f@arm.com>
Date:   Thu, 3 Feb 2022 14:27:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 02/15] coresight: Make ETM4x TRCIDR2 register accesses
 consistent with sysreg.h
To:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202160226.37858-1-james.clark@arm.com>
 <20220202160226.37858-3-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220202160226.37858-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2022 16:02, James Clark wrote:
> This is a no-op change for style and consistency and has no effect on the
> binary produced by gcc-11.
> 
> Signed-off-by: James Clark <james.clark@arm.com>


> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 6 +++---
>   drivers/hwtracing/coresight/coresight-etm4x.h      | 7 +++++++
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 8aefee4e72fd..4abe5444234e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1111,11 +1111,11 @@ static void etm4_init_arch_data(void *info)
>   	/* maximum size of resources */
>   	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
>   	/* CIDSIZE, bits[9:5] Indicates the Context ID size */
> -	drvdata->ctxid_size = BMVAL(etmidr2, 5, 9);
> +	drvdata->ctxid_size = REG_VAL(etmidr2, TRCIDR2_CIDSIZE);
>   	/* VMIDSIZE, bits[14:10] Indicates the VMID size */
> -	drvdata->vmid_size = BMVAL(etmidr2, 10, 14);
> +	drvdata->vmid_size = REG_VAL(etmidr2, TRCIDR2_VMIDSIZE);
>   	/* CCSIZE, bits[28:25] size of the cycle counter in bits minus 12 */
> -	drvdata->ccsize = BMVAL(etmidr2, 25, 28);
> +	drvdata->ccsize = REG_VAL(etmidr2, TRCIDR2_CCSIZE);
>   
>   	etmidr3 = etm4x_relaxed_read32(csa, TRCIDR3);
>   	/* CCITMIN, bits[11:0] minimum threshold value that can be programmed */
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 2bd8ad953b8e..a95df5686b4b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -147,6 +147,13 @@
>   #define TRCIDR0_TSSIZE_SHIFT			24
>   #define TRCIDR0_TSSIZE_MASK			GENMASK(4, 0)
>   
> +#define TRCIDR2_CIDSIZE_SHIFT			5
> +#define TRCIDR2_CIDSIZE_MASK			GENMASK(4, 0)
> +#define TRCIDR2_VMIDSIZE_SHIFT			10
> +#define TRCIDR2_VMIDSIZE_MASK			GENMASK(4, 0)
> +#define TRCIDR2_CCSIZE_SHIFT			25
> +#define TRCIDR2_CCSIZE_MASK			GENMASK(3, 0)
> +

Looks good to me. I have confirmed the above changes matches the spec.

Suzuki
