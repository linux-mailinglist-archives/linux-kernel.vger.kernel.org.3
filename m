Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E1D4E1CD5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244738AbiCTQab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245520AbiCTQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45C34B93;
        Sun, 20 Mar 2022 09:28:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so7232959wmq.2;
        Sun, 20 Mar 2022 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/RImxULSEIcXltj7eh82B63gODFmYdSpUPrpbmj5VVA=;
        b=ZZiaMuUEyV4HvlJOVouI/OC79i49piYPR5WHC39tHtECxTQKhyQZb1WUWqTAQmFkLR
         lu1OybqNPFotogVxetuStr+IJ8tXfhfi66iqr8Qqk4w6BeBIPAreS44Ur1RP3J4fWiNe
         Dvc56vEk6d7FBrYOJRdDK8iho5fnTAEYYdn320CP08j+NUFoZLkIajGGAQhdgK4nYEv7
         t/Qz2oAm0MfE6DdtlqtMZ+9turKuAUatDWoS+VwNUzMOx+MkqdJ15deNJNY+jXHVIVux
         wNo0czahyAl/Bv1zYsZAJzrbdEF46qppopzrqE8/Armke+LyHMwLSD0xW0TZ/QR2Ah6A
         4YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RImxULSEIcXltj7eh82B63gODFmYdSpUPrpbmj5VVA=;
        b=sBdaTEhd1cquVZMCDvl4BDXauKBtSTBoC/oalQ2VgOSppNiqRbEn3PVhBeUR2bqZqJ
         GflEYgkPsyMSxFFJuwwrC4+JYCEtE/+zBp1Vt/fdYytShFRVqdN4qCuRlnGuBFCW20aX
         IbInxTtrgEyyoq95V4uaMOp7/ijPBFPZEs2UAR06ICzyVovJyQee9XTPoMe37qBAxeo2
         u3Lqf9hKHTd4mDxR+7dl5qJlaHCp+pfWPsGlSNDCJ4fx5Xcye6fSrRx9LVRxorEaQHxV
         FCStwIJEeHtUfWQwJRhQIfP8PF46Kql9SqqvyKRxTmQl5AXQNdpcQWnm3DieRdLpQgi5
         VlmA==
X-Gm-Message-State: AOAM5308cDCZPPKty/YYh0XgItW2YZCVPiR1VZyI1RtjszuCCrHG/DH4
        QUE0wKp+0S9bTsRmmRYu8Lg=
X-Google-Smtp-Source: ABdhPJzve9llFzsE3nFRzkBjHx/1boMbc3OIRcvsEC49wNYUIkDmckX5hLtbrjeowdNghouE2q36Cg==
X-Received: by 2002:a05:600c:3506:b0:389:d567:e9fa with SMTP id h6-20020a05600c350600b00389d567e9famr15982077wmq.74.1647793704443;
        Sun, 20 Mar 2022 09:28:24 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:24 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 12/18] clk: qcom: clk-krait: add apq/ipq8064 errata workaround
Date:   Sun, 20 Mar 2022 12:34:24 +0100
Message-Id: <20220320113430.26076-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add apq/ipq8064 errata workaround where the sec_src clock gating needs to
be disabled during switching. To enable this set disable_sec_src_gating
in the mux struct.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 16 ++++++++++++++++
 drivers/clk/qcom/clk-krait.h |  1 +
 drivers/clk/qcom/krait-cc.c  |  1 +
 3 files changed, 18 insertions(+)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index b6b7650dbf15..7ba5dbc72bce 100644
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
+	/* apq/ipq8064 Errata: disable sec_src clock gating during switch. */
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
 
+	/* apq/ipq8064 Errata: re-enabled sec_src clock gating. */
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
index 299eb4c81d96..cb8b267f1dc5 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -157,6 +157,7 @@ krait_add_sec_mux(struct device *dev, struct clk *qsb, int id,
 	mux->shift = 2;
 	mux->parent_map = sec_mux_map;
 	mux->hw.init = &init;
+	mux->disable_sec_src_gating = true;
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
 	if (!init.name)
-- 
2.34.1

