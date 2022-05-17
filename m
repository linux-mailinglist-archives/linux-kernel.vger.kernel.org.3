Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0221752A1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346377AbiEQMsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346368AbiEQMsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:48:13 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BECD3FBE3;
        Tue, 17 May 2022 05:48:10 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i25-20020a9d6259000000b00605df9afea7so12091884otk.1;
        Tue, 17 May 2022 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NpzpNLoEmkRn/F6uE5+1oVZ1luFPE9xSZEAZD03pdY0=;
        b=FkMdQ424AFm5M4F/la9481PW4y7bKE4/auUO4eSkzUdj6YeDa8M2rjq1p7Wz54zNqr
         uG5FWhf2fZYePV8/u9/SktVm6eF9boZfRLzRJ2BwEbG4En9gXIyRyZ9q3S9gBnNtER2T
         nFHzne0bdnmApZ3G2LK41oGO2twG8y4iggio2J4i7SGwErgbAf0gujw0N8lhqsmGPatY
         pD4cyk/NA1pgU42CfDrTIMwt+sy2Iuyv18XldQm5QVQc1bt5bKrRhDKauzqg+WCzAcvO
         TAssoj5mHf3QOTg0VL2mlCCSWSN2Ohi8I64K8VOYbr/lu8QL1yczqBdVEUSCeH+aNJI+
         Ghew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NpzpNLoEmkRn/F6uE5+1oVZ1luFPE9xSZEAZD03pdY0=;
        b=7mtA49q5zkhom3fgWffwOz4KiaQI+/jBol2cLCTuFClD7OMzUD+KuA7GMEfz9WglSJ
         V3g1yDMfjQwPZ08W6Vdar+cy6s4asG/O45cszmHPAlAV+ynUjW5Gf4T0KywbgIpZXYrc
         IuSltj7uaj4R+SkY/Tjvsa2rM3rfm1O/6rNR/GtjIV00t6WLn5QuLwlS7k97HpRGmk6o
         sYSw7GE/WrirU56iIwGmuRMbKg1KUwbu7YL9ORSMxtAX93Hw3CQ9i8dwNpEZDPjoRTfD
         QbSOnXExm8zW4pjarcwCFcEuohIJSw9MBZmj28cbMlbaIgyNRO1orqoTQzeuJHhwKWME
         0U5A==
X-Gm-Message-State: AOAM530updsHCbjKzCUHYnMAX5nFeMWHsekVuq51PM674BmjJTSnkYOc
        kAhpWzpLd4/g0VK+O6+pOK4=
X-Google-Smtp-Source: ABdhPJzqHePQEq34dcSNWFfMU4S9Z3Cpk/nI2Y3MDxu6fdQnSRWoOAttAJVy0Os7wsFCy5CQ5TiuAg==
X-Received: by 2002:a05:6830:25cc:b0:5c9:5fc5:32b1 with SMTP id d12-20020a05683025cc00b005c95fc532b1mr7925519otu.138.1652791689934;
        Tue, 17 May 2022 05:48:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f22-20020a9d5e96000000b00606765d8db2sm4790749otl.77.2022.05.17.05.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:48:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 17 May 2022 05:48:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     keliu <liuke94@huawei.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: Directly use ida_alloc()/free()
Message-ID: <20220517124808.GA3438318@roeck-us.net>
References: <20220517063126.2142637-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517063126.2142637-1-liuke94@huawei.com>
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

On Tue, May 17, 2022 at 06:31:25AM +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/hwmon.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 22de7a9e7ba7..2e2cd79d89eb 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -764,7 +764,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  			 "hwmon: '%s' is not a valid name attribute, please fix\n",
>  			 name);
>  
> -	id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&hwmon_ida, GFP_KERNEL);
>  	if (id < 0)
>  		return ERR_PTR(id);
>  
> @@ -856,7 +856,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  free_hwmon:
>  	hwmon_dev_release(hdev);
>  ida_remove:
> -	ida_simple_remove(&hwmon_ida, id);
> +	ida_free(&hwmon_ida, id);
>  	return ERR_PTR(err);
>  }
>  
> @@ -968,7 +968,7 @@ void hwmon_device_unregister(struct device *dev)
>  
>  	if (likely(sscanf(dev_name(dev), HWMON_ID_FORMAT, &id) == 1)) {
>  		device_unregister(dev);
> -		ida_simple_remove(&hwmon_ida, id);
> +		ida_free(&hwmon_ida, id);
>  	} else
>  		dev_dbg(dev->parent,
>  			"hwmon_device_unregister() failed: bad class ID!\n");
