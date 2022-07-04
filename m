Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5360565155
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiGDJvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiGDJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:51:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EAA63FE;
        Mon,  4 Jul 2022 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656928296; x=1688464296;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NHDN/2lSyCT1GEduT2MlDHQYpJlzlmnBsu/bQ+QOiwY=;
  b=lmG9yypPkV9Lasrb+xCHrXH0BqKGcHC+tjAdjgmVyd3WUy+UZPOiKxi0
   HDK2hTfwQebWnP3ZHc34U2DWSquqzZzKAjuSJJ1FZJ2O0WLggpCEAJIt7
   9IonfVhbA1piln5ZICEnZ5YJhEYvccjctBQt5fsaGJRUdmzEADp02u9kj
   v2jW+154Wmni5bzfIdFG0LQllOKcv8wjnMqUTx5LpE8d6KR8URzeqEoLl
   2Dj5nbecpHPxXyh3gmkJuVCJhG8WVW+MriN8nLYZxWROSZNPzLVaeHtxZ
   kVlk8Mim8cjmQgw+OTJa74qaopVuZ1Y0bMz50RsabaB31Mi8zm4Nd0nR8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="369413044"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="369413044"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 02:51:36 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="649511538"
Received: from bclindho-mobl.ger.corp.intel.com ([10.252.49.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 02:51:31 -0700
Date:   Mon, 4 Jul 2022 12:51:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v2 2/9] serial: core, 8250: set RS485 termination gpio
 in serial core
In-Reply-To: <20220703170039.2058202-3-LinoSanfilippo@gmx.de>
Message-ID: <355354ef-61ff-692d-aad-3b5721db420@linux.intel.com>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de> <20220703170039.2058202-3-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2022, Lino Sanfilippo wrote:

> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In serial8250_em485_config() the termination GPIO is set with the uart_port
> spinlock held. This is an issue if setting the GPIO line can sleep (e.g.
> since the concerning GPIO expander is connected via SPI or I2C).
> 
> Fix this by setting the termination line outside of the uart_port spinlock
> in the serial core and using gpiod_set_value_cansleep() which instead of
> gpiod_set_value() allows to sleep.
> 
> Beside fixing the termination GPIO line setting for the 8250 driver this
> change also makes setting the termination GPIO generic for all UART
> drivers.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/8250/8250_port.c |  3 ---
>  drivers/tty/serial/serial_core.c    | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index ed2a606f2da7..72252d956f17 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -676,9 +676,6 @@ int serial8250_em485_config(struct uart_port *port, struct ktermios *termios,
>  		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
>  	}
>  
> -	gpiod_set_value(port->rs485_term_gpio,
> -			rs485->flags & SER_RS485_TERMINATE_BUS);
> -

I sent a series to make .rs485_supported per uart_port and properly set 
SER_RS485_TERMINATE_BUS according to DT config. With that series added 
first, SER_RS485_TERMINATE_BUS should also be removed from 
serial8250_em485_supported so that serial core can properly manage 
it all.

-- 
 i.
