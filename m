Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCDE532178
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiEXDJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 23:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiEXDJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 23:09:45 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AC77982D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 20:09:44 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id p12-20020a9d4e0c000000b00606b40860a3so11488749otf.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 20:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=e78CQNC1uLghZYWcbbPHutK66WvbanuXJwmFqteb1s4=;
        b=iUEAQ7t+MzmWZIOqEgsZEt/tFkWtr3CHA8vwzOtwWXQQLBSJSNryrVL2oPl52EXnVD
         B7Iv15EpUPNoylcGiGFDBtyMV5ckl65s8go5La0BAJICLgJL+OgJKuW5mPLlbh7orpq2
         1nWLTOJuGoy8vf2nBe2Gmxcqj+L4n5/2XZYVWNSoqPSOUshbxqPFZqEth1/Smd3Yd69c
         4KQJMU/2rgGsXarWPZ7lSciUa1zcAGnYP0jipB3lxEBGlXFd68Wo+OLhDfkw2ju8o3+E
         SsK3MetrTf/lscxl4C5FJaa4rYzO9NES2TRv0IOmdtFz7lyN9qnfMSZOEUGd3fxmxPV4
         Rspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=e78CQNC1uLghZYWcbbPHutK66WvbanuXJwmFqteb1s4=;
        b=wuB82WMVEqaCNTcIA59Svk0oa38V/9OGL1FqyvtvdVBRxzDbdhQw8vXAyBTlsjHcmN
         dc66g2QTv3/E2lav3QsBup/DyWQGddn6fcK6fLFeK2VFMH7OinfLLyYxhl3+L8EGPYvT
         CHa+0EEyY/UrF4b5CZdri3goFo81wp43E6kqIZvZerLV7ipnAYvlKCsWJaQUPvtjHlX9
         /MELq80bQfbL3fRA4mSxd1zcGQLENdm27nTb2mMLAAAob8ohqO5pX8+CL0/bp0DfvQhz
         JTKQlvX6xANOC/HoHAi1wGAFKlMQUosaLaPwOKtupmkfOj9q+NNvVNqQ7noEVjdK3wQK
         5nEg==
X-Gm-Message-State: AOAM5336ZB3YEGTgTXSkj4vHbbJQZwIlgrYNY+6XmI6kj6Z4X/vfy+Qz
        VVQ1ROc7FeCNZnS+iOzCJz8=
X-Google-Smtp-Source: ABdhPJwmyK2n3K7H/Hz34hFIlmTZ7eGhntFkJtsvA1oy/6srCB2NxsocgcB8SEaZlq5pvOh+YrGeQw==
X-Received: by 2002:a05:6830:25d0:b0:606:f15f:e3f1 with SMTP id d16-20020a05683025d000b00606f15fe3f1mr9833526otu.369.1653361783622;
        Mon, 23 May 2022 20:09:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o7-20020a4abe87000000b0035eb4e5a6c0sm4869517oop.22.2022.05.23.20.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 20:09:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 23 May 2022 20:09:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh@kernel.org
Subject: Re: [PATCH] amba: fix refcount underflow if amba_device_add() fails
Message-ID: <20220524030941.GA290608@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 10:51:39AM +0800, Kefeng Wang wrote:
> "ARM: 9192/1: amba: fix memory leak in amba_device_try_add()" leads
> to a refcount underflow if amba_device_add() fails, which called by
> of_amba_device_create(), the of_amba_device_create() already exists
> the error handling, so amba_put_device() only need to be added into
> amba_deferred_retry().
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
>  drivers/amba/bus.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 0e3ed5eb367b..0cb20324da16 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -493,13 +493,8 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>  		goto skip_probe;
>  
>  	ret = amba_read_periphid(dev);
> -	if (ret) {
> -		if (ret != -EPROBE_DEFER) {
> -			amba_device_put(dev);
> -			goto err_out;
> -		}
> +	if (ret)
>  		goto err_release;
> -	}
>  
>  skip_probe:
>  	ret = device_add(&dev->dev);
> @@ -546,6 +541,7 @@ static int amba_deferred_retry(void)
>  			continue;
>  
>  		list_del_init(&ddev->node);
> +		amba_device_put(ddev->dev);
>  		kfree(ddev);
>  	}
>  
> -- 
> 2.35.3
> 
