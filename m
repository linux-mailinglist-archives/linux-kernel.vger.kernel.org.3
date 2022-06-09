Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FC8544B86
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbiFIMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbiFIMQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:16:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22502B12EA;
        Thu,  9 Jun 2022 05:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5257A61635;
        Thu,  9 Jun 2022 12:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34DDC3411D;
        Thu,  9 Jun 2022 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654776981;
        bh=PkBfDMVj8MxOh4iD///tuj1560VB+8BsCN38UErI+oQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITJSdHIyo+Q9S9YJbacbQTe5Fn32DU4x0g1G+biWVcf3+UMYR4zzg2TLnHpvDk/JQ
         rYh3GYI0FBLw0/fvuCfDQBS9VqwQI7K0Y9nmLWgfZDPqe3Lk6bwfdNDDzbK/oE7ke2
         uQTSKOzdfxtZpjq9DJVVX4jhH/GuLNm3OT2BqdCjbBR6o7oZ3dzK85MjmWfXYOy+z0
         jxytSoQ0+Rn9a105wciws0sFQKIj8eV05JMJFFBYv9TDy2MB6Mz8jZ8AKc/vGUnthw
         JSE5rljjYwNnQB3udPfVLIJasqu/4mBv/N8EXDbm6CdZdCKN0c2iMHh2fZGPNbXoPs
         gLHJGgIqqEBrQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzH5F-0002BX-64; Thu, 09 Jun 2022 14:16:17 +0200
Date:   Thu, 9 Jun 2022 14:16:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Robert Eckelmann <longnoserob@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: serial: io_ti: Adding Agilent E5805A support
Message-ID: <YqHkkYcwNhJJJgqT@hovoldconsulting.com>
References: <20220521230808.30931eca@octoberrain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521230808.30931eca@octoberrain>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 11:08:08PM +0900, Robert Eckelmann wrote:
> 
> This patch adds support for Agilent E5805A (rebranded ION Edgeport/4) to
> io_ti.
> 
> Signed-off-by: Robert Eckelmann <longnoserob@gmail.com>
> ---
> output of lsusb -v (with Serial-Number of the device anonymized):

[...]

> Changes in v2:
>   - removed documentation change
>   - improvements to spaceing in io_usbvend.h
>   - rephrasing comment in io_usbvend.h

Thanks for the v2. Now applied with minor tweaks to the commit message,
keeping the double newline separator after the new define, and adding
the missing spaces after the USB_DEVICE macros.

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-linus&id=908e698f2149c3d6a67d9ae15c75545a3f392559

> diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
> index a7b3c15957ba..ff0d05f45fce 100644
> --- a/drivers/usb/serial/io_ti.c
> +++ b/drivers/usb/serial/io_ti.c
> @@ -166,6 +166,7 @@ static const struct usb_device_id edgeport_2port_id_table[] = {
>  	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_8S) },
>  	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416) },
>  	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416B) },
> +	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_E5805A)},
>  	{ }
>  };
>  
> @@ -204,6 +205,7 @@ static const struct usb_device_id id_table_combined[] = {
>  	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_8S) },
>  	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416) },
>  	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416B) },
> +	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_E5805A)},
>  	{ }
>  };
>  
> diff --git a/drivers/usb/serial/io_usbvend.h b/drivers/usb/serial/io_usbvend.h
> index 52cbc353051f..879ef755898f 100644
> --- a/drivers/usb/serial/io_usbvend.h
> +++ b/drivers/usb/serial/io_usbvend.h
> @@ -213,6 +213,7 @@
>  // Definitions for other product IDs
>  #define ION_DEVICE_ID_MT4X56USB			0x1403	// OEM device
>  
> +#define ION_DEVICE_ID_E5805A			0x1A01  // OEM device (rebranded Edgeport/4)
>  
>  #define	GENERATION_ID_FROM_USB_PRODUCT_ID(ProductId)				\
>  			((__u16) ((ProductId >> 8) & (ION_GENERATION_MASK)))

Johan
