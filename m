Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61365512FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbiFTIiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbiFTIil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63F0D6142
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655714319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6/w9H8BLMSGJdCi5DadpwGzUnzWwm3tPGQz0dSHpO8=;
        b=OtBFu8hMO1O+hIeN7w+EIFg3m7YvmJsn7/mgDLpwuG1M2JS3ecT4m4HVSjuLQ7aRhWIcz3
        mNXeP3omDO5AGjaImL5YCmhQRcQVqtPHBgs5apzcJF5a+4kVjqtI1TD7jIC5g6SmgPtruI
        Fsjho1mL6kHtcGMGxFqDvbUE7rETZ5g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-Y1rx2M2nOHyj08RU1Vm7uA-1; Mon, 20 Jun 2022 04:38:37 -0400
X-MC-Unique: Y1rx2M2nOHyj08RU1Vm7uA-1
Received: by mail-ej1-f70.google.com with SMTP id pv1-20020a170907208100b00710f5f8105cso3176015ejb.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f6/w9H8BLMSGJdCi5DadpwGzUnzWwm3tPGQz0dSHpO8=;
        b=rpM27OwK7zjxttfesSFm84yOqB4P0nS5pJZ6RDPifP5OGfpV/UtBVEZUKpSOoiu8jR
         koPwKB2BCyyI9DTjnsmKJIOJwWFV29HPTzMW9xwKT+d4PqTGLoeCre+pv7NJynXggzPD
         XIBhBNZMHvhwGwk2IU8q1w4Tk/kImGXJvdypo3GxpEB2Qt+ydKXcVaVGg5sxEqE3Abha
         sFRBo3GXSGG/5HrRDLtJaXx+9Z/1CBijRURymykWfIY9pOCxviXeOJwV7sumnSy06VmL
         Tjp9Ymdk8GNuHZUiWCO1SO0J4uQt+9Mn/ubp+2tHxr8NfucwSkMycqLTOmhLM4YPrWxM
         7S2w==
X-Gm-Message-State: AJIora+TNfZlDvKRuipE2L1DNZkcNkLeuQfITd0fI4HrWEtio8Os00DL
        YIYoown2E/hCzLy/38xZVk/JxxlVvootcK42djRczbfMRE3pM+Z9DQoC63ipT7FqR75uzFz4i/1
        VjXlidBSgFnggbwYldKe0DgYC
X-Received: by 2002:a17:906:604f:b0:718:e9e8:9d2a with SMTP id p15-20020a170906604f00b00718e9e89d2amr19433763ejj.315.1655714316748;
        Mon, 20 Jun 2022 01:38:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1usD0cBaYhCbUI1ROqyQJpqrT2uvnD8HVydrgQCcwPKkzZ9Ywvrrgfx9dkuzAP4UoZPAweL8g==
X-Received: by 2002:a17:906:604f:b0:718:e9e8:9d2a with SMTP id p15-20020a170906604f00b00718e9e89d2amr19433755ejj.315.1655714316564;
        Mon, 20 Jun 2022 01:38:36 -0700 (PDT)
Received: from [10.87.1.19] ([145.15.244.207])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063ca900b0072232a898f1sm2595116ejh.103.2022.06.20.01.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:38:36 -0700 (PDT)
Message-ID: <8c0ddc7c-c3e0-f370-3cca-9b6c0ab03e3d@redhat.com>
Date:   Mon, 20 Jun 2022 10:38:34 +0200
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

I don't see how this helps, __maybe_unused only means the compiler should not
warn AFAIK it is still allowed to remove static globals which are unused
even of they are marked __maybe_unused ?

And DEFINE_SIMPLE_DEV_PM_OPS does not mark the dev_pm_ops as
__maybe_unused where as pm_sleep_ptr() will not reference the struct
when CONFIG_PM is not set.

But I guess that the new PTR_IF magic:

#define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)

Still counts as referencing the struct so we don't get
an unused warning and since cond is a const 0 value the compiler
can optimize things away ?

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

