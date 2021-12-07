Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8746BDF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhLGOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:44:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43880 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhLGOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:44:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71785B80782;
        Tue,  7 Dec 2021 14:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FF8C341CD;
        Tue,  7 Dec 2021 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638888040;
        bh=GS9SqX/7Ke8trVS8oUm0AXdD09BTgGMzdoPgBeW2sew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeRAFhKd5dLLwksO+k4RmMAael5JbFIaHTqaO5GV+a2Y/afLT6BaNnTlEj83/uldu
         PV/gTlOWOHUO57dxwA035ALnn2LW3aB1RR2bHoHrEFahEz1UmoLtaPvTfTtJRoFDf9
         cupgxGayS7SKF3l/gtCt59sgdqsxKaM5hvhxH92o=
Date:   Tue, 7 Dec 2021 15:40:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, Li Jun <jun.li@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@vivo.com
Subject: Re: [PATCH] usb: core: hcd: fix bug: application of sizeof to pointer
Message-ID: <Ya9yZX3JsuO8OcVJ@kroah.com>
References: <20211207135401.5507-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207135401.5507-1-guozhengkui@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 09:53:47PM +0800, Guo Zhengkui wrote:
> Fix following error:
> ./drivers/usb/core/hcd.c:1284:38-44: ERROR:
> application of sizeof to pointer.

What generated this error?

> 
> Use sizeof(*vaddr) instead.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/usb/core/hcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 4d326ee12c36..996d5273cf60 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1281,7 +1281,7 @@ static int hcd_alloc_coherent(struct usb_bus *bus,
>  		return -EFAULT;
>  	}
>  
> -	vaddr = hcd_buffer_alloc(bus, size + sizeof(vaddr),
> +	vaddr = hcd_buffer_alloc(bus, size + sizeof(*vaddr),

I think you just broke the code.

Look at this closer and see what the function is doing with this buffer
and if you still think your patch is correct, please rewrite the
changelog text to explain why it is so (hint, just using the output of
coccinelle isn't ok.)

thanks,

greg k-h
