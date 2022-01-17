Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5194903D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbiAQI3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiAQI3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:29:15 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7DDC061574;
        Mon, 17 Jan 2022 00:29:14 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 4AA461C0002;
        Mon, 17 Jan 2022 08:29:10 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:30:12 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 2/2] media: v4l2-mediabus: add support for dual edge
 sampling
Message-ID: <20220117083012.jhrpcqf7htw6yr3n@uno.localdomain>
References: <20220114105755.730200-1-michael.riesch@wolfvision.net>
 <20220114105755.730200-3-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220114105755.730200-3-michael.riesch@wolfvision.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael

On Fri, Jan 14, 2022 at 11:57:55AM +0100, Michael Riesch wrote:
> Some devices support sampling of the parallel data at both edges of the
> interface pixel clock in order to reduce the pixel clock by two.
> Add a mediabus flag that represents this feature.
>
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>

I was not expecting this :)
But I guess makes sense to add such option.

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

> ---
>  drivers/media/v4l2-core/v4l2-fwnode.c | 23 +++++++++++++++++++----
>  include/media/v4l2-mediabus.h         | 17 +++++++++--------
>  2 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> index 00457e1e93f6..70adf6549f5b 100644
> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> @@ -296,10 +296,25 @@ v4l2_fwnode_endpoint_parse_parallel_bus(struct fwnode_handle *fwnode,
>
>  	if (!fwnode_property_read_u32(fwnode, "pclk-sample", &v)) {
>  		flags &= ~(V4L2_MBUS_PCLK_SAMPLE_RISING |
> -			   V4L2_MBUS_PCLK_SAMPLE_FALLING);
> -		flags |= v ? V4L2_MBUS_PCLK_SAMPLE_RISING :
> -			V4L2_MBUS_PCLK_SAMPLE_FALLING;
> -		pr_debug("pclk-sample %s\n", v ? "high" : "low");
> +			   V4L2_MBUS_PCLK_SAMPLE_FALLING |
> +			   V4L2_MBUS_PCLK_SAMPLE_DUALEDGE);
> +		switch (v) {
> +		case 0:
> +			flags |= V4L2_MBUS_PCLK_SAMPLE_FALLING;
> +			pr_debug("pclk-sample low\n");
> +			break;
> +		case 1:
> +			flags |= V4L2_MBUS_PCLK_SAMPLE_RISING;
> +			pr_debug("pclk-sample high\n");
> +			break;
> +		case 2:
> +			flags |= V4L2_MBUS_PCLK_SAMPLE_DUALEDGE;
> +			pr_debug("pclk-sample dual edge\n");
> +			break;
> +		default:
> +			pr_warn("invalid argument for pclk-sample");
> +			break;
> +		}
>  	}
>
>  	if (!fwnode_property_read_u32(fwnode, "data-active", &v)) {
> diff --git a/include/media/v4l2-mediabus.h b/include/media/v4l2-mediabus.h
> index 841e190aedd9..c98f956ef586 100644
> --- a/include/media/v4l2-mediabus.h
> +++ b/include/media/v4l2-mediabus.h
> @@ -57,17 +57,18 @@
>  #define V4L2_MBUS_VSYNC_ACTIVE_LOW		BIT(5)
>  #define V4L2_MBUS_PCLK_SAMPLE_RISING		BIT(6)
>  #define V4L2_MBUS_PCLK_SAMPLE_FALLING		BIT(7)
> -#define V4L2_MBUS_DATA_ACTIVE_HIGH		BIT(8)
> -#define V4L2_MBUS_DATA_ACTIVE_LOW		BIT(9)
> +#define V4L2_MBUS_PCLK_SAMPLE_DUALEDGE		BIT(8)
> +#define V4L2_MBUS_DATA_ACTIVE_HIGH		BIT(9)
> +#define V4L2_MBUS_DATA_ACTIVE_LOW		BIT(10)
>  /* FIELD = 0/1 - Field1 (odd)/Field2 (even) */
> -#define V4L2_MBUS_FIELD_EVEN_HIGH		BIT(10)
> +#define V4L2_MBUS_FIELD_EVEN_HIGH		BIT(11)
>  /* FIELD = 1/0 - Field1 (odd)/Field2 (even) */
> -#define V4L2_MBUS_FIELD_EVEN_LOW		BIT(11)
> +#define V4L2_MBUS_FIELD_EVEN_LOW		BIT(12)
>  /* Active state of Sync-on-green (SoG) signal, 0/1 for LOW/HIGH respectively. */
> -#define V4L2_MBUS_VIDEO_SOG_ACTIVE_HIGH		BIT(12)
> -#define V4L2_MBUS_VIDEO_SOG_ACTIVE_LOW		BIT(13)
> -#define V4L2_MBUS_DATA_ENABLE_HIGH		BIT(14)
> -#define V4L2_MBUS_DATA_ENABLE_LOW		BIT(15)
> +#define V4L2_MBUS_VIDEO_SOG_ACTIVE_HIGH		BIT(13)
> +#define V4L2_MBUS_VIDEO_SOG_ACTIVE_LOW		BIT(14)
> +#define V4L2_MBUS_DATA_ENABLE_HIGH		BIT(15)
> +#define V4L2_MBUS_DATA_ENABLE_LOW		BIT(16)
>
>  /* Serial flags */
>  /* CSI-2 D-PHY number of data lanes. */
> --
> 2.30.2
>
