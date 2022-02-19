Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C074BC8DB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242409AbiBSOdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:33:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240738AbiBSOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:33:35 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747C160D8B;
        Sat, 19 Feb 2022 06:33:16 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h9so20735536qvm.0;
        Sat, 19 Feb 2022 06:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3B8WyFvP/lKwQqeUTl53oNABZ4hmqxp7hX7jbuZVxDs=;
        b=egXeUnwwZlqwiPRmNQr0z5mDu7WHQU6xpt9TmLrotx6SJHeWj15jgoAchXH0nNqXRv
         cFrMk+uxOWF0Abvhh8/nMVyni8D03NvLxCE6gORbnfNG0w14u+0LmLsRtwQFPo8Xncv0
         JCwh45yO8mhs1gkb68Z+CoGC5hbr6a76exY4b9MTCYjfztOgWJ1NSl9BlO8WM3ytk7Vw
         MpuZ0l3n+j8BWwPFToSSp4I3iIphdjDtdC8SpkGsYTVE57+MF4HTxRrVHk9wotO8zRHr
         rYUBZzbuhA9SpnoHnEV6rB+1c+4LXNELk2Qw+fHnO9s3UUHLAaXdtVd5+jaKOiwSUDCj
         NnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3B8WyFvP/lKwQqeUTl53oNABZ4hmqxp7hX7jbuZVxDs=;
        b=QFIbr5bWjXOdmu0YegXmqIQfNUnFi6BI32cQEiYqeGIIL0Efnip3tZWnbyhB8VwjSS
         PRts7QNgvSK2jWnsbXQPUnimF7OFrBjPV1Dl6eHzECUgb03GsPj8i+Ed6wtU2QdQQjuS
         +Vz944CJdsjhhh4F0VowNIDpdsNINwmjVuJ9xZMx8BGh4M/uyyDAjuXYq3HFLGSnfFLo
         j1Nl2mm1t7EVCdLrw156u1UKyqLyVfu8BwZs7C7jHfLGc4uB90AZxMvrAG1HRM8NM4W1
         ZFl+vPYuZi+ldpyUcrOesvGzz4JuAokSFgVs5qe8/SHRrqjyezWcn+qUY3Alba+RjrNy
         NQsw==
X-Gm-Message-State: AOAM531mknl+alRNoAvK3NqHXJDGSbo6FkHdJo+TBcKC0nqXyk1Hi8zT
        ezic2IfU2RxXb7oqy7sHoraBkd7GLS6xvg==
X-Google-Smtp-Source: ABdhPJxvgGMNb8MooB0Ygfw+d7YS3pbd1g9kx0v0EFlsADLntxlC7GQopoe45oftlruKCRFRcaDZhg==
X-Received: by 2002:a05:6214:246b:b0:42c:1c8c:a70a with SMTP id im11-20020a056214246b00b0042c1c8ca70amr9579383qvb.3.1645281195557;
        Sat, 19 Feb 2022 06:33:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v17sm1293445qtx.97.2022.02.19.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 06:33:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Feb 2022 06:33:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (pmbus) lm25066: Add regulator support
Message-ID: <20220219143313.GA1031345@roeck-us.net>
References: <20220219000742.20126-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219000742.20126-1-zev@bewilderbeest.net>
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

On Fri, Feb 18, 2022 at 04:07:42PM -0800, Zev Weiss wrote:
> While these chips aren't strictly advertised as voltage regulators per
> se, they (aside from the lm25056) support the PMBus OPERATION command
> to enable and disable their outputs and have status bits for reporting
> various warnings and faults, and can hence usefully support all the
> pmbus_regulator_ops operations.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Changes since v1 [0]:
>  - split out of power-efuse driver series
> 
> [0] https://lore.kernel.org/openbmc/20220217104444.7695-3-zev@bewilderbeest.net/
> 
>  drivers/hwmon/pmbus/Kconfig   |  7 +++++++
>  drivers/hwmon/pmbus/lm25066.c | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index c96f7b7338bd..c73aa50c7615 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -174,6 +174,13 @@ config SENSORS_LM25066
>  	  This driver can also be built as a module. If so, the module will
>  	  be called lm25066.
>  
> +config SENSORS_LM25066_REGULATOR
> +	bool "Regulator support for LM25066 and compatibles"
> +	depends on SENSORS_LM25066 && REGULATOR
> +	help
> +	  If you say yes here you get regulator support for National
> +	  Semiconductor LM25066, LM5064, and LM5066.
> +
>  config SENSORS_LTC2978
>  	tristate "Linear Technologies LTC2978 and compatibles"
>  	help
> diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
> index 8402b41520eb..09792cd03d9f 100644
> --- a/drivers/hwmon/pmbus/lm25066.c
> +++ b/drivers/hwmon/pmbus/lm25066.c
> @@ -435,6 +435,12 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
>  	return ret;
>  }
>  
> +#if IS_ENABLED(CONFIG_SENSORS_LM25066_REGULATOR)
> +static const struct regulator_desc lm25066_reg_desc[] = {
> +	PMBUS_REGULATOR("vout", 0),
> +};
> +#endif
> +
>  static const struct i2c_device_id lm25066_id[] = {
>  	{"lm25056", lm25056},
>  	{"lm25066", lm25066},
> @@ -545,6 +551,14 @@ static int lm25066_probe(struct i2c_client *client)
>  	info->m[PSC_CURRENT_IN] = info->m[PSC_CURRENT_IN] * shunt / 1000;
>  	info->m[PSC_POWER] = info->m[PSC_POWER] * shunt / 1000;
>  
> +#if IS_ENABLED(CONFIG_SENSORS_LM25066_REGULATOR)
> +	/* LM25056 doesn't support OPERATION */
> +	if (data->id != lm25056) {
> +		info->num_regulators = ARRAY_SIZE(lm25066_reg_desc);
> +		info->reg_desc = lm25066_reg_desc;
> +	}
> +#endif
> +
>  	return pmbus_do_probe(client, info);
>  }
>  
