Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A38257F44C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 11:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiGXJKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 05:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiGXJKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 05:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90354E0;
        Sun, 24 Jul 2022 02:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45BE6B80D47;
        Sun, 24 Jul 2022 09:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89F0C3411E;
        Sun, 24 Jul 2022 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658653814;
        bh=89M89dfnkToEcgLfJ1AqZkSAL9rrseeGP4EToMudOEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/Z7Ws5HTMSzhQcqS6mi+man7/Ww4lmw9Y1pxNsHH8JwA5kM6BVD0BluSupLjX5CR
         zq8Edxx5sDPmAY2qUbCbBtOviNND9OntjCngyRheSLTB0Zo1usi2T8y3TwwEUvWnJx
         1a+k+wGi0UxOMVQKBcBUxf2/gXm70A10x1FZX/0exOqdTNlYU8j7EBapeay+R2/9cw
         NO6E1gKIUS7TZipdZD3+SV734ysfhM9bCQMJjv9y3AvU4xdWVg4kENr86ehZ890YKF
         BBP7QrZAmhN/AgvgkNNXb8FKhkVzj4wyOB85i9DklWLN1tlM/3S2Ei+oI2NOGd+qvA
         Xwl2E2ISOpLQw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFXd0-00013C-TP; Sun, 24 Jul 2022 11:10:22 +0200
Date:   Sun, 24 Jul 2022 11:10:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Yan Xinyu <sdlyyxy@bupt.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: usb_wwan: replace DTR/RTS magic numbers
 with macros
Message-ID: <Yt0MfqQQTwe4ztuN@hovoldconsulting.com>
References: <20220722085040.704885-1-sdlyyxy@bupt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722085040.704885-1-sdlyyxy@bupt.edu.cn>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 04:50:40PM +0800, Yan Xinyu wrote:
> The usb_wwan_send_setup function generates DTR/RTS signals in compliance
> with CDC ACM standard. This patch changes magic numbers in this function
> to equivalent macros.
> 
> Signed-off-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> ---
> v1->v2:
>  * Fix Signed-off-by name.
> v2->v3:
>  * Use already defined ACM_CTRL_DTR and ACM_CTRL_RTS in drivers/usb/class/cdc-acm.h
> ---
>  drivers/usb/serial/usb_wwan.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
> index dab38b63eaf7..5c8303bd3676 100644
> --- a/drivers/usb/serial/usb_wwan.c
> +++ b/drivers/usb/serial/usb_wwan.c
> @@ -29,8 +29,10 @@
>  #include <linux/bitops.h>
>  #include <linux/uaccess.h>
>  #include <linux/usb.h>
> +#include <linux/usb/cdc.h>
>  #include <linux/usb/serial.h>
>  #include <linux/serial.h>
> +#include "../class/cdc-acm.h"

If we are to use common defines, these would need to be added to
linux/usb/cdc.h first (parts of which are exposed to user space).

Note that we already have at least three copies of these defines in the
tree.

I'm fine with adding another copy for now and not have to deal with with
naming and cross driver updates. What do you think, Greg?

>  #include "usb-wwan.h"
>  
>  /*
> @@ -48,9 +50,9 @@ static int usb_wwan_send_setup(struct usb_serial_port *port)
>  	portdata = usb_get_serial_port_data(port);
>  
>  	if (portdata->dtr_state)
> -		val |= 0x01;
> +		val |= ACM_CTRL_DTR;
>  	if (portdata->rts_state)
> -		val |= 0x02;
> +		val |= ACM_CTRL_RTS;
>  
>  	ifnum = serial->interface->cur_altsetting->desc.bInterfaceNumber;
>  
> @@ -59,8 +61,9 @@ static int usb_wwan_send_setup(struct usb_serial_port *port)
>  		return res;
>  
>  	res = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
> -				0x22, 0x21, val, ifnum, NULL, 0,
> -				USB_CTRL_SET_TIMEOUT);
> +				USB_CDC_REQ_SET_CONTROL_LINE_STATE,
> +				USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> +				val, ifnum, NULL, 0, USB_CTRL_SET_TIMEOUT);
>  
>  	usb_autopm_put_interface(port->serial->interface);

Looks good otherwise.

Johan
