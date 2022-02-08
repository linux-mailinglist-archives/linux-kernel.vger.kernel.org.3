Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D11C4AE1AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385656AbiBHS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385660AbiBHS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:58:34 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D23C03FEEC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:58:18 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y5so72541pfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NuDVKcupWPWZQzgU6U8buer2ersgmbuGRKW8s6KtZbI=;
        b=ZR0NoryWPniq+EVBewnvk2KsPHdygfYYI9dNoCF/9m61vF5whsv+I2/jV8p/Qbgx+P
         7jRNFL5zyq+Jb5WyrcDtB1sb9qHvDUO64EksOXJLFpU3KB0w0ZTDLgz3BFQWyQA/Vz7x
         NRIrn0Ofuzm1CYeL2Z/7vtT09huxe9rD9Yfwo+mDu2VPTjWKVoTwXJE/ELSlqvQZs31G
         Nf2b667cbUfgtRJdBtGkxW6NS7ypZ6EB5TtSXgc8uJvuM02lnF2DR7huVV/1L2i4ZBLZ
         VB1OWlbBxmCtkhzkqNisMa64BoAV6F68Zd/KaIX+W3B0G+m3oTDTybQIMqnmkpC+nM2j
         sPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NuDVKcupWPWZQzgU6U8buer2ersgmbuGRKW8s6KtZbI=;
        b=zpN6cQefVPZ+n0wqYAbNisVn9/dvZSqpfMVaFw9LfUW6HBo5e3NCJUc/eewHNiMKFz
         cFgAGwGAnRDRhBslOQoRXZnABg5SowAgmvcKyUyjmUhf2yhjE4ECQKQBsOq3Q+lCsCQM
         vR/tzSCOWJFFAyFR21Xvo5azBaWFbS7xfsMLBblj4UxCUfrtOYBgiQq6VoWxj4tbeWpO
         jjQk/yhVY6jNOBxNDHLxntrE5U/i/Z70kk9yy/ShbN0K7QY6GbgBsPOxft09oZ8KM+mI
         tjqlCLjHYgcqrEREiyCoK21f0iF4iTvWLUVZTW/xNN4UwGz7M9e7Qh24YWHm5bjWDKkf
         K4Ag==
X-Gm-Message-State: AOAM5337OvZcWrnocZjou5pvvAetF4oD4AARjV64xHXRdpT/QCjD36oo
        v2aQOXCPUp/VSCW+a9mbuFkWRg==
X-Google-Smtp-Source: ABdhPJw8VHoJtAoqxATZi1GTIrqeRrywDXg1regOzdAutz7/rUf4XHuenfExCHOS2dvxIIgT6JrTsg==
X-Received: by 2002:aa7:9528:: with SMTP id c8mr5554106pfp.85.1644346697738;
        Tue, 08 Feb 2022 10:58:17 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id ip5sm3690253pjb.13.2022.02.08.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:58:16 -0800 (PST)
Date:   Tue, 8 Feb 2022 11:58:14 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        leo.yan@linaro.com, mike.leach@linaro.org,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/15] coresight: Make ETM4x TRCRSCTLRn register
 accesses consistent with sysreg.h
Message-ID: <20220208185814.GA3508773@p14s>
References: <20220203120604.128396-1-james.clark@arm.com>
 <20220203120604.128396-16-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203120604.128396-16-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 12:06:03PM +0000, James Clark wrote:
> This is a no-op change for style and consistency and has no effect on the
> binary produced by gcc-11.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 7 +++++--
>  drivers/hwtracing/coresight/coresight-etm4x.h       | 9 +++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index a0cdd2cd978a..c876a63fa84d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1728,8 +1728,11 @@ static ssize_t res_ctrl_store(struct device *dev,
>  	/* For odd idx pair inversal bit is RES0 */
>  	if (idx % 2 != 0)
>  		/* PAIRINV, bit[21] */
> -		val &= ~BIT(21);
> -	config->res_ctrl[idx] = val & GENMASK(21, 0);
> +		val &= ~TRCRSCTLRn_PAIRINV;
> +	config->res_ctrl[idx] = val & (TRCRSCTLRn_PAIRINV |
> +				       TRCRSCTLRn_INV |
> +				       (TRCRSCTLRn_GROUP_MASK << TRCRSCTLRn_GROUP_SHIFT) |
> +				       (TRCRSCTLRn_SELECT_MASK << TRCRSCTLRn_SELECT_SHIFT));
>  	spin_unlock(&drvdata->spinlock);
>  	return size;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 4d943faade33..dd2156a5e70b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -258,6 +258,15 @@
>  #define TRCBBCTLR_RANGE_SHIFT			0
>  #define TRCBBCTLR_RANGE_MASK			GENMASK(7, 0)
>  
> +#define TRCRSCTLRn_PAIRINV			BIT(21)
> +#define TRCRSCTLRn_INV				BIT(20)
> +#define TRCRSCTLRn_GROUP_SHIFT			16
> +#define TRCRSCTLRn_GROUP_MASK			GENMASK(3, 0)
> +#define TRCRSCTLRn_SELECT_SHIFT			0
> +#define TRCRSCTLRn_SELECT_MASK			GENMASK(15, 0)
> +
> +
> +

Two extra newlines.

With the above and for patches 02 to 15:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  /*
>   * System instructions to access ETM registers.
>   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> -- 
> 2.28.0
> 
