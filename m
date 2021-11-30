Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99914632CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbhK3Lsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:48:37 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55224 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhK3Ls1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:48:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C3535CE189B;
        Tue, 30 Nov 2021 11:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B47C53FD1;
        Tue, 30 Nov 2021 11:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638272705;
        bh=2h877NUNcxuYoPp2Gk4J/rQHwqfdOCqinlttcnauj50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRLVxdO2S5UcB5Ej6DKrLPUqUO/AH4IcNzudkuPuCF7915XrRs2mVDg7A0EMsXfGw
         uvzziA0cwsIN6afsgGqwDz2nGqL5+qhuP+jEmxFkgmdBLKWbhZyNMjGtuk2evEU1od
         RuOT2TMEEJV+ZZm+IQ9iU0UEJ0Q6PoSODJcsI9ts=
Date:   Tue, 30 Nov 2021 12:45:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
Message-ID: <YaYOvgCaO4FJ8r+z@kroah.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-2-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130104256.3106797-2-neal_liu@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 06:42:53PM +0800, Neal Liu wrote:
> Support qualifier descriptor to pass USB30CV compliance test.

Please provide more information here in this description.  This does not
explain what is happening here very well.

Also, what is "USB30CV"?

> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 24 +++++++++++++++++++++++
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> index b9960fdd8a51..93f27a745760 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> @@ -68,6 +68,18 @@ static const struct usb_device_descriptor ast_vhub_dev_desc = {
>  	.bNumConfigurations	= 1,
>  };
>  
> +static const struct usb_qualifier_descriptor ast_vhub_qual_desc = {
> +	.bLength = 0xA,
> +	.bDescriptorType = USB_DT_DEVICE_QUALIFIER,
> +	.bcdUSB = cpu_to_le16(0x0200),
> +	.bDeviceClass = USB_CLASS_HUB,
> +	.bDeviceSubClass = 0,
> +	.bDeviceProtocol = 0,
> +	.bMaxPacketSize0 = 64,
> +	.bNumConfigurations = 1,
> +	.bRESERVED = 0,

Fields that are to be set to zero do not need to be set here, the
compiler does it for you.

thanks,

greg k-h
