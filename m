Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC714CD59A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbiCDN4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiCDN42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:56:28 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3606619D634;
        Fri,  4 Mar 2022 05:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646402141; x=1677938141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c4N+V43B3i0c7JWoTDHNDNh4DYCcViChbXoi/oxgYJ4=;
  b=nOzgqITRsYTt3w3jH6R4vrDtROCF2kN2Q9RZ329aWoWgCxUGPkyE9FpJ
   0bKMjYn5S7aBex4XDPD8gm24Tm4uJCFYISHl/XYMwPY/TtRp+WQ8OgQoG
   O5b+8Ex3mDwyKX4QJECQeZioe8utkAHvxS7bbjPJ2/FaKr/rzGBbaqU5Z
   d78vi5BtDMNxNxJbdZWGkSzfNsM5fqJ5BARrDdhoxVHIAOgg1PSnEV0qn
   mS9EmC3sZ8Y/x+XFOlomzjmmbAmQjSEMgU4s0Ex8EdbOMDIM42NKGbcXj
   QpIHWBjW0HADYY/407JMXkOxFCUm/SkNXVVRQ1sMsi8pzn3nWuWdMwXL8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="314693087"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="314693087"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 05:55:40 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="511854676"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 05:55:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nQ8OR-00BF8a-QX;
        Fri, 04 Mar 2022 15:54:51 +0200
Date:   Fri, 4 Mar 2022 15:54:51 +0200
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
Subject: Re: [PATCH v3 4/6] typec: mux: Allow multiple mux_devs per mux
Message-ID: <YiIaK8kSYGtivvhk@smile.fi.intel.com>
References: <20220303223351.141238-1-bjorn.andersson@linaro.org>
 <20220303223351.141238-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303223351.141238-4-bjorn.andersson@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 02:33:49PM -0800, Bjorn Andersson wrote:
> In the Qualcomm platforms the USB/DP PHY handles muxing and orientation
> switching of the SuperSpeed lines, but the SBU lines needs to be
> connected and switched by external (to the SoC) hardware.
> 
> It's therefor necessary to be able to have the TypeC controller operate
> multiple TypeC muxes and switches. Use the newly introduced indirection
> object to handle this, to avoid having to taint the TypeC controllers
> with knowledge about the downstream hardware configuration.
> 
> The max number of devs per indirection is set to 3, which account for
> being able to mux/switch the USB HS, SS and SBU lines, as per defined
> defined in the usb-c-connector binding. This number could be grown if
> need arrises at a later point in time.

...

> +	for (i = 0; i < count; i++) {
> +		if (IS_ERR(sw_devs[i])) {
> +			err = PTR_ERR(sw_devs[i]);
> +			goto put_sw_devs;
> +		}
> +	}
>  
> -	sw->sw_dev = sw_dev;
> +	for (i = 0; i < count; i++) {
> +		WARN_ON(!try_module_get(sw_devs[i]->dev.parent->driver->owner));
> +		sw->sw_devs[i] = sw_devs[i];
> +	}
> +
> +	sw->num_sw_devs = count;
>  
>  	return sw;
> +
> +put_sw_devs:
> +	for (i = 0; i < count; i++) {

Shouldn't it be

	while (i--)

?

> +		if (!IS_ERR(sw_devs[i]))

We may get rid of this check if we guarantee that the device is NULL.

> +			put_device(&sw_devs[i]->dev);
> +	}
> +
> +	kfree(sw);
> +
> +	return ERR_PTR(err);
>  }

...

> +	for (i = 0; i < count; i++) {
> +		if (IS_ERR(mux_devs[i])) {
> +			err = PTR_ERR(mux_devs[i]);
> +			goto put_mux_devs;
> +		}

Ditto.

> +	}

...

> +put_mux_devs:
> +	for (i = 0; i < count; i++) {
> +		if (!IS_ERR(mux_devs[i]))
> +			put_device(&mux_devs[i]->dev);
> +	}

Ditto.

-- 
With Best Regards,
Andy Shevchenko


