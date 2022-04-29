Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E705148CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358907AbiD2MIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358868AbiD2MHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:07:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE5BC866F;
        Fri, 29 Apr 2022 05:04:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e23so8798386eda.11;
        Fri, 29 Apr 2022 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EC9ILjDGL3YF8DKjgFAU1/3Xp1zrJQq7k7xRaKAybfM=;
        b=D+iWrmXg19BEad+DLw8cIOPvJlYhItIDdZqTuyZybVcCxroDVkJ97vSPWnwlIXwFzU
         ZoRoSZ/QLyhOkA1/okvQYXbeS90QiZqtfXswQyGvnOLSCUxkP73g0hpbfXHVl6Ko9mRP
         XW0nnV3XtvgwPyrBDeDzXEYk3wBi3l7c1qsPEXFIYtTGlAFFbmZPiHRQySrwoAQafHnP
         J9/baeXOH7Wlw8dN6g1QerJ50e1CTkvwjgHq31SVWWNu1A8JfcXKuEsNgIq6RySt6xVi
         gGq9zm9cfe15HzTLnjoMOa7nYcWIwT1cyfvIo/V45ODkiltO5AH5fFPQ0+klLrKRUHcV
         KZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EC9ILjDGL3YF8DKjgFAU1/3Xp1zrJQq7k7xRaKAybfM=;
        b=jesgliccKwrpcTjZKtUJgEFUwFZQ04d8gPxQujDBT0dcFqzP90FNUqefngEEzitWr+
         biXC+uSX24UkmVlZKMmEYVGtpLUwohiwcCe17mLc7aRlRHqEaLXplN608JEAmR+wSbMg
         9mm49bTREi48lpsZblKUTkq/Khx/hdJyJZk2oHIR2in+PUeJe5WizJl9AOz22yArkDdY
         79fkL2gAARpjfXjgf8gVLRy7g5WdEbCoHvjEX4mSrsVtemDytVK6CBOpNcdFH50BH6rq
         4upHuTuAoqjTGJpF+DxJiA+moaV2rEKbR0Y9gssLHbgYhU21k35+wxl/mrwwN5bzw4E9
         UURQ==
X-Gm-Message-State: AOAM532P9r6PwR2+gG8lddQULMo0Vy00gX/kBSzzFEHLjWTUwbqfpvk+
        1o/plEQdXzxxmV3ofmMUJwLb1Qfmjqs=
X-Google-Smtp-Source: ABdhPJx1+RF5T8GZpmW1o93stK0/PvpCeUxoJ0xeV0iatikrqIWy41vwCDxagNkza9zDakDxP7aiDA==
X-Received: by 2002:a05:6402:254a:b0:424:1ed9:e173 with SMTP id l10-20020a056402254a00b004241ed9e173mr41785315edb.276.1651233871725;
        Fri, 29 Apr 2022 05:04:31 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id eo9-20020a1709069b0900b006f3ef214e02sm581338ejc.104.2022.04.29.05.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:04:31 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 4/4] clk: qcom: clk-krait: add apq/ipq8064 errata workaround
Date:   Fri, 29 Apr 2022 14:01:08 +0200
Message-Id: <20220429120108.9396-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429120108.9396-1-ansuelsmth@gmail.com>
References: <20220429120108.9396-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 6c367ad6506a..4a9b3296c45b 100644
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
index 4d4b657d33c3..0f88bf41ec6e 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -138,6 +138,7 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 	mux->parent_map = sec_mux_map;
 	mux->hw.init = &init;
 	mux->safe_sel = 0;
+	mux->disable_sec_src_gating = true;
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
 	if (!init.name)
-- 
2.34.1

