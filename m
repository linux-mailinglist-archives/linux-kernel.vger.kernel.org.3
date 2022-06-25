Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B447055AC3C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiFYT6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 15:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiFYT6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 15:58:47 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8BBA187;
        Sat, 25 Jun 2022 12:58:46 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id B874A10045BFD;
        Sat, 25 Jun 2022 21:58:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 936301191F2; Sat, 25 Jun 2022 21:58:44 +0200 (CEST)
Date:   Sat, 25 Jun 2022 21:58:44 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 2/8] serial: core, 8250: set RS485 termination gpio in
 serial core
Message-ID: <20220625195844.GB2879@wunner.de>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-3-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622154659.8710-3-LinoSanfilippo@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:46:53PM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In serial8250_em485_config() the termination GPIO is set with the uart_port
> spinlock held. This is an issue if setting the GPIO line can sleep (e.g.
> since the concerning GPIO expander is connected via SPI or I2C).
> 
> Fix this by setting the termination line outside of the uart_port spinlock
> in the serial core.
[...]
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1400,6 +1411,7 @@ static int uart_set_rs485_config(struct uart_port *port,
>  	if (ret)
>  		return ret;
>  	uart_sanitize_serial_rs485(port, &rs485);
> +	uart_set_rs485_termination(port, &rs485);
>  
>  	spin_lock_irqsave(&port->lock, flags);
>  	ret = port->rs485_config(port, &rs485);

That's one way to solve the issue.  Another would be to push
acquisition of the port spinlock down into drivers.

I think in most drivers we don't need to take the port spinlock at all
or only for a few specific register accesses.  So taking the lock here
in the midlayer is likely unwarranted.  However, changing that requires
going through every single driver's ->rs485_config() callback and
checking whether it needs the lock or not.  That's painful, but
unavoidable in the long run.  This patch just kicks the can down the road...

Thanks,

Lukas
