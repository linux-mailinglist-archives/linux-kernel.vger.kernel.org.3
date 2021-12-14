Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF83847439C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhLNNhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLNNhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:37:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D3C061574;
        Tue, 14 Dec 2021 05:37:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76468B819B6;
        Tue, 14 Dec 2021 13:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC8EC34601;
        Tue, 14 Dec 2021 13:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639489062;
        bh=deFyXMcKiwCRpUDJn69BxS6xCrAqOSThqPq5nRVxAGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hHtBvzlU39mAmq3xjbRUe8YqzLHaBkzT6T3VqtpKPNrk73Y3LfEWbyHYvgXEa6FUt
         ddVmEJiULld/Y+jrGJMwITVL6aQxtwXH2n4CAI9iTMahH/nGMjnI6EXbLmJK90mned
         O9qYd9lL2kABQgbard8dhbq2DleBWF94AulcXrFI83NTCor5b+53MVi92qUErAoUvT
         Tq3zdpbKWOXK870dIxCkbhRvCJwQ7XkP7t0r8bVL+q/RpuguI0sli/OxJ6AtsoX9rY
         S5wCLI0TGQWBW3RS0shYKoS5woUI4i/Ys6m9t9tma/zeg5u+opGw/MGi/I7XySKVjC
         ZCFd+0g5gJwdw==
Date:   Tue, 14 Dec 2021 14:37:38 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Chuck Ritola <cjritola@gmail.com>
Cc:     crope@iki.fi, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dvb-frontends: a8293: fix LNB powerup failure in
 PCTV 461e
Message-ID: <20211214143738.7cd2c240@coco.lan>
In-Reply-To: <20211119020905.22725-1-cjritola@gmail.com>
References: <20211119020905.22725-1-cjritola@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 18 Nov 2021 21:09:05 -0500
Chuck Ritola <cjritola@gmail.com> escreveu:

> Fixes a8293 failure to raise LNB voltage in PCTV 461e DVB-S2 Stick
> affecting multiple users over several years as found here:
> 
> http://www.linuxquestions.org/questions/linux-hardware-18/pctv-dvb-s2-stick-461e-not-feeding-lnb-4175529374/
> https://www.linuxtv.org/wiki/index.php/Pinnacle_PCTV_DVB-S2_Stick_(461e)
> https://github.com/OpenELEC/OpenELEC.tv/issues/3731
> 
> Caused by vIN undervoltage lockout (status register bit 7) when raising LNB to 18V.
> Addressed by using the higher-precision voltages available on the a8293 to gradually
> increase (slew) the voltage when voltage increases are requested.
> 
> Adds volt_slew_nanos_per_mv to a8293_platform_data struct for specifying slew rate.
> If value is <1 or non-sane (>1600), the original no-slew version for a8293_set_voltage is used.
> 
> Signed-off-by: Chuck Ritola <cjritola@gmail.com>
> ---
>  drivers/media/dvb-frontends/a8293.c   | 147 +++++++++++++++++++++++++-
>  drivers/media/dvb-frontends/a8293.h   |   2 +
>  drivers/media/usb/em28xx/em28xx-dvb.c |   3 +
>  3 files changed, 150 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/a8293.c b/drivers/media/dvb-frontends/a8293.c
> index 57f52c004..f86af43ee 100644
> --- a/drivers/media/dvb-frontends/a8293.c
> +++ b/drivers/media/dvb-frontends/a8293.c
> @@ -3,16 +3,139 @@
>   * Allegro A8293 SEC driver
>   *
>   * Copyright (C) 2011 Antti Palosaari <crope@iki.fi>
> + * Copyright (C) 2021 Chuck Ritola <cjritola@gmail.com>

We don't usually add copyrights on files authored by others, except
when the original author explicitly agree with that by sending his
Signed-off-by or Acked-by.

So, except if Antti agrees with that, please remove this change
from the patch. Your credits will still be there stored at the
git tree.

>   */
>  
>  #include "a8293.h"
>  
> +#define A8293_FLAG_ODT			0x10
> +
> +
>  struct a8293_dev {
>  	struct i2c_client *client;
>  	u8 reg[2];
> +	int volt_slew_nanos_per_mv;
>  };
>  
> -static int a8293_set_voltage(struct dvb_frontend *fe,
> +/*
> + * When increasing voltage, do so in minimal steps over time, minimizing risk of vIN undervoltage.
> + */
> +
> +static int a8293_set_voltage_slew(struct a8293_dev *dev,
> +				struct i2c_client *client,
> +			     enum fe_sec_voltage fe_sec_voltage,
> +				int min_nanos_per_mv)
> +{
> +	int ret;
> +	u8 reg0, reg1;
> +	int new_volt_idx;
> +	const int idx_to_mv[] = {0,    12709, 13042, 13375, 14042, 15042, 18042, 18709, 19042};
> +	const u8 idx_to_reg[] = {0x00, 0x20,  0x21,  0x22,  0x24,  0x27,  0x28,  0x2A,  0x2B };
> +	int this_volt_idx;
> +	u8 status;
> +	int prev_volt_idx;
> +
> +	dev_dbg(&client->dev, "set_voltage_slew fe_sec_voltage=%d\n", fe_sec_voltage);
> +
> +	/* Read status register to clear any stale faults. */
> +	ret = i2c_master_recv(client, &status, 1);
> +	if (ret < 0)
> +		goto err;
> +
> +	/* Determine previous voltage */
> +	switch (dev->reg[0] & 0x2F) {
> +	case 0x00:
> +		prev_volt_idx = 0;
> +		break;
> +	case 0x20:
> +		prev_volt_idx = 1;
> +		break;
> +	case 0x21:
> +		prev_volt_idx = 2;
> +		break;
> +	case 0x22:
> +		prev_volt_idx = 3;
> +		break;
> +	case 0x24:
> +		prev_volt_idx = 4;
> +		break;
> +	case 0x27:
> +		prev_volt_idx = 5;
> +		break;
> +	case 0x28:
> +		prev_volt_idx = 6;
> +		break;
> +	case 0x2A:
> +		prev_volt_idx = 7;
> +		break;
> +	case 0x2B:
> +		prev_volt_idx = 8;
> +		break;
> +	default:
> +		prev_volt_idx = 0;
> +	}
> +
> +	/* Determine new voltage */
> +	switch (fe_sec_voltage) {
> +	case SEC_VOLTAGE_OFF:
> +		new_volt_idx = 0;
> +		break;
> +	case SEC_VOLTAGE_13:
> +		new_volt_idx = 2;
> +		break;
> +	case SEC_VOLTAGE_18:
> +		new_volt_idx = 6;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	/* Slew to new voltage if new voltage is greater than current voltage */
> +	this_volt_idx = prev_volt_idx;
> +	if (this_volt_idx < new_volt_idx) {
> +		while (this_volt_idx < new_volt_idx) {
> +			int delta_mv = idx_to_mv[this_volt_idx+1] - idx_to_mv[this_volt_idx];
> +			int min_wait_time = delta_mv * min_nanos_per_mv;
> +
> +			reg0 = idx_to_reg[this_volt_idx+1];
> +			reg0 |= A8293_FLAG_ODT;
> +
> +			ret = i2c_master_send(client, &reg0, 1);
> +			if (ret < 0)
> +				goto err;
> +			dev->reg[0] = reg0;
> +			this_volt_idx++;
> +			usleep_range(min_wait_time, min_wait_time * 2);
> +		}
> +	} else { /* Else just set the voltage */
> +		reg0 = idx_to_reg[new_volt_idx];
> +		reg0 |= A8293_FLAG_ODT;
> +		ret = i2c_master_send(client, &reg0, 1);
> +		if (ret < 0)
> +			goto err;
> +		dev->reg[0] = reg0;
> +	}
> +
> +	/* TMODE=0, TGATE=1 */
> +	reg1 = 0x82;
> +	if (reg1 != dev->reg[1]) {
> +		ret = i2c_master_send(client, &reg1, 1);
> +		if (ret < 0)
> +			goto err;
> +		dev->reg[1] = reg1;
> +	}
> +
> +	usleep_range(1500, 5000);
> +
> +	return 0;
> +err:
> +	dev_dbg(&client->dev, "failed=%d\n", ret);
> +	return ret;
> +}
> +
> +
> +static int a8293_set_voltage_noslew(struct dvb_frontend *fe,
>  			     enum fe_sec_voltage fe_sec_voltage)
>  {
>  	struct a8293_dev *dev = fe->sec_priv;
> @@ -20,7 +143,7 @@ static int a8293_set_voltage(struct dvb_frontend *fe,
>  	int ret;
>  	u8 reg0, reg1;
>  
> -	dev_dbg(&client->dev, "fe_sec_voltage=%d\n", fe_sec_voltage);
> +	dev_dbg(&client->dev, "set_voltage_noslew fe_sec_voltage=%d\n", fe_sec_voltage);
>  
>  	switch (fe_sec_voltage) {
>  	case SEC_VOLTAGE_OFF:
> @@ -62,6 +185,24 @@ static int a8293_set_voltage(struct dvb_frontend *fe,
>  	return ret;
>  }
>  
> +static int a8293_set_voltage(struct dvb_frontend *fe,
> +			     enum fe_sec_voltage fe_sec_voltage)
> +{
> +	struct a8293_dev *dev = fe->sec_priv;
> +	struct i2c_client *client = dev->client;
> +	int volt_slew_nanos_per_mv = dev->volt_slew_nanos_per_mv;
> +
> +	dev_dbg(&client->dev, "set_voltage volt_slew_nanos_per_mv=%d\n", volt_slew_nanos_per_mv);
> +
> +	/* Use slew version if slew rate is set to a sane value */
> +	if (volt_slew_nanos_per_mv > 0 && volt_slew_nanos_per_mv < 1600)
> +		a8293_set_voltage_slew(dev, client, fe_sec_voltage, volt_slew_nanos_per_mv);
> +	else
> +		a8293_set_voltage_noslew(fe, fe_sec_voltage);
> +
> +	return 0;
> +}
> +
>  static int a8293_probe(struct i2c_client *client,
>  		       const struct i2c_device_id *id)
>  {
> @@ -78,6 +219,7 @@ static int a8293_probe(struct i2c_client *client,
>  	}
>  
>  	dev->client = client;
> +	dev->volt_slew_nanos_per_mv = pdata->volt_slew_nanos_per_mv;
>  
>  	/* check if the SEC is there */
>  	ret = i2c_master_recv(client, buf, 2);
> @@ -127,5 +269,6 @@ static struct i2c_driver a8293_driver = {
>  module_i2c_driver(a8293_driver);
>  
>  MODULE_AUTHOR("Antti Palosaari <crope@iki.fi>");
> +MODULE_AUTHOR("Chuck Ritola <cjritola@gmail.com>");

Same applies here.

>  MODULE_DESCRIPTION("Allegro A8293 SEC driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/media/dvb-frontends/a8293.h b/drivers/media/dvb-frontends/a8293.h
> index 8c09635ef..0a807c022 100644
> --- a/drivers/media/dvb-frontends/a8293.h
> +++ b/drivers/media/dvb-frontends/a8293.h
> @@ -18,9 +18,11 @@
>  /**
>   * struct a8293_platform_data - Platform data for the a8293 driver
>   * @dvb_frontend: DVB frontend.
> + * @volt_slew_nanos_per_mv: Slew rate when increasing LNB voltage, in nanoseconds per millivolt.
>   */
>  struct a8293_platform_data {
>  	struct dvb_frontend *dvb_frontend;
> +	int volt_slew_nanos_per_mv;
>  };
>  
>  #endif /* A8293_H */
> diff --git a/drivers/media/usb/em28xx/em28xx-dvb.c b/drivers/media/usb/em28xx/em28xx-dvb.c
> index 471bd7466..859f4a33e 100644
> --- a/drivers/media/usb/em28xx/em28xx-dvb.c
> +++ b/drivers/media/usb/em28xx/em28xx-dvb.c
> @@ -1208,6 +1208,9 @@ static int em28178_dvb_init_pctv_461e(struct em28xx *dev)
>  
>  	/* attach SEC */
>  	a8293_pdata.dvb_frontend = dvb->fe[0];
> +	/* 461e has a tendency to have vIN undervoltage troubles. Slew mitigates this. */
> +	a8293_pdata.volt_slew_nanos_per_mv = 20;
> +
>  	dvb->i2c_client_sec = dvb_module_probe("a8293", NULL,
>  					       &dev->i2c_adap[dev->def_i2c_bus],
>  					       0x08, &a8293_pdata);

Thanks,
Mauro
