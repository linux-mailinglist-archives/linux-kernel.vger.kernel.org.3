Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1A64631AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhK3LAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:00:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:4915 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235667AbhK3LAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:00:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="234914651"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="234914651"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 02:56:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="654117650"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 30 Nov 2021 02:56:52 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Nov 2021 12:56:52 +0200
Date:   Tue, 30 Nov 2021 12:56:52 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     steven_syu <steven_syu@asus.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: clear usb_pd flag if change to typec only
 mode
Message-ID: <YaYDdIJbOyAiiFsY@kuha.fi.intel.com>
References: <1638241033-12467-1-git-send-email-steven_syu@asus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638241033-12467-1-git-send-email-steven_syu@asus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:57:13AM +0800, steven_syu wrote:
> This patch handle power mode change from PD to Type-C only
> and the user space unknown power delivery  was turned off
> by typec driver.
> 
> Signed-off-by: steven_syu <steven_syu@asus.com>
> ---
>  drivers/usb/typec/class.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index aeef453..11e2a98 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1718,6 +1718,10 @@ void typec_set_pwr_opmode(struct typec_port *port,
>                         partner->usb_pd = 1;
>                         sysfs_notify(&partner_dev->kobj, NULL,
>                                      "supports_usb_power_delivery");
> +               } else if (opmode != TYPEC_PWR_MODE_PD && partner->usb_pd) {
> +                       partner->usb_pd = 0;
> +                       sysfs_notify(&partner_dev->kobj, NULL,
> +                                    "supports_usb_power_delivery");
>                 }
>                 put_device(partner_dev);
>         }
> --
> 2.7.4
> 
> ===================================================================================================================================
> ???K???T This email and any attachments to it contain confidential information and are intended solely for the use of the individual to whom it is addressed.If you are not the intended recipient or receive it accidentally, please immediately notify the sender by e-mail and delete the message and any attachments from your computer system, and destroy all hard copies. If any, please be advised that any unauthorized disclosure, copying, distribution or any action taken or omitted in reliance on this, is illegal and prohibited. Furthermore, any views or opinions expressed are solely those of the author and do not represent those of ASUSTeK. Thank you for your cooperation.
> ===================================================================================================================================

Please remove that footer from the next mail.

thanks,

-- 
heikki
