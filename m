Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F81852EC56
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349452AbiETMlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242225AbiETMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:40:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B9EF2;
        Fri, 20 May 2022 05:40:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 39C0C1F462AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653050443;
        bh=1cI7pJdMnTRIrjJ1RulEP49MI5dUM/5mesdNO1GWVz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0tAkU63Gsv6F35bpHi7VC2t0gJZXQNisR3r2SkQXYnbYmOLl8m1uBpD+9P8Rn8Cg
         QCK0OPu9l6rX7bmbRnLWsDp+WAOjlUg+eaKbfMG9xS37+4uTNfn9nDXkosP5wiPhQj
         SOMb+swpYgtORdI3xg6n32hrank1MYBliryTbwtr1UtmKdp4on/oCL2ApOoo6cFTtc
         XexakscSvOEYUUsLtsucBJAFmkDhp0bGlCtKOn6MdpYuBq4q3AVxcnxhtEy1eEoQUh
         38r3B3+12vgkLpEwEJUNK1avcv24xDWYmxvT7Rx2uq4enQJAU8sLWEmicST2fvbMtc
         boLckHEBkraRw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        zhiyong.tao@mediatek.com, henryc.chen@mediatek.com,
        johnson.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] soc: mediatek: pwrap: Move PMIC read test sequence in function
Date:   Fri, 20 May 2022 14:40:33 +0200
Message-Id: <20220520124039.228314-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520124039.228314-1-angelogioacchino.delregno@collabora.com>
References: <20220520124039.228314-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
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

The PMIC read test is performed in two places: pwrap_init_dual_io()
and pwrap_init_sidly().
In preparation for adding support for PMICs requiring a companion
part, move this sequence to a new function pwrap_pmic_read_test().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 32 +++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index d8cb0f833645..d0c79ee4c56b 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1390,6 +1390,18 @@ static int pwrap_regmap_write(void *context, u32 adr, u32 wdata)
 	return pwrap_write(context, adr, wdata);
 }
 
+static bool pwrap_pmic_read_test(struct pmic_wrapper *wrp, const u32 *dew_regs,
+				 u16 read_test_val)
+{
+	bool is_success;
+	u32 rdata;
+
+	pwrap_read(wrp, dew_regs[PWRAP_DEW_READ_TEST], &rdata);
+	is_success = ((rdata & U16_MAX) == read_test_val);
+
+	return is_success;
+}
+
 static int pwrap_reset_spislave(struct pmic_wrapper *wrp)
 {
 	bool tmp;
@@ -1433,18 +1445,18 @@ static int pwrap_reset_spislave(struct pmic_wrapper *wrp)
  */
 static int pwrap_init_sidly(struct pmic_wrapper *wrp)
 {
-	u32 rdata;
 	u32 i;
 	u32 pass = 0;
+	bool read_ok;
 	signed char dly[16] = {
 		-1, 0, 1, 0, 2, -1, 1, 1, 3, -1, -1, -1, 3, -1, 2, 1
 	};
 
 	for (i = 0; i < 4; i++) {
 		pwrap_writel(wrp, i, PWRAP_SIDLY);
-		pwrap_read(wrp, wrp->slave->dew_regs[PWRAP_DEW_READ_TEST],
-			   &rdata);
-		if (rdata == PWRAP_DEW_READ_TEST_VAL) {
+		read_ok = pwrap_pmic_read_test(wrp, wrp->slave->dew_regs,
+					       PWRAP_DEW_READ_TEST_VAL);
+		if (read_ok) {
 			dev_dbg(wrp->dev, "[Read Test] pass, SIDLY=%x\n", i);
 			pass |= 1 << i;
 		}
@@ -1464,8 +1476,7 @@ static int pwrap_init_sidly(struct pmic_wrapper *wrp)
 static int pwrap_init_dual_io(struct pmic_wrapper *wrp)
 {
 	int ret;
-	bool tmp;
-	u32 rdata;
+	bool read_ok, tmp;
 
 	/* Enable dual IO mode */
 	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_DIO_EN], 1);
@@ -1481,12 +1492,9 @@ static int pwrap_init_dual_io(struct pmic_wrapper *wrp)
 	pwrap_writel(wrp, 1, PWRAP_DIO_EN);
 
 	/* Read Test */
-	pwrap_read(wrp,
-		   wrp->slave->dew_regs[PWRAP_DEW_READ_TEST], &rdata);
-	if (rdata != PWRAP_DEW_READ_TEST_VAL) {
-		dev_err(wrp->dev,
-			"Read failed on DIO mode: 0x%04x!=0x%04x\n",
-			PWRAP_DEW_READ_TEST_VAL, rdata);
+	read_ok = pwrap_pmic_read_test(wrp, wrp->slave->dew_regs, PWRAP_DEW_READ_TEST_VAL);
+	if (!read_ok) {
+		dev_err(wrp->dev, "Read failed on DIO mode.\n");
 		return -EFAULT;
 	}
 
-- 
2.35.1

