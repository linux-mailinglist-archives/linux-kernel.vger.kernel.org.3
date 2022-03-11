Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC984D6A80
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiCKWyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiCKWy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:54:27 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B656CF4050
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:28:48 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id 63so4238668uaw.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=92arqH79BiLSpPq07XLUFaVqVUezAYRqELNUQGsWkP8=;
        b=iQpC0+rNJZbuHaOeNvznCfYVkxwcczBWd0UPzccgCs+Go8jlx74Jwrya4YQPPBqi1a
         LIhTzDWIhSomlxEQMebBYj8mab0jbSuU3k9hDKg0n1CMhsrp9WiAjLKAjU27AZhCBitS
         QdUsya3XzeGHUIkAESKVibTANgUfmYd5fV2hTFATDwqkRGRgZ8T6ndA7i/TLiLdoJf0W
         ZgnR8E5uV3gns2EJU0+hrIVrz5bQFQ2CfJzZXCTKlZr0x+0nbhJsXD0LqeAY2NFTGf2N
         ZcI9uRsZS71/z3er5kTnwf0nSFfrzZrnHIc3Sol/BUgkr2SKn5yPQVWURocQU4wj4diI
         6opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=92arqH79BiLSpPq07XLUFaVqVUezAYRqELNUQGsWkP8=;
        b=4uacjPuCqeBcVW2R6u9fXVS4KF1gY1hd4NzGF5KPoBshJT5eQdCEsAxP9u/Hm54Vm8
         MrRRWH4o7Q9HyBI7rb4U6VQgtxh8cf/V5xmnVqngc4TH77tyL7dl9Czj4qhiccGhsn+4
         XSxilnmuZN526XwgocoiZGyuxLYHSCHRMrWKAoZ7llkXFDJ5HSCjywwIue/rXVEqcVG/
         IZCdfbzTBddL69L0pRPQm03rP141u8pibjb5q8zl2YR33UFONpXVYZJ7uSqCTAp01CsL
         xWnLLmIqv6y6RWGduulxKPWRkD1+ZHDnGJ1U0fGw4xH8g9fiimbrU4Aa2MguNlGehyLC
         2K6g==
X-Gm-Message-State: AOAM531qqzKXxl83ylluWuKzt4sjR3VyFkhRZnCHNKewJercbGQPn+Ei
        PCnU9D+KKHN74Z67m2RVu8LDLvANPBr9tA==
X-Google-Smtp-Source: ABdhPJyNJ1dbWXRv+O1wDk73YwyJ+7WeYLAxuFLmw30ASpn4am7HYMJlx1E1uXw3X6gJavS+fE1RZA==
X-Received: by 2002:a4a:a9cf:0:b0:2e9:5c75:e242 with SMTP id h15-20020a4aa9cf000000b002e95c75e242mr5516391oon.25.1647033654425;
        Fri, 11 Mar 2022 13:20:54 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u22-20020a4ae696000000b0032158ab4ce9sm2585808oot.26.2022.03.11.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:20:53 -0800 (PST)
Date:   Fri, 11 Mar 2022 15:20:52 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     mathieu.poirier@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: Re: [PATCH V3 2/2] remoteproc: support attach recovery after rproc
 crash
Message-ID: <Yiu9NNn/ZFpg7j7F@builder.lan>
References: <20220309230128.15856-1-peng.fan@oss.nxp.com>
 <20220309230128.15856-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309230128.15856-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09 Mar 17:01 CST 2022, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> Current logic only support main processor to stop/start the remote
> processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> remote processor could do attach recovery after crash and trigger watchdog
> reboot. It does not need main processor to load image, or stop/start M4
> core.
> 
> Introduce two functions: rproc_attach_recovery, rproc_firmware_recovery
> for the two cases. Firmware recovery is as before, let main processor to
> help recovery, while attach recovery is recover itself withou help.
> To attach recovery, we only do detach and attach.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Hi Peng,

Didn't spot this v3 as I reviewed v2, please see my feedback on that
version.

Regards,
Bjorn

> ---
> 
> V3:
>  Resend with cover-letter
> 
> V2-version 2:
>  use rproc_has_feature in patch 1/2
> V2-version1:
>  Nothing change in V2.
>  Only move this patch out from
>  https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364
> 
>  drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 69f51acf235e..366fad475898 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1887,6 +1887,50 @@ static int __rproc_detach(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static int rproc_attach_recovery(struct rproc *rproc)
> +{
> +	int ret;
> +
> +	mutex_unlock(&rproc->lock);
> +	ret = rproc_detach(rproc);
> +	mutex_lock(&rproc->lock);
> +	if (ret)
> +		return ret;
> +
> +	if (atomic_inc_return(&rproc->power) > 1)
> +		return 0;
> +
> +	return rproc_attach(rproc);
> +}
> +
> +static int rproc_firmware_recovery(struct rproc *rproc)
> +{
> +	const struct firmware *firmware_p;
> +	struct device *dev = &rproc->dev;
> +	int ret;
> +
> +	ret = rproc_stop(rproc, true);
> +	if (ret)
> +		return ret;
> +
> +	/* generate coredump */
> +	rproc->ops->coredump(rproc);
> +
> +	/* load firmware */
> +	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> +	if (ret < 0) {
> +		dev_err(dev, "request_firmware failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* boot the remote processor up again */
> +	ret = rproc_start(rproc, firmware_p);
> +
> +	release_firmware(firmware_p);
> +
> +	return ret;
> +}
> +
>  /**
>   * rproc_trigger_recovery() - recover a remoteproc
>   * @rproc: the remote processor
> @@ -1901,7 +1945,6 @@ static int __rproc_detach(struct rproc *rproc)
>   */
>  int rproc_trigger_recovery(struct rproc *rproc)
>  {
> -	const struct firmware *firmware_p;
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> @@ -1915,24 +1958,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  
>  	dev_err(dev, "recovering %s\n", rproc->name);
>  
> -	ret = rproc_stop(rproc, true);
> -	if (ret)
> -		goto unlock_mutex;
> -
> -	/* generate coredump */
> -	rproc->ops->coredump(rproc);
> -
> -	/* load firmware */
> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> -	if (ret < 0) {
> -		dev_err(dev, "request_firmware failed: %d\n", ret);
> -		goto unlock_mutex;
> -	}
> -
> -	/* boot the remote processor up again */
> -	ret = rproc_start(rproc, firmware_p);
> -
> -	release_firmware(firmware_p);
> +	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_RECOVERY))
> +		ret = rproc_attach_recovery(rproc);
> +	else
> +		ret = rproc_firmware_recovery(rproc);
>  
>  unlock_mutex:
>  	mutex_unlock(&rproc->lock);
> -- 
> 2.30.0
> 
