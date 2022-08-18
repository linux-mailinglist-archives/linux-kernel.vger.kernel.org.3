Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0485F598CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbiHRTkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbiHRTkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:40:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674171057F;
        Thu, 18 Aug 2022 12:40:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f4so208120pgc.12;
        Thu, 18 Aug 2022 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=ulMg8tTHr07JXADnsATIwJjQyIx3Snpx5qARr9jK6UA=;
        b=n9xlbNi8id94f4BxSUtpst7ZPal3m8sIo8LIC6dMnklQbgk3mkRVYEPstoDKAdpjcm
         /RMlGcKEXZxSGd3YjFd5R6chTO7+VYz0302lCBLpMn9jPUdn5oUybzWJQjEkqydKp4so
         UvkBu6UWzAos5J6ih9d29NCqHH+QVb/oRKOy+5iWNTS1QQzOJYeJIAVPGPirM+4lhadx
         22ezxtRRy56V1ylvsCi+WO8szAQFY4Q2kHXGBiimnGk4h0nPyzvrdBnyogic4XCGUcw/
         NeUq2Ylp7RvsWn8YgxOgt8jOibWYJ8k8D01K6DkXY3tLcARu0XvUCIvbzx91DwW6W/4y
         8UNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=ulMg8tTHr07JXADnsATIwJjQyIx3Snpx5qARr9jK6UA=;
        b=5c6Y+AWzMwCnSyJ1rsHKO8+wN5GUpLlz+cToRSAhzkBn//cV7enyp1G5akM9EecVjX
         pVJk8ZScZZaKn69WUgUvyO8NQqLLWSG0MR401v3EJbGbEeGaypqG6pFgL9R5BMn4hIEG
         a5xU5XFDkSvjpldjREDx7tQovw+BJ//cgHen5aDGs3w/4J8Wn4KE4LZXmTwCFFeN/ouq
         R2nK6C/my+Orbb4Oo0P6UMK2Te/ZPtCmMXC35WAQBIlmFLjb9t3QKF80J1MMOWz0LdGV
         ukHG65h5qa95MSeTIBX05TOXbUSe9wrsn4YcW41nRdtcPHduavzJ7HhV5ZUUF/qxZohD
         ntIg==
X-Gm-Message-State: ACgBeo0/J9BUfgifFXM9vV7GIL6CaAOUQLpaSdi94S21jlB11GAcVIxU
        nNQfT+4geW4vTeP3Ev5ZguU=
X-Google-Smtp-Source: AA6agR4FefTBHo9ngDpHXcHDxebo2RSaUqagrN+Kjesfv4bVTdERIQ1NvP2huUDMIRbJeSw94+jv5Q==
X-Received: by 2002:a05:6a00:1996:b0:52e:b0f7:8c83 with SMTP id d22-20020a056a00199600b0052eb0f78c83mr4342979pfl.59.1660851611848;
        Thu, 18 Aug 2022 12:40:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e25-20020aa79819000000b0052895642037sm1991984pfl.139.2022.08.18.12.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 12:40:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 12:40:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 01/16] hwmon: (mr75203) fix VM sensor allocation when
 "intel,vm-map" not defined
Message-ID: <20220818194008.GA3118944@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-2-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817054321.6519-2-farbere@amazon.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 05:43:06AM +0000, Eliav Farber wrote:
> Fix a bug that in case "intel,vm-map" is missing 'num' is set to 0,
> and no voltage channel infos are allocated.
> 

"intel,vm-map" is listed as required property in moortec,mr75203.yaml.
If it is missing, the probe function should fail.

Guenter

> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/hwmon/mr75203.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 046523d47c29..0e29877a1a9c 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -580,8 +580,6 @@ static int mr75203_probe(struct platform_device *pdev)
>  	}
>  
>  	if (vm_num) {
> -		u32 num = vm_num;
> -
>  		ret = pvt_get_regmap(pdev, "vm", pvt);
>  		if (ret)
>  			return ret;
> @@ -594,30 +592,28 @@ static int mr75203_probe(struct platform_device *pdev)
>  		ret = device_property_read_u8_array(dev, "intel,vm-map",
>  						    pvt->vm_idx, vm_num);
>  		if (ret) {
> -			num = 0;
> +			/*
> +			 * Incase intel,vm-map property is not defined, we
> +			 * assume incremental channel numbers.
> +			 */
> +			for (i = 0; i < vm_num; i++)
> +				pvt->vm_idx[i] = i;
>  		} else {
>  			for (i = 0; i < vm_num; i++)
>  				if (pvt->vm_idx[i] >= vm_num ||
> -				    pvt->vm_idx[i] == 0xff) {
> -					num = i;
> +				    pvt->vm_idx[i] == 0xff)
>  					break;
> -				}
> -		}
>  
> -		/*
> -		 * Incase intel,vm-map property is not defined, we assume
> -		 * incremental channel numbers.
> -		 */
> -		for (i = num; i < vm_num; i++)
> -			pvt->vm_idx[i] = i;
> +			vm_num = i;
> +		}
>  
> -		in_config = devm_kcalloc(dev, num + 1,
> +		in_config = devm_kcalloc(dev, vm_num + 1,
>  					 sizeof(*in_config), GFP_KERNEL);
>  		if (!in_config)
>  			return -ENOMEM;
>  
> -		memset32(in_config, HWMON_I_INPUT, num);
> -		in_config[num] = 0;
> +		memset32(in_config, HWMON_I_INPUT, vm_num);
> +		in_config[vm_num] = 0;
>  		pvt_in.config = in_config;
>  
>  		pvt_info[index++] = &pvt_in;
