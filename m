Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA7653B9F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiFBNjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiFBNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:38:59 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD98F188E91;
        Thu,  2 Jun 2022 06:38:57 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id r14-20020a056830418e00b0060b8da9ff75so3394320otu.11;
        Thu, 02 Jun 2022 06:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O0boLWIGc2cfiJKY/LFTM6gVy1MpJxwr9WhYPcXpskU=;
        b=VDrgBEMkIou4EratkB48MV4XejyIAOCCYpcm1d/DRt5b+uaRXbVEZSaON9eN/Ni+FQ
         q/uldFdyozHVzayncI0HNeZ8HBLGDgJFTDOhOqss5Akmyk6wi7IXmrY3X35bqr3DyF/H
         i9plM2b8mLC/U5rihvrjjTD8eJLJQbKTMwcpXxNC1oIzbWP/i+z+woJpJDTeJF3w2tF9
         hklUHr+PU8gdvych9wBeBN+trm1Cu1WK9/mtJVfXcuP3/DoOfOT0y2yvvHbwzyGT9Cyq
         L96adEK42eIqE3IHA+sUq26e6rZQBfFHlxZbVCN+fQr3Yi1vMYZhAh/h/4xA8pozxnuw
         OZtQ==
X-Gm-Message-State: AOAM530WpjX/t9+Ie9pSKHBdSYdgcSTOW/bQgXJ6oITyptX0aVV8TWMB
        t3tzmkR1BCoU8iHHPYS2tw==
X-Google-Smtp-Source: ABdhPJx6ISSfHaPjGV6XtcEyoeKv02Q64hSfVaIxtnQ1fZxRzpSt3XZ2FhCSsu3eTVkTMB/rA3s7DQ==
X-Received: by 2002:a9d:734f:0:b0:60b:198a:2168 with SMTP id l15-20020a9d734f000000b0060b198a2168mr2087080otk.20.1654177136930;
        Thu, 02 Jun 2022 06:38:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u5-20020a056830248500b0060b088dcbeesm2177284ots.27.2022.06.02.06.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:38:56 -0700 (PDT)
Received: (nullmailer pid 2167289 invoked by uid 1000);
        Thu, 02 Jun 2022 13:38:55 -0000
Date:   Thu, 2 Jun 2022 08:38:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, martink@posteo.de,
        geert+renesas@glider.be, john@metanate.com, hechtb@gmail.com
Subject: Re: [PATCH] Input: st1232 - Support power supply regulators
Message-ID: <20220602133855.GA2166481-robh@kernel.org>
References: <20220524081216.8550-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524081216.8550-1-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 10:12:16AM +0200, Mike Looijmans wrote:
> Add support for the VDD and IOVDD power supply inputs. This allows the
> chip to share its supplies with other components (e.g. panel) and manage
> them.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  .../input/touchscreen/sitronix,st1232.yaml    |  6 +++

Separate patch please.

>  drivers/input/touchscreen/st1232.c            | 54 ++++++++++++++++---
>  2 files changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> index 1d8ca19fd37a..240be8d49232 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> @@ -28,6 +28,12 @@ properties:
>      description: A phandle to the reset GPIO
>      maxItems: 1
>  
> +  vdd-supply:
> +    description: Power supply regulator for the chip
> +
> +  vddio-supply:
> +    description: Power supply regulator for the I2C bus
> +
>  required:
>    - compatible
>    - reg
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> index e38ba3e4f183..d9c9f6f1f11a 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -44,6 +44,11 @@
>  #define REG_XY_COORDINATES	0x12
>  #define ST_TS_MAX_FINGERS	10
>  
> +enum st1232_regulators {
> +	ST1232_REGULATOR_VDD,
> +	ST1232_REGULATOR_IOVDD,
> +};
> +
>  struct st_chip_info {
>  	bool	have_z;
>  	u16	max_area;
> @@ -56,6 +61,7 @@ struct st1232_ts_data {
>  	struct touchscreen_properties prop;
>  	struct dev_pm_qos_request low_latency_req;
>  	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data regulators[2];
>  	const struct st_chip_info *chip_info;
>  	int read_buf_len;
>  	u8 *read_buf;
> @@ -197,17 +203,36 @@ static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
> +static int st1232_ts_power_on(struct st1232_ts_data *ts)
> +{
> +	int err;
> +
> +	err = regulator_bulk_enable(ARRAY_SIZE(ts->regulators), ts->regulators);
> +	if (err)
> +		return err;
> +
> +	usleep_range(5000, 6000);
> +
> +	if (ts->reset_gpio)
> +		gpiod_set_value_cansleep(ts->reset_gpio, 0);
> +
> +	return 0;
> +}
> +
> +static void st1232_ts_power_off(struct st1232_ts_data *ts)
>  {
>  	if (ts->reset_gpio)
> -		gpiod_set_value_cansleep(ts->reset_gpio, !poweron);
> +		gpiod_set_value_cansleep(ts->reset_gpio, 1);
> +	usleep_range(100, 150);
> +	regulator_bulk_disable(ARRAY_SIZE(ts->regulators), ts->regulators);
>  }
>  
> -static void st1232_ts_power_off(void *data)
> +static void st1232_ts_power_off_action(void *data)
>  {
> -	st1232_ts_power(data, false);
> +	st1232_ts_power_off(data);
>  }
>  
> +
>  static const struct st_chip_info st1232_chip_info = {
>  	.have_z		= true,
>  	.max_area	= 0xff,
> @@ -266,6 +291,14 @@ static int st1232_ts_probe(struct i2c_client *client,
>  	ts->client = client;
>  	ts->input_dev = input_dev;
>  
> +	ts->regulators[ST1232_REGULATOR_VDD].supply = "vdd";
> +	ts->regulators[ST1232_REGULATOR_IOVDD].supply = "iovdd";
> +	error = devm_regulator_bulk_get(&client->dev,
> +					ARRAY_SIZE(ts->regulators),
> +					ts->regulators);
> +	if (error)
> +		return error;
> +
>  	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, NULL,
>  						 GPIOD_OUT_HIGH);
>  	if (IS_ERR(ts->reset_gpio)) {
> @@ -275,9 +308,14 @@ static int st1232_ts_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	st1232_ts_power(ts, true);
> +	error = st1232_ts_power_on(ts);
> +	if (error) {
> +		dev_err(&client->dev, "Failed to power on: %d\n", error);
> +		return error;
> +	}
>  
> -	error = devm_add_action_or_reset(&client->dev, st1232_ts_power_off, ts);
> +	error = devm_add_action_or_reset(&client->dev,
> +					 st1232_ts_power_off_action, ts);
>  	if (error) {
>  		dev_err(&client->dev,
>  			"Failed to install power off action: %d\n", error);
> @@ -348,7 +386,7 @@ static int __maybe_unused st1232_ts_suspend(struct device *dev)
>  	disable_irq(client->irq);
>  
>  	if (!device_may_wakeup(&client->dev))
> -		st1232_ts_power(ts, false);
> +		st1232_ts_power_off(ts);
>  
>  	return 0;
>  }
> @@ -359,7 +397,7 @@ static int __maybe_unused st1232_ts_resume(struct device *dev)
>  	struct st1232_ts_data *ts = i2c_get_clientdata(client);
>  
>  	if (!device_may_wakeup(&client->dev))
> -		st1232_ts_power(ts, true);
> +		st1232_ts_power_on(ts);
>  
>  	enable_irq(client->irq);
>  
> -- 
> 2.17.1
> 
> 
