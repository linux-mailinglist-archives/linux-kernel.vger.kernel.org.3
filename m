Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095F547C386
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbhLUQJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239498AbhLUQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:09:02 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E15C061574;
        Tue, 21 Dec 2021 08:09:02 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id v22-20020a9d4e96000000b005799790cf0bso4720106otk.5;
        Tue, 21 Dec 2021 08:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i/peC/Cg7dwfJK3Tu9ie4F9EPKhlVGPQSGQJFHbXFxs=;
        b=inN65pOqgxQ5wY8vnXA2qIuyBP+fTPsocbE8v4UPhPPQhQe2KXu6QQGF5hpXCo2XMV
         Gi8WXqjzS4Tzh6BddOS8f7ibOIBFB9yvuC/NGds6dM3W1SzYGthHoaUajux7C5x8bwHA
         0HKULHLHu0s6N70tNNGYeVc8WS5/WsxUDRvCEHR8jd04rdXaFJ0dHlPri5WM8LZK5Wo+
         QG1VqaYDSrLTGm5CIZCnCzeACWIYkUj1pgPu9jf7kv9Ahp4oEa9fZHSxrGlE5aZfwSZo
         jkh2U5AUJxgzeHyFl9WdEG/kVshe9iTh8c3O9+Je90QZ6uejE+qo3XbB1BxmUVKUNcdh
         3lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i/peC/Cg7dwfJK3Tu9ie4F9EPKhlVGPQSGQJFHbXFxs=;
        b=qU1ViMhq8pJXa+0ywlz20MVos+flFhPRaCtAcqUw/yM8KOql9xTcU4p7jb3kfBMV0q
         X/Sh9vSw8OQtOkmKGDIziYLH7sqIn+HBMxxdO7syUCBoaxTVXr5yPSH+IGqhPdRIgrLb
         FYw9kbLIhbYlGRFDWbMY0uUb2IFiLN1HINKNwpJoOsG0q1HnUPYOv73p4bVs7OdPJw9f
         R8UPoZHdaQd5q2FjwwFrpFAqlr6/FVTvQT87drgW43JYSClQspIDwWDkqjzW/BHZ7mHv
         QMxinx5ff5cFv1L6H4U6PjG4ofIqKMlreMoTR+lsLavpejlw1R3WPNfa3DRWH+CnQ0se
         nV/Q==
X-Gm-Message-State: AOAM532SKmX5LQ8ZrHY4Yc6/RZocQh7gO/23UI3MHEpEGVtLM5+qLDTj
        w6/p3bSh43suY4O5pPHN7iCAD+Q65og=
X-Google-Smtp-Source: ABdhPJyNhDjuYoRCMItZZHobOSSmR+1sxjpBnjjQF01bP8c9M4LmgLwX+PJ3xhk8sWagsWEga2m9cg==
X-Received: by 2002:a05:6830:1605:: with SMTP id g5mr2814511otr.46.1640102941534;
        Tue, 21 Dec 2021 08:09:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w18sm3761656otm.1.2021.12.21.08.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 08:09:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1 03/10] hwmon: adt7x10: use devm_request_threaded_irq
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221123944.2683245-1-demonsingur@gmail.com>
 <20211221123944.2683245-3-demonsingur@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <82012996-b266-873a-699a-26d77bcb7e5a@roeck-us.net>
Date:   Tue, 21 Dec 2021 08:08:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221123944.2683245-3-demonsingur@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 4:39 AM, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> To simplify the core driver remove function.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>   drivers/hwmon/adt7x10.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
> index dbe9f1ad7db0..48adc0344e88 100644
> --- a/drivers/hwmon/adt7x10.c
> +++ b/drivers/hwmon/adt7x10.c
> @@ -402,9 +402,11 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>   	}
>   
>   	if (irq > 0) {
> -		ret = request_threaded_irq(irq, NULL, adt7x10_irq_handler,
> -				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				dev_name(dev), dev);
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						adt7x10_irq_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						dev_name(dev), dev);
>   		if (ret)
>   			goto exit_hwmon_device_unregister;
>   	}
> @@ -425,9 +427,6 @@ void adt7x10_remove(struct device *dev, int irq)
>   {
>   	struct adt7x10_data *data = dev_get_drvdata(dev);
>   
> -	if (irq > 0)
> -		free_irq(irq, dev);
> -
>   	hwmon_device_unregister(data->hwmon_dev);
>   	sysfs_remove_group(&dev->kobj, &adt7x10_group);
>   	if (data->oldconfig != data->config)
> 

This will keep the interrupt running after the hwmon device was removed,
and after the configuration was restored. If an interrupt occurs at that time,
the handler may potentially access released data. I don't mind making those
changes, but the patches will have to be well sequenced to ensure that each
patch on its own doesn't leave a crippled driver behind. Again, "oh, this will
be ok after the entire series was applied" is not acceptable.

Thanks,
Guenter
