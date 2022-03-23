Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33614E55D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbiCWQAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiCWQAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:00:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D274D7B116
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:59:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gb19so2111538pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ucpk5Q0in5Zgbmf1vtrkAAwV871oryzGrvM70mFS3CI=;
        b=CQzATWJKf28fxyTpOkmeWbkvLyK9AewrGllJY3t3RNq3EZtbzERxekm9HaFBMYn1E+
         56isxkCPgUp04yuqfjVihN/1uchukjJiTgWS1MByLePR6e4Iu8K7C0tsPsta1k05EWk4
         cA+b0sP/rBbAOSi3gnLCMz/AahwV5tgcnwBYl6YZ3Fzwj/uYdyuMeNnMiKAEZ7Tb51Ff
         bHdGkNciwPIA6pg/kVeovkWoME0EV+0txqpiI7J70WdDrIM7xihsO7Sdk9vEiFF5409d
         pOZRjjX0pnGMuyNpdVRBkxxr0WRrjCDo9rlZ5okzn94wHCC+lF88hvSlFjJw0J9sUKk5
         FL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ucpk5Q0in5Zgbmf1vtrkAAwV871oryzGrvM70mFS3CI=;
        b=At9eK/BvHG8mgZhpJQW1jsc0AVkPSJ08+IMiFkaG0GHLoayhZpsZod0EWKqAh+2bp2
         yxHTJHkkjaenXQdqMm7d9nizP8uI7lImPlD/snbhSx/TQxO8GUsDxl3zJsBG/DGJfavO
         WqrT1AVnn2JSdwTQ71Lr15uF4bro+QhyLVT2XLAFh3vN+fVnYyh5+qiFMvyGuFpE3euJ
         x6NwWhoG+46ZdfkReaZmks6Z/KvlgIAxpmsA6hUtFfR9Rgsg0AcG9mHjFu7dEZzz2n2S
         QVHVjVG0gRZxnH38gxTYO9RUJdqq4E/94M8R2gRUx5gQ4pl9qprZci8QRyULsTcitXot
         WW1A==
X-Gm-Message-State: AOAM531+Jpc2hHKy4eTV2RgZ9xo/NfoRBM8kZEcp37ypPOVmDdV3Rsp7
        KHZeZHhYujRagVUJjH8Us9QqjA==
X-Google-Smtp-Source: ABdhPJyPle3MrmLdWNeklLJA9g1fqYHDW07xJy5RiKRHnVc6idUDhtpYtvzkRwNCkKLoNM77AB45LQ==
X-Received: by 2002:a17:902:f612:b0:14c:e978:f99e with SMTP id n18-20020a170902f61200b0014ce978f99emr644119plg.23.1648051157197;
        Wed, 23 Mar 2022 08:59:17 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id ot17-20020a17090b3b5100b001c746bfba10sm7594536pjb.35.2022.03.23.08.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 08:59:15 -0700 (PDT)
Date:   Wed, 23 Mar 2022 09:59:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/15] coresight: etm4x: Cleanup TRCVICTLR register
 accesses
Message-ID: <20220323155913.GA3248686@p14s>
References: <20220304171913.2292458-1-james.clark@arm.com>
 <20220304171913.2292458-10-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304171913.2292458-10-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Mar 04, 2022 at 05:19:06PM +0000, James Clark wrote:
> This is a no-op change for style and consistency and has no effect on
> the binary output by the compiler. In sysreg.h fields are defined as
> the register name followed by the field name and then _MASK. This
> allows for grepping for fields by name rather than using magic numbers.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 10 +++---
>  .../coresight/coresight-etm4x-sysfs.c         | 36 +++++++++----------
>  drivers/hwtracing/coresight/coresight-etm4x.h | 22 +++++-------
>  3 files changed, 31 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 445e2057d5ed..88353f8ba414 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1206,7 +1206,7 @@ static void etm4_init_arch_data(void *info)
>  
>  static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
>  {
> -	return etm4_get_access_type(config) << TRCVICTLR_EXLEVEL_SHIFT;
> +	return etm4_get_access_type(config) << __bf_shf(TRCVICTLR_EXLEVEL_MASK);
>  }
>  
>  /* Set ELx trace filter access in the TRCVICTLR register */
> @@ -1232,7 +1232,7 @@ static void etm4_set_default_config(struct etmv4_config *config)
>  	config->ts_ctrl = 0x0;
>  
>  	/* TRCVICTLR::EVENT = 0x01, select the always on logic */
> -	config->vinst_ctrl = BIT(0);
> +	config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
>  
>  	/* TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering */
>  	etm4_set_victlr_access(config);
> @@ -1341,7 +1341,7 @@ static void etm4_set_default_filter(struct etmv4_config *config)
>  	 * TRCVICTLR::SSSTATUS == 1, the start-stop logic is
>  	 * in the started state
>  	 */
> -	config->vinst_ctrl |= BIT(9);
> +	config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
>  	config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
>  
>  	/* No start-stop filtering for ViewInst */
> @@ -1445,7 +1445,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>  			 * TRCVICTLR::SSSTATUS == 1, the start-stop logic is
>  			 * in the started state
>  			 */
> -			config->vinst_ctrl |= BIT(9);
> +			config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
>  
>  			/* No start-stop filtering for ViewInst */
>  			config->vissctlr = 0x0;
> @@ -1473,7 +1473,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>  			 * etm4_disable_perf().
>  			 */
>  			if (filters->ssstatus)
> -				config->vinst_ctrl |= BIT(9);
> +				config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
>  
>  			/* No include/exclude filtering for ViewInst */
>  			config->viiectlr = 0x0;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index cd24590ea38a..b3b1b92909cc 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -206,11 +206,11 @@ static ssize_t reset_store(struct device *dev,
>  	 * started state. ARM recommends start-stop logic is set before
>  	 * each trace run.
>  	 */
> -	config->vinst_ctrl = BIT(0);
> +	config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
>  	if (drvdata->nr_addr_cmp > 0) {
>  		config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
>  		/* SSSTATUS, bit[9] */
> -		config->vinst_ctrl |= BIT(9);
> +		config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
>  	}
>  
>  	/* No address range filtering for ViewInst */
> @@ -416,22 +416,22 @@ static ssize_t mode_store(struct device *dev,
>  
>  	/* bit[9] Start/stop logic control bit */
>  	if (config->mode & ETM_MODE_VIEWINST_STARTSTOP)
> -		config->vinst_ctrl |= BIT(9);
> +		config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
>  	else
> -		config->vinst_ctrl &= ~BIT(9);
> +		config->vinst_ctrl &= ~TRCVICTLR_SSSTATUS;
>  
>  	/* bit[10], Whether a trace unit must trace a Reset exception */
>  	if (config->mode & ETM_MODE_TRACE_RESET)
> -		config->vinst_ctrl |= BIT(10);
> +		config->vinst_ctrl |= TRCVICTLR_TRCRESET;
>  	else
> -		config->vinst_ctrl &= ~BIT(10);
> +		config->vinst_ctrl &= ~TRCVICTLR_TRCRESET;
>  
>  	/* bit[11], Whether a trace unit must trace a system error exception */
>  	if ((config->mode & ETM_MODE_TRACE_ERR) &&
>  		(drvdata->trc_error == true))
> -		config->vinst_ctrl |= BIT(11);
> +		config->vinst_ctrl |= TRCVICTLR_TRCERR;
>  	else
> -		config->vinst_ctrl &= ~BIT(11);
> +		config->vinst_ctrl &= ~TRCVICTLR_TRCERR;
>  
>  	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
>  		etm4_config_trace_mode(config);
> @@ -723,7 +723,7 @@ static ssize_t event_vinst_show(struct device *dev,
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
>  	struct etmv4_config *config = &drvdata->config;
>  
> -	val = config->vinst_ctrl & ETMv4_EVENT_MASK;
> +	val = FIELD_GET(TRCVICTLR_EVENT_MASK, config->vinst_ctrl);
>  	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
>  }
>  
> @@ -739,9 +739,9 @@ static ssize_t event_vinst_store(struct device *dev,
>  		return -EINVAL;
>  
>  	spin_lock(&drvdata->spinlock);
> -	val &= ETMv4_EVENT_MASK;
> -	config->vinst_ctrl &= ~ETMv4_EVENT_MASK;
> -	config->vinst_ctrl |= val;
> +	val &= TRCVICTLR_EVENT_MASK >> __bf_shf(TRCVICTLR_EVENT_MASK);

Not sure why the right-shifting operation is needed since the mask starts at bit
0.  Please consider fixing _if_ you end up respinning this.

Thanks,
Mathieu

> +	config->vinst_ctrl &= ~TRCVICTLR_EVENT_MASK;
> +	config->vinst_ctrl |= FIELD_PREP(TRCVICTLR_EVENT_MASK, val);
>  	spin_unlock(&drvdata->spinlock);
>  	return size;
>  }
> @@ -755,7 +755,7 @@ static ssize_t s_exlevel_vinst_show(struct device *dev,
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
>  	struct etmv4_config *config = &drvdata->config;
>  
> -	val = (config->vinst_ctrl & TRCVICTLR_EXLEVEL_S_MASK) >> TRCVICTLR_EXLEVEL_S_SHIFT;
> +	val = FIELD_GET(TRCVICTLR_EXLEVEL_S_MASK, config->vinst_ctrl);
>  	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
>  }
>  
> @@ -772,10 +772,10 @@ static ssize_t s_exlevel_vinst_store(struct device *dev,
>  
>  	spin_lock(&drvdata->spinlock);
>  	/* clear all EXLEVEL_S bits  */
> -	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_S_MASK);
> +	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_S_MASK;
>  	/* enable instruction tracing for corresponding exception level */
>  	val &= drvdata->s_ex_level;
> -	config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_S_SHIFT);
> +	config->vinst_ctrl |= val << __bf_shf(TRCVICTLR_EXLEVEL_S_MASK);
>  	spin_unlock(&drvdata->spinlock);
>  	return size;
>  }
> @@ -790,7 +790,7 @@ static ssize_t ns_exlevel_vinst_show(struct device *dev,
>  	struct etmv4_config *config = &drvdata->config;
>  
>  	/* EXLEVEL_NS, bits[23:20] */
> -	val = (config->vinst_ctrl & TRCVICTLR_EXLEVEL_NS_MASK) >> TRCVICTLR_EXLEVEL_NS_SHIFT;
> +	val = FIELD_GET(TRCVICTLR_EXLEVEL_NS_MASK, config->vinst_ctrl);
>  	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
>  }
>  
> @@ -807,10 +807,10 @@ static ssize_t ns_exlevel_vinst_store(struct device *dev,
>  
>  	spin_lock(&drvdata->spinlock);
>  	/* clear EXLEVEL_NS bits  */
> -	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_NS_MASK);
> +	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_NS_MASK;
>  	/* enable instruction tracing for corresponding exception level */
>  	val &= drvdata->ns_ex_level;
> -	config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_NS_SHIFT);
> +	config->vinst_ctrl |= val << __bf_shf(TRCVICTLR_EXLEVEL_NS_MASK);
>  	spin_unlock(&drvdata->spinlock);
>  	return size;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 36934056a5dc..9cacc38b1890 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -200,6 +200,14 @@
>  #define TRCSTALLCTLR_INSTPRIORITY		BIT(10)
>  #define TRCSTALLCTLR_NOOVERFLOW			BIT(13)
>  
> +#define TRCVICTLR_EVENT_MASK			GENMASK(7, 0)
> +#define TRCVICTLR_SSSTATUS			BIT(9)
> +#define TRCVICTLR_TRCRESET			BIT(10)
> +#define TRCVICTLR_TRCERR			BIT(11)
> +#define TRCVICTLR_EXLEVEL_MASK			GENMASK(22, 16)
> +#define TRCVICTLR_EXLEVEL_S_MASK		GENMASK(19, 16)
> +#define TRCVICTLR_EXLEVEL_NS_MASK		GENMASK(22, 20)
> +
>  /*
>   * System instructions to access ETM registers.
>   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> @@ -700,23 +708,9 @@
>  #define ETM_EXLEVEL_NS_OS		BIT(5)	/* NonSecure EL1	*/
>  #define ETM_EXLEVEL_NS_HYP		BIT(6)	/* NonSecure EL2	*/
>  
> -#define ETM_EXLEVEL_MASK		(GENMASK(6, 0))
> -#define ETM_EXLEVEL_S_MASK		(GENMASK(3, 0))
> -#define ETM_EXLEVEL_NS_MASK		(GENMASK(6, 4))
> -
>  /* access level controls in TRCACATRn */
>  #define TRCACATR_EXLEVEL_SHIFT		8
>  
> -/* access level control in TRCVICTLR */
> -#define TRCVICTLR_EXLEVEL_SHIFT		16
> -#define TRCVICTLR_EXLEVEL_S_SHIFT	16
> -#define TRCVICTLR_EXLEVEL_NS_SHIFT	20
> -
> -/* secure / non secure masks - TRCVICTLR, IDR3 */
> -#define TRCVICTLR_EXLEVEL_MASK		(ETM_EXLEVEL_MASK << TRCVICTLR_EXLEVEL_SHIFT)
> -#define TRCVICTLR_EXLEVEL_S_MASK	(ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_SHIFT)
> -#define TRCVICTLR_EXLEVEL_NS_MASK	(ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_SHIFT)
> -
>  #define ETM_TRCIDR1_ARCH_MAJOR_SHIFT	8
>  #define ETM_TRCIDR1_ARCH_MAJOR_MASK	(0xfU << ETM_TRCIDR1_ARCH_MAJOR_SHIFT)
>  #define ETM_TRCIDR1_ARCH_MAJOR(x)	\
> -- 
> 2.28.0
> 
