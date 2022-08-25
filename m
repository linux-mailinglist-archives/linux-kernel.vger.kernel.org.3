Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D965A1355
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbiHYOUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbiHYOT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:19:27 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0340BAE9D3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:19:26 -0700 (PDT)
Received: (qmail 2307 invoked by uid 1000); 25 Aug 2022 10:19:26 -0400
Date:   Thu, 25 Aug 2022 10:19:26 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Matthias Kaehlcke <mka@chromium.org>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: host: Initiate urb ep with udev ep0
Message-ID: <YweE7jCfGDhLB16G@rowland.harvard.edu>
References: <20220824203107.14908-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824203107.14908-1-khalid.masum.92@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 02:31:07AM +0600, Khalid Masum wrote:
> Currently we look up for endpoint in a table and initate urb endpoint
> with it. This is unnecessary because the lookup will always result in
> endpoint 0.
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---
> Changes since v1:
>  - Remove endpoint lookup and NULL check
>  - Remove unnecessary variable *ep
>  - Initiate urb ep with udev ep0
>  - Update commit message
>  - v1 Link: https://lore.kernel.org/lkml/20220824130702.10912-1-khalid.masum.92@gmail.com/ 
> 
>  drivers/usb/core/hcd.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 94b305bbd621..05f30ae5570b 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2158,21 +2158,14 @@ static struct urb *request_single_step_set_feature_urb(
>  {
>  	struct urb *urb;
>  	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
> -	struct usb_host_endpoint *ep;
>  
>  	urb = usb_alloc_urb(0, GFP_KERNEL);
>  	if (!urb)
>  		return NULL;
>  
>  	urb->pipe = usb_rcvctrlpipe(udev, 0);
> -	ep = (usb_pipein(urb->pipe) ? udev->ep_in : udev->ep_out)
> -				[usb_pipeendpoint(urb->pipe)];
> -	if (!ep) {
> -		usb_free_urb(urb);
> -		return NULL;
> -	}
>  
> -	urb->ep = ep;
> +	urb->ep = &udev->ep0;
>  	urb->dev = udev;
>  	urb->setup_packet = (void *)dr;
>  	urb->transfer_buffer = buf;

Acked-by: Alan Stern <stern@rowland.harvard.edu>
