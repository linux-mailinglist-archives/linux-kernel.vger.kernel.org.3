Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFDB50F93A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244581AbiDZJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346374AbiDZJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:47:33 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD4184;
        Tue, 26 Apr 2022 02:03:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c15so21051351ljr.9;
        Tue, 26 Apr 2022 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Si96HTniFqAHPeuy1DolLYYuwT3M1Hn5V7Wkw5gU8dw=;
        b=I+zMLdnK0IsKBTQHU/XV/hEh4vvw0myMCRtn4sbatiHozSMkOGb0FOsgBwA/vfVjhD
         uU3Wiv1PLIRpzYcRSCNwViH2i0lwYGHFTaY2x93DkdzTQeM9+yTozlQdsu1MwoDTeEfA
         LQwypL7I8OR19vYMCUMA9bgIFROc42Fk+7758yQa+ZGI6I3Je+iRLrEGRvJFPQEDP1YH
         eg5btLnW9fI1aWbIFt5yGI1wx0SJGRfUyi3NkT7Obcs8U1PTFPkhV8SxVCMe8YEIDRbJ
         95YjluZXoumd/xFuH+z8ChJ5PBx7lJtuoHAqfgeNSPK6o5e9hHuIP3vPMS8mzs7OfhmG
         IKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Si96HTniFqAHPeuy1DolLYYuwT3M1Hn5V7Wkw5gU8dw=;
        b=F3ad8Ygr3euGH+2PkLYDcUz/aaAV5iEzxt81R1E+iJ7x1ODJ5Co3SfDKgJ11DXMQaE
         /kgS/Qncg+tUNMnG6ElySDrwhsvoMqUUDAFRbJUTeq3mxUo02O+jZkF9k6bo1BvIFs6W
         RqQdfdXjarGTBzc+sDef9qoL0YMizmTNojH+yX5+v7rYUxyW16tnPsdhAHYyL+dS4NUf
         CrTmcSahgX1whqIfLyZwaV5YjbQHyU1wIuvzJk8agSETivkqOs4nlg9yE4zWWIe8pia1
         6rFmAw/N602N3dPUP2SV71+KpCyJ8ONHBDuZvB8wXzfeSEbrK78mQNHPrq8g6qLKTVRU
         tEiQ==
X-Gm-Message-State: AOAM5328jPU/RLz/yhUjbqM3bI1/Uq7zJRJg/Bh1AY7K4TGoJCZwN8fY
        teipAvg8NKDd3o6CStZkbwH4svJxX0o=
X-Google-Smtp-Source: ABdhPJyp8ibW5mSQfSOznK4zZ6YB3MyymZuzLrP+5/DL3Ssiv5SEM3UZA1quuwjQGYWglB+c6A0XgQ==
X-Received: by 2002:a2e:b901:0:b0:24f:f84:9793 with SMTP id b1-20020a2eb901000000b0024f0f849793mr6657359ljb.256.1650963796118;
        Tue, 26 Apr 2022 02:03:16 -0700 (PDT)
Received: from localhost.localdomain (adla4.neoplus.adsl.tpnet.pl. [79.185.4.4])
        by smtp.gmail.com with ESMTPSA id i6-20020a198c46000000b0044424910c94sm1676907lfj.113.2022.04.26.02.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 02:03:15 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: smd: Update MSM8976 RPM clocks.
Date:   Tue, 26 Apr 2022 11:02:17 +0200
Message-Id: <20220426090226.27293-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
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

MSM8976 does not have rpm clock named mmssnoc,
instead it's called sysmmnoc, drop define and reuse.
While we are at it add XO clock to list.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/clk/qcom/clk-smd-rpm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index afc6dc930011..10b4e6d8d10f 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -563,17 +563,19 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8974 = {
 	.num_clks = ARRAY_SIZE(msm8974_clks),
 };
 
-DEFINE_CLK_SMD_RPM(msm8976, mmssnoc_ahb_clk, mmssnoc_ahb_a_clk,
-		   QCOM_SMD_RPM_BUS_CLK, 2);
 DEFINE_CLK_SMD_RPM(msm8976, ipa_clk, ipa_a_clk, QCOM_SMD_RPM_IPA_CLK, 0);
 
 static struct clk_smd_rpm *msm8976_clks[] = {
+	[RPM_SMD_XO_CLK_SRC] = &sdm660_bi_tcxo,
+	[RPM_SMD_XO_A_CLK_SRC] = &sdm660_bi_tcxo_a,
 	[RPM_SMD_PCNOC_CLK] = &msm8916_pcnoc_clk,
 	[RPM_SMD_PCNOC_A_CLK] = &msm8916_pcnoc_a_clk,
 	[RPM_SMD_SNOC_CLK] = &msm8916_snoc_clk,
 	[RPM_SMD_SNOC_A_CLK] = &msm8916_snoc_a_clk,
 	[RPM_SMD_BIMC_CLK] = &msm8916_bimc_clk,
 	[RPM_SMD_BIMC_A_CLK] = &msm8916_bimc_a_clk,
+	[RPM_SMD_SYSMMNOC_CLK]	= &msm8936_sysmmnoc_clk,
+	[RPM_SMD_SYSMMNOC_A_CLK] = &msm8936_sysmmnoc_a_clk,
 	[RPM_SMD_QDSS_CLK] = &msm8916_qdss_clk,
 	[RPM_SMD_QDSS_A_CLK] = &msm8916_qdss_a_clk,
 	[RPM_SMD_BB_CLK1] = &msm8916_bb_clk1,
@@ -586,8 +588,6 @@ static struct clk_smd_rpm *msm8976_clks[] = {
 	[RPM_SMD_BB_CLK1_A_PIN] = &msm8916_bb_clk1_a_pin,
 	[RPM_SMD_BB_CLK2_PIN] = &msm8916_bb_clk2_pin,
 	[RPM_SMD_BB_CLK2_A_PIN] = &msm8916_bb_clk2_a_pin,
-	[RPM_SMD_MMSSNOC_AHB_CLK] = &msm8976_mmssnoc_ahb_clk,
-	[RPM_SMD_MMSSNOC_AHB_A_CLK] = &msm8976_mmssnoc_ahb_a_clk,
 	[RPM_SMD_DIV_CLK2] = &msm8974_div_clk2,
 	[RPM_SMD_DIV_A_CLK2] = &msm8974_div_a_clk2,
 	[RPM_SMD_IPA_CLK] = &msm8976_ipa_clk,
-- 
2.25.1

