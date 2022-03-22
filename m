Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF54E4499
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbiCVQ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbiCVQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:57:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E415FB7CC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647968182; x=1679504182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bmmDyu0Vb7XFsOT1vxBWP7QRy91KbOrlHk6aSyxue84=;
  b=fNB2DyNQZ6a2DAbiYXSeoXh6ftUdt5hLUKDAAuGa6QC8gC2aJoANMZpU
   IjpO4q/LlYFuaaCV+gHsl9zOqAZ4Q//LcLOdapfKJR6uaYUVaWl6qKTCt
   SgbBuTMknhZJSVI2sMJFRuxXVLzFsmV3z3tQCzPhemrLxOAKGC/btj5RN
   RJxPJKGiFUVXJ3LPUzVXTZVnW8wQqbYZ9gODq85F5jxBXDbirz93bzRe5
   OXUfcQYlWs0/kQp83Eg5M/Cte+Rvj+CFx3F1zSYhABqOnIuqsa6l1VDV/
   aznwiUC6nYMZrWsFu9YD+e69MxGCuIS5NEFC78AOIEqyp7iRPKOAqxXh7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="245346352"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="245346352"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 09:56:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="560464945"
Received: from jdtong-mobl.amr.corp.intel.com (HELO intel.com) ([10.255.37.87])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 09:56:20 -0700
Date:   Tue, 22 Mar 2022 12:56:18 -0400
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
Subject: Re: [Intel-gfx] [PATCH v11 4/5] mei: gsc: add runtime pm handlers
Message-ID: <Yjn/si3bGhPtJcyc@intel.com>
References: <20220315131157.3972238-1-alexander.usyskin@intel.com>
 <20220315131157.3972238-5-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315131157.3972238-5-alexander.usyskin@intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:11:56PM +0200, Alexander Usyskin wrote:
> From: Tomas Winkler <tomas.winkler@intel.com>
> 
> Implement runtime handlers for mei-gsc, to track
> idle state of the device properly.
> 
> CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
> V4: drop debug prints
> V5: Rebase
> V6: Rebase
> V7: add Greg KH Reviewed-by
> V8: Rebase
> V9: Rebase
> V11: Rebase
> ---
>  drivers/misc/mei/gsc-me.c | 67 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> index 58e39c00f150..32ea75f5e7aa 100644
> --- a/drivers/misc/mei/gsc-me.c
> +++ b/drivers/misc/mei/gsc-me.c
> @@ -159,7 +159,72 @@ static int __maybe_unused mei_gsc_pm_resume(struct device *device)
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
> +
> +	return -EBUSY;

I see now... this function takes to the autosuspend but returns the EBUSY so
the pci subsystem won't take it. Many other drivers taking this approach.

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

Thank you for all the explanation.

I would prefer if you could move the autosuspend enable and autosuspend delay
to this patch instead of having it on the patch 2. Concerning some strange
behaviour in some bisect...

But that's minor and up to you:

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>



>  
>  static const struct auxiliary_device_id mei_gsc_id_table[] = {
>  	{
> -- 
> 2.32.0
> 
