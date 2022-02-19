Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2754BC9AF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbiBSSD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:03:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiBSSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:03:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DD760045;
        Sat, 19 Feb 2022 10:03:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4073260B89;
        Sat, 19 Feb 2022 18:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3089EC004E1;
        Sat, 19 Feb 2022 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645293814;
        bh=7sdjXCq+horHJeTaGuXGQHBBiVUmSagqKBrk/149NCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P+hnkv8s6dzEW3vB/fakyR7sGqJH6EFy6xFKzprHN3D6JJd74gMeRaboaBJFlGGCU
         yN2RVnHwvx/z8CaAZ9+9t7FcugU0jbxM22DOTFwyOYeUwGsrmfs78v0ANHK7h6z/Ac
         Bs1nEbWEchnXKRgyi0P9CJSaf44eBqosCRcBTQb8I0T6XnKQY6zYJ5HbmVyM8SQ+uA
         AybKK5z7ztDp3U4/bFm6H/TiTm6JVL0KrToE5eLbFHfDvPZLHfLN7szN9r0VAX3zzS
         PPV/JQrhkGEr7UZls6VZaAndY+DY31kwiv/PHhqUxIhPtuKi82iL0FQxWBvDAoIc10
         lbgJOKuiRvxTQ==
Date:   Sat, 19 Feb 2022 18:10:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH V2 4/5] iio: accel: sca3300: Add support for SCL3300
Message-ID: <20220219181022.4655a1a7@jic23-huawei>
In-Reply-To: <20220217062705.2867149-5-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220217062705.2867149-5-Qing-wu.Li@leica-geosystems.com.cn>
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

On Thu, 17 Feb 2022 06:27:04 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Add support for Murata SCL3300, a 3-axis MEMS accelerometer.
> Same as SCA3300, it has accelerometer and temperature output.
> Datasheet:
> www.murata.com/en-us/products/sensor/inclinometer/overview/lineup/scl3300
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>

Hi

Most comments are follow on from previous patch review.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/sca3300.c | 45 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index b1748874c02d..123ab9a784d2 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -42,6 +42,9 @@
>  #define SCA3300_VALUE_RS_ERROR	0x3
>  #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
>  
> +#define SCA3300_REG_ANG_CTRL 0x0C
> +#define SCA3300_ANG_ENABLE   0x1F
> +
>  enum sca3300_op_mode_indexes {
>  	OP_MOD_1 = 0,
>  	OP_MOD_2,
> @@ -52,6 +55,7 @@ enum sca3300_op_mode_indexes {
>  
>  enum sca3300_chip_type {
>  	CHIP_SCA3300 = 0,
> +	CHIP_SCL3300,
>  	CHIP_CNT
>  };
>  
> @@ -106,8 +110,19 @@ static const struct iio_chan_spec sca3300_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP),
>  };
>  
> +static const struct iio_chan_spec scl3300_channels[] = {
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
> +	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
> +	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP),
> +};
> +
>  static const int sca3300_lp_freq_table[] = {70, 70, 70, 10};
> +static const int scl3300_lp_freq_table[] = {40, 70, 10, 10};
> +
>  static const int sca3300_accel_scale_table[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
> +static const int scl3300_accel_scale_table[][2] = {{0, 167}, {0, 333}, {0, 83}, {0, 83}};

As below, given there is no obvious reason to support both mode 3 and 4 I would only
have values for one of them and have a different number of modes available for this device.

>  
>  static const unsigned long sca3300_scan_masks[] = {
>  	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
> @@ -161,6 +176,18 @@ static const struct sca3300_chip_info sca3300_chip_info_tbl[] = {
>  		.chip_id = 0x51,
>  		.num_freqs = 2,
>  	},
> +	[CHIP_SCL3300] = {
> +		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale_table)*2-1,
> +		.num_channels = ARRAY_SIZE(scl3300_channels),
> +		.accel_scale_table = scl3300_accel_scale_table,
> +		.freq_table = scl3300_lp_freq_table,
> +		.scan_masks = sca3300_scan_masks,
> +		.channels = scl3300_channels,
> +		.chip_type = CHIP_SCL3300,
> +		.name = "scl3300",
> +		.chip_id = 0xC1,
> +		.num_freqs = 3,
> +	},
>  };
>  
>  DECLARE_CRC8_TABLE(sca3300_crc_table);
> @@ -274,6 +301,11 @@ static int sca3300_set_op_mode(struct sca3300_data *sca_data, unsigned int mode)
>  	if ((mode < OP_MOD_1) || (mode >= OP_MOD_CNT))
>  		return -EINVAL;
>  
> +	/* SCL3300, mode 3 and 4 are same, use mode 4 only*/
> +	if (sca_data->chip_info->chip_type == CHIP_SCL3300) {

For this, the interface would be simpler if we just pretend mode 3 doesn't
exist and have only 3 modes (though obvious we'll still need to adjust it ehre).

> +		if (mode == OP_MOD_3)
> +			mode = OP_MOD_4;
> +	}
>  	return sca3300_write_reg(sca_data, SCA3300_REG_MODE, mode);
>  }
>  
> @@ -317,6 +349,8 @@ static int sca3300_write_raw(struct iio_dev *indio_dev,
>  			if (reg_val == OP_MOD_4 && mode == OP_MOD_3)
>  				return sca3300_set_op_mode(data, mode);
>  			return -EINVAL;
> +		case CHIP_SCL3300:
> +			return sca3300_set_op_mode(data, mode);

As mentioned in previous patch I'd like these choices to be expressed as
'features' or similar in the chip_info so that we don't end up with
the part differences exposed only via a specific 'type' field.

>  		default:
>  			return -EINVAL;
>  		}
> @@ -348,8 +382,9 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
>  			*val =  data->chip_info->accel_scale_table[reg_val][0];
>  			*val2 = data->chip_info->accel_scale_table[reg_val][1];
>  			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
>  		}
> -		return -EINVAL;

Fix in earlier patch.

>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
>  		if (ret)
> @@ -431,6 +466,12 @@ static int sca3300_init(struct sca3300_data *sca_data,
>  	indio_dev->name = sca3300_chip_info_tbl[i].name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	if (sca_data->chip_info->chip_type == CHIP_SCL3300) {
As previously I'd ideally prefer to have the chip_info contain flags on which we make
a decision on a particular 'feature' rather than using a generic chip_type and
mixing where we have the information on the difference between devices.  I want
all that info in the chip_info structure.

	if (sca_data->chip_info->ang) {
		ret = sca3000_write_reg(sca_data, SCA330...
		...
	}
> +		ret = sca3300_write_reg(sca_data, SCA3300_REG_ANG_CTRL, SCA3300_ANG_ENABLE);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -474,7 +515,6 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -		return -EINVAL;

This was introduced in previous patch. Please fix it there.


>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		*vals = (const int *)data->chip_info->freq_table;
>  		*length = data->chip_info->num_freqs;
> @@ -536,6 +576,7 @@ static int sca3300_probe(struct spi_device *spi)
>  
>  static const struct of_device_id sca3300_dt_ids[] = {
>  	{ .compatible = "murata,sca3300"},
> +	{ .compatible = "murata,scl3300"},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sca3300_dt_ids);

