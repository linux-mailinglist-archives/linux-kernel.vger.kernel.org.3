Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F3A481C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbhL3M3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbhL3M3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:29:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBFFC061574;
        Thu, 30 Dec 2021 04:29:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E8EE6168D;
        Thu, 30 Dec 2021 12:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A54C36AEA;
        Thu, 30 Dec 2021 12:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640867358;
        bh=3RiH11t6VVvu4zL04o+ytwebu6tBXHYIvfKR8bgCLPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKWLO9C0M7oZ6xbISXwb4i5h5PnGuaCF8XfLQerQ9sc5Kj/HdSP2+/rn0Pfb9aYtq
         csMmj4L19HghZ1EZhuh4lISEUy5wqnjZzyoaKJdi/Dz0K825XFxYTXzWfi164qU/5l
         XEj34/jXVFrOMPVF8G0JuSN4TDMDAUIlNnXVkQjQ=
Date:   Thu, 30 Dec 2021 13:29:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V3 2/6] tty: serial: meson: Request the register region
 in meson_uart_probe()
Message-ID: <Yc2mHOT4WwgUrrhG@kroah.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-3-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230102110.3861-3-yu.tu@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 06:21:06PM +0800, Yu Tu wrote:
> This simplifies resetting the UART controller during probe and will make
> it easier to integrate the common clock code which will require the
> registers at probe time as well.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/tty/serial/meson_uart.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index c9a37602ffd0..99efe62a1507 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -397,24 +397,11 @@ static int meson_uart_verify_port(struct uart_port *port,
>  
>  static void meson_uart_release_port(struct uart_port *port)
>  {
> -	devm_iounmap(port->dev, port->membase);
> -	port->membase = NULL;
> -	devm_release_mem_region(port->dev, port->mapbase, port->mapsize);
> +	/* nothing to do */
>  }

Are you sure a release call like this can be "empty"?  That goes against
the normal way the driver model works.  If it is empty, why have it at
all?

thanks,

greg k-h
