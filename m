Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043CC47AFF6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbhLTPXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbhLTPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:22:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE01C08C5D9;
        Mon, 20 Dec 2021 07:02:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BC8FB80ED3;
        Mon, 20 Dec 2021 15:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B805C36AE8;
        Mon, 20 Dec 2021 15:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640012547;
        bh=U7/RAfWf0ohq7ORVC8vlxJx5oX8ogjWmNdFAhAij1a8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jb6EtDnKl0D7MlYBdIl1SwNI3F0D5bA4co4UKnqdArAQnI9nygtrkovHKCgnD9EkD
         hlxfywsll1k7vD4hSdS655BaeVg8+Aook5YySHWS6TVl4/KNtGsedcwTDBVSMTwyJO
         BS4RjVO63gIeVSefC4q0+b6I1nsecer6Mi08pJO8=
Date:   Mon, 20 Dec 2021 15:45:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     ok@artecdesign.ee, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: host: Check for null res pointer
Message-ID: <YcCXB0QMkkFYXMIY@kroah.com>
References: <20211220064946.817004-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220064946.817004-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 02:49:46PM +0800, Jiasheng Jiang wrote:
> The return value of platform_get_resource() needs to be checked.
> To avoid use of error pointer in case of the failure of alloc.
> 
> Fixes: 4808a1c02611 ("[PATCH] USB: Add isp116x-hcd USB host controller driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/usb/host/isp116x-hcd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/host/isp116x-hcd.c b/drivers/usb/host/isp116x-hcd.c
> index 8835f6bd528e..addd2b43a14c 100644
> --- a/drivers/usb/host/isp116x-hcd.c
> +++ b/drivers/usb/host/isp116x-hcd.c
> @@ -1541,9 +1541,15 @@ static int isp116x_remove(struct platform_device *pdev)
>  
>  	iounmap(isp116x->data_reg);
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res)
> +		return -EINVAL;

You really can not fail a remove call.  If you do so here, memory will
leak.

Please make this work no matter what.

thanks,

greg k-h
