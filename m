Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE5E530D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiEWJR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiEWJRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:17:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06092457B5;
        Mon, 23 May 2022 02:17:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEA55ED1;
        Mon, 23 May 2022 02:17:16 -0700 (PDT)
Received: from [10.57.34.201] (unknown [10.57.34.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8AA83F73D;
        Mon, 23 May 2022 02:17:13 -0700 (PDT)
Message-ID: <7fd884ed-1255-5976-6fcc-7a19ad0eb04e@arm.com>
Date:   Mon, 23 May 2022 10:17:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v7 05/10] coresight-tpdm: Add integration test support
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
 <20220509133947.20987-6-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220509133947.20987-6-quic_jinlmao@quicinc.com>
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

On 09/05/2022 14:39, Mao Jinlong wrote:
> Integration test for tpdm can help to generate the data for
> verification of the topology during TPDM software bring up.
> 
> Sample:
> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
> echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
> echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
> cat /dev/tmc_etf0 > /data/etf-tpdm0.bin
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>

Please could we stick this under a sub-Kconfig entry, like
we did for the CTI ?

CONFIG_CORESIGHT_TPMD_INTEGRATION_TEST

> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 54 ++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h | 14 +++++
>   2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 70df888ac565..57e38aa7d2bd 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -123,6 +123,59 @@ static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>   	CS_LOCK(drvdata->base);
>   }
>   
> +/*
> + * value 1: 64 bits test data
> + * value 2: 32 bits test data
> + */
> +static ssize_t integration_test_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf,
> +					  size_t size)
> +{
> +	int i, ret = 0;
> +	unsigned long val;
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != 1 && val != 2)
> +		return -EINVAL;
> +
> +	if (!drvdata->enable)
> +		return -EINVAL;
> +
> +	if (val == 1)
> +		val = ATBCNTRL_VAL_64;
> +	else
> +		val = ATBCNTRL_VAL_32;
> +	CS_UNLOCK(drvdata->base);
> +	writel_relaxed(0x1, drvdata->base + TPDM_ITCNTRL);
> +
> +	for (i = 1; i < INTEGRATION_TEST_CYCLE; i++)

super minor nit : It is a bit un-natural, not to have i = 0;

Rest looks fine to me .

Suzuki


> +		writel_relaxed(val, drvdata->base + TPDM_ITATBCNTRL);
> +
> +	writel_relaxed(0, drvdata->base + TPDM_ITCNTRL);
> +	CS_LOCK(drvdata->base);
> +	return size;
> +}
> +static DEVICE_ATTR_WO(integration_test);
> +
> +static struct attribute *tpdm_attrs[] = {
> +	&dev_attr_integration_test.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group tpdm_attr_grp = {
> +	.attrs = tpdm_attrs,
> +};
> +
> +static const struct attribute_group *tpdm_attr_grps[] = {
> +	&tpdm_attr_grp,
> +	NULL,
> +};
> +
>   static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   {
>   	struct device *dev = &adev->dev;
> @@ -157,6 +210,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>   	desc.ops = &tpdm_cs_ops;
>   	desc.pdata = adev->dev.platform_data;
>   	desc.dev = &adev->dev;
> +	desc.groups = tpdm_attr_grps;
>   	drvdata->csdev = coresight_register(&desc);
>   	if (IS_ERR(drvdata->csdev))
>   		return PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index f95aaad9c653..4aa880794383 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -14,6 +14,20 @@
>   /* Enable bit for DSB subunit */
>   #define TPDM_DSB_CR_ENA		BIT(0)
>   
> +/* TPDM integration test registers */
> +#define TPDM_ITATBCNTRL		(0xEF0)
> +#define TPDM_ITCNTRL		(0xF00)
> +
> +/* Register value for integration test */
> +#define ATBCNTRL_VAL_32		0xC00F1409
> +#define ATBCNTRL_VAL_64		0xC01F1409
> +
> +/*
> + * Number of cycles to write value when
> + * integration test.
> + */
> +#define INTEGRATION_TEST_CYCLE	10
> +
>   /**
>    * This enum is for PERIPHIDR0 register of TPDM.
>    * The fields [6:0] of PERIPHIDR0 are used to determine what

