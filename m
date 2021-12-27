Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B247FA85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 07:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhL0G3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 01:29:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36708 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbhL0G3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 01:29:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4AA5B80E52;
        Mon, 27 Dec 2021 06:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F29C36AEA;
        Mon, 27 Dec 2021 06:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640586552;
        bh=nfs9cY8hI68fJLHPs5Fa7P0ypNV+LDUhpthBrDIFF8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABAPlhryXS4apdou9GUXwJ8i5FQcKWPhWFsKp7W0eJWH4AMZRiTk0eGETSG0DstwF
         84NvaMBh07x3inS0s2BeTyjeaglKmONOOBYVNDTjwo5M006tzcriXVb+OkSmba8D9/
         dbk303EYzmi5XnWPJJQaYoe70dl6LR7fAjpV0GNQ=
Date:   Mon, 27 Dec 2021 07:29:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, andrew@aj.id.au, linux-fsi@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fsi: Aspeed: Fix a potential double free
Message-ID: <YcldM9sgYdjMYMtH@kroah.com>
References: <2cafa0607ca171ebd00ac6c7e073b46808e24f00.1640537669.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cafa0607ca171ebd00ac6c7e073b46808e24f00.1640537669.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 05:56:02PM +0100, Christophe JAILLET wrote:
> 'aspeed' is a devm_alloc'ed, so there is no need to free it explicitly or
> there will be a double free().

A struct device can never be devm_alloced for obvious reasons.  Perhaps
that is the real problem here?

> Remove the 'release' function that is wrong and unneeded.
> 
> Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is completely theoretical. It looks good to me, but there is a
> little too much indirections for me. I'm also not that familiar with
> fixing issue related to 'release' function...
> 
> ... So review with care :)
> ---
>  drivers/fsi/fsi-master-aspeed.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index 8606e55c1721..4a745ccb60cf 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -373,14 +373,6 @@ static int aspeed_master_break(struct fsi_master *master, int link)
>  	return aspeed_master_write(master, link, 0, addr, &cmd, 4);
>  }
>  
> -static void aspeed_master_release(struct device *dev)
> -{
> -	struct fsi_master_aspeed *aspeed =
> -		to_fsi_master_aspeed(dev_to_fsi_master(dev));
> -
> -	kfree(aspeed);
> -}
> -
>  /* mmode encoders */
>  static inline u32 fsi_mmode_crs0(u32 x)
>  {
> @@ -603,7 +595,6 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev, "hub version %08x (%d links)\n", reg, links);
>  
>  	aspeed->master.dev.parent = &pdev->dev;
> -	aspeed->master.dev.release = aspeed_master_release;

Odd, then what deletes this device structure when the release function
wants to be called?  You should have gotten a big warning from the
kernel when removing the device from the system at runtime, did you test
this somehow?

This does not look correct at all.

greg k-h
