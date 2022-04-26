Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0715100D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbiDZOr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiDZOr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:47:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886FD377FD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:44:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so1698114wmn.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2ZqGkETvEtXhWv+2nhNMHUqNOd0wQzvX0go9oa2PkjM=;
        b=sCQwd1euImCjwuDYwMBUhtygOnGIpMVSR6mjS5LsN2JoYnD4R6Y5H1J1cDhlTmWYFb
         iadPuQX7Pu6pl+t9ysee3qGpjerXOTQ1Nh5nX0nAa1OF1ZPbpeZ0D44SisqcDfnpCbYh
         u+sh8LZ+XmbNvPO/Vj1QWc6ImRR+AeJYju1TfucXetYxvYTLgQDb6Xwh1/rZdBfhSMKl
         QBw5pPsR5bHm4PIiMgTNqHB6NzNnrnkwJOr45FCnAgeNSdqkai4E6R9w4R1LHtDAuDKb
         i150mrd4Ha8Q6m1SNn0uno2geM+fA1+2kOdtWTydiyQmcz9/CMr4Ax4txi4/QKqtLnJ5
         3quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2ZqGkETvEtXhWv+2nhNMHUqNOd0wQzvX0go9oa2PkjM=;
        b=g1Hb6V6meYpenVUnmt8KN6CSi98XjwOKRbUZ6ZVMLRkt4gm/sHi04yHkSkYMZaqAIB
         Am2LKL+EDqp2+/glrNtsqiHsizorOdls9iPC30TxOqFgNCVV8YD23at93n1RBVUKc5pg
         dqHzC/yI8U+dnrSb4mCtedw1d3PJI9E6QGoPhqPjVRLJl9hvYV0wzyTXF2AmiDXEeP8W
         bkqc/pY5bhuPy8LNF7STi5eZ4IMHHmtap3aw0Gmd7H5UudKWywLLhXfivanziD3QS1ce
         x2GRlqtUp1T1g+nnDVz5GDjfSoyo1qrHNk4+A1qTB1Cv4u68E5xLvNA5nt/M8/wHwwQm
         1cWg==
X-Gm-Message-State: AOAM532iHbuBIGQsLS+5k0muKT6+ogaLz0YoCGmt4JaQvZrjtFPckKgS
        TZJfw9aNDNkWK3dBtGRk8Ld7fQ==
X-Google-Smtp-Source: ABdhPJz5tau/8V/DmFS+tD504POLe+3zrMF4WPcijnPlwUmPdKmc7mXFiVcBlwVQqe8KjG/LcLL2Lw==
X-Received: by 2002:a1c:acc4:0:b0:392:9dd4:fbcc with SMTP id v187-20020a1cacc4000000b003929dd4fbccmr21103737wme.78.1650984287132;
        Tue, 26 Apr 2022 07:44:47 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f66-20020a1c3845000000b00393e84ea043sm6897855wma.44.2022.04.26.07.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:44:46 -0700 (PDT)
Date:   Tue, 26 Apr 2022 15:44:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sprd: Add SC2730 PMIC to SPI device ID table
Message-ID: <YmgFXLAGDlQe4LZ4@google.com>
References: <20220425132410.2708304-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425132410.2708304-1-gengcixi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022, Cixi Geng wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Add the SC2730 PMIC support for module autoloading
> through SPI modalises.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index 55d2c31bdfb2..cf4f89114ae4 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -248,6 +248,7 @@ MODULE_DEVICE_TABLE(of, sprd_pmic_match);
>  
>  static const struct spi_device_id sprd_pmic_spi_ids[] = {
>  	{ .name = "sc2731", .driver_data = (unsigned long)&sc2731_data },
> +	{ .name = "sc2730", .driver_data = (unsigned long)&sc2730_data },

Nicer if these were ordered with the smallest number at the top.

>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, sprd_pmic_spi_ids);

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
