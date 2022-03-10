Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238314D5205
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245728AbiCJTGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbiCJTGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:06:04 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C915E141E3E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646939102; x=1678475102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WnFGNKbJzycKyV82fMk3LWMbBnyeS+s9105OQY/fMpc=;
  b=jOQkeXeihZRAUZnmZfqgK1V1WJurN4yFWBixmEuw0+rTbe1LMZlp0ET1
   P5qJNNihAAoDh5joEuiyi3Ks/Hagd/Zwtdp/rq+3En/Cv6vv2X3xSTqcH
   ptrr73D5X/OiPeD+qtj2HDCGjkcO8+LyFLC/cjMdJilAWAtLApeYlL7Ce
   Op2nPBAO80VezYpeBAk3hBXV2EYMUdldaFXMDzgfJ5iaG+eHh5IxQYfjK
   fmWcvAnFRBXVTdsXXZ85lpKXPRdezRM8FR5+FY/cBCiuXDbmiNqQ3e/ur
   rpa6eDobrcDHtDX0O8dysgH8wRusmB+sreBeSBEfuyo2opxM9UFM9Opy2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255081932"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="255081932"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 11:03:49 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="554794723"
Received: from jdubrow-mobl.amr.corp.intel.com (HELO intel.com) ([10.255.39.9])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 11:03:46 -0800
Date:   Thu, 10 Mar 2022 14:03:45 -0500
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v10 4/5] mei: gsc: add runtime pm handlers
Message-ID: <YipLkXkoZFFNuK3p@intel.com>
References: <20220308163654.942820-1-alexander.usyskin@intel.com>
 <20220308163654.942820-5-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308163654.942820-5-alexander.usyskin@intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 06:36:53PM +0200, Alexander Usyskin wrote:
> From: Tomas Winkler <tomas.winkler@intel.com>
> 
> Implement runtime handlers for mei-gsc, to track
> idle state of the device properly.
> 
> CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/misc/mei/gsc-me.c | 67 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> index cf427f6fdec9..dac482ddab51 100644
> --- a/drivers/misc/mei/gsc-me.c
> +++ b/drivers/misc/mei/gsc-me.c
> @@ -152,7 +152,72 @@ static int __maybe_unused mei_gsc_pm_resume(struct device *device)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(mei_gsc_pm_ops, mei_gsc_pm_suspend, mei_gsc_pm_resume);
> +static int __maybe_unused mei_gsc_pm_runtime_idle(struct device *device)
> +{
> +	struct mei_device *dev = dev_get_drvdata(device);
> +
> +	if (!dev)
> +		return -ENODEV;
> +	if (mei_write_is_idle(dev))
> +		pm_runtime_autosuspend(device);

This is not needed. The _idle() callback is called right before the autosuspend.
so you just need to return -EBUSY if not idle.

But also I'm missing the call to enable the autosuspend and set the delay.

Is this flow really working and you are getting device suspended when not in use?
(Maybe it is just my ignorance on other flow types here)

> +
> +	return -EBUSY;
> +}
> +
> +static int  __maybe_unused mei_gsc_pm_runtime_suspend(struct device *device)
> +{
> +	struct mei_device *dev = dev_get_drvdata(device);
> +	struct mei_me_hw *hw;
> +	int ret;
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	mutex_lock(&dev->device_lock);
> +
> +	if (mei_write_is_idle(dev)) {
> +		hw = to_me_hw(dev);
> +		hw->pg_state = MEI_PG_ON;
> +		ret = 0;
> +	} else {
> +		ret = -EAGAIN;
> +	}

probably not needed this here... but it would be good if you use
the runtime_pm{get,put} to protect your write operations as well...

> +
> +	mutex_unlock(&dev->device_lock);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused mei_gsc_pm_runtime_resume(struct device *device)
> +{
> +	struct mei_device *dev = dev_get_drvdata(device);
> +	struct mei_me_hw *hw;
> +	irqreturn_t irq_ret;
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	mutex_lock(&dev->device_lock);
> +
> +	hw = to_me_hw(dev);
> +	hw->pg_state = MEI_PG_OFF;
> +
> +	mutex_unlock(&dev->device_lock);
> +
> +	irq_ret = mei_me_irq_thread_handler(1, dev);
> +	if (irq_ret != IRQ_HANDLED)
> +		dev_err(dev->dev, "thread handler fail %d\n", irq_ret);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops mei_gsc_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(mei_gsc_pm_suspend,
> +				mei_gsc_pm_resume)
> +	SET_RUNTIME_PM_OPS(mei_gsc_pm_runtime_suspend,
> +			   mei_gsc_pm_runtime_resume,
> +			   mei_gsc_pm_runtime_idle)
> +};
>  
>  static const struct auxiliary_device_id mei_gsc_id_table[] = {
>  	{
> -- 
> 2.32.0
> 
