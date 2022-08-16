Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C91595DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiHPNx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiHPNxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:53:54 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C90A5266F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:53:53 -0700 (PDT)
Received: (qmail 129095 invoked by uid 1000); 16 Aug 2022 09:53:53 -0400
Date:   Tue, 16 Aug 2022 09:53:53 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ray Chi <raychi@google.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        badhri@google.com, albertccwang@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: core: add a hook to check port init status
Message-ID: <YvuhcUx9R8Rdyfr4@rowland.harvard.edu>
References: <20220816083854.1491886-1-raychi@google.com>
 <20220816083854.1491886-2-raychi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816083854.1491886-2-raychi@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:38:53PM +0800, Ray Chi wrote:
> This patch add a hook to check the port init status. Currently, only
> usbcore knows port init status even if the result is bad. It will cause
> a USB host keep doing USB enumeration for a long time when the USB host
> connects to a broken USB accessory.
> 
> The hc_driver could use the hook to know port init status and do possible
> error handling according to platform requirements or limitations.
> 
> Signed-off-by: Ray Chi <raychi@google.com>
> ---
>  drivers/usb/core/hub.c  | 14 ++++++++++++++
>  include/linux/usb/hcd.h |  8 ++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 2633acde7ac1..6ce6092816cb 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c

> @@ -4855,6 +4865,10 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
>  					buf->bMaxPacketSize0;
>  			kfree(buf);
>  
> +			retval = hub_port_check_init_status(udev, r);
> +			if (retval < 0)
> +				goto fail;

For future reference, you should be aware that this code won't get 
executed if do_new_scheme is false.

Alan Stern
