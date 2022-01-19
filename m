Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9360F49378B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353107AbiASJnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353044AbiASJm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:42:56 -0500
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:1::465:111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375D3C061574;
        Wed, 19 Jan 2022 01:42:56 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4Jf10G3v44z9scy;
        Wed, 19 Jan 2022 10:42:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642585372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yUiafitayqG9qVxmPKvPhVi5mgDkb14L3ujh+Xnamc=;
        b=bgviz6d/ghsnghYiGAol8hFucAxD3VeMHq9rtMsJhC5CwnT+LfZrvR/nIKhfVSoxpH2BZT
        j1QSF7QrSx+BTRUnZHDdUUxEwe4toBtiMlN4ftQshqD0c5ohEq5vF3nSHfQ2D9T8RRGs4+
        yLjXw3qbZl/FIO0S5MdEZg7w0eQtrCQ9GCKJweZXnqfXoOfKdWmQsOBGBhdiY++4Usykfp
        qdJ9ZiifZlCNL0bl0Ph91+IWXyR0XHjzZlSmcIjcHXkp77CLF9CWMd5A5+VEmJotHcOk4q
        5muYsiathCc04rciGRZsLxJTZN4r17zQTTJNS8EErfe+xNi7JSFzYbsBydghPw==
Message-ID: <06b7adc5612d9d0436cfb57e47518ad835b4fc62.camel@sylv.io>
Subject: Re: [PATCH v2 2/4] hwmon: (max6639) Add regulator support
From:   sylv <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Date:   Wed, 19 Jan 2022 10:42:49 +0100
In-Reply-To: <20220118161108.GA4115171@roeck-us.net>
References: <cover.1642413668.git.sylv@sylv.io>
         <4c644f279f6e205d3c9540a4ad35825e4d5f2da1.1642413668.git.sylv@sylv.io>
         <20220118161108.GA4115171@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-18 at 08:11 -0800, Guenter Roeck wrote:
> On Mon, Jan 17, 2022 at 11:40:24AM +0100, Marcello Sylvester Bauer wrote:
> > Add regulator support for boards where the fan-supply have to be
> > powered up before it can be used.
> > 
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > ---
> >  drivers/hwmon/max6639.c | 64 +++++++++++++++++++++++++++++++++++------
> >  1 file changed, 56 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> > index ccc0f047bd44..0b241f029229 100644
> > --- a/drivers/hwmon/max6639.c
> > +++ b/drivers/hwmon/max6639.c
> > @@ -87,6 +87,9 @@ struct max6639_data {
> >  	/* Register values initialized only once */
> >  	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
> >  	u8 rpm_range;		/* Index in above rpm_ranges table */
> > +
> > +	/* Optional regulator for FAN supply */
> > +	struct regulator *reg;
> >  };
> >  
> >  static struct max6639_data *max6639_update_device(struct device *dev)
> > @@ -516,6 +519,11 @@ static int max6639_detect(struct i2c_client *client,
> >  	return 0;
> >  }
> >  
> > +static void max6639_regulator_disable(void *data)
> > +{
> > +	regulator_disable(data);
> > +}
> > +
> >  static int max6639_probe(struct i2c_client *client)
> >  {
> >  	struct device *dev = &client->dev;
> > @@ -528,6 +536,30 @@ static int max6639_probe(struct i2c_client *client)
> >  		return -ENOMEM;
> >  
> >  	data->client = client;
> > +
> > +	data->reg = devm_regulator_get_optional(dev, "fan");
> > +	if (IS_ERR(data->reg)) {
> > +		if (PTR_ERR(data->reg) != -ENODEV) {
> > +			err = (int)PTR_ERR(data->reg);
> > +			dev_warn(dev, "Failed looking up fan supply: %d\n", err);
> 
> This could be -EPROBE_DEFER. I do not think that warrants
> an error message.

I see. I'll adapt it analog to: drivers/hwmon/pwm-fan.c:323

> 
> > +			return err;
> > +		}
> > +		data->reg = NULL;
> > +	} else {
> > +		/* Spin up fans */
> > +		err = regulator_enable(data->reg);
> > +		if (err) {
> > +			dev_err(dev, "Failed to enable fan supply: %d\n", err);
> > +			return err;
> > +		}
> > +		err = devm_add_action_or_reset(dev, max6639_regulator_disable,
> > +					       data->reg);
> > +		if (err) {
> > +			dev_err(dev, "Failed to register action: %d\n", err);
> > +			return err;
> > +		}
> > +	}
> > +
> >  	mutex_init(&data->update_lock);
> >  
> >  	/* Initialize the max6639 chip */
> > @@ -545,23 +577,39 @@ static int max6639_probe(struct i2c_client *client)
> >  static int max6639_suspend(struct device *dev)
> >  {
> >  	struct i2c_client *client = to_i2c_client(dev);
> > -	int data = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> > -	if (data < 0)
> > -		return data;
> > +	struct max6639_data *data = dev_get_drvdata(dev);
> > +	int ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (data->reg)
> > +		regulator_disable(data->reg);
> >  
> >  	return i2c_smbus_write_byte_data(client,
> > -			MAX6639_REG_GCONFIG, data | MAX6639_GCONFIG_STANDBY);
> > +			MAX6639_REG_GCONFIG, ret | MAX6639_GCONFIG_STANDBY);
> >  }
> >  
> >  static int max6639_resume(struct device *dev)
> >  {
> >  	struct i2c_client *client = to_i2c_client(dev);
> > -	int data = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> > -	if (data < 0)
> > -		return data;
> > +	struct max6639_data *data = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	if (data->reg) {
> > +		ret = regulator_enable(data->reg);
> > +		if (ret) {
> > +			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> > +	if (ret < 0)
> > +		return ret;
> >  
> >  	return i2c_smbus_write_byte_data(client,
> > -			MAX6639_REG_GCONFIG, data & ~MAX6639_GCONFIG_STANDBY);
> > +			MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
> >  }
> >  #endif /* CONFIG_PM_SLEEP */
> >  

