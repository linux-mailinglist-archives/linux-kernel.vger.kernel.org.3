Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B740489319
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiAJIMR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 03:12:17 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52341 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239741AbiAJIMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:12:06 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id CEEFE60004;
        Mon, 10 Jan 2022 08:11:58 +0000 (UTC)
Date:   Mon, 10 Jan 2022 09:11:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: Re: [PATCH v1 4/5] mtd: core: Drop duplicate NULL checks around
 nvmem_unregister()
Message-ID: <20220110091157.6396569e@xps13>
In-Reply-To: <20220104133843.44272-4-andriy.shevchenko@linux.intel.com>
References: <20220104133843.44272-1-andriy.shevchenko@linux.intel.com>
        <20220104133843.44272-4-andriy.shevchenko@linux.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Tue,  4 Jan 2022 15:38:42
+0200:

> Since nvmem_unregister() checks for NULL, no need to repeat in
> the caller. Drop duplicate NULL checks.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mtd/mtdcore.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 70f492dce158..010ffc34532a 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -742,8 +742,7 @@ int del_mtd_device(struct mtd_info *mtd)
>  		debugfs_remove_recursive(mtd->dbg.dfs_dir);
>  
>  		/* Try to remove the NVMEM provider */
> -		if (mtd->nvmem)
> -			nvmem_unregister(mtd->nvmem);
> +		nvmem_unregister(mtd->nvmem);
>  
>  		device_unregister(&mtd->dev);
>  
> @@ -921,8 +920,7 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
>  	return 0;
>  
>  err:
> -	if (mtd->otp_user_nvmem)
> -		nvmem_unregister(mtd->otp_user_nvmem);
> +	nvmem_unregister(mtd->otp_user_nvmem);
>  	return err;
>  }
>  
> @@ -1026,11 +1024,8 @@ int mtd_device_unregister(struct mtd_info *master)
>  		memset(&master->reboot_notifier, 0, sizeof(master->reboot_notifier));
>  	}
>  
> -	if (master->otp_user_nvmem)
> -		nvmem_unregister(master->otp_user_nvmem);
> -
> -	if (master->otp_factory_nvmem)
> -		nvmem_unregister(master->otp_factory_nvmem);
> +	nvmem_unregister(master->otp_user_nvmem);
> +	nvmem_unregister(master->otp_factory_nvmem);
>  
>  	err = del_mtd_partitions(master);
>  	if (err)


Thanks,
Miquèl
