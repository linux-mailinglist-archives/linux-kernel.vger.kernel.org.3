Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845D546333F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhK3LvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241202AbhK3Lua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:50:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED318C0613E0;
        Tue, 30 Nov 2021 03:47:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 45286CE18B8;
        Tue, 30 Nov 2021 11:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4D0C58335;
        Tue, 30 Nov 2021 11:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638272827;
        bh=k9WyNYGgTV92Nf8EhsdK/4a7BRg1HEKvlaZQo0J87Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxreogXLDgZULP3/Us7kcZz2y+4YjJ9XPaqc2uhv0CZsWv+7HECN4Mdts51gr/0m0
         9scCdnf0PDmoOzK1M2iiwKGIiXcv93WAS3GEyw2eYG6ZqIllx62FIw6na+LuNwjxDF
         /sQtThqqZ3ebzLJFIHc4lGY3ONV+OxopKKvniy90=
Date:   Tue, 30 Nov 2021 12:47:04 +0100
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
Subject: Re: [PATCH v2 4/4] usb: aspeed-vhub: support test mode feature
Message-ID: <YaYPOAB3Anfhh5AA@kroah.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-5-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130104256.3106797-5-neal_liu@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 06:42:56PM +0800, Neal Liu wrote:
> Support aspeed usb vhub set feature to test mode.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c | 18 ++++++++++++++----
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c | 22 ++++++++++++++++------
>  2 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> index d918e8b2af3c..4462f4b73b04 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> @@ -110,15 +110,25 @@ static int ast_vhub_dev_feature(struct ast_vhub_dev *d,
>  				u16 wIndex, u16 wValue,
>  				bool is_set)
>  {
> +	u32 val;
> +
>  	DDBG(d, "%s_FEATURE(dev val=%02x)\n",
>  	     is_set ? "SET" : "CLEAR", wValue);
>  
> -	if (wValue != USB_DEVICE_REMOTE_WAKEUP)
> -		return std_req_driver;
> +	if (wValue == USB_DEVICE_REMOTE_WAKEUP) {
> +		d->wakeup_en = is_set;
> +		return std_req_complete;
>  
> -	d->wakeup_en = is_set;
> +	} else if (wValue == USB_DEVICE_TEST_MODE) {

If you return, no need for an else statement, right?


> +		val = readl(d->vhub->regs + AST_VHUB_CTRL);
> +		val &= ~GENMASK(10, 8);
> +		val |= VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
> +		writel(val, d->vhub->regs + AST_VHUB_CTRL);
>  
> -	return std_req_complete;
> +		return std_req_complete;
> +	}
> +
> +	return std_req_driver;
>  }
>  
>  static int ast_vhub_ep_feature(struct ast_vhub_dev *d,
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> index 93f27a745760..e52805fbdebd 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> @@ -212,17 +212,27 @@ static int ast_vhub_hub_dev_feature(struct ast_vhub_ep *ep,
>  				    u16 wIndex, u16 wValue,
>  				    bool is_set)
>  {
> +	u32 val;
> +
>  	EPDBG(ep, "%s_FEATURE(dev val=%02x)\n",
>  	      is_set ? "SET" : "CLEAR", wValue);
>  
> -	if (wValue != USB_DEVICE_REMOTE_WAKEUP)
> -		return std_req_stall;
> +	if (wValue == USB_DEVICE_REMOTE_WAKEUP) {
> +		ep->vhub->wakeup_en = is_set;
> +		EPDBG(ep, "Hub remote wakeup %s\n",
> +		      is_set ? "enabled" : "disabled");
> +		return std_req_complete;
>  
> -	ep->vhub->wakeup_en = is_set;
> -	EPDBG(ep, "Hub remote wakeup %s\n",
> -	      is_set ? "enabled" : "disabled");
> +	} else if (wValue == USB_DEVICE_TEST_MODE) {

Same here, no need for else.

thanks,

greg k-h
