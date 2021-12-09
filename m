Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E1E46E666
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhLIKO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:14:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:4342 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232650AbhLIKOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:14:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="225327468"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="225327468"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 02:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="658710954"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 09 Dec 2021 02:11:19 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 09 Dec 2021 12:11:18 +0200
Date:   Thu, 9 Dec 2021 12:11:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Steven Syu <stevensyu7@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: clear usb_pd flag if change to typec only
 mode
Message-ID: <YbHWRgrddFh8IM40@kuha.fi.intel.com>
References: <1638947905-2502-1-git-send-email-steven_syu7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638947905-2502-1-git-send-email-steven_syu7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 08, 2021 at 03:18:25PM +0800, Steven Syu wrote:
> From: Steven Syu <stevensyu7@gmail.com>
> 
> Set usb_pd to 0 when power operation mode
> leaving power delivery. That can avoid user-sepace
> read "yes" form the supports_usb_power_delivery_show() attribute
> but power operation mode already change form power delivery to
> others mode.

I think you need to add a short explanation about the situation where
this can happen - where we loose the USB PD contract.

> Signed-off-by: Steven Syu <stevensyu7@gmail.com>
> ---
> changes for v3:
> resubmit and add the changes comment of v1->v2
> 
> v1->v2:
> 1.remove sysfs_notify(&partner_dev->kobj, NULL, "supports_usb_power_delivery"); when operation mode is not PD.
> 2.resubmitted patch by private email for remove footbar in the mail.
> 
>  drivers/usb/typec/class.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index aeef453..2043e07 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1718,6 +1718,8 @@ void typec_set_pwr_opmode(struct typec_port *port,
>  			partner->usb_pd = 1;
>  			sysfs_notify(&partner_dev->kobj, NULL,
>  				     "supports_usb_power_delivery");
> +		} else if (opmode != TYPEC_PWR_MODE_PD && partner->usb_pd) {
> +			partner->usb_pd = 0;
>  		}
>  		put_device(partner_dev);
>  	}
> -- 
> 2.7.4

thanks,

-- 
heikki
