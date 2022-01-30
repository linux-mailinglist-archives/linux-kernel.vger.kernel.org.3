Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5904A36E0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355132AbiA3OqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:46:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54302 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355122AbiA3OpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:45:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 077A9B82973;
        Sun, 30 Jan 2022 14:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161E5C340E8;
        Sun, 30 Jan 2022 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643553922;
        bh=5HmiHVeprudoa5Q4aruSHZTv9jVzOD5vFnAOcy/m0zY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=clqj16mVniI09/7yffpGOBTFfPpUTpDqWQlRd3/1dJwTRc59CoU+T83nPom24EfHP
         PkLBfWL98h0RRhSt4n15TlJCn7k9h45WnP4znvbXd2SqTQCCxDucrPt50HG603Pz3K
         aAJLZqfYvbcvMOOJsLwtqFc9+RUSkmu2T/+awMwHtY9w+3ULoyEiKDQ/sEAMuDnYQ9
         8ILIa8FkvGRzd+CdpujN30LxDC63HjGVhQq7HAwTm6nTKiAz+eciTJg1kmB9zo+yV2
         cc7qi1JAcIc0abxsy9E/DL+FHUrbs8kJdWrCn8cPqnK0qkYK6Yn5UNqv2Fr37ryzVG
         TaEhoayOFrVVw==
Date:   Sun, 30 Jan 2022 14:51:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>, adi.reus@gmail.com,
        ardeleanalex@gmail.com, gwendal@chromium.org, lars@metafoo.de,
        linus.walleij@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2] iio: Fix error handling for PM
Message-ID: <20220130145146.2d666289@jic23-huawei>
In-Reply-To: <YdgrMwCkqzOG8j/j@smile.fi.intel.com>
References: <YdWjHWowWXy01zaE@smile.fi.intel.com>
        <20220106112309.16879-1-linmq006@gmail.com>
        <YdgrMwCkqzOG8j/j@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 13:59:47 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Jan 06, 2022 at 11:23:09AM +0000, Miaoqian Lin wrote:
> > The pm_runtime_enable will increase power disable depth.
> > If the probe fails, we should use pm_runtime_disable() to balance
> > pm_runtime_enable(). In the PM Runtime docs:
> >     Drivers in ->remove() callback should undo the runtime PM changes done
> >     in ->probe(). Usually this means calling pm_runtime_disable(),
> >     pm_runtime_dont_use_autosuspend() etc.
> > We should do this in error handling.
> > 
> > Fix this problem for the following drivers: bmc150, bmg160, kmx61,
> > kxcj-1013, mma9551, mma9553.  
> 
> LGTM, FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> > Fixes: 7d0ead5c3f00 ("iio: Reconcile operation order between iio_register/unregister and pm functions")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> > Changes in v2:
> > - fix the fixes tag
> > - fix similar problems introduced by the same commit
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c  | 5 ++++-
> >  drivers/iio/accel/kxcjk-1013.c         | 5 ++++-
> >  drivers/iio/accel/mma9551.c            | 5 ++++-
> >  drivers/iio/accel/mma9553.c            | 5 ++++-
> >  drivers/iio/gyro/bmg160_core.c         | 5 ++++-
> >  drivers/iio/imu/kmx61.c                | 5 ++++-
> >  drivers/iio/magnetometer/bmc150_magn.c | 5 +++--
> >  7 files changed, 27 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> > index b0678c351e82..c3a2b4c0b3b2 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -1783,11 +1783,14 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret < 0) {
> >  		dev_err(dev, "Unable to register iio device\n");
> > -		goto err_trigger_unregister;
> > +		goto err_pm_cleanup;
> >  	}
> >  
> >  	return 0;
> >  
> > +err_pm_cleanup:
> > +	pm_runtime_dont_use_autosuspend(dev);
> > +	pm_runtime_disable(dev);
> >  err_trigger_unregister:
> >  	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
> >  err_buffer_cleanup:
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > index 24c9387c2968..ba6c8ca488b1 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -1589,11 +1589,14 @@ static int kxcjk1013_probe(struct i2c_client *client,
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret < 0) {
> >  		dev_err(&client->dev, "unable to register iio device\n");
> > -		goto err_buffer_cleanup;
> > +		goto err_pm_cleanup;
> >  	}
> >  
> >  	return 0;
> >  
> > +err_pm_cleanup:
> > +	pm_runtime_dont_use_autosuspend(&client->dev);
> > +	pm_runtime_disable(&client->dev);
> >  err_buffer_cleanup:
> >  	iio_triggered_buffer_cleanup(indio_dev);
> >  err_trigger_unregister:
> > diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> > index 4c359fb05480..c53a3398b14c 100644
> > --- a/drivers/iio/accel/mma9551.c
> > +++ b/drivers/iio/accel/mma9551.c
> > @@ -495,11 +495,14 @@ static int mma9551_probe(struct i2c_client *client,
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret < 0) {
> >  		dev_err(&client->dev, "unable to register iio device\n");
> > -		goto out_poweroff;
> > +		goto err_pm_cleanup;
> >  	}
> >  
> >  	return 0;
> >  
> > +err_pm_cleanup:
> > +	pm_runtime_dont_use_autosuspend(&client->dev);
> > +	pm_runtime_disable(&client->dev);
> >  out_poweroff:
> >  	mma9551_set_device_state(client, false);
> >  
> > diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> > index ba3ecb3b57dc..1599b75724d4 100644
> > --- a/drivers/iio/accel/mma9553.c
> > +++ b/drivers/iio/accel/mma9553.c
> > @@ -1134,12 +1134,15 @@ static int mma9553_probe(struct i2c_client *client,
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret < 0) {
> >  		dev_err(&client->dev, "unable to register iio device\n");
> > -		goto out_poweroff;
> > +		goto err_pm_cleanup;
> >  	}
> >  
> >  	dev_dbg(&indio_dev->dev, "Registered device %s\n", name);
> >  	return 0;
> >  
> > +err_pm_cleanup:
> > +	pm_runtime_dont_use_autosuspend(&client->dev);
> > +	pm_runtime_disable(&client->dev);
> >  out_poweroff:
> >  	mma9551_set_device_state(client, false);
> >  	return ret;
> > diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> > index 17b939a367ad..81a6d09788bd 100644
> > --- a/drivers/iio/gyro/bmg160_core.c
> > +++ b/drivers/iio/gyro/bmg160_core.c
> > @@ -1188,11 +1188,14 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret < 0) {
> >  		dev_err(dev, "unable to register iio device\n");
> > -		goto err_buffer_cleanup;
> > +		goto err_pm_cleanup;
> >  	}
> >  
> >  	return 0;
> >  
> > +err_pm_cleanup:
> > +	pm_runtime_dont_use_autosuspend(dev);
> > +	pm_runtime_disable(dev);
> >  err_buffer_cleanup:
> >  	iio_triggered_buffer_cleanup(indio_dev);
> >  err_trigger_unregister:
> > diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> > index 1dabfd615dab..f89724481df9 100644
> > --- a/drivers/iio/imu/kmx61.c
> > +++ b/drivers/iio/imu/kmx61.c
> > @@ -1385,7 +1385,7 @@ static int kmx61_probe(struct i2c_client *client,
> >  	ret = iio_device_register(data->acc_indio_dev);
> >  	if (ret < 0) {
> >  		dev_err(&client->dev, "Failed to register acc iio device\n");
> > -		goto err_buffer_cleanup_mag;
> > +		goto err_pm_cleanup;
> >  	}
> >  
> >  	ret = iio_device_register(data->mag_indio_dev);
> > @@ -1398,6 +1398,9 @@ static int kmx61_probe(struct i2c_client *client,
> >  
> >  err_iio_unregister_acc:
> >  	iio_device_unregister(data->acc_indio_dev);
> > +err_pm_cleanup:
> > +	pm_runtime_dont_use_autosuspend(&client->dev);
> > +	pm_runtime_disable(&client->dev);
> >  err_buffer_cleanup_mag:
> >  	if (client->irq > 0)
> >  		iio_triggered_buffer_cleanup(data->mag_indio_dev);
> > diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> > index f96f53175349..3d4d21f979fa 100644
> > --- a/drivers/iio/magnetometer/bmc150_magn.c
> > +++ b/drivers/iio/magnetometer/bmc150_magn.c
> > @@ -962,13 +962,14 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret < 0) {
> >  		dev_err(dev, "unable to register iio device\n");
> > -		goto err_disable_runtime_pm;
> > +		goto err_pm_cleanup;
> >  	}
> >  
> >  	dev_dbg(dev, "Registered device %s\n", name);
> >  	return 0;
> >  
> > -err_disable_runtime_pm:
> > +err_pm_cleanup:
> > +	pm_runtime_dont_use_autosuspend(dev);
> >  	pm_runtime_disable(dev);
> >  err_buffer_cleanup:
> >  	iio_triggered_buffer_cleanup(indio_dev);
> > -- 
> > 2.17.1
> >   
> 

