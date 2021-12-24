Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E244347ED6A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbhLXIsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbhLXIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:48:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB490C061401;
        Fri, 24 Dec 2021 00:48:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5ECCAB82244;
        Fri, 24 Dec 2021 08:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EC0C36AE8;
        Fri, 24 Dec 2021 08:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640335690;
        bh=T43leFYqIOyj/mgE0jKDcP5h0L4GBknslRoxNQfS3SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGUrYdtaodfVqaHpJG/bydIESWnGmMu9R9GvtOJo0FB0g+9qGwmy7c7sQx8nZ2LAY
         aPa2G1bD5AdrUeD5uq2U3SgoRIpb8S5iEmzFmhrjMwncocJx2ekwUmMfolnAUPLEQx
         rHPIwWPXplCBjHvanKZUSapEmiPWVaWYAHq0r9sk=
Date:   Fri, 24 Dec 2021 09:48:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     hminas@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc2: host: Check for error map
Message-ID: <YcWJRWpmLAmXrnry@kroah.com>
References: <20211224031842.1564705-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224031842.1564705-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 11:18:42AM +0800, Jiasheng Jiang wrote:
> For the possible failure of the dma_map_single(), it should be better to
> check the return map address by using dma_mapping_error() to guarantee
> the valid of the map address.
> 
> Fixes: 197ba5f406cc ("Move DWC2 driver out of staging")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/usb/dwc2/hcd_ddma.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/hcd_ddma.c b/drivers/usb/dwc2/hcd_ddma.c
> index a858b5f9c1d6..89ed93a67c8a 100644
> --- a/drivers/usb/dwc2/hcd_ddma.c
> +++ b/drivers/usb/dwc2/hcd_ddma.c
> @@ -143,6 +143,7 @@ static void dwc2_desc_list_free(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
>  
>  static int dwc2_frame_list_alloc(struct dwc2_hsotg *hsotg, gfp_t mem_flags)
>  {
> +	dma_addr_t addr;
>  	if (hsotg->frame_list)
>  		return 0;
>  
> @@ -151,9 +152,13 @@ static int dwc2_frame_list_alloc(struct dwc2_hsotg *hsotg, gfp_t mem_flags)
>  	if (!hsotg->frame_list)
>  		return -ENOMEM;
>  
> -	hsotg->frame_list_dma = dma_map_single(hsotg->dev, hsotg->frame_list,
> -					       hsotg->frame_list_sz,
> -					       DMA_TO_DEVICE);
> +	addr = dma_map_single(hsotg->dev, hsotg->frame_list,
> +			      hsotg->frame_list_sz,
> +			      DMA_TO_DEVICE);
> +	if (dma_mapping_error(hsotg->dev, addr))
> +		return -ENOMEM;
> +
> +	hsotg->frame_list_dma = addr;
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 

As I have said before, I am not going to be taking any changes from you
due to them not being correct and the resulting aftermath of them.

Please start out with doing work in the drivers/staging/ portion of the
kernel to learn kernel development better and get more experience before
going out into other areas which can cause problems to more people.

good luck,

greg k-h
