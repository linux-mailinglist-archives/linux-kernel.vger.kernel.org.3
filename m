Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950F74CB47B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiCCBw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiCCBwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:52:53 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0193D111A;
        Wed,  2 Mar 2022 17:52:09 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id x3so3019908qvd.8;
        Wed, 02 Mar 2022 17:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KVujQolZaOxrqf5Q/2Oi93Y5mDWXCJ9XvGmoyx2Rfs=;
        b=V+cy/NCTgADucp216rHe8jhqh3g+R5gW3nArEHc5P9B493NX301In8q8py+ypygpmi
         ZV5RVGx/L98CrEJrzgthflS5bmNiCteuXdhU52A/+k6BuObWkFp0N076JumK/5Wh6ATu
         STUaaI3WoW/uIu1Cp1t/AgryI+q7F9eRPV3V+iHTWQQ0zx6Nwb3XisPYD9L4CrwnQnsB
         XdKbExZaXHHaJ3xcggFS2uy4g+2WeVHugVMbEQDR7EqBrXlGBxDByVk5uE0haTEr46ne
         unlSafCUxkygdhMal9v1pTolMuRSVsWTDInyvWLL8iuna8+QLq32yhXbCQFwIMb07Fsu
         1KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KVujQolZaOxrqf5Q/2Oi93Y5mDWXCJ9XvGmoyx2Rfs=;
        b=C+Xh9NqUcEWZBNTMnPCVZtefERIiazxMz3KefalBWJdBJZDYmL1CTeDFXmEDUF7+9Q
         WYDUtDj0En7v+FLnKMpBoykPQRNACdo+y3nSsZXae2fKEr0zTxLT1D0eEAxWe/yMm5gz
         YS2olKmbBlP+lkwrvsZq/n8X3IlDfTdq7CL0l7/VtSOc9auG87siXDeSr99AptEjLN1a
         kTuh+C7MRXA8rWLFvPFnuIZSAa/t2DKlpqDSaIIMh4lhbP11sEsA6VzylOGeLmZUObgS
         DI/FypV8iGwLymCtUXmmYTceDNOjjVisHjgxI3+dUT3Z+NNs3NDdhAomgP9UJ/lrDg7j
         IYrA==
X-Gm-Message-State: AOAM5329Y1p64gO3cR6mf5vucQ6a3Tb0rPOM3+dC68wAZFBckZ7sKUXp
        gj6jPdfHOzoq7dm6W3086gc=
X-Google-Smtp-Source: ABdhPJyzLMVOPLC8sHNOXTgI2vgUY914/z1joGrNE5mu7Nb3Q1H1fi5SpCNsQ9gbt/mW/9LgBXA2pA==
X-Received: by 2002:a05:6214:c2f:b0:435:1b08:f0ed with SMTP id a15-20020a0562140c2f00b004351b08f0edmr4277800qvd.52.1646272328000;
        Wed, 02 Mar 2022 17:52:08 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id m2-20020ae9e002000000b0050819df7151sm388258qkk.99.2022.03.02.17.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 17:52:07 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     robin.murphy@arm.com, Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Addy Ke <addy.ke@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Peter Geis <pgwipeout@gmail.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: host: dw-mmc-rockchip: fix handling invalid clock rates
Date:   Wed,  2 Mar 2022 20:51:51 -0500
Message-Id: <20220303015151.1711860-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The Rockchip ciu clock cannot be set as low as the dw-mmc hardware
supports. This leads to a situation during card initialization where the
ciu clock is set lower than the clock driver can support. The
dw-mmc-rockchip driver spews errors when this happens.
For normal operation this only happens a few times during boot, but when
cd-broken is enabled (in cases such as the SoQuartz module) this fires
multiple times each poll cycle.

Fix this by testing the minimum frequency the clock driver can support
that is within the mmc specification, then divide that by the internal
clock divider. Set the f_min frequency to this value, or if it fails,
set f_min to the downstream driver's default.

Fixes: f629ba2c04c9 ("mmc: dw_mmc: add support for RK3288")

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 31 ++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 95d0ec0f5f3a..c198590cd74a 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -15,7 +15,9 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
-#define RK3288_CLKGEN_DIV       2
+#define RK3288_CLKGEN_DIV	2
+#define RK3288_MIN_INIT_FREQ	375000
+#define MMC_MAX_INIT_FREQ	400000
 
 struct dw_mci_rockchip_priv_data {
 	struct clk		*drv_clk;
@@ -27,6 +29,7 @@ struct dw_mci_rockchip_priv_data {
 static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct dw_mci_rockchip_priv_data *priv = host->priv;
+	struct mmc_host *mmc = mmc_from_priv(host);
 	int ret;
 	unsigned int cclkin;
 	u32 bus_hz;
@@ -34,6 +37,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	if (ios->clock == 0)
 		return;
 
+	/* the clock will fail if below the f_min rate */
+	if (ios->clock < mmc->f_min)
+		ios->clock = mmc->f_min;
+
 	/*
 	 * cclkin: source clock of mmc controller
 	 * bus_hz: card interface clock generated by CLKGEN
@@ -51,7 +58,7 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 
 	ret = clk_set_rate(host->ciu_clk, cclkin);
 	if (ret)
-		dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
+		dev_warn(host->dev, "failed to set rate %uHz err: %d\n", cclkin, ret);
 
 	bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
 	if (bus_hz != host->bus_hz) {
@@ -290,13 +297,29 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 
 static int dw_mci_rockchip_init(struct dw_mci *host)
 {
+	struct mmc_host *mmc = mmc_from_priv(host);
+	int ret;
+
 	/* It is slot 8 on Rockchip SoCs */
 	host->sdio_id0 = 8;
 
-	if (of_device_is_compatible(host->dev->of_node,
-				    "rockchip,rk3288-dw-mshc"))
+	if (of_device_is_compatible(host->dev->of_node, "rockchip,rk3288-dw-mshc")) {
 		host->bus_hz /= RK3288_CLKGEN_DIV;
 
+		/* clock driver will fail if the clock is less than the lowest source clock
+		 * divided by the internal clock divider. Test for the lowest available
+		 * clock and set the f_min freq to clock / clock divider. If we fail, set
+		 * it to the downstream hardcoded value.
+		 */
+		ret = clk_round_rate(host->ciu_clk, MMC_MAX_INIT_FREQ * RK3288_CLKGEN_DIV);
+		if (ret < 0) {
+			dev_warn(host->dev, "mmc safe rate failed: %d\n", ret);
+			mmc->f_min = RK3288_MIN_INIT_FREQ;
+		} else {
+			mmc->f_min = ret / RK3288_CLKGEN_DIV;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.25.1

