Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9044BC8DA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242405AbiBSOcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:32:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiBSOc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:32:29 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3313D60D8B;
        Sat, 19 Feb 2022 06:32:10 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id x3so20676599qvd.8;
        Sat, 19 Feb 2022 06:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1zwvjXkPIV7WfWDZ6hn1K8yMjcYpSi6BP/nq2Cbk7lY=;
        b=gveXzipz/SMfvQ32jp3WdP/98a8gc0cFUgY4OQEsuKmr1b3CgwhDzqvMpux5DYNeUP
         jeB/gbuBlTVZAbuODqQRuljvQGLhTOezc1PkJrNySKchNIS8eQNgrF5xdZshGd/MD4xL
         lkdFftlKoD6oc/WFxtUn64PRr2fiNbaTApMs2uZ1tbFy7TuMRYx8KdSDMAM/azG/JMdj
         9wAsEZVGOazspIv5SxqYbLF92ABPUYo63jDJpmzbeIWwNjekXarEOBStppmzPk1TRC8K
         vlrPLN1+y/et8vK8z/0Gn/8wSOJTVsYuN5hP1KY/B826iD6Jcn/khLxyz2ACeiE8FrJz
         f3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1zwvjXkPIV7WfWDZ6hn1K8yMjcYpSi6BP/nq2Cbk7lY=;
        b=TQjxoGm5BAuKNLvje7Zspp/tM7zwZy9Z+sUoozxIsECrl1qhlcpWsVe5lAEymaSsot
         fM1enOYCQ2CHJcV7fiF1LXRuFXFVgU+nSkMNmm/IXJYgHs642XOgtXpKZ7KdJkCXd8g6
         gwh6pTnpbW9inQAuB80N5JOIjSaUIYndiMWiM2O1Qbs32MHCokfiCKu601vdij15en/v
         nOScj6NljITZHHqWo87qDN4UklIhkZ09oKyOvMLMZhCA3PUNLgqdG8MLbjbp/WhIJEYd
         peirKqM2cYJ19mslWRIOEv5B8KQ6/tnsdMMKXbk/GVQxnLBI8PCweSKQPW6x9+9W2R2Y
         Larg==
X-Gm-Message-State: AOAM5327rT6ErCpzx++AnoS1qjNpAtYxpvlKiHT+o8cpnZ3R6Y1n57TS
        LL6KlqRGzrCbLE0LmuTygsk=
X-Google-Smtp-Source: ABdhPJzwlceKLP30tLpZchqTymlHP2GAuvKAPYgkdJ4dkTEuXOerZaVrlanDQe7Smw9hPxs7IkfJfw==
X-Received: by 2002:a05:622a:3ce:b0:2cc:96a3:a303 with SMTP id k14-20020a05622a03ce00b002cc96a3a303mr11192272qtx.73.1645281129179;
        Sat, 19 Feb 2022 06:32:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3sm21845263qkp.54.2022.02.19.06.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 06:32:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Feb 2022 06:32:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (pmbus) Add get_error_flags support to
 regulator ops
Message-ID: <20220219143206.GA1031166@roeck-us.net>
References: <20220219000359.19985-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219000359.19985-1-zev@bewilderbeest.net>
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

On Fri, Feb 18, 2022 at 04:03:59PM -0800, Zev Weiss wrote:
> The various PMBus status bits don't all map perfectly to the more
> limited set of REGULATOR_ERROR_* flags, but there's a reasonable
> number where they correspond well enough.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Changes since v1 [0]:
>  - split patch out of power-efuse driver series
>  - simplified pmbus_get_status() call
>  - added comment explaining PB_STATUS_{IOUT_OC,VOUT_OV} checks
>  - added fallback PB_STATUS_TEMPERATURE check mapping it to
>    REGULATOR_ERROR_OVER_TEMP_WARN
> 
> [0] https://lore.kernel.org/openbmc/20220217104444.7695-2-zev@bewilderbeest.net/
> 
>  drivers/hwmon/pmbus/pmbus_core.c | 109 +++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 776ee2237be2..6f05c271bdf8 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2417,10 +2417,119 @@ static int pmbus_regulator_disable(struct regulator_dev *rdev)
>  	return _pmbus_regulator_on_off(rdev, 0);
>  }
>  
> +/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
> +struct pmbus_regulator_status_assoc {
> +	int pflag, rflag;
> +};
> +
> +/* PMBus->regulator bit mappings for a PMBus status register */
> +struct pmbus_regulator_status_category {
> +	int func;
> +	int reg;
> +	const struct pmbus_regulator_status_assoc *bits; /* zero-terminated */
> +};
> +
> +static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
> +	{
> +		.func = PMBUS_HAVE_STATUS_VOUT,
> +		.reg = PMBUS_STATUS_VOUT,
> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
> +			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
> +			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
> +			{ },
> +		},
> +	}, {
> +		.func = PMBUS_HAVE_STATUS_IOUT,
> +		.reg = PMBUS_STATUS_IOUT,
> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
> +			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
> +			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
> +			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
> +			{ },
> +		},
> +	}, {
> +		.func = PMBUS_HAVE_STATUS_TEMP,
> +		.reg = PMBUS_STATUS_TEMPERATURE,
> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
> +			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
> +			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
> +			{ },
> +		},
> +	},
> +};
> +
> +static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
> +{
> +	int i, status;
> +	const struct pmbus_regulator_status_category *cat;
> +	const struct pmbus_regulator_status_assoc *bit;
> +	struct device *dev = rdev_get_dev(rdev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +	u8 page = rdev_get_id(rdev);
> +	int func = data->info->func[page];
> +
> +	*flags = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(pmbus_regulator_flag_map); i++) {
> +		cat = &pmbus_regulator_flag_map[i];
> +		if (!(func & cat->func))
> +			continue;
> +
> +		status = pmbus_read_byte_data(client, page, cat->reg);
> +		if (status < 0)
> +			return status;
> +
> +		for (bit = cat->bits; bit->pflag; bit++) {
> +			if (status & bit->pflag)
> +				*flags |= bit->rflag;
> +		}
> +	}
> +
> +	/*
> +	 * Map what bits of STATUS_{WORD,BYTE} we can to REGULATOR_ERROR_*
> +	 * bits.  Some of the other bits are tempting (especially for cases
> +	 * where we don't have the relevant PMBUS_HAVE_STATUS_*
> +	 * functionality), but there's an unfortunate ambiguity in that
> +	 * they're defined as indicating a fault *or* a warning, so we can't
> +	 * easily determine whether to report REGULATOR_ERROR_<foo> or
> +	 * REGULATOR_ERROR_<foo>_WARN.
> +	 */
> +	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
> +	if (status < 0)
> +		return status;
> +
> +	if (pmbus_regulator_is_enabled(rdev) && (status & PB_STATUS_OFF))
> +		*flags |= REGULATOR_ERROR_FAIL;
> +
> +	/*
> +	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
> +	 * defined strictly as fault indicators (not warnings).
> +	 */
> +	if (status & PB_STATUS_IOUT_OC)
> +		*flags |= REGULATOR_ERROR_OVER_CURRENT;
> +	if (status & PB_STATUS_VOUT_OV)
> +		*flags |= REGULATOR_ERROR_REGULATION_OUT;
> +
> +	/*
> +	 * If we haven't discovered any thermal faults or warnings via
> +	 * PMBUS_STATUS_TEMPERATURE, map PB_STATUS_TEMPERATURE to a warning as
> +	 * a (conservative) best-effort interpretation.
> +	 */
> +	if (!(*flags & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN))
> +	    && (status & PB_STATUS_TEMPERATURE))
> +		*flags |= REGULATOR_ERROR_OVER_TEMP_WARN;
> +
> +	return 0;
> +}
> +
>  const struct regulator_ops pmbus_regulator_ops = {
>  	.enable = pmbus_regulator_enable,
>  	.disable = pmbus_regulator_disable,
>  	.is_enabled = pmbus_regulator_is_enabled,
> +	.get_error_flags = pmbus_regulator_get_error_flags,
>  };
>  EXPORT_SYMBOL_NS_GPL(pmbus_regulator_ops, PMBUS);
>  
