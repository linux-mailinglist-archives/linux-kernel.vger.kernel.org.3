Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBF058CB33
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbiHHPU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243661AbiHHPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:20:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83BE1408C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:20:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i128-20020a1c3b86000000b003a536d58f73so2594233wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=de9exsSiUr3o3yB1M5BCPv7zIDPwsS151CoD7NOZ4ZA=;
        b=qTvkpWq1GmfL98YXB8OzmlD2yZq7YsgZBme91LFqRVBFf/75hx6jrKS5X2OKX5QzlH
         Ekm7wGY3pMLIOELGD/tvZczyAdYjJmDXyM5NZiBY75IexOIgPyBeCpvMwoL6vTW6Rkjc
         8O/u2jwVGkTHkrhSJIelnctCQ/3KbDdYLWwz11N1yeLN+M6aqZwGSb6NzuaSs3Nx/m0l
         4OeH8/zf9O8cqgZBxQCgQuIklE0pp38N5ZulUX+huLEh4qihoRgWcMVK4jO1V6ASI9Gf
         ZW51TlJXv9v0HqtkaEijYzBTI6J4JkvtGAzkbb10IxT8GLeC4hPmJIB8yBFWzJ5EnFOw
         4Y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=de9exsSiUr3o3yB1M5BCPv7zIDPwsS151CoD7NOZ4ZA=;
        b=acVHPA8xF4DMzezkSeQSdLuTip7L68YM6HBPDvmfL6PWh115tfhh54Z4gyFVp+VwK9
         3URBNX2H51sXxa6xwvJquyfAKx+AB7bRpWDTDUNVaj1ifTJGP6BL0bLxNCHIo5+Db98D
         U4C0YZQYVtSg4CmQz+xD0iNx0fRz8x7facy0uCbmB2bxjGI37tZvzYKfNPOLTXSKZ9gl
         vqbVWrfMcRHGbgCOeiRn56VteeS9Hd/gZwbsgkaRa9Ge83Fwqz34QagPVyaPWCwWxQkN
         DmV2s8Rfr4koZDeQgA5XGlkDDvNvcpsFt5MoIB6eGpnLI/ya3yZkphia9Z5jPIGwh5LP
         6eFQ==
X-Gm-Message-State: ACgBeo0ZX/6s4KMM5NcivEQ0cvE5L4a5Nn1E9srzH8NLivIXldaHGYVr
        p8a3WDxM5AXWCmhLfJ5AZmgA8g==
X-Google-Smtp-Source: AA6agR70/Jce+jRuStUNFM4ja55YmPaocjiKiPKsJd45VvkFnQ9wIKI2AuQhU2HcI6d7AcEXCfdD7w==
X-Received: by 2002:a7b:ce0a:0:b0:3a3:1adf:af34 with SMTP id m10-20020a7bce0a000000b003a31adfaf34mr12817370wmc.127.1659972045397;
        Mon, 08 Aug 2022 08:20:45 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o5-20020a056000010500b0021f0af83142sm11398689wrx.91.2022.08.08.08.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:20:45 -0700 (PDT)
Date:   Mon, 8 Aug 2022 16:20:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: [RESEND][PATCH v1 9/9] Revert "mfd: intel_soc_pmic_bxtwc:
 Support IRQ chip hierarchy"
Message-ID: <YvEpy/I2F9pk19Ar@google.com>
References: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
 <20220718122328.8287-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718122328.8287-9-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022, Andy Shevchenko wrote:

> This reverts commit 4a34dfdfcc185efea44da958b2e4a6005a70e7d4.

Sign-off?

Commit message?

> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index f9842ff44b3f..8dac0d41f64f 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -422,10 +422,8 @@ static int bxtwc_add_chained_irq_chip(struct intel_soc_pmic *pmic,
>  		return dev_err_probe(pmic->dev, irq, "Failed to get parent vIRQ(%d) for chip %s\n",
>  				     pirq, chip->name);
>  
> -	return __devm_regmap_add_irq_chip(pmic->dev, pmic->regmap, irq,
> -					  irq_flags, 0,
> -					  regmap_irq_get_domain(pdata),
> -					  chip, data);
> +	return devm_regmap_add_irq_chip(pmic->dev, pmic->regmap, irq, irq_flags,
> +					0, chip, data);
>  }
>  
>  static int bxtwc_probe(struct platform_device *pdev)

-- 
DEPRECATED: Please use lee@kernel.org
