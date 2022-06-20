Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E253D551330
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiFTIs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiFTIs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B6226413
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655714905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5Uro1J4gY9HG1/yF5DyvRE66hoxfiQn8V+oc0to5c0=;
        b=JiTUSeT5JUkTHkNOmIEoMEvvZKLCJ4ySJYS0WNfyH74bveJDj+twgumKg6m850o5oyA89i
        QKjTHy5sXnbG4WPZP+YpYnhmyvCynJbLBBOJtdJ6o0Kv1SSuHsQ3uqOwR7duc8bYhuUctS
        ftrymenNNIUStNF25Hb6zmkq07ZVPvA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-akszceKrPOODAEZKKmAB_Q-1; Mon, 20 Jun 2022 04:48:23 -0400
X-MC-Unique: akszceKrPOODAEZKKmAB_Q-1
Received: by mail-ed1-f70.google.com with SMTP id y13-20020a056402358d00b0042dfb820070so8211314edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I5Uro1J4gY9HG1/yF5DyvRE66hoxfiQn8V+oc0to5c0=;
        b=uuHDgXmKf9Zk4PoJvEXfEMr+dS3NsxP0ipOHfBomXWCSi9gPl2RPb3ztWmmtTbaCOd
         +OYVeFhq/2qNw5j2Dhl6kEiHX7P+o9BgNoBHDSIJiorjT+Obwl+iOLzudjIInMb9mBiz
         LgbCMdwkbqQTgYMYhXBwf244fSk0QpCe5//jryoOz5pRkvUNGmQwYLA5s6ycgk6bGK1l
         aViNcZBjyB3qTW42GkohwtiglKUr8f0ONqjg4GFqFUix+oh1SL48KzsRztcyTipx3H3a
         rrW+aFh/aibDbCsLSH6/IlgG3w9T073/rdPBWeG+pYyHY9NIRltEK8CZfkDAquFJ2VrR
         pC2w==
X-Gm-Message-State: AJIora9TIA1EaO9coL+BYw9KV1mxNuk12RC3/fCytitT7Y4eZguOiKU9
        jw9LMpyEjIKkEUivm4p8wkYajqNImWl8FyualDOr3ctLkcSn1Rp7LH8dJmAoItsFyL2AqXjCwaW
        FbecqVGTy7rwBTqeFpVQaw91D
X-Received: by 2002:a17:906:1109:b0:711:d8fe:fe56 with SMTP id h9-20020a170906110900b00711d8fefe56mr20168310eja.261.1655714902602;
        Mon, 20 Jun 2022 01:48:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uLjJErYpdqaeD4fW0BTAngj/XosU2D1velpB0tf4752ptssH8+Ktyw9tSCeRMP1DJZB+mtZQ==
X-Received: by 2002:a17:906:1109:b0:711:d8fe:fe56 with SMTP id h9-20020a170906110900b00711d8fefe56mr20168298eja.261.1655714902437;
        Mon, 20 Jun 2022 01:48:22 -0700 (PDT)
Received: from [10.87.1.19] ([145.15.244.207])
        by smtp.gmail.com with ESMTPSA id o22-20020aa7c7d6000000b0042dc8dd59c7sm9689808eds.51.2022.06.20.01.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:48:21 -0700 (PDT)
Message-ID: <9cfa54dc-ba15-65ff-dd96-ac314cc7b4e1@redhat.com>
Date:   Mon, 20 Jun 2022 10:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 2/2] mfd: intel_soc_pmic_chtwc: Switch from
 __maybe_unused to pm_sleep_ptr() etc
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
References: <20220616171009.43524-1-andriy.shevchenko@linux.intel.com>
 <20220616171009.43524-2-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220616171009.43524-2-andriy.shevchenko@linux.intel.com>
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
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less heavier for builds
> than the use of __maybe_unused attributes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I see that this basically converts the code to the new way of dealing
with pm_ops, so after a second look:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> ---
>  drivers/mfd/intel_soc_pmic_chtwc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
> index 1cbe2bcce530..9216f0d34206 100644
> --- a/drivers/mfd/intel_soc_pmic_chtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_chtwc.c
> @@ -222,7 +222,7 @@ static void cht_wc_shutdown(struct i2c_client *client)
>  	disable_irq(pmic->irq);
>  }
>  
> -static int __maybe_unused cht_wc_suspend(struct device *dev)
> +static int cht_wc_suspend(struct device *dev)
>  {
>  	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
>  
> @@ -231,7 +231,7 @@ static int __maybe_unused cht_wc_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused cht_wc_resume(struct device *dev)
> +static int cht_wc_resume(struct device *dev)
>  {
>  	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
>  
> @@ -239,7 +239,7 @@ static int __maybe_unused cht_wc_resume(struct device *dev)
>  
>  	return 0;
>  }
> -static SIMPLE_DEV_PM_OPS(cht_wc_pm_ops, cht_wc_suspend, cht_wc_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(cht_wc_pm_ops, cht_wc_suspend, cht_wc_resume);
>  
>  static const struct i2c_device_id cht_wc_i2c_id[] = {
>  	{ }
> @@ -253,7 +253,7 @@ static const struct acpi_device_id cht_wc_acpi_ids[] = {
>  static struct i2c_driver cht_wc_driver = {
>  	.driver	= {
>  		.name	= "CHT Whiskey Cove PMIC",
> -		.pm     = &cht_wc_pm_ops,
> +		.pm     = pm_sleep_ptr(&cht_wc_pm_ops),
>  		.acpi_match_table = cht_wc_acpi_ids,
>  	},
>  	.probe_new = cht_wc_probe,

