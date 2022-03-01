Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5C4C82A0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiCAEnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiCAEnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:43:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC1B93;
        Mon, 28 Feb 2022 20:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/s4GR9S2+ETqoDEQye8YSHELvdJ4cuLvOBPR6dSfpBk=; b=wCc3Hl/hx6CjrBUzWcGdshMMcY
        2rCjwoIKtF5hXCwaW0hrcrrgJp1f1UXxlqmBCC7vEZaKVGdMHbUmrrVvBdqGi8vyLPIoJ/+qVDK9P
        DTrSom/Frd+KveF4jTttCVy4NwrtTh+bgQwacpJpj87g8lct2qtydjFtfnr7XrH310p/TtDdQ1mrP
        Fgzk2PykbEjEocc1XHYi3feeO9sQA+BBd5biUCOlFRFXaXlh1ngE8gRwvp4kT2VOQ2TCNijbkf4bU
        sm4wx7Ga2D788xkiAME6RIEfj8B94WjY95POHHhRW96TWsgcXAFk5C3zWpFIE+9l+s8zgwkKGwH5J
        y6o14wqA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOuLY-009F0N-In; Tue, 01 Mar 2022 04:42:48 +0000
Message-ID: <2d47ac47-cabe-72c9-336e-d54cbc402530@infradead.org>
Date:   Mon, 28 Feb 2022 20:42:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH tty-next] serial:sunplus-uart:Fix compile error while
 CONFIG_SERIAL_SUNPLUS_CONSOLE=n
Content-Language: en-US
To:     Hammer Hsieh <hammerh0314@gmail.com>, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com
References: <1646108386-29905-1-git-send-email-hammerh0314@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1646108386-29905-1-git-send-email-hammerh0314@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/22 20:19, Hammer Hsieh wrote:
> 1. Fix implicit declaration of function 'wait_for_xmitr' issue.
> 2. Fix 'sunplus_uart_console' undeclared here issue.
> 3. Fix use of undeclared identifier 'sunplus_uart_console' issue.
> 
> Fixes: 9e8d547032("serial:sunplus-uart:Fix compile error for SP7021")
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
> ---
>  drivers/tty/serial/sunplus-uart.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
> index 450c8e7..1c7a30b 100644
> --- a/drivers/tty/serial/sunplus-uart.c
> +++ b/drivers/tty/serial/sunplus-uart.c
> @@ -441,7 +441,7 @@ static int sunplus_verify_port(struct uart_port *port, struct serial_struct *ser
>  	return 0;
>  }
>  
> -#ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
> +#if defined(CONFIG_SERIAL_SUNPLUS_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
>  static void wait_for_xmitr(struct uart_port *port)
>  {
>  	unsigned int val;
> @@ -562,6 +562,10 @@ static struct console sunplus_uart_console = {
>  	.index		= -1,
>  	.data		= &sunplus_uart_driver
>  };
> +
> +#define	SERIAL_SUNPLUS_CONSOLE	(&sunplus_uart_console)
> +#else
> +#define	SERIAL_SUNPLUS_CONSOLE	NULL
>  #endif
>  
>  static struct uart_driver sunplus_uart_driver = {
> @@ -571,7 +575,7 @@ static struct uart_driver sunplus_uart_driver = {
>  	.major		= TTY_MAJOR,
>  	.minor		= 64,
>  	.nr		= SUP_UART_NR,
> -	.cons		= &sunplus_uart_console,
> +	.cons		= SERIAL_SUNPLUS_CONSOLE,
>  };
>  
>  static void sunplus_uart_disable_unprepare(void *data)

-- 
~Randy
