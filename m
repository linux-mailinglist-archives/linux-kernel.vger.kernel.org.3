Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7E45678F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiGEU4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiGEU4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:56:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFDE15A0B;
        Tue,  5 Jul 2022 13:56:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sb34so23654933ejc.11;
        Tue, 05 Jul 2022 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kUlxRQ1of3eu4XW5c6JjZr01Kt72atQDrgao/HtGT8o=;
        b=miyLqZVDr95MvsZByIU18n/yp0Ra7HJ0BNVK4mKXeV8tRMGr3ngt0Y9Hnl+pOI+2D7
         cWXICRa2OW2HyJYaHu6HORU/kZ3WqTdG7miqXV21G2vsxwnX/R3nyi1XaPIq2bKA8QXy
         Bg3zeqnHhbw/ItfO6WAKVAZhFXtkF0kZMQD8CRPZH95jrc/m0eRzIXKZZ/vDePGkXxLK
         roWoSfLaGK0KMGDHH03HaUiWlReh+SRdtbDTr0iEITBUEnPcZMi4JDY7TP6MNJaYDfrb
         vyTQ1QxIEkMorAiI9PcV2VZamL8+/oaljcHWnN3ebCazzKpEqeUWFADs6ed7LbELLTZq
         Suuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUlxRQ1of3eu4XW5c6JjZr01Kt72atQDrgao/HtGT8o=;
        b=JotKsZ+z+OAvR+uzXg+HWeU8Y4b9e8lpo2v8K1AilGkZtqZNnCsWkYcqfU6+3KCKcE
         qvqURq/Euk/RFkWo0NYEjQA8NRPOHRoKcZK8P+cuwcWrM0fMF1PCksJ1WfhyBgAljXXe
         WN3YtOyRQWzQvIfbVjsGeoonam73V3Qex6gZd2/MR12SU/MY7zIR5FX9+9pd/SAdT2Fa
         A2Sn+pA0s5KPDEEkNRutKVD1s3BaHTCXepbHpK/nmozjh97ZN3gEnfkAc1P/9JA12XAy
         PBt8uY5Bx6oE3iDYr7HUOnxEYBdmce+M7z8Q5UzYWN02iATY39zwlSJDvLRilvsxEkBS
         aJyg==
X-Gm-Message-State: AJIora/H+E3+6Lc6cXa3Q4h8U8+jfsCl9fw9soPJw6jZlZpRPWUqe5x6
        pY41tWYv8TFXmhfgP6iyAbg=
X-Google-Smtp-Source: AGRyM1tkrgcFjXCiCX34Lg+Lnqb+x2ssJiae/UJXSnmXTeK4u1T3oF/r+ctDrKsKTu5KdSyy0vKxdw==
X-Received: by 2002:a17:906:5189:b0:722:dc81:222a with SMTP id y9-20020a170906518900b00722dc81222amr35711482ejk.502.1657054565390;
        Tue, 05 Jul 2022 13:56:05 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id dm3-20020a05640222c300b0043a70c51470sm3836956edb.55.2022.07.05.13.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:56:05 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 5/5] clk: qcom: gcc-ipq806x: remove cc_register_board for pxo and cxo
Date:   Tue,  5 Jul 2022 22:28:37 +0200
Message-Id: <20220705202837.667-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705202837.667-1-ansuelsmth@gmail.com>
References: <20220705202837.667-1-ansuelsmth@gmail.com>
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

Now that these clock are defined as fixed clk in dts, we can drop the
register_board_clk for cxo_board and pxo_board in gcc_ipq806x_probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 718de17a1e60..883629de2751 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3384,14 +3384,6 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int ret;
 
-	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 25000000);
-	if (ret)
-		return ret;
-
-	ret = qcom_cc_register_board_clk(dev, "pxo_board", "pxo", 25000000);
-	if (ret)
-		return ret;
-
 	if (of_machine_is_compatible("qcom,ipq8065")) {
 		ubi32_core1_src_clk.freq_tbl = clk_tbl_nss_ipq8065;
 		ubi32_core2_src_clk.freq_tbl = clk_tbl_nss_ipq8065;
-- 
2.36.1

