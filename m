Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C73A4CFBEB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbiCGKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242465AbiCGKtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:49:18 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51227A0BF5;
        Mon,  7 Mar 2022 02:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646647747; x=1678183747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8PFTkIqce0rP+0KbEpJbiB9sWz9SBA69Y1zamNvg0f4=;
  b=cw8u9u7f7159WZzX2d1h+tzfnd0vhsDVxpnRlElCpEucD8u10VhfcM9g
   3XLWQvqtQKnKXUl/UnKv0AOSbEoC9TMtueLdASsZvJFewv+pTVdS58erB
   CCzreqxiI3UkBL/2PPI2NMgip79NqzFRPzLffBM2EutS0extYib4ijbjv
   06387ymMKMMMx4SvATc69V15wgtpv9nA5Ln0B113dgG7tnHhSgJ9laV73
   GFKjV/Ab4F4jMpG+aTaSxy1S0WogXw8gPX4LzWeaDLalagmqg3/N0Ek8l
   Ex7Y90MVgvzbdod4rNdKcMdP+1w34qdfLQL9sTcB+IXl4yyU93rGnehsv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="234961906"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="234961906"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:09:06 -0800
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="780273706"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:09:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRAHr-00ChaN-5o;
        Mon, 07 Mar 2022 12:08:19 +0200
Date:   Mon, 7 Mar 2022 12:08:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 3/7] usb: typec: mux: Check dev_set_name() return value
Message-ID: <YiXZkqPQxqQ9I0VH@smile.fi.intel.com>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
 <20220307034040.1111107-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307034040.1111107-3-bjorn.andersson@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 07:40:36PM -0800, Bjorn Andersson wrote:
> It's possible that dev_set_name() returns -ENOMEM, catch and handle this.

Thanks!
Shouldn't we have a Fixes tag and be sent separately for this cycle?

> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v3:
> - New patch
> 
>  drivers/usb/typec/mux.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index c8340de0ed49..d2aaf294b649 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -131,8 +131,11 @@ typec_switch_register(struct device *parent,
>  	sw->dev.class = &typec_mux_class;
>  	sw->dev.type = &typec_switch_dev_type;
>  	sw->dev.driver_data = desc->drvdata;
> -	dev_set_name(&sw->dev, "%s-switch",
> -		     desc->name ? desc->name : dev_name(parent));
> +	ret = dev_set_name(&sw->dev, "%s-switch", desc->name ? desc->name : dev_name(parent));

We may use shorten form of the ternary

	ret = dev_set_name(&sw->dev, "%s-switch", desc->name ?: dev_name(parent));

at the same time, but it's up to you.

Either way code looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> +	if (ret) {
> +		put_device(&sw->dev);
> +		return ERR_PTR(ret);
> +	}
>  
>  	ret = device_add(&sw->dev);
>  	if (ret) {
> @@ -338,8 +341,11 @@ typec_mux_register(struct device *parent, const struct typec_mux_desc *desc)
>  	mux->dev.class = &typec_mux_class;
>  	mux->dev.type = &typec_mux_dev_type;
>  	mux->dev.driver_data = desc->drvdata;
> -	dev_set_name(&mux->dev, "%s-mux",
> -		     desc->name ? desc->name : dev_name(parent));
> +	ret = dev_set_name(&mux->dev, "%s-mux", desc->name ? desc->name : dev_name(parent));

Ditto.

> +	if (ret) {
> +		put_device(&mux->dev);
> +		return ERR_PTR(ret);
> +	}
>  
>  	ret = device_add(&mux->dev);
>  	if (ret) {
> -- 
> 2.33.1
> 

-- 
With Best Regards,
Andy Shevchenko


