Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7055C803
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbiF0M2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiF0M2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:28:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8ED64F0;
        Mon, 27 Jun 2022 05:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B84FB81181;
        Mon, 27 Jun 2022 12:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680A1C3411D;
        Mon, 27 Jun 2022 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656332893;
        bh=0sfx/Gz1mK4MTiDmgOMunb4YktvqBJDEAWOW40rHciw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWjfqkKWlIffUuXBnOGUM/oWU01a7KN52IKAW7juplhwMgaloHbAzCiykFoN0A1sl
         Ve6v0C0pxPkADtKrjkj3hXZ+zNl3wIoCQx2oIScBiPh5A13Uvf05om1o1uMJSZbMuw
         +5w/vZXe9qTuMCQwXXPp2cLA3HuZGO6q3N/e3IRA=
Date:   Mon, 27 Jun 2022 14:08:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Yang <yiyang13@huawei.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        andy.shevchenko@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] serial: 8250: fix return error code in
 serial8250_request_std_resource()
Message-ID: <Yrmdy6IJrWMkZfZg@kroah.com>
References: <20220620072025.172088-1-yiyang13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620072025.172088-1-yiyang13@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 03:20:25PM +0800, Yi Yang wrote:
> If port->mapbase = NULL in serial8250_request_std_resource() , it need
> return a error code instead of 0. If uart_set_info() fail to request new
> regions by serial8250_request_std_resource() but the return value of
> serial8250_request_std_resource() is 0, that The system will mistakenly
> considers that port resources are successfully applied for. A null
> pointer reference is triggered when the port resource is later invoked.
> 
> The problem can also be triggered with the following simple program:
> ----------
>   #include <stdio.h>
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <fcntl.h>
>   #include <sys/ioctl.h>
>   #include <unistd.h>
>   #include <errno.h>
> 
>   struct serial_struct {
>       int type;
>       int line;
>       unsigned int    port;
>       int irq;
>       int flags;
>       int xmit_fifo_size;
>       int custom_divisor;
>       int baud_base;
>       unsigned short  close_delay;
>       char    io_type;
>       char    reserved_char[1];
>       int hub6;
>       unsigned short  closing_wait; /* time to wait before closing */
>       unsigned short  closing_wait2; /* no longer used... */
>       unsigned char   *iomem_base;
>       unsigned short  iomem_reg_shift;
>       unsigned int    port_high;
>       unsigned long   iomap_base; /* cookie passed into ioremap */
>   };
> 
>   struct serial_struct str;
> 
>   int main(void)
>   {
>       open("/dev/ttyS0", O_RDWR);
>       ioctl(fd, TIOCGSERIAL, &str);
>       str.iomem_base = 0;
>       ioctl(fd, TIOCSSERIAL, str);
>       return 0;
>   }
> ----------
> 
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 3e3d784aa628..e1cefa97bdeb 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2961,8 +2961,10 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
>  	case UPIO_MEM32BE:
>  	case UPIO_MEM16:
>  	case UPIO_MEM:
> -		if (!port->mapbase)
> +		if (!port->mapbase) {
> +			ret = -EFAULT;

This not a memory fault, that only gets returned for failures when
copying to/from userspace.

Please return -EINVAL or something like that.

thanks,

greg k-h
