Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C8746DF4E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbhLIAPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:15:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:42476 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241385AbhLIAPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:15:06 -0500
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1B9060E7017366;
        Wed, 8 Dec 2021 18:06:01 -0600
Message-ID: <9290cfc85fbb857f55ff297e482b06d96c807f1a.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 4/4] usb: aspeed-vhub: support test mode feature
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Cc:     BMC-SW@aspeedtech.com
Date:   Thu, 09 Dec 2021 11:06:00 +1100
In-Reply-To: <20211208100545.1441397-5-neal_liu@aspeedtech.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
         <20211208100545.1441397-5-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-08 at 18:05 +0800, Neal Liu wrote:
> Support aspeed usb vhub set feature to test mode.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c | 19 +++++++++++++++----
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c | 23 +++++++++++++++++-----
> -
>  2 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> index d918e8b2af3c..b0dfca43fbdc 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> @@ -110,15 +110,26 @@ static int ast_vhub_dev_feature(struct
> ast_vhub_dev *d,
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
> +	}
>  
> -	d->wakeup_en = is_set;
> +	if (wValue == USB_DEVICE_TEST_MODE) {
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
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> index 93f27a745760..65cd4e46f031 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> @@ -212,17 +212,28 @@ static int ast_vhub_hub_dev_feature(struct
> ast_vhub_ep *ep,
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
> +	}
>  
> -	ep->vhub->wakeup_en = is_set;
> -	EPDBG(ep, "Hub remote wakeup %s\n",
> -	      is_set ? "enabled" : "disabled");
> +	if (wValue == USB_DEVICE_TEST_MODE) {
> +		val = readl(ep->vhub->regs + AST_VHUB_CTRL);
> +		val &= ~GENMASK(10, 8);
> +		val |= VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
> +		writel(val, ep->vhub->regs + AST_VHUB_CTRL);
>  
> -	return std_req_complete;
> +		return std_req_complete;
> +	}
> +
> +	return std_req_stall;
>  }
>  
>  static int ast_vhub_hub_ep_feature(struct ast_vhub_ep *ep,

