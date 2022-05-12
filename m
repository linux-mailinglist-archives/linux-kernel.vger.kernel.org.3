Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F612524A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352596AbiELKZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352590AbiELKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:25:14 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0A1F0DE3;
        Thu, 12 May 2022 03:25:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l11so4177599pgt.13;
        Thu, 12 May 2022 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B0z70l/EHNI185diYCy/yAUimxq5OV5uwPx43q+AZpw=;
        b=lhuwnemmB/jSGn/ychoOsz2uOa4iOM5tHhVl7yscl2ciw6+64DwsL+Xgh35okGS2ov
         40IAupoRiU6nbD+BL6OWhSyw+KCNR+XTCeR0urc0is1OS9cG+m4p2dCiT0kFSLCzZ8Lg
         yDdtCAhTbXNgbJrYRPfVskrRWqVP5GjK092z7GWrT3nPydkvQKOFUoKr/c7QytotLtQp
         /5WpbjPZJkAZzWypCQqXqu4Ku3yPPCWBUG9NWkQ0b6TGSCmTJdIpT+sN1ufEogwwjoQL
         1stN2mFW2RgzCknPjAYJteruOz653xn0llTpGf8T7DafdU8lBRqgW8MqAEzXop8oxzTi
         ryIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B0z70l/EHNI185diYCy/yAUimxq5OV5uwPx43q+AZpw=;
        b=XAFQpytnttNhLaOV+Dt5a8Bj8JLrE+Y3hjaW7ozbz2llZ73CgV96/tKSxNsJo7Nj2S
         PkLcXyRwqWneMDy+BZnTo2hDx/+ii2+E7f50yfNjoe/VqzMkZBNs5heRjuaLF9B20sKn
         ghRDqb0mq3iMDvHQ7n6eGGozcHqQrjdDIv9ModLrV+OBf/X+EN/Tnir3oSV6Z8m2GMSY
         XMam2Kr4i+l7JXtczSNI0WeGn1Uuzz7feTSxvw1wVSZKMs1Fv9OLBOnkdmZHHahBlm7T
         axecHTtEjAH8XwKy4+jz5KSw6D1gyaREUAmKPvym/j/VIm4QwzJlCO2CN4nwkIayHnU1
         uWQQ==
X-Gm-Message-State: AOAM533jn6KDdoEbaoxYTJ4T41DxC3avvdcIv9W7J3EKH5W9BP8mKlgN
        o4jqOZ9oNU0K02xt7y6P8pBwaHlWvn8rWQ==
X-Google-Smtp-Source: ABdhPJymMEFui5zPZPg28ynCFM42DId6/wOlFRUPq9Z8+E/B9p2zNbfubQ8MFNob9O+vdZN3nL4V1A==
X-Received: by 2002:a05:6a00:248d:b0:510:5d7d:18ab with SMTP id c13-20020a056a00248d00b005105d7d18abmr28783890pfv.51.1652351113560;
        Thu, 12 May 2022 03:25:13 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ad76:8fc:e2ba:172])
        by smtp.gmail.com with ESMTPSA id be12-20020a170902aa0c00b0015e8d4eb1e4sm3595969plb.46.2022.05.12.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:25:12 -0700 (PDT)
Date:   Thu, 12 May 2022 03:25:10 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     cgel.zte@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] Input: simplify the return expression of
 da9034_touch_probe()
Message-ID: <Ynzghmx1CkJSRVpN@google.com>
References: <20220429055300.3852396-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429055300.3852396-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 05:53:00AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/input/touchscreen/da9034-ts.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/da9034-ts.c b/drivers/input/touchscreen/da9034-ts.c
> index 2943f6a58388..dfb2604381d2 100644
> --- a/drivers/input/touchscreen/da9034-ts.c
> +++ b/drivers/input/touchscreen/da9034-ts.c
> @@ -298,7 +298,6 @@ static int da9034_touch_probe(struct platform_device *pdev)
>  	struct da9034_touch_pdata *pdata = dev_get_platdata(&pdev->dev);
>  	struct da9034_touch *touch;
>  	struct input_dev *input_dev;
> -	int error;
>  
>  	touch = devm_kzalloc(&pdev->dev, sizeof(struct da9034_touch),
>  			     GFP_KERNEL);
> @@ -344,11 +343,7 @@ static int da9034_touch_probe(struct platform_device *pdev)
>  	touch->input_dev = input_dev;
>  	input_set_drvdata(input_dev, touch);
>  
> -	error = input_register_device(input_dev);
> -	if (error)
> -		return error;
> -
> -	return 0;
> +	return input_register_device(input_dev);

In cases where there are multiple checks/exit paths in the same function
I prefer the existing style as it requires less changes when extending.

Thanks,

-- 
Dmitry
