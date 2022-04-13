Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE65E4FF83F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiDMN77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiDMN75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:59:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E429647D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:57:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so3093702wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dcb3YhyCtjHznZSYs5+LeJVLJeyOtBrBRFQwmCzaYrA=;
        b=Q7NIkGiuf27tCd8S6eF7pPSPIoo5eVov/Sf4pITZGcG28tH/YvxpYmz/fn13xiIDxD
         ofarjKJ+5tGsvaE+x6Vhba+4G2DGoskGU+9DBvhRLOAcSIAEUmoIH3eVq4rinjouegd4
         DdM7F7EzTYrnUs0llg1XPit84WUtDAaUXF7/i9gfKK1rxOOit62iuY3+yQlNBSyNQG0n
         YmkB1CONTuYxX0HvEtTpuLRQMy5h7YPOIDjauVqzeQGiVDDoNE/BXYEbNNIeHdJBI0v4
         ePWEi5f7gTYgyXoBbH6m2+ey4iOukBg+OT+HNY8IsjS6/mzGZn/XEpNSr4DwplG0jBjO
         e09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dcb3YhyCtjHznZSYs5+LeJVLJeyOtBrBRFQwmCzaYrA=;
        b=3Ni8BBldDBIFUEq89EHY8NNunz5zPRmZbDUVIfC+hvHbnKDI4O1Bj/DId8kaGOmNKK
         d7Rk7yBANRQ0wlMdm9l3Lwz+sLgA0D4gibFSwdI3gCSjTPqUtnntjLMXBX0pv30Rgz0v
         nH74sNvrLXVM0pkF8G7MqO3OuqN/zolzAoo717K2n/+XzgECxQ+h7oM1J+sF704Kc9NG
         vxVyVBTPvAsFzfInu/KTgB2oy+SBS6OWZ2nuygTqLaUqn1BVUK52d7+Qo9PZyZ8scU7t
         bijXxTdHl+yljIt3YKvRr8uvnFtGbuUFvdYfNms4qsgftwRzw4Bzd3Fjuhlrubap+qUx
         7ZMQ==
X-Gm-Message-State: AOAM533EkypC3bbgNXcYEuXWc16R9FvYXxAPfxCRlkVMi/yaIvrr9RZB
        jPIA71L7DA83XUrkkNchPdSxYROYDGojc44zwYyawg==
X-Google-Smtp-Source: ABdhPJzsFl8WDDnkwJuvdk05A9rznBwycR3ZTSCbEKRAmmFaWwamsJAXtVQVzj15ykoOD2WCxMDwkheWYAzJLeJCzWk=
X-Received: by 2002:a05:600c:1c9c:b0:38e:3270:373d with SMTP id
 k28-20020a05600c1c9c00b0038e3270373dmr8675253wms.199.1649858253994; Wed, 13
 Apr 2022 06:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220412125035.40312-1-quic_jinlmao@quicinc.com> <20220412125035.40312-6-quic_jinlmao@quicinc.com>
In-Reply-To: <20220412125035.40312-6-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 13 Apr 2022 14:57:30 +0100
Message-ID: <CAJ9a7ViQ-vubAZCvmSRU3wjUVtVCw+4o3973Oct5ULV7aLG1gA@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] coresight-tpdm: Add integration test support
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, 12 Apr 2022 at 13:51, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
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
>  drivers/hwtracing/coresight/Kconfig          |  9 +++
>  drivers/hwtracing/coresight/coresight-tpdm.c | 64 ++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tpdm.h | 14 +++++
>  3 files changed, 87 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 5c506a1cd08f..60248fef4089 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -214,4 +214,13 @@ config CORESIGHT_TPDM
>           To compile this driver as a module, choose M here: the module will be
>           called coresight-tpdm.
>
> +config CORESIGHT_TPDM_INTEGRATION_TEST
> +       bool "Enable CoreSight Integration Test For TPDM"
> +       depends on CORESIGHT_TPDM
> +       help
> +         This option adds support for the CoreSight integration test on this
> +         devie. Coresight architecture provides integration control modes of
> +         operation to facilitate integration testing and software bringup
> +         and/or to instrument topology discovery. The TPDM utilizes integration
> +         mode to accomplish integration testing and software bringup.
>  endif

For the last patchset you mentioned that you were making this
configurable because the CTI intgration tests were also configurable.
The reason that the CTI intergration test registers were done in this
way is that some of the CoreSight components were not guaranteed to
return to a usable state once integration test was disabled.
Thus after use of the integration test, a complete board reset was
recommended. Therefore we ensured that these features would only be
used by those specifically configuring them and who were hopefully
aware of the potentail limitations

If your hardware can reliably enable and disable integration test
without adverse effects, then you may wish to consider making the
integration test a permanent feature of the driver.

Regards

Mike

> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index d7b970cdcf51..14bccbff467d 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -126,6 +126,69 @@ static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>         CS_LOCK(drvdata->base);
>  }
>
> +/*
> + * Define CONFIG_CORESIGHT_TPDM_INTEGRATION_TEST to enable
> + * integration_test sysfs nodes. It will help to generate
> + * tpdm data to make sure that the trace path is enabled
> + * and the funnel configurations are fine.
> + */
> +#ifdef CONFIG_CORESIGHT_TPDM_INTEGRATION_TEST
> +/*
> + * value 1: 64 bits test data
> + * value 2: 32 bits test data
> + */
> +static ssize_t integration_test_store(struct device *dev,
> +                                         struct device_attribute *attr,
> +                                         const char *buf,
> +                                         size_t size)
> +{
> +       int i, ret = 0;
> +       unsigned long val;
> +       struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +       ret = kstrtoul(buf, 10, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (val != 1 && val != 2)
> +               return -EINVAL;
> +
> +       if (!drvdata->enable)
> +               return -EINVAL;
> +
> +       if (val == 1)
> +               val = ATBCNTRL_VAL_64;
> +       else
> +               val = ATBCNTRL_VAL_32;
> +       CS_UNLOCK(drvdata->base);
> +       writel_relaxed(0x1, drvdata->base + TPDM_ITCNTRL);
> +
> +       for (i = 1; i < INTEGRATION_TEST_CYCLE; i++)
> +               writel_relaxed(val, drvdata->base + TPDM_ITATBCNTRL);
> +
> +       writel_relaxed(0, drvdata->base + TPDM_ITCNTRL);
> +       CS_LOCK(drvdata->base);
> +       return size;
> +}
> +static DEVICE_ATTR_WO(integration_test);
> +#endif /* CORESIGHT_TPDM_INTEGRATION_TEST */
> +
> +static struct attribute *tpdm_attrs[] = {
> +#ifdef CONFIG_CORESIGHT_TPDM_INTEGRATION_TEST
> +       &dev_attr_integration_test.attr,
> +#endif /* CORESIGHT_TPDM_INTEGRATION_TEST */
> +       NULL,
> +};
> +
> +static struct attribute_group tpdm_attr_grp = {
> +       .attrs = tpdm_attrs,
> +};
> +
> +static const struct attribute_group *tpdm_attr_grps[] = {
> +       &tpdm_attr_grp,
> +       NULL,
> +};
> +
>  static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>  {
>         struct device *dev = &adev->dev;
> @@ -160,6 +223,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>         desc.ops = &tpdm_cs_ops;
>         desc.pdata = adev->dev.platform_data;
>         desc.dev = &adev->dev;
> +       desc.groups = tpdm_attr_grps;
>         drvdata->csdev = coresight_register(&desc);
>         if (IS_ERR(drvdata->csdev))
>                 return PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 8f05070879c4..ea457ba5434e 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -12,6 +12,20 @@
>  /* DSB Subunit Registers */
>  #define TPDM_DSB_CR            (0x780)
>
> +/* TPDM integration test registers */
> +#define TPDM_ITATBCNTRL                (0xEF0)
> +#define TPDM_ITCNTRL           (0xF00)
> +
> +/* Register value for integration test */
> +#define ATBCNTRL_VAL_32                0xC00F1409
> +#define ATBCNTRL_VAL_64                0xC01F1409
> +
> +/*
> + * Number of cycles to write value when
> + * integration test.
> + */
> +#define INTEGRATION_TEST_CYCLE 10
> +
>  /**
>   * This enum is for PERIPHIDR0 register of TPDM.
>   * The fields [6:0] of PERIPHIDR0 are used to determine what
> --
> 2.17.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
