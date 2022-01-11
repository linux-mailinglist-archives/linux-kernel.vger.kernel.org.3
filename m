Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E007848AA3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349206AbiAKJMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:12:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45108 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349178AbiAKJMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:12:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59A466156E;
        Tue, 11 Jan 2022 09:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7B1C36AE3;
        Tue, 11 Jan 2022 09:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641892361;
        bh=4hj/uIFmhoUyvcfUx7eYWheV50HgF3Q8mYjBsGb8DM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uuF908DiXPFNdUN7s2Pqten8kAlIj+hyhImGW+9K7sT3d2eIak3X2PBaGy3S/hu3r
         qPh7c+a9rdhwK3U1boBi2Pwjf6vEgk2FEK4l9QEJeYpyzg8hOoVpO+PvTUFBmHIqbs
         x/GFHwKxAHmlGC/5tj/C2yuzxbRA/muyB2ako3SA=
Date:   Tue, 11 Jan 2022 10:12:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     peter.chen@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: remove not used variables
Message-ID: <Yd1KBiRB/ByZ2Kx1@kroah.com>
References: <20220111085934.44844-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111085934.44844-1-pawell@gli-login.cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 09:59:34AM +0100, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> Patch removes not used variables:
>  - ret from cdnsp_decode_trb function
>  - temp_64 from cdnsp_run function
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/cdnsp-debug.h  | 287 +++++++++++++++----------------
>  drivers/usb/cdns3/cdnsp-gadget.c |   3 -
>  2 files changed, 138 insertions(+), 152 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
> index a8776df2d4e0..29f3cf7ddbaa 100644
> --- a/drivers/usb/cdns3/cdnsp-debug.h
> +++ b/drivers/usb/cdns3/cdnsp-debug.h
> @@ -182,206 +182,195 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
>  	int ep_id = TRB_TO_EP_INDEX(field3) - 1;
>  	int type = TRB_FIELD_TO_TYPE(field3);
>  	unsigned int ep_num;
> -	int ret = 0;

Please fix this function to properly handle the ret value, as I think it
should be checked, right?

> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -1243,12 +1243,9 @@ static int cdnsp_run(struct cdnsp_device *pdev,
>  		     enum usb_device_speed speed)
>  {
>  	u32 fs_speed = 0;
> -	u64 temp_64;
>  	u32 temp;
>  	int ret;
>  
> -	temp_64 = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
> -	temp_64 &= ~ERST_PTR_MASK;
>  	temp = readl(&pdev->ir_set->irq_control);
>  	temp &= ~IMOD_INTERVAL_MASK;
>  	temp |= ((IMOD_DEFAULT_INTERVAL / 250) & IMOD_INTERVAL_MASK);
> -- 
> 2.25.1
> 

A separate patch for this.

Also, are you SURE this is ok to do?  Did you check it on the hardware
that a read is not needed here for it to work properly?

This type of "warning" is horrible for dealing with hardware devices,
always treat it as incorrect unless you can prove otherwise.

thanks,

greg k-h
