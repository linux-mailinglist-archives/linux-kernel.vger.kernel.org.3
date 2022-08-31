Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBBF5A7B50
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiHaKYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHaKYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:24:46 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C37313D3C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:14:56 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so22961628fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Nk8Oy5vkVnTTSzGWaE5y7yDsItAvAdd8LQXNrJXKYZE=;
        b=amshP7IOWgmv5dih6NiB6+tMgw5jXRfyCEsSSXDMXhRXZNJiAaenki7t8NdLuupVHN
         v3jkhj0IJbe5cTwxULee47U3PiiBL/4fpoX+uwDcmV11ODX4SIOt08jfjk21eLQp4jH8
         kMSxCx0vwJZv//D0WZazhWOGvZORbCp6f40l3bbxEITNqUsCbDadnJJYWjJVfX1Xnu3H
         3hG+X/+En4RjeutgzCyy8T4DROhAB+/xCXv9xWOIJf8rEkcwl9U5LYenfXALIes94keX
         SnvzO0uXesbCqHPV5TgOTthfxg0k+NCumQkKrxbr9aOxn33dqJhIVljpy7A88xh8Z8Wv
         fh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Nk8Oy5vkVnTTSzGWaE5y7yDsItAvAdd8LQXNrJXKYZE=;
        b=RN/P3mzok/YlpCM+zFyAuHCBojT4J2vb8Xto0aaj0nfLjyVOxB6MvfXS1D89bMDVSL
         /0QEhQ9tvivun2G/Cw5sJy6z4Yn4eUfTtom8SEEn40O4yegSytwcGQEmIVbJyvQdX4YW
         tryWCZzRKiTDTtiFi3/lM16NANS7uXYrtabcQN56j+8OuZvk73bB4a0YRE+xGDTRN8w2
         ab37ytu9DhY0psVwIMiaQOdFgng82LNUxw0jsUVGaSCpWns44JONLFnboQlAKgp+54yx
         NZZuiPUAuZ++yG0sl5ujN0MhPBpzHubf/c9u5a1kAOhqBPkxhRrARcKLDuWx2oBZ9jrI
         7hEg==
X-Gm-Message-State: ACgBeo0++qhqNQnYIPH2q/mxJm4xNR0Yzcub2qPEVK4jxUQE2AtvraTy
        Al9ohE/Tma3DCvHvdeMQ+dXTRSXyKZweQBVimQcRKA==
X-Google-Smtp-Source: AA6agR7jawkBeelqj7YKMLju3461JHxtE4/7FNbyMBe++ok7zHieJ3ZOxTgnZnYJ9/zG5YncVuEwL6nQtSz1MY5HHqU=
X-Received: by 2002:a05:6870:58a4:b0:11c:9b6d:f066 with SMTP id
 be36-20020a05687058a400b0011c9b6df066mr1030196oab.155.1661940895794; Wed, 31
 Aug 2022 03:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220830172614.340962-1-james.clark@arm.com> <20220830172614.340962-6-james.clark@arm.com>
In-Reply-To: <20220830172614.340962-6-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 31 Aug 2022 11:14:44 +0100
Message-ID: <CAJ9a7Vhx2g+Er9ohjznqA7k+HZBNKWiruCPyC93mn88mb2Ekqw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] coresight: Make new csdev_access offsets unsigned
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
> New csdev_access functions were added as part of the previous
> refactor. In order to make them more consistent with the
> existing ones, change any signed offset types to be unsigned.
>
> Now that they are unsigned, stop using hi_off = -1 to signify
> a single 32bit access. Instead just call the existing 32bit
> accessors. This is also applied to other parts of the codebase,
> and the coresight_{read,write}_reg_pair() functions can be
> deleted.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.h |  8 ++---
>  drivers/hwtracing/coresight/coresight-core.c | 18 ++++++++--
>  drivers/hwtracing/coresight/coresight-priv.h | 35 +++++---------------
>  drivers/hwtracing/coresight/coresight-tmc.h  |  4 +--
>  include/linux/coresight.h                    | 27 +++++++++------
>  5 files changed, 47 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
> index 6160c2d75a56..442e034bbfba 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.h
> +++ b/drivers/hwtracing/coresight/coresight-catu.h
> @@ -70,24 +70,24 @@ struct catu_drvdata {
>  static inline u32                                                      \
>  catu_read_##name(struct catu_drvdata *drvdata)                         \
>  {                                                                      \
> -       return coresight_read_reg_pair(drvdata->base, offset, -1);      \
> +       return csdev_access_relaxed_read32(&drvdata->csdev->access, offset); \
>  }                                                                      \
>  static inline void                                                     \
>  catu_write_##name(struct catu_drvdata *drvdata, u32 val)               \
>  {                                                                      \
> -       coresight_write_reg_pair(drvdata->base, val, offset, -1);       \
> +       csdev_access_relaxed_write32(&drvdata->csdev->access, val, offset); \
>  }
>
>  #define CATU_REG_PAIR(name, lo_off, hi_off)                            \
>  static inline u64                                                      \
>  catu_read_##name(struct catu_drvdata *drvdata)                         \
>  {                                                                      \
> -       return coresight_read_reg_pair(drvdata->base, lo_off, hi_off);  \
> +       return csdev_access_relaxed_read_pair(&drvdata->csdev->access, lo_off, hi_off); \
>  }                                                                      \
>  static inline void                                                     \
>  catu_write_##name(struct catu_drvdata *drvdata, u64 val)               \
>  {                                                                      \
> -       coresight_write_reg_pair(drvdata->base, val, lo_off, hi_off);   \
> +       csdev_access_relaxed_write_pair(&drvdata->csdev->access, val, lo_off, hi_off); \
>  }
>
>  CATU_REG32(control, CATU_CONTROL);
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index c63b2167a69f..d5dbc67bacb4 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -60,7 +60,7 @@ EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
>
>  static const struct cti_assoc_op *cti_assoc_ops;
>
> -ssize_t coresight_simple_show(struct device *_dev,
> +ssize_t coresight_simple_show_pair(struct device *_dev,
>                               struct device_attribute *attr, char *buf)
>  {
>         struct coresight_device *csdev = container_of(_dev, struct coresight_device, dev);
> @@ -72,7 +72,21 @@ ssize_t coresight_simple_show(struct device *_dev,
>         pm_runtime_put_sync(_dev->parent);
>         return sysfs_emit(buf, "0x%llx\n", val);
>  }
> -EXPORT_SYMBOL_GPL(coresight_simple_show);
> +EXPORT_SYMBOL_GPL(coresight_simple_show_pair);
> +
> +ssize_t coresight_simple_show32(struct device *_dev,
> +                             struct device_attribute *attr, char *buf)
> +{
> +       struct coresight_device *csdev = container_of(_dev, struct coresight_device, dev);
> +       struct cs_off_attribute *cs_attr = container_of(attr, struct cs_off_attribute, attr);
> +       u64 val;
> +
> +       pm_runtime_get_sync(_dev->parent);
> +       val = csdev_access_relaxed_read32(&csdev->access, cs_attr->off);
> +       pm_runtime_put_sync(_dev->parent);
> +       return sysfs_emit(buf, "0x%llx\n", val);
> +}
> +EXPORT_SYMBOL_GPL(coresight_simple_show32);
>
>  void coresight_set_cti_ops(const struct cti_assoc_op *cti_op)
>  {
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index c211979deca5..595ce5862056 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -41,8 +41,8 @@
>  #define ETM_MODE_EXCL_USER     BIT(31)
>  struct cs_pair_attribute {
>         struct device_attribute attr;
> -       s32 lo_off;
> -       s32 hi_off;
> +       u32 lo_off;
> +       u32 hi_off;
>  };
>
>  struct cs_off_attribute {
> @@ -50,21 +50,23 @@ struct cs_off_attribute {
>         u32 off;
>  };
>
> -extern ssize_t coresight_simple_show(struct device *_dev,
> +extern ssize_t coresight_simple_show32(struct device *_dev,
> +                                    struct device_attribute *attr, char *buf);
> +extern ssize_t coresight_simple_show_pair(struct device *_dev,
>                                      struct device_attribute *attr, char *buf);
>
>  #define coresight_simple_reg32(name, offset)                           \
> -       (&((struct cs_pair_attribute[]) {                               \
> +       (&((struct cs_off_attribute[]) {                                \
>            {                                                            \
> -               __ATTR(name, 0444, coresight_simple_show, NULL),        \
> -               offset, -1                                              \
> +               __ATTR(name, 0444, coresight_simple_show32, NULL),      \
> +               offset                                                  \
>            }                                                            \
>         })[0].attr.attr)
>
>  #define coresight_simple_reg64(name, lo_off, hi_off)                   \
>         (&((struct cs_pair_attribute[]) {                               \
>            {                                                            \
> -               __ATTR(name, 0444, coresight_simple_show, NULL),        \
> +               __ATTR(name, 0444, coresight_simple_show_pair, NULL),   \
>                 lo_off, hi_off                                          \
>            }                                                            \
>         })[0].attr.attr)
> @@ -130,25 +132,6 @@ static inline void CS_UNLOCK(void __iomem *addr)
>         } while (0);
>  }
>
> -static inline u64
> -coresight_read_reg_pair(void __iomem *addr, s32 lo_offset, s32 hi_offset)
> -{
> -       u64 val;
> -
> -       val = readl_relaxed(addr + lo_offset);
> -       val |= (hi_offset < 0) ? 0 :
> -              (u64)readl_relaxed(addr + hi_offset) << 32;
> -       return val;
> -}
> -
> -static inline void coresight_write_reg_pair(void __iomem *addr, u64 val,
> -                                                s32 lo_offset, s32 hi_offset)
> -{
> -       writel_relaxed((u32)val, addr + lo_offset);
> -       if (hi_offset >= 0)
> -               writel_relaxed((u32)(val >> 32), addr + hi_offset);
> -}
> -
>  void coresight_disable_path(struct list_head *path);
>  int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
>  struct coresight_device *coresight_get_sink(struct list_head *path);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 6bec20a392b3..66959557cf39 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -282,12 +282,12 @@ ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
>  static inline u64                                                      \
>  tmc_read_##name(struct tmc_drvdata *drvdata)                           \
>  {                                                                      \
> -       return coresight_read_reg_pair(drvdata->base, lo_off, hi_off);  \
> +       return csdev_access_relaxed_read_pair(&drvdata->csdev->access, lo_off, hi_off); \
>  }                                                                      \
>  static inline void                                                     \
>  tmc_write_##name(struct tmc_drvdata *drvdata, u64 val)                 \
>  {                                                                      \
> -       coresight_write_reg_pair(drvdata->base, val, lo_off, hi_off);   \
> +       csdev_access_relaxed_write_pair(&drvdata->csdev->access, val, lo_off, hi_off); \
>  }
>
>  TMC_REG_PAIR(rrp, TMC_RRP, TMC_RRPHI)
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index a47dd1f62216..1554021231f9 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -373,21 +373,26 @@ static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
>  }
>
>  static inline u64 csdev_access_relaxed_read_pair(struct csdev_access *csa,
> -                                                s32 lo_offset, s32 hi_offset)
> +                                                u32 lo_offset, u32 hi_offset)
>  {
> -       u64 val;
> -
>         if (likely(csa->io_mem)) {
> -               val = readl_relaxed(csa->base + lo_offset);
> -               val |= (hi_offset < 0) ? 0 :
> -                      (u64)readl_relaxed(csa->base + hi_offset) << 32;
> -               return val;
> +               return readl_relaxed(csa->base + lo_offset) |
> +                       ((u64)readl_relaxed(csa->base + hi_offset) << 32);
>         }
>
> -       val = csa->read(lo_offset, true, false);
> -       val |= (hi_offset < 0) ? 0 :
> -              (u64)csa->read(hi_offset, true, false) << 32;
> -       return val;
> +       return csa->read(lo_offset, true, false) | (csa->read(hi_offset, true, false) << 32);
> +}
> +
> +static inline void csdev_access_relaxed_write_pair(struct csdev_access *csa, u64 val,
> +                                                  u32 lo_offset, u32 hi_offset)
> +{
> +       if (likely(csa->io_mem)) {
> +               writel_relaxed((u32)val, csa->base + lo_offset);
> +               writel_relaxed((u32)(val >> 32), csa->base + hi_offset);
> +       } else {
> +               csa->write((u32)val, lo_offset, true, false);
> +               csa->write((u32)(val >> 32), hi_offset, true, false);
> +       }
>  }
>
>  static inline u32 csdev_access_read32(struct csdev_access *csa, u32 offset)
> --
> 2.28.0
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
