Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04E151CC39
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386393AbiEEWiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386358AbiEEWiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:38:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921F55EDEE;
        Thu,  5 May 2022 15:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E20B61E53;
        Thu,  5 May 2022 22:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6D5C385AF;
        Thu,  5 May 2022 22:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651790068;
        bh=uDr+lsBem0J7+7JVvUgfHSt8biqb1jclJ2+jD27kwkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5ZDUYZh/a68zlQOTLkTEP4KqZ5cGRXRWUcGKr23MBVHfLrUwKPZWS3UwBxmuWuGH
         RPm4BILcARKDqOSf4wbyJQpP8hj79QMmMjpWdQLZpbklfCPHry5zi3lUKRn/dQe8si
         BuNlgw0ZgO+338p2ckw2D3RwhgLp5AvwhfEJt+ug=
Date:   Thu, 5 May 2022 22:50:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, michal.simek@xilinx.com,
        jirislaby@kernel.org, git@xilinx.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] tty: xilinx_uartps: Add check for runtime_get_sync
 calls
Message-ID: <YnQ4lxfJUGe4TyFi@kroah.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
 <20220429081422.3630070-4-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429081422.3630070-4-shubhrajyoti.datta@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:44:18PM +0530, Shubhrajyoti Datta wrote:
> Add a check for the return value of runtime get_sync calls.
> 
> Addresses-Coverity: Event check_return.
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 8f15fe24a0eb..868f4e587263 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1100,13 +1100,17 @@ static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
>  static void cdns_uart_pm(struct uart_port *port, unsigned int state,
>  		   unsigned int oldstate)
>  {
> +	int ret;
> +
>  	switch (state) {
>  	case UART_PM_STATE_OFF:
>  		pm_runtime_mark_last_busy(port->dev);
>  		pm_runtime_put_autosuspend(port->dev);
>  		break;
>  	default:
> -		pm_runtime_get_sync(port->dev);
> +		ret = pm_runtime_get_sync(port->dev);
> +		if (ret < 0)
> +			dev_err(port->dev, "Failed to enable clocks\n");

So you just ignore the error?  SHouldn't you propagate it back upward?

thanks,

greg k-h
