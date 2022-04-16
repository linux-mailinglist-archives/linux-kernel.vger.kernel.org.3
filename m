Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0292550377F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiDPQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDPQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 12:21:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4CEE0E8;
        Sat, 16 Apr 2022 09:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37639B80022;
        Sat, 16 Apr 2022 16:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6965C385A1;
        Sat, 16 Apr 2022 16:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650125933;
        bh=hZUjVSzOWisnpzTgPjHtWLSekh5zsdbQd0T6QOdJffo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WAk6vBqJ+IMN/mIW+qtY3a2YI+Jdzd81m45+obkp8eFOqYzz5784yvCNrXnO6dThs
         EADnRuea8IXYABZz6MplD8jLADUvHj92oS6UfMxy3xKy4BA3foB6Rnr1Gh6tkd8cPQ
         U70RfmP3kmJZEw/M1wYH+XRQayq8aEwQdV6CMtWedih64YYMJICKb2csOMg4aJiXUi
         JgIIskKrYKGoowAmV/HArcuUnCNTgpu0MNZ1yOTl2Cd6V3vfs6ml1xv67wpp5US4/p
         XXCOvZC8d6DL2S1afTn2x3aw3f/FkETK1xj48liZYY5XPSKSsG7Lr6BZJWIEh0AGuT
         S9R6W5nJEmQjg==
Date:   Sat, 16 Apr 2022 17:26:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] iio: stk3310: Export near level property for
 proximity sensor
Message-ID: <20220416172651.695d4439@jic23-huawei>
In-Reply-To: <20220415085018.35063-3-arnaud.ferraris@collabora.com>
References: <20220415085018.35063-1-arnaud.ferraris@collabora.com>
        <20220415085018.35063-3-arnaud.ferraris@collabora.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 10:50:18 +0200
Arnaud Ferraris <arnaud.ferraris@collabora.com> wrote:

> This makes the value from which an object should be considered "near"
> available to userspace. This hardware-dependent value should be set
> in the device-tree.
> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Hi Arnaud,

Minor request to slightly modify how you do this inline.
Otherwise looks good to me.

Thanks,

Jonathan

> ---
>  drivers/iio/light/stk3310.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 1d02dfbc29d1..7792456323ef 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -106,6 +106,7 @@ struct stk3310_data {
>  	struct mutex lock;
>  	bool als_enabled;
>  	bool ps_enabled;
> +	uint32_t ps_near_level;
>  	u64 timestamp;
>  	struct regmap *regmap;
>  	struct regmap_field *reg_state;
> @@ -135,6 +136,25 @@ static const struct iio_event_spec stk3310_events[] = {
>  	},
>  };
>  
> +static ssize_t stk3310_read_near_level(struct iio_dev *indio_dev,
> +				       uintptr_t priv,
> +				       const struct iio_chan_spec *chan,
> +				       char *buf)
> +{
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%u\n", data->ps_near_level);
> +}
> +
> +static const struct iio_chan_spec_ext_info stk3310_ext_info[] = {
> +	{
> +		.name = "nearlevel",
> +		.shared = IIO_SEPARATE,
> +		.read = stk3310_read_near_level,
> +	},
> +	{ /* sentinel */ }
> +};
> +
>  static const struct iio_chan_spec stk3310_channels[] = {
>  	{
>  		.type = IIO_LIGHT,
> @@ -151,6 +171,7 @@ static const struct iio_chan_spec stk3310_channels[] = {
>  			BIT(IIO_CHAN_INFO_INT_TIME),
>  		.event_spec = stk3310_events,
>  		.num_event_specs = ARRAY_SIZE(stk3310_events),
> +		.ext_info = stk3310_ext_info,
>  	}
>  };
>  
> @@ -581,6 +602,11 @@ static int stk3310_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	data->client = client;
>  	i2c_set_clientdata(client, indio_dev);
> +
> +	if (device_property_read_u32(&client->dev, "proximity-near-level",
> +				     &data->ps_near_level))
> +		data->ps_near_level = 0;

Prefer this pattern.

	data->ps_near_level = 0;
	device_property_read_u32(&client->dev, "proximity-near-level",
				 &data->ps_near_level);
taking advantage of the fact that the output won't be set unless
the property read succeeds.

> +
>  	mutex_init(&data->lock);
>  
>  	ret = stk3310_regmap_init(data);

