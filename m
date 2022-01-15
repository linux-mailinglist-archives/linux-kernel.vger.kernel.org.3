Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521EF48F7D6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiAOQbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiAOQbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:31:25 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D14C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:31:24 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1FCCCA24;
        Sat, 15 Jan 2022 17:31:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642264282;
        bh=SKPkoj4u1M/XPVndCWVekUDTPMbBU42gAJzWiSZ/tSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfjywUnQtbJWIOkgbB9ljNhzsOcv9dwP6N+A+zlmadlXB75/Vo6NYjkqzlufkEaYz
         ETneE1V23HjKX4MgbSxuyRph54mTtIgr9tB3B8CzvhaxD5dbSHvctM1SIzU0peCpmI
         AE2jUfRuEujQkno1mKGXXgz4fF/BJ6XJ+BDvxAxU=
Date:   Sat, 15 Jan 2022 18:31:08 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Watson Chow <watson.chow@avnet.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: MAX20086: add gpio/consumer.h
Message-ID: <YeL2zLp9jsbBqMYG@pendragon.ideasonboard.com>
References: <20220115033603.24473-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220115033603.24473-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thank you for the patch.

On Fri, Jan 14, 2022 at 07:36:03PM -0800, Randy Dunlap wrote:
> max20086-regulator.c needs <linux/gpio/consumer.h> for an enum, some
> macros, and a function prototype. (seen on ARCH=m68k)
> 
> Adding this header file fixes multiple build errors:
> 
> ../drivers/regulator/max20086-regulator.c: In function 'max20086_i2c_probe':
> ../drivers/regulator/max20086-regulator.c:217:26: error: storage size of 'flags' isn't known
>   217 |         enum gpiod_flags flags;
> ../drivers/regulator/max20086-regulator.c:261:27: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
>   261 |         flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
>       |                           ^~~~~~~~~~~~~~
> ../drivers/regulator/max20086-regulator.c:261:44: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
>   261 |         flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> ../drivers/regulator/max20086-regulator.c:262:27: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
>   262 |         chip->ena_gpiod = devm_gpiod_get(chip->dev, "enable", flags);
> ../drivers/regulator/max20086-regulator.c:217:26: warning: unused variable 'flags' [-Wunused-variable]
>   217 |         enum gpiod_flags flags;
> 
> Fixes: bfff546aae50 ("regulator: Add MAX20086-MAX20089 driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Watson Chow <watson.chow@avnet.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/regulator/max20086-regulator.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20220114.orig/drivers/regulator/max20086-regulator.c
> +++ linux-next-20220114/drivers/regulator/max20086-regulator.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/err.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>

-- 
Regards,

Laurent Pinchart
