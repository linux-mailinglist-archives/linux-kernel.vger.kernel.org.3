Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E3E563150
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiGAKYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiGAKYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:24:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8415C40E65;
        Fri,  1 Jul 2022 03:24:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 854161424;
        Fri,  1 Jul 2022 03:24:32 -0700 (PDT)
Received: from [10.57.85.211] (unknown [10.57.85.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A09B3F66F;
        Fri,  1 Jul 2022 03:24:29 -0700 (PDT)
Message-ID: <36f1cb8f-5ad9-9b3a-276e-2774a05707ca@arm.com>
Date:   Fri, 1 Jul 2022 11:24:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v11 6/9] Coresight: Add TPDA link driver
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
References: <20220620120101.2906-1-quic_jinlmao@quicinc.com>
 <20220620120101.2906-7-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220620120101.2906-7-quic_jinlmao@quicinc.com>
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

On 20/06/2022 13:00, Mao Jinlong wrote:
> TPDA(Trace, Profiling and Diagnostics Aggregator) is
> to provide packetization, funneling and timestamping of
> TPDM data. Multiple monitors are connected to different
> input ports of TPDA.This change is to add tpda
> enable/disable/probe functions for coresight tpda driver.
> 
>   - - - -         - - - -        - - - -
> | TPDM 0|      | TPDM 1 |     | TPDM 2|
>   - - - -         - - - -        - - - -
>      |               |             |
>      |_ _ _ _ _ _    |     _ _ _ _ |
>                  |   |    |
>                  |   |    |
>             ------------------
>            |        TPDA      |
>             ------------------
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/coresight/Kconfig          |  11 +
>   drivers/hwtracing/coresight/Makefile         |   1 +
>   drivers/hwtracing/coresight/coresight-tpda.c | 206 +++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h |  35 ++++
>   4 files changed, 253 insertions(+)
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index b2b72a35e416..0cbebfd0d23e 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -205,6 +205,7 @@ config CORESIGHT_TRBE
>   config CORESIGHT_TPDM
>   	tristate "CoreSight Trace, Profiling & Diagnostics Monitor driver"
>   	select CORESIGHT_LINKS_AND_SINKS
> +	select CORESIGHT_TPDA
>   	help
>   	  This driver provides support for configuring monitor. Monitors are
>   	  primarily responsible for data set collection and support the
> @@ -213,4 +214,14 @@ config CORESIGHT_TPDM
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called coresight-tpdm.
>   
> +config CORESIGHT_TPDA
> +	tristate "CoreSight Trace, Profiling & Diagnostics Aggregator driver"
> +	help
> +	  This driver provides support for configuring aggregator. This is
> +	  primarily useful for pulling the data sets from one or more
> +	  attached monitors and pushing the resultant data out. Multiple
> +	  monitors are connected on different input ports of TPDA.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called coresight-tpda.
>   endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 6bb9b1746bc7..1712d82e7260 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -26,5 +26,6 @@ obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
>   obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>   obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
> +obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>   		   coresight-cti-sysfs.o
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> new file mode 100644
> index 000000000000..7a0478a8b63e
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/amba/bus.h>
> +#include <linux/bitfield.h>
> +#include <linux/coresight.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include "coresight-priv.h"
> +#include "coresight-tpda.h"
> +#include "coresight-trace-id.h"
> +
> +DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
> +
> +/* Settings pre enabling port control register */
> +static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
> +{
> +	u32 val;
> +
> +	val = readl_relaxed(drvdata->base + TPDA_CR);


Even though the drvdata->atid is constant during the life time
of the driver, I would recommend clearing the field and then
setting it. e.g, if you get a different ATID on unload-load
sequence of the driver, the field will corrupted.

	val &= ~TPDA_CR_ATID;

> +	val |= FIELD_PREP(TPDA_CR_ATID, drvdata->atid);


> +	writel_relaxed(val, drvdata->base + TPDA_CR);
> +}
> +

Is there no global turn-ON for the TPDA ? Or is it per-port
enable only via TPDA_Pn_CR ?

> +static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
> +{
> +	u32 val;
> +
> +	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
> +	/* Enable the port */
> +	val |= TPDA_Pn_CR_ENA;
> +	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
> +}
> +
> +static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
> +{
> +	CS_UNLOCK(drvdata->base);
> +
> +	if (!drvdata->csdev->enable)
> +		tpda_enable_pre_port(drvdata);
> +
> +	tpda_enable_port(drvdata, port);
> +
> +	CS_LOCK(drvdata->base);
> +}
> +
> +static int tpda_enable(struct coresight_device *csdev, int inport, int outport)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	spin_lock(&drvdata->spinlock);
> +	if (atomic_read(&csdev->refcnt[inport]) == 0)
> +		__tpda_enable(drvdata, inport);
> +
> +	atomic_inc(&csdev->refcnt[inport]);
> +	spin_unlock(&drvdata->spinlock);
> +
> +	dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", inport);
> +	return 0;
> +}
> +
> +static void __tpda_disable(struct tpda_drvdata *drvdata, int port)
> +{
> +	u32 val;
> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
> +	val &= ~TPDA_Pn_CR_ENA;
> +	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
> +
> +	CS_LOCK(drvdata->base);
> +}
> +
> +static void tpda_disable(struct coresight_device *csdev, int inport,
> +			   int outport)
> +{
> +	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	spin_lock(&drvdata->spinlock);
> +	if (atomic_dec_return(&csdev->refcnt[inport]) == 0)
> +		__tpda_disable(drvdata, inport);
> +
> +	spin_unlock(&drvdata->spinlock);
> +
> +	dev_dbg(drvdata->dev, "TPDA inport %d disabled\n", inport);
> +}
> +
> +static const struct coresight_ops_link tpda_link_ops = {
> +	.enable		= tpda_enable,
> +	.disable	= tpda_disable,
> +};
> +
> +static const struct coresight_ops tpda_cs_ops = {
> +	.link_ops	= &tpda_link_ops,
> +};
> +
> +static int tpda_init_default_data(struct tpda_drvdata *drvdata)
> +{

Is there a register that indicates the number of ports on the device ?
We don't seem to be using that information.

> +	int atid;
> +	/*
> +	 * TPDA must has a unique atid. This atid can uniquely
> +	 * identify the TPDM trace source connected to the TPDA.
> +	 */
> +	atid = coresight_trace_id_get_system_id(coresight_get_trace_id_map());
> +	if (atid < 0)
> +		return atid;
> +

You need to release this id at module exit. Otherwise, we are leaking
the id.


Suzuki
