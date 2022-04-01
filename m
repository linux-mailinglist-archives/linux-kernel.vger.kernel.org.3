Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F374EEAFE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiDAKKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiDAKKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:10:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3B9C76;
        Fri,  1 Apr 2022 03:08:47 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-78-4-nat.elisa-mobile.fi [85.76.78.4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 667222F7;
        Fri,  1 Apr 2022 12:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1648807725;
        bh=K5Sq9Yy2RVQrGV8/mjWy3qcvNyxqmrBpCW1VDNpkzIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJgE1tLwoo64WXtAjtalqJEtmqFFgBD6Qu0lVeDi0Y6HC1xI0R0/Pc6q8HnHAUbOD
         lsH053yVUlKmysPK0nelTBuyZtTpZLelwx40jGSm+mfsj9R+SRYBLZTMeayhqCzss3
         5/z3dIgalvgolqgnmaNrj0enAOLXhrhdvtqSEEgc=
Date:   Fri, 1 Apr 2022 13:08:40 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2] media: nxp: imx-mips-csis depends on VIDEO_DEV
Message-ID: <YkbPKHrmHwtmuZVR@pendragon.ideasonboard.com>
References: <20220331231128.22015-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220331231128.22015-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thank you for the patch.

On Thu, Mar 31, 2022 at 04:11:28PM -0700, Randy Dunlap wrote:
> imx-mipi-csis uses interfaces that are made available by VIDEO_DEV,
> so the driver should depend on VIDEO_DEV to eliminate build errors.
> 
> Fixes these build errors:
> 
> aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_calculate_params':
> imx-mipi-csis.c:(.text+0x2ec): undefined reference to `v4l2_get_link_freq'
> aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_async_register':
> imx-mipi-csis.c:(.text+0x464): undefined reference to `v4l2_async_nf_init'
> aarch64-linux-ld: imx-mipi-csis.c:(.text+0x48c): undefined reference to `v4l2_fwnode_endpoint_parse'
> aarch64-linux-ld: imx-mipi-csis.c:(.text+0x538): undefined reference to `__v4l2_async_nf_add_fwnode_remote'
> aarch64-linux-ld: imx-mipi-csis.c:(.text+0x56c): undefined reference to `v4l2_async_subdev_nf_register'
> aarch64-linux-ld: imx-mipi-csis.c:(.text+0x57c): undefined reference to `v4l2_async_register_subdev'
> aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_notify_bound':
> imx-mipi-csis.c:(.text+0x5e0): undefined reference to `v4l2_create_fwnode_links_to_pad'
> aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_probe':
> imx-mipi-csis.c:(.text+0x1088): undefined reference to `v4l2_subdev_init'
> aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1148): undefined reference to `v4l2_async_nf_unregister'
> aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1150): undefined reference to `v4l2_async_nf_cleanup'
> aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1158): undefined reference to `v4l2_async_unregister_subdev'
> aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_set_fmt':
> imx-mipi-csis.c:(.text+0x1348): undefined reference to `v4l_bound_align_image'
> aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_s_stream':
> imx-mipi-csis.c:(.text+0x14bc): undefined reference to `v4l2_subdev_call_wrappers'
> aarch64-linux-ld: imx-mipi-csis.c:(.text+0x14c0): undefined reference to `v4l2_subdev_call_wrappers'
> aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1624): undefined reference to `v4l2_subdev_call_wrappers'
> aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1628): undefined reference to `v4l2_subdev_call_wrappers'
> aarch64-linux-ld: imx-mipi-csis.c:(.text+0x16d0): undefined reference to `v4l2_subdev_call_wrappers'
> aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:imx-mipi-csis.c:(.text+0x16d4): more undefined references to `v4l2_subdev_call_wrappers' follow
> aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_remove':
> aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:(.rodata+0x4b8): undefined reference to `v4l2_subdev_get_fwnode_pad_1_to_1'
> aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:(.rodata+0x4c8): undefined reference to `v4l2_subdev_link_validate'
> 
> Fixes: 46fb99951fe2 ("media: platform: place NXP drivers on a separate dir")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: linux-media@vger.kernel.org

This seems to duplicate
https://lore.kernel.org/linux-media/20220331123151.1953-1-laurent.pinchart@ideasonboard.com/T/#u.

> ---
> v2: fix copy-pasta Subject: line problem
> 
>  drivers/media/platform/nxp/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20220331.orig/drivers/media/platform/nxp/Kconfig
> +++ linux-next-20220331/drivers/media/platform/nxp/Kconfig
> @@ -7,6 +7,7 @@ comment "NXP media platform drivers"
>  config VIDEO_IMX_MIPI_CSIS
>  	tristate "NXP MIPI CSI-2 CSIS receiver found on i.MX7 and i.MX8 models"
>  	depends on ARCH_MXC || COMPILE_TEST
> +	depends on VIDEO_DEV
>  	select MEDIA_CONTROLLER
>  	select V4L2_FWNODE
>  	select VIDEO_V4L2_SUBDEV_API

-- 
Regards,

Laurent Pinchart
