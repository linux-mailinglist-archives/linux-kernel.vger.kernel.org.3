Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88CF51CC2C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386436AbiEEWil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386405AbiEEWiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:38:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5795F26A;
        Thu,  5 May 2022 15:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41F0DB830E9;
        Thu,  5 May 2022 22:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE40C385A8;
        Thu,  5 May 2022 22:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651790072;
        bh=dp3F8rI4CvWgLhnUbMRL1J2c9h2g1LNaKqqleeQ+zMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEMjOVRmp/JQJDirJ8sIrNKbUCcfAKCxJg7M4ZcgbBKoZ19HMA+Jbogu4BTHRuV66
         vYgaH/CCQd9ZEOa7yMTdw3vxsam15yq9Q9oe1IUtvna9dsyryRfOCfXEG79N7iTLth
         v/RcrUgFgITDbSWKl/PuE60xUpJDkHDBuDHdc1kU=
Date:   Thu, 5 May 2022 22:56:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, michal.simek@xilinx.com,
        jirislaby@kernel.org, git@xilinx.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] serial: uartps: Prevent writes when the controller
 is disabled
Message-ID: <YnQ55WC56Y87jCPI@kroah.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
 <20220429081422.3630070-8-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429081422.3630070-8-shubhrajyoti.datta@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:44:22PM +0530, Shubhrajyoti Datta wrote:
> Prevent writing to the fifo if the controller is disabled.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 81ba69c57716..f629c4ca940f 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1150,6 +1150,13 @@ static struct uart_driver cdns_uart_uart_driver;
>   */
>  static void cdns_uart_console_putchar(struct uart_port *port, unsigned char ch)
>  {
> +	unsigned int ctrl_reg;
> +
> +	ctrl_reg = readl(port->membase + CDNS_UART_CR);
> +	while (ctrl_reg & CDNS_UART_CR_TX_DIS) {
> +		ctrl_reg = readl(port->membase + CDNS_UART_CR);
> +		cpu_relax();

You are spinning for forever?  With no timeout possible?

That's not ok :(


> +	}
>  	while (readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)
>  		cpu_relax();

Ick, same here, you better hope your hardware works...

thanks,

greg k-h
