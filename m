Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3945606B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiF2Qvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiF2Qvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:51:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF8F6E;
        Wed, 29 Jun 2022 09:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FBF1B825DB;
        Wed, 29 Jun 2022 16:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E81C34114;
        Wed, 29 Jun 2022 16:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656521501;
        bh=yuwIKZkchTheG5wn1GwB8qN2vRzMhjjoHKv0gTFvEto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ew+1yvS2cQ9ZULkW4Qd3Ti7cr7WW+P60spoYnQEx4nTAK9RBK3ENSpDiXDZYoiB2j
         EvvGthbW34eiwzIBD/KpqdyFO/2Da43fEsizQWUDD+/Gbbefiv2ZOFmLzJ4QcgzaWJ
         MJnLFWRppAuvcoodC7da+6DCaOK0i1KkeAo4c8WE=
Date:   Wed, 29 Jun 2022 18:51:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Berger <opendmb@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2] serial: 8250_bcm7271: Save/restore RTS in
 suspend/resume
Message-ID: <YryDGoIFTdNAzn72@kroah.com>
References: <20220629160208.3167955-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629160208.3167955-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 09:02:08AM -0700, Florian Fainelli wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> Commit 9cabe26e65a8 ("serial: 8250_bcm7271: UART errors after resuming
> from S2") prevented an early enabling of RTS during resume, but it did
> not actively restore the RTS state after resume.
> 
> Fixes: 9cabe26e65a8 ("serial: 8250_bcm7271: UART errors after resuming from S2")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_bcm7271.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
> index 9b878d023dac..b9cea38c8aff 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -1139,16 +1139,19 @@ static int __maybe_unused brcmuart_suspend(struct device *dev)
>  	struct brcmuart_priv *priv = dev_get_drvdata(dev);
>  	struct uart_8250_port *up = serial8250_get_port(priv->line);
>  	struct uart_port *port = &up->port;
> -
> -	serial8250_suspend_port(priv->line);
> -	clk_disable_unprepare(priv->baud_mux_clk);
> +	unsigned long flags;
>  
>  	/*
>  	 * This will prevent resume from enabling RTS before the
> -	 *  baud rate has been resored.
> +	 *  baud rate has been restored.
>  	 */
> +	spin_lock_irqsave(&port->lock, flags);
>  	priv->saved_mctrl = port->mctrl;
> -	port->mctrl = 0;
> +	port->mctrl &= ~TIOCM_RTS;
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	serial8250_suspend_port(priv->line);
> +	clk_disable_unprepare(priv->baud_mux_clk);
>  
>  	return 0;
>  }
> @@ -1158,6 +1161,7 @@ static int __maybe_unused brcmuart_resume(struct device *dev)
>  	struct brcmuart_priv *priv = dev_get_drvdata(dev);
>  	struct uart_8250_port *up = serial8250_get_port(priv->line);
>  	struct uart_port *port = &up->port;
> +	unsigned long flags;
>  	int ret;
>  
>  	ret = clk_prepare_enable(priv->baud_mux_clk);
> @@ -1180,7 +1184,15 @@ static int __maybe_unused brcmuart_resume(struct device *dev)
>  		start_rx_dma(serial8250_get_port(priv->line));
>  	}
>  	serial8250_resume_port(priv->line);
> -	port->mctrl = priv->saved_mctrl;
> +
> +	if (priv->saved_mctrl & TIOCM_RTS) {
> +		/* Restore RTS */
> +		spin_lock_irqsave(&port->lock, flags);
> +		port->mctrl |= TIOCM_RTS;
> +		spin_unlock_irqrestore(&port->lock, flags);
> +		port->ops->set_mctrl(port, port->mctrl);
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
