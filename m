Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8204C5D93
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 17:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiB0Qrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 11:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiB0Qrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 11:47:43 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32D96D3AA;
        Sun, 27 Feb 2022 08:47:06 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so15267751ooi.0;
        Sun, 27 Feb 2022 08:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0azag6v+1uR8a4wOo4OrSJQed/Lyr2YVQstG09jLzok=;
        b=cpC96hMhyn1TjUGPC9TRaLCMQ4VOgWtXdO94E8dvyc920DWhOwAZbhiLrI9D6MABfH
         A3RHYZ2JBnqCwYdptFdIGEpRyMS9HwfwSfXousRDrQg/eBC/USbs/KZSjWiAVia/H5pL
         QGGAGjwSPQtapxzKW9N8JbvLpLNFKsohaJVKVNokV6EyLDLz4c9dsLvBlMm3206XTkJE
         TzqHcpePDEm4z4o1f4Fy+SxJx7HoXSoUZNdpBVI5x3NMq/G+3mwHZOS1lbHU1SSOPbOm
         7BH/znH3bKOe8uoOynKU0Ls6pzkp5DyrPJpYfi6jFVRfBCcdyWcXA/vxnGbBsrXjtWMq
         uaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0azag6v+1uR8a4wOo4OrSJQed/Lyr2YVQstG09jLzok=;
        b=kWiV3YrpWBCwAo6OigoxsoBOSj4iXKn9JMLo1D13CGp3iqCwg7qc0PAweum7rzuv1C
         +tCEVKWRBAdrji3Uaw/iZhLnpwOsZ34PAFoGKsK93ne9ArzAGaecZXuZt8BJoajdv908
         pcRo/s1o7lHJVBKHZtdGA/PaoHH3oW/ExGIkFBqOTlBFHItUmqCqwULGCbCdU0BbQ4+i
         fggENEAE6zR2PfSd0P+zWzujCWnPJpDwrvfUbg4qYze2FNIXFhVpl5cX/YqJQ1kXEzom
         AH8eKEcKFV0WkoW4N7MRY4EXO5bJ+MjSbFgccVA9eyE2D8hdh56XQ0qQl/tX2VG+vJ7I
         Jx6A==
X-Gm-Message-State: AOAM533chfev6wVooicloo/FupwTv6F79NjG0Wx5+DXltA1kVS+PkLmE
        m5AqbUjslv51Txc/voEM3hionyhnBsg=
X-Google-Smtp-Source: ABdhPJxrxnOZDPvTUEmdwCqnTqk/iFs/KDFhn/UCHij28wbX278PsT325gjmys9on712wAAOOV0IBQ==
X-Received: by 2002:a05:6871:80e:b0:d7:3c9:6afa with SMTP id q14-20020a056871080e00b000d703c96afamr3428362oap.126.1645980426297;
        Sun, 27 Feb 2022 08:47:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a11-20020a0568300b8b00b005acfd19434asm3652761otv.75.2022.02.27.08.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 08:47:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 27 Feb 2022 08:47:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v1 1/1] drivers/hwmon/pmbus: Add mutex to regulator ops
Message-ID: <20220227164704.GA770993@roeck-us.net>
References: <b991506bcbf665f7af185945f70bf9d5cf04637c.1645804976.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b991506bcbf665f7af185945f70bf9d5cf04637c.1645804976.git.sylv@sylv.io>
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

On Fri, Feb 25, 2022 at 05:06:09PM +0100, Marcello Sylvester Bauer wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> On PMBUS devices with multiple pages, the regulator ops need to be
> protected with the update mutex. This prevents accidentally changing
> the page in a separate thread while operating on the PMBUS_OPERATION
> register.
> 
> Tested on Infineon xdpe11280 while a separate thread polls for sensor
> data.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>

Good catch. Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 776ee2237be2..f79930162256 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2386,10 +2386,14 @@ static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
>  {
>  	struct device *dev = rdev_get_dev(rdev);
>  	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
>  	u8 page = rdev_get_id(rdev);
>  	int ret;
>  
> +	mutex_lock(&data->update_lock);
>  	ret = pmbus_read_byte_data(client, page, PMBUS_OPERATION);
> +	mutex_unlock(&data->update_lock);
> +
>  	if (ret < 0)
>  		return ret;
>  
> @@ -2400,11 +2404,17 @@ static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
>  {
>  	struct device *dev = rdev_get_dev(rdev);
>  	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
>  	u8 page = rdev_get_id(rdev);
> +	int ret;
>  
> -	return pmbus_update_byte_data(client, page, PMBUS_OPERATION,
> -				      PB_OPERATION_CONTROL_ON,
> -				      enable ? PB_OPERATION_CONTROL_ON : 0);
> +	mutex_lock(&data->update_lock);
> +	ret = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
> +				     PB_OPERATION_CONTROL_ON,
> +				     enable ? PB_OPERATION_CONTROL_ON : 0);
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
>  }
>  
>  static int pmbus_regulator_enable(struct regulator_dev *rdev)
