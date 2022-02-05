Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323AE4AAA67
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380546AbiBERIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348697AbiBERIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:08:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF3C061348;
        Sat,  5 Feb 2022 09:08:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A775EB80814;
        Sat,  5 Feb 2022 17:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B890C340E8;
        Sat,  5 Feb 2022 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644080928;
        bh=cE21F3sGRlbBLNbrsjc2j1xdyEfgnJJv0XLdNj69hb4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ol/Rk3aXSQou6Tf75r24sTUznf1DZHZRpkPNeHBJf2rUbq7jOFpnINSOIKuX6tL/9
         oo8If6LBy3Xp29LT94dM0lz04OKkNQa4+YZQ9sgmQnwVTuDm3PT99vZpKSWO3Ue3Zf
         CoMGrz5svQv9pytAx/ph8kZl2aVrUd0uKpsE0n627cT8qAS5d9Trdkuimd7D66sbrc
         dYNpIz0ZmdKnlFDwwRXPzJXeGOPu3Sk+281onv3JKTY2gJZlzr8mKviAcFxH6LDSeD
         C6R4f3sqQc7m6Y4RuyqMaKqOLnJsClV+z9Bgybk2mzyI5v1wQu5JaGe2VVXBNcleTK
         Jwv/6F2FD+yqw==
Date:   Sat, 5 Feb 2022 17:15:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 2/2] iio: temperature: ltc2983: Make use of device
 properties
Message-ID: <20220205171454.49a7225c@jic23-huawei>
In-Reply-To: <20220203114506.53904-2-andriy.shevchenko@linux.intel.com>
References: <20220203114506.53904-1-andriy.shevchenko@linux.intel.com>
        <20220203114506.53904-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Feb 2022 13:45:06 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.

This description needs expansion as it's not a straight forward
conversion.

Also, complex enough that I definitely want more eyes and preferably
some testing.

Thanks,

Jonathan

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/temperature/ltc2983.c | 211 +++++++++++++++---------------
>  1 file changed, 105 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index d272c303c1b0..a2fcea7d9d90 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -12,11 +12,15 @@
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
>  #include <linux/list.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
> +#include <asm/byteorder.h>
> +#include <asm/unaligned.h>
> +
>  /* register map */
>  #define LTC2983_STATUS_REG			0x0000
>  #define LTC2983_TEMP_RES_START_REG		0x0010
> @@ -219,7 +223,7 @@ struct ltc2983_sensor {
>  
>  struct ltc2983_custom_sensor {
>  	/* raw table sensor data */
> -	u8 *table;
> +	void *table;
>  	size_t size;
>  	/* address offset */
>  	s8 offset;
> @@ -377,25 +381,25 @@ static int __ltc2983_chan_custom_sensor_assign(struct ltc2983_data *st,
>  	return regmap_bulk_write(st->regmap, reg, custom->table, custom->size);
>  }
>  
> -static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
> -						struct ltc2983_data *st,
> -						const struct device_node *np,
> -						const char *propname,
> -						const bool is_steinhart,
> -						const u32 resolution,
> -						const bool has_signed)
> +static struct ltc2983_custom_sensor *
> +__ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct fwnode_handle *fn,
> +			    const char *propname, const bool is_steinhart,
> +			    const u32 resolution, const bool has_signed)
>  {
>  	struct ltc2983_custom_sensor *new_custom;
> -	u8 index, n_entries, tbl = 0;
>  	struct device *dev = &st->spi->dev;
>  	/*
>  	 * For custom steinhart, the full u32 is taken. For all the others
>  	 * the MSB is discarded.
>  	 */
>  	const u8 n_size = is_steinhart ? 4 : 3;
> -	const u8 e_size = is_steinhart ? sizeof(u32) : sizeof(u64);
> +	u8 index, n_entries;
> +	int ret;
>  
> -	n_entries = of_property_count_elems_of_size(np, propname, e_size);
> +	if (is_steinhart)
> +		n_entries = fwnode_property_count_u32(fn, propname);
> +	else
> +		n_entries = fwnode_property_count_u64(fn, propname);
>  	/* n_entries must be an even number */
>  	if (!n_entries || (n_entries % 2) != 0) {
>  		dev_err(dev, "Number of entries either 0 or not even\n");
> @@ -415,29 +419,39 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
>  	}
>  	/* Check space on the table. */
>  	if (st->custom_table_size + new_custom->size >
> -	    (LTC2983_CUST_SENS_TBL_END_REG -
> -	     LTC2983_CUST_SENS_TBL_START_REG) + 1) {
> +	    (LTC2983_CUST_SENS_TBL_END_REG - LTC2983_CUST_SENS_TBL_START_REG) + 1) {

Shouldn't really be in this patch. Or at very least call out that there is
whitespace cleanup in the patch description.

>  		dev_err(dev, "No space left(%d) for new custom sensor(%zu)",
>  				st->custom_table_size, new_custom->size);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	/* allocate the table */
> -	new_custom->table = devm_kzalloc(dev, new_custom->size, GFP_KERNEL);
> +	if (is_steinhart)
> +		new_custom->table = devm_kcalloc(dev, n_entries, sizeof(u32), GFP_KERNEL);
> +	else
> +		new_custom->table = devm_kcalloc(dev, n_entries, sizeof(u64), GFP_KERNEL);
>  	if (!new_custom->table)
>  		return ERR_PTR(-ENOMEM);
>  
> -	for (index = 0; index < n_entries; index++) {
> -		u64 temp = 0, j;
> -		/*
> -		 * Steinhart sensors are configured with raw values in the
> -		 * devicetree. For the other sensors we must convert the
> -		 * value to raw. The odd index's correspond to temperarures
> -		 * and always have 1/1024 of resolution. Temperatures also
> -		 * come in kelvin, so signed values is not possible
> -		 */
> -		if (!is_steinhart) {
> -			of_property_read_u64_index(np, propname, index, &temp);
> +	if (is_steinhart)
> +		ret = fwnode_property_read_u32_array(fn, propname, new_custom->table, n_entries);
> +	else
> +		ret = fwnode_property_read_u64_array(fn, propname, new_custom->table, n_entries);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	/*
> +	 * Steinhart sensors are configured with raw values in the device tree.
> +	 * For the other sensors we must convert the value to raw. The odd
> +	 * index's correspond to temperatures and always have 1/1024 of
> +	 * resolution. Temperatures also come in Kelvin, so signed values is
> +	 * not possible.
> +	 */
> +	if (is_steinhart) {

Perhaps would be cleaner to combine this if else with the one above at the cost
of duplicating the if (ret < 0) check.

> +		cpu_to_be32_array(new_custom->table, new_custom->table, n_entries);

I completely failed to register the hand coded big endian conversion.  Nice
tidy up.  However, definitely something to call out in the patch description.

> +	} else {
> +		for (index = 0; index < n_entries; index++) {
> +			u64 temp = ((u64 *)new_custom->table)[index];
>  
>  			if ((index % 2) != 0)
>  				temp = __convert_to_raw(temp, 1024);
> @@ -445,16 +459,9 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
>  				temp = __convert_to_raw_sign(temp, resolution);
>  			else
>  				temp = __convert_to_raw(temp, resolution);
> -		} else {
> -			u32 t32;
>  
> -			of_property_read_u32_index(np, propname, index, &t32);
> -			temp = t32;
> +			put_unaligned_be24(temp, new_custom->table + index * 3);
>  		}
> -
> -		for (j = 0; j < n_size; j++)
> -			new_custom->table[tbl++] =
> -				temp >> (8 * (n_size - j - 1));
>  	}
>  
>  	new_custom->is_steinhart = is_steinhart;
> @@ -597,13 +604,12 @@ static int ltc2983_adc_assign_chan(struct ltc2983_data *st,
>  	return __ltc2983_chan_assign_common(st, sensor, chan_val);
>  }
>  

...

> -static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
> -					  struct ltc2983_data *st,
> -					  const struct ltc2983_sensor *sensor)
> +static struct ltc2983_sensor *
> +ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
> +		const struct ltc2983_sensor *sensor)
>  {
>  	struct ltc2983_rtd *rtd;
>  	int ret = 0;
>  	struct device *dev = &st->spi->dev;
> -	struct device_node *phandle;
> +	struct fwnode_handle *ref;
>  	u32 excitation_current = 0, n_wires = 0;
>  
>  	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
>  	if (!rtd)
>  		return ERR_PTR(-ENOMEM);
>  
> -	phandle = of_parse_phandle(child, "adi,rsense-handle", 0);
> -	if (!phandle) {
> +	ref = fwnode_find_reference(child, "adi,rsense-handle", 0);
> +	if (!ref) {
>  		dev_err(dev, "Property adi,rsense-handle missing or invalid");
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	ret = of_property_read_u32(phandle, "reg", &rtd->r_sense_chan);
> +	ret = fwnode_property_read_u32(ref, "reg", &rtd->r_sense_chan);
>  	if (ret) {
>  		dev_err(dev, "Property reg must be given\n");
>  		goto fail;
>  	}
>  
> -	ret = of_property_read_u32(child, "adi,number-of-wires", &n_wires);
> +	ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
>  	if (!ret) {
>  		switch (n_wires) {
>  		case 2:
> @@ -738,9 +742,9 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
>  		}
>  	}
>  
> -	if (of_property_read_bool(child, "adi,rsense-share")) {
> +	if (fwnode_property_read_bool(child, "adi,rsense-share")) {
>  		/* Current rotation is only available with rsense sharing */
> -		if (of_property_read_bool(child, "adi,current-rotate")) {
> +		if (fwnode_property_read_bool(child, "adi,current-rotate")) {
>  			if (n_wires == 2 || n_wires == 3) {
>  				dev_err(dev,
>  					"Rotation not allowed for 2/3 Wire RTDs");
> @@ -803,7 +807,7 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
>  							  "adi,custom-rtd",
>  							  false, 2048, false);
>  		if (IS_ERR(rtd->custom)) {
> -			of_node_put(phandle);
> +			fwnode_handle_put(ref);

I guess there was a bunch of cut and paste in this driver ;) Same question as below
on whether we can just use a goto here to share the put in the fail path.

>  			return ERR_CAST(rtd->custom);
>  		}
>  	}
> @@ -812,8 +816,8 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
>  	rtd->sensor.fault_handler = ltc2983_common_fault_handler;
>  	rtd->sensor.assign_chan = ltc2983_rtd_assign_chan;
>  
> -	ret = of_property_read_u32(child, "adi,excitation-current-microamp",
> -				   &excitation_current);
> +	ret = fwnode_property_read_u32(child, "adi,excitation-current-microamp",
> +				       &excitation_current);
>  	if (ret) {
>  		/* default to 5uA */
>  		rtd->excitation_current = 1;
> @@ -852,23 +856,22 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
>  		}
>  	}
>  
> -	of_property_read_u32(child, "adi,rtd-curve", &rtd->rtd_curve);
> +	fwnode_property_read_u32(child, "adi,rtd-curve", &rtd->rtd_curve);
>  
> -	of_node_put(phandle);
> +	fwnode_handle_put(ref);
>  	return &rtd->sensor;
>  fail:
> -	of_node_put(phandle);
> +	fwnode_handle_put(ref);
>  	return ERR_PTR(ret);
>  }
>  
> -static struct ltc2983_sensor *ltc2983_thermistor_new(
> -					const struct device_node *child,
> -					struct ltc2983_data *st,
> -					const struct ltc2983_sensor *sensor)
> +static struct ltc2983_sensor *
> +ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *st,
> +		       const struct ltc2983_sensor *sensor)
>  {
>  	struct ltc2983_thermistor *thermistor;
>  	struct device *dev = &st->spi->dev;
> -	struct device_node *phandle;
> +	struct fwnode_handle *ref;
>  	u32 excitation_current = 0;
>  	int ret = 0;
>  
> @@ -876,23 +879,23 @@ static struct ltc2983_sensor *ltc2983_thermistor_new(
>  	if (!thermistor)
>  		return ERR_PTR(-ENOMEM);
>  
> -	phandle = of_parse_phandle(child, "adi,rsense-handle", 0);
> -	if (!phandle) {
> +	ref = fwnode_find_reference(child, "adi,rsense-handle", 0);
> +	if (!ref) {
>  		dev_err(dev, "Property adi,rsense-handle missing or invalid");
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	ret = of_property_read_u32(phandle, "reg", &thermistor->r_sense_chan);
> +	ret = fwnode_property_read_u32(ref, "reg", &thermistor->r_sense_chan);
>  	if (ret) {
>  		dev_err(dev, "rsense channel must be configured...\n");
>  		goto fail;
>  	}
>  
> -	if (of_property_read_bool(child, "adi,single-ended")) {
> +	if (fwnode_property_read_bool(child, "adi,single-ended")) {
>  		thermistor->sensor_config = LTC2983_THERMISTOR_SGL(1);
> -	} else if (of_property_read_bool(child, "adi,rsense-share")) {
> +	} else if (fwnode_property_read_bool(child, "adi,rsense-share")) {
>  		/* rotation is only possible if sharing rsense */
> -		if (of_property_read_bool(child, "adi,current-rotate"))
> +		if (fwnode_property_read_bool(child, "adi,current-rotate"))
>  			thermistor->sensor_config =
>  						LTC2983_THERMISTOR_C_ROTATE(1);
>  		else
> @@ -926,7 +929,7 @@ static struct ltc2983_sensor *ltc2983_thermistor_new(
>  								 steinhart,
>  								 64, false);
>  		if (IS_ERR(thermistor->custom)) {
> -			of_node_put(phandle);
> +			fwnode_handle_put(ref);
>  			return ERR_CAST(thermistor->custom);

Obviously not due to this patch, but this is odd.  Why have one error path
that doesn't use the goto faill;?
If you could tidy that up and add a note on it to the patch description
that would be great.

>  		}
>  	}
> @@ -934,8 +937,8 @@ static struct ltc2983_sensor *ltc2983_thermistor_new(
>  	thermistor->sensor.fault_handler = ltc2983_common_fault_handler;
>  	thermistor->sensor.assign_chan = ltc2983_thermistor_assign_chan;
>  
> -	ret = of_property_read_u32(child, "adi,excitation-current-nanoamp",
> -				   &excitation_current);
> +	ret = fwnode_property_read_u32(child, "adi,excitation-current-nanoamp",
> +				       &excitation_current);
>  	if (ret) {
>  		/* Auto range is not allowed for custom sensors */
>  		if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART)
> @@ -999,17 +1002,16 @@ static struct ltc2983_sensor *ltc2983_thermistor_new(
>  		}
>  	}
>  
> -	of_node_put(phandle);
> +	fwnode_handle_put(ref);
>  	return &thermistor->sensor;
>  fail:
> -	of_node_put(phandle);
> +	fwnode_handle_put(ref);
>  	return ERR_PTR(ret);
>  }
>  
