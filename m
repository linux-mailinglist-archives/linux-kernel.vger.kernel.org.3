Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D28539E4B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350326AbiFAHeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbiFAHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:34:30 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377C5712D8;
        Wed,  1 Jun 2022 00:34:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (lmontsouris-659-1-41-236.w92-154.abo.wanadoo.fr [92.154.76.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C97C6D1;
        Wed,  1 Jun 2022 09:34:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654068867;
        bh=LSmcQuI3jEWMS6JTLThQMDkjOJsgG4H2onu8Xq7U+5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJ0EOR9F0ZtkgJzZhBapc0/H18KI8HSuG3Ax375crZw5beOTwriCy1EXG81j/q+gc
         oxZUbUH8T2BXTkDzDKxyguoXfeA8ZCJps7j+0mvd3CWGnlhRdwtCA8XAilY3ts5kx1
         6zyBYMPQBcLscs61M9ugIPGiKJhrBrHzasW0LjcQ=
Date:   Wed, 1 Jun 2022 10:34:23 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v4l: xilinx-vipp: Fix refcount leak in
 xvip_graph_dma_init
Message-ID: <YpcWf46fAJcfIgIt@pendragon.ideasonboard.com>
References: <20220601042514.61780-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601042514.61780-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lin,

Thank you for the patch.

On Wed, Jun 01, 2022 at 08:25:14AM +0400, Miaoqian Lin wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: df3305156f98 ("[media] v4l: xilinx: Add Xilinx Video IP core")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/media/platform/xilinx/xilinx-vipp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/xilinx/xilinx-vipp.c b/drivers/media/platform/xilinx/xilinx-vipp.c
> index f34f8b077e03..415579b63737 100644
> --- a/drivers/media/platform/xilinx/xilinx-vipp.c
> +++ b/drivers/media/platform/xilinx/xilinx-vipp.c
> @@ -483,10 +483,12 @@ static int xvip_graph_dma_init(struct xvip_composite_device *xdev)
>  		ret = xvip_graph_dma_init_one(xdev, port);
>  		if (ret < 0) {
>  			of_node_put(port);
> +			of_node_put(ports);
>  			return ret;
>  		}
>  	}
>  
> +	of_node_put(ports);

We could possibly simplify this a little bit by initializing ret to 0
when declaring it, replacing the "return ret" above by a break, and
returning ret below. This would remove the need for the first
of_node_put(ports) call above.

If you think that's a good idea I can make that change when applying
this patch to my tree, otherwise I'll take it as-is.

In either case,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
