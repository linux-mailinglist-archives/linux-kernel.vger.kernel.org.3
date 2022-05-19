Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9176852D9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbiESP75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiESP7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:59:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD6F9E9E2;
        Thu, 19 May 2022 08:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7B67FCE25D9;
        Thu, 19 May 2022 15:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6937EC385AA;
        Thu, 19 May 2022 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652975988;
        bh=8nwqZ3h0TtcSyftFuwGKZD0+/DFI3JpFngKKV0LgKSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jz4f0sdeb4IlP9nc8naFEP1UTMKeNsxRSbr5DOb22WyLxuRzqzU2D3WLJvAuiHGy1
         /08FBhmSb8OyavxHwzaTnShmLoa8exmJACyIlDO4DP6a6HwXcdU6P3hoz0KBrMbo/z
         8LoWgIFQHkUItaxr6TTJX4elRERwMyd4d8iW7dcE=
Date:   Thu, 19 May 2022 17:59:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kushagra Verma <kushagra765@outlook.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB / dwc3: remove the use of -ENOSYS from core.c
Message-ID: <YoZpcqDCwoXIvI5q@kroah.com>
References: <HK0PR01MB280106E1D78EF51A5B8ED8BFF8CE9@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR01MB280106E1D78EF51A5B8ED8BFF8CE9@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 08:22:00PM +0530, Kushagra Verma wrote:
> This patch removes the use of -ENOSYS as it is used when users try to call a
> syscall that doesn't exist. So, we don't need to check if 'ret == -ENOSYS'.

ENOSYS is also used internally in the kernel for other things.

> 
> Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
> ---
>  drivers/usb/dwc3/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index c78205c5e19f..3c1a877d5183 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1283,7 +1283,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>  	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
>  	if (IS_ERR(dwc->usb2_generic_phy)) {
>  		ret = PTR_ERR(dwc->usb2_generic_phy);
> -		if (ret == -ENOSYS || ret == -ENODEV)
> +		if (ret == -ENODEV)

Did you validate that no callers can ever set this to ENOSYS?

Why was this added in the first place?  What commit added it?

thanks,

greg k-h
