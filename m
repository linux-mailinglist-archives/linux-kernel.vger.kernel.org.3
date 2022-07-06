Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6839456958A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiGFWyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiGFWya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:54:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA0124BEE;
        Wed,  6 Jul 2022 15:54:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r18so21012905edb.9;
        Wed, 06 Jul 2022 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70ArcNGj890gaijyE1Qj+S01sRqH0gGAcpKoaVXKgAU=;
        b=DuUHkzM9LHLiS5jnzorB3uQ5RigZQJfeuxOQkmkMH1VQLeAZ972IS1jOMQUPs7C/Q7
         pJ7T2vkpV6P+x3fmhx1uhsEIEof7/5+kMVIgTDqG+X/oXi2mk5khb9YtVnp3RlSq00/l
         Vqr5+FE+bKlB83ZDUlr4izHeKvI2lZMmSza4A7ouR2IbmXdCXsw/bYeAw2RL/him4S+T
         fP+UORyHnMvPY9XM5GgHC5TNrdHOnwSDlfu+m5hgM0QXOEQdjGhPRs6fq/HAxNJ4woQd
         QRZcy4AkGafHL0eRzIEILP6MQ6mVKYuPZg8+bEuKCNmPb6do+o0HrR7iWwsnk9AwBowr
         TRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70ArcNGj890gaijyE1Qj+S01sRqH0gGAcpKoaVXKgAU=;
        b=dKN57ZIAIdD0To2SRTsqVgUVz+DumncAT21hgAbZplParING9emvPL5ysmB36NQl8q
         1NigsY5/FLdx3zycupXncBgCYG+Xxopan8nrBW55+xxmiQ76AYr4I0wVYtJPV37+k7/U
         mFZGWEmVo2kdZ5N9nUyBLjozd/92Ia6rgXk6xRe1zXCFZnSS9FbpXRfOUQFMJiSv8Ktm
         1poNhPSAxMs78m8sxtxba7tN+e1Ye/P0AFHz9ATxvu2Hsy4iOU9pb4dQtGuMbRQTt7A6
         Z2iVGbt+N6Rw22AoQzI4/e870iUZlz4ODtrMFIGNSyCYcsX8XzVuTFJhB77CLOZz/H9f
         deUw==
X-Gm-Message-State: AJIora+Nbi62TISIBSZkRPthN8iZi46wmDZGfaO05ao17Fe0V6VB2fSi
        kfFIYiGKqyJXQ4lXsRyMAnw=
X-Google-Smtp-Source: AGRyM1sltlrAA8dGjvSE8ZUVcdb/qq1RxdByeIBvvQSNIQP6m3hSUe9oGyI285/yFiO1TxkbT0GXOw==
X-Received: by 2002:a05:6402:5215:b0:43a:8a94:f514 with SMTP id s21-20020a056402521500b0043a8a94f514mr7785957edd.22.1657148067776;
        Wed, 06 Jul 2022 15:54:27 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id d7-20020a170906304700b006fe921fcb2dsm1767637ejd.49.2022.07.06.15.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:54:27 -0700 (PDT)
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
Subject: [PATCH v2 3/4] clk: qcom: clk-rpm: convert to parent_data API
Date:   Thu,  7 Jul 2022 00:53:20 +0200
Message-Id: <20220706225321.26215-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706225321.26215-1-ansuelsmth@gmail.com>
References: <20220706225321.26215-1-ansuelsmth@gmail.com>
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

Convert clk-rpm driver to parent_data API.
We keep the old pxo/cxo_board parent naming to keep compatibility with
old DT and we use the new pxo/cxo for new implementation where these
clock are defined in DTS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-rpm.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
index a18811c38018..747c473b0b5e 100644
--- a/drivers/clk/qcom/clk-rpm.c
+++ b/drivers/clk/qcom/clk-rpm.c
@@ -23,6 +23,14 @@
 #define QCOM_RPM_SCALING_ENABLE_ID			0x2
 #define QCOM_RPM_XO_MODE_ON				0x2
 
+static const struct clk_parent_data gcc_pxo[] = {
+	{ .fw_name = "pxo", .name = "pxo_board" },
+};
+
+static const struct clk_parent_data gcc_cxo[] = {
+	{ .fw_name = "cxo", .name = "cxo_board" },
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

