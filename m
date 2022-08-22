Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C58259C547
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiHVRpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbiHVRnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:43:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEF81CB38
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:43:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m15so3644921pjj.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=f3n9zw83ec+Iaxuow/m9Y94VHHvJBz+8h9M5RHlcf9c=;
        b=PGxWME4hHumZfnoJLWIyZfCDFx6G4W+h19ZXcIelhmvvfGLSHB/jFK/xLTlrgMxnYd
         Bu9DmRRyDxFndNLtGGwcxhTv90zg4rBV5B5tlYVjRqCiQEF4XUUMa0n3HxbEk3X1wWve
         5HiNfxZUQ/4l3QxQYP1mZ1EGwwjxAVNvM7QzlS+DDuVB8uUuX8SBgrnw0rs/fNsqZTVz
         JiACxMMANN00WeP4vdLO2Un9krvEXmvgBlAarY/AXfhrnAqUOKaI/hIh0S2HyCWNEWUc
         v4y3gO12OyYpWXs2/Ub4FLMcvJvEB+DPtRJgD/g3FNsw9ieVpHWhiH4/LBeWNTRtSOp4
         InJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=f3n9zw83ec+Iaxuow/m9Y94VHHvJBz+8h9M5RHlcf9c=;
        b=bjFZXr8kxoa13kkdxaXmODfKhzhkJoV+X38a1MtGlqiDw5kFuAnuYF2ozC0bO4Qnvv
         OfXDvIVDiS1RieEDpMy+5m91euzR38k6C19ZZPu23kgEkTVGFEj4L3vK0emEaojYySFt
         OdtvBnLhp6YY+xz/UNWIHROg59vsJSyYXezDyQkCix3hlrO4YvSoRsGvTUtDEI5TTRKB
         CHLqbBWhOzjPEIGPrH9AJ2PxbhlUbiKAR6D4d0mULedb+JKG7vpQKIq0SFEGmgZ5RBKh
         zTHilwyu9KW7kOwDOq/1hu3V+8nHtk9HwEZfwDsOIKREO1fo/jdCtrSAY6afy+orDml+
         evYQ==
X-Gm-Message-State: ACgBeo2emIlcxg4X0jwNI9ZgGoP7+4hXr9bW55DyVwBEA9HTExz/RWdY
        bPsGGy5Gay9vkjDGClrElHGM3g==
X-Google-Smtp-Source: AA6agR504aqRET5QyBY+jSoS1EiwOQ6z1CuGkV3LfLqYc9+x/lXk3gMbWxY+SY9gwIdSXpjZBlx08w==
X-Received: by 2002:a17:902:f606:b0:172:6522:4bfc with SMTP id n6-20020a170902f60600b0017265224bfcmr20862197plg.133.1661190207200;
        Mon, 22 Aug 2022 10:43:27 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id u23-20020a63f657000000b0042a93b625d4sm3372848pgj.27.2022.08.22.10.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:43:26 -0700 (PDT)
Date:   Mon, 22 Aug 2022 11:43:23 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] coresight: Re-use same function for similar sysfs
 register accessors
Message-ID: <20220822174323.GD1583519@p14s>
References: <20220725145221.517776-1-james.clark@arm.com>
 <20220725145221.517776-4-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725145221.517776-4-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 03:52:20PM +0100, James Clark wrote:
> Currently each accessor macro creates an identical function which wastes
> space in the text area and pollutes the ftrace function names. Change it
> so that the same function is used, but the register to access is passed
> in as parameter rather than baked into each function.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c  | 25 ++++-------
>  drivers/hwtracing/coresight/coresight-core.c  | 14 ++++++
>  drivers/hwtracing/coresight/coresight-etb10.c | 25 ++++-------
>  .../coresight/coresight-etm3x-sysfs.c         | 31 +++++--------
>  drivers/hwtracing/coresight/coresight-priv.h  | 40 +++++++++--------
>  .../coresight/coresight-replicator.c          |  7 +--
>  drivers/hwtracing/coresight/coresight-stm.c   | 37 ++++++----------
>  .../hwtracing/coresight/coresight-tmc-core.c  | 43 ++++++-------------
>  8 files changed, 92 insertions(+), 130 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 9d89c4054046..bc90a03f478f 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -365,24 +365,15 @@ static const struct etr_buf_operations etr_catu_buf_ops = {
>  	.get_data = catu_get_data_etr_buf,
>  };
>  
> -coresight_simple_reg32(devid, CORESIGHT_DEVID);
> -coresight_simple_reg32(control, CATU_CONTROL);
> -coresight_simple_reg32(status, CATU_STATUS);
> -coresight_simple_reg32(mode, CATU_MODE);
> -coresight_simple_reg32(axictrl, CATU_AXICTRL);
> -coresight_simple_reg32(irqen, CATU_IRQEN);
> -coresight_simple_reg64(sladdr, CATU_SLADDRLO, CATU_SLADDRHI);
> -coresight_simple_reg64(inaddr, CATU_INADDRLO, CATU_INADDRHI);
> -
>  static struct attribute *catu_mgmt_attrs[] = {
> -	&dev_attr_devid.attr,
> -	&dev_attr_control.attr,
> -	&dev_attr_status.attr,
> -	&dev_attr_mode.attr,
> -	&dev_attr_axictrl.attr,
> -	&dev_attr_irqen.attr,
> -	&dev_attr_sladdr.attr,
> -	&dev_attr_inaddr.attr,
> +	coresight_simple_reg32(devid, CORESIGHT_DEVID),
> +	coresight_simple_reg32(control, CATU_CONTROL),
> +	coresight_simple_reg32(status, CATU_STATUS),
> +	coresight_simple_reg32(mode, CATU_MODE),
> +	coresight_simple_reg32(axictrl, CATU_AXICTRL),
> +	coresight_simple_reg32(irqen, CATU_IRQEN),
> +	coresight_simple_reg64(sladdr, CATU_SLADDRLO, CATU_SLADDRHI),
> +	coresight_simple_reg64(inaddr, CATU_INADDRLO, CATU_INADDRHI),
>  	NULL,
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 1edfec1e9d18..b46b5184411e 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -60,6 +60,20 @@ EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
>  
>  static const struct cti_assoc_op *cti_assoc_ops;
>  
> +ssize_t coresight_simple_show(struct device *_dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct coresight_device *csdev = container_of(_dev, struct coresight_device, dev);
> +	struct cs_ext_attribute *cs_attr = container_of(attr, struct cs_ext_attribute, attr);
> +	u64 val;
> +
> +	pm_runtime_get_sync(_dev->parent);
> +	val = csdev_access_relaxed_read_pair(&csdev->access, cs_attr->lo_off, cs_attr->hi_off);
> +	pm_runtime_put_sync(_dev->parent);
> +	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", val);
> +}
> +EXPORT_SYMBOL_GPL(coresight_simple_show);
> +
>  void coresight_set_cti_ops(const struct cti_assoc_op *cti_op)
>  {
>  	cti_assoc_ops = cti_op;
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 405bb3355cb1..8aa6e4f83e42 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -655,24 +655,15 @@ static const struct file_operations etb_fops = {
>  	.llseek		= no_llseek,
>  };
>  
> -coresight_simple_reg32(rdp, ETB_RAM_DEPTH_REG);
> -coresight_simple_reg32(sts, ETB_STATUS_REG);
> -coresight_simple_reg32(rrp, ETB_RAM_READ_POINTER);
> -coresight_simple_reg32(rwp, ETB_RAM_WRITE_POINTER);
> -coresight_simple_reg32(trg, ETB_TRG);
> -coresight_simple_reg32(ctl, ETB_CTL_REG);
> -coresight_simple_reg32(ffsr, ETB_FFSR);
> -coresight_simple_reg32(ffcr, ETB_FFCR);
> -
>  static struct attribute *coresight_etb_mgmt_attrs[] = {
> -	&dev_attr_rdp.attr,
> -	&dev_attr_sts.attr,
> -	&dev_attr_rrp.attr,
> -	&dev_attr_rwp.attr,
> -	&dev_attr_trg.attr,
> -	&dev_attr_ctl.attr,
> -	&dev_attr_ffsr.attr,
> -	&dev_attr_ffcr.attr,
> +	coresight_simple_reg32(rdp, ETB_RAM_DEPTH_REG),
> +	coresight_simple_reg32(sts, ETB_STATUS_REG),
> +	coresight_simple_reg32(rrp, ETB_RAM_READ_POINTER),
> +	coresight_simple_reg32(rwp, ETB_RAM_WRITE_POINTER),
> +	coresight_simple_reg32(trg, ETB_TRG),
> +	coresight_simple_reg32(ctl, ETB_CTL_REG),
> +	coresight_simple_reg32(ffsr, ETB_FFSR),
> +	coresight_simple_reg32(ffcr, ETB_FFCR),
>  	NULL,
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index 12f8e8176c7e..1d059947ae32 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -1252,28 +1252,19 @@ static struct attribute *coresight_etm_attrs[] = {
>  	NULL,
>  };
>  
> -coresight_simple_reg32(etmccr, ETMCCR);
> -coresight_simple_reg32(etmccer, ETMCCER);
> -coresight_simple_reg32(etmscr, ETMSCR);
> -coresight_simple_reg32(etmidr, ETMIDR);
> -coresight_simple_reg32(etmcr, ETMCR);
> -coresight_simple_reg32(etmtraceidr, ETMTRACEIDR);
> -coresight_simple_reg32(etmteevr, ETMTEEVR);
> -coresight_simple_reg32(etmtssvr, ETMTSSCR);
> -coresight_simple_reg32(etmtecr1, ETMTECR1);
> -coresight_simple_reg32(etmtecr2, ETMTECR2);
> +

Extra newline, and if I am correct removing the above and adding what follows
will result in 2 extra newline.

>  
>  static struct attribute *coresight_etm_mgmt_attrs[] = {
> -	&dev_attr_etmccr.attr,
> -	&dev_attr_etmccer.attr,
> -	&dev_attr_etmscr.attr,
> -	&dev_attr_etmidr.attr,
> -	&dev_attr_etmcr.attr,
> -	&dev_attr_etmtraceidr.attr,
> -	&dev_attr_etmteevr.attr,
> -	&dev_attr_etmtssvr.attr,
> -	&dev_attr_etmtecr1.attr,
> -	&dev_attr_etmtecr2.attr,
> +	coresight_simple_reg32(etmccr, ETMCCR),
> +	coresight_simple_reg32(etmccer, ETMCCER),
> +	coresight_simple_reg32(etmscr, ETMSCR),
> +	coresight_simple_reg32(etmidr, ETMIDR),
> +	coresight_simple_reg32(etmcr, ETMCR),
> +	coresight_simple_reg32(etmtraceidr, ETMTRACEIDR),
> +	coresight_simple_reg32(etmteevr, ETMTEEVR),
> +	coresight_simple_reg32(etmtssvr, ETMTSSCR),
> +	coresight_simple_reg32(etmtecr1, ETMTECR1),
> +	coresight_simple_reg32(etmtecr2, ETMTECR2),
>  	NULL,
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index cf8ae768106e..6680f5929429 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -39,24 +39,30 @@
>  
>  #define ETM_MODE_EXCL_KERN	BIT(30)
>  #define ETM_MODE_EXCL_USER	BIT(31)
> +struct cs_ext_attribute {
> +	struct device_attribute attr;
> +	u32 lo_off;
> +	u32 hi_off;

I touched based on those in my previous comment, i.e it should be s32 rather
than u32.

> +};
>  
> -#define __coresight_simple_show(name, lo_off, hi_off)		\
> -static ssize_t name##_show(struct device *_dev,				\
> -			   struct device_attribute *attr, char *buf)	\
> -{									\
> -	struct coresight_device *csdev = container_of(_dev, struct coresight_device, dev); \
> -	u64 val;							\
> -	pm_runtime_get_sync(_dev->parent);				\
> -	val = csdev_access_relaxed_read_pair(&csdev->access, lo_off, hi_off);	\
> -	pm_runtime_put_sync(_dev->parent);				\
> -	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", val);		\
> -}									\
> -static DEVICE_ATTR_RO(name)
> -
> -#define coresight_simple_reg32(name, offset)			\
> -	__coresight_simple_show(name, offset, -1)
> -#define coresight_simple_reg64(name, lo_off, hi_off)		\
> -	__coresight_simple_show(name, lo_off, hi_off)
> +extern ssize_t coresight_simple_show(struct device *_dev,
> +				     struct device_attribute *attr, char *buf);
> +
> +#define coresight_simple_reg32(name, offset)				\
> +	(&((struct cs_ext_attribute[]) {				\
> +	   {								\
> +		__ATTR(name, 0444, coresight_simple_show, NULL),	\
> +		offset, -1						\
> +	   }								\
> +	})[0].attr.attr)
> +
> +#define coresight_simple_reg64(name, lo_off, hi_off)			\
> +	(&((struct cs_ext_attribute[]) {				\
> +	   {								\
> +		__ATTR(name, 0444, coresight_simple_show, NULL),	\
> +		lo_off, hi_off						\
> +	   }								\
> +	})[0].attr.attr)
>  
>  extern const u32 coresight_barrier_pkt[4];
>  #define CORESIGHT_BARRIER_PKT_SIZE (sizeof(coresight_barrier_pkt))
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 7cffcbb2ec42..4dd50546d7e4 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -196,12 +196,9 @@ static const struct coresight_ops replicator_cs_ops = {
>  	.link_ops	= &replicator_link_ops,
>  };
>  
> -coresight_simple_reg32(idfilter0, REPLICATOR_IDFILTER0);
> -coresight_simple_reg32(idfilter1, REPLICATOR_IDFILTER1);
> -
>  static struct attribute *replicator_mgmt_attrs[] = {
> -	&dev_attr_idfilter0.attr,
> -	&dev_attr_idfilter1.attr,
> +	coresight_simple_reg32(idfilter0, REPLICATOR_IDFILTER0),
> +	coresight_simple_reg32(idfilter1, REPLICATOR_IDFILTER1),
>  	NULL,
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 4a31905604fe..463f449cfb79 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -634,19 +634,6 @@ static ssize_t traceid_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(traceid);
>  
> -coresight_simple_reg32(tcsr, STMTCSR);
> -coresight_simple_reg32(tsfreqr, STMTSFREQR);
> -coresight_simple_reg32(syncr, STMSYNCR);
> -coresight_simple_reg32(sper, STMSPER);
> -coresight_simple_reg32(spter, STMSPTER);
> -coresight_simple_reg32(privmaskr, STMPRIVMASKR);
> -coresight_simple_reg32(spscr, STMSPSCR);
> -coresight_simple_reg32(spmscr, STMSPMSCR);
> -coresight_simple_reg32(spfeat1r, STMSPFEAT1R);
> -coresight_simple_reg32(spfeat2r, STMSPFEAT2R);
> -coresight_simple_reg32(spfeat3r, STMSPFEAT3R);
> -coresight_simple_reg32(devid, CORESIGHT_DEVID);
> -
>  static struct attribute *coresight_stm_attrs[] = {
>  	&dev_attr_hwevent_enable.attr,
>  	&dev_attr_hwevent_select.attr,
> @@ -657,18 +644,18 @@ static struct attribute *coresight_stm_attrs[] = {
>  };
>  
>  static struct attribute *coresight_stm_mgmt_attrs[] = {
> -	&dev_attr_tcsr.attr,
> -	&dev_attr_tsfreqr.attr,
> -	&dev_attr_syncr.attr,
> -	&dev_attr_sper.attr,
> -	&dev_attr_spter.attr,
> -	&dev_attr_privmaskr.attr,
> -	&dev_attr_spscr.attr,
> -	&dev_attr_spmscr.attr,
> -	&dev_attr_spfeat1r.attr,
> -	&dev_attr_spfeat2r.attr,
> -	&dev_attr_spfeat3r.attr,
> -	&dev_attr_devid.attr,
> +	coresight_simple_reg32(tcsr, STMTCSR),
> +	coresight_simple_reg32(tsfreqr, STMTSFREQR),
> +	coresight_simple_reg32(syncr, STMSYNCR),
> +	coresight_simple_reg32(sper, STMSPER),
> +	coresight_simple_reg32(spter, STMSPTER),
> +	coresight_simple_reg32(privmaskr, STMPRIVMASKR),
> +	coresight_simple_reg32(spscr, STMSPSCR),
> +	coresight_simple_reg32(spmscr, STMSPMSCR),
> +	coresight_simple_reg32(spfeat1r, STMSPFEAT1R),
> +	coresight_simple_reg32(spfeat2r, STMSPFEAT2R),
> +	coresight_simple_reg32(spfeat3r, STMSPFEAT3R),
> +	coresight_simple_reg32(devid, CORESIGHT_DEVID),
>  	NULL,
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 781d213526b7..07abf28ad725 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -251,36 +251,21 @@ static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
>  	return memwidth;
>  }
>  
> -coresight_simple_reg32(rsz, TMC_RSZ);
> -coresight_simple_reg32(sts, TMC_STS);
> -coresight_simple_reg32(trg, TMC_TRG);
> -coresight_simple_reg32(ctl, TMC_CTL);
> -coresight_simple_reg32(ffsr, TMC_FFSR);
> -coresight_simple_reg32(ffcr, TMC_FFCR);
> -coresight_simple_reg32(mode, TMC_MODE);
> -coresight_simple_reg32(pscr, TMC_PSCR);
> -coresight_simple_reg32(axictl, TMC_AXICTL);
> -coresight_simple_reg32(authstatus, TMC_AUTHSTATUS);
> -coresight_simple_reg32(devid, CORESIGHT_DEVID);
> -coresight_simple_reg64(rrp, TMC_RRP, TMC_RRPHI);
> -coresight_simple_reg64(rwp, TMC_RWP, TMC_RWPHI);
> -coresight_simple_reg64(dba, TMC_DBALO, TMC_DBAHI);
> -
>  static struct attribute *coresight_tmc_mgmt_attrs[] = {
> -	&dev_attr_rsz.attr,
> -	&dev_attr_sts.attr,
> -	&dev_attr_rrp.attr,
> -	&dev_attr_rwp.attr,
> -	&dev_attr_trg.attr,
> -	&dev_attr_ctl.attr,
> -	&dev_attr_ffsr.attr,
> -	&dev_attr_ffcr.attr,
> -	&dev_attr_mode.attr,
> -	&dev_attr_pscr.attr,
> -	&dev_attr_devid.attr,
> -	&dev_attr_dba.attr,
> -	&dev_attr_axictl.attr,
> -	&dev_attr_authstatus.attr,
> +	coresight_simple_reg32(rsz, TMC_RSZ),
> +	coresight_simple_reg32(sts, TMC_STS),
> +	coresight_simple_reg64(rrp, TMC_RRP, TMC_RRPHI),
> +	coresight_simple_reg64(rwp, TMC_RWP, TMC_RWPHI),
> +	coresight_simple_reg32(trg, TMC_TRG),
> +	coresight_simple_reg32(ctl, TMC_CTL),
> +	coresight_simple_reg32(ffsr, TMC_FFSR),
> +	coresight_simple_reg32(ffcr, TMC_FFCR),
> +	coresight_simple_reg32(mode, TMC_MODE),
> +	coresight_simple_reg32(pscr, TMC_PSCR),
> +	coresight_simple_reg32(devid, CORESIGHT_DEVID),
> +	coresight_simple_reg64(dba, TMC_DBALO, TMC_DBAHI),
> +	coresight_simple_reg32(axictl, TMC_AXICTL),
> +	coresight_simple_reg32(authstatus, TMC_AUTHSTATUS),
>  	NULL,
>  };
>  
> -- 
> 2.28.0
> 
