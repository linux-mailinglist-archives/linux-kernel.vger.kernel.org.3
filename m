Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3A44FF677
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiDMMMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiDMML7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:11:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED197366B8;
        Wed, 13 Apr 2022 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649851778; x=1681387778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hhyexus128Xv2t+3slwqPm0xae7+oA0Gbb2vq1OyZlg=;
  b=VuEhqLLaBM60NkYdaPUCxuX2N1zeA5xSVN33x+W1eoyi7gmpQiQNd1aA
   A0L1foTx5Zegn3QKhwFsGSKzCH9oyPzLb9UbRwIWlTYHLQxiWt/oQqjCC
   790ZIfdqRCF8WrWM0Y0FNiO/zTfFE2xKp+JSVQlxfX2LhcWXGLAvX/qPQ
   9n03SayN0cGUBqhJOB+64F689fo2F48CCQ1yg1wuiW1uTUBXvDIdMqjhU
   fYlHlYjkfllhzbSLFh1ZQakLpY1ziqP/LVFfRCrdHYk+5cwA9BKugW0n2
   ZWLD0kJXJti78I/XyFw+iUHDeb2mv1nyiCVmklokq8cs9ETBn7sydgzHG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261495220"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="261495220"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 05:09:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="559725422"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 05:09:37 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 28F1F20316;
        Wed, 13 Apr 2022 15:09:35 +0300 (EEST)
Date:   Wed, 13 Apr 2022 15:09:35 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: dw9714: Register a callback to disable the
 regulator
Message-ID: <Yla9f03/j9sEB2Rc@paasikivi.fi.intel.com>
References: <20220409140939.2176161-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409140939.2176161-1-zheyuma97@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheyu,

Thanks for the patch.

On Sat, Apr 09, 2022 at 10:09:39PM +0800, Zheyu Ma wrote:
> When the driver fails to probe, we will get the following splat:
> 
> [   59.305988] ------------[ cut here ]------------
> [   59.306417] WARNING: CPU: 2 PID: 395 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> [   59.310345] RIP: 0010:_regulator_put+0x3ec/0x4e0
> [   59.318362] Call Trace:
> [   59.318582]  <TASK>
> [   59.318765]  regulator_put+0x1f/0x30
> [   59.319058]  devres_release_group+0x319/0x3d0
> [   59.319420]  i2c_device_probe+0x766/0x940
> 
> Fix this by adding a callback that will deal with the disabling when the
> driver fails to probe.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/media/i2c/dw9714.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
> index cd7008ad8f2f..eccd05fc50c7 100644
> --- a/drivers/media/i2c/dw9714.c
> +++ b/drivers/media/i2c/dw9714.c
> @@ -137,6 +137,13 @@ static int dw9714_init_controls(struct dw9714_device *dev_vcm)
>  	return hdl->error;
>  }
>  
> +static void dw9714_disable_regulator(void *arg)
> +{
> +	struct dw9714_device *dw9714_dev = arg;
> +
> +	regulator_disable(dw9714_dev->vcc);
> +}
> +
>  static int dw9714_probe(struct i2c_client *client)
>  {
>  	struct dw9714_device *dw9714_dev;
> @@ -157,6 +164,10 @@ static int dw9714_probe(struct i2c_client *client)
>  		return rval;
>  	}
>  
> +	rval = devm_add_action_or_reset(&client->dev, dw9714_disable_regulator, dw9714_dev);
> +	if (rval)
> +		return rval;
> +
>  	v4l2_i2c_subdev_init(&dw9714_dev->sd, client, &dw9714_ops);
>  	dw9714_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
>  				V4L2_SUBDEV_FL_HAS_EVENTS;

Could you instead disable the regulator in error handling in the probe
function?

-- 
Sakari Ailus
