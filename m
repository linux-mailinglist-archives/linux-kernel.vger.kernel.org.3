Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A409C59B01D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiHTT7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiHTT6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:58:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0A3326D3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y141so7040620pfb.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=jQxqJRMDZJaQoBVA5zc0nS90T27LyxE0WQ7RiUL+5/8=;
        b=lVm13wXfoqOK0P3bQudLyy/ZUTjxwI51VH7FwKO1pHhDjXGCNyQ+NO8tVV/5w+LOJE
         dSRm0PxdWGmRubhjOT9/BrvnAWszZTu55w1b2YHghHlN2YZMRSV3G6opjlv+L5SdWLq0
         tOirAnisHMz9Y4lncQW0DIcgyIEk6KtD5KzxVLUv+aROuIrRIiwg8HlfHdFMsTEQz2BM
         dIPbQbB1X5YR6jgFjRctS0GlDrG0beEZAKew6+Epd+xhDW1Ci8LmzFheQYg30koO1a/4
         0JBBMZproFdQzdRcuhSrHXu+m3jGtYlrznMY25qwBa2e8MLTYVrdQW1ueKhcG6s8fPP0
         3I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=jQxqJRMDZJaQoBVA5zc0nS90T27LyxE0WQ7RiUL+5/8=;
        b=DIe+Onj9gWNLEd5AVwOUz+jKvNciWBSi7aSlpFIpGL61O70KOBEISu/IGPqXj7ImEJ
         8jcn0z2vdMI85uIEgMIq0dWQW1quQPay6FHl6RgLpnc4n/T3SLz0aweswsaxhnWc9ALK
         QIVnE8C6fjaBQCI+1IANzPJfNcRWrD/zG9tzAEw3afkPZwLcJDELBwLy/j2xOzeTcch3
         x8h+attWqPrP3W+2x9jI/wg4my4PY2VIpel/XfnV5ZTtZSlYnJBA6TyJmrK14UEpyEaj
         ANNwJyHansY+cRAFBt2/+pD5+Xfe3fe9MT4h9kI2wygBqQa+SlGRyPzsPzzbXWnmYntA
         MQZQ==
X-Gm-Message-State: ACgBeo1eYe9/F3hTC79fj6T/4A8WSp0G3boFi6NZSCg5CwhLwN4Qq9fs
        oQu401nDglMQuSHV2KQQsAOt/g==
X-Google-Smtp-Source: AA6agR6V+W12g3z/SCutMu3xdVCV0zPyZftrloynOKYKb3GKOxs7BHoPTGP/IfXxUhhiUtX/rmdk7w==
X-Received: by 2002:a63:77ce:0:b0:429:f679:2335 with SMTP id s197-20020a6377ce000000b00429f6792335mr11080510pgc.327.1661025527490;
        Sat, 20 Aug 2022 12:58:47 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:47 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 13/17] mmc: sdhci-cadence: Enable device specific override of writel()
Date:   Sat, 20 Aug 2022 12:57:46 -0700
Message-Id: <20220820195750.70861-14-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

SoCs with device specific Cadence implementation, such as setting
byte-enables before the write, need to override writel().  Add a
callback where the default is writel() for all existing chips.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 drivers/mmc/host/sdhci-cadence.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 6f2de54a5987..708d4297f241 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -67,6 +67,7 @@ struct sdhci_cdns_phy_param {
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 	bool enhanced_strobe;
+	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
 	unsigned int nr_phy_params;
 	struct sdhci_cdns_phy_param phy_params[];
 };
@@ -90,6 +91,12 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
 	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
 };
 
+static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
+			       void __iomem *reg)
+{
+	writel(val, reg);
+}
+
 static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 				    u8 addr, u8 data)
 {
@@ -104,17 +111,17 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 
 	tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
 	      FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
-	writel(tmp, reg);
+	priv->priv_writel(priv, tmp, reg);
 
 	tmp |= SDHCI_CDNS_HRS04_WR;
-	writel(tmp, reg);
+	priv->priv_writel(priv, tmp, reg);
 
 	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
 	if (ret)
 		return ret;
 
 	tmp &= ~SDHCI_CDNS_HRS04_WR;
-	writel(tmp, reg);
+	priv->priv_writel(priv, tmp, reg);
 
 	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
 				 0, 10);
@@ -191,7 +198,7 @@ static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
 	tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
 	tmp &= ~SDHCI_CDNS_HRS06_MODE;
 	tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
-	writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
+	priv->priv_writel(priv, tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
 }
 
 static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
@@ -223,7 +230,7 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 	 */
 	for (i = 0; i < 2; i++) {
 		tmp |= SDHCI_CDNS_HRS06_TUNE_UP;
-		writel(tmp, reg);
+		priv->priv_writel(priv, tmp, reg);
 
 		ret = readl_poll_timeout(reg, tmp,
 					 !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
@@ -386,6 +393,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	priv->nr_phy_params = nr_phy_params;
 	priv->hrs_addr = host->ioaddr;
 	priv->enhanced_strobe = false;
+	priv->priv_writel = cdns_writel;
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
-- 
2.17.1

