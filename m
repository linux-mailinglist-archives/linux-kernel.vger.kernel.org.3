Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E34DA89C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353257AbiCPCuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiCPCuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:50:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB36BF65
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:48:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so3855166pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F+9Lk/ZaOrFy64xMvd6xSLhdg3ceUuM8DcyhbPt/GUM=;
        b=t32YKnrPGUxZ5shZ99fWStzfMUkFlC1Lj9TCief1G7+4rubHcPZCBW99KdgQrIoNB6
         atAh1RryHo5uqi5Gx3OY5qF014LUWmMiEIwgWtAwocyP0sU/Mg8x0GVnZypuPgsNkqpp
         Zz6eOomO9XKNL88zcrqmCS1AeIENLF3YgGcEzNgqGs9mzR9VmjtCtvPzo7t4/vFZm5HD
         Tm8VI3wqWOatHyzn4bhprFp4M7kFjkUbav8yO8TOREOEP7MLAsCte5twThcAn3HBNQ5Y
         pbqYBjWbVRb+js8vPRpr3JxHDbRWvosFQbQuDpaE5s3sc2oOkWtC12PwgWQi0RnKFH8O
         Yl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+9Lk/ZaOrFy64xMvd6xSLhdg3ceUuM8DcyhbPt/GUM=;
        b=cAo42W3cvm6aFqRAQ7pmJTFhbhDvNqy9VjjH3YCliuFlU2mIkhQdVoDQcRm1ZCDkFr
         ZTBUdcVfAZMqSOHfkw9+ZXSs+oiNWf9uBXnCLL5EXDKguIgivjhHuZ1Hhxijn7ERnseG
         AgVEl49CUQT8dU5t9VDmJoTrT73b7bPmyPHKD6fGdJLVPk45gHicEpWWUIWA8mt0e5Om
         TMDVpZKxAmvbEWS3sPW8s4oupLu2T6VlvZeZPuqM/Vkbcj7ootzhcbs48Ic02aSjpmZa
         XZg3HSaJ/D8TJJKTY8Mri/SmqsjAfBovhjNVO0J3QFN1HHmf8qy8axGH65t+svXWa58v
         BUlQ==
X-Gm-Message-State: AOAM531O5u1LMOdG7GwOZZNn6vZwyI1LtsKXHtqvoOnAN/wacRRdTvz7
        pYRtHjLnszMx8+FRdRoOh/uNeA==
X-Google-Smtp-Source: ABdhPJxJpa5gzfSyzonLKOeAhPe6n4QlorqfcbOtWa28voaFWTFtbrkhQvbHibqjpCMnoGlB62iB/w==
X-Received: by 2002:a17:90b:4f92:b0:1bf:25e2:f6af with SMTP id qe18-20020a17090b4f9200b001bf25e2f6afmr7931464pjb.98.1647398929987;
        Tue, 15 Mar 2022 19:48:49 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id j17-20020a634a51000000b00378f9c90e66sm616942pgl.39.2022.03.15.19.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 19:48:49 -0700 (PDT)
Date:   Wed, 16 Mar 2022 10:48:44 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org
Subject: Re: [PATCH -next] irqchip/irq-qcom-mpm: fix return value check in
 qcom_mpm_init()
Message-ID: <20220316024844.GA282154@dragon>
References: <20220316025100.1758413-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316025100.1758413-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 10:51:00AM +0800, Yang Yingliang wrote:
> If devm_platform_ioremap_resource() fails, it never returns
> NULL, replace NULL check with IS_ERR().
> 
> Fixes: a6199bb514d8 ("irqchip: Add Qualcomm MPM controller driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/irqchip/irq-qcom-mpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
> index eea5a753618c..d30614661eea 100644
> --- a/drivers/irqchip/irq-qcom-mpm.c
> +++ b/drivers/irqchip/irq-qcom-mpm.c
> @@ -375,7 +375,7 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>  	raw_spin_lock_init(&priv->lock);
>  
>  	priv->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (!priv->base)
> +	if (IS_ERR(priv->base))

Oops!  Thanks for the fixing!

Acked-by: Shawn Guo <shawn.guo@linaro.org>

>  		return PTR_ERR(priv->base);
>  
>  	for (i = 0; i < priv->reg_stride; i++) {
> -- 
> 2.25.1
> 
