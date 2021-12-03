Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113A6467948
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352622AbhLCOVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244958AbhLCOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:21:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76317C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:17:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0405C62B38
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 14:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FD3C53FAD;
        Fri,  3 Dec 2021 14:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638541075;
        bh=uCKSvB3L+Hnnq6ms61JRDbtoxWJzF3D/KNKAllaz/lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYnkrcyeGTOi/Z6kXXy4hyYElWGzWQ00v7cxkk5eE58HGBLyGNAl8vFBIhM7Lxhwm
         Py5baBCS0NyhUmf8/4NpzgD9AmjwWTYaPHlVOXEKYfZrm/TaVOOb2P0u7pvpVGhCGC
         4R84wUbsrWihzbDsCLHTU7Wi5LFiEVJFSNGyDIF4=
Date:   Fri, 3 Dec 2021 15:17:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] uio: uio_dmem_genirq: Catch the Exception
Message-ID: <YaonED6U7CWERHnr@kroah.com>
References: <20211202091839.1489204-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202091839.1489204-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 05:18:39PM +0800, Jiasheng Jiang wrote:
> The return value of dma_set_coherent_mask() is not always 0.
> To catch the exception in case that dma is not support the mask.
> 
> Fixes: 0a0c3b5a24bd ("Add new uio device for dynamic memory allocation")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/uio/uio_dmem_genirq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
> index 6b5cfa5b0673..570f5be64b46 100644
> --- a/drivers/uio/uio_dmem_genirq.c
> +++ b/drivers/uio/uio_dmem_genirq.c
> @@ -188,7 +188,9 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> +	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;

Please print out an error like the other failures above this in the
function.

And why is this a RESEND?  When was it sent before?

thanks,

greg k-h
