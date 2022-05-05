Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CE351CC2F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386432AbiEEWig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386397AbiEEWiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:38:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E785EDF7;
        Thu,  5 May 2022 15:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05706B830E6;
        Thu,  5 May 2022 22:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBECC385A4;
        Thu,  5 May 2022 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651790070;
        bh=hO2A4SVsDkhJ7qnPrTSEyzIul7Kf9wYJIiSuZtra2y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMz1GkHg2Ro7dJBVzR7KY57I4+4Nrki4LoN+G/w5QI+436fvKLwQhkewGgQ+FvjRN
         K8zDXL/cNsqlQbSexeXruRgUtXmM3GeKREPi2wGmiw1eROPqQ400FXTLFQtk2SPWZt
         iJEseGYABQK5bnuBe1Ho3xq0p0Q1uLo2Ip7LWNAI=
Date:   Thu, 5 May 2022 22:54:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, michal.simek@xilinx.com,
        jirislaby@kernel.org, git@xilinx.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] tty: xilinx_uartps: Make the timeout unsigned
Message-ID: <YnQ5fh6pcPWmveE8@kroah.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
 <20220429081422.3630070-6-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429081422.3630070-6-shubhrajyoti.datta@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:44:20PM +0530, Shubhrajyoti Datta wrote:
> The timeout cannot be negative make it unsigned.
> Also the same for the trigger level.
> 
> Addresses-Coverity: Event incompatible_param.

What does this mean?

> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index bf0415f0a194..289d70914956 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -34,12 +34,12 @@
>  #define TX_TIMEOUT		500000
>  
>  /* Rx Trigger level */
> -static int rx_trigger_level = 56;
> +static uint rx_trigger_level = 56;
>  module_param(rx_trigger_level, uint, 0444);
>  MODULE_PARM_DESC(rx_trigger_level, "Rx trigger level, 1-63 bytes");
>  
>  /* Rx Timeout */
> -static int rx_timeout = 10;
> +static uint rx_timeout = 10;
>  module_param(rx_timeout, uint, 0444);
>  MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");

As this is bounded (right?) why is this an issue?

Shouldn't it be a "byte" instead?

thanks,

greg k-h
