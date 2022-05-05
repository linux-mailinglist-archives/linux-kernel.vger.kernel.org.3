Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040D551CC2E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386414AbiEEWiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386357AbiEEWiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:38:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4A15EDE9;
        Thu,  5 May 2022 15:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49DB361E53;
        Thu,  5 May 2022 22:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B4CC385A8;
        Thu,  5 May 2022 22:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651790069;
        bh=yTcFGVLc3+AOQ1XjsAcqpmVXAumzRnrItaNrHQCcFDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wo3lcRzwPSsIofnFhSxwv0SUxltKy9OuwQn7q2w//MopqTs+nn/Li/1kTa9xnHQ5B
         cPRpoHa+1/UNV3UMfnGinENJDvsBZOagu9SRBcElNxekIK7KvQGIv5d20ZTzrypQSo
         PTZbaePukkvxYCmP/tA9+/JYORwX09FUdDAjm4mk=
Date:   Thu, 5 May 2022 22:51:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, michal.simek@xilinx.com,
        jirislaby@kernel.org, git@xilinx.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] tty: xilinx_uartps: Check clk_enable return value
Message-ID: <YnQ4t+vAjG2RaNh8@kroah.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
 <20220429081422.3630070-5-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429081422.3630070-5-shubhrajyoti.datta@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:44:19PM +0530, Shubhrajyoti Datta wrote:
> Check for the clock enable return value.
> 
> Addresses-Coverity: Event check_return.
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 868f4e587263..bf0415f0a194 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1347,12 +1347,18 @@ static int cdns_uart_resume(struct device *device)
>  	unsigned long flags;
>  	u32 ctrl_reg;
>  	int may_wake;
> +	int ret;
>  
>  	may_wake = device_may_wakeup(device);
>  
>  	if (console_suspend_enabled && uart_console(port) && !may_wake) {
> -		clk_enable(cdns_uart->pclk);
> -		clk_enable(cdns_uart->uartclk);
> +		ret = clk_enable(cdns_uart->pclk);
> +		if (ret)
> +			return ret;
> +
> +		ret = clk_enable(cdns_uart->uartclk);
> +		if (ret)
> +			return ret;

Shouldn't you disable the clock you enabled if this fails here?

thanks,

greg k-h
