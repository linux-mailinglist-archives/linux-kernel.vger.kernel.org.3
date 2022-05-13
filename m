Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD9A525BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377625AbiEMHCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiEMHCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:02:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD0AC5DB7;
        Fri, 13 May 2022 00:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57F3BB82C44;
        Fri, 13 May 2022 07:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1224CC34100;
        Fri, 13 May 2022 07:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652425323;
        bh=ed9Xjuop8xat3sEczfPwLseBiQGfIJDlKSpeWiAG6qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhukNom9BDICDhiz82Y1+ftRhJifpPl4/imUbDRdRXDMg9EPAOph5egRjNy71CJ/S
         j/eN9n4Iso2qEt1ywb2xcLWU1nrA1VoGTaJ+W8fx5Pd4OSPXAY7gHPjFid/Bh3dmlk
         q/3aKFSRSsOpz6kooB5d5196EYG6Ca7bOgdtKrRryWJgBBZ7cr6I2dpdS00m/Mgsyw
         4ML5sGSZxi33r8L7ZyWQrhWr9AHVkcCRzSP4ZfggL1yMue55Eu9h2Cwn0NOfKRFU66
         Pbzplnj1xpcc4EXPw3rOtRZaStJ6lVRQ1Y5NSkvySbegFlLptUho+1t4A/P7RwCmWr
         DeDmTWj8Xk3LQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npPJH-0006bM-4M; Fri, 13 May 2022 09:01:59 +0200
Date:   Fri, 13 May 2022 09:01:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/5] tty/termbits: remove #ifdef CMSPAR that is always
 defined
Message-ID: <Yn4CZzRIKRUjhsS5@hovoldconsulting.com>
References: <20220511101139.5306-1-ilpo.jarvinen@linux.intel.com>
 <20220511101139.5306-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220511101139.5306-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 01:11:35PM +0300, Ilpo Järvinen wrote:
> CMSPAR is defined by all architectures.

For the sake of reviewers please say something about when this changed. 

Also no need to be so verbose in your Subjects

	tty: remove CMSPAR ifdefs

works just fine and is more in line with the prefix typically used for
this subsystem.

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/char/pcmcia/synclink_cs.c   | 2 --
>  drivers/tty/amiserial.c             | 2 --
>  drivers/tty/serial/8250/8250_port.c | 2 --
>  drivers/tty/serial/jsm/jsm_cls.c    | 6 ------
>  drivers/tty/serial/jsm/jsm_neo.c    | 6 ------
>  drivers/tty/serial/sunsu.c          | 2 --
>  drivers/usb/class/cdc-acm.h         | 8 --------
>  drivers/usb/serial/ark3116.c        | 3 +--
>  drivers/usb/serial/whiteheat.c      | 4 ----
>  9 files changed, 1 insertion(+), 34 deletions(-)

The change itself looks good otherwise.

Reviewed-by: Johan Hovold <johan@kernel.org>

> diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> index 78baba55a8b5..c20f2cb784e8 100644
> --- a/drivers/char/pcmcia/synclink_cs.c
> +++ b/drivers/char/pcmcia/synclink_cs.c
> @@ -1432,10 +1432,8 @@ static void mgslpc_change_params(MGSLPC_INFO *info, struct tty_struct *tty)
>  			info->params.parity = ASYNC_PARITY_ODD;
>  		else
>  			info->params.parity = ASYNC_PARITY_EVEN;
> -#ifdef CMSPAR
>  		if (cflag & CMSPAR)
>  			info->params.parity = ASYNC_PARITY_SPACE;
> -#endif
>  	}
>  
>  	/* calculate number of jiffies to transmit a full
> diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
> index 533d02b38e02..afb2d373dd47 100644
> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -588,10 +588,8 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
>  	}
>  	if (!(cflag & PARODD))
>  		cval |= UART_LCR_EPAR;
> -#ifdef CMSPAR
>  	if (cflag & CMSPAR)
>  		cval |= UART_LCR_SPAR;
> -#endif
>  
>  	/* Determine divisor based on baud rate */
>  	baud = tty_get_baud_rate(tty);
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 5591f18f2ea9..78b6dedc43e6 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2620,10 +2620,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
>  	}
>  	if (!(c_cflag & PARODD))
>  		cval |= UART_LCR_EPAR;
> -#ifdef CMSPAR
>  	if (c_cflag & CMSPAR)
>  		cval |= UART_LCR_SPAR;
> -#endif
>  
>  	return cval;
>  }
> diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
> index 444f233ebd1f..046b624e5f71 100644
> --- a/drivers/tty/serial/jsm/jsm_cls.c
> +++ b/drivers/tty/serial/jsm/jsm_cls.c
> @@ -723,14 +723,8 @@ static void cls_param(struct jsm_channel *ch)
>  	if (!(ch->ch_c_cflag & PARODD))
>  		lcr |= UART_LCR_EPAR;
>  
> -	/*
> -	 * Not all platforms support mark/space parity,
> -	 * so this will hide behind an ifdef.
> -	 */
> -#ifdef CMSPAR
>  	if (ch->ch_c_cflag & CMSPAR)
>  		lcr |= UART_LCR_SPAR;
> -#endif
>  
>  	if (ch->ch_c_cflag & CSTOPB)
>  		lcr |= UART_LCR_STOP;
> diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
> index 110696cdaa1d..0cf586c10688 100644
> --- a/drivers/tty/serial/jsm/jsm_neo.c
> +++ b/drivers/tty/serial/jsm/jsm_neo.c
> @@ -997,14 +997,8 @@ static void neo_param(struct jsm_channel *ch)
>  	if (!(ch->ch_c_cflag & PARODD))
>  		lcr |= UART_LCR_EPAR;
>  
> -	/*
> -	 * Not all platforms support mark/space parity,
> -	 * so this will hide behind an ifdef.
> -	 */
> -#ifdef CMSPAR
>  	if (ch->ch_c_cflag & CMSPAR)
>  		lcr |= UART_LCR_SPAR;
> -#endif
>  
>  	if (ch->ch_c_cflag & CSTOPB)
>  		lcr |= UART_LCR_STOP;
> diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
> index c31389114b86..fff50b5b82eb 100644
> --- a/drivers/tty/serial/sunsu.c
> +++ b/drivers/tty/serial/sunsu.c
> @@ -798,10 +798,8 @@ sunsu_change_speed(struct uart_port *port, unsigned int cflag,
>  		cval |= UART_LCR_PARITY;
>  	if (!(cflag & PARODD))
>  		cval |= UART_LCR_EPAR;
> -#ifdef CMSPAR
>  	if (cflag & CMSPAR)
>  		cval |= UART_LCR_SPAR;
> -#endif
>  
>  	/*
>  	 * Work around a bug in the Oxford Semiconductor 952 rev B
> diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
> index 3aa7f0a3ad71..d26ecd15be60 100644
> --- a/drivers/usb/class/cdc-acm.h
> +++ b/drivers/usb/class/cdc-acm.h
> @@ -7,14 +7,6 @@
>   *
>   */
>  
> -/*
> - * CMSPAR, some architectures can't have space and mark parity.
> - */
> -
> -#ifndef CMSPAR
> -#define CMSPAR			0
> -#endif
> -
>  /*
>   * Major and minor numbers.
>   */
> diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
> index c0e4df87ff22..39eaa7b97c40 100644
> --- a/drivers/usb/serial/ark3116.c
> +++ b/drivers/usb/serial/ark3116.c
> @@ -208,10 +208,9 @@ static void ark3116_set_termios(struct tty_struct *tty,
>  		lcr |= UART_LCR_PARITY;
>  	if (!(cflag & PARODD))
>  		lcr |= UART_LCR_EPAR;
> -#ifdef CMSPAR
>  	if (cflag & CMSPAR)
>  		lcr |= UART_LCR_SPAR;
> -#endif
> +
>  	/* handshake control */
>  	hcr = (cflag & CRTSCTS) ? 0x03 : 0x00;
>  
> diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
> index 06aad0d727dd..332fb92ae575 100644
> --- a/drivers/usb/serial/whiteheat.c
> +++ b/drivers/usb/serial/whiteheat.c
> @@ -30,10 +30,6 @@
>  #include <linux/usb/ezusb.h>
>  #include "whiteheat.h"			/* WhiteHEAT specific commands */
>  
> -#ifndef CMSPAR
> -#define CMSPAR 0
> -#endif
> -
>  /*
>   * Version Information
>   */

Johan
