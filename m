Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548035678F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiGEU4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiGEU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:56:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF3514D3D;
        Tue,  5 Jul 2022 13:56:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f26so812344ejl.4;
        Tue, 05 Jul 2022 13:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pxGLgqzAqc2l8/ddgANBnUDCCoY1u5ohBwZ73O4BlQ=;
        b=LioSRr8uLOdD4wJfnGoyW7I38zarpcZSYK6pbWcurbClBkdAY1FNnzqJ6UslL8WOkk
         jO+MD20ygtas4RPU+rU6pZ4x7AT++xpFViRA4e4kA3nlqpYPJThum0AO3whwsaETXSUp
         VEGf5DelS++fbMSQizieo155t1BsiSYH1o0eH+puiwrG87T5dYC8tereZv+7WjzPFUnz
         MsliTk9rvzGqn/5VscyIx5uqFO8i8w+brmbvBPIiTw1n3s5EoV39lrrCZdqKsmoyJN60
         +TDlin0PvEpOfpfrlZ0bLdWTaEmoww9U5T/+SGIBu1ilAJ72ip0jU4IEs0J2jAFIXGfl
         qqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pxGLgqzAqc2l8/ddgANBnUDCCoY1u5ohBwZ73O4BlQ=;
        b=Oa12XZteV4hfJMgSM1XQXuhAbFGTNoqVBo1eM5etg1hogjAFFDpXUWoXkhb5waZO68
         WSP2Ftqjk/SqbbfpWT+Uh3g2E2mgLoMV0PsUtNzCdU8jJhh3hCk63mK5/tBOMi35qBwS
         Pya35EPwMPsJmNuGF2e+zeGOdXyRRp9FTKypPxN+oQz+31J2MVfl3X9Og0PNbyose3sy
         OeYplRePCowGixXC7JBgBhmZyNYYtu32AiOvc2svTgQ71KkmPIzIi9Mh5DZfwz/ZAMfB
         bMVUezJ5fYYeJY59/C8H3kVQKiaNZMQCLar0tNPzKiu9VCIUhZ912IUDpsBH0n42zM71
         MLag==
X-Gm-Message-State: AJIora84RcOb724xW25imaoKbln0+E9D3yqwFx9PsvOKme1hCRQbqW8u
        FCJs2M/LSCpRzsmky9TnPO0=
X-Google-Smtp-Source: AGRyM1sbftGN1BJPGRPcnZkK9dHdSsBdkzB+AOczKdOp05PVuXAhxpHsPDU80I4FNtO80u166bBjJw==
X-Received: by 2002:a17:906:478e:b0:722:f84d:159f with SMTP id cw14-20020a170906478e00b00722f84d159fmr36093911ejc.182.1657054563348;
        Tue, 05 Jul 2022 13:56:03 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id dm3-20020a05640222c300b0043a70c51470sm3836956edb.55.2022.07.05.13.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:56:03 -0700 (PDT)
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
Subject: [PATCH 3/5] clk: qcom: clk-rpm: convert to parent_data API
Date:   Tue,  5 Jul 2022 22:28:35 +0200
Message-Id: <20220705202837.667-4-ansuelsmth@gmail.com>
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

Convert clk-rpm driver to parent_data API and change parent names to cxo
and pxo instead of the board variant as pxo_board is an ancient name and
pxo should be used instead.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-rpm.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
index a18811c38018..d45a8b0fc97c 100644
--- a/drivers/clk/qcom/clk-rpm.c
+++ b/drivers/clk/qcom/clk-rpm.c
@@ -23,6 +23,14 @@
 #define QCOM_RPM_SCALING_ENABLE_ID			0x2
 #define QCOM_RPM_XO_MODE_ON				0x2
 
+static const struct clk_parent_data gcc_pxo[] = {
+	{ .fw_name = "pxo", .name = "pxo" },
+};
+
+static const struct clk_parent_data gcc_cxo[] = {
+	{ .fw_name = "cxo", .name = "cxo" },
+};
+
 #define DEFINE_CLK_RPM(_platform, _name, _active, r_id)			      \
 	static struct clk_rpm _platform##_##_active;			      \
 	static struct clk_rpm _platform##_##_name = {			      \
@@ -32,8 +40,8 @@
 		.hw.init = &(struct clk_init_data){			      \
 			.ops = &clk_rpm_ops,				      \
 			.name = #_name,					      \
-			.parent_names = (const char *[]){ "pxo_board" },      \
-			.num_parents = 1,				      \
+			.parent_data = gcc_pxo,				      \
+			.num_parents = ARRAY_SIZE(gcc_pxo),		      \
 		},							      \
 	};								      \
 	static struct clk_rpm _platform##_##_active = {			      \
@@ -44,8 +52,8 @@
 		.hw.init = &(struct clk_init_data){			      \
 			.ops = &clk_rpm_ops,				      \
 			.name = #_active,				      \
-			.parent_names = (const char *[]){ "pxo_board" },      \
-			.num_parents = 1,				      \
+			.parent_data = gcc_pxo,				      \
+			.num_parents = ARRAY_SIZE(gcc_pxo),		      \
 		},							      \
 	}
 
@@ -56,8 +64,8 @@
 		.hw.init = &(struct clk_init_data){			      \
 			.ops = &clk_rpm_xo_ops,			      \
 			.name = #_name,					      \
-			.parent_names = (const char *[]){ "cxo_board" },      \
-			.num_parents = 1,				      \
+			.parent_data = gcc_cxo,				      \
+			.num_parents = ARRAY_SIZE(gcc_cxo),		      \
 		},							      \
 	}
 
@@ -68,8 +76,8 @@
 		.hw.init = &(struct clk_init_data){			      \
 			.ops = &clk_rpm_fixed_ops,			      \
 			.name = #_name,					      \
-			.parent_names = (const char *[]){ "pxo" },	      \
-			.num_parents = 1,				      \
+			.parent_data = gcc_pxo,				      \
+			.num_parents = ARRAY_SIZE(gcc_pxo),		      \
 		},							      \
 	}
 
-- 
2.36.1

