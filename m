Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A655A0CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiFXSPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiFXSO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:14:58 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D0174832A;
        Fri, 24 Jun 2022 11:14:57 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,218,1650898800"; 
   d="scan'208";a="125578126"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Jun 2022 03:14:56 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 640D4400F791;
        Sat, 25 Jun 2022 03:14:53 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 2/2] mmc: renesas_sdhi: Fix typo's
Date:   Fri, 24 Jun 2022 19:14:38 +0100
Message-Id: <20220624181438.4355-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220624181438.4355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220624181438.4355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo's,
* difference -> different
* alignment -> aligned

While at it updated the comment to make it clear that Renesas SDHI DMAC
needs buffers to be 128-byte aligned.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 3084b15ae2cb..890aa7832baf 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -321,7 +321,7 @@ renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host)
 }
 
 /*
- * renesas_sdhi_internal_dmac_map() will be called with two difference
+ * renesas_sdhi_internal_dmac_map() will be called with two different
  * sg pointers in two mmc_data by .pre_req(), but tmio host can have a single
  * sg_ptr only. So, renesas_sdhi_internal_dmac_{un}map() should use a sg
  * pointer in a mmc_data instead of host->sg_ptr.
@@ -355,7 +355,7 @@ renesas_sdhi_internal_dmac_map(struct tmio_mmc_host *host,
 
 	data->host_cookie = cookie;
 
-	/* This DMAC cannot handle if buffer is not 128-bytes alignment */
+	/* This DMAC needs buffers to be 128-byte aligned */
 	if (!IS_ALIGNED(sg_dma_address(data->sg), 128)) {
 		renesas_sdhi_internal_dmac_unmap(host, data, cookie);
 		return false;
-- 
2.17.1

