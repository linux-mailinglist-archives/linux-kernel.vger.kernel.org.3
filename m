Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB205B1C9B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiIHMSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiIHMSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:18:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F75E55B7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:18:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e16so6488193wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=36szBVL2Cn+cs2NB42v+LawQS2D430mbQOaqyu/Olfs=;
        b=Pde3JYxD/Xd7HKAURItyoFTzSLlbMdkJZf1gK9a32JrxfqoSR6WT7zjXJ30ox8O3HB
         zs49UqsyBuLz6xVMI0aQekGt+BTmG/KUBFlcAcB4ZlBhVS4aceqzdh64Ic+v0Q9TghVe
         Aj/TPe9IXO7rMvvRs7GxgWDEzruAd5C+rvoMrKPgJBNEga4t2DPEKGfBsVAGA3D/wXvf
         xd+pRbnIomRsdTKedKKrUE5WcNF5tavoZCeGkht64YQiI7mu9TrAQggoHu26KZqdzI1g
         uUfXz4zxxI5PDVkuze5GMqJ+cv5HZyf+XodaHVXZFDWgij62kVXc3yFRzpgs0gCuv8ws
         xr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=36szBVL2Cn+cs2NB42v+LawQS2D430mbQOaqyu/Olfs=;
        b=vUI3VcRNrygHrpVHuBOpxcAW0yD9rxFNvB/MEC6XS5Em9rNvCgVzcTPg5Skg4aGJEd
         WP6nB/WWIWFPR3ryAnZd3R5XUk6ThsuYrzfXPVJpxV+HoSBuidAxofxgE006V1sZ4+ma
         6B91mmC2mx342Y9ZIIYhOjGGRtUqDRwoTER/F0WjPH2xP+EsrumjWlCwpR76fW3lPS2K
         hIA9j80XBvWXFDF61H8ECV2smlUSYvzmoFANfs7t9wrw/x0CZctTQFHPAsUKAoy2F7+m
         /3vRRR2P6OO3YI2QXSToPX7WGZW5U4WH2aQDXBMpBng6pxA4Dw6yhDCmXnSD56XyPbEq
         elxg==
X-Gm-Message-State: ACgBeo24aXjwOsqad0vr2JYDu7yKZ5HLDzsRI+5X/ZT2mf0jSwxeJ16j
        fCjwx8WNemp4Hn6gorbWRFpLMcLHDqm+UNtu
X-Google-Smtp-Source: AA6agR5EjA56judCPtRCeCyzyYiLIg54xxck9hVsX0853urdIxfPbSabM8hT3pDh8JwKOyA8tSzDaQ==
X-Received: by 2002:a5d:6e8c:0:b0:225:5f3f:1d8f with SMTP id k12-20020a5d6e8c000000b002255f3f1d8fmr5262682wrz.610.1662639490672;
        Thu, 08 Sep 2022 05:18:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:982:cbb0:666e:a053:1034:922f])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003ab1a870daasm3212208wmq.5.2022.09.08.05.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 05:18:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH] spi: meson-spicc: do not rely on busy flag in pow2 clk ops
Date:   Thu,  8 Sep 2022 14:18:03 +0200
Message-Id: <20220908121803.919943-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2239; h=from:subject; bh=yaCMBlN3USyF395Qdq99BsDpbkdWYyZKbFBk4XoweKc=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBjGd1q0Ohn/nMUpBJQiilkpVXCK3b8I2QACUHiwbG7 HNL0O1GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYxndagAKCRB33NvayMhJ0RtJD/ 4mdK7zWsfF1Ga9qsaLSDth+NlZNgABEsh3oscJvCZlBD9qZNExO3Glepq2g1FnFmbD7FIoK6kN+NP2 nRT3URxR0tX2COW7gxtfywqW3N8Pu7l4HDr2MXnjhL+3q8dw/+TtjRfHPgWb+uyXg1N1vScKU6dnRy lBUilgIhBTygZl2E1g6vtGN3tFZG1idUwIT+YIgxbb7EcWCXac6Z+L6omlKS2j8L4gpszEIM10YE0x nE5TE5gsbHciqfxc0X8pd7wI2oxugaw7fz7ecDy3pWZh6/+ofNiRrGjwjgbwGMlV45UTncwv4O8SF7 5Dd1I3IyZjWQ5I0v+oQNCOKb/gs3QG7zOwgkvBSR9UQjbVFBOXIoJZ3UafQQP/wmFXaeRr4oJKR+OD NymFVCG3+6NC/vqTZnmkGBSzpNbmOeaD4SWXHM8M2eDEDgY98wclVDLCkyi2fV9fOeIVWKnzeRJ3RB a74K42rUBbN+t37jcwZxObMWH8XHSAWqjcWxz80Dc4hjhaEvGjMO2QNz2LzsYEjJhzkxwcB0+HV5D2 lPKPpS1AXR1EF7U8pfxcpl5G/BtrabXa6bGz42Pb6163yqzFc4NjjNWb4POhBpZgWzgO+gzgT3HQBl xy00lqqUJqtsPMaQBtJUHSMUSD54ssFtW/sHjSpttcvgZMTjwEAi28AtZ43w==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since [1], controller's busy flag isn't set anymore when the
__spi_transfer_message_noqueue() is used instead of the
__spi_pump_transfer_message() logic for spi_sync transfers.

Since the pow2 clock ops were limited to only be available when a
transfer is ongoing (between prepare_transfer_hardware and
unprepare_transfer_hardware callbacks), the only way to track this
down is to check for the controller cur_msg.

[1] ae7d2346dc89 ("spi: Don't use the message queue if possible in spi_sync")

Fixes: 09992025dacd ("spi: meson-spicc: add local pow2 clock ops to preserve rate between messages")
Fixes: ae7d2346dc89 ("spi: Don't use the message queue if possible in spi_sync")
Reported-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spicc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index e4cb52e1fe26..6974a1c947aa 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -537,7 +537,7 @@ static unsigned long meson_spicc_pow2_recalc_rate(struct clk_hw *hw,
 	struct clk_divider *divider = to_clk_divider(hw);
 	struct meson_spicc_device *spicc = pow2_clk_to_spicc(divider);
 
-	if (!spicc->master->cur_msg || !spicc->master->busy)
+	if (!spicc->master->cur_msg)
 		return 0;
 
 	return clk_divider_ops.recalc_rate(hw, parent_rate);
@@ -549,7 +549,7 @@ static int meson_spicc_pow2_determine_rate(struct clk_hw *hw,
 	struct clk_divider *divider = to_clk_divider(hw);
 	struct meson_spicc_device *spicc = pow2_clk_to_spicc(divider);
 
-	if (!spicc->master->cur_msg || !spicc->master->busy)
+	if (!spicc->master->cur_msg)
 		return -EINVAL;
 
 	return clk_divider_ops.determine_rate(hw, req);
@@ -561,7 +561,7 @@ static int meson_spicc_pow2_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_divider *divider = to_clk_divider(hw);
 	struct meson_spicc_device *spicc = pow2_clk_to_spicc(divider);
 
-	if (!spicc->master->cur_msg || !spicc->master->busy)
+	if (!spicc->master->cur_msg)
 		return -EINVAL;
 
 	return clk_divider_ops.set_rate(hw, rate, parent_rate);
-- 
2.25.1

