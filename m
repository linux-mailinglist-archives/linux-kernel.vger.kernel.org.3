Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D1753EB86
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiFFQgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiFFQgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:36:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8A1B7F7;
        Mon,  6 Jun 2022 09:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F070A60C93;
        Mon,  6 Jun 2022 16:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B57C385A9;
        Mon,  6 Jun 2022 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654533362;
        bh=0Mjg97U+ZMbST6i3lAYoqGdbBWQbXG3j5keTPSi7ieg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sy/VMLg9MW8C0l9Zr0sNxqtsspglU0kkaNq2eEia/2PxI5+Q2f6dSBLb4gOJ3vnTX
         fl05wLcv9Y3j2ZfIQlo+pU/E1XoxPtcrduH/v0+SkDFZXEMiStQx0Uert34UQ7KXre
         47gRZQMQ2DvMS/CX+ZzQkSerZQe6GY0+RavtTcs87RFi3toceavaIFlJGqJ0gTRXI+
         zjf5c/FOzORqq3hpbw/i2bq8KPllQ1EAleKosvdED8vwgq5A7Z9PzFbft8sXx40dP1
         wEisxn6cbmo7Hxmro/CBvVfwkPaLbZw5ctwOVSmQFE9R2qcQjG0EQ09Fa1C8YkS2k7
         ytmgpVftCrWVw==
Message-ID: <29ac9241-7007-1c5b-a313-2bdea32e1dc8@kernel.org>
Date:   Mon, 6 Jun 2022 19:35:55 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/4] soc: qcom: icc-bwmon: Add bandwidth monitoring
 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-3-krzysztof.kozlowski@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220601101140.170504-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for working on this!

On 1.06.22 13:11, Krzysztof Kozlowski wrote:
> Bandwidth monitoring (BWMON) sits between various subsytems like CPU,
> GPU, Last Level caches and memory subsystem.  The BWMON can be
> configured to monitor the data throuhput between memory and other
> subsytems.  The throughput is measured within specified sampling window
> and is used to vote for corresponding interconnect bandwidth.
> 
> Current implementation brings support for BWMON v4, used for example on
> SDM845 to measure bandwidth between CPU (gladiator_noc) and Last Level
> Cache (memnoc).  Usage of this BWMON allows to remove fixed bandwidth
> votes from cpufreq (CPU nodes) thus achieve high memory throughput even
> with lower CPU frequencies.

I am curious if you ran any tests - e.g set the CPU to some fixed
frequency and run memory throughput benchmarks with/without this
driver? Could you share any data?

> Co-developed-by: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   MAINTAINERS                  |   7 +
>   drivers/soc/qcom/Kconfig     |  15 ++
>   drivers/soc/qcom/Makefile    |   1 +
>   drivers/soc/qcom/icc-bwmon.c | 421 +++++++++++++++++++++++++++++++++++
>   4 files changed, 444 insertions(+)
>   create mode 100644 drivers/soc/qcom/icc-bwmon.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6157e706ed02..bc123f706256 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16376,6 +16376,13 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
>   F:	drivers/i2c/busses/i2c-qcom-cci.c
>   
> +QUALCOMM INTERCONNECT BWMON DRIVER
> +M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
> +F:	drivers/soc/qcom/icc-bwmon.c
> +
>   QUALCOMM IOMMU
>   M:	Rob Clark <robdclark@gmail.com>
>   L:	iommu@lists.linux-foundation.org
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index e718b8735444..35c5192dcfc7 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -228,4 +228,19 @@ config QCOM_APR
>   	  application processor and QDSP6. APR is
>   	  used by audio driver to configure QDSP6
>   	  ASM, ADM and AFE modules.
> +
> +config QCOM_ICC_BWMON
> +	tristate "QCOM Interconnect Bandwidth Monitor driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select PM_OPP
> +	help
> +	  Sets up driver monitoring bandwidth on various interconnects and
> +	  based on that voting for interconnect bandwidth, adjusting their
> +	  speed to current demand.
> +	  Current implementation brings support for BWMON v4, used for example
> +	  on SDM845 to measure bandwidth between CPU (gladiator_noc) and Last
> +	  Level Cache (memnoc).  Usage of this BWMON allows to remove fixed
> +	  bandwidth votes from cpufreq (CPU nodes) thus achieve high memory
> +	  throughput even with lower CPU frequencies.
> +
>   endmenu
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 70d5de69fd7b..d66604aff2b0 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -28,3 +28,4 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
>   obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>   obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>   obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
> +obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> new file mode 100644
> index 000000000000..1eed075545db
> --- /dev/null
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -0,0 +1,421 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2014-2018, The Linux Foundation. All rights reserved.
> + * Copyright (C) 2021-2022 Linaro Ltd
> + * Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, based on
> + *         previous work of Thara Gopinath and msm-4.9 downstream sources.
> + */
> +#include <linux/interconnect.h>

Is this used?

> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/sizes.h>

Ditto.

Thanks,
Georgi
