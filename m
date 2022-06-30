Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE0561EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiF3PNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiF3PNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:13:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBBCB495;
        Thu, 30 Jun 2022 08:13:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ACF6B82B76;
        Thu, 30 Jun 2022 15:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFD0C34115;
        Thu, 30 Jun 2022 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656602026;
        bh=kpiRVEGAJETnWwHMDlHte1k8MSqX7MbbDM7BGK6dC30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfzg4ksFAK1vBb8Ei301Zm9mV3hohge3fWgpFg/EfXt7Tt+eJsgidHGbdOQqI5dU2
         A/Nng0R7l3I2+tZ/LcjRReye3HEdMKOFVpWWPkzIf+Gzi694DQp91OaZ8Gp9oEGNto
         5H1I7l+fb4RDn7VKhGrCQwWDJuLfogPgGrkg53fg=
Date:   Thu, 30 Jun 2022 17:13:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        geert+renesas@glider.be, peter@hurleysoftware.com,
        sjoerd.simons@collabora.co.uk
Subject: Re: [PATCH 2/2] serial: sh-sci: fix missing uart_unregister_driver()
 in sci_probe_single()
Message-ID: <Yr29pxQPgGs6/0yr@kroah.com>
References: <20220630140919.3857698-1-yangyingliang@huawei.com>
 <20220630140919.3857698-2-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630140919.3857698-2-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:09:19PM +0800, Yang Yingliang wrote:
> Add missing uart_unregister_driver() in error case in sci_probe_single().
> 
> Fixes: 352b92664549 ("serial: sh-sci: Move uart_register_driver call to device probe")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/tty/serial/sh-sci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index ca5a58f01aff..08a249eaaa8c 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3280,7 +3280,7 @@ static int sci_probe_single(struct platform_device *dev,
>  
>  	ret = sci_init_single(dev, sciport, index, p, false);
>  	if (ret)
> -		return ret;
> +		goto err_unregister;
>  
>  	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
>  	if (IS_ERR(sciport->gpios)) {
> @@ -3306,6 +3306,10 @@ static int sci_probe_single(struct platform_device *dev,
>  
>  err_cleanup_single:
>  	sci_cleanup_single(sciport);
> +err_unregister:
> +	mutex_lock(&sci_uart_registration_lock);
> +	uart_unregister_driver(&sci_uart_driver);
> +	mutex_unlock(&sci_uart_registration_lock);

Did you test this?

I think you just broke all other devices attached to this driver.

Please always test your code before submitting it, especially for stuff
like this.

thanks,

greg k-h
