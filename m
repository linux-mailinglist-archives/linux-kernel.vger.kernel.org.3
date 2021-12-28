Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DBC480B12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhL1QGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbhL1QGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:06:14 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2071EC061574;
        Tue, 28 Dec 2021 08:06:14 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id w7so9937577oiw.0;
        Tue, 28 Dec 2021 08:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qatF57jpU+SCdFsFak5TocjA6SmuzgsHZB8nddmDgyI=;
        b=HMQq4QUPCUmpBoElYxK0iKmL4nb9IjRdsjsYfspvm+2y3hH3BJ0t2vb9dVydSNk4lz
         2edhKjNTwFN8edacMg1Q21r57DofAoXh1c05UT/EYTP+atXEIfjHjq5VCd5EMUjSBlmj
         qRfkkBJdQUIlVZDrgJN0XuY1+ZVVQRr6px5yTh0dil975zybX5Ok+1m+WAs0d2qYn7XF
         WIonsuCKhlUKZh4OcL2d9HCg3REwVdkKk3qRi9OI8iXKCuIrFXtw61Kh5tavg2o3Glfd
         mLzoFFItNE1MnkkW6FyOojCVORBU/+lbsc0EfgEZhkUTBffqu78HSdYpvSe07Mtsfh8B
         sPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qatF57jpU+SCdFsFak5TocjA6SmuzgsHZB8nddmDgyI=;
        b=bLzJ5W2GV+UjoPnWHlodIkVSJb2gNqpswI2K2DT5fbbq82dmJzSOKoxijggyqmM8k9
         YeZuy7YWv8fhjfzSTu2YOo03qCwzaOMxJ2iV/UlFxQ5MsgLVjyh8v66VOAwVtfnXF8pM
         zGKeRDVuGzeyeNw4DA44IYcKyBVpKATCgyYc3C8q4Mie+/0Z9N10piWzhZlO/Z9hSspA
         VCa4uxugQC7AuFfwPmdzpxdbdgt/3DvtMeacXK58TBJrnD9Qwt7RhZQoq3Ue/8OoEiSW
         0vE6Rbr/XibpWOCPeMy7bgCR2HzR2UW16lAj7mHWkCE+MHyUe37j8eQQHq+ykLQ3zuQ8
         bTrQ==
X-Gm-Message-State: AOAM532YgauUOhM/ztMOXPcY4tc3ZI3P8CREBkMt6JFmatfnGlDwtfnb
        hTOUOTUxZtwqJJs/54MMEGDuS/F1kjY=
X-Google-Smtp-Source: ABdhPJwSgbGrG3P6bD5wS8Q8ezsGwLrD4WLYAOPi8AltXOEYGkoC4HPpcUhn+mEu95A9FbuUPbKQxg==
X-Received: by 2002:aca:3148:: with SMTP id x69mr15651323oix.95.1640707573315;
        Tue, 28 Dec 2021 08:06:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t31sm3669197oiw.30.2021.12.28.08.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 08:06:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] watchdog: msc313e: Check if the WDT was running at boot
To:     Daniel Palmer <daniel@0x0f.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org
Cc:     romain.perier@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211228073427.2443174-1-daniel@0x0f.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1f60c5ac-b262-2b8f-6bf1-c1c7f2b20699@roeck-us.net>
Date:   Tue, 28 Dec 2021 08:06:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211228073427.2443174-1-daniel@0x0f.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 11:34 PM, Daniel Palmer wrote:
> Check if the WDT was running at boot and set the running
> flag if it was. This prevents the system from getting
> rebooted if the userland daemon doesn't take over soon enough
> or there isn't a userland daemon at all.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/msc313e_wdt.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
> index 0d497aa0fb7d..90171431fc59 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -120,6 +120,10 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
>   	priv->wdev.max_timeout = U32_MAX / clk_get_rate(priv->clk);
>   	priv->wdev.timeout = MSC313E_WDT_DEFAULT_TIMEOUT;
>   
> +	/* If the period is non-zero the WDT is running */
> +	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT_MAX_PRD_H) << 16))
> +		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
> +
>   	watchdog_set_drvdata(&priv->wdev, priv);
>   
>   	watchdog_init_timeout(&priv->wdev, timeout, dev);
> 

