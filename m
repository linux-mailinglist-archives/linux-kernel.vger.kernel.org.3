Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F605AF1EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiIFRF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiIFRFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:05:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F431DF7F;
        Tue,  6 Sep 2022 09:52:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x19so11990874pfr.1;
        Tue, 06 Sep 2022 09:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=ClsUxNWUlr9YbZdE+mBsdmX6Ii6dUBfM2rBrEWed8FM=;
        b=ZD657V+czK2A/LT1vcZmFRCURy17vlQAFGimz4Jd5d/IPRsSAMXR07XLUZXZme8gIq
         x8x555YqBk4OCpHs6IQj7S179VJTHqGdegJGcaRE5r+ek2tYWjbdydM9q1OBwvfzCI4n
         bSZJOjvQZP+pBItAudmKakhqdhhPPYPgcbrwOT976LYefXLkXzXokgEek4uTaHZ1S9PR
         xFkrbnTcWPICMZTZl5e4YXNHbBGyDZBOgyZW9I+XErl1IJhSfyMf6ngWZsgP47k88O/L
         x+SNt+lr+F9iQRTTMfGbnZLgUzoIm73JH4KM8Mvxj9djD+GXsblryciSK75z/F029/HE
         gCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ClsUxNWUlr9YbZdE+mBsdmX6Ii6dUBfM2rBrEWed8FM=;
        b=NNPNmYs021vuxXRWYRxgDcsaszqCsac3ypodux18rPHb5xbbhkqL1B957BkP8vGsHt
         rcxV6JlQy2a6p8bmB4jeCJseIcoKLOE8ft6Krlr3iBWwGaVw7yiM9fP5CbpjtaFA+BlO
         HRQna2ZaysAugiMblwxYolENEKldO3oOgLwv4JAAl77FULd+2XcfYUyC1/U8d9lapYfn
         oXJIY4HWK22KJCrkI4aNx0LiU9CrNN9npgsCGhrSuJnnwnRASZHIfwRVazcSiN/5e5e2
         71b9TTQ8p/yKKvRlXb95XxBnQQGGjoES0iqb77gfgek8eUNRT6xtw+AXii46+lU5ld0V
         HL5g==
X-Gm-Message-State: ACgBeo1oPAZppJNs5F+8iXNoy2ipM984owZuK6p35soHZ2icuY39/9e0
        5tUO6WwC71sde7KimJkkuUQ=
X-Google-Smtp-Source: AA6agR7slyrhF09ZZ0GyrgwjiB2Ccf7IGqljYtzz29C9BmNLvx4Eqxw4/ky7biMQJ1KKhfmPq4ftGw==
X-Received: by 2002:a05:6a00:14c7:b0:52e:efb7:bd05 with SMTP id w7-20020a056a0014c700b0052eefb7bd05mr54838752pfu.24.1662483151937;
        Tue, 06 Sep 2022 09:52:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bi10-20020a170902bf0a00b00174e5fe9ce1sm1906391plb.159.2022.09.06.09.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:52:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Sep 2022 09:52:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hhhawa@amazon.com, jonnyc@amazon.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH v4 01/21] hwmon: (mr75203) fix coding style space errors
Message-ID: <20220906165229.GA594012@roeck-us.net>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-2-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906083356.21067-2-farbere@amazon.com>
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

On Tue, Sep 06, 2022 at 08:33:36AM +0000, Eliav Farber wrote:
> Fix: "ERROR: space required before the open parenthesis '('"
> 
> Fixes: 9d823351a337 ("hwmon: Add hardware monitoring driver for Moortec MR75203 PVT controller")

Coding style "fixes" do not fix the code. I consider using the Fixes: tag
for those to close to an abuse of that tag (and it would be great if that
was spelled out somewhere). As it is, I can not with good conscience apply
this patch to the mainline kernel (especially not for -rc5), meaning the
entire series will have to wait for the next release window unless there
are no conflicts.

Guenter

> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/hwmon/mr75203.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 046523d47c29..8adfbb15453f 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -155,7 +155,7 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
>  			return ret;
>  
>  		ret = regmap_read(t_map, SDIF_DATA(channel), &nbs);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		nbs &= SAMPLE_DATA_MSK;
> @@ -197,7 +197,7 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
>  			return ret;
>  
>  		ret = regmap_read(v_map, VM_SDIF_DATA(vm_idx), &n);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		n &= SAMPLE_DATA_MSK;
> @@ -291,19 +291,19 @@ static int pvt_init(struct pvt_device *pvt)
>  
>  	if (t_num) {
>  		ret = regmap_write(t_map, SDIF_SMPL_CTRL, 0x0);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_write(t_map, SDIF_HALT, 0x0);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_write(t_map, CLK_SYNTH, clk_synth);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_write(t_map, SDIF_DISABLE, 0x0);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
> @@ -316,7 +316,7 @@ static int pvt_init(struct pvt_device *pvt)
>  		val = CFG0_MODE_2 | CFG0_PARALLEL_OUT | CFG0_12_BIT |
>  		      IP_CFG << SDIF_ADDR_SFT | SDIF_WRN_W | SDIF_PROG;
>  		ret = regmap_write(t_map, SDIF_W, val);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
> @@ -329,7 +329,7 @@ static int pvt_init(struct pvt_device *pvt)
>  		val = POWER_DELAY_CYCLE_256 | IP_TMR << SDIF_ADDR_SFT |
>  			      SDIF_WRN_W | SDIF_PROG;
>  		ret = regmap_write(t_map, SDIF_W, val);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
> @@ -343,39 +343,39 @@ static int pvt_init(struct pvt_device *pvt)
>  		      IP_CTRL << SDIF_ADDR_SFT |
>  		      SDIF_WRN_W | SDIF_PROG;
>  		ret = regmap_write(t_map, SDIF_W, val);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  	}
>  
>  	if (p_num) {
>  		ret = regmap_write(p_map, SDIF_HALT, 0x0);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_write(p_map, SDIF_DISABLE, BIT(p_num) - 1);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_write(p_map, CLK_SYNTH, clk_synth);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  	}
>  
>  	if (v_num) {
>  		ret = regmap_write(v_map, SDIF_SMPL_CTRL, 0x0);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_write(v_map, SDIF_HALT, 0x0);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_write(v_map, CLK_SYNTH, clk_synth);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_write(v_map, SDIF_DISABLE, 0x0);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
> @@ -389,7 +389,7 @@ static int pvt_init(struct pvt_device *pvt)
>  		      CFG1_14_BIT | IP_CFG << SDIF_ADDR_SFT |
>  		      SDIF_WRN_W | SDIF_PROG;
>  		ret = regmap_write(v_map, SDIF_W, val);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
> @@ -402,7 +402,7 @@ static int pvt_init(struct pvt_device *pvt)
>  		val = POWER_DELAY_CYCLE_64 | IP_TMR << SDIF_ADDR_SFT |
>  		      SDIF_WRN_W | SDIF_PROG;
>  		ret = regmap_write(v_map, SDIF_W, val);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  
>  		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
> @@ -416,7 +416,7 @@ static int pvt_init(struct pvt_device *pvt)
>  		      IP_CTRL << SDIF_ADDR_SFT |
>  		      SDIF_WRN_W | SDIF_PROG;
>  		ret = regmap_write(v_map, SDIF_W, val);
> -		if(ret < 0)
> +		if (ret < 0)
>  			return ret;
>  	}
>  
> @@ -535,7 +535,7 @@ static int mr75203_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
>  
>  	ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
> -	if(ret < 0)
> +	if (ret < 0)
>  		return ret;
>  
>  	ts_num = (val & TS_NUM_MSK) >> TS_NUM_SFT;
