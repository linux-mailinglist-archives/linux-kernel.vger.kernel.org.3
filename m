Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7204755CC49
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245735AbiF1Jvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbiF1Jvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:51:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D98A2AE3F;
        Tue, 28 Jun 2022 02:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B654B81D79;
        Tue, 28 Jun 2022 09:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5884C3411D;
        Tue, 28 Jun 2022 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409900;
        bh=2MJDoSVSUvHYBQTXDGlST2aZE277KT5703sWMj70kjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pws1kpE3r+YJwttZPjszbUdhTl59v0B+/FxkYHEkwFNThrNOZAknMy4RPwk2Vw085
         WfTfoGcl5pK5xqZsh/dr8omX0xXEjsTBYdEXker6SL707CqtbGnUiAu3vOrCKVkDqI
         C9qyRQ+G0KUZEvZqz6WBPlcvtV9qWU3Z0AM1rmQ9ppFNTP6sdCcTEgpICnJqpGi3Rd
         7wXzFjJZdzb9hpxW63tbO0w0JsJtqlzR4Qc2rdmDm2EpsF+c9lwrq+JpwabcfrrUse
         O7DEm59lo29LpDcKhKjPSm+L2nFTdLetyKsrZNbn+IaCaVRKX9QHuyi1f3DC14LpSe
         l8Y7IQCUqNFOQ==
Received: by pali.im (Postfix)
        id C50A77AE; Tue, 28 Jun 2022 11:51:36 +0200 (CEST)
Date:   Tue, 28 Jun 2022 11:51:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Allen Yan <yanwei@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: mvebu: Apply old baudrate to termios
Message-ID: <20220628095136.fhtjjjkj3mre7hwa@pali>
References: <20220628094155.26297-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628094155.26297-1-ilpo.jarvinen@linux.intel.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 June 2022 12:41:55 Ilpo Järvinen wrote:
> A fallback baud rate was derived from old termios but got never applied
> to (new/current) termios. Old termios is dropped once ->set_termios()
> call chain completes, only termios persists the values. Encode also the
> old baud rate into termios.
> 
> Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baudrate")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Hello! Could you explain a bit more what is this patch fixing? I have
not caught it yet. Do you have a test scenario which can demonstrate
this issue? Because I have tested this driver more deeply (on Mox
and Espressobin) and I have not seen any remaining issue with reporting
incorrect baudrate.

> ---
>  drivers/tty/serial/mvebu-uart.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 0429c2a54290..12a79018697f 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -592,10 +592,9 @@ static void mvebu_uart_set_termios(struct uart_port *port,
>  		if (old)
>  			baud = uart_get_baud_rate(port, old, NULL,
>  						  min_baud, max_baud);
> -	} else {
> -		tty_termios_encode_baud_rate(termios, baud, baud);
> -		uart_update_timeout(port, termios->c_cflag, baud);
>  	}
> +	tty_termios_encode_baud_rate(termios, baud, baud);
> +	uart_update_timeout(port, termios->c_cflag, baud);
>  
>  	/* Only the following flag changes are supported */
>  	if (old) {
> 
> -- 
> tg: (f287f971e256..) fix/mvebu-apply-old-baud (depends on: tty-next)
