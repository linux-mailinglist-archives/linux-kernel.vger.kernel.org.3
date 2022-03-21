Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA44E2BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349986AbiCUPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349942AbiCUPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42472EDF0B;
        Mon, 21 Mar 2022 08:17:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t11so21180761wrm.5;
        Mon, 21 Mar 2022 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8h0dp/sRCWnE/SzxqBhwWtp3OCJwunZ7486W2HMfBko=;
        b=Z60PkwuF45a94nU3pDR2UUzDhsn150Rvh2gB+Ung2m71vatdGxrP4dLJWflsoYAdHz
         +pjCVTMpDWLMKyl2Y6OSxmlNqJXfaHPaEGk5shhm2ccExJW89JB+0qaO0/fSa04rv3T7
         HkBFAsEyVKs54e6bcul0kgdwcnHYaukpYhOG6+ww8ynG9LOyMetAkTMA76/7rBqIq2dd
         KwWHOh57/IgSp44MmaT8smsC4HbRkJa7/EsjjbLceCjxay+dPBmwjvArVs3jn0EtPrTH
         P7nWco+sg6wLdA01JHRTN2gJLqpcRq+mQ/Ak1FA4apu5sqt9KlVxhUdA9d7xK9KUSZ0z
         E1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8h0dp/sRCWnE/SzxqBhwWtp3OCJwunZ7486W2HMfBko=;
        b=XmdQAK609T26LXwWNGLC+/jRDvZBhHGQuzO0InL8NU21VyEQsLSnf8T0ASuoXHz816
         BHrcVisgXC9FhgX9cwEAD0kbmsAa0WNnLS4Nzcfeq0/kRRo35TW5UEeh7LbpNlUoSkfo
         QVTDj1Topn7xLDeWL+zVp4FLabNnCMHDUm/1Pc+Xb21tXuVbYBCDzHi3t1Tf4qeYXG6H
         tIpDfnLYMHyuwGO3CXxEtrAZgzEgzHKfQmSzXScelyy+vmumt4h+a9Iwv+h9mlMBWn4A
         d1xKRRynHTVkouYFfFpuGEcy41TeCr6qMVLKSuNF4AfzLrkql+f214HhumOsWtfuYURD
         XJ6Q==
X-Gm-Message-State: AOAM530/XLef8lXAqvHa1KdWQ/MB9mZ4xm3uZN2PxdNA5mXX6o9olRiq
        BD1h5DpKT7o9edKVonuuVqo=
X-Google-Smtp-Source: ABdhPJyVphV0iTWxd2pv7sbyrbbMdvHxY2Wi0G2Zz9gj2N03j3KbicFxC/kSLrtfYCP2vxAfCxbfcw==
X-Received: by 2002:a5d:504d:0:b0:203:e60e:49ef with SMTP id h13-20020a5d504d000000b00203e60e49efmr18601562wrt.546.1647875869752;
        Mon, 21 Mar 2022 08:17:49 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:17:49 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 04/18] clk: qcom: clk-hfpll: use poll_timeout macro
Date:   Mon, 21 Mar 2022 15:48:11 +0100
Message-Id: <20220321144825.11736-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321144825.11736-1-ansuelsmth@gmail.com>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
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

Use regmap_read_poll_timeout macro instead of do-while structure.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-hfpll.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
index e847d586a73a..a4e347eb4d4d 100644
--- a/drivers/clk/qcom/clk-hfpll.c
+++ b/drivers/clk/qcom/clk-hfpll.c
@@ -12,6 +12,8 @@
 #include "clk-regmap.h"
 #include "clk-hfpll.h"
 
+#define HFPLL_BUSY_WAIT_TIMEOUT	100
+
 #define PLL_OUTCTRL	BIT(0)
 #define PLL_BYPASSNL	BIT(1)
 #define PLL_RESET_N	BIT(2)
@@ -72,13 +74,12 @@ static void __clk_hfpll_enable(struct clk_hw *hw)
 	regmap_update_bits(regmap, hd->mode_reg, PLL_RESET_N, PLL_RESET_N);
 
 	/* Wait for PLL to lock. */
-	if (hd->status_reg) {
-		do {
-			regmap_read(regmap, hd->status_reg, &val);
-		} while (!(val & BIT(hd->lock_bit)));
-	} else {
+	if (hd->status_reg)
+		regmap_read_poll_timeout(regmap, hd->status_reg, val,
+					 !(val & BIT(hd->lock_bit)), USEC_PER_MSEC * 2,
+					 HFPLL_BUSY_WAIT_TIMEOUT * USEC_PER_MSEC);
+	else
 		udelay(60);
-	}
 
 	/* Enable PLL output. */
 	regmap_update_bits(regmap, hd->mode_reg, PLL_OUTCTRL, PLL_OUTCTRL);
-- 
2.34.1

