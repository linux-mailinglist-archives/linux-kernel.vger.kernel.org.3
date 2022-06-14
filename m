Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC5A54BD01
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358252AbiFNVvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358361AbiFNVvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:51:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DAB552503;
        Tue, 14 Jun 2022 14:51:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA0C61763;
        Tue, 14 Jun 2022 14:51:26 -0700 (PDT)
Received: from [10.57.84.206] (unknown [10.57.84.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA0F13F73B;
        Tue, 14 Jun 2022 14:51:19 -0700 (PDT)
Message-ID: <e96a300f-abf6-f2e5-76aa-465733f83803@arm.com>
Date:   Tue, 14 Jun 2022 22:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v10 02/10] Coresight: Add coresight TPDM source driver
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220611004331.7343-1-quic_jinlmao@quicinc.com>
 <20220611004331.7343-3-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220611004331.7343-3-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2022 01:43, Mao Jinlong wrote:
> Add driver to support Coresight device TPDM (Trace, Profiling and
> Diagnostics Monitor). TPDM is a monitor to collect data from
> different datasets. This change is to add probe/enable/disable
> functions for tpdm source.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/coresight/Kconfig          |  12 ++
>   drivers/hwtracing/coresight/Makefile         |   1 +
>   drivers/hwtracing/coresight/coresight-core.c |   5 +-
>   drivers/hwtracing/coresight/coresight-tpdm.c | 149 +++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h |  26 ++++
>   include/linux/coresight.h                    |   1 +
>   6 files changed, 193 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 514a9b8086e3..b2b72a35e416 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -201,4 +201,16 @@ config CORESIGHT_TRBE
>   
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called coresight-trbe.
> +
> +config CORESIGHT_TPDM
> +	tristate "CoreSight Trace, Profiling & Diagnostics Monitor driver"
> +	select CORESIGHT_LINKS_AND_SINKS
> +	help
> +	  This driver provides support for configuring monitor. Monitors are
> +	  primarily responsible for data set collection and support the
> +	  ability to collect any permutation of data set types.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called coresight-tpdm.
> +
>   endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 329a0c704b87..6bb9b1746bc7 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -25,5 +25,6 @@ obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>   obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
>   obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
> +obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
>   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>   		   coresight-cti-sysfs.o
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 23ab16dd9b5d..1d2b5b84bb5d 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1047,7 +1047,8 @@ static int coresight_validate_source(struct coresight_device *csdev,
>   	}
>   
>   	if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
> -	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE) {
> +	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
> +	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS) {
>   		dev_err(&csdev->dev, "wrong device subtype in %s\n", function);
>   		return -EINVAL;
>   	}
> @@ -1116,6 +1117,7 @@ int coresight_enable(struct coresight_device *csdev)
>   		per_cpu(tracer_path, cpu) = path;
>   		break;
>   	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> +	case CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
>   		/*
>   		 * Use the hash of source's device name as ID
>   		 * and map the ID to the pointer of the path.
> @@ -1165,6 +1167,7 @@ void coresight_disable(struct coresight_device *csdev)
>   		per_cpu(tracer_path, cpu) = NULL;
>   		break;
>   	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> +	case CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
>   		hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
>   		/* Find the path by the hash. */
>   		path = idr_find(&path_idr, hash);
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> new file mode 100644
> index 000000000000..eb8998affa90
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/amba/bus.h>
> +#include <linux/bitmap.h>
> +#include <linux/coresight.h>
> +#include <linux/coresight-pmu.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include "coresight-priv.h"
> +#include "coresight-tpdm.h"
> +
> +DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
> +
> +/* TPDM enable operations */
> +static int tpdm_enable(struct coresight_device *csdev,
> +		       struct perf_event *event, u32 mode)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	spin_lock(&drvdata->spinlock);
> +	if (drvdata->enable) {
> +		spin_unlock(&drvdata->spinlock);
> +		return -EBUSY;
> +	}
> +
> +	drvdata->enable = true;
> +	spin_unlock(&drvdata->spinlock);
> +
> +	dev_info(drvdata->dev, "TPDM tracing enabled\n");

Please make all of these dev_dbg(). We don't want these messages
flooding the dmesg for everytime the device is turned on/off.

> +	return 0;
> +}
> +
> +/* TPDM disable operations */
> +static void tpdm_disable(struct coresight_device *csdev,
> +			 struct perf_event *event)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	spin_lock(&drvdata->spinlock);
> +	if (!drvdata->enable) {
> +		spin_unlock(&drvdata->spinlock);
> +		return;
> +	}
> +
> +	drvdata->enable = false;
> +	spin_unlock(&drvdata->spinlock);
> +
> +	dev_info(drvdata->dev, "TPDM tracing disabled\n");

Same as above. Otherwise looks good to me.

Suzuki
