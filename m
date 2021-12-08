Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC546CD44
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbhLHFsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:48:41 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36138 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbhLHFsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:48:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 01C47CE1FE7;
        Wed,  8 Dec 2021 05:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029C7C00446;
        Wed,  8 Dec 2021 05:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638942305;
        bh=z3jrqMaA7Ll8zNGj+CAEiv+2JfaV3Q780Qlq87qhtys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRExbGqR1C7x0NVnB4255G25OiR9paoWQRc/CbnDT+nDNY1QAH938iMYvmEHh7Uup
         Qd1OnyCrG7Ak3igrLz/Xi+pL6MScHCeLBXL9gpg8E+xskaglvnLYivS7NDlhTfImiY
         XaehQogPOXGPFFh9Prfzfk/395hAJNgnLmpyDnSM=
Date:   Wed, 8 Dec 2021 06:44:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: return appropriate error on failure
Message-ID: <YbBGWH0lPs3NBLQr@kroah.com>
References: <20211207221741.50422-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207221741.50422-1-makvihas@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 03:47:41AM +0530, Vihas Mak wrote:
> when a user with CAP_SYS_ADMIN disabled calls ioctl (TIOCSSERIAL),
> uart_set_info() returns 0 instead of -EPERM and the user remains unware
> about what went wrong. Fix this.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215205
> 
> Signed-off-by: Vihas Mak <makvihas@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 61e3dd022..c204bdecc 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -960,7 +960,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>  		uport->fifosize = new_info->xmit_fifo_size;
>  
>   check_and_exit:
> -	retval = 0;
> +	retval = retval < 0 ? retval : 0;

Please no, do not use ? : unless you have to.  Spell it out and use a
real if statement.

thanks,

greg k-h
