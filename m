Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CD53043A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348736AbiEVP60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347192AbiEVP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:58:07 -0400
Received: from herzl.nuvoton.co.il (unknown [212.199.177.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10183B565;
        Sun, 22 May 2022 08:58:04 -0700 (PDT)
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 24MFp6F1031639;
        Sun, 22 May 2022 18:51:06 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id DBCFE63A4A; Sun, 22 May 2022 18:51:06 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 10/19] reset: npcm: using syscon instead of device data
Date:   Sun, 22 May 2022 18:50:37 +0300
Message-Id: <20220522155046.260146-11-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220522155046.260146-1-tmaimon77@gmail.com>
References: <20220522155046.260146-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,NML_ADSP_CUSTOM_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using syscon device tree property instead of
device data to handle the NPCM GCR registers.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/reset/reset-npcm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index 2ea4d3136e15..0c963b21eddc 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -138,8 +138,7 @@ static int npcm_reset_xlate(struct reset_controller_dev *rcdev,
 }
 
 static const struct of_device_id npcm_rc_match[] = {
-	{ .compatible = "nuvoton,npcm750-reset",
-		.data = (void *)"nuvoton,npcm750-gcr" },
+	{ .compatible = "nuvoton,npcm750-reset"},
 	{ }
 };
 
@@ -155,14 +154,10 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
 	u32 ipsrst1_bits = 0;
 	u32 ipsrst2_bits = NPCM_IPSRST2_USB_HOST;
 	u32 ipsrst3_bits = 0;
-	const char *gcr_dt;
 
-	gcr_dt = (const char *)
-	of_match_device(dev->driver->of_match_table, dev)->data;
-
-	gcr_regmap = syscon_regmap_lookup_by_compatible(gcr_dt);
+	gcr_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
 	if (IS_ERR(gcr_regmap)) {
-		dev_err(&pdev->dev, "Failed to find %s\n", gcr_dt);
+		dev_err(&pdev->dev, "Failed to find gcr syscon");
 		return PTR_ERR(gcr_regmap);
 	}
 
-- 
2.33.0

