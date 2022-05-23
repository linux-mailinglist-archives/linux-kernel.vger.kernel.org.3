Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E274530DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiEWJLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiEWJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:11:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0524246642;
        Mon, 23 May 2022 02:11:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD9DFED1;
        Mon, 23 May 2022 02:11:51 -0700 (PDT)
Received: from [10.57.34.201] (unknown [10.57.34.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 009023F73D;
        Mon, 23 May 2022 02:11:48 -0700 (PDT)
Message-ID: <00c30f02-de4e-6bd1-f220-00ae114ef91f@arm.com>
Date:   Mon, 23 May 2022 10:11:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v7 04/10] coresight-tpdm: Add DSB dataset support
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
References: <20220509133947.20987-1-quic_jinlmao@quicinc.com>
 <20220509133947.20987-5-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220509133947.20987-5-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 09/05/2022 14:39, Mao Jinlong wrote:
> TPDM serves as data collection component for various dataset types.
> DSB(Discrete Single Bit) is one of the dataset types. DSB subunit
> can be enabled for data collection by writing 1 to the first bit of
> DSB_CR register. This change is to add enable/disable function for
> DSB dataset by writing DSB_CR register.

The patch looks good to me, except for some minor comment below.

> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 58 ++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h | 23 ++++++++
>   2 files changed, 81 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 6a4e2a35053d..70df888ac565 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -20,7 +20,28 @@
>   
>   DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>   
> +static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
> +{
> +	u32 val;
> +
> +	/* Set the enable bit of DSB control register to 1 */
> +	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> +	val |= TPDM_DSB_CR_ENA;
> +	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
> +}
> +
>   /* TPDM enable operations */
> +static void _tpdm_enable(struct tpdm_drvdata *drvdata)
> +{
> +	CS_UNLOCK(drvdata->base);
> +
> +	/* Check if DSB datasets is present for TPDM. */
> +	if (drvdata->datasets & BIT(TPDM_DS_DSB))
> +		tpdm_enable_dsb(drvdata);
> +
> +	CS_LOCK(drvdata->base);
> +}
> +
>   static int tpdm_enable(struct coresight_device *csdev,
>   		       struct perf_event *event, u32 mode)
>   {
> @@ -32,6 +53,7 @@ static int tpdm_enable(struct coresight_device *csdev,
>   		return -EBUSY;
>   	}
>   
> +	_tpdm_enable(drvdata);
>   	drvdata->enable = true;
>   	mutex_unlock(&drvdata->lock);
>   
> @@ -39,7 +61,29 @@ static int tpdm_enable(struct coresight_device *csdev,
>   	return 0;
>   }
>   
> +static void tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
> +{
> +	u32 val;
> +
> +	/* Set the enable bit of DSB control register to 0 */
> +	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> +	val &= ~TPDM_DSB_CR_ENA;
> +	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
> +}
> +
>   /* TPDM disable operations */
> +static void _tpdm_disable(struct tpdm_drvdata *drvdata)
> +{
> +	CS_UNLOCK(drvdata->base);
> +
> +	/* Check if DSB datasets is present for TPDM. */
> +	if (drvdata->datasets & BIT(TPDM_DS_DSB))
> +		tpdm_disable_dsb(drvdata);
> +
> +	CS_LOCK(drvdata->base);
> +

nit: extra new line.
> +}
> +
>   static void tpdm_disable(struct coresight_device *csdev,
>   			 struct perf_event *event)
>   {
> @@ -51,6 +95,7 @@ static void tpdm_disable(struct coresight_device *csdev,
>   		return;
>   	}
>   
> +	_tpdm_disable(drvdata);
>   	drvdata->enable = false;
>   	mutex_unlock(&drvdata->lock);
>   
> @@ -66,6 +111,18 @@ static const struct coresight_ops tpdm_cs_ops = {
>   	.source_ops	= &tpdm_source_ops,
>   };
>   
> +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> +{
> +	int i;
> +	u32 pidr;
> +
> +	CS_UNLOCK(drvdata->base);
> +	/*  Get the datasets present on the TPDM. */
> +	pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
> +	drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
> +	CS_LOCK(drvdata->base);
> +}
> +
>   static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   {
>   	struct device *dev = &adev->dev;
> @@ -104,6 +161,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   	if (IS_ERR(drvdata->csdev))
>   		return PTR_ERR(drvdata->csdev);
>   
> +	tpdm_init_default_data(drvdata);
>   	/* Decrease pm refcount when probe is done.*/
>   	pm_runtime_put(&adev->dev);
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 94a7748a5426..f95aaad9c653 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -6,6 +6,27 @@
>   #ifndef _CORESIGHT_CORESIGHT_TPDM_H
>   #define _CORESIGHT_CORESIGHT_TPDM_H
>   
> +/* The max number of the datasets that TPDM supports */
> +#define TPDM_DATASETS       7
> +
> +/* DSB Subunit Registers */
> +#define TPDM_DSB_CR		(0x780)
> +/* Enable bit for DSB subunit */
> +#define TPDM_DSB_CR_ENA		BIT(0)
> +
> +/**
> + * This enum is for PERIPHIDR0 register of TPDM.
> + * The fields [6:0] of PERIPHIDR0 are used to determine what
> + * interfaces and subunits are present on a given TPDM.
> + *
> + * PERIPHIDR0[0] : Fix to 1 if ImplDef subunit present, else 0
> + * PERIPHIDR0[1] : Fix to 1 if DSB subunit present, else 0
> + */
> +enum tpdm_dataset {
> +	TPDM_DS_IMPLDEF,
> +	TPDM_DS_DSB,
> +};

Please could we name this explicitly to indicate the register field they 
appear in ? e.g,

#define TPDM_PIDR0_DS_IMPDEF	BIT(0)
#define	TPDM_PIDR0_DS_DSB	BIT(1)

Suzuki
