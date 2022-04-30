Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F75515D16
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355071AbiD3M4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241936AbiD3M4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:56:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9A860AA6;
        Sat, 30 Apr 2022 05:53:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g20so11863029edw.6;
        Sat, 30 Apr 2022 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aIciRzMYkPzkWig+LRqnWt0TUAKSu0ybKrdfIEn8ELs=;
        b=hKFZj3/poS2k6vehXqzJjUZj7lYJotX+HhSK81+6TdiszUC6ARUqOyjqCdoTV+2771
         hoLw+dWMsU10TEXeHOH7eLnx24FM2HxeOB8ksqhEPVIj8lbFrfD9ePQB7lqHmjBk0V+i
         ebVtT0ed8mo3E8TqZt79vl5xsQSdDFOYx74PS4poXbjqw8aMfnpDKoeB6NBZ9EmpJkn2
         brQMbUeCcGoqY6vrfTtBzxJaNqeSfhGdyDL21moqaloosq8189F7MvciEyCTtSiZeEFt
         AJl770S7qW8aMDGYxUcveM/ZvFJZcHGOnXwAouBXLu5VTST2Sa6xgZacj6jZCvVUSZNa
         x44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aIciRzMYkPzkWig+LRqnWt0TUAKSu0ybKrdfIEn8ELs=;
        b=qgjVlslTdLWjBaED17fcIDZJPkmIE1pTqrqzTOqpYEVp5V7Naj1++leWMv67FI8Klf
         mW6TBH9DEAuGQ3hMWRYEtPb0jgcsThuxHKmWuPyabq9nYH8qvMdtMLbuVP2FYFQfbkbu
         9ZtbeopAZ3RPPiCZ5GQzLmMJTp3+x4jBvu/EWdffOszzq5Bhvx2iFUTu3mlSnT0oLNTt
         AuzrwpRw1JKLZMqwOV41++lo2NE08YbDGWg8xY/pAh9e6KTrz2+gYIbJP7QYc1J9M3F7
         QXOBhe/PreqprCyXEUMrhsqijALMJNhjCM/IM1z0+dqgHS14nZ3bCpKIp4muOv1K/cNf
         e74A==
X-Gm-Message-State: AOAM533Z4ge9+UGH+XtDQsIQJS1YUrRvN5dGEpUwdjqM4zfsUFQo5tBi
        XStYJeyCLHU2pTOgqno7/7f0m19z1/Q=
X-Google-Smtp-Source: ABdhPJy2h6rIHiYMLoby/9pT0hFxIKZSyn6LwkfW77ktbhv0M96NEht68ivMa/+J8v57jqkEN3gXZg==
X-Received: by 2002:aa7:da08:0:b0:425:af3c:196a with SMTP id r8-20020aa7da08000000b00425af3c196amr4325510eds.69.1651323198687;
        Sat, 30 Apr 2022 05:53:18 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id jl25-20020a17090775d900b006f3ef214dc5sm1597209ejc.43.2022.04.30.05.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:53:18 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 3/3] clk: qcom: clk-krait: add apq/ipq8064 errata workaround
Date:   Sat, 30 Apr 2022 07:44:58 +0200
Message-Id: <20220430054458.31321-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220430054458.31321-1-ansuelsmth@gmail.com>
References: <20220430054458.31321-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add apq/ipq8064 errata workaround where the sec_src clock gating needs to
be disabled during switching. krait-cc compatible is not enough to
handle this and limit this workaround to apq/ipq8064. We check machine
compatible to handle this.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 16 ++++++++++++++++
 drivers/clk/qcom/clk-krait.h |  1 +
 drivers/clk/qcom/krait-cc.c  |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 90046428693c..45da736bd5f4 100644
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
index 4d4b657d33c3..cfd961d5cc45 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -139,6 +139,14 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 	mux->hw.init = &init;
 	mux->safe_sel = 0;
 
+	/* Checking for qcom,krait-cc-v1 or qcom,krait-cc-v2 is not
+	 * enough to limit this to apq/ipq8064. Directly check machine
+	 * compatible to correctly handle this errata.
+	 */
+	if (of_machine_is_compatible("qcom,ipq8064") ||
+	    of_machine_is_compatible("qcom,apq8064"))
+		mux->disable_sec_src_gating = true;
+
 	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
 	if (!init.name)
 		return -ENOMEM;
-- 
2.34.1

