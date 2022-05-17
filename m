Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D071A529FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344651AbiEQKrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344635AbiEQKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:47:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5443527D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:47:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A52F01F444D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652784437;
        bh=ALr3bte5ObWK9QXi4TwG41I7mS1thOAooIulWi4FCTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DwZJKZ/TNJ/qHKEzTzjqzF9Q/q6OHn3XehVbx+FVtwwmikhGJpji9iE4IiM6NYuxE
         0/n/N/9OQnf61ZayVXmOW17hfCwvpk19UnEMPXqVQwk6BZUefaFfQejvtv54vuZEwk
         2kusJaQA/MX/LH9BHLxjDj+x8324XTWFO3mqkFpWJ65r1XXTUyMiWOhgW10XduN3os
         1cY81o82AbYisTvFPGhvBIIEgObsbHlexur9zjwRd+TAr5hx4b29b5YbIe4bLe8Uje
         tuuhoA7OTL/8PCshS5xy7kH19t2DK+B7YAltx6fCMlvySrd7Bkd6xDLl90/q57pN5I
         0UcZiSluN73+w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 1/5] soc: mediatek: pwrap: Use readx_poll_timeout() instead of custom function
Date:   Tue, 17 May 2022 12:47:08 +0200
Message-Id: <20220517104712.24579-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517104712.24579-1-angelogioacchino.delregno@collabora.com>
References: <20220517104712.24579-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function pwrap_wait_for_state() is a function that polls an address
through a helper function, but this is the very same operation that
the readx_poll_timeout macro means to do.
Convert all instances of calling pwrap_wait_for_state() to instead
use the read_poll_timeout macro.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 60 +++++++++++++++-------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index bf39a64f3ecc..54a5300ab72b 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -13,6 +13,9 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
+#define PWRAP_POLL_DELAY_US	10
+#define PWRAP_POLL_TIMEOUT_US	10000
+
 #define PWRAP_MT8135_BRIDGE_IORD_ARB_EN		0x4
 #define PWRAP_MT8135_BRIDGE_WACS3_EN		0x10
 #define PWRAP_MT8135_BRIDGE_INIT_DONE3		0x14
@@ -1241,27 +1244,14 @@ static bool pwrap_is_fsm_idle_and_sync_idle(struct pmic_wrapper *wrp)
 		(val & PWRAP_STATE_SYNC_IDLE0);
 }
 
-static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
-		bool (*fp)(struct pmic_wrapper *))
-{
-	unsigned long timeout;
-
-	timeout = jiffies + usecs_to_jiffies(10000);
-
-	do {
-		if (time_after(jiffies, timeout))
-			return fp(wrp) ? 0 : -ETIMEDOUT;
-		if (fp(wrp))
-			return 0;
-	} while (1);
-}
-
 static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 {
+	bool tmp;
 	int ret;
 	u32 val;
 
-	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
+	ret = readx_poll_timeout(pwrap_is_fsm_idle, wrp, tmp, tmp,
+				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
 	if (ret) {
 		pwrap_leave_fsm_vldclr(wrp);
 		return ret;
@@ -1273,7 +1263,8 @@ static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 		val = (adr >> 1) << 16;
 	pwrap_writel(wrp, val, PWRAP_WACS2_CMD);
 
-	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_vldclr);
+	ret = readx_poll_timeout(pwrap_is_fsm_vldclr, wrp, tmp, tmp,
+				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
 	if (ret)
 		return ret;
 
@@ -1290,11 +1281,14 @@ static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 
 static int pwrap_read32(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 {
+	bool tmp;
 	int ret, msb;
 
 	*rdata = 0;
 	for (msb = 0; msb < 2; msb++) {
-		ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
+		ret = readx_poll_timeout(pwrap_is_fsm_idle, wrp, tmp, tmp,
+					 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
+
 		if (ret) {
 			pwrap_leave_fsm_vldclr(wrp);
 			return ret;
@@ -1303,7 +1297,8 @@ static int pwrap_read32(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 		pwrap_writel(wrp, ((msb << 30) | (adr << 16)),
 			     PWRAP_WACS2_CMD);
 
-		ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_vldclr);
+		ret = readx_poll_timeout(pwrap_is_fsm_vldclr, wrp, tmp, tmp,
+					 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
 		if (ret)
 			return ret;
 
@@ -1323,9 +1318,11 @@ static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 
 static int pwrap_write16(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
 {
+	bool tmp;
 	int ret;
 
-	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
+	ret = readx_poll_timeout(pwrap_is_fsm_idle, wrp, tmp, tmp,
+				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
 	if (ret) {
 		pwrap_leave_fsm_vldclr(wrp);
 		return ret;
@@ -1344,10 +1341,12 @@ static int pwrap_write16(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
 
 static int pwrap_write32(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
 {
+	bool tmp;
 	int ret, msb, rdata;
 
 	for (msb = 0; msb < 2; msb++) {
-		ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
+		ret = readx_poll_timeout(pwrap_is_fsm_idle, wrp, tmp, tmp,
+					 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
 		if (ret) {
 			pwrap_leave_fsm_vldclr(wrp);
 			return ret;
@@ -1388,6 +1387,7 @@ static int pwrap_regmap_write(void *context, u32 adr, u32 wdata)
 
 static int pwrap_reset_spislave(struct pmic_wrapper *wrp)
 {
+	bool tmp;
 	int ret, i;
 
 	pwrap_writel(wrp, 0, PWRAP_HIPRIO_ARB_EN);
@@ -1407,7 +1407,8 @@ static int pwrap_reset_spislave(struct pmic_wrapper *wrp)
 		pwrap_writel(wrp, wrp->master->spi_w | PWRAP_MAN_CMD_OP_OUTS,
 				PWRAP_MAN_CMD);
 
-	ret = pwrap_wait_for_state(wrp, pwrap_is_sync_idle);
+	ret = readx_poll_timeout(pwrap_is_sync_idle, wrp, tmp, tmp,
+				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
 	if (ret) {
 		dev_err(wrp->dev, "%s fail, ret=%d\n", __func__, ret);
 		return ret;
@@ -1458,14 +1459,15 @@ static int pwrap_init_sidly(struct pmic_wrapper *wrp)
 static int pwrap_init_dual_io(struct pmic_wrapper *wrp)
 {
 	int ret;
+	bool tmp;
 	u32 rdata;
 
 	/* Enable dual IO mode */
 	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_DIO_EN], 1);
 
 	/* Check IDLE & INIT_DONE in advance */
-	ret = pwrap_wait_for_state(wrp,
-				   pwrap_is_fsm_idle_and_sync_idle);
+	ret = readx_poll_timeout(pwrap_is_fsm_idle_and_sync_idle, wrp, tmp, tmp,
+				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
 	if (ret) {
 		dev_err(wrp->dev, "%s fail, ret=%d\n", __func__, ret);
 		return ret;
@@ -1570,6 +1572,7 @@ static bool pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp)
 static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 {
 	int ret;
+	bool tmp;
 	u32 rdata = 0;
 
 	pwrap_writel(wrp, 0x1, PWRAP_CIPHER_SWRST);
@@ -1624,14 +1627,16 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	}
 
 	/* wait for cipher data ready@AP */
-	ret = pwrap_wait_for_state(wrp, pwrap_is_cipher_ready);
+	ret = readx_poll_timeout(pwrap_is_cipher_ready, wrp, tmp, tmp,
+				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
 	if (ret) {
 		dev_err(wrp->dev, "cipher data ready@AP fail, ret=%d\n", ret);
 		return ret;
 	}
 
 	/* wait for cipher data ready@PMIC */
-	ret = pwrap_wait_for_state(wrp, pwrap_is_pmic_cipher_ready);
+	ret = readx_poll_timeout(pwrap_is_pmic_cipher_ready, wrp, tmp, tmp,
+				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
 	if (ret) {
 		dev_err(wrp->dev,
 			"timeout waiting for cipher data ready@PMIC\n");
@@ -1640,7 +1645,8 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 
 	/* wait for cipher mode idle */
 	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_MODE], 0x1);
-	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle_and_sync_idle);
+	ret = readx_poll_timeout(pwrap_is_fsm_idle_and_sync_idle, wrp, tmp, tmp,
+				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
 	if (ret) {
 		dev_err(wrp->dev, "cipher mode idle fail, ret=%d\n", ret);
 		return ret;
-- 
2.35.1

