Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FABB52D9CA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiESQH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiESQHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:07:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAE62FFC7;
        Thu, 19 May 2022 09:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EED5661BBA;
        Thu, 19 May 2022 16:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B5EC385AA;
        Thu, 19 May 2022 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652976440;
        bh=B1fYf54IjPeGalvH3CwBhG+qqjZDzVXczaHOH9KQrZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spOKlQjtYPG0EV9EIHDLlamGD5yCnUK+Jnxc5dKHlwKCODS1ivCVqJyQKx7K4HOgh
         WFKg0EFtBk0EuTJ8GKhKALyPB5TWo3aDGnJGauUMhdwP0QXN7tqlrPsUlyugtS4EdF
         5EkdjPTrPJQmf3ArYA9bdOMzAfaqx0PD8CgBhP3Y=
Date:   Thu, 19 May 2022 18:07:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, felipe.balbi@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuyq@stu.pku.edu.cn
Subject: Re: [PATCH] usb: cdns3:  Fix potential dereference of NULL pointer
Message-ID: <YoZrNRf5W4hLdy9N@kroah.com>
References: <1652861570-102489-1-git-send-email-lyz_cs@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652861570-102489-1-git-send-email-lyz_cs@pku.edu.cn>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:12:50AM -0700, Yongzhi Liu wrote:
> The return value of cdns3_gadget_ep_alloc_request()
> needs to be checked to avoid use of NULL pointer
> in case of an allocation failure.
> 
> Fixes: 7733f6c32e36f ("usb: cdns3: Add Cadence USB3 DRD Driver")
> 
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>

Again, no blank line and use the full width for your text.

> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 5d8c982..7be328e 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -2568,6 +2568,10 @@ static int cdns3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
>  		struct cdns3_request *priv_req;
>  
>  		zlp_request = cdns3_gadget_ep_alloc_request(ep, GFP_ATOMIC);
> +		if (!zlp_request) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}

How did you test this that the if the allocation fails this will clean
up properly?

thanks,

greg k-h
