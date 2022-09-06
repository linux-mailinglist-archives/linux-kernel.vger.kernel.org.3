Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6475ADFFB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbiIFGiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbiIFGiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:38:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24C722286;
        Mon,  5 Sep 2022 23:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94278B8161C;
        Tue,  6 Sep 2022 06:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81FAC433D6;
        Tue,  6 Sep 2022 06:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662446294;
        bh=QsCDlqO4tjSBHwaY1BpaR2HUe1nmWPIOovcOuwER1F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBSs4dEHzflv4FTctNetNLXgdPKv5Hqe+R/BB1M9gAM5+84WiarO4LPC+Ya3Zn9JM
         GwjUeuXMi/iCXJYbX0JLzs6ebCB6XxE+nWEJARGKdcy+dBWfOqGiTXED+cTPQ6gZ7v
         Q8DmXDYsuVmPfRNQuJAdaysTt583Ugr2z7WxUd8s=
Date:   Tue, 6 Sep 2022 08:38:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com
Subject: Re: [PATCH] phy: usb: free the buffer after reading a given nvmem
 cell
Message-ID: <Yxbq0ynfdsKNAySv@kroah.com>
References: <1662445382-29879-1-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662445382-29879-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 02:23:02PM +0800, Vincent Shih wrote:
> Use kfree() to free the buffer after calling nvmem_cell_read() to
> read a given nvmem cell.
> 
> Fixes:99d9ccd97385("phy: usb: Add USB2.0 phy driver for Sunplus SP7021")

This is not a commit in Linus's tree, are you sure it is right?

And the format is not quite correct, you need some spaces in the line.

> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
>  drivers/phy/sunplus/phy-sunplus-usb2.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunplus/phy-sunplus-usb2.c
> index 5269968..c8540e1 100644
> --- a/drivers/phy/sunplus/phy-sunplus-usb2.c
> +++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
> @@ -13,6 +13,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
> @@ -92,13 +93,15 @@ static int update_disc_vol(struct sp_usbphy *usbphy)
>  	otp_v = nvmem_cell_read(cell, &otp_l);
>  	nvmem_cell_put(cell);
>  
> -	if (otp_v) {
> +	if (!IS_ERR(otp_v)) {
>  		set = *(otp_v + 1);
>  		set = (set << (sizeof(char) * 8)) | *otp_v;
>  		set = (set >> usbphy->disc_vol_addr_off) & J_DISC;
> +		
> +		kfree(otp_v);
>  	}
> -
> -	if (!otp_v || set == 0)
> +	
> +	if (IS_ERR(otp_v) || (set == 0))
>  		set = OTP_DISC_LEVEL_DEFAULT;
>  
>  	val = readl(usbphy->phy_regs + CONFIG7);
> @@ -294,3 +297,4 @@ module_platform_driver(sunplus_usb_phy_driver);
>  MODULE_AUTHOR("Vincent Shih <vincent.shih@sunplus.com>");
>  MODULE_DESCRIPTION("Sunplus USB 2.0 phy driver");
>  MODULE_LICENSE("GPL");
> +

Why the extra blank line?

thanks,

greg k-h
