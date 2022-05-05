Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40651CC2D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386422AbiEEWi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386376AbiEEWiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58C95EDEF;
        Thu,  5 May 2022 15:34:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7216C61F12;
        Thu,  5 May 2022 22:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC566C385AE;
        Thu,  5 May 2022 22:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651790071;
        bh=zOBW++BCHSNvdBCqAZLjyPO411PVn+5DXQzlEUXxqUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oe2LXfu0+UOS6eouin3T47wn4UIuAnaVqTWHSYcRGWnQZoE3s8ANfpvt3DvX/aTij
         o6pgfqI3MS8sUXDQa3uh9pmju9+q74BFqdMhtR+3zVMHNhK1g6AB6L0Ss6ONtIsrzb
         CSsSoaddMBmy1sVomJe6jx+qlR+sf7q/2BWvoWfA=
Date:   Thu, 5 May 2022 22:55:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, michal.simek@xilinx.com,
        jirislaby@kernel.org, git@xilinx.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] serial: uartps: Fix the ignore_status
Message-ID: <YnQ5tqp8ucihwVs9@kroah.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
 <20220429081422.3630070-7-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429081422.3630070-7-shubhrajyoti.datta@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:44:21PM +0530, Shubhrajyoti Datta wrote:
> Currently the ignore_status is not considered in the isr.
> Also the ignore_status is not updated in the set_termios.

When you say "also" that's a huge hint that it should be a separate
patch.

> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 289d70914956..81ba69c57716 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -375,6 +375,8 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
>  		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
>  	}
>  
> +	isrstatus &= port->read_status_mask;
> +	isrstatus &= ~port->ignore_status_mask;
>  	/*
>  	 * Skip RX processing if RX is disabled as RXEMPTY will never be set
>  	 * as read bytes will not be removed from the FIFO.
> @@ -1583,6 +1585,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  	port->dev = &pdev->dev;
>  	port->uartclk = clk_get_rate(cdns_uart_data->uartclk);
>  	port->private_data = cdns_uart_data;
> +	port->read_status_mask = CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_RXTRIG |
> +			CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_TOUT;

You are doing two different things here, please make this two different
patches.

Also, what commit id does this fix?  Does it need to be backported?

thanks,

greg k-h
