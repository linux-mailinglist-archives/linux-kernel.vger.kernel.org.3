Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEA5516A3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 07:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383301AbiEBFTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 01:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242649AbiEBFTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 01:19:46 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2286AB7C;
        Sun,  1 May 2022 22:16:19 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-ed8a3962f8so3320709fac.4;
        Sun, 01 May 2022 22:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lORRpPwxQ+ihCpV3e8277it0sFWbS7hubWntdISnTcc=;
        b=EqBzMJ4UtGwq7xxTMWsf3CL0oL8oMU9/bwJjdysDLvKxTnXzzwq9NcNpp2XrTQTaYh
         mEYO7GZ/14PGglT+CoAkAI9qqbN3kAD9O+AvN5py0BVXmyKJt2MOzjyHvRvQxZYgbXvE
         T2GqDOVglA1/EqTaFpzzl9RwUIppyYFQe2RzSuKCBDLaF+8NWIpT4/8eTIidZhQy6JMR
         vH4XvciWR61q5ocYxnplCdlBwpcZo3EN9vJv4DhoLGLHa8j7n+EV68FpKpR5sL8sCSYM
         qiUoSFKfKE2xerXgiDOFX7mx/mXNVsv/oCFiwaL/5dO4z02pUxXraZ2Vcnb5XHXfJ8O+
         Timg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lORRpPwxQ+ihCpV3e8277it0sFWbS7hubWntdISnTcc=;
        b=Kh0gZTLrreIk5MnNxtPejngfSCnumWbXuZ6HDlQq1+PF3TdLlYgPuZSeosPqO6Pa9D
         oPQuPusS/EOa9HupZ0wzgmYJxWcJOWBjgywPG0kpz4od0sIvth7IInOSW3WzmtBTBcBK
         eoBKhI5gwCoqlnaX5ZfT+WhaTuSzR0qkVBIfYm32Tf4Nl0Ymb6FKgeoixUSQmr9qTtDH
         W5LwscoeQvTWKoRXUcHcGJZ9Dkh6C5qBQRvdxHuK0NcOeHfonlaPKl6eyndbDprcbtMW
         IEyYKRsvoU68ynhAWqMfOGBnmQLM4V1Cq5i+pjuZ9axp4w+tGUgc1C5NHMbdzLqHhkhm
         dAnw==
X-Gm-Message-State: AOAM532sc5QwgPTENy+jTtzGvI0Hj1fJp05AHjaWBpXREiekMws4eMDH
        mEPtvDE0j70Zb41LdC+oIuA=
X-Google-Smtp-Source: ABdhPJwJjEB331fbENKh6dmPgCGgRl7ty7pWiZPdQsP+vX4QXBX2Y08YSnbcwpR7wemtvuMMdglRdA==
X-Received: by 2002:a05:6870:1785:b0:e5:9292:b664 with SMTP id r5-20020a056870178500b000e59292b664mr5908927oae.260.1651468578497;
        Sun, 01 May 2022 22:16:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n20-20020a4ac714000000b00333301670dcsm3563616ooq.2.2022.05.01.22.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 22:16:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 1 May 2022 22:16:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eduardo Valentin <evalenti@kernel.org>
Subject: Re: [PATCHv2 1/1] drivers: hwmon: pmbus: register with thermal for
 PSC_TEMPERATURE
Message-ID: <20220502051616.GA2146180@roeck-us.net>
References: <20220428174926.2150-1-eduval@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428174926.2150-1-eduval@amazon.com>
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

On Thu, Apr 28, 2022 at 10:49:26AM -0700, Eduardo Valentin wrote:
> Some pmbus device drivers have device tree support and
> may want to use of-thermal to register a thermal zone
> OF sensor for those device drivers.
> 
> This way we allow describing device tree thermal zones
> for pmbus device drivers with device tree support.
> 
> This patch achieves this by registering pmbus sensors
> with thermal subsystem if they are PSC_TEMPERATURE
> and are providing _input hwmon interface.
> 
> Cc: Guenter Roeck <linux@roeck-us.net> (maintainer:PMBUS HARDWARE MONITORING DRIVERS)
> Cc: Jean Delvare <jdelvare@suse.com> (maintainer:HARDWARE MONITORING)
> Cc: linux-hwmon@vger.kernel.org (open list:PMBUS HARDWARE MONITORING DRIVERS)
> Cc: linux-kernel@vger.kernel.org (open list)
> Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Eduardo Valentin <evalenti@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> V2: Incorporated Guenter's suggestion to use pmbus_data as field of pmbus_thermal_data.
> 
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 68 ++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 776ee2237be2..371d16e3bac6 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -19,6 +19,8 @@
>  #include <linux/pmbus.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/of.h>
> +#include <linux/thermal.h>
>  #include "pmbus.h"
>  
>  /*
> @@ -1078,6 +1080,68 @@ static int pmbus_add_boolean(struct pmbus_data *data,
>  	return pmbus_add_attribute(data, &a->dev_attr.attr);
>  }
>  
> +/* of thermal for pmbus temperature sensors */
> +struct pmbus_thermal_data {
> +	struct pmbus_data *pmbus_data;
> +	struct pmbus_sensor *sensor;
> +};
> +
> +static int pmbus_thermal_get_temp(void *data, int *temp)
> +{
> +	struct pmbus_thermal_data *tdata = data;
> +	struct pmbus_sensor *sensor = tdata->sensor;
> +	struct pmbus_data *pmbus_data = tdata->pmbus_data;
> +	struct i2c_client *client = to_i2c_client(pmbus_data->dev);
> +	struct device *dev = pmbus_data->hwmon_dev;
> +	int ret = 0;
> +
> +	if (!dev) {
> +		/* May not even get to hwmon yet */
> +		*temp = 0;
> +		return 0;
> +	}
> +
> +	mutex_lock(&pmbus_data->update_lock);
> +	pmbus_update_sensor_data(client, sensor);
> +	if (sensor->data < 0)
> +		ret = sensor->data;
> +	else
> +		*temp = (int)pmbus_reg2data(pmbus_data, sensor);
> +	mutex_unlock(&pmbus_data->update_lock);
> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_of_device_ops pmbus_thermal_ops = {
> +	.get_temp = pmbus_thermal_get_temp,
> +};
> +
> +static int pmbus_thermal_add_sensor(struct pmbus_data *pmbus_data,
> +				    struct pmbus_sensor *sensor, int index)
> +{
> +	struct device *dev = pmbus_data->dev;
> +	struct pmbus_thermal_data *tdata;
> +	struct thermal_zone_device *tzd;
> +
> +	tdata = devm_kzalloc(dev, sizeof(*tdata), GFP_KERNEL);
> +	if (!tdata)
> +		return -ENOMEM;
> +
> +	tdata->sensor = sensor;
> +	tdata->pmbus_data = pmbus_data;
> +
> +	tzd = devm_thermal_zone_of_sensor_register(dev, index, tdata,
> +						   &pmbus_thermal_ops);
> +	/*
> +	 * If CONFIG_THERMAL_OF is disabled, this returns -ENODEV,
> +	 * so ignore that error but forward any other error.
> +	 */
> +	if (IS_ERR(tzd) && (PTR_ERR(tzd) != -ENODEV))
> +		return PTR_ERR(tzd);
> +
> +	return 0;
> +}
> +
>  static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
>  					     const char *name, const char *type,
>  					     int seq, int page, int phase,
> @@ -1121,6 +1185,10 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
>  	sensor->next = data->sensors;
>  	data->sensors = sensor;
>  
> +	/* temperature sensors with _input values are registered with thermal */
> +	if (class == PSC_TEMPERATURE && strcmp(type, "input") == 0)
> +		pmbus_thermal_add_sensor(data, sensor, seq);
> +
>  	return sensor;
>  }
>  
