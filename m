Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA1152A61C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349904AbiEQPXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiEQPXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:23:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B93C3153F;
        Tue, 17 May 2022 08:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D570E61465;
        Tue, 17 May 2022 15:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B33C385B8;
        Tue, 17 May 2022 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652800977;
        bh=NkPPZQlulZyYFxcr14FJfM4TxekosEMQzC9py7Up9Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8RbvEYE61pgRvH8LA7dZZeoWsIiy6vaaucwau767Ops/o1TtFDkn3wsF/slV8Cun
         2L/S69iRGAjfBo5BTWGYLQwvhHfCzfBN+MPE25utRF6KO0ePrMw6VdFV+kKIwL+qY2
         SNUyW3ZvXGjYoqJAD8k0opJIk1D1M4LFwPQfPzkr1AZNktrZmGnvi7XXaQNZn0HusN
         XfdhFJupt91vAzXHQt7dBfyc7uvY/+zHXWnYF9m92FjDncwXPkVWhApaoiV4c16IUx
         //MLEXTa70foqBJdy7Qs4WJ0Fzm1S/qlvrYY5n4f7nUtQMJdszpgDrQEmdtY71rR6P
         72LDrYq0beQpQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nqz2H-0001PP-Et; Tue, 17 May 2022 17:22:57 +0200
Date:   Tue, 17 May 2022 17:22:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Robert Eckelmann <longnoserob@gmail.com>
Cc:     gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: serial: io_ti: Adding Agilent E5805A support
Message-ID: <YoO90SiFgBwrwhgK@hovoldconsulting.com>
References: <20220514122804.05c69987@octoberrain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514122804.05c69987@octoberrain>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 12:28:04PM +0900, Robert Eckelmann wrote:
> Hello Johan,
> 
> Below is a small patch regarding the io_ti driver.
> This patch enables the use of the Agilent E5805A USB-RS232(x4) adapter.
> It is a relabeled Inside Out Networks Edgeport with OEM USB-ID.

Thanks for the patch. Note that anything you write here in the body of
the will end up in the git commit message so greetings etc. should go
below the --- line.

> Signed-off-by: Robert Eckelmann <longnoserob@gmail.com>
> ---
>  Documentation/usb/usb-serial.rst | 4 ++++
>  drivers/usb/serial/io_ti.c       | 2 ++
>  drivers/usb/serial/io_usbvend.h  | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/usb/usb-serial.rst b/Documentation/usb/usb-serial.rst
> index 69586aeb60bb..d9cfb6cb2d07 100644
> --- a/Documentation/usb/usb-serial.rst
> +++ b/Documentation/usb/usb-serial.rst
> @@ -412,6 +412,10 @@ Inside Out Networks Edgeport Driver
>         - Edgeport/4 DIN
>         - Edgeport/16 Dual
> 
> +  This dirver now also includes the Agilent E5805A usb-to-RS232 adapter device,

typo: dirver

> +  as this is a rebranded Edgeport device.

But I don't we need to update the documentation here as the list isn't
complete as is.

Actually this entry appears to be for the io_edgeport driver.

> +
> +
>    For any questions or problems with this driver, please contact Greg
>    Kroah-Hartman at greg@kroah.com
> 
> diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
> index a7b3c15957ba..2810cefa628d 100644
> --- a/drivers/usb/serial/io_ti.c
> +++ b/drivers/usb/serial/io_ti.c
> @@ -166,6 +166,7 @@ static const struct usb_device_id edgeport_2port_id_table[] = {
> 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_8S) },
> 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416) },
> 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416B) },
> +	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_E5805A)},
> 	{ }
>  };
> 
> @@ -204,6 +205,7 @@ static const struct usb_device_id id_table_combined[] = {
> 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_8S) },
> 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416) },
> 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416B) },
> +	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_E5805A)},
> 	{ }
>  };
> 
> diff --git a/drivers/usb/serial/io_usbvend.h b/drivers/usb/serial/io_usbvend.h
> index 52cbc353051f..3be6bce15d97 100644
> --- a/drivers/usb/serial/io_usbvend.h
> +++ b/drivers/usb/serial/io_usbvend.h
> @@ -212,7 +212,7 @@
>  //
>  // Definitions for other product IDs
>  #define ION_DEVICE_ID_MT4X56USB			0x1403	// OEM device
> -

Please keep the double newline separator.

> +#define ION_DEVICE_ID_E5805A			0x1A01  // OEM device (internals based on Edgeport/4?)

Just say "rebranded" here too?

Could you please also post the output of usb-devices (or lsusb -v) for
this device for completeness?

> 
>  #define	GENERATION_ID_FROM_USB_PRODUCT_ID(ProductId)				\
> 			((__u16) ((ProductId >> 8) & (ION_GENERATION_MASK)))

Johan
