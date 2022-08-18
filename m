Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE87598E05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbiHRU2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346048AbiHRU2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:28:45 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E310D3;
        Thu, 18 Aug 2022 13:28:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r22so2145837pgm.5;
        Thu, 18 Aug 2022 13:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=0S9pswd0lTMDAoOgJNHN+XxSC6Y9mGzIwVS4d8zY1N8=;
        b=E/rJybmsbBHMKkh5f9OrGyDmQ9hv7D0HN0E6tJ2fom+248IJqK4aQpe2Ah1SDzVzkN
         yOtJwOfFWNtrtaFLPsbmG8KDTyrX6OOp5L6tZSTF/pqEmAVXUhOPagt+1R8SpOnZbFrC
         ksH12jYXNj3wm459DXRP69ZaYafKXhDj8G5XvwMJzLeIMhWLCb311F0adAjCUpAwq0ym
         1W8RwRJ3BjWjX75AQZ0kdKl9Gn4sxz46GiwyWWA/DyKKc/VMhFKonmMccYshkHYdzU9n
         T1K/CzGqo0PQ9DE37IgfGfqLFC6MwKsUcPqTAWZjDwMTxc1+K7/ZD7FNEuV2tvuekuwU
         FcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=0S9pswd0lTMDAoOgJNHN+XxSC6Y9mGzIwVS4d8zY1N8=;
        b=U21P2yxlROo+kUzczilsJ5Iu3NN7pqsvLQQanFPPRwWylu3//dnNg8Juc4E+43bvF/
         elOdkZSgn97737CKuArQ6+D2siQe/uiDSQoMm9r2y8VjZZdS2MkHGxhStELUT0WmCxu2
         zrM/oOaMSyup4ZY/jCwNUOu1ALot8e3U7fqYVolTr6dvnw6bpldt7MNKOHTBj1WPVZSM
         13ufhBI40ByZraNujO9rKP9ElUja+qJnjF6JaDH55GXXeyL8oKmzaxMAm0wZ8Dgf4uCj
         67hFts3ki7wCB52DoKyM08g16KIp8dBXQKPhLP6oGk2kpqjrpu1MH2bwax8Siiom7Brr
         v7Kw==
X-Gm-Message-State: ACgBeo3S16ea8n7JIEsWA9d8JVwegl7MwbH78WMXC0UTvqXjkgeAodeE
        ONF7HJgNiB3orADrrVZ+a28=
X-Google-Smtp-Source: AA6agR69yMkB0QYmmTxyIbimAV01u677JPoOEX75/EsidU+JD+0KFzfUJ5UdMucRJKxTGN1JIsME1Q==
X-Received: by 2002:a05:6a00:88f:b0:530:dec:81fd with SMTP id q15-20020a056a00088f00b005300dec81fdmr4536094pfj.64.1660854522402;
        Thu, 18 Aug 2022 13:28:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p124-20020a62d082000000b0052dd95e72bcsm2022083pfg.193.2022.08.18.13.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:28:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 13:28:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 14/16] hwmon: (mr75203) parse thermal coefficients
 from device-tree
Message-ID: <20220818202839.GA3431511@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-15-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817054321.6519-15-farbere@amazon.com>
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

On Wed, Aug 17, 2022 at 05:43:19AM +0000, Eliav Farber wrote:
> Use thermal coefficients from the device tree if they exist.
> Otherwise, use default values.
> 
> The equation used in the driver is:
>   T = G + H * (n / cal5 - 0.5) + J * F
> 
> With this change we can support also Mode 1 Conversion, which
> uses A instead of G, and B instead of H.
> 
> We can also support the series 6 equation that has different
> coefficients and has a slightly different format:
>   T = G + H * (n / cal5 - 0.5)
> by setting J to 0.
> 

The calculation was just changed to use new defaults in a previous
patch. This patch makes it quite clear that the coefficients
are implementation (?) dependent. So the previous patch just changes
the defaults to (presumably) the coefficients used in your system.
That is inappropriate. Adding non-default corefficients is ok
and makes sense is supported by the chip, but changing defaults
isn't.

Guenter

> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/hwmon/mr75203.c | 44 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index e500897585e4..e54a4d1803e4 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -131,6 +131,10 @@ struct pvt_device {
>  	u32			p_num;
>  	u32			v_num;
>  	u32			ip_freq;
> +	u32			ts_coeff_h;
> +	u32			ts_coeff_g;
> +	s32			ts_coeff_j;
> +	u32			ts_coeff_cal5;
>  	u8			vm_ch_max;
>  	u8			vm_ch_total;
>  };
> @@ -179,10 +183,10 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
>  		 * Convert the register value to degrees centigrade temperature:
>  		 * T = G + H * (n / cal5 - 0.5) + J * F
>  		 */
> -		*val = PVT_G_CONST;
> -		*val += PVT_H_CONST * nbs / PVT_CAL5_CONST;
> -		*val -= PVT_H_CONST / 2;
> -		*val += PVT_J_CONST * pvt->ip_freq / HZ_PER_MHZ;
> +		*val = pvt->ts_coeff_g;
> +		*val += pvt->ts_coeff_h * nbs / pvt->ts_coeff_cal5;
> +		*val -= pvt->ts_coeff_h / 2;
> +		*val += pvt->ts_coeff_j * pvt->ip_freq / HZ_PER_MHZ;
>  
>  		return 0;
>  	default:
> @@ -619,6 +623,38 @@ static int mr75203_probe(struct platform_device *pdev)
>  		memset32(temp_config, HWMON_T_INPUT, ts_num);
>  		pvt_temp.config = temp_config;
>  		pvt_info[index++] = &pvt_temp;
> +
> +		/*
> +		 * Incase ts-coeff-h/g/j/cal5 property is not defined, use
> +		 * default value.
> +		 */
> +		ret = of_property_read_u32(np, "ts-coeff-h", &pvt->ts_coeff_h);
> +		if (ret)
> +			pvt->ts_coeff_h = PVT_H_CONST;
> +
> +		ret = of_property_read_u32(np, "ts-coeff-g", &pvt->ts_coeff_g);
> +		if (ret)
> +			pvt->ts_coeff_g = PVT_G_CONST;
> +
> +		ret = of_property_read_s32(np, "ts-coeff-j", &pvt->ts_coeff_j);
> +		if (ret)
> +			pvt->ts_coeff_j = PVT_J_CONST;
> +
> +		ret = of_property_read_u32(np, "ts-coeff-cal5",
> +					   &pvt->ts_coeff_cal5);
> +		if (ret) {
> +			pvt->ts_coeff_cal5 = PVT_CAL5_CONST;
> +		} else {
> +			if (pvt->ts_coeff_cal5 == 0) {
> +				dev_err(dev, "invalid ts-coeff-cal5 (%u)\n",
> +					pvt->ts_coeff_cal5);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		dev_dbg(dev, "ts-coeff: h = %u, g = %u, j = %d, cal5 = %u\n",
> +			pvt->ts_coeff_h, pvt->ts_coeff_g, pvt->ts_coeff_j,
> +			pvt->ts_coeff_cal5);
>  	}
>  
>  	if (pd_num) {
