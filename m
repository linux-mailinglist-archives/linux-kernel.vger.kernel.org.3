Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD71D4CE750
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiCEV7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiCEV7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:59:34 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCAD3D4A4;
        Sat,  5 Mar 2022 13:58:43 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id s16so904596qks.4;
        Sat, 05 Mar 2022 13:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bA6COhkxqJULw1J6YY+ycVS3dSCISRuj2zyilCuPjTI=;
        b=BXZW4KqpbIUC7e+zCk9eKL18jIJ0xZDUM3QtLst9hKoIqWVpoDyleq8wSY2l5TncMf
         JQk2xtn64KZmU1Ia3GSEU6RIMKWAGnrVYFoHUoI2RhJSOit01nr0AibQupeN8cW08iHC
         RDYBX6rgSbkNCwhalIT+DRyn1Gbr/XWUyswf8JXXuhL9gyPJ6zlQexrG+xA6/BSn0g0B
         skCYIBmAmproF0AygsVLr6LeZBsjJkbCkYF7zkkea53wpfy42+0yUB6rY9VY4apC7SzL
         xwf5LMUJyZKnmUL0YucmXeOny0+opvohkONeP7QKsY/f8na36oD8KkMEjI5GAXEhuUh5
         1H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bA6COhkxqJULw1J6YY+ycVS3dSCISRuj2zyilCuPjTI=;
        b=rbJ4wQIJ+WGD6OY4epI3i1iOCYwNmR5oqor6PwDbrNo0kG/3Kv1pGYvz0xEcNJ5jtC
         w5e0Ux/VJYdQ6JbNM68RNOZe4WpHG2b+EHlmrsv5s+K68c59CGzNDaqwj/dC4Ci/ww2S
         tB54dQI63O1+J9rHwSp/Rmi7HON/AchJQnoGxCwpVoukNapWpGnyR7zV2HEpR9MpazBp
         sWMlx9yjTei7T60UQuIM8LrzTGsThskCpmFlCfiajWr+rA2i20dGqj5KgXgYXgGKbkyG
         L8B6+0fbcRnoPI3+uNjJtuwA1C4/JfbJeJMRitWQD89J3U2lIdESyMNF6pNGc/bSGXxd
         aqdQ==
X-Gm-Message-State: AOAM533kqOA3pj1XU5wHZQjd9QIwRRMe/Y/AlcTgFIR6rM1C8dx7ZU1e
        /ai+pk6sBiVw1TSxPj+Q+EA=
X-Google-Smtp-Source: ABdhPJw4vJOzmKSTMCO2ApCNqa91/MVS9ULXJohkxDqioQVkTER3QFf0T9/hF/IJnPH+tAoyzM+xew==
X-Received: by 2002:a05:620a:4307:b0:507:d5b1:f65e with SMTP id u7-20020a05620a430700b00507d5b1f65emr2924851qko.363.1646517522746;
        Sat, 05 Mar 2022 13:58:42 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id h188-20020a376cc5000000b00648d7e2a36bsm4230067qkc.117.2022.03.05.13.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 13:58:42 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     robin.murphy@arm.com, linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mmc: host: dw-mmc-rockchip: fix handling invalid clock rates
Date:   Sat,  5 Mar 2022 16:58:35 -0500
Message-Id: <20220305215835.2210388-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305215835.2210388-1-pgwipeout@gmail.com>
References: <20220305215835.2210388-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip rk356x ciu clock cannot be set as low as the dw-mmc
hardware supports. This leads to a situation during card initialization
where the clock is set lower than the clock driver can support. The
dw-mmc-rockchip driver spews errors when this happens.
For normal operation this only happens a few times during boot, but when
cd-broken is enabled (in cases such as the SoQuartz module) this fires
multiple times each poll cycle.

Fix this by testing the lowest possible frequency that the clock driver
can support which is within the mmc specification. Divide that rate by
the internal divider and set f_min to this.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 95d0ec0f5f3a..f825487aa739 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -15,7 +15,9 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
-#define RK3288_CLKGEN_DIV       2
+#define RK3288_CLKGEN_DIV	2
+
+static const unsigned int freqs[] = { 100000, 200000, 300000, 400000 };
 
 struct dw_mci_rockchip_priv_data {
 	struct clk		*drv_clk;
@@ -51,7 +53,7 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 
 	ret = clk_set_rate(host->ciu_clk, cclkin);
 	if (ret)
-		dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
+		dev_warn(host->dev, "failed to set rate %uHz err: %d\n", cclkin, ret);
 
 	bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
 	if (bus_hz != host->bus_hz) {
@@ -290,13 +292,30 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 
 static int dw_mci_rockchip_init(struct dw_mci *host)
 {
+	int ret, i;
+
 	/* It is slot 8 on Rockchip SoCs */
 	host->sdio_id0 = 8;
 
-	if (of_device_is_compatible(host->dev->of_node,
-				    "rockchip,rk3288-dw-mshc"))
+	if (of_device_is_compatible(host->dev->of_node, "rockchip,rk3288-dw-mshc")) {
 		host->bus_hz /= RK3288_CLKGEN_DIV;
 
+		/* clock driver will fail if the clock is less than the lowest source clock
+		 * divided by the internal clock divider. Test for the lowest available
+		 * clock and set the minimum freq to clock / clock divider.
+		 */
+
+		for (i = 0; i < ARRAY_SIZE(freqs); i++) {
+			ret = clk_round_rate(host->ciu_clk, freqs[i] * RK3288_CLKGEN_DIV);
+			if (ret > 0) {
+				host->minimum_speed = ret / RK3288_CLKGEN_DIV;
+				break;
+			}
+		}
+		if (ret < 0)
+			dev_warn(host->dev, "no valid minimum freq: %d\n", ret);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

