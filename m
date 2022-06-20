Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0625511E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiFTHxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiFTHxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:53:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B89E0E4;
        Mon, 20 Jun 2022 00:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655711616; x=1687247616;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WmXXD82WDY2lb/RJx0DI6EQgl775Y4vH/1ER9y50VeE=;
  b=nT1yFDOCm+cxlwf2xpdLn8DKzuPesCGcgbkEZc17ZxIzzUiooxndibJY
   641u2VR2Qb/x8D6ff1SCnbAj2J2UP0xbqy+pi9OJ5TJ81EUtkYO50v8nX
   oDMex+mnfZF4N84T+A/yKJ4uqsoGGxQR7FSA6Ki/vp3LdTUZ07XQRprPS
   +xaZpv5ha2sv9Ge3x4qZyqKp6iJtqMA0SHq9OaOT+7phXilUBwOmVqbwy
   Q50gsIQ2hNImt5lLfoKKl+4CAXyuTiDmULTqS5omtuqLJEYwxt3VLb8IJ
   L6pXq2VSmrNUQXQxLuri4YKx8eL1Ab7qRY7Q0XEtquhs3fJGXyO9MBOuk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262866792"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262866792"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 00:53:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="591060446"
Received: from lspinell-mobl1.ger.corp.intel.com ([10.251.215.169])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 00:53:26 -0700
Date:   Mon, 20 Jun 2022 10:53:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Yi Yang <yiyang13@huawei.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, andy.shevchenko@gmail.com,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] serial: 8250: fix return error code in
 serial8250_request_std_resource()
In-Reply-To: <20220620072025.172088-1-yiyang13@huawei.com>
Message-ID: <fe25cbe3-3cc3-45c3-d6d0-e867ee372b7@linux.intel.com>
References: <20220620072025.172088-1-yiyang13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022, Yi Yang wrote:

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

With admin priviledges I guess?

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
>  			break;
> +		}
>  
>  		if (!request_mem_region(port->mapbase, size, "serial")) {
>  			ret = -EBUSY;
> 

I recall reading somewhere that somebody more knowledgeful than me noted 
that this interface has many ways to shoot oneself in the foot if one 
really wants to which is why some things are limited to admin only.
I cannot seem to find that a reference to that now though.


-- 
 i.

