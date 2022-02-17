Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F054B9F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbiBQLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:47:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239930AbiBQLrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:47:48 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CE7282E56;
        Thu, 17 Feb 2022 03:47:34 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 79C5F10045C15;
        Thu, 17 Feb 2022 12:47:32 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4D9AE2E9DD4; Thu, 17 Feb 2022 12:47:32 +0100 (CET)
Date:   Thu, 17 Feb 2022 12:47:32 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de, linux@armlinux.org.uk,
        richard.genoud@gmail.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2 4/9] serial: sc16is7xx: remove redundant check in
 rs485_config
Message-ID: <20220217114732.GB7826@wunner.de>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
 <20220216001803.637-5-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216001803.637-5-LinoSanfilippo@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:17:58AM +0100, Lino Sanfilippo wrote:
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -959,16 +959,6 @@ static int sc16is7xx_config_rs485(struct uart_port *port,
>  	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
>  
>  	if (rs485->flags & SER_RS485_ENABLED) {
> -		bool rts_during_rx, rts_during_tx;
> -
> -		rts_during_rx = rs485->flags & SER_RS485_RTS_AFTER_SEND;
> -		rts_during_tx = rs485->flags & SER_RS485_RTS_ON_SEND;
> -
> -		if (rts_during_rx == rts_during_tx)
> -			dev_err(port->dev,
> -				"unsupported RTS signalling on_send:%d after_send:%d - exactly one of RS485 RTS flags should be set\n",
> -				rts_during_tx, rts_during_rx);
> -

Hm, patch 1 in this series doesn't emit such a message, so unlike now,
users will no longer be warned that they passed in nonsensical settings...
