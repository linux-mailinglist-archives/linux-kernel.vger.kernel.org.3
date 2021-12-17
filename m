Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA8C479204
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbhLQQzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhLQQy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:54:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B990C061574;
        Fri, 17 Dec 2021 08:54:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC2CF62305;
        Fri, 17 Dec 2021 16:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89721C36AE7;
        Fri, 17 Dec 2021 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639760098;
        bh=35R/DOnfqARo0hvx3JTyLxO4xZ9BgeHF7T8etQNvDHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWMpmgB68DIatvPYkqYjULgyZgpZm/WMp4eE8rqINzZ9/bAyqsTC1Jl9h7QmBDiEk
         Bx5OBzIg5HSwgc9C4DkLm/LrO2pg18GadbSWqiO8QSR5tfTr6PfiY9NXHhXoqBgT2T
         grrlMhwcyRuarrxfW0fDVXPEpigZiFUYtU2L3ZBg=
Date:   Fri, 17 Dec 2021 17:54:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 1/1] serial: 8520_mtk: Prepare for
 platform_get_irq_optional() changes
Message-ID: <YbzA3y5jp5K5zL/+@kroah.com>
References: <20211217151034.62046-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217151034.62046-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 05:10:34PM +0200, Andy Shevchenko wrote:
> The platform_get_irq_optional() is going to be changed in a way
> that the result of it:
>    = 0 means no IRQ is provided
>    < 0 means the error which needs to be propagated to the upper layers
>    > 0 valid vIRQ is allocated

What about 0 being a valid irq?

> In this case, drop check for 0. Note, the 0 is not valid vIRQ and
> platform_get_irq_optional() issues a big WARN() in such case,

But it still is a valid irq, so why did you just break things?  Yes, a
warning will happen, but the driver and platform will still work.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index fb65dc601b23..8d3e16d7bf63 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -641,7 +641,7 @@ static int __maybe_unused mtk8250_resume(struct device *dev)
>  	struct mtk8250_data *data = dev_get_drvdata(dev);
>  	int irq = data->rx_wakeup_irq;
>  
> -	if (irq >= 0)
> +	if (irq > 0)
>  		disable_irq_wake(irq);

Why change this now?  What does this solve at this point in time?

thanks,

greg k-h
