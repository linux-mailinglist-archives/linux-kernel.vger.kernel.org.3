Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9B746288D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhK2XvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:51:02 -0500
Received: from gate.crashing.org ([63.228.1.57]:34567 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhK2XvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:51:01 -0500
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1ATNf0UG024811;
        Mon, 29 Nov 2021 17:41:01 -0600
Message-ID: <84b2d2c6b530d0a3a9b86b0ffcbfa70935bdb0a9.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/3] usb: aspeed-vhub: add qualifier descriptor
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
Date:   Tue, 30 Nov 2021 10:40:59 +1100
In-Reply-To: <20211126110954.2677627-2-neal_liu@aspeedtech.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
         <20211126110954.2677627-2-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-11-26 at 19:09 +0800, Neal Liu wrote:
> 
> @@ -417,10 +435,9 @@ enum std_req_rc ast_vhub_std_hub_request(struct ast_vhub_ep *ep,
>  
>  		/* GET/SET_CONFIGURATION */
>  	case DeviceRequest | USB_REQ_GET_CONFIGURATION:
> -		return ast_vhub_simple_reply(ep, 1);
> +		return ast_vhub_simple_reply(ep, vhub->current_config);
>  	case DeviceOutRequest | USB_REQ_SET_CONFIGURATION:
> -		if (wValue != 1)
> -			return std_req_stall;
> +		vhub->current_config = wValue;
>  		return std_req_complete;

This is odd.. why should we support arbitrary SET_CONFIGURATION for
configs we don't support ?

Otherwise looks good.

Cheers,
Ben.


