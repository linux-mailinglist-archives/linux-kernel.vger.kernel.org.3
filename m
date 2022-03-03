Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCA4CBE7B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiCCNGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiCCNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:05:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B654F447;
        Thu,  3 Mar 2022 05:05:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D35DB8250F;
        Thu,  3 Mar 2022 13:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0696DC004E1;
        Thu,  3 Mar 2022 13:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646312711;
        bh=B/3RGiI7W/FPKOXvLsn6wtt0Q35YkbEwATTMSqvP5EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGtAju3KW2L6I/fjAo5jBMcu5Upa2TiOXYq6Ef2l7VpOX192bPu+yULKLeSWXPPiy
         xj6500n/LUgsomKXyDI9xSiqnoMx5Vk1GKOAoFonzHbLv4Zcf8PWfg7xFPBu+v7zU3
         iAlqon1NSoz0Y5L+T69NnqEOP7nsrksuXdL0/E8TJcaA/5CaZjtjOleNXN5r/Skixg
         OO5bKcpFCCr+1MHQrfszuX86QEe443ExaGV/vu082UWxm8TPqXAH0FvoQ7pOGvGeXF
         F6lhJhFvOeG1cgMLXNr2OPaH92qGAy4UA/KUMKgSghhfpmnh54e2OmIiEHWmz4idCU
         DIDBKdveUAcZg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nPl8n-0008SD-28; Thu, 03 Mar 2022 14:05:09 +0100
Date:   Thu, 3 Mar 2022 14:05:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] USB: serial: ti_usb_3410_5052: Use struct_size()
 helper in ti_write_byte()
Message-ID: <YiC9BYxcmtp6TUIx@hovoldconsulting.com>
References: <20220120213131.GA32119@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120213131.GA32119@embeddedor>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 03:31:31PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.

This boiler-plate motivation doesn't apply here since the "variable"
size is in fact constant.

> Also, address the following sparse warnings:
> drivers/usb/serial/ti_usb_3410_5052.c:1521:16: warning: using sizeof on a flexible structure

And this bit is again bogus, since this off-by-default warning would
still be there with this patch applied.

> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/usb/serial/ti_usb_3410_5052.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
> index 18c0bd853392..03f98e61626f 100644
> --- a/drivers/usb/serial/ti_usb_3410_5052.c
> +++ b/drivers/usb/serial/ti_usb_3410_5052.c
> @@ -1512,13 +1512,13 @@ static int ti_write_byte(struct usb_serial_port *port,
>  			 u8 mask, u8 byte)
>  {
>  	int status;
> -	unsigned int size;
> +	size_t size;
>  	struct ti_write_data_bytes *data;
>  
>  	dev_dbg(&port->dev, "%s - addr 0x%08lX, mask 0x%02X, byte 0x%02X\n", __func__,
>  		addr, mask, byte);
>  
> -	size = sizeof(struct ti_write_data_bytes) + 2;
> +	size = struct_size(data, bData, 2);

I guess the change itself is fine otherwise and could be motivated as
documenting the constant.

At least as long as the compiler is smart enough to not generate any
additional code for this, there wouldn't be any downsides.

>  	data = kmalloc(size, GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;

Johan
