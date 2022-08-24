Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A88459F33E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiHXF4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiHXF4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:56:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCCC86C2C;
        Tue, 23 Aug 2022 22:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D33C618A9;
        Wed, 24 Aug 2022 05:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9A4C433D6;
        Wed, 24 Aug 2022 05:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661320568;
        bh=/lQK6eSyHFmPY9FHfehXTuLBTlCtNaOLxFlDwPC1f/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zU3ILmUfSavbZXEmKsGu1fAYoww8AzQBdd3YPcnxApAGDxwTBCxdrIxAonCW6Hz5Z
         f9/C+zA/dIP1ip6oHBmKb0AgMm4uvnH0TonlVfIcZwYTSQI3ybgaKjm/bk1dV3yEm1
         lioqgCBJIpZuHvmqsTx7M1OVFG+pDfxJZZi+Cyp4=
Date:   Wed, 24 Aug 2022 07:56:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: ehci: Prevent possible modulo by zero
Message-ID: <YwW9dBW/0TKHPnC1@kroah.com>
References: <20220823182758.13401-1-khalid.masum.92@gmail.com>
 <20220823182758.13401-3-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823182758.13401-3-khalid.masum.92@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:27:58AM +0600, Khalid Masum wrote:
> usb_maxpacket() returns 0 if it fails to fetch the endpoint. This
> value is later used for calculating modulo. Which can cause modulo
> by zero in qtd_fill.
> 
> Prevent this breakage by returning if maxpacket is found to be 0.
> 
> Fixes coverity warning: 1487371 ("Division or modulo by zero")

Odd tag format, is that in the documentation?

> Fixes: 9841f37a1cca ("usb: ehci: Add support for SINGLE_STEP_SET_FEATURE test of EHSET")
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---
>  drivers/usb/host/ehci-q.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index eb31d13e9ecd..cf2585e9a09f 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -1221,6 +1221,8 @@ static int ehci_submit_single_step_set_feature(
>  	token |= (1 /* "in" */ << 8);  /*This is IN stage*/
>  
>  	maxpacket = usb_maxpacket(urb->dev, urb->pipe);
> +	if (unlikely(!maxpacket))

You only ever use likely/unlikely if you can document how it matters
with a benchmark or other way to notice the difference.  Otherwise let
the compiler and the CPU do their magic, they know how to do this better
than us.

> +		return -1;

A real error number should be returned here if this was valid.

But as Alan said, coverity is often wrong, and unless you can prove
otherwise, this patch isn't valid.

thanks,

greg k-h
