Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197694DDB57
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbiCRON7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiCRON4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:13:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5BF228D2D;
        Fri, 18 Mar 2022 07:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647612757; x=1679148757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tU+/rM47jb0yzckoQPeArY4wRj/yQ13txRTRa2WwT6U=;
  b=ilXV0neZUFrwCEWW53YxNK9KXqP0o3UzuSzMmzCpEyKn4lg+C0pOgjQQ
   MxkZtmRgEMb4hLTacV2zWIfx3akF+T0C8YvOkj2UU77AIak3RPXDF+szb
   EPnbjPkXs3xGnKEh6PnZxcoe+k4SzZhSzU91pd0yRBi8Ighdz/XqNQ3z9
   Rf93JGfqJJAtGZ1qU3RjRGOs/TEd1bSy1xzUjsoKUIv0bB4CLAuhaPYv/
   BJIZP3fFg741WbGMFNpBTfn4Pu4Leo4JRS0IMDawJWU8VpZh2b+lHFtJE
   ChUMAqgt11DCOfagxCKxR4VDw8pYaDC151486OZ7dp98ICW1YG651jD5k
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257091616"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257091616"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:12:37 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="635767287"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:12:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nVDKd-002GWj-P6;
        Fri, 18 Mar 2022 16:11:55 +0200
Date:   Fri, 18 Mar 2022 16:11:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:imu:bmi160: disable regulator in error path
Message-ID: <YjSTK4yun3kiulB1@smile.fi.intel.com>
References: <20220318070900.2499370-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318070900.2499370-1-ztong0001@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 12:09:00AM -0700, Tong Zhang wrote:
> regulator should be disabled in error path as mentioned in _regulator_put()
> 
> [   16.233604] WARNING: CPU: 0 PID: 2177 at drivers/regulator/core.c:2257 _regulator_put
> [   16.240453] Call Trace:
> [   16.240572]  <TASK>
> [   16.240676]  regulator_put+0x26/0x40
> [   16.240853]  regulator_bulk_free+0x26/0x50
> [   16.241050]  release_nodes+0x3f/0x70
> [   16.241225]  devres_release_group+0x147/0x1c0
> [   16.241441]  ? bmi160_core_probe+0x175/0x3a0 [bmi160_core]

Seems legit. Currently we call it only when something else is failed afterwards.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 5dea3fb066f0 ("iio: imu: bmi160: added regulator support")
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 824b5124a5f5..f12446edb5ce 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -730,7 +730,7 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
>  
>  	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
>  	if (ret)
> -		return ret;
> +		goto disable_regulator;
>  
>  	usleep_range(BMI160_SOFTRESET_USLEEP, BMI160_SOFTRESET_USLEEP + 1);
>  
> @@ -741,29 +741,34 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
>  	if (use_spi) {
>  		ret = regmap_read(data->regmap, BMI160_REG_DUMMY, &val);
>  		if (ret)
> -			return ret;
> +		goto disable_regulator;
>  	}
>  
>  	ret = regmap_read(data->regmap, BMI160_REG_CHIP_ID, &val);
>  	if (ret) {
>  		dev_err(dev, "Error reading chip id\n");
> -		return ret;
> +		goto disable_regulator;
>  	}
>  	if (val != BMI160_CHIP_ID_VAL) {
>  		dev_err(dev, "Wrong chip id, got %x expected %x\n",
>  			val, BMI160_CHIP_ID_VAL);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto disable_regulator;
>  	}
>  
>  	ret = bmi160_set_mode(data, BMI160_ACCEL, true);
>  	if (ret)
> -		return ret;
> +		goto disable_regulator;
>  
>  	ret = bmi160_set_mode(data, BMI160_GYRO, true);
>  	if (ret)
> -		return ret;
> +		goto disable_regulator;
>  
>  	return 0;
> +
> +disable_regulator:
> +	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
> +	return ret;
>  }
>  
>  static int bmi160_data_rdy_trigger_set_state(struct iio_trigger *trig,
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


