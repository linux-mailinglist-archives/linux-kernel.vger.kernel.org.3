Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF31525310
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356732AbiELQzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356716AbiELQz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:55:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22156E8D9;
        Thu, 12 May 2022 09:55:27 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kzd985FVsz67lbv;
        Fri, 13 May 2022 00:51:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 18:55:25 +0200
Received: from localhost (10.81.210.133) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 17:55:24 +0100
Date:   Thu, 12 May 2022 17:55:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Markuss Broks <markuss.broks@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] proximity: vl53l0x: Handle the VDD regulator
Message-ID: <20220512175522.000013cb@Huawei.com>
In-Reply-To: <20220512110757.5297-4-markuss.broks@gmail.com>
References: <20220512110757.5297-1-markuss.broks@gmail.com>
        <20220512110757.5297-4-markuss.broks@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.133]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 14:07:55 +0300
Markuss Broks <markuss.broks@gmail.com> wrote:

> Handle the regulator supplying the VDD pin of VL53L0X.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Hi Markuss,

One ordering question inline.

> ---
>  drivers/iio/proximity/vl53l0x-i2c.c | 37 +++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 12a3e2eff464..d8523e3981e8 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -43,6 +43,7 @@
>  struct vl53l0x_data {
>  	struct i2c_client *client;
>  	struct completion completion;
> +	struct regulator *vdd_supply;
>  };
>  
>  static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
> @@ -192,10 +193,31 @@ static const struct iio_info vl53l0x_info = {
>  	.read_raw = vl53l0x_read_raw,
>  };
>  
> +static void vl53l0x_power_off(void *_data)
> +{
> +	struct vl53l0x_data *data = _data;
> +
> +	regulator_disable(data->vdd_supply);
> +}
> +
> +static int vl53l0x_power_on(struct vl53l0x_data *data)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(data->vdd_supply);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(3200, 5000);
> +
> +	return 0;
> +}
> +
>  static int vl53l0x_probe(struct i2c_client *client)
>  {
>  	struct vl53l0x_data *data;
>  	struct iio_dev *indio_dev;
> +	int error;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -210,6 +232,21 @@ static int vl53l0x_probe(struct i2c_client *client)
>  				     I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -EOPNOTSUPP;
>  
> +	data->vdd_supply = devm_regulator_get_optional(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
> +				     "Unable to get VDD regulator\n");
> +
> +	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);

I don't follow why you have this before the power_on.  We haven't enabled the
regulator yet so shouldn't be turning it off if we get an error whilst trying
to enable it.  The or_reset part is to ensure that even if this call
fails to register a devm action it will still call the callback thus allowing
you safely do this after turning the power on.

> +	if (error)
> +		return dev_err_probe(&client->dev, error,
> +				     "Failed to install poweroff action\n");
> +
> +	error = vl53l0x_power_on(data);
> +	if (error)
> +		return dev_err_probe(&client->dev, error,
> +				     "Failed to power on the chip\n");
> +
>  	indio_dev->name = "vl53l0x";
>  	indio_dev->info = &vl53l0x_info;
>  	indio_dev->channels = vl53l0x_channels;

