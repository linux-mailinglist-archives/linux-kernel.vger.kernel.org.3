Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C005AA733
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiIBFYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIBFYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:24:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADF7EE21;
        Thu,  1 Sep 2022 22:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAA6FB81CCF;
        Fri,  2 Sep 2022 05:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6F4C433C1;
        Fri,  2 Sep 2022 05:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662096281;
        bh=4X2YpCNGs+Lc0xdA7x/qqOj/KFmabIXoSeXWOx7VaHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IANCZLQq9rVauziIqD1LfkMYvIpsCEA97Nopw7t5SyP5gDbSUbub4WXJVL2nzAnum
         dMFpJMK9cOn5J0qHdVnDqxWvL82lw+y30HUWmeCURIETcP6WK/B5fA5KuKoERB91p5
         TFbJJ19u0FfthE719GMnxfyoTKWiDoYspZYXIk3s=
Date:   Fri, 2 Sep 2022 07:24:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: Add check for create_sysfs_attrs
Message-ID: <YxGTlhCVbv1LsO0K@kroah.com>
References: <20220902032002.3859368-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902032002.3859368-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:20:02AM +0800, Jiasheng Jiang wrote:
> As create_sysfs_attrs() can return error number,
> it should be better to check the return value and
> deal with the exception.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/usb/serial/ftdi_sio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index d5a3986dfee7..c28f894430a5 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -2251,7 +2251,11 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
>  	if (read_latency_timer(port) < 0)
>  		priv->latency = 16;
>  	write_latency_timer(port);
> -	create_sysfs_attrs(port);
> +	result = create_sysfs_attrs(port);
> +	if (result) {
> +		remove_sysfs_attrs(port);
> +		return result;
> +	}

Again, this should be changed to use a default attribute group instead.
Please make that change.

thanks,

greg k-h
