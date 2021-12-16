Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42043477735
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbhLPQKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:10:47 -0500
Received: from netrider.rowland.org ([192.131.102.5]:50257 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S239032AbhLPQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:10:46 -0500
Received: (qmail 819215 invoked by uid 1000); 16 Dec 2021 11:10:45 -0500
Date:   Thu, 16 Dec 2021 11:10:45 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci-spear: Remove direct access to platform_device
 resource list
Message-ID: <YbtlBaUqlLtNR+/c@rowland.harvard.edu>
References: <20211215225509.1995417-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215225509.1995417-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 04:55:09PM -0600, Rob Herring wrote:
> The memory resource is already retrieved with platform_get_resource(), so
> let's use it instead of assuming it is the first resource in the array.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ohci-spear.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
> index b4cd9e6c72fd..9b81f420656d 100644
> --- a/drivers/usb/host/ohci-spear.c
> +++ b/drivers/usb/host/ohci-spear.c
> @@ -76,7 +76,7 @@ static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
>  		goto err_put_hcd;
>  	}
>  
> -	hcd->rsrc_start = pdev->resource[0].start;
> +	hcd->rsrc_start = res->start;
>  	hcd->rsrc_len = resource_size(res);
>  
>  	sohci_p = to_spear_ohci(hcd);
> -- 
> 2.32.0
> 
