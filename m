Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263A349DE3E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbiA0JlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:41:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37296 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiA0JlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:41:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9960F61BCB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78497C340E4;
        Thu, 27 Jan 2022 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643276479;
        bh=p4uXNmT7t58NwCRHsbijJnTaA9+RdUDdYmuEIzvP+EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFh2oJcjcvFWOkJ5iKzRpgstH9r8uX2jnzQWLapYRuQfEA5Gp3IQ9ZivTUeHK5hU8
         Yo0FKao1C14H1VNsV08D8vpNhjp+vuAqM0LUac91DOAPed9cLBTCW9KhAlvsiNV2x7
         eV0rGB/7VlEp9IHRiIYD43SSVdYswHKXcjgFsUbs=
Date:   Thu, 27 Jan 2022 10:41:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sami =?iso-8859-1?Q?Ky=F6stil=E4?= <skyostil@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dtor@chromium.org,
        evanbenn@chromium.org, arnd@arndb.de
Subject: Re: [PATCH 2/2] drivers/misc: add transfer ioctl for HPS
Message-ID: <YfJovN7clqBZ8NDr@kroah.com>
References: <20220127083545.1020423-1-skyostil@chromium.org>
 <20220127083545.1020423-3-skyostil@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220127083545.1020423-3-skyostil@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 07:35:45PM +1100, Sami Kyöstilä wrote:
> This patch adds an ioctl operation for sending and receiving data from
> the ChromeOS snooping protection sensor (a.k.a., HPS). This allows
> userspace programs to perform a combined read/write I2C transaction
> through a single syscall.
> 
> The I2C wire protocol for the device is documented at:
> 
> https://chromium.googlesource.com/chromiumos/platform/hps-firmware/+/
> refs/heads/main/docs/host_device_i2c_protocol.md
> 
> Signed-off-by: Sami Kyöstilä <skyostil@chromium.org>
> ---
> 
>  MAINTAINERS              |  1 +
>  drivers/misc/hps-i2c.c   | 81 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/hps.h | 20 ++++++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 include/uapi/linux/hps.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9dea4b8c2ab5..d5fc066fdbc2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8803,6 +8803,7 @@ M:	Sami Kyöstilä <skyostil@chromium.org>
>  R:	Evan Benn <evanbenn@chromium.org>
>  S:	Maintained
>  F:	drivers/misc/hps-i2c.c
> +F:	include/uapi/linux/hps.h
>  
>  HSI SUBSYSTEM
>  M:	Sebastian Reichel <sre@kernel.org>
> diff --git a/drivers/misc/hps-i2c.c b/drivers/misc/hps-i2c.c
> index fe9f073b0352..748ead49d678 100644
> --- a/drivers/misc/hps-i2c.c
> +++ b/drivers/misc/hps-i2c.c
> @@ -17,9 +17,11 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> +#include <uapi/linux/hps.h>
>  
>  #define HPS_ACPI_ID		"GOOG0020"
>  #define HPS_MAX_DEVICES		1
> +#define HPS_MAX_MSG_SIZE	8192
>  
>  struct hps_drvdata {
>  	struct i2c_client *client;
> @@ -60,6 +62,8 @@ static int hps_open(struct inode *inode, struct file *file)
>  	ret = pm_runtime_get_sync(dev);
>  	if (ret < 0)
>  		goto pm_get_fail;
> +
> +	file->private_data = hps->client;
>  	return 0;
>  
>  pm_get_fail:
> @@ -84,10 +88,87 @@ static int hps_release(struct inode *inode, struct file *file)
>  	return ret;
>  }
>  
> +static int hps_do_ioctl_transfer(struct i2c_client *client,
> +				 struct hps_transfer_ioctl_data *args)
> +{
> +	int ret;
> +	int nmsg = 0;
> +	struct i2c_msg msgs[2] = {
> +		{
> +			.addr = client->addr,
> +			.flags = client->flags,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = client->flags,
> +		},
> +	};
> +
> +	if (args->isize) {
> +		msgs[nmsg].len = args->isize;
> +		msgs[nmsg].buf = memdup_user(args->ibuf, args->isize);
> +		if (IS_ERR(msgs[nmsg].buf)) {
> +			ret = PTR_ERR(msgs[nmsg].buf);
> +			goto memdup_fail;
> +		}
> +		nmsg++;
> +	}
> +
> +	if (args->osize) {
> +		msgs[nmsg].len = args->osize;
> +		msgs[nmsg].buf = memdup_user(args->obuf, args->osize);
> +		msgs[nmsg].flags |= I2C_M_RD;
> +		if (IS_ERR(msgs[nmsg].buf)) {
> +			ret = PTR_ERR(msgs[nmsg].buf);
> +			goto memdup_fail;
> +		}
> +		nmsg++;
> +	}
> +
> +	ret = i2c_transfer(client->adapter, &msgs[0], nmsg);
> +	if (ret > 0 && args->osize) {
> +		if (copy_to_user(args->obuf, msgs[nmsg - 1].buf, ret))
> +			ret = -EFAULT;
> +	}

Why can't you just do normal i2c transfers to/from userspace instead of
requring a custom ioctl?

thanks,

greg k-h
