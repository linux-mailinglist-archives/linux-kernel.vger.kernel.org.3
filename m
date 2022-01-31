Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779934A4B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379965AbiAaQCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiAaQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:02:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F2C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:02:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso13967352wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R1waSOXuRTWfmmibx0UOhk55aRdye0tFKHySP0f7UCg=;
        b=AcT5Kmuu8TzZMEAN89bZiKdanaqelM9NrY+pjgCqiiEESB+rpzDoHLySTdvN8xSv/h
         eiDHyqBvuq/aFTncTefK/o3Z+VGnUPEleEU8EVDaUsjnPJsE5vro1HvZw/TexpjyrYqk
         1iJ8psDadY7j0p5HPbImYPtcR18BR5W1Y8Plx1LOX43Lr6Hvoq/LwIs719nUzg8S7F8/
         3FUQqjapPe3pXqGh3lnducRmMZwkyICtJeg6wKMFND+DH6UypDy4cj0uGgDIIP9bloEz
         pBlixLpI1xUhmDAoRPWv4OoC1tCgfD6RodeOV9kPbo8tGPwt5EMvnUuHVJwdP1mCuMjm
         gFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R1waSOXuRTWfmmibx0UOhk55aRdye0tFKHySP0f7UCg=;
        b=36lfcegs00FMCMcnxRvpEbJrMBXBR/vTA34jrfqoqh5uFwWLVUhhmaW4a7K8necCBz
         EOrwG/IwV7a7uGaDBKaG6dAm/Huv7gufTARrE1o9pbGV7MtIaNjLnFw1V2Qcr0TTS5Og
         dRIQHwVpaZObtuN3BVD+MekkaHaSKL/L2u9BXwoOuYDGBLAb9wyb2xLIbJyuBPt8w3rb
         Q1cltogoWlL4W62Utzi7fBu2TQKnSTeRh3ugkR2DIMR9zToFsZX3mkXdvAu6qH4V14N5
         MZo41+Yboh8bnS3dtHFPLp8y2yegY+w258PaC8xc8qxeeziltwh1GDPvWKm8UkWBtJMp
         BG2Q==
X-Gm-Message-State: AOAM532maexz70Ac5xDqbx3PbVw4nrqAHl71egKVVyZfkibdoW84bKpr
        IzaLWYtQPA100LMcKgFtiJRLL7mUWzMvDg==
X-Google-Smtp-Source: ABdhPJyByn8SlQ+x5rOdn45Bw3uigKy3RGOLa84b9HFfjxd/UoOLRgTQVQ/3kvW4OXwH2h+ubMo7Qg==
X-Received: by 2002:a05:600c:6028:: with SMTP id az40mr27745827wmb.33.1643644951450;
        Mon, 31 Jan 2022 08:02:31 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id p15sm11978139wrq.66.2022.01.31.08.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:02:30 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:02:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mfd: rk808: add reboot support to rk808.c
Message-ID: <YfgIFM9FWkHWEnuC@google.com>
References: <20211221230550.1331047-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211221230550.1331047-1-pgwipeout@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021, Peter Geis wrote:

> This adds reboot support to the rk808 pmic driver and enables it for
> the rk809 and rk817 devices.
> This only enables if the rockchip,system-power-controller flag is set.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> (Resending due to incorrect Subject line)
> 
> This patch was created to address issues with psci-reset on rk356x
> chips. Until the rk356x series ATF open source code is released so we
> can fix the issue at the source, this is the only way to ensure reliable
> resetting on devices using these chips.
> 
> After testing the rk808 (thanks Robin!), it was found DEV_OFF_RST does
> not reset the PMIC to a power on state. Since the rk805 and rk818 match
> this register layout, I'm removing support for all three in the v2.
> It may be possible to add support to them using an RTC wakeup, but that
> has not been explored and is outside the scope of this patch.
> 
> Changelog:
> V4:
> - reorder rk808_restart_notify (Thanks Dmitry)
> - drop of_property_read_bool before unregister (Good catch Frank)
> 
> V3: Thanks Dmitry!
> - Adjust priority to be in line with other pmic drivers
> - Move ret handling to case switch
> - Make default registration debug
> - Add unregister function on removal
> 
> V2:
> - Squash the patch from Frank Wunderlich for rk809 support.
> - Remove support for the rk805, rk808, and rk818 devices.
> - Only register the reset handler for supported devices.
> - Remove unnecessary dev_err and dev_warn statements.
> - Register the reset handler directly
> 
>  drivers/mfd/rk808.c       | 44 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rk808.h |  1 +
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index b181fe401330..874d461dda44 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> +#include <linux/reboot.h>
>  
>  struct rk808_reg_data {
>  	int addr;
> @@ -543,6 +544,7 @@ static void rk808_pm_power_off(void)
>  		reg = RK808_DEVCTRL_REG,
>  		bit = DEV_OFF_RST;
>  		break;
> +	case RK809_ID:
>  	case RK817_ID:
>  		reg = RK817_SYS_CFG(3);
>  		bit = DEV_OFF;
> @@ -559,6 +561,34 @@ static void rk808_pm_power_off(void)
>  		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
>  }
>  
> +static int rk808_restart_notify(struct notifier_block *this, unsigned long mode, void *cmd)
> +{
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> +	unsigned int reg, bit;
> +	int ret;
> +
> +	switch (rk808->variant) {
> +	case RK809_ID:
> +	case RK817_ID:
> +		reg = RK817_SYS_CFG(3);
> +		bit = DEV_RST;
> +		break;
> +
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +	ret = regmap_update_bits(rk808->regmap, reg, bit, bit);
> +	if (ret)
> +		dev_err(&rk808_i2c_client->dev, "Failed to restart device!\n");
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block rk808_restart_handler = {
> +	.notifier_call = rk808_restart_notify,
> +	.priority = 192,
> +};
> +
>  static void rk8xx_shutdown(struct i2c_client *client)
>  {
>  	struct rk808 *rk808 = i2c_get_clientdata(client);
> @@ -727,6 +757,18 @@ static int rk808_probe(struct i2c_client *client,
>  	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
>  		rk808_i2c_client = client;
>  		pm_power_off = rk808_pm_power_off;
> +
> +		switch (rk808->variant) {
> +		case RK809_ID:
> +		case RK817_ID:
> +			ret = register_restart_handler(&rk808_restart_handler);
> +			if (ret)
> +				dev_warn(&client->dev, "failed to register restart handler, %d\n", ret);

This line looks very long.

I'm surprised it survived checkpatch.pl!

Once this has been fixed, please resubmit with my:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> +			break;
> +		default:
> +			dev_dbg(&client->dev, "pmic controlled board reset not supported\n");
> +			break;
> +		}
>  	}
>  
>  	return 0;
> @@ -749,6 +791,8 @@ static int rk808_remove(struct i2c_client *client)
>  	if (pm_power_off == rk808_pm_power_off)
>  		pm_power_off = NULL;
>  
> +	unregister_restart_handler(&rk808_restart_handler);
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
> index a96e6d43ca06..58602032e642 100644
> --- a/include/linux/mfd/rk808.h
> +++ b/include/linux/mfd/rk808.h
> @@ -373,6 +373,7 @@ enum rk805_reg {
>  #define SWITCH2_EN	BIT(6)
>  #define SWITCH1_EN	BIT(5)
>  #define DEV_OFF_RST	BIT(3)
> +#define DEV_RST		BIT(2)
>  #define DEV_OFF		BIT(0)
>  #define RTC_STOP	BIT(0)
>  

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
