Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884E35A4233
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiH2FZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2FZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:25:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48AE10FF4;
        Sun, 28 Aug 2022 22:25:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B6FD60FDE;
        Mon, 29 Aug 2022 05:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5DDC433C1;
        Mon, 29 Aug 2022 05:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661750741;
        bh=wtS0E8DuXrMBFmQOWy3AskYn5cwEnLqnh+xleQGqxe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJQhF4UFGCsGpEL0zpAhzbcloCKKOO1aHQmXhvi+WlQUZN8G8DCNckT77eIfGomMi
         Bo+yiSgfjWfq4Cr4DNd6Tu2v7QBuGED9bVl/1k6ZaNiB1Ghq4CzqF30sJtmfhsS+6Z
         pBuRcv//fLo/Jv/RwXK6qQB+MfpG6pjdSmqXpi+Y=
Date:   Mon, 29 Aug 2022 07:25:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
Subject: Re: [PATCH v3] drivers/tty/serial: check the return value of
 uart_port_check()
Message-ID: <YwxN49VVBcq1FOJn@kroah.com>
References: <20220828201159.1945416-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828201159.1945416-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 01:11:59PM -0700, Li Zhong wrote:
> uart_port_check() will return NULL pointer when state->uart_port is
> NULL. Check the return value before dereference it to avoid
> null-pointer-dereference error. Here we do not need unlock in the error
> handling because the mutex_unlock() is called in callers.
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 12c87cd201a7..760e177166cf 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -194,6 +194,9 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>  	unsigned long page;
>  	int retval = 0;
>  
> +	if (!uport)
> +		return -EIO;
> +
>  	if (uport->type == PORT_UNKNOWN)
>  		return 1;
>  
> @@ -498,6 +501,8 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
>  	struct ktermios *termios;
>  	int hw_stopped;
>  
> +	if (!uport)
> +		return;
>  	/*
>  	 * If we have no tty, termios, or the port does not exist,
>  	 * then we can't set the parameters for this port.
> @@ -1045,6 +1050,8 @@ static int uart_get_lsr_info(struct tty_struct *tty,
>  	struct uart_port *uport = uart_port_check(state);
>  	unsigned int result;
>  
> +	if (!uport)
> +		return -EIO;
>  	result = uport->ops->tx_empty(uport);
>  
>  	/*
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
