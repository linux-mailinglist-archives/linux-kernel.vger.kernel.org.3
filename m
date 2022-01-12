Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0242148BED3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiALHH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351119AbiALHHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:07:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE30C06173F;
        Tue, 11 Jan 2022 23:07:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5E3EB81DD1;
        Wed, 12 Jan 2022 07:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074C3C36AEA;
        Wed, 12 Jan 2022 07:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641971264;
        bh=nTFBhQOmnBA93U9cxAz7NAgpiaQ5l5uga4MLGTJJUP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTV7tM6Ua2JmZrTqbyT4xI5YYM+cRjMhRdyMn8X/1edr5hssfJoaLzyBu4uPw+r+o
         1S3rJ/o0rrXPdNOMgECEMomkghn/01pBjAypruajMcnXjjvhLHF5l0DlP3cjA33xhV
         DMdb+mTKLBha0fGYz/ApFpqcTgPTRzKhi7QPDOqQ=
Date:   Wed, 12 Jan 2022 08:07:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     heikki.krogerus@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, singhanc@nvidia.com
Subject: Re: [PATCH v4 1/1] ucsi_ccg: Check DEV_INT bit only when starting
 CCG4
Message-ID: <Yd5+Pd+YHWEB1Px9@kroah.com>
References: <20220112054950.615341-1-waynec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112054950.615341-1-waynec@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 01:49:50PM +0800, Wayne Chang wrote:
> From: Sing-Han Chen <singhanc@nvidia.com>
> 
> after driver sending the UCSI_START cmd, CCGx would
> clear Bit 0:Device Interrupt in the INTR_REG if CCGX
> reset successfully.
> 
> however, there might be a chance that other bits in
> INTR_REG are not cleared due to internal data queued
> in PPM and cause the driver thinks CCGx reset failed.
> 
> the commit checks bit 0 in INTR_REG and ignore other
> bits. ucsi driver would reset PPM later.
> 
> Fixes: 247c554a14aa ("usb: typec: ucsi: add support for Cypress CCGx")
> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index bff96d64dddf..6db7c8ddd51c 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -325,7 +325,7 @@ static int ucsi_ccg_init(struct ucsi_ccg *uc)
>  		if (status < 0)
>  			return status;
>  
> -		if (!data)
> +		if (!(data & DEV_INT))
>  			return 0;
>  
>  		status = ccg_write(uc, CCGX_RAB_INTR_REG, &data, sizeof(data));
> -- 
> 2.25.1
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
