Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD3547C378
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbhLUQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:06:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41680 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbhLUQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:06:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A768B81780
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F079C36AE9;
        Tue, 21 Dec 2021 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640102786;
        bh=NOYoccZt6FqoUbAIz4mlZs58jm+22mhlBg3szfAUdVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkWya9lfr1Orv0l2lnY7EOpMcmi29VL0g0mKhEg1OxWqPq6k3d8bXFyPaexnBoZYx
         tkGaWYgGw6tMHoYySxMIcAph4FC3c9lHz7ZcoCVwg7GbutDE2wg6zZO+acYyTAg+/R
         eOia6Ce24a2CUw6R+HRyWYV+iQ1b+kmallU1bH5w=
Date:   Tue, 21 Dec 2021 17:06:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register()
 error path
Message-ID: <YcH7fw5S6aSXswvb@kroah.com>
References: <20211221154550.11455-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211221154550.11455-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 04:45:50PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Drop incorrect put_device() calls
> 
> If device_register() fails then underlaying device_add() takes care of
> calling put_device() if needed. There is no need to do that in a driver.

Did you read the documentation for device_register() that says:

 * NOTE: _Never_ directly free @dev after calling this function, even
 * if it returned an error! Always use put_device() to give up the
 * reference initialized in this function instead.

> 2. Use device_unregister()
> 
> Now that we don't call put_device() we can use above helper.
> 
> Fixes: 3360acdf8391 ("nvmem: core: fix leaks on registration errors")
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> That put_device() was explicitly added by Johan but after checking
> device_register() twice I still think it's incorrect. I hope I didn't
> miss sth obvious and I didn't mess it up.
> ---
>  drivers/nvmem/core.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 785a56e33f69..f7f31af7226f 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -901,12 +901,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  
>  	rval = device_register(&nvmem->dev);
>  	if (rval)
> -		goto err_put_device;
> +		return ERR_PTR(rval);

Where do you call put_device() to free the allocated memory?

You just leaked the kzalloc() call to allocate the memory pointed to by
nvmem :(

I think the code is fine as-is.

thanks,

greg k-h
