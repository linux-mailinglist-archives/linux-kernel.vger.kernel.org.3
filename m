Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23634DD60E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiCRIZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiCRIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:25:07 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0CF88780;
        Fri, 18 Mar 2022 01:23:48 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 8ED1C100009;
        Fri, 18 Mar 2022 08:23:44 +0000 (UTC)
Date:   Fri, 18 Mar 2022 09:23:43 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] media: platform: Fix build error
Message-ID: <20220318082343.46m5xmnqmjw6q4s2@uno.localdomain>
References: <20220318071028.1356775-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220318071028.1356775-1-wanghai38@huawei.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wang Hai

On Fri, Mar 18, 2022 at 03:10:28PM +0800, Wang Hai wrote:
> If VIDEO_IMX_MIPI_CSIS is y but VIDEO_DEV is n, building failed:
>
> drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_remove':
> imx-mipi-csis.c:(.text+0x1f0): undefined reference to `v4l2_async_nf_unregister'
> ld: imx-mipi-csis.c:(.text+0x1f8): undefined reference to `v4l2_async_nf_cleanup'
> ld: imx-mipi-csis.c:(.text+0x200): undefined reference to `v4l2_async_unregister_subdev'
>
> Set VIDEO_IMX_MIPI_CSIS to depend on VIDEO_DEV to fix it
>
> Fixes: 4a598f62a03b ("media: platform/*/Kconfig: make manufacturer menus more uniform")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Thanks, my understanding is that is fixed in Mauro's VIDEO_DEV rework.
[PATCH v2 00/67] media: Kconfig/Makefile reorg


> ---
>  drivers/media/platform/nxp/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/platform/nxp/Kconfig b/drivers/media/platform/nxp/Kconfig
> index 838abc9766b4..704fcf55697b 100644
> --- a/drivers/media/platform/nxp/Kconfig
> +++ b/drivers/media/platform/nxp/Kconfig
> @@ -6,6 +6,7 @@ comment "NXP drivers"
>
>  config VIDEO_IMX_MIPI_CSIS
>  	tristate "NXP MIPI CSI-2 CSIS receiver found on i.MX7 and i.MX8 models"
> +	depends on VIDEO_DEV
>  	select MEDIA_CONTROLLER
>  	select V4L2_FWNODE
>  	select VIDEO_V4L2_SUBDEV_API
> --
> 2.25.1
>
