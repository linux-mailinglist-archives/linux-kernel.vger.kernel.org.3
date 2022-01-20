Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FC3494B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359687AbiATJ5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:57:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:53476 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234649AbiATJ44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642672616; x=1674208616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GPPqEEya5Djn2FMh4k7K1ILiDGJZo64bnZksGVpDU44=;
  b=gYJJLGmWD4cRpDx8belNarmy7ygRhlByejziDVPluXkcuI+3tZgpgmGo
   4ghsCkwI2XUe9p1LIvOHjJ7qEGllpo8oFitIaXJ3NksNbv8attbE5P4ZO
   rp6LVxe1QPC07XYJDA+gUeOJJrMf6I5GENsDZN5B06HfS8KiRkIODcoGa
   rOzPnmkmi0sCvKwTgvANWbSgPSDh/aua+hty7I6TiImB4Cl5nrAbV3r1c
   P70bOdJAmjgKVAsJJxow6g4psAYhemIVy6EZ4Fs80A6MTVgjrGDhIEgof
   kvNwKZj67kscdxOZPPIj6mixh2Sjf5AFwStt/tJDNw9vFICwAw/ad+MEB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="245513190"
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="245513190"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 01:56:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="626235260"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 01:56:45 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id AA0EE203C8;
        Thu, 20 Jan 2022 11:56:43 +0200 (EET)
Date:   Thu, 20 Jan 2022 11:56:43 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     broonie@kernel.org, angus@akkea.ca, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH v3] media: i2c: dw9714: add optional regulator support
Message-ID: <Yekx25NEQZ7iownA@paasikivi.fi.intel.com>
References: <20211129120754.1766570-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129120754.1766570-1-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Apologies for the delay.

On Mon, Nov 29, 2021 at 01:07:54PM +0100, Martin Kepplinger wrote:
> From: Angus Ainslie <angus@akkea.ca>
> 
> Allow the dw9714 to control a regulator and adjust suspend() and resume()
> to support both runtime and system pm.
> 
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
> 
> 
> revision history
> ----------------
> v3: (thank you Mark and Sakari)
>  * use regulator_get() instead of regulator_get_optional()
> 
> v2: (thank you Mark)
>  * simplify the regulator_get_optional() error path
>  * fix regulator usage during probe()
> https://lore.kernel.org/linux-media/20211126090107.1243558-1-martin.kepplinger@puri.sm/
> 
> v1:
> https://lore.kernel.org/linux-media/20211125080922.978583-1-martin.kepplinger@puri.sm/
> 
> 
> 
>  drivers/media/i2c/dw9714.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
> index 3863dfeb8293..81170bbe0e55 100644
> --- a/drivers/media/i2c/dw9714.c
> +++ b/drivers/media/i2c/dw9714.c
> @@ -5,6 +5,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-event.h>
> @@ -36,6 +37,7 @@ struct dw9714_device {
>  	struct v4l2_ctrl_handler ctrls_vcm;
>  	struct v4l2_subdev sd;
>  	u16 current_val;
> +	struct regulator *vcc;
>  };
>  
>  static inline struct dw9714_device *to_dw9714_vcm(struct v4l2_ctrl *ctrl)
> @@ -145,6 +147,16 @@ static int dw9714_probe(struct i2c_client *client)
>  	if (dw9714_dev == NULL)
>  		return -ENOMEM;
>  
> +	dw9714_dev->vcc = devm_regulator_get(&client->dev, "vcc");
> +	if (IS_ERR(dw9714_dev->vcc))
> +		return PTR_ERR(dw9714_dev->vcc);
> +
> +	rval = regulator_enable(dw9714_dev->vcc);

You'll need to disable the regulator in driver's remove callback. That also
depends on runtime PM.

See e.g. ccs_remove() in drivers/media/i2c/ccs/ccs-core.c .

> +	if (rval < 0) {
> +		dev_err(&client->dev, "failed to enable vcc: %d\n", rval);
> +		return rval;
> +	}
> +
>  	v4l2_i2c_subdev_init(&dw9714_dev->sd, client, &dw9714_ops);
>  	dw9714_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
>  				V4L2_SUBDEV_FL_HAS_EVENTS;
> @@ -200,6 +212,9 @@ static int __maybe_unused dw9714_vcm_suspend(struct device *dev)
>  	struct dw9714_device *dw9714_dev = sd_to_dw9714_vcm(sd);
>  	int ret, val;
>  
> +	if (pm_runtime_suspended(&client->dev))
> +		return 0;
> +
>  	for (val = dw9714_dev->current_val & ~(DW9714_CTRL_STEPS - 1);
>  	     val >= 0; val -= DW9714_CTRL_STEPS) {
>  		ret = dw9714_i2c_write(client,
> @@ -208,7 +223,12 @@ static int __maybe_unused dw9714_vcm_suspend(struct device *dev)
>  			dev_err_once(dev, "%s I2C failure: %d", __func__, ret);
>  		usleep_range(DW9714_CTRL_DELAY_US, DW9714_CTRL_DELAY_US + 10);
>  	}
> -	return 0;
> +
> +	ret = regulator_disable(dw9714_dev->vcc);
> +	if (ret)
> +		dev_err(dev, "Failed to disable vcc: %d\n", ret);
> +
> +	return ret;
>  }
>  
>  /*
> @@ -224,6 +244,16 @@ static int  __maybe_unused dw9714_vcm_resume(struct device *dev)
>  	struct dw9714_device *dw9714_dev = sd_to_dw9714_vcm(sd);
>  	int ret, val;
>  
> +	if (pm_runtime_suspended(&client->dev))
> +		return 0;
> +
> +	ret = regulator_enable(dw9714_dev->vcc);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable vcc: %d\n", ret);
> +		return ret;
> +	}
> +	usleep_range(1000, 2000);
> +
>  	for (val = dw9714_dev->current_val % DW9714_CTRL_STEPS;
>  	     val < dw9714_dev->current_val + DW9714_CTRL_STEPS - 1;
>  	     val += DW9714_CTRL_STEPS) {

-- 
Sakari Ailus
