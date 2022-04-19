Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EEB5067A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350339AbiDSJ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiDSJ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:26:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A3C2A70E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:23:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k22so21572251wrd.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hRsDdiN6EhYKNLyrnkRjNTtwirzyg/RAEgpP11Cwmw=;
        b=FwrkovJcbdIVVMXVZWDUd5jd9axLQKpGMMYf+/AwrNpSA4jvBwMtP2Bh9hj2vyL5XU
         9JoxGYABR7NsVOA/E8sxGGpu3PG9jeQX//T5QU27wm5ZjiernPenAjK+V045uO0qCzSz
         XARaMJN0CbE7xR/CNUwae4cWnzJQMrat0OVUy59iZmcWQ4YhV4lph6CF/H17z2W2V5x5
         toeBX6m+4ul1pSonCRsIfG8zQZtHvV7YJjpbVKy3uy4eXeS+5HfCHrPhtlVdCfbQm/Vy
         7LguSP2WgY1y3UU56eRkQTOewjPQYdLUYKBbo8KueTof8lIIBXnb4Pd6+P0ChWnK8WAY
         3fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hRsDdiN6EhYKNLyrnkRjNTtwirzyg/RAEgpP11Cwmw=;
        b=0haS00v5L2shheIvPSdn/tThSV/2KHu3E2NuhoXT33ZCYoqXLImj7RXkpfbwja8JwL
         T+dQL1WUFJKRgpS/CGhxofa2N5B8bxOIp9Dm5yIKfp+nYwA4y+5LRWZqOh9FtDRi8aC6
         Uh5G0prU23GF3Cy+Zxyg71y+yY+jzqeMZU0F9MqjeQmqRba/5Stef0UFLrDfs6kT5EXP
         S2BMOvThk7xCoKIHXSC3Q216Dziwtk6Rqo3TCQXRSi1EPdE/g8WjjqjaiUkyAAFujnu4
         S/kB6IexjAOj+VVL9zGbKrjGYjSBtwkhaphWd0poSBTAZgYIR2hRyXIwZBOC8/b2625Q
         1RhQ==
X-Gm-Message-State: AOAM53301mB76+puk4TLvDUvvF45NNMdfZ9sMQS/NvVSMI7pmG2XoyNN
        Krx6v8XN1P3osr6Ik+Hu+xuA0o/K7hfyQHT676N9BtIVrVd7+w==
X-Google-Smtp-Source: ABdhPJyMt3crfvBgV9o3/3yKrUdfD4Oj81eHudDowT7GqmyY7T/j+yqnmgR8PNmRZYHU3Bk2y3E4WE/I1Z34HDgCJ10=
X-Received: by 2002:adf:e5d2:0:b0:207:9be3:c080 with SMTP id
 a18-20020adfe5d2000000b002079be3c080mr10945204wrn.519.1650360205037; Tue, 19
 Apr 2022 02:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220412125035.40312-1-quic_jinlmao@quicinc.com> <20220412125035.40312-5-quic_jinlmao@quicinc.com>
In-Reply-To: <20220412125035.40312-5-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 19 Apr 2022 10:23:23 +0100
Message-ID: <CAJ9a7ViDkaqykQTiPX7T7z0T0cDOfnyDM6H7sY=dNDe0DqZwDw@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] coresight-tpdm: Add DSB dataset support
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

Hi,

On Tue, 12 Apr 2022 at 13:51, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> TPDM serves as data collection component for various dataset types.
> DSB(Discrete Single Bit) is one of the dataset types. DSB subunit
> can be enabled for data collection by writing 1 to the first bit of
> DSB_CR register. This change is to add enable/disable function for
> DSB dataset by writing DSB_CR register.
>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-tpdm.c | 61 ++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tpdm.h | 21 +++++++
>  2 files changed, 82 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 3900ae50670a..d7b970cdcf51 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -20,7 +20,28 @@
>
>  DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>
> +static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
> +{
> +       u32 val;
> +
> +       /* Set the enable bit of DSB control register to 1 */
> +       val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> +       val = val | BIT(0);

Please use #defined values, declared in the header file rather than
BIT(x) here. (the etm4x drivers have been recently updated to use the
same pattern).
e.g.
 val |= TPDM_DSB_CR_ENA;

> +       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
> +}
> +
>  /* TPDM enable operations */
> +static void _tpdm_enable(struct tpdm_drvdata *drvdata)
> +{
> +       CS_UNLOCK(drvdata->base);
> +
> +       /* Check if DSB datasets is present for TPDM. */
> +       if (test_bit(TPDM_DS_DSB, drvdata->datasets))
> +               tpdm_enable_dsb(drvdata);
> +
> +       CS_LOCK(drvdata->base);
> +}
> +
>  static int tpdm_enable(struct coresight_device *csdev,
>                        struct perf_event *event, u32 mode)
>  {
> @@ -32,6 +53,7 @@ static int tpdm_enable(struct coresight_device *csdev,
>                 return -EBUSY;
>         }
>
> +       _tpdm_enable(drvdata);
>         drvdata->enable = true;
>         mutex_unlock(&drvdata->lock);
>
> @@ -39,7 +61,29 @@ static int tpdm_enable(struct coresight_device *csdev,
>         return 0;
>  }
>
> +static void tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
> +{
> +       u32 val;
> +
> +       /* Set the enable bit of DSB control register to 0 */
> +       val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> +       val = val & ~BIT(0);

val &= ~TPDM_DSB_CR_ENA;

> +       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
> +}
> +
>  /* TPDM disable operations */
> +static void _tpdm_disable(struct tpdm_drvdata *drvdata)
> +{
> +       CS_UNLOCK(drvdata->base);
> +
> +       /* Check if DSB datasets is present for TPDM. */
> +       if (test_bit(TPDM_DS_DSB, drvdata->datasets))
> +               tpdm_disable_dsb(drvdata);
> +
> +       CS_LOCK(drvdata->base);
> +
> +}
> +
>  static void tpdm_disable(struct coresight_device *csdev,
>                          struct perf_event *event)
>  {
> @@ -51,6 +95,7 @@ static void tpdm_disable(struct coresight_device *csdev,
>                 return;
>         }
>
> +       _tpdm_disable(drvdata);
>         drvdata->enable = false;
>         mutex_unlock(&drvdata->lock);
>
> @@ -66,6 +111,21 @@ static const struct coresight_ops tpdm_cs_ops = {
>         .source_ops     = &tpdm_source_ops,
>  };
>
> +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> +{
> +       int i;
> +       u32 pidr;
> +
> +       CS_UNLOCK(drvdata->base);
> +       /*  Get the datasets present on the TPDM. */
> +       pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
> +       for (i = 0; i < TPDM_DATASETS; i++) {
> +               if (pidr & BIT(i))
> +                       __set_bit(i, drvdata->datasets);

Could this be considerably simpified? - there are a maximum of 7 bits
for datasets - and you are setting the same bit in drvdata->datasets
for each bit in pidr

e.g. if the datasets declaration is a simple unsigned long, then the
following is easier to read and understand:

drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);

The tests above could then become:
if (drvdata->datasets & BIT(TPDM_DS_DSB)) ...


> +       }
> +       CS_LOCK(drvdata->base);
> +}
> +
>  static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>  {
>         struct device *dev = &adev->dev;
> @@ -104,6 +164,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>         if (IS_ERR(drvdata->csdev))
>                 return PTR_ERR(drvdata->csdev);
>
> +       tpdm_init_default_data(drvdata);
>         /* Decrease pm refcount when probe is done.*/
>         pm_runtime_put(&adev->dev);
>
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 94a7748a5426..8f05070879c4 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -6,6 +6,25 @@
>  #ifndef _CORESIGHT_CORESIGHT_TPDM_H
>  #define _CORESIGHT_CORESIGHT_TPDM_H
>
> +/* The max number of the datasets that TPDM supports */
> +#define TPDM_DATASETS       7
> +
> +/* DSB Subunit Registers */
> +#define TPDM_DSB_CR            (0x780)
> +

declare the enable bit here with comment documenting usage  - see above.

> +/**
> + * This enum is for PERIPHIDR0 register of TPDM.
> + * The fields [6:0] of PERIPHIDR0 are used to determine what
> + * interfaces and subunits are present on a given TPDM.
> + *
> + * PERIPHIDR0[0] : Fix to 1 if ImplDef subunit present, else 0
> + * PERIPHIDR0[1] : Fix to 1 if DSB subunit present, else 0
> + */
> +enum tpdm_dataset {
> +       TPDM_DS_IMPLDEF,
> +       TPDM_DS_DSB,
> +};
> +
>  /**
>   * struct tpdm_drvdata - specifics associated to an TPDM component
>   * @base:       memory mapped base address for this component.
> @@ -13,6 +32,7 @@
>   * @csdev:      component vitals needed by the framework.
>   * @lock:       lock for the enable value.
>   * @enable:     enable status of the component.
> + * @datasets:   The datasets types present of the TPDM.
>   */
>
>  struct tpdm_drvdata {
> @@ -21,6 +41,7 @@ struct tpdm_drvdata {
>         struct coresight_device *csdev;
>         struct mutex            lock;
>         bool                    enable;
> +       DECLARE_BITMAP(datasets, TPDM_DATASETS);

Could this simply be declared as an unsigned long? - then simplify the
code in the .c file.

Regards

Mike

>  };
>
>  #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
> --
> 2.17.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
