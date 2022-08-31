Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832475A7A11
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiHaJWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiHaJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:22:21 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC00FCD4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:22:20 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-11edd61a9edso16711718fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nZMfUfFd3uBlhXii5kFveg6WW7SA+qHitCgLBAqLjwc=;
        b=vXHnZbzGWEW1m7TEwOTwlU/djwaa8PbV2OT0q794yuzvPmDlll28KkhFOT79OXwHFd
         QrIGv78wX/VUnVjZaUax635N2G6K3zUFObtjQmiaT0mt3zNLn4LFcsEDC1TJR11/aH29
         WT/pXkg/LfbFlltiLsJuRp8x/pyzI8fmBcPgufqBpWIJi/XY2IL/7dlBBPjL1pkDrA2E
         5MiwH3JO+LSmWDBtlluRPFGqXPBpZrx5ztW90B1m8X81XC+aExNoBH5uj/NENsn6e3ey
         GGsJgNYF8QQ/mwHCSTTOBTPaWzqq7mzFWYd40ps0ddGHYs80JpJGN6Mvz+xBVRiN70eA
         7wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nZMfUfFd3uBlhXii5kFveg6WW7SA+qHitCgLBAqLjwc=;
        b=Q82gnxxpix5OG1ZBZcieWNXiHIHu3azGiHtEAKdiJ/6gUGEmmseB8KjErdZTD1dJl3
         ibL5A3cbiwojUN0R1T5bVTtFRsbrCCfyEor3+gzmkDCgrUf35ppgKEFRDhoIheOQmnaG
         pGXxb6MHs+XOWKezYk0Fi6UMDtOkLFFPAg4JBIkjpAnaCnQDV+qECTeAdvGcvHkllUBh
         B6i2U4RVxSlsyqNFJaL8wso8CrnN27DSHL+RwfqNFRcks/j36gL5YrJmDC14ln1mo5bN
         QuWar5lokFT5ymTw7WnEL8KwVMlaihn2KXXKGCqCSz1RvGEZixUj3uXRxJJFQj/wmtmq
         mQuw==
X-Gm-Message-State: ACgBeo2arR6eCqGqpP0eaWjqqyvxufd4WUQhCdVrkZYSor7Bqp+xrdzl
        NS6PyWR5wTiP12pUpsdB+kycLjo4BU9mlD5YiZOASQ==
X-Google-Smtp-Source: AA6agR48aLj6SNmwM8yedsnFmFGMMwf+yjbBupP9RW0i6ITBLoiDnA6z98nETpqYugNWM2kZ/jfSzNZWmTWQ1uP0rac=
X-Received: by 2002:a05:6870:58a4:b0:11c:9b6d:f066 with SMTP id
 be36-20020a05687058a400b0011c9b6df066mr946934oab.155.1661937740096; Wed, 31
 Aug 2022 02:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220830172614.340962-1-james.clark@arm.com> <20220830172614.340962-3-james.clark@arm.com>
In-Reply-To: <20220830172614.340962-3-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 31 Aug 2022 10:22:09 +0100
Message-ID: <CAJ9a7ViJoMezcR_VKhCKUn6v64VHEdehRVLGQ-g0x8CRSkNBng@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] coresight: Simplify sysfs accessors by using
 csdev_access abstraction
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
> The coresight_device struct is available in the sysfs accessor, and this
> contains a csdev_access struct which can be used to access registers.
> Use this instead of passing in the type of each drvdata so that a common
> function can be shared between all the cs drivers.
>
> No functional changes.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c  | 18 +++++-----
>  drivers/hwtracing/coresight/coresight-etb10.c | 19 +++++------
>  .../coresight/coresight-etm3x-sysfs.c         | 23 ++++++-------
>  drivers/hwtracing/coresight/coresight-priv.h  | 14 ++++----
>  .../coresight/coresight-replicator.c          |  7 ++--
>  drivers/hwtracing/coresight/coresight-stm.c   | 27 +++++++--------
>  .../hwtracing/coresight/coresight-tmc-core.c  | 33 ++++++++-----------
>  include/linux/coresight.h                     | 18 ++++++++++
>  8 files changed, 79 insertions(+), 80 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index e0740c6dbd54..9d89c4054046 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -365,16 +365,14 @@ static const struct etr_buf_operations etr_catu_buf_ops = {
>         .get_data = catu_get_data_etr_buf,
>  };
>
> -coresight_simple_reg32(struct catu_drvdata, devid, CORESIGHT_DEVID);
> -coresight_simple_reg32(struct catu_drvdata, control, CATU_CONTROL);
> -coresight_simple_reg32(struct catu_drvdata, status, CATU_STATUS);
> -coresight_simple_reg32(struct catu_drvdata, mode, CATU_MODE);
> -coresight_simple_reg32(struct catu_drvdata, axictrl, CATU_AXICTRL);
> -coresight_simple_reg32(struct catu_drvdata, irqen, CATU_IRQEN);
> -coresight_simple_reg64(struct catu_drvdata, sladdr,
> -                      CATU_SLADDRLO, CATU_SLADDRHI);
> -coresight_simple_reg64(struct catu_drvdata, inaddr,
> -                      CATU_INADDRLO, CATU_INADDRHI);
> +coresight_simple_reg32(devid, CORESIGHT_DEVID);
> +coresight_simple_reg32(control, CATU_CONTROL);
> +coresight_simple_reg32(status, CATU_STATUS);
> +coresight_simple_reg32(mode, CATU_MODE);
> +coresight_simple_reg32(axictrl, CATU_AXICTRL);
> +coresight_simple_reg32(irqen, CATU_IRQEN);
> +coresight_simple_reg64(sladdr, CATU_SLADDRLO, CATU_SLADDRHI);
> +coresight_simple_reg64(inaddr, CATU_INADDRLO, CATU_INADDRHI);
>
>  static struct attribute *catu_mgmt_attrs[] = {
>         &dev_attr_devid.attr,
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index efa39820acec..405bb3355cb1 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -655,17 +655,14 @@ static const struct file_operations etb_fops = {
>         .llseek         = no_llseek,
>  };
>
> -#define coresight_etb10_reg(name, offset)              \
> -       coresight_simple_reg32(struct etb_drvdata, name, offset)
> -
> -coresight_etb10_reg(rdp, ETB_RAM_DEPTH_REG);
> -coresight_etb10_reg(sts, ETB_STATUS_REG);
> -coresight_etb10_reg(rrp, ETB_RAM_READ_POINTER);
> -coresight_etb10_reg(rwp, ETB_RAM_WRITE_POINTER);
> -coresight_etb10_reg(trg, ETB_TRG);
> -coresight_etb10_reg(ctl, ETB_CTL_REG);
> -coresight_etb10_reg(ffsr, ETB_FFSR);
> -coresight_etb10_reg(ffcr, ETB_FFCR);
> +coresight_simple_reg32(rdp, ETB_RAM_DEPTH_REG);
> +coresight_simple_reg32(sts, ETB_STATUS_REG);
> +coresight_simple_reg32(rrp, ETB_RAM_READ_POINTER);
> +coresight_simple_reg32(rwp, ETB_RAM_WRITE_POINTER);
> +coresight_simple_reg32(trg, ETB_TRG);
> +coresight_simple_reg32(ctl, ETB_CTL_REG);
> +coresight_simple_reg32(ffsr, ETB_FFSR);
> +coresight_simple_reg32(ffcr, ETB_FFCR);
>
>  static struct attribute *coresight_etb_mgmt_attrs[] = {
>         &dev_attr_rdp.attr,
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index 68fcbf4ce7a8..12f8e8176c7e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -1252,19 +1252,16 @@ static struct attribute *coresight_etm_attrs[] = {
>         NULL,
>  };
>
> -#define coresight_etm3x_reg(name, offset)                      \
> -       coresight_simple_reg32(struct etm_drvdata, name, offset)
> -
> -coresight_etm3x_reg(etmccr, ETMCCR);
> -coresight_etm3x_reg(etmccer, ETMCCER);
> -coresight_etm3x_reg(etmscr, ETMSCR);
> -coresight_etm3x_reg(etmidr, ETMIDR);
> -coresight_etm3x_reg(etmcr, ETMCR);
> -coresight_etm3x_reg(etmtraceidr, ETMTRACEIDR);
> -coresight_etm3x_reg(etmteevr, ETMTEEVR);
> -coresight_etm3x_reg(etmtssvr, ETMTSSCR);
> -coresight_etm3x_reg(etmtecr1, ETMTECR1);
> -coresight_etm3x_reg(etmtecr2, ETMTECR2);
> +coresight_simple_reg32(etmccr, ETMCCR);
> +coresight_simple_reg32(etmccer, ETMCCER);
> +coresight_simple_reg32(etmscr, ETMSCR);
> +coresight_simple_reg32(etmidr, ETMIDR);
> +coresight_simple_reg32(etmcr, ETMCR);
> +coresight_simple_reg32(etmtraceidr, ETMTRACEIDR);
> +coresight_simple_reg32(etmteevr, ETMTEEVR);
> +coresight_simple_reg32(etmtssvr, ETMTSSCR);
> +coresight_simple_reg32(etmtecr1, ETMTECR1);
> +coresight_simple_reg32(etmtecr2, ETMTECR2);
>
>  static struct attribute *coresight_etm_mgmt_attrs[] = {
>         &dev_attr_etmccr.attr,
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index f2458b794ef3..cf8ae768106e 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -40,23 +40,23 @@
>  #define ETM_MODE_EXCL_KERN     BIT(30)
>  #define ETM_MODE_EXCL_USER     BIT(31)
>
> -#define __coresight_simple_show(type, name, lo_off, hi_off)            \
> +#define __coresight_simple_show(name, lo_off, hi_off)          \
>  static ssize_t name##_show(struct device *_dev,                                \
>                            struct device_attribute *attr, char *buf)    \
>  {                                                                      \
> -       type *drvdata = dev_get_drvdata(_dev->parent);                  \
> +       struct coresight_device *csdev = container_of(_dev, struct coresight_device, dev); \
>         u64 val;                                                        \
>         pm_runtime_get_sync(_dev->parent);                              \
> -       val = coresight_read_reg_pair(drvdata->base, lo_off, hi_off);   \
> +       val = csdev_access_relaxed_read_pair(&csdev->access, lo_off, hi_off);   \
>         pm_runtime_put_sync(_dev->parent);                              \
>         return scnprintf(buf, PAGE_SIZE, "0x%llx\n", val);              \
>  }                                                                      \
>  static DEVICE_ATTR_RO(name)
>
> -#define coresight_simple_reg32(type, name, offset)                     \
> -       __coresight_simple_show(type, name, offset, -1)
> -#define coresight_simple_reg64(type, name, lo_off, hi_off)             \
> -       __coresight_simple_show(type, name, lo_off, hi_off)
> +#define coresight_simple_reg32(name, offset)                   \
> +       __coresight_simple_show(name, offset, -1)
> +#define coresight_simple_reg64(name, lo_off, hi_off)           \
> +       __coresight_simple_show(name, lo_off, hi_off)
>
>  extern const u32 coresight_barrier_pkt[4];
>  #define CORESIGHT_BARRIER_PKT_SIZE (sizeof(coresight_barrier_pkt))
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index b86acbc74cf0..7cffcbb2ec42 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -196,11 +196,8 @@ static const struct coresight_ops replicator_cs_ops = {
>         .link_ops       = &replicator_link_ops,
>  };
>
> -#define coresight_replicator_reg(name, offset) \
> -       coresight_simple_reg32(struct replicator_drvdata, name, offset)
> -
> -coresight_replicator_reg(idfilter0, REPLICATOR_IDFILTER0);
> -coresight_replicator_reg(idfilter1, REPLICATOR_IDFILTER1);
> +coresight_simple_reg32(idfilter0, REPLICATOR_IDFILTER0);
> +coresight_simple_reg32(idfilter1, REPLICATOR_IDFILTER1);
>
>  static struct attribute *replicator_mgmt_attrs[] = {
>         &dev_attr_idfilter0.attr,
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index bb14a3a8a921..4a31905604fe 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -634,21 +634,18 @@ static ssize_t traceid_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(traceid);
>
> -#define coresight_stm_reg(name, offset)        \
> -       coresight_simple_reg32(struct stm_drvdata, name, offset)
> -
> -coresight_stm_reg(tcsr, STMTCSR);
> -coresight_stm_reg(tsfreqr, STMTSFREQR);
> -coresight_stm_reg(syncr, STMSYNCR);
> -coresight_stm_reg(sper, STMSPER);
> -coresight_stm_reg(spter, STMSPTER);
> -coresight_stm_reg(privmaskr, STMPRIVMASKR);
> -coresight_stm_reg(spscr, STMSPSCR);
> -coresight_stm_reg(spmscr, STMSPMSCR);
> -coresight_stm_reg(spfeat1r, STMSPFEAT1R);
> -coresight_stm_reg(spfeat2r, STMSPFEAT2R);
> -coresight_stm_reg(spfeat3r, STMSPFEAT3R);
> -coresight_stm_reg(devid, CORESIGHT_DEVID);
> +coresight_simple_reg32(tcsr, STMTCSR);
> +coresight_simple_reg32(tsfreqr, STMTSFREQR);
> +coresight_simple_reg32(syncr, STMSYNCR);
> +coresight_simple_reg32(sper, STMSPER);
> +coresight_simple_reg32(spter, STMSPTER);
> +coresight_simple_reg32(privmaskr, STMPRIVMASKR);
> +coresight_simple_reg32(spscr, STMSPSCR);
> +coresight_simple_reg32(spmscr, STMSPMSCR);
> +coresight_simple_reg32(spfeat1r, STMSPFEAT1R);
> +coresight_simple_reg32(spfeat2r, STMSPFEAT2R);
> +coresight_simple_reg32(spfeat3r, STMSPFEAT3R);
> +coresight_simple_reg32(devid, CORESIGHT_DEVID);
>
>  static struct attribute *coresight_stm_attrs[] = {
>         &dev_attr_hwevent_enable.attr,
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index d0276af82494..781d213526b7 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -251,25 +251,20 @@ static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
>         return memwidth;
>  }
>
> -#define coresight_tmc_reg(name, offset)                        \
> -       coresight_simple_reg32(struct tmc_drvdata, name, offset)
> -#define coresight_tmc_reg64(name, lo_off, hi_off)      \
> -       coresight_simple_reg64(struct tmc_drvdata, name, lo_off, hi_off)
> -
> -coresight_tmc_reg(rsz, TMC_RSZ);
> -coresight_tmc_reg(sts, TMC_STS);
> -coresight_tmc_reg(trg, TMC_TRG);
> -coresight_tmc_reg(ctl, TMC_CTL);
> -coresight_tmc_reg(ffsr, TMC_FFSR);
> -coresight_tmc_reg(ffcr, TMC_FFCR);
> -coresight_tmc_reg(mode, TMC_MODE);
> -coresight_tmc_reg(pscr, TMC_PSCR);
> -coresight_tmc_reg(axictl, TMC_AXICTL);
> -coresight_tmc_reg(authstatus, TMC_AUTHSTATUS);
> -coresight_tmc_reg(devid, CORESIGHT_DEVID);
> -coresight_tmc_reg64(rrp, TMC_RRP, TMC_RRPHI);
> -coresight_tmc_reg64(rwp, TMC_RWP, TMC_RWPHI);
> -coresight_tmc_reg64(dba, TMC_DBALO, TMC_DBAHI);
> +coresight_simple_reg32(rsz, TMC_RSZ);
> +coresight_simple_reg32(sts, TMC_STS);
> +coresight_simple_reg32(trg, TMC_TRG);
> +coresight_simple_reg32(ctl, TMC_CTL);
> +coresight_simple_reg32(ffsr, TMC_FFSR);
> +coresight_simple_reg32(ffcr, TMC_FFCR);
> +coresight_simple_reg32(mode, TMC_MODE);
> +coresight_simple_reg32(pscr, TMC_PSCR);
> +coresight_simple_reg32(axictl, TMC_AXICTL);
> +coresight_simple_reg32(authstatus, TMC_AUTHSTATUS);
> +coresight_simple_reg32(devid, CORESIGHT_DEVID);
> +coresight_simple_reg64(rrp, TMC_RRP, TMC_RRPHI);
> +coresight_simple_reg64(rwp, TMC_RWP, TMC_RWPHI);
> +coresight_simple_reg64(dba, TMC_DBALO, TMC_DBAHI);
>
>  static struct attribute *coresight_tmc_mgmt_attrs[] = {
>         &dev_attr_rsz.attr,
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 9f445f09fcfe..a47dd1f62216 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -372,6 +372,24 @@ static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
>         return csa->read(offset, true, false);
>  }
>
> +static inline u64 csdev_access_relaxed_read_pair(struct csdev_access *csa,
> +                                                s32 lo_offset, s32 hi_offset)
> +{
> +       u64 val;
> +
> +       if (likely(csa->io_mem)) {
> +               val = readl_relaxed(csa->base + lo_offset);
> +               val |= (hi_offset < 0) ? 0 :
> +                      (u64)readl_relaxed(csa->base + hi_offset) << 32;
> +               return val;
> +       }
> +
> +       val = csa->read(lo_offset, true, false);
> +       val |= (hi_offset < 0) ? 0 :
> +              (u64)csa->read(hi_offset, true, false) << 32;
> +       return val;
> +}
> +
>  static inline u32 csdev_access_read32(struct csdev_access *csa, u32 offset)
>  {
>         if (likely(csa->io_mem))
> --
> 2.28.0
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
