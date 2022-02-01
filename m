Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194154A6205
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbiBARNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiBARNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:13:10 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41868C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:13:10 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso3758947pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GOTW49dkatvM+333ev58XzmJGJGpPe+Z89sc7+xSJjo=;
        b=wuvvP0gdVgZs1A/Wxt5ap2DV8ui/vAGBipNuDcKGDCYcwe6WAq6sPm3j0WCUfD9Lr0
         caum9JUDupSfKFFJ+B7s1kloeUVTj8qj04Ow+T34j2MeTG9JOATCNW67W9c5mk2H5Rm/
         8IWOmLnyI1OanJEtsko1eLc0Sv+iX5xstLj/NPhB3Kj1ac+IpoBtL9+60aCPgfyhuzrU
         7F4xgaAChfOMtavqslzy8wfskfw8BCsf7FvCy5S1h6JimYZ3/Y47aRFe0dThCXKZ0wj2
         4vdnoVu3/K1tAiQvFYZJeD56BqF1eibPvhpDsV+eX8+9vnzSKyPWLszpaLwSjmN61b4w
         qCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GOTW49dkatvM+333ev58XzmJGJGpPe+Z89sc7+xSJjo=;
        b=df7Tq8B+wZWUePEheaEuu9oMccgGiduXdCyBunhHhky1Y01Sx2/YhkU7x/9mDdn3Rt
         Y9WU7bV36UCukiR590xhbJHXw6zPq54LMExju6FhTudEOeHWZ3utKBrG19UwGd8D8/+/
         20SozTsyJ8QDzHMHmQ7oxMy26uRV2df2Th/kfQC+PtwamDHy4+oQl1AhE5QVp4TfTdp+
         lOdKX5mQK33b95wCSe/Z1pbBSucOyRS2s0/4v9C/ZuTtGVBiF4KBxy+EOF6ZGJcyyZay
         u0OAMZwlFRgVSunH4ObAZbxkHZpNAOQQjg00/gX1koC3RIXjd1ToPllOGpjVmkBPni7d
         ijRw==
X-Gm-Message-State: AOAM530nEhYf3htlSxHNwHTNfKIjAfPWNGJeP+l9FKy+7Co6rvZ9cvoe
        6axx8SwtCCR3yVKn9J6SFQ27Jw==
X-Google-Smtp-Source: ABdhPJzrR5tNGJO1MpLKd5EJaHkefJxDXaOyvaYpafZQ4Mnt1nlV2uCN7KUlpMtMkAcx7lU8+yXsWQ==
X-Received: by 2002:a17:90b:4f4e:: with SMTP id pj14mr3422943pjb.220.1643735589737;
        Tue, 01 Feb 2022 09:13:09 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 38sm32163145pgm.37.2022.02.01.09.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:13:08 -0800 (PST)
Date:   Tue, 1 Feb 2022 10:13:06 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
        leo.yan@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        suzuki.poulose@arm.com
Subject: Re: [PATCH v2] coresight: syscfg: Fix memleak on registration
 failure in cscfg_create_device
Message-ID: <20220201171306.GB2490199@p14s>
References: <20220120182822.GA1342128@p14s>
 <20220124124121.8888-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124124121.8888-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 12:41:21PM +0000, Miaoqian Lin wrote:
> device_register() calls device_initialize(),
> according to doc of device_initialize:
> 
>     Use put_device() to give up your reference instead of freeing
>     * @dev directly once you have called this function.
> 
> To prevent potential memleak, use put_device() for error handling.
> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> Changes in v2:
> - simply call put_device() instead of cscfg_dev_release() in the error
> path of cscfg_create_device.
> ---
>  drivers/hwtracing/coresight/coresight-syscfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index 43054568430f..c30989e0675f 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -791,7 +791,7 @@ static int cscfg_create_device(void)
>  
>  	err = device_register(dev);
>  	if (err)
> -		cscfg_dev_release(dev);
> +		put_device(dev);

Applied.

Thanks,
Mathieu

>  
>  create_dev_exit_unlock:
>  	mutex_unlock(&cscfg_mutex);
> -- 
> 2.17.1
> 
