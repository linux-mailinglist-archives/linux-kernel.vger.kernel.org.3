Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609864DDE01
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiCRQKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbiCRQKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:10:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF8245B2;
        Fri, 18 Mar 2022 09:08:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u23so8339932ejt.1;
        Fri, 18 Mar 2022 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/RImxULSEIcXltj7eh82B63gODFmYdSpUPrpbmj5VVA=;
        b=Mre129SUos0QigZGiTepLRmoM+DqmTR/OLSwil9AJ/bS7houyWDVpZDi42wYKlSA4p
         Rj25TQCKbx9dQj0eQod7E0QMeO74akMiq+Rx8v/VBYFdsLudSa/QLRcH/jxsYWSsUek4
         WGREYSTPvQjkbfpJQvJGkPKlgPy37dUJEeAcEYHibIyGaPFEleRZ0c4Ptczi2qWA0Pi5
         ruuVvgfSJb6upjLC0jfcgvFtBycbvI08Or1aABsumMYaqlexJ1pOeV8rfmVGWw/o/pRj
         nLmvZiPGUa4oFPznCFrm3DFdHqFsqTm/CScGx9b1oHoMs2Fhj9xQ8Y2XNdGNvDovo0SL
         zIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RImxULSEIcXltj7eh82B63gODFmYdSpUPrpbmj5VVA=;
        b=jLMDoxErjf/ABRU3DIx5t7JbBFCMycHcxj3GqdZb00nRIhe2CXD7YHOAs9sSZtLpAe
         c3OSzvUeBtSJaVwwpZ5wCfWPiz0IEqIeLoCr2NvxqH+swjWgPWpniAE0/KtMBbOEKPQr
         p5utYZVUDWvMij2CShCWReXwJ0CDDFC8t7+zNmro65ux+Ndcga0UgIvi2slxnkRC5+Vv
         v/inzblbIny6YQCJYcGwQE1T5irP4BLJ7bndgGKRGQr16Fnq4hRCx1slm4zice03xx+b
         AEyKnFmAKZjetlRhHSRIETxnrxg3E5UvRxJMrKmvkvHMTuhJcRM7NZyJhwVttnCJCiqS
         lC0w==
X-Gm-Message-State: AOAM533HIlspyHkcXeKbz3CkoTuHQlJPP0apyNpYKWMGL8HHwXlwW8Mg
        fP+0MQStyv4FMcH7Kp6DC7zRd83p9T4=
X-Google-Smtp-Source: ABdhPJzA/H+VijZ8k5uM7408Pw9MByYHTdRFjaZXdPE2cnSlYXwhJU6adYKcjS1wO8I1ACG6RerrKw==
X-Received: by 2002:a17:906:d555:b0:6da:ac8c:f66b with SMTP id cr21-20020a170906d55500b006daac8cf66bmr9458704ejc.107.1647619721489;
        Fri, 18 Mar 2022 09:08:41 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:41 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 12/16] clk: qcom: clk-krait: add apq/ipq8064 errata workaround
Date:   Fri, 18 Mar 2022 17:08:23 +0100
Message-Id: <20220318160827.8860-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318160827.8860-1-ansuelsmth@gmail.com>
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
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

