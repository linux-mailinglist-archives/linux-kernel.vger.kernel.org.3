Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3973462D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbhK3HCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:02:48 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52696 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbhK3HCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:02:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 53114CE180B;
        Tue, 30 Nov 2021 06:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A67C53FC1;
        Tue, 30 Nov 2021 06:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638255565;
        bh=411v8+NvNRozBhGfgdnICIxrSZQdMGHtyclSkNpfE0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCkG0gKdhLx3j5wm/T4j4A7zOeRBSTL+KVcbP7gPEqrfheP2/H5/ewRrlzKkZAHIb
         sWPPBuFa5FcBbRwJ7mKAILthzTk+VtZtisvygjt7DbXBw6x/TnUsJchOZzrONR6Mzh
         JlLJn95ZvSz4qo3GJrrW4uFoOtJwgg0P0ekuF938=
Date:   Tue, 30 Nov 2021 07:59:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     steven_syu <steven_syu@asus.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: clear usb_pd flag if change to typec only
 mode
Message-ID: <YaXLyHX1Qm3AHFob@kroah.com>
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

I do not understand this sentance, can you please rewrite it a bit?

> Signed-off-by: steven_syu <steven_syu@asus.com>

Please use the name you sign documents with, I doubt you do so with a
"_" in it, right?

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

Are you sure this is correct?  You set usb_pd to 0 and then told
userspace it was 1?

confused,

greg k-h
