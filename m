Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6571446DF49
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbhLIAO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:14:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:42469 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238478AbhLIAO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:14:28 -0500
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1B905TbW017335;
        Wed, 8 Dec 2021 18:05:29 -0600
Message-ID: <391323f136e49387797d43e89b6e42cd95d916c2.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
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
Date:   Thu, 09 Dec 2021 11:05:28 +1100
In-Reply-To: <20211208100545.1441397-3-neal_liu@aspeedtech.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
         <20211208100545.1441397-3-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-08 at 18:05 +0800, Neal Liu wrote:
> Signaling remote wakeup if an emulated USB device has any activity
> if the device is allowed by host.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>

I still think it should fundamentally be the device making that
decision, but since they don't, this is an acceptable workaround, but
please, don't write the MMIO on every EP queue. Either keep track of
the bus being suspended, or turn on the AUTO bit in HW when wakeup_en
is set.

Cheers,
Ben.

> ---
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> index 917892ca8753..ccc239b5cc17 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> @@ -381,6 +381,11 @@ static int ast_vhub_epn_queue(struct usb_ep*
> u_ep, struct usb_request *u_req,
>  	} else
>  		u_req->dma = 0;
>  
> +	if (ep->dev->wakeup_en) {
> +		EPVDBG(ep, "Wakeup host first\n");
> +		ast_vhub_hub_wake_all(vhub);
> +	}
> +
>  	EPVDBG(ep, "enqueue req @%p\n", req);
>  	EPVDBG(ep, " l=%d dma=0x%x zero=%d noshort=%d noirq=%d
> is_in=%d\n",
>  	       u_req->length, (u32)u_req->dma, u_req->zero,

