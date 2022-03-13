Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453DA4D77D1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiCMTHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbiCMTGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806BB50B13;
        Sun, 13 Mar 2022 12:05:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a8so29583203ejc.8;
        Sun, 13 Mar 2022 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ULORFmB1Gv653NhwYAC6GyuMCDu1OWN34Ide113fYeY=;
        b=jLZx6wHRAQlKhDJq8r1pf+twX5RsUltvQMFTKUyaZOIJHmvCGm60JM5AWPsMmoo9kf
         4f2Zh1MzbE5QaCzShn8HEoVMDNi+Iwe9y1GR7uPw/9ddI8tbEZLFnAT37eb6rPn4NA2i
         Z6MztMJafR88Nmu4cUhShdLBFS6s1GhpnbhbOmJn19eqfP2JTZ3pK8HVQavg0SwjBurd
         AEP7MqUReH6kgOEE8xR3Er930To+yPqhshHnGUTWaqxqGkdLGM+oF8SpbGwWpmSylEOX
         ONYf3wzXmrwd6X1XaNNjvL0hWZju7iMng6aYOIAqTSvhmBoHWrOvLzWQOpRLnLFVh8PN
         Xbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ULORFmB1Gv653NhwYAC6GyuMCDu1OWN34Ide113fYeY=;
        b=39o98h+pZPqhWehlVh62zZwciQ4J+JmxWZ1yafDeg3Hg0KfngA7Lmti7nJxivZPzQ/
         KW7VDej7gDwSVwdO+2twHyvInJSc6npb8gImHGCDYja1U3ACpRQSPxZiNu8LQt8Z2Z6j
         9jcYQ4nTMhN4LIJS4EWNhW5Y0EdxmOqDlOw2clslc01yy/Qb3z99QBZHy11thOUhDrnb
         aPTuUqdDSuMpVG07oor48SQcrvgd0zGvpuCce++Z8DF1PX/wEvccpwrSC3zbNahX32oR
         kkXDNRkE6/bJLwRslSdciM0N1Hn6t5eluT3fCmw/iLYWIKuzp6ayGyqNb3+pgi3Q9JED
         ZDxw==
X-Gm-Message-State: AOAM5329zy5sS7fo3LMkoP8vRV3a/IgiBjwnmhmYYBTS/edThzbbB2vq
        BmlJFJhdTodwQuQpEN3hY1o=
X-Google-Smtp-Source: ABdhPJxRL8RZcsidjudMbrw77ttd/RNpbT/GvMdVejgX0mXy/oMdLgL07Djq6C91LDW0EBoL1481gQ==
X-Received: by 2002:a17:906:9b8f:b0:6db:ab62:4713 with SMTP id dd15-20020a1709069b8f00b006dbab624713mr9662533ejc.738.1647198315903;
        Sun, 13 Mar 2022 12:05:15 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:15 -0700 (PDT)
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
Subject: [PATCH 13/16] clk: qcom: clk-krait: add enable disable ops
Date:   Sun, 13 Mar 2022 20:04:16 +0100
Message-Id: <20220313190419.2207-14-ansuelsmth@gmail.com>
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

Add enable/disable ops for krait mux. On disable the mux is set to the
safe selection.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 82fe7031e1f4..fc277fe3841c 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -85,7 +85,25 @@ static u8 krait_mux_get_parent(struct clk_hw *hw)
 	return clk_mux_val_to_index(hw, mux->parent_map, 0, sel);
 }
 
+static int krait_mux_enable(struct clk_hw *hw)
+{
+	struct krait_mux_clk *mux = to_krait_mux_clk(hw);
+
+	__krait_mux_set_sel(mux, mux->en_mask);
+
+	return 0;
+}
+
+static void krait_mux_disable(struct clk_hw *hw)
+{
+	struct krait_mux_clk *mux = to_krait_mux_clk(hw);
+
+	__krait_mux_set_sel(mux, mux->safe_sel);
+}
+
 const struct clk_ops krait_mux_clk_ops = {
+	.enable = krait_mux_enable,
+	.disable = krait_mux_disable,
 	.set_parent = krait_mux_set_parent,
 	.get_parent = krait_mux_get_parent,
 	.determine_rate = __clk_mux_determine_rate_closest,
-- 
2.34.1

