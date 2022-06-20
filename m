Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F065512E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbiFTIdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbiFTIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5DCC12AAB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655714020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s95qKuu92bSeKH0aZ3/xELPzDRZOedRegx+aREtihuc=;
        b=Xut8mA8TtDeYRKGwhYt2RXtzggxMdoykXa9BCRZnoL3J6w7Qfkkt9xHB006ANqLbYJV7l7
        J1dzvxZjbBKPcscmfk/csejLyQhSL+fiCBV6E/bHTY5fi3KpLbIVkrX4y8j9J0W2DCrqGd
        o4snC3+n7vkCIGIz3rWAJndln8AQow0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-xl25lJiYPrKKyhg8iUagcw-1; Mon, 20 Jun 2022 04:33:39 -0400
X-MC-Unique: xl25lJiYPrKKyhg8iUagcw-1
Received: by mail-ed1-f71.google.com with SMTP id v7-20020a056402348700b004351fb80abaso8133846edc.14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s95qKuu92bSeKH0aZ3/xELPzDRZOedRegx+aREtihuc=;
        b=SiuGiuUtiICzlqghxUPF2E5ZHcXzJk1+qjwkfDo2EdQa29dOc/Cl80aXK1WQjZVoHW
         fI9Hzy4db2Z7sxwlC1ob1rpjUl30UXrfDHe5/gH0h6Ze8e+cXAHpto0kiT+y/laaRW08
         bljI6u+BlnO9h2txeoMNFrsmgxYWt1YC0+NjtEqPciykG++h5WTJYcB6s/lyDxDuNIln
         9HL8vTknVlXL0MzT0qlZJYePgWvES6pcPaPY/lHPvoAMVGdIyHIwAYIGKADh9XrVKeu0
         NgIWv2ChrBLMjiJMjJJFVeGJXDcB6J9sjWCdf8pX4IZ4+h66+3LmrG9040sJKtXGH7kh
         Hpfg==
X-Gm-Message-State: AJIora/eIBeey6CQZMr4pGIX4+qBd8Klk+xuz5VQGZeu5Qt+U5CIlyLn
        OGDSKTubf8OU1ahvCDwvFvNTs0HpsPZ6L6tYQk7EeuFz2OVOGUF3zLsJz2lhqFl8koa/r45tyFh
        z6E85sSBFCa6d8aoA7tBYGsl4
X-Received: by 2002:a17:906:739d:b0:712:302b:78e9 with SMTP id f29-20020a170906739d00b00712302b78e9mr19873761ejl.569.1655714018257;
        Mon, 20 Jun 2022 01:33:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uyrfJgH0+gpIxQpeX3a3HZYLY1xLEZIV+pxlL5GmSIFXUoGfbyVquYWqAyVmpegV8CQ4sa+g==
X-Received: by 2002:a17:906:739d:b0:712:302b:78e9 with SMTP id f29-20020a170906739d00b00712302b78e9mr19873751ejl.569.1655714018072;
        Mon, 20 Jun 2022 01:33:38 -0700 (PDT)
Received: from [10.87.1.19] ([145.15.244.207])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b00711d5baae0esm5592487ejg.145.2022.06.20.01.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:33:37 -0700 (PDT)
Message-ID: <1a8e3e3a-1008-b52b-b7e9-117fd43e77d4@redhat.com>
Date:   Mon, 20 Jun 2022 10:33:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/2] mfd: intel_soc_pmic_chtwc: Use dev_err_probe()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
References: <20220616171009.43524-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220616171009.43524-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/16/22 19:10, Andy Shevchenko wrote:
> Simplify the mux error path a bit by using dev_err_probe().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/mfd/intel_soc_pmic_chtwc.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
> index 4eab191e053a..1cbe2bcce530 100644
> --- a/drivers/mfd/intel_soc_pmic_chtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_chtwc.c
> @@ -179,18 +179,13 @@ static int cht_wc_probe(struct i2c_client *client)
>  	int ret;
>  
>  	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "_HRV", NULL, &hrv);
> -	if (ACPI_FAILURE(status)) {
> -		dev_err(dev, "Failed to get PMIC hardware revision\n");
> -		return -ENODEV;
> -	}
> -	if (hrv != CHT_WC_HRV) {
> -		dev_err(dev, "Invalid PMIC hardware revision: %llu\n", hrv);
> -		return -ENODEV;
> -	}
> -	if (client->irq < 0) {
> -		dev_err(dev, "Invalid IRQ\n");
> -		return -EINVAL;
> -	}
> +	if (ACPI_FAILURE(status))
> +		return dev_err_probe(dev, -ENODEV, "Failed to get PMIC hardware revision\n");
> +	if (hrv != CHT_WC_HRV)
> +		return dev_err_probe(dev, -ENODEV, "Invalid PMIC hardware revision: %llu\n", hrv);
> +
> +	if (client->irq < 0)
> +		return dev_err_probe(dev, -EINVAL, "Invalid IRQ\n");
>  
>  	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
>  	if (!pmic)

