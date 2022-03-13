Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA364D77DA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiCMTHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiCMTGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEE9506E5;
        Sun, 13 Mar 2022 12:05:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qa43so29422021ejc.12;
        Sun, 13 Mar 2022 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sEQR7AHep43bwZwVHXAE2cEONvRXMp4DrDQG9qka08M=;
        b=Sz87HYVsoKtiiOuHvJ2WAz9s27Dc7vz6VwvczrwWbn33hJLQ7c5xQzRrqfHvgoitpp
         MOq1Y5c6rlONCTvZt1iU0y/TC4L4L6bKo9tfo0kHqWffk1ILj2AbeHq/2lwgV5kmxAtg
         kARmmXJOO5Aq5tSsaOF9gJCValwDoMB1lirS392xbQJdDHUKEMquUNhecxBCldbJD51/
         pkyNNtXjDv4204rz52OLTKHwP4GT6UlY1dz3q26FIkbvo36wSST3OmrouGVc9JAkvEYq
         8OYJ+QgwTnIrUiH0dH42LT7aC2c8cK7jhQ7JTyB80/JHvYSlTWIXTfAQJqWFNPUwtsah
         Q/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEQR7AHep43bwZwVHXAE2cEONvRXMp4DrDQG9qka08M=;
        b=Z1319PC1eM9zndNBBaBXKkKRwwXG42F7lploNSPkz+n7aCLeX2u0lPyLEB0txhKzTA
         PxXPHtDJg+8qPbMwvSB0CQWb7n0AatFzduX8Zo+CyANVkSNBD4YRk3a06g7rOG6r534b
         bjcjT4xVVYUYxXbdT6rbPwUe3mWAhXP5OzY2ogt2hUnCcJ5r8IdaLywPa6T4uA7sC6ca
         aZMF97Nn/xPQI8LNOZeKdR4+LDpwr/nR831ro3NZeAMdqtO6Mpg8N4X6E9PqC/3usqvr
         SwvPu/TpNaB1XxE3+3X91hJZtHlHnwnmvejgwzIvBWkQGDYBMsKmX/Mb2MrUhq8oQUcE
         Vxjg==
X-Gm-Message-State: AOAM531MVnEiO4/9xHUQ8zAIk1qoYn/kD3WEmm5mvOBa94KwTKGIzviv
        kOO0OJwarSo3DI8dxwlcZUo=
X-Google-Smtp-Source: ABdhPJzJSvZYpZkmGjsnohew5wdo1ux3J5zVQpqlGhuzOBMbIRj96up6V93GUgT0NEoWBVVpsA1piw==
X-Received: by 2002:a17:906:7954:b0:6da:9ee0:2e54 with SMTP id l20-20020a170906795400b006da9ee02e54mr16921227ejo.630.1647198314701;
        Sun, 13 Mar 2022 12:05:14 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:14 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 12/16] clk: qcom: clk-krait: add 8064 errata workaround
Date:   Sun, 13 Mar 2022 20:04:15 +0100
Message-Id: <20220313190419.2207-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220313190419.2207-1-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
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

Add 8064 errata workaround where the sec_src clock gating needs to be
disabled during switching. To enable this set disable_sec_src_gating in
the mux struct.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 16 ++++++++++++++++
 drivers/clk/qcom/clk-krait.h |  1 +
 drivers/clk/qcom/krait-cc.c  |  1 +
 3 files changed, 18 insertions(+)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index d8af281eba0e..82fe7031e1f4 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -18,13 +18,23 @@
 static DEFINE_SPINLOCK(krait_clock_reg_lock);
 
 #define LPL_SHIFT	8
+#define SECCLKAGD	BIT(4)
+
 static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
 {
 	unsigned long flags;
 	u32 regval;
 
 	spin_lock_irqsave(&krait_clock_reg_lock, flags);
+
 	regval = krait_get_l2_indirect_reg(mux->offset);
+
+	/* 8064 Errata: disable sec_src clock gating during switch. */
+	if (mux->disable_sec_src_gating) {
+		regval |= SECCLKAGD;
+		krait_set_l2_indirect_reg(mux->offset, regval);
+	}
+
 	regval &= ~(mux->mask << mux->shift);
 	regval |= (sel & mux->mask) << mux->shift;
 	if (mux->lpl) {
@@ -33,6 +43,12 @@ static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
 	}
 	krait_set_l2_indirect_reg(mux->offset, regval);
 
+	/* 8064 Errata: re-enabled sec_src clock gating. */
+	if (mux->disable_sec_src_gating) {
+		regval &= ~SECCLKAGD;
+		krait_set_l2_indirect_reg(mux->offset, regval);
+	}
+
 	/* Wait for switch to complete. */
 	mb();
 	udelay(1);
diff --git a/drivers/clk/qcom/clk-krait.h b/drivers/clk/qcom/clk-krait.h
index 9120bd2f5297..f930538c539e 100644
--- a/drivers/clk/qcom/clk-krait.h
+++ b/drivers/clk/qcom/clk-krait.h
@@ -15,6 +15,7 @@ struct krait_mux_clk {
 	u8		safe_sel;
 	u8		old_index;
 	bool		reparent;
+	bool		disable_sec_src_gating;
 
 	struct clk_hw	hw;
 	struct notifier_block   clk_nb;
diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 1bdc89c097e6..533a770332be 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -154,6 +154,7 @@ krait_add_sec_mux(struct device *dev, struct clk *qsb, int id,
 	mux->shift = 2;
 	mux->parent_map = sec_mux_map;
 	mux->hw.init = &init;
+	mux->disable_sec_src_gating = true;
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
 	if (!init.name)
-- 
2.34.1

