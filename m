Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930834E5621
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245182AbiCWQR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiCWQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:17:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED7F5E760
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:15:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so3871739pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pcx7/9ycFKhUp3zVINYYwi3rKHTntPB1s1CdzdzJkI8=;
        b=eGGfvi/aUXQQclLi2Amu4UiMJiLdizTXDGRXWO/qo/pjeq0UjwJ+/KmjV1QJc9ydpy
         pL0ZR9rWXELEPhhUCWfxF8mn7RgGLmXlPvf0DtTZgMVU+r9GW/CSWpNzpJ+9LMDRQ9q5
         v12h6RkJp5B7xF9FmyJYBNc7GzflaBOdqWriG/uwfJNh8U18BYF8s/42UTwJKxYKgDs3
         IPg8D7JKTBO3BA/JFEjYbq0nkr4qIDA5RRRfZo5B8ecvmPEJSAeK9HZiZQc8BrVS8kHJ
         LO6eRGpdTF/k/4UWjOGozhBoRo0xDEdCEJVRLjh5COk7eOXaP5EwZPWVwNPuzQ8Wz0YT
         EpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pcx7/9ycFKhUp3zVINYYwi3rKHTntPB1s1CdzdzJkI8=;
        b=pTyqXGNbt2/Jg4SzIpsKrp6hlpkfdwB67ZvuwjkNTMu+lHOGxQ3Bv7glX5e187uHb3
         rWkgdFaB4GS+KUt3vJlj/xPdEs4eyoRU8gsTR/1uSVuPbqW3U1aHnZdLUgX1k+l6D40F
         xtpBJDD/f6BYVjLONXse5gYYjEmqf0VmO1GvEChtR7rNt2o+La24awrfm1OgU7TBuyiv
         0xZJofSVeYHtF4YghaVdGx09TVM3ysCdU0PW8KzNVardD26ElHB4yyQcat3i0poOVjY3
         bvQQoePSTXF/ZYBCsOZQMVhq72TyT0DWl8BLXw9e8lg9EAn1Icpo2wgUQDaNN18S6glX
         QmWQ==
X-Gm-Message-State: AOAM531LPeQcmhmM4ktjzsFSzlRBro01lswmRu5duQ4Nvon+cMtpLeVj
        gXqESr4+mHvZR+5CHQIN8EaYRQ==
X-Google-Smtp-Source: ABdhPJyxi08PWO08eYKcX0xvVjJbDB4ehRiQE8BTsiU1yHEEjgcdGYY/QQmGaXBPJattZjY/9m5ulQ==
X-Received: by 2002:a17:90a:dd45:b0:1bc:9466:9b64 with SMTP id u5-20020a17090add4500b001bc94669b64mr12553848pjv.23.1648052155246;
        Wed, 23 Mar 2022 09:15:55 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y13-20020a63b50d000000b0038297275c00sm265964pge.34.2022.03.23.09.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:15:54 -0700 (PDT)
Date:   Wed, 23 Mar 2022 10:15:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/15] coresight: etm4x: Cleanup TRCRSCTLRn register
 accesses
Message-ID: <20220323161551.GB3248686@p14s>
References: <20220304171913.2292458-1-james.clark@arm.com>
 <20220304171913.2292458-16-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304171913.2292458-16-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 05:19:12PM +0000, James Clark wrote:
> This is a no-op change for style and consistency and has no effect on
> the binary output by the compiler. In sysreg.h fields are defined as
> the register name followed by the field name and then _MASK. This
> allows for grepping for fields by name rather than using magic numbers.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 7 +++++--
>  drivers/hwtracing/coresight/coresight-etm4x.h       | 7 +++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 3ae6f4432646..6ea8181816fc 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1726,8 +1726,11 @@ static ssize_t res_ctrl_store(struct device *dev,
>  	/* For odd idx pair inversal bit is RES0 */
>  	if (idx % 2 != 0)
>  		/* PAIRINV, bit[21] */
> -		val &= ~BIT(21);
> -	config->res_ctrl[idx] = val & GENMASK(21, 0);
> +		val &= ~TRCRSCTLRn_PAIRINV;
> +	config->res_ctrl[idx] = val & (TRCRSCTLRn_PAIRINV |
> +				       TRCRSCTLRn_INV |
> +				       TRCRSCTLRn_GROUP_MASK |
> +				       TRCRSCTLRn_SELECT_MASK);
>  	spin_unlock(&drvdata->spinlock);
>  	return size;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 15704982357f..2c412841b126 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -223,6 +223,13 @@
>  #define TRCBBCTLR_MODE				BIT(8)
>  #define TRCBBCTLR_RANGE_MASK			GENMASK(7, 0)
>  
> +#define TRCRSCTLRn_PAIRINV			BIT(21)
> +#define TRCRSCTLRn_INV				BIT(20)
> +#define TRCRSCTLRn_GROUP_MASK			GENMASK(19, 16)
> +#define TRCRSCTLRn_SELECT_MASK			GENMASK(15, 0)
> +
> +
> +

Two extra lines.

>  /*
>   * System instructions to access ETM registers.
>   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> -- 
> 2.28.0
> 
