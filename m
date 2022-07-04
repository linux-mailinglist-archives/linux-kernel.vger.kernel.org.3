Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC304565243
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiGDK1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiGDK1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:27:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462261B7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:27:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e28so12853395wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 03:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MNMbHzD5KJ2JcIG/LcIbHrbNKAV7LgAJDZBxOs+MMBg=;
        b=xDRar0wJQ9XQz56re9IzVmxtqbfUAqTpqrFvPCBARJpDxuIfgvN6Fy+4mtKSCxUmfK
         wfWvythZm9Vbwc834ew6Ndxa5/rQ5wnzBxMP6GvjO1B532xE1Te7AS8+iOI+bAY0Cswy
         DfTEITQZABwbPx5SItE8bdl/iu0Ia/WNX9elACWdcHQIkySkKDQhdbgLkE3clnerLqdQ
         oX1Kbjo8Z0YP4Q0dHb/zb1CuKB36+g3WgQgHMQl/dTKaOo1IHbnXx7HUHgcAtZAAYDhF
         F1OXCaLVoY2C+HvLqFnBRUTLjf/9BoFLpNzLUK7k2GbyGkVwJklwtsOryCH2ck6rM2KN
         oGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MNMbHzD5KJ2JcIG/LcIbHrbNKAV7LgAJDZBxOs+MMBg=;
        b=B4ud5hODtwYYmXlopVx8Kl90BYxMmqVJ8ji7wsnXKYFUv3YLTj6XmJ1fJmZam/XblB
         +asXlSpjN/doWBDI4T/q+Kgr3q532S9FioSWblKl1LVhBzPSrwDP9CEg2GIGcuEUP1fV
         IG7zkhBOcPOII90WHs8MAZM+HE14TH5/IGpV4NYP6NH2acIV0pGsAjSXEIomSwKtXfb2
         27YJidLiQvzJN657UgVXdnR1fu1zU85neZIuxwkpJAHwvuUD/HSJoIVNgJVeYhDEzUiK
         6FbX9ZjZRBRePiOiHO1cVS+H74rVlWcUJwM/jgyg8OJcSa680gSmnKd1qITlahqjL6tn
         Wq+A==
X-Gm-Message-State: AJIora97xuxD7atKulZZoREAzM2/NbdOorbFySFKP7ttBRSjtJ1AeAwq
        sgt9w29VYW36m3Vbu9ExXa+Qdw==
X-Google-Smtp-Source: AGRyM1uPUOOvSF+3QtJTrc9fFHW7coliowWFbjsxeXjWAHdQgEuOMh+pCY7mH+x9RPCRyi6EZgjCZw==
X-Received: by 2002:adf:db89:0:b0:21b:84a6:9cce with SMTP id u9-20020adfdb89000000b0021b84a69ccemr27149004wri.675.1656930424833;
        Mon, 04 Jul 2022 03:27:04 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c144900b0039ee51fda45sm19169045wmi.2.2022.07.04.03.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 03:27:04 -0700 (PDT)
Date:   Mon, 4 Jul 2022 11:27:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Helmut Grohne <helmut.grohne@intenta.de>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/2] mfd: da9062: enable being a
 system-power-controller
Message-ID: <YsLAdjpBIYBda1Dv@google.com>
References: <bafccf43111a24e20fb36c46740d650dedda04c0.1656418366.git.helmut.grohne@intenta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bafccf43111a24e20fb36c46740d650dedda04c0.1656418366.git.helmut.grohne@intenta.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022, Helmut Grohne wrote:

> The DA9062 can be the device used to power the CPU. In that case, it can
> be used to power off the system. In the CONTROL_A register, the M_*_EN
> bits must be zero for the corresponding *_EN bits to have an effect. We
> zero them all to turn off the system.
> 
> Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
> ---
>  drivers/mfd/da9062-core.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> Compared to v2, this addresses the following concerns raised by Lee Jones:
>  * Drop unnecessary comment.
>  * Restructure da9062_power_off to avoid unnecessary assignments.
>  * Make power off failure message user friendly while still including
>    the error code for diagnostics.
> 
> Lee Jones also questioned the utility of warning about pm_power_off already
> being assigned:
> 
> > Do we really mind/care?
> >
> > Is there anything we can do about it?
> >
> > Thus, do we really need to warn() about it?
> 
> I do think this is useful, because it only happens when two nodes decalare
> being a system-power-controller. It is a misconfiguration of your device tree
> that is being warned here. Other drivers (e.g. rn5t618.c, act8865-regulator.c,
> rtc-jz4740.c, and bcm2835_wdt.c) issue a similar warning.
> 
> I note that Adam Thomson reviewed v2. Thank you. I did not include the
> Reviewed-by, because noticeable code changed compared to what was reviewed.
> 
> As pointed out by Adam Thomson, this version still uses regmap (and possibly
> mutexes) in pm_power_off (with irqs disabled). This is a fundamental problem
> shared with many other pm_power_off hooks.
> 
> I've now included Rob Herring's Acked-by on the second patch as the rebase was
> trivial.
> 
> Helmut
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 2774b2cbaea6..0083a2756f28 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -620,6 +620,26 @@ static const struct of_device_id da9062_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, da9062_dt_ids);
>  
> +static struct i2c_client *da9062_i2c_client;
> +
> +static void da9062_power_off(void)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(
> +		((struct
> da9062*)i2c_get_clientdata(da9062_i2c_client))->regmap,

This is ugly.  Please pull this out of the function args and separate
the whole thing.  No func()->attribute craziness please.

> +		DA9062AA_CONTROL_A,
> +		DA9062AA_SYSTEM_EN_MASK | DA9062AA_POWER_EN_MASK |
> +			DA9062AA_POWER1_EN_MASK | DA9062AA_M_SYSTEM_EN_MASK |
> +			DA9062AA_M_POWER_EN_MASK | DA9062AA_M_POWER1_EN_MASK,
> +		0
> +	);
> +
> +	if (ret < 0)
> +		dev_err(&da9062_i2c_client->dev,
> +			"failed to power the system off (err=%d)\n", ret);

Either start with a uppercase char, or don't.  Please be consistent.

> +}
> +
>  static int da9062_i2c_probe(struct i2c_client *i2c,
>  	const struct i2c_device_id *id)
>  {
> @@ -720,6 +740,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>  
> +	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
> +		if (!pm_power_off) {
> +			da9062_i2c_client = i2c;
> +			pm_power_off = da9062_power_off;
> +		} else {
> +			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
> +		}
> +	}
> +
>  	return ret;
>  }
>  
> @@ -727,6 +756,11 @@ static int da9062_i2c_remove(struct i2c_client *i2c)
>  {
>  	struct da9062 *chip = i2c_get_clientdata(i2c);
>  
> +	if (pm_power_off == da9062_power_off)
> +		pm_power_off = NULL;
> +	if (da9062_i2c_client)
> +		da9062_i2c_client = NULL;
> +
>  	mfd_remove_devices(chip->dev);
>  	regmap_del_irq_chip(i2c->irq, chip->regmap_irq);
>  

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
