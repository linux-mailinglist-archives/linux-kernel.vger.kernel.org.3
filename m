Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A7B480B10
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhL1QFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbhL1QFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:05:21 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E8BC061574;
        Tue, 28 Dec 2021 08:05:21 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id x10so25777795oix.6;
        Tue, 28 Dec 2021 08:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=edFmYLVLoIcO5y9TQGcs1+dT+JVGzn5+Fzz27dqEWq4=;
        b=X7gH8JNSqvAYo0jWSj8DC4t4ETN+QBuSb9DoNXF9r9JMMEQ6OK/E/2a281SVbpIfeR
         JBZa5be2x2gDoBTYiY2w+Y5UREja/I/Sl3Vna1sIE/erFtUtEqWllo8xaCzTkTb8L1Ss
         QX8HLJr5bwLG/vNWjnOK9IGPAfNDD25nWdBRCiMCvMV+HSWO/zc7su906CiHF46UDr4v
         wzkx6YitGWTsTw/OF6U/tGxI2s4wZBQEnWWe/2p73xp3xJvXsBwX93njNl+dvABpH7Qp
         tI0D5knZeySTLlBZ76e57aCc+NmB1ALuEc4D2JGE9g88H/LBvHq4AxHi0pZraaXLBcOd
         Tiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=edFmYLVLoIcO5y9TQGcs1+dT+JVGzn5+Fzz27dqEWq4=;
        b=CvcCPfpJwlH7NVBW0iB96Jkawuq0jZ9Ov98ik9zJYHfPyZv/gSqSP9fEzdf7P95BJW
         03857qyilEI+RGbtG2m86494lk4v2zQW6dFLx/kox9svr9N0A4XosweU1EBO9B/TwXS8
         LNUGb9gSzq/6waskkhyCnGYwqV7kDVUKdEB3AmIkOSy0tsJsUCuoNgPpMCIWTtSnB67h
         CRaA6+OwvbQ9SGiIj9u/qNVwMbR7c04Igt96jk/JZOKLwBdwQj+mfYHr3MlOn0Hnjm47
         tRs99+5UScHYQAwUeiQnp1I4crebors1XBuPMAlarDHoDF3Q5zWmAMlWR2FTeARIWNZh
         rfWA==
X-Gm-Message-State: AOAM5316+9E4ZPGqG3zggK7YbSGIFZ3IQg6fLiSBB4hV2pofjqMrSrZ0
        Qhx7ppyy34BKxdzRnInXRm0Z9ivPqu0=
X-Google-Smtp-Source: ABdhPJz/ifnr2BF+quj9AajZCnZVxmq7lWjYZWHEH5vr9C7TDyjmuQFmNCV8zcJHfQIy6dtCVA0+6w==
X-Received: by 2002:a05:6808:1509:: with SMTP id u9mr16608239oiw.4.1640707520674;
        Tue, 28 Dec 2021 08:05:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r37sm3408754otv.54.2021.12.28.08.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:05:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Dec 2021 08:05:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peiwei Hu <jlu.hpw@foxmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] hwmon: add free before exiting xgene_hwmon_probe
Message-ID: <20211228160518.GA1183124@roeck-us.net>
References: <tencent_C851C0324431466CBC22D60C5C6AC4A8E808@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C851C0324431466CBC22D60C5C6AC4A8E808@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 04:59:10PM +0800, Peiwei Hu wrote:
> do kfifo_free(&ctx->async_msg_fifo) before error exiting
> instead of returning directly.
> 

Applied, but please reference the driver in the subject line
of future patches.

Guenter

> Signed-off-by: Peiwei Hu <jlu.hpw@foxmail.com>
> ---
>  drivers/hwmon/xgene-hwmon.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
> index 30aae8642069..5cde837bfd09 100644
> --- a/drivers/hwmon/xgene-hwmon.c
> +++ b/drivers/hwmon/xgene-hwmon.c
> @@ -659,8 +659,10 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
>  
>  		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
>  					    &pdev->dev);
> -		if (!acpi_id)
> -			return -EINVAL;
> +		if (!acpi_id) {
> +			rc = -EINVAL;
> +			goto out_mbox_free;
> +		}
>  
>  		version = (int)acpi_id->driver_data;
>  
