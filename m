Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C7A487744
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiAGMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:01:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:54093 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbiAGMBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641556867; x=1673092867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=heSDGCNywvZzzqIbhUmNfkHqbvb5bJzIwb1qtihvehM=;
  b=Tak9LzTVFEQ5KpAjg9bbqhWiV5vLm/dcYsjH0089QYkqG4l/CR9wE96A
   KwdXz68xIZzkgvglXwDEI0oX2BMo5JrJcrZhqVH6NZ37Cul2QQEvZgjkV
   /UJ41a/eIjdQGoOhsPybX7xNbvhjpH5cmp6wxpcvCAkCFDphc+DVbIgd/
   Gu996U8NZROwYR5K+nJ7YAkn8EBu8E41scDS5jYWz1C6KJxTbtNIfl4l0
   QiiruPhd0zCYYXbLCAj7QfTCgsrKVmyjfoSxMlL75th1VmgMOUbPhdSkN
   NApq03q2jbk2dpdvcnKSA7GjYgKo2WnPaddL1y7484MLwzeQoBOiYfoYE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="240407162"
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="240407162"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 04:01:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="689763914"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 04:01:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n5nuN-007MdL-Dk;
        Fri, 07 Jan 2022 13:59:47 +0200
Date:   Fri, 7 Jan 2022 13:59:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     adi.reus@gmail.com, ardeleanalex@gmail.com, gwendal@chromium.org,
        jic23@kernel.org, lars@metafoo.de, linus.walleij@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stephan@gerhold.net
Subject: Re: [PATCH v2] iio: Fix error handling for PM
Message-ID: <YdgrMwCkqzOG8j/j@smile.fi.intel.com>
References: <YdWjHWowWXy01zaE@smile.fi.intel.com>
 <20220106112309.16879-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106112309.16879-1-linmq006@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 11:23:09AM +0000, Miaoqian Lin wrote:
> The pm_runtime_enable will increase power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable(). In the PM Runtime docs:
>     Drivers in ->remove() callback should undo the runtime PM changes done
>     in ->probe(). Usually this means calling pm_runtime_disable(),
>     pm_runtime_dont_use_autosuspend() etc.
> We should do this in error handling.
> 
> Fix this problem for the following drivers: bmc150, bmg160, kmx61,
> kxcj-1013, mma9551, mma9553.

LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 7d0ead5c3f00 ("iio: Reconcile operation order between iio_register/unregister and pm functions")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> Changes in v2:
> - fix the fixes tag
> - fix similar problems introduced by the same commit
> ---
>  drivers/iio/accel/bmc150-accel-core.c  | 5 ++++-
>  drivers/iio/accel/kxcjk-1013.c         | 5 ++++-
>  drivers/iio/accel/mma9551.c            | 5 ++++-
>  drivers/iio/accel/mma9553.c            | 5 ++++-
>  drivers/iio/gyro/bmg160_core.c         | 5 ++++-
>  drivers/iio/imu/kmx61.c                | 5 ++++-
>  drivers/iio/magnetometer/bmc150_magn.c | 5 +++--
>  7 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index b0678c351e82..c3a2b4c0b3b2 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1783,11 +1783,14 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(dev, "Unable to register iio device\n");
> -		goto err_trigger_unregister;
> +		goto err_pm_cleanup;
>  	}
>  
>  	return 0;
>  
> +err_pm_cleanup:
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_disable(dev);
>  err_trigger_unregister:
>  	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
>  err_buffer_cleanup:
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 24c9387c2968..ba6c8ca488b1 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1589,11 +1589,14 @@ static int kxcjk1013_probe(struct i2c_client *client,
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "unable to register iio device\n");
> -		goto err_buffer_cleanup;
> +		goto err_pm_cleanup;
>  	}
>  
>  	return 0;
>  
> +err_pm_cleanup:
> +	pm_runtime_dont_use_autosuspend(&client->dev);
> +	pm_runtime_disable(&client->dev);
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  err_trigger_unregister:
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index 4c359fb05480..c53a3398b14c 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -495,11 +495,14 @@ static int mma9551_probe(struct i2c_client *client,
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "unable to register iio device\n");
> -		goto out_poweroff;
> +		goto err_pm_cleanup;
>  	}
>  
>  	return 0;
>  
> +err_pm_cleanup:
> +	pm_runtime_dont_use_autosuspend(&client->dev);
> +	pm_runtime_disable(&client->dev);
>  out_poweroff:
>  	mma9551_set_device_state(client, false);
>  
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index ba3ecb3b57dc..1599b75724d4 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -1134,12 +1134,15 @@ static int mma9553_probe(struct i2c_client *client,
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "unable to register iio device\n");
> -		goto out_poweroff;
> +		goto err_pm_cleanup;
>  	}
>  
>  	dev_dbg(&indio_dev->dev, "Registered device %s\n", name);
>  	return 0;
>  
> +err_pm_cleanup:
> +	pm_runtime_dont_use_autosuspend(&client->dev);
> +	pm_runtime_disable(&client->dev);
>  out_poweroff:
>  	mma9551_set_device_state(client, false);
>  	return ret;
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 17b939a367ad..81a6d09788bd 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -1188,11 +1188,14 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(dev, "unable to register iio device\n");
> -		goto err_buffer_cleanup;
> +		goto err_pm_cleanup;
>  	}
>  
>  	return 0;
>  
> +err_pm_cleanup:
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_disable(dev);
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  err_trigger_unregister:
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 1dabfd615dab..f89724481df9 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -1385,7 +1385,7 @@ static int kmx61_probe(struct i2c_client *client,
>  	ret = iio_device_register(data->acc_indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Failed to register acc iio device\n");
> -		goto err_buffer_cleanup_mag;
> +		goto err_pm_cleanup;
>  	}
>  
>  	ret = iio_device_register(data->mag_indio_dev);
> @@ -1398,6 +1398,9 @@ static int kmx61_probe(struct i2c_client *client,
>  
>  err_iio_unregister_acc:
>  	iio_device_unregister(data->acc_indio_dev);
> +err_pm_cleanup:
> +	pm_runtime_dont_use_autosuspend(&client->dev);
> +	pm_runtime_disable(&client->dev);
>  err_buffer_cleanup_mag:
>  	if (client->irq > 0)
>  		iio_triggered_buffer_cleanup(data->mag_indio_dev);
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index f96f53175349..3d4d21f979fa 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -962,13 +962,14 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(dev, "unable to register iio device\n");
> -		goto err_disable_runtime_pm;
> +		goto err_pm_cleanup;
>  	}
>  
>  	dev_dbg(dev, "Registered device %s\n", name);
>  	return 0;
>  
> -err_disable_runtime_pm:
> +err_pm_cleanup:
> +	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


