Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA365814BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbiGZOCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbiGZOCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:02:11 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D32E15FF6;
        Tue, 26 Jul 2022 07:02:10 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s204so17158432oif.5;
        Tue, 26 Jul 2022 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Rl6MVE3aMomkDjnvOIHumxd0JS/5JLNfbjl5fhr8vOY=;
        b=Icsi4QvSPFikvHEq8eo26Q80r+frOYeflQuqLiPA4s53ZENajUE6CcDI17C38XKRaL
         F28Rko7J1HCiDho0gMfGIgkHPuygOjGdRaxfbtcmzhazvjwsSgWq2qxcA3sPFNpj5BJ+
         rIF57ehAnnVw73X2N4ifGD8rk7fFM4naSaG+pZJ7cwpRXVqAFj3WQltACqRHzRryJy+Z
         vBwQjoojsxzs7lwK80RSsVoHZEkMLjk4OAss1yyueE1aIjpjzf3kRiFnjYnUzeKMSImM
         DJ7l1V08zQ7ufJBKJDAMt9aKyvTYjk/WLcdEvTn4MMgehh25hObLtREnPckzGQ8BnMVw
         747Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Rl6MVE3aMomkDjnvOIHumxd0JS/5JLNfbjl5fhr8vOY=;
        b=KBhCZiEA67JHRbG4avyvELoixZw/5LfiW9HXzzs/v5jnIeJDswxdK43t1dPD0NXDVJ
         2vqVMCIXxMr+5org45+yR+0l3wMFnNCKFQw81G0vKNG1fAm+TU/Np5rpYm48x2fDeJEh
         ISKdOwPwxAq+ibBoU8ymOOOSma38pQD8dul/UIQMmey6pR17zvK/UKzA6zYZIR+BeySY
         zFerwB/ilzP/2EYQ3eDPw+nkw68ogcuY5A1+F12Z0Z4pRzJ/iXvMO+zwM2Syfn/TJQ3b
         F/8CciTpkcnAAkqWYjJaGLizUDe/fMPKlIZnfMOpTOCg5B9LsuQdwqkLw2pmZsVN2tM/
         UV7Q==
X-Gm-Message-State: AJIora+5vq29PKL4tRMwL2jHhcAvXsQknvYD5Tc21bGxsXF9yyiKzeTl
        6IyX5dG05KuDovKGyae6YBYrj3KiUmNA0g==
X-Google-Smtp-Source: AGRyM1uZTmbtncnEqSUIZx10k2gMkE6ccOrEFKt54pdLLktvZwzflWZVQTCVmvcHN6atG8a43beL3g==
X-Received: by 2002:aca:1b0b:0:b0:33a:98d8:cd3d with SMTP id b11-20020aca1b0b000000b0033a98d8cd3dmr14370304oib.265.1658844129155;
        Tue, 26 Jul 2022 07:02:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u189-20020acaabc6000000b003263cf0f282sm6027511oie.26.2022.07.26.07.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:02:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Jul 2022 07:02:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] hwmon: sht15: Fix wrong assumptions in device remove
 callback
Message-ID: <20220726140207.GA4117654@roeck-us.net>
References: <20220725194344.150098-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725194344.150098-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 09:43:44PM +0200, Uwe Kleine-König wrote:
> Taking a lock at the beginning of .remove() doesn't prevent new readers.
> With the existing approach it can happen, that a read occurs just when
> the lock was taken blocking the reader until the lock is released at the
> end of the remove callback which then accessed *data that is already
> freed then.
> 
> To actually fix this problem the hwmon core needs some adaption. Until
> this is implemented take the optimistic approach of assuming that all
> readers are gone after hwmon_device_unregister() and
> sysfs_remove_group() as most other drivers do. (And once the core
> implements that, taking the lock would deadlock.)
> 
> So drop the lock, move the reset to after device unregistration to keep
> the device in a workable state until it's deregistered. Also add a error
> message in case the reset fails and return 0 anyhow. (Returning an error
> code, doesn't stop the platform device unregistration and only results
> in a little helpful error message before the devm cleanup handlers are
> called.)
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied.

Thanks,
Guenter

> ---
> Hello,
> 
> the motivation for this patch is to fix the driver to not return an
> error code in .remove(). The long term goal is to make remove callbacks
> return void as returning an error is nearly always wrong and doesn't
> have the effect that driver authors think it has. This patch is a
> preparation for this conversion.
> 
> Best regards
> Uwe
> 
>  drivers/hwmon/sht15.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> index 7f4a63959730..ae4d14257a11 100644
> --- a/drivers/hwmon/sht15.c
> +++ b/drivers/hwmon/sht15.c
> @@ -1020,25 +1020,20 @@ static int sht15_probe(struct platform_device *pdev)
>  static int sht15_remove(struct platform_device *pdev)
>  {
>  	struct sht15_data *data = platform_get_drvdata(pdev);
> +	int ret;
>  
> -	/*
> -	 * Make sure any reads from the device are done and
> -	 * prevent new ones beginning
> -	 */
> -	mutex_lock(&data->read_lock);
> -	if (sht15_soft_reset(data)) {
> -		mutex_unlock(&data->read_lock);
> -		return -EFAULT;
> -	}
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);
> +
> +	ret = sht15_soft_reset(data);
> +	if (ret)
> +		dev_err(&pdev->dev, "Failed to reset device (%pe)\n", ERR_PTR(ret));
> +
>  	if (!IS_ERR(data->reg)) {
>  		regulator_unregister_notifier(data->reg, &data->nb);
>  		regulator_disable(data->reg);
>  	}
>  
> -	mutex_unlock(&data->read_lock);
> -
>  	return 0;
>  }
>  
