Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03DD576DC1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 14:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiGPMPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 08:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGPMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 08:15:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E31EC53;
        Sat, 16 Jul 2022 05:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A2BC60FC3;
        Sat, 16 Jul 2022 12:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E99C34115;
        Sat, 16 Jul 2022 12:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657973702;
        bh=I60693levZgEbb4nb1eqggLV2fzh5jOMm8Vl/zFKeKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2SAJ2Rq3xmZyuA+a0uaSo681naNkNP8WHOxCem+kY3GVjH5LMFA/hOWkk1vI3lie
         POGuD21vCRXxNVY/dfbc/ot6SOJFl65MD8ol4rlHDiFlovhJQJW0WWp4AgqfTRHgBe
         DEQzYYHw1HMVIC3Pzq33fBAlDiosfSDO94uPyOMXsVZf4xHG8Y9qsHBtK0KOf0JBnW
         pVbAZ8Zi2FuV1MCPIlh4thqU78iwR/x5779qK/t2s/d+KrtiARLf9EgITU23gUa2Bp
         TtQitS1J0C9r/xZ7x/ftezQj0Z3UfPsI1BK1yWW0ntvlJpV5z/cRHltSJEJsqbckht
         Mf0skPURxJ/sg==
Date:   Sat, 16 Jul 2022 20:14:56 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: removed useless condition in
 cdns3_gadget_ep_dequeue()
Message-ID: <20220716121456.GA238342@nchen-desktop>
References: <20220711151032.16825-1-strochuk@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711151032.16825-1-strochuk@ispras.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-11 18:10:32, Andrey Strachuk wrote:
> Comparison of 'ep' with NULL is useless since
> 'ep' is a result of container_of and cannot be NULL
> in any reasonable scenario.
> 

If ep is NULL, the container_of(NULL, struct cdns3_endpoint,
endpoint) will not cause panic, but later ep->desc will cause panic.
So we can't delete the NULL check for ep.

Peter

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> Fixes: 64b558f597d1 ("usb: cdns3: Change file names for cdns3 driver.")
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 5c15c48952a6..f31b389ae0b2 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -2608,7 +2608,7 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
>  	unsigned long flags;
>  	int ret = 0;
>  
> -	if (!ep || !request || !ep->desc)
> +	if (!request || !ep->desc)
>  		return -EINVAL;
>  
>  	spin_lock_irqsave(&priv_dev->lock, flags);
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen
