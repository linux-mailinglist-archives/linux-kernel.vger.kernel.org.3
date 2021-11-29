Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC14628AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhK2X5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:57:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:58760 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhK2X5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:57:36 -0500
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1ATNmnMv025112;
        Mon, 29 Nov 2021 17:48:49 -0600
Message-ID: <12cf11dc4326922ceb67ede7b63a53fe1840b6fd.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/3] usb: aspeed-vhub: fix ep0 OUT ack received wrong
 length issue
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
Date:   Tue, 30 Nov 2021 10:48:48 +1100
In-Reply-To: <20211126110954.2677627-4-neal_liu@aspeedtech.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
         <20211126110954.2677627-4-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-11-26 at 19:09 +0800, Neal Liu wrote:
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> index 74ea36c19b1e..bea9cbb191a2 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> @@ -251,6 +251,13 @@ static void ast_vhub_ep0_do_receive(struct
> ast_vhub_ep *ep, struct ast_vhub_req
>  		len = remain;
>  		rc = -EOVERFLOW;
>  	}
> +
> +	/* HW return wrong data len */
> +	if (len < ep->ep.maxpacket && len != remain) {
> +		EPDBG(ep, "using expected data len instead\n");
> +		len = remain;
> +	}
> +

Wow, that is a nasty hw bug ! Patch looks good, I had to swap some of
that logic back into my brain but it looks like it won't break any
normal case :-)

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.

