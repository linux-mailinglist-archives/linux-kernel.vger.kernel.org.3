Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D254EED08
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbiDAMWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345826AbiDAMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:22:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFB127855F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:20:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54238619CF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CC7C3410F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648815630;
        bh=uk21Dfi1NLedLZlU+WTy5BFw1I7PDgyf8dQtEmHAbs4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VhmsRcXrqIM4fOgfTIH0PBnFO/lFojwzLa5fMGMaCVsFuKrbQo9JJogKeMIwNoO5S
         16ANRqrGAgOM5LzciqYLO80KMZDAm0d6de5N6gEOhmM0gJ+jtWGcVrYBE2i6WgGlcQ
         CV7cYS+La+52SvLB+zSsCwr1gavRmuXHChTcMrzG20qHJ7y0HYkUIblrixtGbffoNn
         5qxpg42mQZXqhFoeHNyiKqovUOd13F8HGFTHq1NfSRAlH90Z9Jhltp+Kq423nRC5n1
         nlV6RYokncR151pneTgpAdykm3mySq6HjzAiTivj9J1Juvj+r/91FSDy9deND6+CSu
         bO8TQ+ucX6FEA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] habanalabs: change a reset print to debug level
Date:   Fri,  1 Apr 2022 15:20:17 +0300
Message-Id: <20220401122017.116205-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401122017.116205-1-ogabbay@kernel.org>
References: <20220401122017.116205-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have two reset prints per reset. One is in the common
code and one in each asic-specific file.

We can change the asic-specific message to be debug only as we can
know the type of reset being done according to the print in the
common code, which is also easier to maintain.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 6 +++---
 drivers/misc/habanalabs/goya/goya.c   | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 33f7cfea53ae..b4bd40d47000 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4212,7 +4212,7 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset, bool fw_reset
 	}
 
 	if (fw_reset) {
-		dev_info(hdev->dev,
+		dev_dbg(hdev->dev,
 			"Firmware performs HARD reset, going to wait %dms\n",
 			reset_timeout_ms);
 
@@ -4304,11 +4304,11 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset, bool fw_reset
 		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST,
 			1 << PSOC_GLOBAL_CONF_SW_ALL_RST_IND_SHIFT);
 
-		dev_info(hdev->dev,
+		dev_dbg(hdev->dev,
 			"Issued HARD reset command, going to wait %dms\n",
 			reset_timeout_ms);
 	} else {
-		dev_info(hdev->dev,
+		dev_dbg(hdev->dev,
 			"Firmware performs HARD reset, going to wait %dms\n",
 			reset_timeout_ms);
 	}
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 8572b178ef7d..4d87dbf208f8 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2825,12 +2825,12 @@ static void goya_hw_fini(struct hl_device *hdev, bool hard_reset, bool fw_reset)
 		goya_set_pll_refclk(hdev);
 
 		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG, RESET_ALL);
-		dev_info(hdev->dev,
+		dev_dbg(hdev->dev,
 			"Issued HARD reset command, going to wait %dms\n",
 			reset_timeout_ms);
 	} else {
 		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG, DMA_MME_TPC_RESET);
-		dev_info(hdev->dev,
+		dev_dbg(hdev->dev,
 			"Issued SOFT reset command, going to wait %dms\n",
 			reset_timeout_ms);
 	}
-- 
2.25.1

