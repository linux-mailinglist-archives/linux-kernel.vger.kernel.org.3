Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ED5561EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbiF3POG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiF3POD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:14:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD3831DD7;
        Thu, 30 Jun 2022 08:14:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C72861004;
        Thu, 30 Jun 2022 15:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0BEC34115;
        Thu, 30 Jun 2022 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656602041;
        bh=ikhr1JUFQR9QZpOqDxt7kL713tH3M1EotJAj2y6sij4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K21sZN5FR3KhP4UKW1cCBE7qiMoEVMYpND66mDqd155qb4tmRzc2Osdu0K/0wDUA3
         L3nKugzmVlj44K7Qda4zxfi+sqg7H/Iu/jP4Jvc706KDSNvFfxhVimjAtPZAbmt59T
         XgGMQo7texx1/rPL40YXfbbOBFI3Xi3fh2I2Yxj0=
Date:   Thu, 30 Jun 2022 17:13:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        geert+renesas@glider.be, peter@hurleysoftware.com,
        sjoerd.simons@collabora.co.uk
Subject: Re: [PATCH 1/2] serial: sh-sci: fix missing sci_cleanup_single() in
 sci_probe_single()
Message-ID: <Yr29tlTOTrBfJPBP@kroah.com>
References: <20220630140919.3857698-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630140919.3857698-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:09:18PM +0800, Yang Yingliang wrote:
> Add missing sci_cleanup_single() in error case in sci_probe_single()
> 
> Fixes: f907c9ea8835 ("serial: sh-sci: Add support for GPIO-controlled modem lines")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/tty/serial/sh-sci.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 0075a1420005..ca5a58f01aff 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3283,25 +3283,31 @@ static int sci_probe_single(struct platform_device *dev,
>  		return ret;
>  
>  	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
> -	if (IS_ERR(sciport->gpios))
> -		return PTR_ERR(sciport->gpios);
> +	if (IS_ERR(sciport->gpios)) {
> +		ret = PTR_ERR(sciport->gpios);
> +		goto err_cleanup_single;
> +	}
>  
>  	if (sciport->has_rtscts) {
>  		if (mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_CTS) ||
>  		    mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_RTS)) {
>  			dev_err(&dev->dev, "Conflicting RTS/CTS config\n");
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err_cleanup_single;
>  		}
>  		sciport->port.flags |= UPF_HARD_FLOW;
>  	}
>  
>  	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
> -	if (ret) {
> -		sci_cleanup_single(sciport);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_cleanup_single;
>  
>  	return 0;
> +
> +err_cleanup_single:
> +	sci_cleanup_single(sciport);
> +
> +	return ret;
>  }
>  
>  static int sci_probe(struct platform_device *dev)
> -- 
> 2.25.1
> 

How was this tested?

thanks,

greg k-h
