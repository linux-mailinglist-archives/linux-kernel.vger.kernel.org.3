Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE998592F47
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbiHONAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbiHONAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:00:20 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C111229;
        Mon, 15 Aug 2022 06:00:16 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EFB4C201ACD;
        Mon, 15 Aug 2022 15:00:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B9F64200C0D;
        Mon, 15 Aug 2022 15:00:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5D8C5180031D;
        Mon, 15 Aug 2022 21:00:13 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: imx_dsp_rproc: fix argument 2 of rproc_mem_entry_init
Date:   Mon, 15 Aug 2022 20:43:18 +0800
Message-Id: <1660567398-24495-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are sparse warning:
drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *va @@     got void [noderef] __iomem *[assigned] cpu_addr @@
drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse:     expected void *va
drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse:     got void [noderef] __iomem *[assigned] cpu_addr
drivers/remoteproc/imx_dsp_rproc.c:638:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *va @@     got void [noderef] __iomem *[assigned] cpu_addr @@
drivers/remoteproc/imx_dsp_rproc.c:638:49: sparse:     expected void *va
drivers/remoteproc/imx_dsp_rproc.c:638:49: sparse:     got void [noderef] __iomem *[assigned] cpu_addr

Fixes: ec0e5549f358 ("remoteproc: imx_dsp_rproc: Add remoteproc driver for DSP on i.MX")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index ca0817f8e41e..899aa8dd12f0 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -599,7 +599,7 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
 		}
 
 		/* Register memory region */
-		mem = rproc_mem_entry_init(dev, cpu_addr, (dma_addr_t)att->sa,
+		mem = rproc_mem_entry_init(dev, (void __force *)cpu_addr, (dma_addr_t)att->sa,
 					   att->size, da, NULL, NULL, "dsp_mem");
 
 		if (mem)
@@ -635,7 +635,7 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
 		}
 
 		/* Register memory region */
-		mem = rproc_mem_entry_init(dev, cpu_addr, (dma_addr_t)rmem->base,
+		mem = rproc_mem_entry_init(dev, (void __force *)cpu_addr, (dma_addr_t)rmem->base,
 					   rmem->size, da, NULL, NULL, it.node->name);
 
 		if (mem)
-- 
2.34.1

