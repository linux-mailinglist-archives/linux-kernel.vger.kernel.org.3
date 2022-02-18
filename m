Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA894BBD16
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiBRQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:10:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbiBRQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:10:57 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B852B2E38
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:10:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso8954486wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/AWVD/1v/OrltbsGLUWIiBolmGY0D5NB3cjsCAaCvo=;
        b=F196Gj6X7cMmzv1LmcLHEWq1bNaYOHIez4eL8fW9SaLZd4vLt1LlT989pRSsRtpqYu
         zvABT7jyXZy5k8s7GLJ5rYlNkIfrShBaRCjziTLt+oyNiHrnXb/dH92AbwOqgTHzXakf
         j8egLAR8jk/59JbSo0boemLftJ9a8wlSQWLZ981MLbZN+BeMym4pAjufS/wCUwquUWi+
         TN8conih/ENjS7WS8MU82mrrPZbCofNUyVaS7XdQlcwTfiRBYDraR8Tru0qBrHPLGs1S
         VyielxAnD2JJtvNxx/qX0nssoXYJ8/w66vrMeMDOu8xSzPsAD1eAb7TK7QbfvWg9xO1g
         lcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/AWVD/1v/OrltbsGLUWIiBolmGY0D5NB3cjsCAaCvo=;
        b=tXlILcQ7HgGq6yW/2iiSVhBZ2aPTKgCf5pqR9g/Yao6LWN5ILw6MUxrkUAC8v+Si5R
         wU6wlibz8N14Yh7dpy469DaDnP1zch5nLIotuolWbCtruVHhNfJnMvsz/kqX7998d0VP
         yrzkniQFoM3zQ2e8kjKsueOCDg/gRlu1p0+JtIihey4GE1gLjCDirjK+KeDIwp3rAaul
         bO6ydjRhqP0gq5tHf4c1DHAbNEnKTDoT0kOElb8DyjuQng+9SUJM6ub6ZMuuHrmpqcBD
         P8/1l8yrR1sj/fProAt+vtdyB6EmgxbcwkTJP0rBo3qxJvVPf6/Dl62Wkpu5gjqk0mPR
         4nEA==
X-Gm-Message-State: AOAM533vytbLYI8qjBIEm8vyCNM599BE4IBvYem01LzBLTKvNgONGhbY
        GfbAa7+WCIm7FT+mXCmyvRziY0drb3f1ThtGTbicqw==
X-Google-Smtp-Source: ABdhPJyaTo8GQS0NlVyqhKtGAlZCehfwbplk5FAbe/7QQ9yc04MN011Y6Cp2S6D7f2WTZbq3wFru9ATE8GWB9Yt9D0E=
X-Received: by 2002:a1c:a510:0:b0:37e:2645:2222 with SMTP id
 o16-20020a1ca510000000b0037e26452222mr11164689wme.26.1645200637167; Fri, 18
 Feb 2022 08:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20220209105706.18852-1-quic_jinlmao@quicinc.com> <20220209105706.18852-6-quic_jinlmao@quicinc.com>
In-Reply-To: <20220209105706.18852-6-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 18 Feb 2022 16:10:26 +0000
Message-ID: <CAJ9a7Vi5L8c7FoxHHNk1NVuPr_Sp4rMHZO11JwX5CaTFSTTBXg@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] coresight-tpdm: Add DSB dataset support
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

This patch does not apply cleanly:-

=======================================
git apply -v ../patch.in/qcom/qcom-05.patch
Checking patch drivers/hwtracing/coresight/coresight-tpdm.c...
error: while searching for:

DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");

/** TPDM enable operations **/
static int tpdm_enable(struct coresight_device *csdev,
               struct perf_event *event, u32 mode)
{

error: patch failed: drivers/hwtracing/coresight/coresight-tpdm.c:20
error: drivers/hwtracing/coresight/coresight-tpdm.c: patch does not apply
Checking patch drivers/hwtracing/coresight/coresight-tpdm.h...

=======================================

In patch 3 - the first time coresight-tpdm.c. is added the comment line is

/* TPDM enable operations */

Note the single * in the comment.

This would seem to indicate missing intermediate patches, or patches
from different trees / times.

A coherent patch set is needed for review

Regards

Mike



On Wed, 9 Feb 2022 at 10:57, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
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
>  drivers/hwtracing/coresight/coresight-tpdm.c | 57 ++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tpdm.h | 21 ++++++++
>  2 files changed, 78 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 51b8b17e6a80..c6480b7389b0 100644
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
> +       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
> +}
> +
>  /** TPDM enable operations **/
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
> +       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
> +}
> +
>  /** TPDM disable operations **/
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
> @@ -76,7 +121,19 @@ static const struct coresight_ops tpdm_cs_ops = {
>
>  static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>  {
> +       int i;
> +       u32 pidr;
> +
>         drvdata->traceid = coresight_get_system_trace_id();
> +
> +       CS_UNLOCK(drvdata->base);
> +       /*  Get the datasets present on the TPDM. */
> +       pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
> +       for (i = 0; i < TPDM_DATASETS; i++) {
> +               if (pidr & BIT(i))
> +                       __set_bit(i, drvdata->datasets);
> +       }
> +       CS_LOCK(drvdata->base);
>  }
>
>  static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 2effbabf349b..cb3ddc6c89ae 100644
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
>   * @traceid:    value of the current ID for this component.
>   */
>
> @@ -22,6 +42,7 @@ struct tpdm_drvdata {
>         struct coresight_device *csdev;
>         struct mutex            lock;
>         bool                    enable;
> +       DECLARE_BITMAP(datasets, TPDM_DATASETS);
>         int                     traceid;
>  };
>
> --
> 2.17.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
