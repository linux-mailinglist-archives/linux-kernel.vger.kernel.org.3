Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6B4AB820
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347123AbiBGJtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351851AbiBGJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:36:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411CDC043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:36:22 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nH0RX-0001Oq-5l; Mon, 07 Feb 2022 10:36:19 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nH0RW-0005jj-2h; Mon, 07 Feb 2022 10:36:18 +0100
Date:   Mon, 7 Feb 2022 10:36:18 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] misc: alcor_pci: Fix an error handling path
Message-ID: <20220207093618.GA18325@pengutronix.de>
References: <918a9875b7f67b7f8f123c4446452603422e8c5e.1644136776.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <918a9875b7f67b7f8f123c4446452603422e8c5e.1644136776.git.christophe.jaillet@wanadoo.fr>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:33:44 up 58 days, 18:19, 81 users,  load average: 0.17, 0.22,
 0.38
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 09:39:54AM +0100, Christophe JAILLET wrote:
> A successful ida_simple_get() should be balanced by a corresponding
> ida_simple_remove().
> 
> Add the missing call in the error handling path of the probe.
> 
> While at it, switch to ida_alloc()/ida_free() instead to
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> Fixes: 4f556bc04e3c ("misc: cardreader: add new Alcor Micro Cardreader PCI driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

> ---
>  drivers/misc/cardreader/alcor_pci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
> index de6d44a158bb..3f514d77a843 100644
> --- a/drivers/misc/cardreader/alcor_pci.c
> +++ b/drivers/misc/cardreader/alcor_pci.c
> @@ -266,7 +266,7 @@ static int alcor_pci_probe(struct pci_dev *pdev,
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	ret = ida_simple_get(&alcor_pci_idr, 0, 0, GFP_KERNEL);
> +	ret = ida_alloc(&alcor_pci_idr, GFP_KERNEL);
>  	if (ret < 0)
>  		return ret;
>  	priv->id = ret;
> @@ -280,7 +280,8 @@ static int alcor_pci_probe(struct pci_dev *pdev,
>  	ret = pci_request_regions(pdev, DRV_NAME_ALCOR_PCI);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Cannot request region\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto error_free_ida;
>  	}
>  
>  	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
> @@ -324,6 +325,8 @@ static int alcor_pci_probe(struct pci_dev *pdev,
>  
>  error_release_regions:
>  	pci_release_regions(pdev);
> +error_free_ida:
> +	ida_free(&alcor_pci_idr, priv->id);
>  	return ret;
>  }
>  
> @@ -337,7 +340,7 @@ static void alcor_pci_remove(struct pci_dev *pdev)
>  
>  	mfd_remove_devices(&pdev->dev);
>  
> -	ida_simple_remove(&alcor_pci_idr, priv->id);
> +	ida_free(&alcor_pci_idr, priv->id);
>  
>  	pci_release_regions(pdev);
>  	pci_set_drvdata(pdev, NULL);
> -- 
> 2.32.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
