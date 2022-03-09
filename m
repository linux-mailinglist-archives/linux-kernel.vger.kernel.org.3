Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40904D2DEA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiCIL0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiCIL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:26:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C1B155C3F;
        Wed,  9 Mar 2022 03:25:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80CA3617F3;
        Wed,  9 Mar 2022 11:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4A8C340E8;
        Wed,  9 Mar 2022 11:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646825106;
        bh=sasR7Z6YMt2BgPquYWI91P+JY8kGeqgt5cAKUKjR+xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWALhsXOjwlsoHoBcMvh0jNZYD3YsswFKfnQkNBoBINhErMNYl5S6VGB+c73b/OEC
         ae/EdfiVzazMilQFQfepLOz3vYqbIEo+rWQ0yKPzZoR7UnYjvRHGN8IHmlAoLgFJFd
         80ryLFo2eduN8dGLlHpHQ8NySoawyacXrzfFdNs0=
Date:   Wed, 9 Mar 2022 12:25:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Bin Liu <b-liu@ti.com>, Roger Quadros <rogerq@ti.com>,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: musb: Fix missing of_node_put() in omap2430_probe
Message-ID: <YiiOj3n3ocUr+/68@kroah.com>
References: <20220309111033.24487-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309111033.24487-1-linmq006@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 11:10:33AM +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle() with refcount
> incremented. We should use of_node_put() on it when done.
> 
> Fixes: 8934d3e4d0e7 ("usb: musb: omap2430: Don't use omap_get_control_dev()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/usb/musb/omap2430.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 7d4d0713f4f0..4a963cfa385b 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -363,6 +363,7 @@ static int omap2430_probe(struct platform_device *pdev)
>  	control_node = of_parse_phandle(np, "ctrl-module", 0);
>  	if (control_node) {
>  		control_pdev = of_find_device_by_node(control_node);
> +		of_node_put(control_node);
>  		if (!control_pdev) {
>  			dev_err(&pdev->dev, "Failed to get control device\n");
>  			ret = -EINVAL;
> -- 
> 2.17.1
> 

How was this tested?
