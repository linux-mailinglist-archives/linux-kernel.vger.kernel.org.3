Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6F585E87
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiGaKuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiGaKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A077211820
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D04D60B3D
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 10:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1944C433B5;
        Sun, 31 Jul 2022 10:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659264643;
        bh=/4PNQYWxqsLAmKS//9Lz9FU8s9x7tK2yEhm8PBdtgQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRZs1F8q8oSiupI2DZXSI5Hp4fXkPw7hTh5+fE/LIKDcyVDAXn4mR88yTo7xUxILa
         xYCgGDy2Db+mDu7hXr27a6zRTJ3dVMcW/t1OD82ChHquLKXj0QRdER4RHd6Z6638tr
         0G7DzUa5Q7LTiHE6kvNC4blXP5yW2Ancw5RYi26aCLi1j/ia/VzRItM/lDWyTBwIMs
         NBLlww4QUxhbMVpcI+anUEOHYbooxQMwXJaLrqchiHMazqty2F9o76AEfkSrAqGo3U
         i3dHypfkp0/XaECG2AbO7kyab8kGpksDioS1CsTx4zPLPfnIBK2AbNmwhbg9miHuh/
         2aMY6gwo5mg9Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/8] habanalabs/gaudi: read div_sel value from firmware
Date:   Sun, 31 Jul 2022 13:50:31 +0300
Message-Id: <20220731105037.545106-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220731105037.545106-1-ogabbay@kernel.org>
References: <20220731105037.545106-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Even when running with unsecured f/w, we should read the PLL div_sel
value from the f/w as this register is always privileged.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 866dc4b891d6..7f52935dc603 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -899,12 +899,13 @@ static int gaudi_early_fini(struct hl_device *hdev)
  */
 static int gaudi_fetch_psoc_frequency(struct hl_device *hdev)
 {
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u32 nr = 0, nf = 0, od = 0, div_fctr = 0, pll_clk, div_sel;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u16 pll_freq_arr[HL_PLL_NUM_OUTPUTS], freq;
 	int rc;
 
-	if (hdev->asic_prop.fw_security_enabled) {
+	if ((hdev->fw_components & FW_TYPE_LINUX) &&
+			(prop->fw_app_cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_PLL_INFO_EN)) {
 		struct gaudi_device *gaudi = hdev->asic_specific;
 
 		if (!(gaudi->hw_cap_initialized & HW_CAP_CPU_Q))
-- 
2.25.1

