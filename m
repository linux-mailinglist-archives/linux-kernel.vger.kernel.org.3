Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE1D4CBE24
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiCCMtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiCCMtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:49:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FD51480F2;
        Thu,  3 Mar 2022 04:48:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5C63B8250F;
        Thu,  3 Mar 2022 12:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB2FC004E1;
        Thu,  3 Mar 2022 12:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646311723;
        bh=sBUKb3Vypbz6Qdrb2/AV351kXRloHaYr0DX+EqMWKHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0ZLJIAN4yA1/fjRLuXtytjtHgFy0HJsGAYfN6CMtEfOMd2WhfNRz0wpr1e5axskW
         Mk7styFJ8rQi4LSaYzyHCXVulUmdMnXDuFxOC8ma9rAJcvJeS1RcuZNSAZZhj5qsiG
         9PEkmrlJupx+MzFQEwBhkU4sftQxqwd3I0XbDuauvRGsIxZviVeeLdPZzy/qE8feEs
         Ze6/6PGkHxi/T47bFuFq/b3yk/p9tLK2/ANCftImn/1HG/DqMBtbeXs5bR8ymuCuB/
         iiHVPKrmlal5F+b6/Q86UWG9ETbbFYu1nmz99OhuYyUeXh02Sqm6KW5gOa33iSWP94
         z7CJ/ADcKQmYg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nPksr-0008Hd-5z; Thu, 03 Mar 2022 13:48:41 +0100
Date:   Thu, 3 Mar 2022 13:48:41 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] USB: serial: garmin_gps: Use struct_size() and
 flex_array_size() helpers in pkt_add()
Message-ID: <YiC5KeDM9xJIXi0t@hovoldconsulting.com>
References: <20220120005512.GA72984@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120005512.GA72984@embeddedor>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:55:12PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() and flex_array_size() helpers instead of
> an open-coded version, in order to avoid any potential type mistakes
> or integer overflows that, in the worst scenario, could lead to heap
> overflows.

This motivation doesn't seem to apply to flex_array_size() here.
 
> Also, address the following sparse warnings:
> drivers/usb/serial/garmin_gps.c:270:31: warning: using sizeof on a flexible structure

And this is bogus since the warning is not enabled by default (for a
reason) and would still there with this patch applied since
struct_size() relies on sizeof().

> Link: https://github.com/KSPP/linux/issues/160
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/usb/serial/garmin_gps.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
> index e5c75944ebb7..1d806c108efb 100644
> --- a/drivers/usb/serial/garmin_gps.c
> +++ b/drivers/usb/serial/garmin_gps.c
> @@ -267,13 +267,12 @@ static int pkt_add(struct garmin_data *garmin_data_p,
>  
>  	/* process only packets containing data ... */
>  	if (data_length) {
> -		pkt = kmalloc(sizeof(struct garmin_packet)+data_length,
> -								GFP_ATOMIC);
> +		pkt = kmalloc(struct_size(pkt, data, data_length), GFP_ATOMIC);

This bit is ok and would cause kmalloc() to fail also if data_length is
ever close to UINT_MAX.

>  		if (!pkt)
>  			return 0;
>  
>  		pkt->size = data_length;
> -		memcpy(pkt->data, data, data_length);
> +		memcpy(pkt->data, data, flex_array_size(pkt, data, pkt->size));

But I fail to see the point in using flex_array_size() when dealing with
byte arrays. It just makes the code harder to read without any benefit.

First of all, we're dealing with a byte array so flex_array_size() will
never saturate. And even if it did, we'd still overflow whatever buffer
we're copying to.

And if the type of pkt->data were to change to a larger one for some
reason, then using flex_array_size() could even be harmful and result in
information leaks.

>  		spin_lock_irqsave(&garmin_data_p->lock, flags);
>  		garmin_data_p->flags |= FLAGS_QUEUING;

Johan
