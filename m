Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97155C70A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiF0JFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiF0JFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:05:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EC8634B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:05:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o4so8088005wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CHDSHYN9BpInL+Ryv54jLqygVypCcJUYwj0S5dNNlNY=;
        b=MO2WKWmoot/lvaNaNLbFYHdQbYxMJrCc8Btuz3nNZZ29NgZl6WWHLb+Bhw3gMGbc8M
         2kessA9KbEV0qfbho4/R4rkdmxxGJvWOz+ZGiX3nj7KbiDxw88N5vGtT1vBwpjZb+IcX
         Cxn8aEaKnk0SFBS22KOnIjSkO2zuFzmmMTdI+IkgrtblacfoAPpBX4MZekPL3orpXEVr
         izrWTdm+dEZPknvnd64z09PIl8+YsM2nbrD7hO8VzoGQ95eN4xKk0a56A8+un6NxmfAS
         hMYi2WAnA/lNRBxysFwE/Aaa4+e8/DToDiEGOjbrYfYgMa5FPIhIw19bGPMwypSjBx1E
         aLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CHDSHYN9BpInL+Ryv54jLqygVypCcJUYwj0S5dNNlNY=;
        b=agrZ5lPTzaTflfN7LIXi9TD3rzrhTeGG8afls84w2Le2iP9LdnndrIAbvPjQI9VJVq
         1uY2h0nIB7+iXXiY8EvsMt/WFkKJl8O2d5qQdzTF20eL4uoiD0naqIJnCs5Z2uZaT2sk
         GBot6KqPwCrwhOHyU7L+eHg/+7NO1xzRuuZMCtHlMhXduIblqCsyktGiXhdd3/vGTQGk
         iFIMw9d2ucAYZOjD/Jz6YYje05DpviBG5HfOFRR01hTqAOWNXy+RJaj2iX4ubsw4Ie3p
         qoz6te+O3vGVcqWj3Ie7XNjpZP4h/Xs3ryu/+X8EDG4Cx/goD98It1XeVlXmt8gOBs1M
         4y4Q==
X-Gm-Message-State: AJIora/LTcHLcTFneijPXnK6NsVdEfu3t3MQIKd1wK9N6ub541XaFTcs
        fimIKSnmGhZMSlYs9RBZCgmr2Q6JOxc+gA==
X-Google-Smtp-Source: AGRyM1t0ygV4mlezEyvrgca03/hH34yMCOG3h4y+9E3XRdKQnETyVn+fb2Xm5QpzSHVjp+QFTfsyBg==
X-Received: by 2002:a5d:544c:0:b0:21b:a288:f98c with SMTP id w12-20020a5d544c000000b0021ba288f98cmr11075178wrv.300.1656320709219;
        Mon, 27 Jun 2022 02:05:09 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c4f8d00b003971fc23185sm17770593wmq.20.2022.06.27.02.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:05:08 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:05:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 01/11] mfd: intel_soc_pmic_bxtwc: Don't shadow error
 codes in show()/store()
Message-ID: <Yrlyw1eMFy4kd0JB@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022, Andy Shevchenko wrote:

> kstrtox() along with regmap API can return different error codes based on
> circumstances.
> 
> Don't shadow them when returning to the caller.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index bc069c4daa60..3148a319d467 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -339,10 +339,14 @@ static ssize_t addr_show(struct device *dev,
>  static ssize_t addr_store(struct device *dev,
>  			  struct device_attribute *attr, const char *buf, size_t count)
>  {
> -	if (kstrtoul(buf, 0, &bxtwc_reg_addr)) {
> +	int ret;
> +
> +	ret = kstrtoul(buf, 0, &bxtwc_reg_addr);
> +	if (ret) {
>  		dev_err(dev, "Invalid register address\n");

Is that really what failure means, on every failure?

  "Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing
   error."

> -		return -EINVAL;
> +		return ret;
>  	}
> +
>  	return (ssize_t)count;
>  }
>  
> @@ -354,9 +358,9 @@ static ssize_t val_show(struct device *dev,
>  	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
>  
>  	ret = regmap_read(pmic->regmap, bxtwc_reg_addr, &val);
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(dev, "Failed to read 0x%lx\n", bxtwc_reg_addr);
> -		return -EIO;
> +		return ret;
>  	}
>  
>  	return sprintf(buf, "0x%02x\n", val);
> @@ -377,7 +381,7 @@ static ssize_t val_store(struct device *dev,
>  	if (ret) {
>  		dev_err(dev, "Failed to write value 0x%02x to address 0x%lx",
>  			val, bxtwc_reg_addr);
> -		return -EIO;
> +		return ret;
>  	}
>  	return count;
>  }

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
