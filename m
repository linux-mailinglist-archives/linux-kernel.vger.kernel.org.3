Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE9B55AC7A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiFYUMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiFYUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:12:37 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5177713EB5;
        Sat, 25 Jun 2022 13:12:35 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 46C2330000CCE;
        Sat, 25 Jun 2022 22:12:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 37F854CF4D3; Sat, 25 Jun 2022 22:12:32 +0200 (CEST)
Date:   Sat, 25 Jun 2022 22:12:32 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH 22/36] serial: Sanitize rs485_struct
Message-ID: <20220625201232.GA17597@wunner.de>
References: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
 <20220606100433.13793-23-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220606100433.13793-23-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 01:04:19PM +0300, Ilpo Järvinen wrote:
> -	if (rs485->delay_rts_before_send > RS485_MAX_RTS_DELAY) {
> +	if (!port->rs485_supported->delay_rts_before_send) {
> +		if (rs485->delay_rts_before_send) {
> +			dev_warn_ratelimited(port->dev,
> +				"%s (%d): RTS delay before sending not supported\n",
> +				port->name, port->line);
> +		}
> +		rs485->delay_rts_before_send = 0;
> +	} else if (rs485->delay_rts_before_send > RS485_MAX_RTS_DELAY) {
>  		rs485->delay_rts_before_send = RS485_MAX_RTS_DELAY;
>  		dev_warn_ratelimited(port->dev,
>  			"%s (%d): RTS delay before sending clamped to %u ms\n",
>  			port->name, port->line, rs485->delay_rts_before_send);
>  	}

This series seems to set rs485_supported->delay_rts_before_send to 1
in all drivers to indicate that a delay is supported.

It would probably be smarter to define it as a maximum, i.e. drivers
declare the supported maximum delay in their rs485_supported struct
and the core can use that to clamp the value.  Initially, all drivers
may use RS485_MAX_RTS_DELAY.  Some chips only support specific delays
(multiples of the UART clock or baud clock).  We can amend their
drivers later according to their capabilities.

Thanks,

Lukas
