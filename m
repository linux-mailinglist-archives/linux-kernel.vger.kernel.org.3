Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DEE47BA12
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhLUGhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:37:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56034 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhLUGhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:37:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B461613F7;
        Tue, 21 Dec 2021 06:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4065DC36AE7;
        Tue, 21 Dec 2021 06:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640068654;
        bh=4rdD9gOEHmrr3GLbMUJL0o7fGVv3THCBCwujrR9fBk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aH9sZY4Nj6ncsGL+SirVD0m7SqrDfKkNMp5Z9TStuUiQP/H9mRnysfr4zyzWlvo7H
         YSe106NgbSczo2Wa9jL5S3bTWLEYYalff7flK4sB871X19HsvypK9PHSfaP5+mUclc
         86LYHEB3xqULZKQLMAxlQJ6TI7p7cuuQcT2r3bLM=
Date:   Tue, 21 Dec 2021 07:37:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] usb: early: Fix an error code in xdbc_init()
Message-ID: <YcF2LCEHcr1PsPaO@kroah.com>
References: <20211221022036.80706-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221022036.80706-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:20:36AM +0800, Yang Li wrote:
> When xdbc_trace("hardware not used anymore\n") is performed,
> ret should be assigned -ENODEV to indicate this.
> 
> Clean up smatch warning:
> drivers/usb/early/xhci-dbc.c:972 xdbc_init() warn: missing error code
> 'ret'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/usb/early/xhci-dbc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
> index 4502108069cd..fcb05a8948fa 100644
> --- a/drivers/usb/early/xhci-dbc.c
> +++ b/drivers/usb/early/xhci-dbc.c
> @@ -969,6 +969,7 @@ static int __init xdbc_init(void)
>  	if (early_xdbc_console.index == -1 ||
>  	    (early_xdbc_console.flags & CON_BOOT)) {
>  		xdbc_trace("hardware not used anymore\n");
> +		ret = -ENODEV;
>  		goto free_and_quit;
>  	}

How did you test this?

I think you just broke this, the function should be returning 0 here,
like it currently is.  Are you SURE smatch is correct?

I'll only accept this if you can prove it is tested.  Do you have this
hardware?

thanks,

greg k-h
