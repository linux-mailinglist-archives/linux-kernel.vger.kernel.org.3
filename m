Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2FE57EF0E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 13:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiGWLdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 07:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiGWLdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 07:33:51 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA3644C;
        Sat, 23 Jul 2022 04:33:50 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 532FC2009D;
        Sat, 23 Jul 2022 14:33:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1658576027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UK9gk65TvY3od7Ha8VfOgKiSVkqiYJvtQsYPR9Y9tkc=;
        b=XQ//p285SaXewNX9GPDq6vxo2AQmnvue49fqtPTjsMXqHoT9Cmsg2s7uRAZ1GCjYpntdUA
        HU/0FBf06FPm6GEbt3so4f1UkNxBZykaCUv/3CyNXTnkGo3Cj1tDPr9KyhVSkFf7FnbiEV
        zgi+uEwl0kSkweZgBKvuEytmz8ynshQ=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id C3FEA634C94;
        Sat, 23 Jul 2022 14:33:46 +0300 (EEST)
Date:   Sat, 23 Jul 2022 14:33:46 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] media: i2c: ak7375: Add regulator management
Message-ID: <Ytvcmpa3aPkS9NYK@valkosipuli.retiisi.eu>
References: <20220711144039.232196-1-y.oudjana@protonmail.com>
 <20220711144039.232196-4-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711144039.232196-4-y.oudjana@protonmail.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1658576027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UK9gk65TvY3od7Ha8VfOgKiSVkqiYJvtQsYPR9Y9tkc=;
        b=xzrAnplcTNr9Cr/YyKr7xQ/dnV4cfOdgj0D5W9hbdbZ8RjTgDyY1Bz9aMVTcEa6K/cgNzQ
        MkuQAqYAGhCZECPFY4Vj4+dxmg24WrGB9x8H+TE+Xpp9xyxMeYuwtZbu8S0Vh+CRbEPpCi
        RcMacOYffSaIk6eUveUHKE23B07XPjs=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1658576027; a=rsa-sha256; cv=none;
        b=Lpp9mRfOGJBp1gAC0H2uuRqPCenc+ygZc9l01/2fMccXHo84El1+AOjN6+C5Rg087qcyu+
        dTNQ0Wkfe7oTmARMX3DuyheGNuOnxJQDpXXaaVZr4JpWasV7jgW7sb2rZACwxOAw8prhZ6
        9USqNt8vzzVmraGDsKdTBa/RQCmAamg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yassine,

Thanks for the patch.

On Mon, Jul 11, 2022 at 06:40:39PM +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Make the driver get needed regulators on probe and enable/disable
> them on runtime PM callbacks.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Changes since v1:
>   - Reorganize variable declaration
>   - Change the power-on delay range to 3000-3500 microseconds.
> 
>  drivers/media/i2c/ak7375.c | 39 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/media/i2c/ak7375.c b/drivers/media/i2c/ak7375.c
> index 40b1a4aa846c..c2b2542a0056 100644
> --- a/drivers/media/i2c/ak7375.c
> +++ b/drivers/media/i2c/ak7375.c
> @@ -6,6 +6,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
>  
> @@ -23,17 +24,32 @@
>   */
>  #define AK7375_CTRL_STEPS	64
>  #define AK7375_CTRL_DELAY_US	1000
> +/*
> + * The vcm takes around 3 ms to power on and start taking
> + * I2C messages. This value was found experimentally due to
> + * lack of documentation.
> + */
> +#define AK7375_POWER_DELAY_US	3000
>  
>  #define AK7375_REG_POSITION	0x0
>  #define AK7375_REG_CONT		0x2
>  #define AK7375_MODE_ACTIVE	0x0
>  #define AK7375_MODE_STANDBY	0x40
>  
> +static const char * const ak7375_supply_names[] = {
> +	"vdd",
> +	"vio",
> +};
> +
> +#define AK7375_NUM_SUPPLIES ARRAY_SIZE(ak7375_supply_names)

Please drop this, and use ARRAY_SIZE() directly.

> +
>  /* ak7375 device structure */
>  struct ak7375_device {
>  	struct v4l2_ctrl_handler ctrls_vcm;
>  	struct v4l2_subdev sd;
>  	struct v4l2_ctrl *focus;
> +	struct regulator_bulk_data supplies[AK7375_NUM_SUPPLIES];
> +
>  	/* active or standby mode */
>  	bool active;
>  };
> @@ -133,12 +149,24 @@ static int ak7375_probe(struct i2c_client *client)
>  {
>  	struct ak7375_device *ak7375_dev;
>  	int ret;
> +	int i;

unsigned int, please.

-- 
Kind regards,

Sakari Ailus
