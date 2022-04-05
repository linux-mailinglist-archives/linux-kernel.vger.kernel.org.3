Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D74F2263
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiDEFFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiDEFEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:04:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75F9140B5;
        Mon,  4 Apr 2022 22:01:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80444B81B90;
        Tue,  5 Apr 2022 05:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9943BC340EE;
        Tue,  5 Apr 2022 05:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649134915;
        bh=e5EQtix5aFAPDaLEE5fMDdRZZOPJIQKpd5zNLgUHA2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wc7kf3VBwy/YZJDsat74f+LuofG6avsugwvIRinU0HRzqvELG0iuTi0Atim0G72S7
         Af+3LtDb/LiT/bn2yzD/4rM+mhgpD4gYjvDV1kKitXJrbf1bk3ElTEjFF5ZpyTouZE
         ZN84Tyl4IVBC6+aBp09lfK5b2RkN0AwutDB0Gv1I=
Date:   Tue, 5 Apr 2022 07:01:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH 1/1] tty: serial: samsung: add spin_lock for interrupt
 and console_write
Message-ID: <YkvNQJ5hBhQKCwcU@kroah.com>
References: <20220405033854.110374-1-jaewon02.kim@samsung.com>
 <CGME20220405033448epcas2p397080e15c54369d24eaf94c2a27bd06c@epcas2p3.samsung.com>
 <20220405033854.110374-2-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405033854.110374-2-jaewon02.kim@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 12:38:54PM +0900, Jaewon Kim wrote:
> The console_write and IRQ handler can run concurrently.
> Problems may occurs console_write is continuously executed while
> the IRQ handler is running.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

What commit does this fix?

> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index e1585fbae909..d362e8e114f1 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2480,12 +2480,26 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
>  			     unsigned int count)
>  {
>  	unsigned int ucon = rd_regl(cons_uart, S3C2410_UCON);
> +	unsigned long flags;
> +	int locked = 1;

bool?

>  
>  	/* not possible to xmit on unconfigured port */
>  	if (!s3c24xx_port_configured(ucon))
>  		return;
>  
> +	local_irq_save(flags);
> +	if (cons_uart->sysrq)
> +		locked = 0;
> +	else if (oops_in_progress)
> +		locked = spin_trylock(&cons_uart->lock);
> +	else
> +		spin_lock(&cons_uart->lock);
> +
>  	uart_console_write(cons_uart, s, count, s3c24xx_serial_console_putchar);
> +
> +	if (locked)
> +		spin_unlock(&cons_uart->lock);
> +	local_irq_restore(flags);

Why is irq_save required as well as a spinlock?

thanks,

greg k-h
