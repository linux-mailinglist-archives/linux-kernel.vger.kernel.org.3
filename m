Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9425D5A7A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiHaJvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaJvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:51:51 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB450A47A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:51:49 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-11dca1c9c01so22929071fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RmpUgc6XDmD5QB1XT1I/+fphZcaEbXGhXbqQ4P66lZE=;
        b=SVPqjV1MR9rD/OpYyoUjEbPKPY6cKL1i5EVoo4LHAP/MYiyB7GAxhIkNRa49axeLbT
         1wg0OeTj37m3JcXjD6P5Ec2xb/jhIMmjrJKt0kdpqEw+7Q5sig2nK9HK6hrUCIVu9bDW
         4whljtZR5Iv4OCKD2AhzfzCfnNYqjgffIEO+lBW+ywf5yxm1m+CaZPXVl6KVN0iHClQh
         VJ+5ajLg5ukTP/lIVelebEii4JJCFCEwsyTvM77QdeMsdXwjn6cej/PSniNgk9Gy/3JS
         Qk78AIct7usUEtBGp07ipGipnvorGRU3lI2ZZsT3VgknmvQJ4opWrUR1/SK5vB3jaqxU
         gbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RmpUgc6XDmD5QB1XT1I/+fphZcaEbXGhXbqQ4P66lZE=;
        b=ykyB8/PstKxm7H7/DvepmnXTD7M4sGWQSlO+ErpeDVOb14Z5iqWIZH4fN8owxRzU8U
         WMXH3Oulcw6ZZMnr1mJqpw3RNO9tCy738P5chW8hoQujKw4oCMOzcOl7d3qe+ejYN5J2
         tBVXMcfHur5sbC6dUr2hcsmMSH+MHYVUGcE3L/6Yb4SwK1XCTd96bb1KbheF2D2zzHa8
         K6JwV9f8nJzyccubx1mwPrtqq4rGggxg1OFeYwlKw6nabrTWWL/GfyKBDa+s32UVHEsl
         dMRe4vmGBy9Qa2cYaSQhoLcryfyRcHUHxO1WZMaF6oMoSVev5Hi4XC29bKjvMglrbvcM
         jRIA==
X-Gm-Message-State: ACgBeo0m5BNvnF8hzt9gcPqjYfAAN6fMe0MA3LM1gwSEZIhIhNQJT26Q
        WVYtfmN83HgMFfoAh3JI/C8O8EaCMHxTeumt9bVtkQ==
X-Google-Smtp-Source: AA6agR5OKR5YEj8I9EOVCVeHY9CkUvekFBbneDWV9LtANMPcENZR78gaPHfx0Dp4sJCkD80XnSGltjA7FpggkAGm+zo=
X-Received: by 2002:a05:6870:58a4:b0:11c:9b6d:f066 with SMTP id
 be36-20020a05687058a400b0011c9b6df066mr988863oab.155.1661939508991; Wed, 31
 Aug 2022 02:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220830172614.340962-1-james.clark@arm.com> <20220830172614.340962-5-james.clark@arm.com>
In-Reply-To: <20220830172614.340962-5-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 31 Aug 2022 10:51:38 +0100
Message-ID: <CAJ9a7Vig1HYip=0GHzhmBce3pgNZ74oDR7q4m72+Brs-URtOUA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] coresight: cti-sysfs: Re-use same functions for
 similar sysfs register accessors
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, german.gomez@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
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

On Tue, 30 Aug 2022 at 18:26, James Clark <james.clark@arm.com> wrote:
>
> Currently each accessor macro creates an identical function which wastes
> space in the text area and pollutes the ftrace function name list.
> Change it so that the same function is used, but the register to access
> is passed in as parameter rather than baked into each function.
>
> Note that only the single accessor is used here and not
> csdev_access_relaxed_read_pair() like in the previous commit, so
> so a single unsigned offset value is stored instead.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../hwtracing/coresight/coresight-cti-sysfs.c | 213 +++++++-----------
>  drivers/hwtracing/coresight/coresight-priv.h  |   5 +
>  2 files changed, 91 insertions(+), 127 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index 7ff7e7780bbf..478b8d38b744 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -163,48 +163,82 @@ static struct attribute *coresight_cti_attrs[] = {
>
>  /* register based attributes */
>
> -/* macro to access RO registers with power check only (no enable check). */
> -#define coresight_cti_reg(name, offset)                        \
> -static ssize_t name##_show(struct device *dev,                         \
> -                          struct device_attribute *attr, char *buf)    \
> -{                                                                      \
> -       struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);     \
> -       u32 val = 0;                                                    \
> -       pm_runtime_get_sync(dev->parent);                               \
> -       spin_lock(&drvdata->spinlock);                                  \
> -       if (drvdata->config.hw_powered)                                 \
> -               val = readl_relaxed(drvdata->base + offset);            \
> -       spin_unlock(&drvdata->spinlock);                                \
> -       pm_runtime_put_sync(dev->parent);                               \
> -       return sprintf(buf, "0x%x\n", val);                             \
> -}                                                                      \
> -static DEVICE_ATTR_RO(name)
> +/* Read registers with power check only (no enable check). */
> +static ssize_t coresight_cti_reg_show(struct device *dev,
> +                          struct device_attribute *attr, char *buf)
> +{
> +       struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +       struct cs_off_attribute *cti_attr = container_of(attr, struct cs_off_attribute, attr);
> +       u32 val = 0;
>
> -/* coresight management registers */
> -coresight_cti_reg(devaff0, CTIDEVAFF0);
> -coresight_cti_reg(devaff1, CTIDEVAFF1);
> -coresight_cti_reg(authstatus, CORESIGHT_AUTHSTATUS);
> -coresight_cti_reg(devarch, CORESIGHT_DEVARCH);
> -coresight_cti_reg(devid, CORESIGHT_DEVID);
> -coresight_cti_reg(devtype, CORESIGHT_DEVTYPE);
> -coresight_cti_reg(pidr0, CORESIGHT_PERIPHIDR0);
> -coresight_cti_reg(pidr1, CORESIGHT_PERIPHIDR1);
> -coresight_cti_reg(pidr2, CORESIGHT_PERIPHIDR2);
> -coresight_cti_reg(pidr3, CORESIGHT_PERIPHIDR3);
> -coresight_cti_reg(pidr4, CORESIGHT_PERIPHIDR4);
> +       pm_runtime_get_sync(dev->parent);
> +       spin_lock(&drvdata->spinlock);
> +       if (drvdata->config.hw_powered)
> +               val = readl_relaxed(drvdata->base + cti_attr->off);
> +       spin_unlock(&drvdata->spinlock);
> +       pm_runtime_put_sync(dev->parent);
> +       return sysfs_emit(buf, "0x%x\n", val);
> +}
> +
> +/* Write registers with power check only (no enable check). */
> +static ssize_t coresight_cti_reg_store(struct device *dev,
> +                                      struct device_attribute *attr,
> +                                      const char *buf, size_t size)
> +{
> +       struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +       struct cs_off_attribute *cti_attr = container_of(attr, struct cs_off_attribute, attr);
> +       unsigned long val = 0;
> +
> +       if (kstrtoul(buf, 0, &val))
> +               return -EINVAL;
>
> +       pm_runtime_get_sync(dev->parent);
> +       spin_lock(&drvdata->spinlock);
> +       if (drvdata->config.hw_powered)
> +               cti_write_single_reg(drvdata, cti_attr->off, val);
> +       spin_unlock(&drvdata->spinlock);
> +       pm_runtime_put_sync(dev->parent);
> +       return size;
> +}
> +
> +#define coresight_cti_reg(name, offset)                                        \
> +       (&((struct cs_off_attribute[]) {                                \
> +          {                                                            \
> +               __ATTR(name, 0444, coresight_cti_reg_show, NULL),       \
> +               offset                                                  \
> +          }                                                            \
> +       })[0].attr.attr)
> +
> +#define coresight_cti_reg_rw(name, offset)                             \
> +       (&((struct cs_off_attribute[]) {                                \
> +          {                                                            \
> +               __ATTR(name, 0644, coresight_cti_reg_show,              \
> +                      coresight_cti_reg_store),                        \
> +               offset                                                  \
> +          }                                                            \
> +       })[0].attr.attr)
> +
> +#define coresight_cti_reg_wo(name, offset)                             \
> +       (&((struct cs_off_attribute[]) {                                \
> +          {                                                            \
> +               __ATTR(name, 0200, NULL, coresight_cti_reg_store),      \
> +               offset                                                  \
> +          }                                                            \
> +       })[0].attr.attr)
> +
> +/* coresight management registers */
>  static struct attribute *coresight_cti_mgmt_attrs[] = {
> -       &dev_attr_devaff0.attr,
> -       &dev_attr_devaff1.attr,
> -       &dev_attr_authstatus.attr,
> -       &dev_attr_devarch.attr,
> -       &dev_attr_devid.attr,
> -       &dev_attr_devtype.attr,
> -       &dev_attr_pidr0.attr,
> -       &dev_attr_pidr1.attr,
> -       &dev_attr_pidr2.attr,
> -       &dev_attr_pidr3.attr,
> -       &dev_attr_pidr4.attr,
> +       coresight_cti_reg(devaff0, CTIDEVAFF0),
> +       coresight_cti_reg(devaff1, CTIDEVAFF1),
> +       coresight_cti_reg(authstatus, CORESIGHT_AUTHSTATUS),
> +       coresight_cti_reg(devarch, CORESIGHT_DEVARCH),
> +       coresight_cti_reg(devid, CORESIGHT_DEVID),
> +       coresight_cti_reg(devtype, CORESIGHT_DEVTYPE),
> +       coresight_cti_reg(pidr0, CORESIGHT_PERIPHIDR0),
> +       coresight_cti_reg(pidr1, CORESIGHT_PERIPHIDR1),
> +       coresight_cti_reg(pidr2, CORESIGHT_PERIPHIDR2),
> +       coresight_cti_reg(pidr3, CORESIGHT_PERIPHIDR3),
> +       coresight_cti_reg(pidr4, CORESIGHT_PERIPHIDR4),
>         NULL,
>  };
>
> @@ -454,86 +488,11 @@ static ssize_t apppulse_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(apppulse);
>
> -coresight_cti_reg(triginstatus, CTITRIGINSTATUS);
> -coresight_cti_reg(trigoutstatus, CTITRIGOUTSTATUS);
> -coresight_cti_reg(chinstatus, CTICHINSTATUS);
> -coresight_cti_reg(choutstatus, CTICHOUTSTATUS);
> -
>  /*
>   * Define CONFIG_CORESIGHT_CTI_INTEGRATION_REGS to enable the access to the
>   * integration control registers. Normally only used to investigate connection
>   * data.
>   */
> -#ifdef CONFIG_CORESIGHT_CTI_INTEGRATION_REGS
> -
> -/* macro to access RW registers with power check only (no enable check). */
> -#define coresight_cti_reg_rw(name, offset)                             \
> -static ssize_t name##_show(struct device *dev,                         \
> -                          struct device_attribute *attr, char *buf)    \
> -{                                                                      \
> -       struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);     \
> -       u32 val = 0;                                                    \
> -       pm_runtime_get_sync(dev->parent);                               \
> -       spin_lock(&drvdata->spinlock);                                  \
> -       if (drvdata->config.hw_powered)                                 \
> -               val = readl_relaxed(drvdata->base + offset);            \
> -       spin_unlock(&drvdata->spinlock);                                \
> -       pm_runtime_put_sync(dev->parent);                               \
> -       return sprintf(buf, "0x%x\n", val);                             \
> -}                                                                      \
> -                                                                       \
> -static ssize_t name##_store(struct device *dev,                                \
> -                           struct device_attribute *attr,              \
> -                           const char *buf, size_t size)               \
> -{                                                                      \
> -       struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);     \
> -       unsigned long val = 0;                                          \
> -       if (kstrtoul(buf, 0, &val))                                     \
> -               return -EINVAL;                                         \
> -                                                                       \
> -       pm_runtime_get_sync(dev->parent);                               \
> -       spin_lock(&drvdata->spinlock);                                  \
> -       if (drvdata->config.hw_powered)                                 \
> -               cti_write_single_reg(drvdata, offset, val);             \
> -       spin_unlock(&drvdata->spinlock);                                \
> -       pm_runtime_put_sync(dev->parent);                               \
> -       return size;                                                    \
> -}                                                                      \
> -static DEVICE_ATTR_RW(name)
> -
> -/* macro to access WO registers with power check only (no enable check). */
> -#define coresight_cti_reg_wo(name, offset)                             \
> -static ssize_t name##_store(struct device *dev,                                \
> -                           struct device_attribute *attr,              \
> -                           const char *buf, size_t size)               \
> -{                                                                      \
> -       struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);     \
> -       unsigned long val = 0;                                          \
> -       if (kstrtoul(buf, 0, &val))                                     \
> -               return -EINVAL;                                         \
> -                                                                       \
> -       pm_runtime_get_sync(dev->parent);                               \
> -       spin_lock(&drvdata->spinlock);                                  \
> -       if (drvdata->config.hw_powered)                                 \
> -               cti_write_single_reg(drvdata, offset, val);             \
> -       spin_unlock(&drvdata->spinlock);                                \
> -       pm_runtime_put_sync(dev->parent);                               \
> -       return size;                                                    \
> -}                                                                      \
> -static DEVICE_ATTR_WO(name)
> -
> -coresight_cti_reg_rw(itchout, ITCHOUT);
> -coresight_cti_reg_rw(ittrigout, ITTRIGOUT);
> -coresight_cti_reg_rw(itctrl, CORESIGHT_ITCTRL);
> -coresight_cti_reg_wo(itchinack, ITCHINACK);
> -coresight_cti_reg_wo(ittriginack, ITTRIGINACK);
> -coresight_cti_reg(ittrigin, ITTRIGIN);
> -coresight_cti_reg(itchin, ITCHIN);
> -coresight_cti_reg(itchoutack, ITCHOUTACK);
> -coresight_cti_reg(ittrigoutack, ITTRIGOUTACK);
> -
> -#endif /* CORESIGHT_CTI_INTEGRATION_REGS */
> -
>  static struct attribute *coresight_cti_regs_attrs[] = {
>         &dev_attr_inout_sel.attr,
>         &dev_attr_inen.attr,
> @@ -544,20 +503,20 @@ static struct attribute *coresight_cti_regs_attrs[] = {
>         &dev_attr_appset.attr,
>         &dev_attr_appclear.attr,
>         &dev_attr_apppulse.attr,
> -       &dev_attr_triginstatus.attr,
> -       &dev_attr_trigoutstatus.attr,
> -       &dev_attr_chinstatus.attr,
> -       &dev_attr_choutstatus.attr,
> +       coresight_cti_reg(triginstatus, CTITRIGINSTATUS),
> +       coresight_cti_reg(trigoutstatus, CTITRIGOUTSTATUS),
> +       coresight_cti_reg(chinstatus, CTICHINSTATUS),
> +       coresight_cti_reg(choutstatus, CTICHOUTSTATUS),
>  #ifdef CONFIG_CORESIGHT_CTI_INTEGRATION_REGS
> -       &dev_attr_itctrl.attr,
> -       &dev_attr_ittrigin.attr,
> -       &dev_attr_itchin.attr,
> -       &dev_attr_ittrigout.attr,
> -       &dev_attr_itchout.attr,
> -       &dev_attr_itchoutack.attr,
> -       &dev_attr_ittrigoutack.attr,
> -       &dev_attr_ittriginack.attr,
> -       &dev_attr_itchinack.attr,
> +       coresight_cti_reg_rw(itctrl, CORESIGHT_ITCTRL),
> +       coresight_cti_reg(ittrigin, ITTRIGIN),
> +       coresight_cti_reg(itchin, ITCHIN),
> +       coresight_cti_reg_rw(ittrigout, ITTRIGOUT),
> +       coresight_cti_reg_rw(itchout, ITCHOUT),
> +       coresight_cti_reg(itchoutack, ITCHOUTACK),
> +       coresight_cti_reg(ittrigoutack, ITTRIGOUTACK),
> +       coresight_cti_reg_wo(ittriginack, ITTRIGINACK),
> +       coresight_cti_reg_wo(itchinack, ITCHINACK),
>  #endif
>         NULL,
>  };
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 07b392bfdbcd..c211979deca5 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -45,6 +45,11 @@ struct cs_pair_attribute {
>         s32 hi_off;
>  };
>
> +struct cs_off_attribute {
> +       struct device_attribute attr;
> +       u32 off;
> +};
> +
>  extern ssize_t coresight_simple_show(struct device *_dev,
>                                      struct device_attribute *attr, char *buf);
>
> --
> 2.28.0
>
Reviewed-by: Mike Leach <mike.leach@linaro.org>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
