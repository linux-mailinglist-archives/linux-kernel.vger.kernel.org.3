Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A1B4E2D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350835AbiCUQKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350735AbiCUQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:09:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315F92983C;
        Mon, 21 Mar 2022 09:08:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d7so21372658wrb.7;
        Mon, 21 Mar 2022 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/RImxULSEIcXltj7eh82B63gODFmYdSpUPrpbmj5VVA=;
        b=D1EyxBoNy9rnwvliXwI3sDoqfwUV2eqJrguiEC4wDRzt+p1KxhQxnWErSwJ9ef1TFL
         xateIY4De7ZDOzmC/U/nBTMMrt3gW8cBGbmmXXJ+5K66yz63l1jgS/7RogvBE71/o8uJ
         R/WNTcinisWarPaQgEtZPaMGc4n8Cll6hFN05tNTTDm0oPU2ckNgldJClIeoCUOcYR6X
         h99XaPh65EA+yFb/rJ1TLNHJj4Sh5qdarey9Pq/mbGAArZJo73I6vyjT7xkIF1ZDMgum
         Z1IOcSJ7/zzd6wUCUX/EbH/i+zx44Fiv5WwzOI2q/M2R+t+yNm8YKTzrpv8GRNchAdka
         jeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RImxULSEIcXltj7eh82B63gODFmYdSpUPrpbmj5VVA=;
        b=0C9dmepM0Jh+tvMyVrFOyy2abNUjiR8+8QvsrPnY7GdLdUZhRlmjOWr3YcRfhZArBc
         TnAd8ta153NugOkfU3slJ4gX4tsLSzIZW2cxmpReIlFeaAH89eHsVF9zG1dd17rJAc+O
         juocOXS1nn28YxQq6D958aJI1A+g/V8bawQ/wVsRC63c36wM9jd/kDh+3M02Smz+QJB2
         lZFycwWb22mtm/Yn373Hh4GWSMsC94704R8OPXFapbp0V4RVrH/UVJX+ilnrsx+ygHuN
         OjPsVccaX+33/n9NNsp9uJVesgaqXCv3SL258sPNgM1GpI9q0roN2RNp7zK14RZj0+/2
         kbcA==
X-Gm-Message-State: AOAM533Uvia/cDQsF+iGVBIyMfvaSjfTvhqQgFRBIQYDW1kHVYzMFPUT
        vj97+/nnexjdYW01vVi+Ovw=
X-Google-Smtp-Source: ABdhPJzwGoe3r1UPqUrHoV9XO70tVxS7iM9rErpYXORaXUrC54pyWi6i9EdZQoe2vHnDte6zn3dFAA==
X-Received: by 2002:adf:eb48:0:b0:203:f854:86cc with SMTP id u8-20020adfeb48000000b00203f85486ccmr12661949wrn.102.1647878908236;
        Mon, 21 Mar 2022 09:08:28 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:27 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 12/18] clk: qcom: clk-krait: add apq/ipq8064 errata workaround
Date:   Mon, 21 Mar 2022 16:38:49 +0100
Message-Id: <20220321153855.12082-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321153855.12082-1-ansuelsmth@gmail.com>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
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

