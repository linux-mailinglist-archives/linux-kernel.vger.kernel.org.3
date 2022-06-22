Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECE3554928
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357428AbiFVLRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357187AbiFVLQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:16:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7CD3BA79;
        Wed, 22 Jun 2022 04:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655896614; x=1687432614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MLLOeP/ifnd8x8DPdN0jA/knFVmnzPBL5uESewLgq68=;
  b=PxC13SO71uBEcv6m4uBD4RrUx9kzPQIiL3Y+8M0TtAas1pNwiRbjCbDP
   FlA7jL1vjbcnj50X2p+YhMEK/3DJ7YT/XKgb9/hOfS3UU4Tf2Piv7mEbj
   d8xCkfSpnj+yLNonKCpvzTOgdH5VR510OVdJnXSlo8BuPpkyDfNKSfVHZ
   upfSr6MOxGLpcyBN0uityuDFoPcwUUoq33F2S5/6MHkN6pCKHqQVeggQP
   eWyB4lAR0F6vZ7cdsDqBTR5ppzVfEFJgF/9BUe7pC7bUz8tJuPlXoAJgZ
   oUilmYOU1ZeBbkhT+ELOwpqqpRAIUkEn0YCUhVhBaQKpl1Vhg9wWuJqTh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281120406"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281120406"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 04:16:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="677489669"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 04:16:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3yLn-000sHA-U0;
        Wed, 22 Jun 2022 14:16:47 +0300
Date:   Wed, 22 Jun 2022 14:16:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, djrscally@gmail.com,
        sakari.ailus@linux.intel.com
Subject: Re: [PATCH -next v2] media: ov7251: add missing disable functions on
 error in ov7251_set_power_on()
Message-ID: <YrL6H6Dfp/z3hNhl@smile.fi.intel.com>
References: <20220622044243.2900783-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622044243.2900783-1-yangyingliang@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:42:43PM +0800, Yang Yingliang wrote:
> Add the missing gpiod_set_value_cansleep() and clk_disable_unprepare()
> before return from ov7251_set_power_on() in the error handling case.

This makes sense to me from code flow perspective.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 9e1d3012cc10 ("media: i2c: Remove .s_power() from ov7251")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>   - add gpiod_set_value_cansleep()
>   - also change the patch title and commit message
> ---
>  drivers/media/i2c/ov7251.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
> index 0e7be15bc20a..ad9689820ecc 100644
> --- a/drivers/media/i2c/ov7251.c
> +++ b/drivers/media/i2c/ov7251.c
> @@ -934,6 +934,8 @@ static int ov7251_set_power_on(struct device *dev)
>  					ARRAY_SIZE(ov7251_global_init_setting));
>  	if (ret < 0) {
>  		dev_err(ov7251->dev, "error during global init\n");
> +		gpiod_set_value_cansleep(ov7251->enable_gpio, 0);
> +		clk_disable_unprepare(ov7251->xclk);
>  		ov7251_regulators_disable(ov7251);
>  		return ret;
>  	}
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


