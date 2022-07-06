Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6215B568C32
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiGFPEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiGFPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:04:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7649715A33
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:04:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v16so11040606wrd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zUHjRI1jr+Yrh9dUueZjZWr58/iaqkxDRzBkA9rclyI=;
        b=Yl8J/2mhUuzM78REsuhuyap1UbHG6jdWDrIww75VUghGmOO1FjKfKNKXB/9Jp/9baS
         XXISx1pqBW+IX9dbVVg4tYE1JTNlP7PEE0HUQN7dN7emEZchaX/5dz/gcvFy9Px1w/Jf
         ofxWJej6Yn+VNo7jevmxhUvjmrWPZAX7Eayn/M9MNecMAKCFbcyPP0bWYTswl/wIZuMz
         oaAb+dLxOjW/phWNhUD5/2D0SqTFvt7/S3Q9ym15HCDID55+fCYiHs+sMyKjeHliWxD6
         DghaBfeRDY8lfxK+W6f72lWjdn6uZuGHNH16kWf0nZU4ubnNsRFto1uxHN9N762AOiLs
         cqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zUHjRI1jr+Yrh9dUueZjZWr58/iaqkxDRzBkA9rclyI=;
        b=Ic4MyYwjWiHKgPjvEXQToA0XGwKAoeJf1GwOG+y7SxaqHIRkaHMvz8yDnE8xaYlmlK
         eRcfRN0OPLJzucQmf2pXCGzjqBhApMzCZQ6iL8HtG5SmPOKGmkDqsU5DaUO73p7aef6K
         o0uJvGdoyntbmrKKoFdYw9Zg6I0cpdXOt411he8u/oL8bsPheJ+Jms2/9g2itRlpCuMP
         p/1bfetliVh+6zxek8RCXB4roEn1pe9aXeRN7oM1XYkQNspyJMJzSMBHU/y2eLsGQXpZ
         6JJ9lXUIdVMCNUngDv9VG4lsLAlhJsoS6s3+pSs0JWKCp9j/nkiKhNJrYY+lGbRyLc1Z
         6JmA==
X-Gm-Message-State: AJIora9w/uvBuLzxLBNdDvC7LPHsk86QnDAQ16aUiAEz0QOiV3D9ra90
        ShDIO9/IoTeIGQ99aiswciLRrQ==
X-Google-Smtp-Source: AGRyM1sTX0EBykUUNSxnDmNCn71gGdN1WibbHuKtCzZndxVWdMyf1gXg/h9NxH+czj+cg9UVEO/qCQ==
X-Received: by 2002:a05:6000:1446:b0:21d:2245:ab65 with SMTP id v6-20020a056000144600b0021d2245ab65mr37797391wrx.315.1657119879727;
        Wed, 06 Jul 2022 08:04:39 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v7-20020a1cac07000000b003a04e6410e0sm22443420wme.33.2022.07.06.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:04:39 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC 2/2] clk: qcom: sdm845: Add clk_sync_state_disable_unused as sync_state
Date:   Wed,  6 Jul 2022 18:04:11 +0300
Message-Id: <20220706150411.708213-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220706150411.708213-1-abel.vesa@linaro.org>
References: <20220706150411.708213-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By adding the newly added clk_sync_state_disable_unused as sync_state
callback to all sdm845 clock providers, we make sure that no clock
belonging to these providers gets disabled on clk_disable_unused,
but rather they are disabled on sync_state, when it is safe, since
all the consumers build as modules have their chance of enabling
their own clocks.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/camcc-sdm845.c  | 1 +
 drivers/clk/qcom/dispcc-sdm845.c | 1 +
 drivers/clk/qcom/gcc-sdm845.c    | 1 +
 drivers/clk/qcom/gpucc-sdm845.c  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/camcc-sdm845.c b/drivers/clk/qcom/camcc-sdm845.c
index 27d44188a7ab..e5aeb832e47b 100644
--- a/drivers/clk/qcom/camcc-sdm845.c
+++ b/drivers/clk/qcom/camcc-sdm845.c
@@ -1743,6 +1743,7 @@ static struct platform_driver cam_cc_sdm845_driver = {
 	.driver	= {
 		.name = "sdm845-camcc",
 		.of_match_table = cam_cc_sdm845_match_table,
+		.sync_state = clk_sync_state_disable_unused,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 735adfefc379..1810d58bad09 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -869,6 +869,7 @@ static struct platform_driver disp_cc_sdm845_driver = {
 	.driver		= {
 		.name	= "disp_cc-sdm845",
 		.of_match_table = disp_cc_sdm845_match_table,
+		.sync_state = clk_sync_state_disable_unused,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 58aa3ec9a7fc..5db75d5ba584 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3624,6 +3624,7 @@ static struct platform_driver gcc_sdm845_driver = {
 	.driver		= {
 		.name	= "gcc-sdm845",
 		.of_match_table = gcc_sdm845_match_table,
+		.sync_state = clk_sync_state_disable_unused,
 	},
 };
 
diff --git a/drivers/clk/qcom/gpucc-sdm845.c b/drivers/clk/qcom/gpucc-sdm845.c
index 110b54401bc6..622a54a67d32 100644
--- a/drivers/clk/qcom/gpucc-sdm845.c
+++ b/drivers/clk/qcom/gpucc-sdm845.c
@@ -205,6 +205,7 @@ static struct platform_driver gpu_cc_sdm845_driver = {
 	.driver = {
 		.name = "sdm845-gpucc",
 		.of_match_table = gpu_cc_sdm845_match_table,
+		.sync_state = clk_sync_state_disable_unused,
 	},
 };
 
-- 
2.34.3

