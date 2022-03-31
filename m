Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D303E4EE478
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbiCaXJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242801AbiCaXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:09:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBB024B5F7;
        Thu, 31 Mar 2022 16:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Wc2Oq40Pg0ynpxrJIKmotpTbNN3R2XU6aWZKP1ShEqs=; b=CoFpDdKEQ2S+vTBc7CoT7AM/Ja
        9cOdnIJBJeLJBDeSKRexloTca60TrZzwWFK5yoNgASJGD2uPNeu1NSYnM8OtdPtmaoStuNWQzMag+
        MmOBQ9Tl4wOcLGGVWiq9Rm7R+jvpDec03AJ7wDpF+GANJXsc3ZUi6vNYZZZDTJoTN1aeqGLbDMgPN
        lVA3nVyMgy1tk73Voc/GwosQ5Lgjsi3yhE6PVTE9Gevv623zf5+5Saul83IapslsW2Jj4qOD/c4GD
        3E2w5pb9YnOrZt/beChNrd/xLDtPha3BSvSBOoNMa7Hs9iuYyVfEdKm+ba7Vx7AG0TMpgjiThDOJf
        21eF+2Dw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1na3t3-003vAs-AR; Thu, 31 Mar 2022 23:07:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: nxp: RB532: fix return value of __setup handler
Date:   Thu, 31 Mar 2022 16:07:28 -0700
Message-Id: <20220331230728.13897-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx-mipi-csis uses interfaces that are made available by VIDEO_DEV,
so the driver should depend on VIDEO_DEV to eliminate build errors.

Fixes these build errors:

aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_calculate_params':
imx-mipi-csis.c:(.text+0x2ec): undefined reference to `v4l2_get_link_freq'
aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_async_register':
imx-mipi-csis.c:(.text+0x464): undefined reference to `v4l2_async_nf_init'
aarch64-linux-ld: imx-mipi-csis.c:(.text+0x48c): undefined reference to `v4l2_fwnode_endpoint_parse'
aarch64-linux-ld: imx-mipi-csis.c:(.text+0x538): undefined reference to `__v4l2_async_nf_add_fwnode_remote'
aarch64-linux-ld: imx-mipi-csis.c:(.text+0x56c): undefined reference to `v4l2_async_subdev_nf_register'
aarch64-linux-ld: imx-mipi-csis.c:(.text+0x57c): undefined reference to `v4l2_async_register_subdev'
aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_notify_bound':
imx-mipi-csis.c:(.text+0x5e0): undefined reference to `v4l2_create_fwnode_links_to_pad'
aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_probe':
imx-mipi-csis.c:(.text+0x1088): undefined reference to `v4l2_subdev_init'
aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1148): undefined reference to `v4l2_async_nf_unregister'
aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1150): undefined reference to `v4l2_async_nf_cleanup'
aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1158): undefined reference to `v4l2_async_unregister_subdev'
aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_set_fmt':
imx-mipi-csis.c:(.text+0x1348): undefined reference to `v4l_bound_align_image'
aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_s_stream':
imx-mipi-csis.c:(.text+0x14bc): undefined reference to `v4l2_subdev_call_wrappers'
aarch64-linux-ld: imx-mipi-csis.c:(.text+0x14c0): undefined reference to `v4l2_subdev_call_wrappers'
aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1624): undefined reference to `v4l2_subdev_call_wrappers'
aarch64-linux-ld: imx-mipi-csis.c:(.text+0x1628): undefined reference to `v4l2_subdev_call_wrappers'
aarch64-linux-ld: imx-mipi-csis.c:(.text+0x16d0): undefined reference to `v4l2_subdev_call_wrappers'
aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:imx-mipi-csis.c:(.text+0x16d4): more undefined references to `v4l2_subdev_call_wrappers' follow
aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o: in function `mipi_csis_remove':
aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:(.rodata+0x4b8): undefined reference to `v4l2_subdev_get_fwnode_pad_1_to_1'
aarch64-linux-ld: drivers/media/platform/nxp/imx-mipi-csis.o:(.rodata+0x4c8): undefined reference to `v4l2_subdev_link_validate'

Fixes: 46fb99951fe2 ("media: platform: place NXP drivers on a separate dir")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-media@vger.kernel.org
---
 drivers/media/platform/nxp/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20220331.orig/drivers/media/platform/nxp/Kconfig
+++ linux-next-20220331/drivers/media/platform/nxp/Kconfig
@@ -7,6 +7,7 @@ comment "NXP media platform drivers"
 config VIDEO_IMX_MIPI_CSIS
 	tristate "NXP MIPI CSI-2 CSIS receiver found on i.MX7 and i.MX8 models"
 	depends on ARCH_MXC || COMPILE_TEST
+	depends on VIDEO_DEV
 	select MEDIA_CONTROLLER
 	select V4L2_FWNODE
 	select VIDEO_V4L2_SUBDEV_API
