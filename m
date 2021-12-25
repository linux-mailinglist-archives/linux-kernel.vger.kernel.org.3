Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6394547F44D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 20:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhLYTRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 14:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhLYTRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 14:17:20 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA24C061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 11:17:19 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g26so25698416lfv.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 11:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WJNrRIjHHYf+GPgQViyRAYjVslLnt06sXu04ZoOwHts=;
        b=Gveyeo2okQd7D9oOp4BlMV4Mo7gu3+oAU+tPjrgT/XFk1Jo+YQmG89VxkSf1jUI8UR
         0seCzeyaJggnIzbGhAbmIwRgz8Nm0NTZiEFKAwyk3G8gCyVde2hmcnOrBPVq9Ksi1s+q
         aoEjGOuNn87Z3TTyVr+bTnUIloztyFyoHwW2luJJYhSQV+XAIopPpeOU7sR6DM/XqUWd
         Qjtcn0N3aJaxjlfEYIhnPtFcjcXu/ts/m8f6i0kuMgqW/5BtGYFz4TgFoaFHsPv0Ha5M
         GYFiAHhXrrdeNKCaC/lq1wLLv3tmD4oCryw5ewOCJlkdnt++7o3aqiVeteb/1kNqff81
         5YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WJNrRIjHHYf+GPgQViyRAYjVslLnt06sXu04ZoOwHts=;
        b=FdqNrzvQW7gxnBY063rnhHE+/y0Y5u6yshdA8wsGpfNt29ncUg4MXj1eG14vLjmn/G
         5Y1emM7HVOCtkeWKEZ9flmhBRPpEL0HPFcuiatR6D+jdQGuSE7/5i/eZNPxROSD4UU4+
         gtRjxRAUrFd58UpfYuSrHgkG8PHi+ZkshoDgHc2BRLhFnoOnVVTiGwmdqdsIi3r/4jTP
         HKeLUI/aSdGSEX1JJ+wVr3hd3SjHOCvnCeN/OgULETQ8J2ujFp/nLrGjmek0qNgOmWTy
         CH0S2Yr/HybTmaB5kFz3Hok+HhfRR+7DiYZaNt3HWpKLw6ivpqrDKC1puSOLSY2X5Lhy
         12GA==
X-Gm-Message-State: AOAM531HNhNXpU4a4vayKwc83VqulCRtt2+2NGyg4+ZKF5+cSdenYu9Z
        w4n+rXKI3jfo5nt7jnC1CHxT1u2ZommxuiJQrew=
X-Google-Smtp-Source: ABdhPJzIjE8GJoJ+svQ3ALHAQwA3mymJTGLISXogHXHEsapsVqXpYH+w83Iux53FVVo+kHxa2lyNow==
X-Received: by 2002:a05:6512:3996:: with SMTP id j22mr2600088lfu.74.1640459837886;
        Sat, 25 Dec 2021 11:17:17 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id 194sm252169ljj.60.2021.12.25.11.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 11:17:17 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] pinctrl: renesas: r8a7799[05]: Add MediaLB pins
Date:   Sat, 25 Dec 2021 22:17:13 +0300
Message-Id: <20211225191713.2187975-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds pins, groups, and functions for MediaLB devices on Renesas
R-Car E3 and D3 SoCs.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/pinctrl/renesas/pfc-r8a77990.c | 22 ++++++++++++++++++++--
 drivers/pinctrl/renesas/pfc-r8a77995.c | 14 ++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77990.c b/drivers/pinctrl/renesas/pfc-r8a77990.c
index f44c7da3ec16..b7ab4c520ae5 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77990.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77990.c
@@ -2339,6 +2339,16 @@ static const unsigned int intc_ex_irq5_mux[] = {
 	IRQ5_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A77990
+/* - MLB+ ------------------------------------------------------------------- */
+static const unsigned int mlb_3pin_pins[] = {
+	RCAR_GP_PIN(5, 17), RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19),
+};
+static const unsigned int mlb_3pin_mux[] = {
+	MLB_CLK_MARK, MLB_SIG_MARK, MLB_DAT_MARK,
+};
+#endif /* CONFIG_PINCTRL_PFC_R8A77990 */
+
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -3842,7 +3852,7 @@ static const unsigned int vin5_clk_b_mux[] = {
 static const struct {
 	struct sh_pfc_pin_group common[255];
 #ifdef CONFIG_PINCTRL_PFC_R8A77990
-	struct sh_pfc_pin_group automotive[21];
+	struct sh_pfc_pin_group automotive[22];
 #endif
 } pinmux_groups = {
 	.common = {
@@ -4125,6 +4135,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(drif3_ctrl_b),
 		SH_PFC_PIN_GROUP(drif3_data0_b),
 		SH_PFC_PIN_GROUP(drif3_data1_b),
+		SH_PFC_PIN_GROUP(mlb_3pin),
 	}
 #endif /* CONFIG_PINCTRL_PFC_R8A77990 */
 };
@@ -4315,6 +4326,12 @@ static const char * const intc_ex_groups[] = {
 	"intc_ex_irq5",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A77990
+static const char * const mlb_3pin_groups[] = {
+	"mlb_3pin",
+};
+#endif /* CONFIG_PINCTRL_PFC_R8A77990 */
+
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -4569,7 +4586,7 @@ static const char * const vin5_groups[] = {
 static const struct {
 	struct sh_pfc_function common[49];
 #ifdef CONFIG_PINCTRL_PFC_R8A77990
-	struct sh_pfc_function automotive[4];
+	struct sh_pfc_function automotive[5];
 #endif
 } pinmux_functions = {
 	.common = {
@@ -4629,6 +4646,7 @@ static const struct {
 		SH_PFC_FUNCTION(drif1),
 		SH_PFC_FUNCTION(drif2),
 		SH_PFC_FUNCTION(drif3),
+		SH_PFC_FUNCTION(mlb_3pin),
 	}
 #endif /* CONFIG_PINCTRL_PFC_R8A77990 */
 };
diff --git a/drivers/pinctrl/renesas/pfc-r8a77995.c b/drivers/pinctrl/renesas/pfc-r8a77995.c
index c56e1e4c13b3..d0f0d6b0f979 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77995.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77995.c
@@ -1295,6 +1295,14 @@ static const unsigned int mmc_ctrl_mux[] = {
 	MMC_CLK_MARK, MMC_CMD_MARK,
 };
 
+/* - MLB+ ------------------------------------------------------------------- */
+static const unsigned int mlb_3pin_pins[] = {
+	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7), RCAR_GP_PIN(0, 8),
+};
+static const unsigned int mlb_3pin_mux[] = {
+	MLB_CLK_MARK, MLB_SIG_MARK, MLB_DAT_MARK,
+};
+
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -2049,6 +2057,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c2_b),
 	SH_PFC_PIN_GROUP(i2c3_a),
 	SH_PFC_PIN_GROUP(i2c3_b),
+	SH_PFC_PIN_GROUP(mlb_3pin),
 	SH_PFC_PIN_GROUP(mmc_data1),
 	SH_PFC_PIN_GROUP(mmc_data4),
 	SH_PFC_PIN_GROUP(mmc_data8),
@@ -2314,6 +2323,10 @@ static const char * const vin4_groups[] = {
 	"vin4_clk",
 };
 
+static const char * const mlb_3pin_groups[] = {
+	"mlb_3pin",
+};
+
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -2370,6 +2383,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c1),
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
+	SH_PFC_FUNCTION(mlb_3pin),
 	SH_PFC_FUNCTION(mmc),
 	SH_PFC_FUNCTION(msiof0),
 	SH_PFC_FUNCTION(msiof1),
-- 
2.30.2

