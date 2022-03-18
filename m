Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4BA4DD9C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiCRMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiCRMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE382D7A80;
        Fri, 18 Mar 2022 05:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD27618A9;
        Fri, 18 Mar 2022 12:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0983FC340E8;
        Fri, 18 Mar 2022 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647606726;
        bh=54Ok/2iGFXz3IZ7nZgvvP6ra5Se4bncRygsdoY+z6dM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKXAayjtLN5gupy3uawEImcXQc4hsOau6wF6khve+EpQBY09MKAd7jzr0J0lhRC0e
         ghbyueE5YTXdfA7jW9NAUJ0mlIJVzeOjhEbAGczpIPTsdcS4E22nVZUBo745tL+h53
         iNuMRZXZEihHN4MuwdoTm9AKJZkOALS5O9K44Vdk=
Date:   Fri, 18 Mar 2022 13:27:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/3] serial: 8250_fintek: Finish support for the F81865
Message-ID: <YjR6yfjUmHahbIym@kroah.com>
References: <20220314121856.10112-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314121856.10112-1-twoerner@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 08:18:56AM -0400, Trevor Woerner wrote:
> This driver only partially supports the F81865 device. The UART portions of
> this SuperIO chip behave very similarly to the UART of the F81866, except
> that the F81866 has 128-byte FIFOs whereas the F81865 has 16-byte FIFOs,
> and the IRQ configuration is different. Therefore fill out the support for
> the F81865 in the places where it is missing.
> 
> Tested at 1500000 baud on the iEi NANO-PV-D5251-R10 board.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_fintek.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
> index 251f0018ae8c..47b15d2d9901 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -63,7 +63,12 @@
>  #define F81216_LDN_HIGH	0x4
>  
>  /*
> - * F81866/966 registers
> + * F81866/865/966 registers
> + *
> + * The UART portion of the F81865 functions very similarly to the UART
> + * portion of the F81866, so there's no need to duplicate all the #defines
> + * etc. The only differences are: the F81866 has 128-byte FIFOs whereas the
> + * F81865 has 16-byte FIFOs, and the IRQ configuration is different.
>   *
>   * The IRQ setting mode of F81866/966 is not the same with F81216 series.
>   *	Level/Low: IRQ_MODE0:0, IRQ_MODE1:0
> @@ -316,6 +321,7 @@ static void fintek_8250_set_termios(struct uart_port *port,
>  		break;
>  	case CHIP_ID_F81966:
>  	case CHIP_ID_F81866:
> +	case CHIP_ID_F81865:
>  		reg = F81866_UART_CLK;
>  		break;
>  	default:
> @@ -363,6 +369,7 @@ static void fintek_8250_set_termios_handler(struct uart_8250_port *uart)
>  	case CHIP_ID_F81216H:
>  	case CHIP_ID_F81966:
>  	case CHIP_ID_F81866:
> +	case CHIP_ID_F81865:
>  		uart->port.set_termios = fintek_8250_set_termios;
>  		break;
>  
> -- 
> 2.35.1.455.g1a4874565f
> 

Please resend the whole series, not just one patch out of the lot.  Also
can you correctly "thread" them?  Using a tool like git send-email it
happens automatically.  That way our tools can pick them up properly.

thanks,

greg k-h
