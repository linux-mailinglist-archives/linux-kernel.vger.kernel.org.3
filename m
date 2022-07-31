Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E18A585EBB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 13:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiGaL7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 07:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGaL7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 07:59:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF5BE1E;
        Sun, 31 Jul 2022 04:59:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8E1D60C8A;
        Sun, 31 Jul 2022 11:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B794BC433D6;
        Sun, 31 Jul 2022 11:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659268786;
        bh=80q4Ltg0o6rY6GppCDBJ4wyc9ow/K8xzIPlz++w22sI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qeZsVkWxlmCBhyscH/QajWGe1myEOA3S2qNYTXteESn5QzYWVvCrxhj/pDwCJrv3n
         tqpJGs+pQ1fN1q2neh/Tk+oqX0MzqSjl1LvuWnlxKr7Hc93q4ZkIWR2VV05ybSK4iN
         nH3vwTPX/esl61JOwkIugZWaj6nO9HXqXEgeTFl7wPuFYqiTSya7gfvBl8V6clV44D
         EGi+nQ9ZRg9JLr/2Qk8ILCU1QvdhEY/qbuTwxSJzsk/llJM307SXWMpFnzOxAqbJ9k
         JduveQIT/oBJWfDJB2jobSw7DrltN9GA6SAuLjOfK0hzhsIzMgEvqB4SU+aF1UEQS/
         T1RuvZjkOa1VQ==
Date:   Sun, 31 Jul 2022 13:09:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
Message-ID: <20220731130959.50826fc4@jic23-huawei>
In-Reply-To: <20220728125435.3336618-3-potin.lai.pt@gmail.com>
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
        <20220728125435.3336618-3-potin.lai.pt@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 12:54:35 +0000
Potin Lai <potin.lai.pt@gmail.com> wrote:

> Add manufacturer and device ID checking during probe, and skip the
> checking if chip model not supported.
> 
> Supported:
> - HDC1000
> - HDC1010
> - HDC1050
> - HDC1080
> 
> Not supported:
> - HDC1008
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>

I need some more information on the 'why' of this patch.  There are a number
of drivers that do a similar ID check but in recent times, that approach has
been considered wrong because it breaks potential use of multiple compatible
entries in device tree.   If a new device comes along and is backwards
compatible with an existing one (maybe has new features, but using them is
optional) then we want to have an entry that looks like

compatible = "ti,hdc1099", "ti,hdc1080"

If the new ID is not supported by the kernel that is being used, we still
want the driver to 'work' using the fallback compatible.

As such, we no generally do the following.

1) If we have a match to a device we know about but it's not the one the
   firmware tells us to expect, print a warning but operate as if the firmware
   had been correct - particularly if we know the parts aren't compatible
   with each other. (this bit is optional as we should be able to assume firmware
   doesn't do stupid things :)
2) If we don't match at all, print a warning about an unknown device but carry
   on with assumption that the firmware is correct and this new device ID is
   backwards compatible with the provided fallback compatible.

So if this is just a bit of defensive programming (rather than necessary for some
reason not yet explained) then change from returning an error on probe() to 
printing an warning message but continuing anyway. (which is part (2) of the
above)

> ---
>  drivers/iio/humidity/hdc100x.c | 67 ++++++++++++++++++++++++++++------
>  1 file changed, 56 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 0d514818635cb..31f18cc1cf63c 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -34,6 +34,23 @@
>  #define HDC100X_REG_CONFIG_ACQ_MODE		BIT(12)
>  #define HDC100X_REG_CONFIG_HEATER_EN		BIT(13)
>  
> +#define HDC100X_REG_MFR_ID	0xFE
> +#define HDC100X_REG_DEV_ID	0xFF
> +
> +#define HDC100X_MFR_ID	0x5449
> +
> +struct hdc100x_chip_data {
> +	bool support_mfr_check;
> +};
> +
> +static const struct hdc100x_chip_data hdc100x_chip_data = {
> +	.support_mfr_check	= true,
> +};
> +
> +static const struct hdc100x_chip_data hdc1008_chip_data = {
> +	.support_mfr_check	= false,
> +};
> +
>  struct hdc100x_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> @@ -351,8 +368,32 @@ static const struct iio_info hdc100x_info = {
>  	.attrs = &hdc100x_attribute_group,
>  };
>  
> +static int hdc100x_read_mfr_id(struct i2c_client *client)
> +{
> +	return i2c_smbus_read_word_swapped(client, HDC100X_REG_MFR_ID);
> +}
> +
> +static int hdc100x_read_dev_id(struct i2c_client *client)
> +{
> +	return i2c_smbus_read_word_swapped(client, HDC100X_REG_DEV_ID);
> +}
> +
> +static bool is_valid_hdc100x(struct i2c_client *client)
> +{
> +	int mfr_id, dev_id;
> +
> +	mfr_id = hdc100x_read_mfr_id(client);
> +	dev_id = hdc100x_read_dev_id(client);
> +	if (mfr_id == HDC100X_MFR_ID &&
> +	   (dev_id == 0x1000 || dev_id == 0x1050))
> +		return true;
> +
> +	return false;
> +}
> +
>  static int hdc100x_probe(struct i2c_client *client)
>  {
> +	const struct hdc100x_chip_data *chip_data;
>  	struct iio_dev *indio_dev;
>  	struct hdc100x_data *data;
>  	int ret;
> @@ -361,6 +402,10 @@ static int hdc100x_probe(struct i2c_client *client)
>  				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
>  		return -EOPNOTSUPP;
>  
> +	chip_data = device_get_match_data(&client->dev);
> +	if (chip_data->support_mfr_check && !is_valid_hdc100x(client))
> +		return -EINVAL;
> +
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -396,22 +441,22 @@ static int hdc100x_probe(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id hdc100x_id[] = {
> -	{ "hdc100x", 0 },
> -	{ "hdc1000", 0 },
> -	{ "hdc1008", 0 },
> -	{ "hdc1010", 0 },
> -	{ "hdc1050", 0 },
> -	{ "hdc1080", 0 },
> +	{ "hdc100X", (kernel_ulong_t)&hdc100x_chip_data },
> +	{ "hdc1000", (kernel_ulong_t)&hdc100x_chip_data },
> +	{ "hdc1008", (kernel_ulong_t)&hdc1008_chip_data },
> +	{ "hdc1010", (kernel_ulong_t)&hdc100x_chip_data },
> +	{ "hdc1050", (kernel_ulong_t)&hdc100x_chip_data },
> +	{ "hdc1080", (kernel_ulong_t)&hdc100x_chip_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, hdc100x_id);
>  
>  static const struct of_device_id hdc100x_dt_ids[] = {
> -	{ .compatible = "ti,hdc1000" },
> -	{ .compatible = "ti,hdc1008" },
> -	{ .compatible = "ti,hdc1010" },
> -	{ .compatible = "ti,hdc1050" },
> -	{ .compatible = "ti,hdc1080" },
> +	{ .compatible = "ti,hdc1000", .data = &hdc100x_chip_data },
> +	{ .compatible = "ti,hdc1008", .data = &hdc1008_chip_data },
> +	{ .compatible = "ti,hdc1010", .data = &hdc100x_chip_data },
> +	{ .compatible = "ti,hdc1050", .data = &hdc100x_chip_data },
> +	{ .compatible = "ti,hdc1080", .data = &hdc100x_chip_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);

