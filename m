Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03A3567761
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiGETKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiGETKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:10:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC2515FE8;
        Tue,  5 Jul 2022 12:10:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x10so9162484edd.13;
        Tue, 05 Jul 2022 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tU6uMaYficFOXva4xeM/4aLqe2TPDWlHeWmOttB+92A=;
        b=jH3qhLlqZb0nc/oq4t7EFoPKLxaQPgi3X0JqKTDlAjwn3T5TJ26rnfltAMc2ai4vOa
         Oc+9XlpVdSmNCvL83QtNo3Js/+/4Rh1L7YWBDIjD0YgotPzQJO3mrQ2yewlqP6VrlLvN
         2o3C7M2infcYeHzXPW1msEvIgr0K44gwIFbfuMz25H1AwbUPRuRDVObHzVTpj93LHpxb
         glD75OphKTHLLjZ1nbjcBV5GG8DQSMuRSp/R/X2fOTSeeMMY0bciikGcZyQMp4L5txUN
         9pKVra1XGMiVEAiuJTjW2Ls2PbubVaN6lJpue+UyLtC9f3J/3GiowivW94KF5XMlnX7d
         1wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tU6uMaYficFOXva4xeM/4aLqe2TPDWlHeWmOttB+92A=;
        b=lHhjYzDvtMLf0vOS/Ly67Ja+mtHUQfD2vpsofpzYrcjGtbLWZl5qW5haQP0CIxQ8RE
         6P0ZqtRHjSn6U94RKr85f2trv+OtVSBJVeTSWZNW/30zu/1be+bcmoJLxWTPTiUejO6b
         /HdQllTLwUSxFzyQTC6uQz9U2abgqTHrwlsP0sG6gMNwac7uqW3ar3kq+w3CC8e0mugZ
         nXiMG9WEpdmM6XsFfKF/Dw5wNp49WYW/z1xVQWcNopuCb/JuQzEVGNLGqk2fVtVdzKV8
         I45UcSnhpoPbd+Q8/AX9zjRld+qQr4fUYrWt9lMQkINE9Zhpzy4wD4z1lxZWfZN3hms2
         RPsw==
X-Gm-Message-State: AJIora8/uTqLLz+Y50HLlOp5PIxYKBp+kiCWiHBpnyLfk5RwE0rIGCHg
        0upMpOvZd6vLD324AdhB7pk=
X-Google-Smtp-Source: AGRyM1sZ6h91jZ7h6i52CKxzTxQaFPpz5nmhxai745SiA89Dr8J4qYwX2yadkEkyq1GhxPdx8u3oGw==
X-Received: by 2002:aa7:c45a:0:b0:435:d7a4:99bc with SMTP id n26-20020aa7c45a000000b00435d7a499bcmr48299777edr.158.1657048219306;
        Tue, 05 Jul 2022 12:10:19 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-13.xnet.hr. [88.207.99.13])
        by smtp.googlemail.com with ESMTPSA id es25-20020a056402381900b0043a6b86f024sm4519342edb.67.2022.07.05.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:10:18 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 1/3] clk: qcom: clk-alpha-pll: add support for APSS PLL
Date:   Tue,  5 Jul 2022 21:10:15 +0200
Message-Id: <20220705191017.1683716-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

APSS PLL type will be used by the IPQ8074 APSS driver for providing the
CPU core clocks and enabling CPU Frequency scaling.

This is ported from the downstream 5.4 kernel.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 12 ++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 4406cf609aae..8270363ff98e 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -154,6 +154,18 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_TEST_CTL_U] = 0x30,
 		[PLL_OFF_TEST_CTL_U1] = 0x34,
 	},
+	[CLK_ALPHA_PLL_TYPE_APSS] = {
+		[PLL_OFF_L_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL_U] = 0xff,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0xff,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0x24,
+		[PLL_OFF_TEST_CTL] = 0x30,
+		[PLL_OFF_TEST_CTL_U] = 0x34,
+		[PLL_OFF_STATUS] = 0x28,
+	},
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 6e9907deaf30..626fdf80336d 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -18,6 +18,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_AGERA,
 	CLK_ALPHA_PLL_TYPE_ZONDA,
 	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
+	CLK_ALPHA_PLL_TYPE_APSS,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
-- 
2.36.1

