Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B273C539D70
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343579AbiFAGvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244719AbiFAGvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:51:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B1C95A0F;
        Tue, 31 May 2022 23:51:09 -0700 (PDT)
Received: from pendragon.ideasonboard.com (lmontsouris-659-1-41-236.w92-154.abo.wanadoo.fr [92.154.76.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0AF256D1;
        Wed,  1 Jun 2022 08:51:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654066264;
        bh=I9ZmOGhYwlPu5Iw2LmEOgB3rLqHYXy5EaidCJYy1YSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jq97zO5uG0N8y3cg/druowOs8wOH2M8i2drfRBZtwxsTbvzANwqAl6UlvbQgRMg9f
         muk8GUR/fncZ6UL6XQA+dD3ekVnmvLBV3zrZqMtx8iJiDgXDe84nUDkBwS15mkw9ZI
         tC7fxk32bqI5DQGFK4MFG2m52PeE0lfYEdU7Deug=
Date:   Wed, 1 Jun 2022 09:50:59 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Fix refcount leak in omapdss_init_of
Message-ID: <YpcMU9o8w/zoDE+J@pendragon.ideasonboard.com>
References: <20220601044858.3352-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601044858.3352-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lin,

Thank you for the patch.

On Wed, Jun 01, 2022 at 08:48:58AM +0400, Miaoqian Lin wrote:
> omapdss_find_dss_of_node() calls of_find_compatible_node() to get device
> node. of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() in later error path and normal path.
> 
> Fixes: e0c827aca0730 ("drm/omap: Populate DSS children in omapdss driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/mach-omap2/display.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index 21413a9b7b6c..ed2cb2649cf6 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -259,11 +259,13 @@ static int __init omapdss_init_of(void)
>  
>  	if (!pdev) {
>  		pr_err("Unable to find DSS platform device\n");
> +		of_node_put(node);
>  		return -ENODEV;
>  	}
>  
>  	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
>  	put_device(&pdev->dev);
> +	of_node_put(node);
>  	if (r) {
>  		pr_err("Unable to populate DSS submodule devices\n");
>  		return r;

-- 
Regards,

Laurent Pinchart
