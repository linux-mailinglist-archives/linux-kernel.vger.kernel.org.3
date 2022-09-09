Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71515B2C0E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 04:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiIICSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 22:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiIICSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:18:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216C8D418E;
        Thu,  8 Sep 2022 19:18:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f24so502593plr.1;
        Thu, 08 Sep 2022 19:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=0EaT3oPCBDU5Z7kWWvo6cn5ct86HBA+ojESaUDUfzao=;
        b=PfFNrlZDEZxep2/Ixh3gWYW/hDC4f4kRILLVZY+MPvDOhnfAps+oC0mAoC4zy9I8u0
         FlDs05Uhk/m9ppERIgElnZ2mq75y2tp7C8Q7exQPr0j2PNDoxi2/uhXfJpTkwD5p1HA3
         MFGjfDxHKb/A2lDT7VFDXAaok18PgO4VLuwDgYAqUD/zdDsLRB/TDfhkVRS2eesg5Tqg
         Td9ZWCCMhaSJ9gTmzcKcaGgZ80FdAxfTT1F+zAPiCSYMenQHl/cPsMTaiJOZWjb/jic6
         6TLD2EEsBgvG3tm6/qudvhyp1a2nrmRsG2QRXRA/tsGFOqT+UtXy7w8XLDnG9AgVaSrM
         P+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0EaT3oPCBDU5Z7kWWvo6cn5ct86HBA+ojESaUDUfzao=;
        b=G8uXhDovPTNYm98roWTmMwMC7dYUsXTE2ILbbhyeG6q8ihvkVWsvJD5WRQg5S92mjT
         XEpRmSrqOUL3fBGlKUHPpph2vj5hw2voq00OF3gGq/z/2B3uFcku4lIYmIqELaeVlue/
         FiSU/gk255+OaCshdFEnYWTh4HXAB5OHC2nr3qid3F2OS2dGrWkEPSxM13dJLMxRHIVu
         i8303QC8XOs4cXHMhf3haLeE2FKL9TwjdecygwZxQkUjEqzBm3hC6jOlN6lUrHcslpGf
         jv4IEt1AwB2Ya9Pv0FPEU7ApzD+JFKek6eZdI0QZjYRWfL2H7FrWaGGMXII9c5KdPNLe
         Gu2A==
X-Gm-Message-State: ACgBeo17exXrcQ71mPIMiPgQd/xaW9y9y3tt6Wit60+1hG9BuSWMhND2
        odaKnTfCvsB0UAss1FH0wbJwj1cGgyEWzw==
X-Google-Smtp-Source: AA6agR5EbuJ/5g3En53qApXKot3Jz4yn2Jk+lVAgn21GxoeTzUgkpl/uNAL1HKQEf7Z5lESUOlQLzg==
X-Received: by 2002:a17:90b:3d04:b0:200:9d93:f6f with SMTP id pt4-20020a17090b3d0400b002009d930f6fmr7022135pjb.185.1662689926685;
        Thu, 08 Sep 2022 19:18:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y81-20020a626454000000b0053ee5c7b9fbsm325160pfb.99.2022.09.08.19.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 19:18:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Sep 2022 19:18:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 09/21] hwmon: (mr75203) skip reset-control deassert
 for SOCs that don't support it
Message-ID: <20220909021845.GA4179532@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-10-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-10-farbere@amazon.com>
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

On Thu, Sep 08, 2022 at 03:24:37PM +0000, Eliav Farber wrote:
> Don't fail the probe function and don't deassert the reset controller if
> a "reset" property doesn't exist in the device tree.
> 
> Change is done for SOCs that don't support a reset controller.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> V3 -> v2:
> - Change "reset" property to be optional instead of skipping it.
> 
>  drivers/hwmon/mr75203.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 41e3d3b54baf..19ec9fb91202 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -551,14 +551,17 @@ static int mr75203_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	pvt->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	pvt->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
>  	if (IS_ERR(pvt->rst))
>  		return dev_err_probe(dev, PTR_ERR(pvt->rst),
>  				     "failed to get reset control\n");
>  
> -	ret = pvt_reset_control_deassert(dev, pvt);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
> +	if (pvt->rst) {
> +		ret = pvt_reset_control_deassert(dev, pvt);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "cannot deassert reset control\n");
> +	}
>  
>  	ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
>  	if(ret < 0)
