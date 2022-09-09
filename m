Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0366E5B2E2E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIIFiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIIFiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:38:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C63936DD3;
        Thu,  8 Sep 2022 22:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE804B8206F;
        Fri,  9 Sep 2022 05:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA288C433D6;
        Fri,  9 Sep 2022 05:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662701890;
        bh=cbms7GFzG5wvr0w5mregGfshUDlVU/XWxaQF7S4pzYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHkD7ZuErSo5TBdq6ZehyZ9QKa0M9hy+q/CqXtIBFFuYR+3xdBGYrkbXWR4zVCupv
         OqIHpB/8B2jHtMWxfEiQrNzSdSCW8Y5HoP6OYddmldJ98dpYdB9OQRXyKEPo456png
         hr7HgM61b0pePvkNz7ranWnhfdf1/wb2+aKgPYYA=
Date:   Fri, 9 Sep 2022 07:38:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aniruddha TVS Rao <anrao@nvidia.com>
Subject: Re: [PATCH] usb: gadget: rndis: Avoid dereference before NULL check
Message-ID: <YxrRPxeh/iCeCW4R@kroah.com>
References: <20220908175615.5095-1-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908175615.5095-1-jilin@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 01:56:15AM +0800, Jim Lin wrote:
> NULL check is performed after params->dev is dereferenced in
> dev_get_stats.

I do not understand this statement.

> Fixed by adding a NULL check before dereferencing params->dev and
> removing subsequent NULL checks for it.
> 
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
>  drivers/usb/gadget/function/rndis.c | 37 ++++++++++++-----------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
> index 64de9f1b874c..d2f18f34c8e5 100644
> --- a/drivers/usb/gadget/function/rndis.c
> +++ b/drivers/usb/gadget/function/rndis.c
> @@ -198,6 +198,9 @@ static int gen_ndis_query_resp(struct rndis_params *params, u32 OID, u8 *buf,
>  	outbuf = (__le32 *)&resp[1];
>  	resp->InformationBufferOffset = cpu_to_le32(16);
>  
> +	if (!params->dev)
> +		return -ENODEV;
> +

As Sergey points out, this check is useless and the ones below should
also be removed.

But, why make this check at all, how did you trigger a problem with the
current code?

Are you using this driver?  If so, why?  It is totally broken (as per
the specification) and we really really need to just delete it from the
tree to prevent anyone else from ever using it.

thanks,

greg k-h
