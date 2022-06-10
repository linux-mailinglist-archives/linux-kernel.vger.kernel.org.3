Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4B546895
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349533AbiFJOm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245285AbiFJOmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:42:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356C73B63AA;
        Fri, 10 Jun 2022 07:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B01D761EF5;
        Fri, 10 Jun 2022 14:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE2CC3411E;
        Fri, 10 Jun 2022 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654872139;
        bh=jtP+0a1lHld3cgp8XQj2RRrIAeEu6gKkVeL+rtkS4cg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+gFdphyvlMHvYWZaH16hqMuJaHqBJJCXHy1ZOsK0BKqk0IxkNw3HWQjFxS2AP/yT
         SLaQHFOXyaE1aWOycj2Ipvujq07jseVjiyKur4gj0kPM97x6kMThIKIiIzJ/dxQekJ
         GbPjd5BBJMQhlheiywOndSN88ln2tqHODDZFKW88=
Date:   Fri, 10 Jun 2022 16:42:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PM / wakeup: Unify device_init_wakeup() for PM_SLEEP and
 !PM_SLEEP
Message-ID: <YqNYSBQWtwVUSJ+d@kroah.com>
References: <20220607035158.308111-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607035158.308111-1-helgaas@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 10:51:58PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously the CONFIG_PM_SLEEP and !CONFIG_PM_SLEEP device_init_wakeup()
> implementations differed in confusing ways:
> 
>   - The PM_SLEEP version checked for a NULL device pointer and returned
>     -EINVAL, while the !PM_SLEEP version did not and would simply
>     dereference a NULL pointer.
> 
>   - When called with "false", the !PM_SLEEP version cleared "capable" and
>     "enable" in the opposite order of the PM_SLEEP version.  That was
>     harmless because for !PM_SLEEP they're simple assignments, but it's
>     unnecessary confusion.
> 
> Use a simplified version of the PM_SLEEP implementation for both cases.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/base/power/wakeup.c | 30 ------------------------------
>  include/linux/pm_wakeup.h   | 31 +++++++++++++++++++++++--------
>  2 files changed, 23 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 11a4ffe91367..e3befa2c1b66 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -500,36 +500,6 @@ void device_set_wakeup_capable(struct device *dev, bool capable)
>  }
>  EXPORT_SYMBOL_GPL(device_set_wakeup_capable);
>  
> -/**
> - * device_init_wakeup - Device wakeup initialization.
> - * @dev: Device to handle.
> - * @enable: Whether or not to enable @dev as a wakeup device.
> - *
> - * By default, most devices should leave wakeup disabled.  The exceptions are
> - * devices that everyone expects to be wakeup sources: keyboards, power buttons,
> - * possibly network interfaces, etc.  Also, devices that don't generate their
> - * own wakeup requests but merely forward requests from one bus to another
> - * (like PCI bridges) should have wakeup enabled by default.
> - */
> -int device_init_wakeup(struct device *dev, bool enable)
> -{
> -	int ret = 0;
> -
> -	if (!dev)
> -		return -EINVAL;
> -
> -	if (enable) {
> -		device_set_wakeup_capable(dev, true);
> -		ret = device_wakeup_enable(dev);
> -	} else {
> -		device_wakeup_disable(dev);
> -		device_set_wakeup_capable(dev, false);
> -	}
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(device_init_wakeup);
> -
>  /**
>   * device_set_wakeup_enable - Enable or disable a device to wake up the system.
>   * @dev: Device to handle.
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 196a157456aa..77f4849e3418 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -109,7 +109,6 @@ extern struct wakeup_source *wakeup_sources_walk_next(struct wakeup_source *ws);
>  extern int device_wakeup_enable(struct device *dev);
>  extern int device_wakeup_disable(struct device *dev);
>  extern void device_set_wakeup_capable(struct device *dev, bool capable);
> -extern int device_init_wakeup(struct device *dev, bool val);
>  extern int device_set_wakeup_enable(struct device *dev, bool enable);
>  extern void __pm_stay_awake(struct wakeup_source *ws);
>  extern void pm_stay_awake(struct device *dev);
> @@ -167,13 +166,6 @@ static inline int device_set_wakeup_enable(struct device *dev, bool enable)
>  	return 0;
>  }
>  
> -static inline int device_init_wakeup(struct device *dev, bool val)
> -{
> -	device_set_wakeup_capable(dev, val);
> -	device_set_wakeup_enable(dev, val);
> -	return 0;
> -}
> -
>  static inline bool device_may_wakeup(struct device *dev)
>  {
>  	return dev->power.can_wakeup && dev->power.should_wakeup;
> @@ -217,4 +209,27 @@ static inline void pm_wakeup_hard_event(struct device *dev)
>  	return pm_wakeup_dev_event(dev, 0, true);
>  }
>  
> +/**
> + * device_init_wakeup - Device wakeup initialization.
> + * @dev: Device to handle.
> + * @enable: Whether or not to enable @dev as a wakeup device.
> + *
> + * By default, most devices should leave wakeup disabled.  The exceptions are
> + * devices that everyone expects to be wakeup sources: keyboards, power buttons,
> + * possibly network interfaces, etc.  Also, devices that don't generate their
> + * own wakeup requests but merely forward requests from one bus to another
> + * (like PCI bridges) should have wakeup enabled by default.
> + */
> +static inline int device_init_wakeup(struct device *dev, bool enable)
> +{
> +	if (enable) {
> +		device_set_wakeup_capable(dev, true);
> +		return device_wakeup_enable(dev);
> +	} else {
> +		device_wakeup_disable(dev);
> +		device_set_wakeup_capable(dev, false);
> +		return 0;
> +	}
> +}
> +

Why are you moving this to be inline?  Why not just drop the "other"
version and stick with the .c version?

thanks,

greg k-h
