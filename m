Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34CA582249
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiG0IkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG0IkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:40:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32435459B3;
        Wed, 27 Jul 2022 01:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8AC1B81F86;
        Wed, 27 Jul 2022 08:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7E5C433D6;
        Wed, 27 Jul 2022 08:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658911202;
        bh=tIWFLtMJyA0WvBIj310rvSlNj7MTChe0+yS1av3aX5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFavDORN53dDQcWjAsJD6akPrDEgQ9XP5Y1+JAlzxwS+VHZzphAMfQawE4QcfuaJ3
         yN0AQvnCZYiOw8+NoGmkB33QMfDN5VvAwAxdJZKSyjNSnZh8q5k/vxSHhKUKri2Ywr
         5xsDcwVXZRo7ppOQxU7c+I67oSPxDI2wNFfs4205iTjWPLSWZ5rnFcA2aYyq+UE0MU
         evCpgbqMFd32YKoGkUuRk3Hz+BIM+8SeDDJvvn7CUu91mtRaYe9dAK8cyxrTte232E
         VEoUk/fUzbCkM9S87to5mkJ3wXlGAOv7GYnnrWiUVZ72idHrxrPY8LgcRAeG05bLIf
         AVG7Oju1zSXjA==
Date:   Wed, 27 Jul 2022 16:39:56 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH v2] usb: cdns3: change place of 'priv_ep' assignment in
 cdns3_gadget_ep_dequeue(), cdns3_gadget_ep_enable()
Message-ID: <20220727083956.GA269370@nchen-desktop>
References: <20220718160052.4188-1-strochuk@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718160052.4188-1-strochuk@ispras.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-18 19:00:52, Andrey Strachuk wrote:
> If 'ep' is NULL, result of ep_to_cdns3_ep(ep) is invalid pointer
> and its dereference with priv_ep->cdns3_dev may cause panic.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 5c15c48952a6..aea5db0ec72d 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -2285,13 +2285,14 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
>  	int val;
> 
>  	priv_ep = ep_to_cdns3_ep(ep);
> -	priv_dev = priv_ep->cdns3_dev;
> -	comp_desc = priv_ep->endpoint.comp_desc;
>  
>  	if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
>  		dev_dbg(priv_dev->dev, "usbss: invalid parameters\n");
>  		return -EINVAL;
>  	}
> +
> +	comp_desc = priv_ep->endpoint.comp_desc;
> +	priv_dev = priv_ep->cdns3_dev;
> 
>  	if (!desc->wMaxPacketSize) {
>  		dev_err(priv_dev->dev, "usbss: missing wMaxPacketSize\n");
> @@ -2600,7 +2601,7 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
>  			    struct usb_request *request)
>  {
>  	struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
> -	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +	struct cdns3_device *priv_dev;
>  	struct usb_request *req, *req_temp;
>  	struct cdns3_request *priv_req;
>  	struct cdns3_trb *link_trb;
> @@ -2610,6 +2611,8 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
>  
>  	if (!ep || !request || !ep->desc)
>  		return -EINVAL;
> +
> +	priv_dev = priv_ep->cdns3_dev;
> 
>  	spin_lock_irqsave(&priv_dev->lock, flags);
> 
> -- 

Acked-by: Peter Chen <peter.chen@kernel.org>

-- 

Thanks,
Peter Chen
