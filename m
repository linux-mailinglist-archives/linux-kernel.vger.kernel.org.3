Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45CB4865D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbiAFOMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbiAFOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:12:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADB0C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 06:12:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FAAD61B04
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 14:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D22C36AE0;
        Thu,  6 Jan 2022 14:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641478358;
        bh=S/619fxc8rw0lpO5vyMU+8P9KRO/68r1eyUO9y6srEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPpxy+IdDvDtUAUERUUgduAyBlIm09+80Rj0g1kfg3ODhZHP44zFbBiItcG+CDaXw
         +i+P8ige8rbQ4mlUnvRfEYS7jnWObchSJ2Yht6wsIio0ZX0whgPyZWHL2JBsXPKNEP
         por6NNWWmaDOuM9hL3KFSlf3RiLI9ayCYDctKIHM=
Date:   Thu, 6 Jan 2022 15:12:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/56] staging: r8188eu: add parenthesis to macro SetToDs
Message-ID: <Ydb40xesTGFftdol@kroah.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
 <20220103190326.363960-2-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103190326.363960-2-alb3rt0.m3rciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 08:01:36PM +0100, Alberto Merciai wrote:
> Enclose in parenthesis complex macro SetToDs

Why?

You are saying what you are doing (which is easy to see by looking at
the patch itself), but not _why_ you are doing this.  Please read the
documentation in the kernel source tree for how to write a good kernel
commit message.  It is in the section entitled "The canonical patch
format" in the kernel file, Documentation/SubmittingPatches.

> Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
> ---
>  drivers/staging/r8188eu/include/wifi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
> index 7cbc7015e90f..f16e9f44babe 100644
> --- a/drivers/staging/r8188eu/include/wifi.h
> +++ b/drivers/staging/r8188eu/include/wifi.h
> @@ -164,7 +164,7 @@ enum WIFI_REG_DOMAIN {
>  #define _ORDER_		BIT(15)
>  
>  #define SetToDs(pbuf)	\
> -	*(__le16 *)(pbuf) |= cpu_to_le16(_TO_DS_)
> +	(*(__le16 *)(pbuf) |= cpu_to_le16(_TO_DS_))

The cast here should not be happening as odds are it hides other endian
issues.

Also the name is horrid, but really, the lack of () is is fine as-is as
it is used as a "function call" in the driver.  Wrapping it in () does
nothing to it at all from what I can tell so this change isn't even
helping :(

Why not fix this up properly by replacing the places where it is called
with the code here instead?

For example, these lines:
	else if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
		SetToDs(fctrl);
would be:
	else if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
		fctrl |= cpu_to_le16(_TO_DS_);

Isn't that now much more readable and easier to understand what is
happening here?

Then there's the crazyness of a bit field being called "_TO_DS_", but
that can be cleaned up later...

I hate to reject patch 1 of a 50+ patch series, but next time try
sending smaller series so that you don't have to redo a bunch of work
like now has to happen here (the same comments apply to your other ()
patches in this series.)

thanks,

greg k-h
