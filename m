Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E304CED43
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 19:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiCFSwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 13:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiCFSwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 13:52:46 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A451AD8B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 10:51:53 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9FFE22801BBFA;
        Sun,  6 Mar 2022 19:51:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4D67943B1B0; Sun,  6 Mar 2022 19:51:49 +0100 (CET)
Date:   Sun, 6 Mar 2022 19:51:49 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH 2/7] serial: 8250_dwlib: RS485 HW full duplex support
Message-ID: <20220306185149.GB19394@wunner.de>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302095606.14818-3-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 11:56:01AM +0200, Ilpo Järvinen wrote:
> @@ -110,9 +110,14 @@ static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
>  
>  	if (rs485->flags & SER_RS485_ENABLED) {
>  		/* Clearing unsupported flags. */
> -		rs485->flags &= SER_RS485_ENABLED;
> -
> -		tcr |= DW_UART_TCR_RS485_EN | DW_UART_TCR_XFER_MODE_DE_OR_RE;
> +		rs485->flags &= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX;
> +		tcr |= DW_UART_TCR_RS485_EN;
> +
> +		if (rs485->flags & SER_RS485_RX_DURING_TX) {
> +			tcr |= DW_UART_TCR_XFER_MODE_DE_DURING_RE;
> +		} else {
> +			tcr |= DW_UART_TCR_XFER_MODE_DE_OR_RE;
> +		}

This patch deletes lines introduced by the preceding patch.
I'd just squash the two together, I don't see much value in
introducing full duplex support in a separate patch.

Thanks,

Lukas
