Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C11750FB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349388AbiDZKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349344AbiDZKuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:50:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8A254F9B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E4FCB81D2C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25117C385A0;
        Tue, 26 Apr 2022 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650970013;
        bh=ebY/+/pigrgRUdbBV6C1hDE8PF2Rwpv8OgEzY37reaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ux0FdlSlaru2e2HzG3SQut49DRnwze94TQveHAt+Q9g7d3wB43RtDkULcmA/4yWOT
         Zi+0/xCKR4yopjIYqkPHl7jkJTHVYhXHQEMAJksmCKOn7W71ARkM+TA98aSMbw2pT4
         lG92e4aTmcx0F0r/jcp9RW/UGKa+wfi54hyXBAmc=
Date:   Tue, 26 Apr 2022 12:46:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] platform: finally disallow IRQ0 in platform_get_irq()
 and its ilk
Message-ID: <YmfNi3j/sL9PdByv@kroah.com>
References: <025679e1-1f0a-ae4b-4369-01164f691511@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025679e1-1f0a-ae4b-4369-01164f691511@omp.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 10:35:29PM +0300, Sergey Shtylyov wrote:
> The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
> invalid") only calls WARN() when IRQ0 is about to be returned, however
> using IRQ0 is considered invalid (according to Linus) outside the arch/
> code where it's used by the i8253 drivers. Many driver subsystems treat
> 0 specially (e.g. as an indication of the polling mode by libata), so
> the users of platform_get_irq[_byname]() in them would have to filter
> out IRQ0 explicitly and this (quite obviously) doesn't scale...
> Let's finally get this straight and return -EINVAL instead of IRQ0!
> 
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> ---
> The patch is against the 'driver-core-next' branch of Greg Kroah-Hartman's
> 'driver-core.git' repo.
> 
> Changes in version 2:
> - added Marc's ACK.
> 
>  drivers/base/platform.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: driver-core/drivers/base/platform.c
> ===================================================================
> --- driver-core.orig/drivers/base/platform.c
> +++ driver-core/drivers/base/platform.c
> @@ -231,7 +231,8 @@ int platform_get_irq_optional(struct pla
>  out_not_found:
>  	ret = -ENXIO;
>  out:
> -	WARN(ret == 0, "0 is an invalid IRQ number\n");
> +	if (WARN(!ret, "0 is an invalid IRQ number\n"))
> +		return -EINVAL;
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq_optional);
> @@ -446,7 +447,8 @@ static int __platform_get_irq_byname(str
>  
>  	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
>  	if (r) {
> -		WARN(r->start == 0, "0 is an invalid IRQ number\n");
> +		if (WARN(!r->start, "0 is an invalid IRQ number\n"))
> +			return -EINVAL;
>  		return r->start;
>  	}
>  

Ok, let's try this now.  Worst case, we revert it later :)

thanks,

greg k-h
