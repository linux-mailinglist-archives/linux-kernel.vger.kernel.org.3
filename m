Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DF95379B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbiE3LWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiE3LWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:22:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A4D3EBB4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:22:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n10so20211677ejk.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VZHUKR0IHFYL6ayBsErLDOGwzJgu/d6jiiX5vyOAisk=;
        b=mmUekXcDdIYDwa8P28lVVVA4ROxj0K0LQApMxt/O+OwKivkZoQhq25Iewy6XW4NSDK
         SaC8x5h8gNzwDgGqVmkguXtzuFnYy1vreELcw8s/HudqCmc0NysaQX8pRnjBzHBUnyD0
         x+ydUgrdKKFvwQ5k2nfwVM9br5ezdckE2ddT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VZHUKR0IHFYL6ayBsErLDOGwzJgu/d6jiiX5vyOAisk=;
        b=7xVxOUrEl605zc3aWu7OJrUJnFPK/Nmy+6nC8zSsQqIQ025++pZeI1xu0cN/O2I2BI
         c/J40b/F6g2BsgLVdsCjmrHAClg/OlzLjvj7uWAEatcEzgfM2TxS0Rigg1q43J2+3jy9
         4JDZ571PWfd8SV+pIp17XEtmvofQ1n7ks2mk7oapZoyZmiQ7Pj8Mu6spu03kdUeCzPxh
         yGyS8tFR5zGce6X7RxiHJg489rXTL3G0lcajYXNbCSuWqfjSWWuDJv9Ns2RRu9vkvQ+t
         Q4NkPnVYUoL4DwbyykgAX+pzYR/Pa6hg1JuRg0MA9z+iUH+kXHzX30ZxyMqITtGszKJJ
         eFLg==
X-Gm-Message-State: AOAM532v2yTIfbtX2AFpfbiTiQmAYZxxFu1Wt8X1we/v7pfXWEvx9iFt
        kHynszoQuc0LVMnLtws19O/Axg==
X-Google-Smtp-Source: ABdhPJwJfyWVmxcwcnbxwax6buYE4Db4h473DEuVne798zPPEEF10yoIJqDMpJr3tb9Vmq0YXzQIMQ==
X-Received: by 2002:a17:907:9895:b0:6fe:991e:efe3 with SMTP id ja21-20020a170907989500b006fe991eefe3mr47246097ejc.74.1653909756465;
        Mon, 30 May 2022 04:22:36 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-2-39-143-183.cust.vodafonedsl.it. [2.39.143.183])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090646cb00b006fee7b400e6sm3807355ejs.111.2022.05.30.04.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:22:35 -0700 (PDT)
Date:   Mon, 30 May 2022 13:22:32 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: atomisp-mt9m114: Fix pointer dereferenced before
 checking
Message-ID: <20220530112232.GB99280@tom-ThinkPad-T14s-Gen-2i>
References: <1653897481-25681-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653897481-25681-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 03:58:01PM +0800, Haowen Bai wrote:
> The info->data is dereferencing before null checking, so move
> it after checking.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> index 00d6842c07d6..3c81ab73cdae 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> @@ -616,13 +616,15 @@ static int mt9m114_get_intg_factor(struct i2c_client *client,
>  				   struct camera_mipi_info *info,
>  				   const struct mt9m114_res_struct *res)
>  {
> -	struct atomisp_sensor_mode_data *buf = &info->data;
> +	struct atomisp_sensor_mode_data *buf;
>  	u32 reg_val;
>  	int ret;
>  
>  	if (!info)
>  		return -EINVAL;
>  
> +	buf = &info->data;
> +
>  	ret =  mt9m114_read_reg(client, MISENSOR_32BIT,
>  				REG_PIXEL_CLK, &reg_val);
>  	if (ret)
> -- 
> 2.7.4
> 

Hi Haowen,
Looks good to me, thanks.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
