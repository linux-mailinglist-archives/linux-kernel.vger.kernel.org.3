Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEEF537AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiE3MfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiE3MfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:35:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BB57CB04
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:35:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u3so14453200wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZpnujIPcolEhKbIJZUfooL6oIUs8mzgT5bxqd2OLwk=;
        b=civVMl7MXBedL2Fy/RdMR2hvoMq61sw/bSOuRyUnGfnpbQlu1B1vaETDk2eoLtMg61
         xxvEM0CcGiuHnAv6EMTxHCVekfHJ443IW5HAHw1nPPodMQDAgQb/Z8wkdyR2n2oVdc02
         rEchF77XObT5skBCADYM/9HeAkGoea+j9J1auHdrH25hfsrcuBh06zz0PQOUIkBpRAHo
         9mlga4VSDuJ7sjz7UYdmr50MV3YV9+ezDISlXifrMQirUadM1ssMASjkx+97cXDUuyeb
         JhphSXc6/ervgN2b3jAzZSnPdDVaaUjM91vEkyX+Un5qEiD2lJPkDNrYMhf/x2hF+OXy
         7cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZpnujIPcolEhKbIJZUfooL6oIUs8mzgT5bxqd2OLwk=;
        b=OLRzLVqF7uR3c9IzdNVGiU7ZVfcIevapHGRbUs8ikQvfsbONV0jHtouTf/X/St3s5V
         77gFQkvx3ZuCvg9KCJyDn28aBlv7h0COb7P7SMIlMCqX8SyrRAXsnB3qkKBY51nJBfQr
         O3bc66WyrOtFa8rlYj+rZcCDVafMSDBSSvH94Azgk+UMqS3xaC7oI85zq/710dOBZPih
         mlMCNA2xNE9mAJFYZ3VqwRv8ttLZlZeG8SuaCPBzb8rC+tQP/dJGczA9e2rplk3094n0
         0KC0YRu7yZTNsvOE77CfNQDuXixzRblrLKnLlxUPc4t/ws+0Vyr5MPPkppVJy/iPWqqB
         3QDw==
X-Gm-Message-State: AOAM53121+t7jGLGtOO7W5QFzAXYOBCb6Hs9bDPBywxGEicypmF7E/tk
        lGY81g69Zdivj1nLZGD5OI/k/w==
X-Google-Smtp-Source: ABdhPJxvnP7l8SO28NpVJS5NOclYzbNoRLMyWaTv8lhRa6I5+hFmHhKsWwpdaDK81i85ecqujt0hRA==
X-Received: by 2002:a05:6000:1611:b0:210:28cc:65dd with SMTP id u17-20020a056000161100b0021028cc65ddmr8793920wrb.700.1653914102514;
        Mon, 30 May 2022 05:35:02 -0700 (PDT)
Received: from helium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d47c3000000b0020d0cdbf7eesm9380895wrc.111.2022.05.30.05.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 05:35:01 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: mediatek: common: add quirk for broken set/clr modes
Date:   Mon, 30 May 2022 14:34:24 +0200
Message-Id: <20220530123425.689459-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MT8365, the SET/CLR of the mode is broken and some pin modes won't
be set correctly. Add a quirk for such SoCs, so that instead of using
the SET/CLR register use the main R/W register
to read/update/write the modes.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 46 ++++++++++++-------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  3 ++
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index f25b3e09386b..156627d9c552 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -330,23 +330,37 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
 		return -EINVAL;
 	}
 
-	bit = BIT(pin & pctl->devdata->mode_mask);
-	if (enable)
-		reg_pullen = SET_ADDR(mtk_get_port(pctl, pin) +
-			pctl->devdata->pullen_offset, pctl);
-	else
-		reg_pullen = CLR_ADDR(mtk_get_port(pctl, pin) +
-			pctl->devdata->pullen_offset, pctl);
-
-	if (isup)
-		reg_pullsel = SET_ADDR(mtk_get_port(pctl, pin) +
-			pctl->devdata->pullsel_offset, pctl);
-	else
-		reg_pullsel = CLR_ADDR(mtk_get_port(pctl, pin) +
-			pctl->devdata->pullsel_offset, pctl);
+	if (pctl->devdata->quirks & MTK_PINCTRL_MODE_SET_CLR_BROKEN) {
+		bit = pin & pctl->devdata->mode_mask;
+		reg_pullen = mtk_get_port(pctl, pin) +
+				pctl->devdata->pullen_offset;
+		reg_pullsel = mtk_get_port(pctl, pin) +
+				pctl->devdata->pullsel_offset;
+
+		regmap_update_bits(mtk_get_regmap(pctl, pin), reg_pullen,
+			BIT(bit), enable << bit);
+		regmap_update_bits(mtk_get_regmap(pctl, pin), reg_pullsel,
+			BIT(bit), isup << bit);
+	} else {
+		bit = BIT(pin & pctl->devdata->mode_mask);
+		if (enable)
+			reg_pullen = SET_ADDR(mtk_get_port(pctl, pin) +
+				pctl->devdata->pullen_offset, pctl);
+		else
+			reg_pullen = CLR_ADDR(mtk_get_port(pctl, pin) +
+				pctl->devdata->pullen_offset, pctl);
+
+		if (isup)
+			reg_pullsel = SET_ADDR(mtk_get_port(pctl, pin) +
+				pctl->devdata->pullsel_offset, pctl);
+		else
+			reg_pullsel = CLR_ADDR(mtk_get_port(pctl, pin) +
+				pctl->devdata->pullsel_offset, pctl);
+
+		regmap_write(mtk_get_regmap(pctl, pin), reg_pullen, bit);
+		regmap_write(mtk_get_regmap(pctl, pin), reg_pullsel, bit);
+	}
 
-	regmap_write(mtk_get_regmap(pctl, pin), reg_pullen, bit);
-	regmap_write(mtk_get_regmap(pctl, pin), reg_pullsel, bit);
 	return 0;
 }
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 6fe8564334c9..cc0dce8818c6 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -22,6 +22,8 @@
 
 #define MTK_PINCTRL_NOT_SUPPORT	(0xffff)
 
+#define MTK_PINCTRL_MODE_SET_CLR_BROKEN   BIT(0)
+
 struct mtk_desc_function {
 	const char *name;
 	unsigned char muxval;
@@ -271,6 +273,7 @@ struct mtk_pinctrl_devdata {
 	unsigned int mode_mask;
 	unsigned int mode_per_reg;
 	unsigned int mode_shf;
+	unsigned long quirks;
 };
 
 struct mtk_pinctrl {
-- 
2.36.1

