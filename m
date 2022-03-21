Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ECC4E34D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiCUXr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiCUXqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:46:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44849680E;
        Mon, 21 Mar 2022 16:45:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso416136wmr.1;
        Mon, 21 Mar 2022 16:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/RImxULSEIcXltj7eh82B63gODFmYdSpUPrpbmj5VVA=;
        b=jT8RgMISQDjRNDcRrqAokCQH0i2UNigwlMocsqfEHXQLW5VSAEPDEOQO1dTn+vxDD/
         zsFL4P7xIIk974szJEwNcxbw67WFBDJyFA21HSeEaUHdjDu6Hhi7zo2zzTE0L3NLESmz
         hyuaq93dNO+38/sEg31Ut6w9nOtPETbit0XsCr+Z1eX4rvnRwIyGpPHT05cllPFTgU3n
         0mNCVCBurhC4Iy03d81Nr6F/kew7VWLiU1ocy05b3CZrvv5kJPdtFD+OO3xAKDs6NNqa
         +Zz+hicc3iz4fk/Pf9K8ZNGTmUg2RjKt8l6A9EFcMDJc+sITlSjj1dACPJJ3R252nyHU
         HdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RImxULSEIcXltj7eh82B63gODFmYdSpUPrpbmj5VVA=;
        b=ee+SUTSM9RNXZG1ym9LhrDgBKIGpdmXmXSDdIT+8DJK0dkGgZrzd2wUr5RHjRH5D9O
         AbejzcCJK1aZHKAoiQFadgJMSko7QkTTGQo+aThmES3jWR2CIqWaIY4jfWGnB3WgO8/K
         N8zCItJG1TzcfjYXMnUuboABhzTCTctAKYVeyJ7Q5JAZZzgYabrrhPglWDC8Vc/gwN0h
         jz6Z8f/tefajb1OxGw432i8zG4teeAMO6RN+MayJTRhlsmlw/fKji9DjkRcHpiDXSbg5
         M0W8/KvcfsYUyZYwYxiRLezQUIUbzkD0pKysgmjUZRvWcRmgZ8uK9uimjUcfqH6niHSB
         VPXg==
X-Gm-Message-State: AOAM530cMmuA5lebbkPVB8P04e3+dPx2AxTyNgKxx7lYpGuXXohupeDZ
        OXKPaFsu26parKkE4lTYxg8=
X-Google-Smtp-Source: ABdhPJwATjUZNJIuk7EjZPvgWAjvfl/FZpAz2RfXwPuyrBEv6wLzrqBlm2oO+VvYsEDNsCj1Hu8TCQ==
X-Received: by 2002:a05:600c:500e:b0:38c:6d79:d5ac with SMTP id n14-20020a05600c500e00b0038c6d79d5acmr1303350wmr.42.1647906324864;
        Mon, 21 Mar 2022 16:45:24 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm105497wrf.80.2022.03.21.16.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:45:24 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 12/18] clk: qcom: clk-krait: add apq/ipq8064 errata workaround
Date:   Tue, 22 Mar 2022 00:15:42 +0100
Message-Id: <20220321231548.14276-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321231548.14276-1-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
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

