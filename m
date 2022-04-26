Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B050FC50
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349695AbiDZL4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiDZL4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D83B6D39A;
        Tue, 26 Apr 2022 04:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 070916186D;
        Tue, 26 Apr 2022 11:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C70C385A0;
        Tue, 26 Apr 2022 11:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650974011;
        bh=vbRFHZtcwvwTjgdhuYSzAB1yYcFtySkuikWZHadHkaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wk0BcTiQAIjrgozwm93JCO7qFrC5EN2AYwWtAcTBma2T4GGVm2nXqVr6JYzoWySWw
         ETfF0eWgE2yvxGOcYzb5MqR9ENAqij/1mQ7AWXc773di2cAPXKkBL5xWrzc+P2RAgb
         GHhoJUP2XYReluVfpWq0Z6VRuRl5Dij9+2M9XSpE=
Date:   Tue, 26 Apr 2022 13:53:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Surong Pang <surong.pang@gmail.com>
Cc:     mathias.nyman@linux.intel.com, mathias.nyman@intel.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Orson.Zhai@unisoc.com, yunguo.wu@unisoc.com
Subject: Re: [PATCH V2] usb/host: Let usb phy shutdown later
Message-ID: <YmfdN97xtmwSOo59@kroah.com>
References: <e05ec742-c3dc-df7c-c5d7-29358d0a7081@linux.intel.com>
 <20220424015757.21993-1-surong.pang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424015757.21993-1-surong.pang@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 09:57:57AM +0800, Surong Pang wrote:
> From: Surong Pang <surong.pang@unisoc.com>
> 
> Let usb phy shutdown later in xhci_plat_remove function.
> Some phy driver doesn't divide 3.0/2.0 very clear.
> If calls usb_phy_shutdown earlier than usb_remove_hcd(hcd),
> It will case 10s cmd timeout issue.
> 
> Call usb phy shutdown later has better compatibility.
> 
> Signed-off-by: Surong Pang <surong.pang@unisoc.com>

The subject should say "xhci-plat", right?

> ---
>  drivers/usb/host/xhci-plat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 649ffd861b44..fe492ed99cb7 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -390,13 +390,13 @@ static int xhci_plat_remove(struct platform_device *dev)
>  
>  	usb_remove_hcd(shared_hcd);
>  	xhci->shared_hcd = NULL;
> -	usb_phy_shutdown(hcd->usb_phy);
>  
>  	usb_remove_hcd(hcd);
>  	usb_put_hcd(shared_hcd);
>  
>  	clk_disable_unprepare(clk);
>  	clk_disable_unprepare(reg_clk);
> +	usb_phy_shutdown(hcd->usb_phy);
>  	usb_put_hcd(hcd);

Does this fix a specific commit id?

thanks,

greg k-h
