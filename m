Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39394E635F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350180AbiCXM3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350182AbiCXM3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:29:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AB78CDB3;
        Thu, 24 Mar 2022 05:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CD64B82258;
        Thu, 24 Mar 2022 12:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E1DC340EC;
        Thu, 24 Mar 2022 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648124886;
        bh=qI9DesCsTcwrl5fOtbMdwn017GMdhabG8W/nlYEYXAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MiT/e+4tWu6f4jK9qQRj7nFOr2Qs18gtTdhvB2GjnJOGMc5WhoI0eQyYL2DWIe/XD
         LJioGh7hr7OQwDWfdXa6qu8r1oi+7MWhbGaRGa+BP3GV1aK0UhzKWJuW5wYshn3z/2
         RyoMaefSCT5zjPlfudmwKKF3xsJ6+6CAGc6G2PiU=
Date:   Thu, 24 Mar 2022 13:28:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 05/10] coresight-tpdm: Add integration test support
Message-ID: <Yjxj02nl+hwoYb9C@kroah.com>
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
 <20220324121734.21531-6-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324121734.21531-6-quic_jinlmao@quicinc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 08:17:29PM +0800, Mao Jinlong wrote:
> Integration test for tpdm can help to generate the data for
> verification of the topology during TPDM software bring up.
> 
> Sample:
> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/tpdm1/enable_source
> echo 1 > /sys/bus/coresight/devices/tpdm1/integration_test
> echo 2 > /sys/bus/coresight/devices/tpdm1/integration_test
> cat /dev/tmc_etf0 > /data/etf-tpdm1.bin
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/Kconfig          |  9 ++++
>  drivers/hwtracing/coresight/coresight-tpdm.c | 56 +++++++++++++++++++-
>  drivers/hwtracing/coresight/coresight-tpdm.h |  8 +++
>  3 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 5c506a1cd08f..60248fef4089 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -214,4 +214,13 @@ config CORESIGHT_TPDM
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called coresight-tpdm.
>  
> +config CORESIGHT_TPDM_INTEGRATION_TEST
> +	bool "Enable CoreSight Integration Test For TPDM"
> +	depends on CORESIGHT_TPDM
> +	help
> +	  This option adds support for the CoreSight integration test on this
> +	  devie. Coresight architecture provides integration control modes of
> +	  operation to facilitate integration testing and software bringup
> +	  and/or to instrument topology discovery. The TPDM utilizes integration
> +	  mode to accomplish integration testing and software bringup.

Why is this a Kconfig option?  Why would you never not want this?

>  endif
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index a8d257a591f3..cddd398be0cd 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -124,7 +124,60 @@ static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>  			__set_bit(i, drvdata->datasets);
>  	}
>  	CS_LOCK(drvdata->base);
> - }
> +}
> +
> +#ifdef CONFIG_CORESIGHT_TPDM_INTEGRATION_TEST

Try to keep #ifdefs out of .c files please.

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
> +	for (i = 1; i < 5; i++)
> +		writel_relaxed(val, drvdata->base + TPDM_ITATBCNTRL);
> +
> +	writel_relaxed(0, drvdata->base + TPDM_ITCNTRL);
> +	CS_LOCK(drvdata->base);
> +	return size;
> +}
> +static DEVICE_ATTR_WO(integration_test);
> +#endif /* CORESIGHT_TPDM_INTEGRATION_TEST */
> +
> +static struct attribute *tpdm_attrs[] = {
> +#ifdef CONFIG_CORESIGHT_TPDM_INTEGRATION_TEST
> +	&dev_attr_integration_test.attr,
> +#endif /* CORESIGHT_TPDM_INTEGRATION_TEST */
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

ATTRIBUTE_GROUPS()?

thanks,

greg k-h
