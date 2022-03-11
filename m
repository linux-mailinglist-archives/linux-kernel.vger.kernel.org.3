Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0264D593A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345944AbiCKDrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbiCKDrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:47:43 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B5AF405C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:46:40 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id h10so8136850oia.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C6vfFGaLcvssVHex0UP6Zr+7SJ5PWN1tlE8nC/A476g=;
        b=O66c9UyPP52n2OztO9GWk+p1q5wdS8eFOo4x3wwxlmxtRFKWkGb43xV9Xgsb4IZKkL
         K96TItISzaDZ7Ia81lcRMpI3LVMgaAZ8C6BqZ6ArGpug437uCjlxvqHVuL18qEKeQxpX
         NwPYYN8LbVlo3gHppVRHleWkGqX+RrxV3+jyI0HW85TOmECZJZ8BItHcGxZuXA/RryPH
         7aMO+1uDEp5FphGBMzGZNlQKR7ezkZA1KClvir49AOUk9uoMWxCVkuvzNbaexQJgiFWe
         OTGUsetwGxmpfnh2V0acCOHozVsJ6WCbfFTmdIX4TH5lCtPMiEJcMaUf54FJQ9D4+Cpl
         9W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C6vfFGaLcvssVHex0UP6Zr+7SJ5PWN1tlE8nC/A476g=;
        b=gUTIHxRMJPRuMNajDb09sQmix8MWWxleHq3AbhCRkCnk2TO7qg03O538k0CdvhVM1P
         2VaESZ7RBacKB9c1s15g6J2Iu5/eVnnnv3H6YkIeAWBowLjZYOna3ekVOi5Cvp6XEk/J
         nCunphYKSN6poOGRufwwUd/+C27l74nlfd3DPpp9HYA8/TOjJTVJArK5Y8LXu4n9VNFB
         964owo+RpADpjM5WUb/pdVV77lFqTYYMYYpC0nn8jNQ7zViLlUcMkbcnmuSGbakTN22I
         tTdh9swBfqJ1Z7br1Ue06gpl9l6eBXZrIRf0m/0DcK+olnvkuCoRhA6gFIPYxxHl8jlg
         LujA==
X-Gm-Message-State: AOAM533dEMSwZbgd5gInH6M4eJw5AnkaKWbbI8JY5tp+k1BZmyKrfKnj
        wH57DpYpAW2lXllTfbRfX42CWAdh5SoppQ==
X-Google-Smtp-Source: ABdhPJxQwBydyWONXXRRH31TPbNzgcbsNklB11/mQG1n21KwuZqx9/3hFqab9YvncA0I7KuFVX4iJg==
X-Received: by 2002:a05:6808:4c2:b0:2ec:8fcb:1d4a with SMTP id a2-20020a05680804c200b002ec8fcb1d4amr563051oie.162.1646970399564;
        Thu, 10 Mar 2022 19:46:39 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id w4-20020a4adec4000000b0032109de628esm3126359oou.6.2022.03.10.19.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 19:46:38 -0800 (PST)
Date:   Thu, 10 Mar 2022 19:48:19 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qcom-rng: ensure buffer for generate is
 completely filled
Message-ID: <YirGg8K3DvVhlfMg@ripper>
References: <20220310232459.749638-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310232459.749638-1-bmasney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10 Mar 15:24 PST 2022, Brian Masney wrote:

> The generate function in struct rng_alg expects that the destination
> buffer is completely filled if the function returns 0. qcom_rng_read()
> can run into a situation where the buffer is partially filled with
> randomness and the remaining part of the buffer is zeroed since
> qcom_rng_generate() doesn't check the return value. This issue can
> be reproduced by running the following from libkcapi:
> 
>     kcapi-rng -b 9000000 > OUTFILE
> 
> The generated OUTFILE will have three huge sections that contain all
> zeros, and this is caused by the code where the test
> 'val & PRNG_STATUS_DATA_AVAIL' fails.
> 
> Let's fix this issue by ensuring that qcom_rng_read() always returns
> with a full buffer if the function returns success. Let's also have
> qcom_rng_generate() return the correct value.
> 
> Here's some statistics from the ent project
> (https://www.fourmilab.ch/random/) that shows information about the
> quality of the generated numbers:
> 
>     $ ent -c qcom-random-before
>     Value Char Occurrences Fraction
>       0           606748   0.067416
>       1            33104   0.003678
>       2            33001   0.003667
>     ...
>     253   ???        32883   0.003654
>     254   ???        33035   0.003671
>     255   ???        33239   0.003693
> 
>     Total:       9000000   1.000000
> 
>     Entropy = 7.811590 bits per byte.
> 
>     Optimum compression would reduce the size
>     of this 9000000 byte file by 2 percent.
> 
>     Chi square distribution for 9000000 samples is 9329962.81, and
>     randomly would exceed this value less than 0.01 percent of the
>     times.
> 
>     Arithmetic mean value of data bytes is 119.3731 (127.5 = random).
>     Monte Carlo value for Pi is 3.197293333 (error 1.77 percent).
>     Serial correlation coefficient is 0.159130 (totally uncorrelated =
>     0.0).
> 
> Without this patch, the results of the chi-square test is 0.01%, and
> the numbers are certainly not random according to ent's project page.
> The results improve with this patch:
> 
>     $ ent -c qcom-random-after
>     Value Char Occurrences Fraction
>       0            35432   0.003937
>       1            35127   0.003903
>       2            35424   0.003936
>     ...
>     253   ???        35201   0.003911
>     254   ???        34835   0.003871
>     255   ???        35368   0.003930
> 
>     Total:       9000000   1.000000
> 
>     Entropy = 7.999979 bits per byte.
> 
>     Optimum compression would reduce the size
>     of this 9000000 byte file by 0 percent.
> 
>     Chi square distribution for 9000000 samples is 258.77, and randomly
>     would exceed this value 42.24 percent of the times.
> 
>     Arithmetic mean value of data bytes is 127.5006 (127.5 = random).
>     Monte Carlo value for Pi is 3.141277333 (error 0.01 percent).
>     Serial correlation coefficient is 0.000468 (totally uncorrelated =
>     0.0).
> 
> This change was tested on a Nexus 5 phone (msm8974 SoC).
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Fixes: ceec5f5b5988 ("crypto: qcom-rng - Add Qcom prng driver")
> Cc: stable@vger.kernel.org # 4.19+

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/crypto/qcom-rng.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
> index 99ba8d51d102..11f30fd48c14 100644
> --- a/drivers/crypto/qcom-rng.c
> +++ b/drivers/crypto/qcom-rng.c
> @@ -8,6 +8,7 @@
>  #include <linux/clk.h>
>  #include <linux/crypto.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -43,16 +44,19 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
>  {
>  	unsigned int currsize = 0;
>  	u32 val;
> +	int ret;
>  
>  	/* read random data from hardware */
>  	do {
> -		val = readl_relaxed(rng->base + PRNG_STATUS);
> -		if (!(val & PRNG_STATUS_DATA_AVAIL))
> -			break;
> +		ret = readl_poll_timeout(rng->base + PRNG_STATUS, val,
> +					 val & PRNG_STATUS_DATA_AVAIL,
> +					 200, 10000);
> +		if (ret)
> +			return ret;
>  
>  		val = readl_relaxed(rng->base + PRNG_DATA_OUT);
>  		if (!val)
> -			break;
> +			return -EINVAL;
>  
>  		if ((max - currsize) >= WORD_SZ) {
>  			memcpy(data, &val, WORD_SZ);
> @@ -61,11 +65,10 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
>  		} else {
>  			/* copy only remaining bytes */
>  			memcpy(data, &val, max - currsize);
> -			break;
>  		}
>  	} while (currsize < max);
>  
> -	return currsize;
> +	return 0;
>  }
>  
>  static int qcom_rng_generate(struct crypto_rng *tfm,
> @@ -87,7 +90,7 @@ static int qcom_rng_generate(struct crypto_rng *tfm,
>  	mutex_unlock(&rng->lock);
>  	clk_disable_unprepare(rng->clk);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
> -- 
> 2.34.1
> 
