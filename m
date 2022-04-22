Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B405C50B7D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447688AbiDVNC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447698AbiDVNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:02:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A4257B20;
        Fri, 22 Apr 2022 05:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E656204F;
        Fri, 22 Apr 2022 12:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AEEC385A4;
        Fri, 22 Apr 2022 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650632372;
        bh=2xBTNPyOFSDAnCTOxF45zEU4uV1O5Nj2T7kJtpwY7xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xi6xSvBE+MFqJSwDeEs374dorQ8uFq8KauulbuJc/jz3ADbihejxlUPopJ/7p5/TO
         rhm6T0Pi0yfjwx3gie42DxXaj+rhpd+fFttAo45O2dQP6rVNBgQSmtofl4aejr5+ie
         jR61iQ2B6j+l1KonueGR5vFZhHE+Am2A3GRqc5uQ=
Date:   Fri, 22 Apr 2022 14:59:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     balbi@kernel.org, michal.simek@xilinx.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc-xilinx: remove unnecessary
 initialization of list iterator
Message-ID: <YmKmscbVVZazEkoh@kroah.com>
References: <20220316075153.3708-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316075153.3708-1-xiam0nd.tong@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 03:51:53PM +0800, Xiaomeng Tong wrote:
> 'req' will always be set by the subsequent list_for_each_entry()
> before any uses. Thus, to avoid ambiguity it is better to remove
> the unnecessary initialization of list iterator 'req'.
> 
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  drivers/usb/gadget/udc/udc-xilinx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
> index 6ce886fb7..fa6cbfc63 100644
> --- a/drivers/usb/gadget/udc/udc-xilinx.c
> +++ b/drivers/usb/gadget/udc/udc-xilinx.c
> @@ -1136,7 +1136,7 @@ static int xudc_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
>  static int xudc_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  {
>  	struct xusb_ep *ep	= to_xusb_ep(_ep);
> -	struct xusb_req *req	= to_xusb_req(_req);
> +	struct xusb_req *req;
>  	struct xusb_udc *udc	= ep->udc;
>  	unsigned long flags;
>  
> -- 
> 2.17.1
> 

Does not apply anymore :(
