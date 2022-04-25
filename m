Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A64C50D7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbiDYEDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbiDYECc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:02:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE2835DEC;
        Sun, 24 Apr 2022 20:59:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j8so24172372pll.11;
        Sun, 24 Apr 2022 20:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=560ZyjDjMjw/eukwNXu0xmzkhr36IsOK1UcMliQ6ixc=;
        b=prb9unJJzjMB0mP9+M1FA3lUC7YakIWgMe7cz6wtisEGlAZ4W/UuGfIR/krAV0qFCo
         efB88t2a18IQSEgzl2Fq0IF31F5wCiRqsBJ3v4zGnqN1ZCxucEFdqjR+l58YQw+VmFw9
         fdqVgbyQIhBYe6/oQSpS3qVFtMnQpBXouJbZJ/77qHalJUupcRNzhG7HsocUZY0Dntem
         g+EdHc+F64NmfgCc9cPHHrc/SO8U45jmIOPqzYx5/kCAKIl3o1a4sWM0GtMEcT5P6bXc
         lIHe/c3u1YeWpxNhYikhEsnG5wHSiqAVTArFzjH4RYEHQ+MBh4xWWIe30D7o4L85I6sR
         QdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=560ZyjDjMjw/eukwNXu0xmzkhr36IsOK1UcMliQ6ixc=;
        b=JQpF8WugbT41B1sdNdyhBA/qAyxw4pZo2Mi4ESxA99mc11vTYYdJQQqL6aVFYW/8kq
         doUFAKR0v3DS2xDxUhLspUqDlWf3OQjuOD1XnkhA+REYgHfd5Z3leSZszDALo4YkcjLO
         BapcE5ge63vs7lPWmNZkLKQ6mE/3lhRrzpH+fWaucokcyAwHfw6dvRvlu8Dci6ibKKWq
         97Y//yIROxB+RAk2Aw2P8v1BYgvSJxLGxllg00iNW7Zgv3oJVI6ldYEIUbYIwD9Pxh/3
         empPuWPBPDxx+JZUsOP0pQUQaQE1uTMMm0TZEz+rYFaGIJJ5Pr86zHcDSbkNAA9hACTW
         1c3g==
X-Gm-Message-State: AOAM5315w4yl8XzNwJczEmoEDPTYi1XIuBY+5SJlUgHHSsUE0iDOlFnw
        P3nbKkwzxyXAPMseYHJ9NbA=
X-Google-Smtp-Source: ABdhPJxymPMSMsVhlIAj5Ciak9kOFIqoLkksDgND3qhOb2ScEzBn83mdGxCMXvRU32+KSGX0rgDmNw==
X-Received: by 2002:a17:902:7009:b0:158:3bcf:b774 with SMTP id y9-20020a170902700900b001583bcfb774mr15946121plk.103.1650859167020;
        Sun, 24 Apr 2022 20:59:27 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id c2-20020aa781c2000000b0050a7ff01d2bsm9431985pfn.30.2022.04.24.20.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 20:59:25 -0700 (PDT)
Date:   Sun, 24 Apr 2022 20:59:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Ondrej Jirman <x@xff.cz>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v5] Input: sun4i-lradc-keys - Add wakeup support
Message-ID: <YmYcm3usaDNCi30s@google.com>
References: <20220424161328.61103-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424161328.61103-1-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 11:13:27AM -0500, Samuel Holland wrote:
> From: Ondrej Jirman <x@xff.cz>
> 
> Allow the driver to wake the system on key press if the "wakeup-source"
> property is provided in the device tree. Using the LRADC as a wakeup
> source requires keeping the AVCC domain active during sleep. Since this
> has a nontrivial impact on power consumption (sometimes doubling it),
> disable the LRADC wakeup source by default.
> 
> Signed-off-by: Ondrej Jirman <x@xff.cz>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v5:
>   - Fix typo in commit subject
>   - Update Ondrej's e-mail address per his request
> 
> Changes in v4:
>   - Only mark device as wakeup capable if setting the wakeirq succeeds
>   - An entirely different, but equivalent, DT binding patch was merged,
>     so there is only one patch left
> 
> Changes in v3:
>   - Dropped unnecessary pr_err in platform_get_irq() error path
>   - Dropped patch 3 (DT update) as it was merged
>   - Added Acked-by/Reviewed-by tags
> 
> Changes in v2:
>   - Add requisite DT binding change
>   - Only add wakeup capability if "wakeup-source" is present
>   - Warn but do not error out if setting the wake IRQ fails
>   - Add "wakeup-source" property to PinePhone device tree
> 
>  drivers/input/keyboard/sun4i-lradc-keys.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
> index 4a796bed48ac..781f9b053115 100644
> --- a/drivers/input/keyboard/sun4i-lradc-keys.c
> +++ b/drivers/input/keyboard/sun4i-lradc-keys.c
> @@ -22,6 +22,8 @@
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/pm_wakeup.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  
> @@ -226,8 +228,7 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
>  {
>  	struct sun4i_lradc_data *lradc;
>  	struct device *dev = &pdev->dev;
> -	int i;
> -	int error;
> +	int error, i, irq;
>  
>  	lradc = devm_kzalloc(dev, sizeof(struct sun4i_lradc_data), GFP_KERNEL);
>  	if (!lradc)
> @@ -272,8 +273,11 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
>  	if (IS_ERR(lradc->base))
>  		return PTR_ERR(lradc->base);
>  
> -	error = devm_request_irq(dev, platform_get_irq(pdev, 0),
> -				 sun4i_lradc_irq, 0,
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	error = devm_request_irq(dev, irq, sun4i_lradc_irq, 0,
>  				 "sun4i-a10-lradc-keys", lradc);
>  	if (error)
>  		return error;
> @@ -282,6 +286,14 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
>  	if (error)
>  		return error;
>  
> +	if (device_property_read_bool(dev, "wakeup-source")) {
> +		error = dev_pm_set_wake_irq(dev, irq);
> +		if (error)
> +			dev_warn(dev, "Failed to set wake IRQ\n");

I extended the warning message with irq number and error code and
applied, thank you.

-- 
Dmitry
