Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC03F48766D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbiAGLZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:25:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58662 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiAGLZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:25:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C55A61491
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D9EC36AE0;
        Fri,  7 Jan 2022 11:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641554728;
        bh=NMdqiP2YC/upM7BO54bfCKqBt+mzx1tNSThOlVG9NWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHlBxW3gO02OmibTp6gW7ppQrTxm7SYzl5OI8tvxjhd1CzMPhq61R30weQ0F2AC95
         26wznfgRog5Wu1jWwjU4E3fsdi0Meg181llDvH5tcdELo4LCIGAF/JqpHIMq0eKY41
         12C2NfpHgl1xN8rcFQ5dmKvjGs6kykxiqWf+hW9M=
Date:   Fri, 7 Jan 2022 12:25:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/19] staging: r8188eu: release_firmware is not called
 if allocation fails
Message-ID: <YdgjJRwLjIBWVQvU@kroah.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
 <20220107103620.15648-4-straube.linux@gmail.com>
 <ca0548c0-b36c-98dc-3e49-b629b3d3fb6a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca0548c0-b36c-98dc-3e49-b629b3d3fb6a@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 02:15:19PM +0300, Pavel Skripkin wrote:
> Hi Michael,
> 
> On 1/7/22 13:36, Michael Straube wrote:
> > In function load_firmware() release_firmware() is not called if the
> > allocation of pFirmware->szFwBuffer fails or if fw->size is greater
> > than FW_8188E_SIZE.
> > 
> > Move the call to release_firmware() to the exit label at the end of
> > the function to fix this.
> > 
> > Signed-off-by: Michael Straube <straube.linux@gmail.com>
> > ---
> >   drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> > index dc41682fd8d6..cfafbb6c42f7 100644
> > --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> > +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> > @@ -538,10 +538,10 @@ static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
> >   	}
> >   	memcpy(pFirmware->szFwBuffer, fw->data, fw->size);
> >   	pFirmware->ulFwLength = fw->size;
> > -	release_firmware(fw);
> >   	dev_dbg(device, "!bUsedWoWLANFw, FmrmwareLen:%d+\n", pFirmware->ulFwLength);
> >   Exit:
> > +	release_firmware(fw);
> >   	return rtStatus;
> >   }
> 
> 
> This patch looks like a bug fix and it should go to stable kernels as well.
> The problem is this patch is made on top of 2 previous clean up patches, so
> it can't go to stable as is.
> 
> I think, the less painful way is to move this patch on the first place in
> this series. On the other hand you can just resend this one separately.
> 
> 
> Or, maybe, Greg knows some magic that will help here, we can wait him before
> you resend 20 patch series :)

It's just not worth it for this staging driver, and for an allocation
failure, to be backported here.  Allocation failures almost never happen
in real-world situations, and if they do, they are not alone, so this
would be the least of the problems happening here.

So no need to care about it, I can take this as-is.

thanks,

greg k-h
