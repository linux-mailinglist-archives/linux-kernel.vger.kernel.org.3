Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41239511B31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbiD0NPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiD0NPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:15:37 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0E16D4F1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:11:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a21so1908310edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6yWm7+Ar/4/8ayNYRDPQr7wAj2ROmSNoWWzHAVHw54=;
        b=ij/XleydR+SleEyXBjGFG/HQA1aEsJeShqUBA6BtP4LpAowu7b1m0FdAzyd8gU9LC2
         +kMxCJbDAn6n30PjehDqb/meI9B5aGprQ6ijfY6vUlvdcvr3L2F0M3kTXgKaOi1Q8M+U
         AuObFWNrehCnSoAfkOf0bdKX4IocNMV5QpWKahUlvi0RshJpTxKngRu31/SND4JnDIuJ
         h5GZ0K4xsqbXE9iX+bMtHgKNA57TytK0qy+b7zmMwGpznu+SC80C/3m0BQXtQfxsojRQ
         vP8hP0yQ86olMlhPU0EhPh9Vmii6O4/P6R1O+nsKC+uQAQhajScG6ES+xCsNn74ZYs/P
         VuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6yWm7+Ar/4/8ayNYRDPQr7wAj2ROmSNoWWzHAVHw54=;
        b=XZ+8z+15NWTGwTL31r/D9dwQklAZX8QSm3A5ftSqfB03E5oFMLaPKbS3xGX4TcAkjL
         76Jo018jo0cH3+Jvdye5hhc4btpG+S5h7cThyWcZQsulcUomGmkFIr+GIk/LeoLpvQeU
         xdur94E2mcenY6kG7Z11Q+xw3if/0kV1cwoBKmwZX2P1Tr02vra7mdCTWGJUyW2wYoTQ
         0IZmTEBd/5ShlMBLz34xtmNyoONfOrGRqVJfmoeIIfb9oRlRHmPXPqVmseadLujftTCi
         OVeM4pyR22sUc1WQ3XbImqZiTQ3QXoDEUwcBY2tg6Lfbstq+hUDl/bTJj/S6Kq2Vi+dP
         C4SA==
X-Gm-Message-State: AOAM533nLQqXOt1kCVT+UXOY4ZLgZpq1zT61PD3VRKQjEUxV6T5QQNTy
        +Xl1nZ4dS8jS8Et6imBBgMLsSw==
X-Google-Smtp-Source: ABdhPJz5+9LnLTZP1P6DGBG7H11HpFJTuxT+GgXeaAOHBUOkEJhdxgwd9iWi5Prh4Wh/wAEdmNl7iw==
X-Received: by 2002:a05:6402:50d0:b0:423:f4a1:597d with SMTP id h16-20020a05640250d000b00423f4a1597dmr30107203edb.228.1651065117534;
        Wed, 27 Apr 2022 06:11:57 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o23-20020a509b17000000b00425edfe72a3sm4881031edi.43.2022.04.27.06.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 06:11:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] interconnect: qcom: sc8280xp: constify qcom_icc_desc
Date:   Wed, 27 Apr 2022 15:11:52 +0200
Message-Id: <20220427131154.302581-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct qcom_icc_desc is not modified so it can be made const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/sc8280xp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index 07dae4043986..7e6967d7b4a7 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -2033,7 +2033,7 @@ static struct qcom_icc_node *aggre1_noc_nodes[] = {
 	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
 };
 
-static struct qcom_icc_desc sc8280xp_aggre1_noc = {
+static const struct qcom_icc_desc sc8280xp_aggre1_noc = {
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -2069,7 +2069,7 @@ static struct qcom_icc_node *aggre2_noc_nodes[] = {
 	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
 };
 
-static struct qcom_icc_desc sc8280xp_aggre2_noc = {
+static const struct qcom_icc_desc sc8280xp_aggre2_noc = {
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -2094,7 +2094,7 @@ static struct qcom_icc_node *clk_virt_nodes[] = {
 	[SLAVE_QUP_CORE_2] = &qup2_core_slave,
 };
 
-static struct qcom_icc_desc sc8280xp_clk_virt = {
+static const struct qcom_icc_desc sc8280xp_clk_virt = {
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -2198,7 +2198,7 @@ static struct qcom_icc_node *config_noc_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
-static struct qcom_icc_desc sc8280xp_config_noc = {
+static const struct qcom_icc_desc sc8280xp_config_noc = {
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -2214,7 +2214,7 @@ static struct qcom_icc_node *dc_noc_nodes[] = {
 	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
 };
 
-static struct qcom_icc_desc sc8280xp_dc_noc = {
+static const struct qcom_icc_desc sc8280xp_dc_noc = {
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -2248,7 +2248,7 @@ static struct qcom_icc_node *gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC] = &srvc_sys_gemnoc,
 };
 
-static struct qcom_icc_desc sc8280xp_gem_noc = {
+static const struct qcom_icc_desc sc8280xp_gem_noc = {
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -2271,7 +2271,7 @@ static struct qcom_icc_node *lpass_ag_noc_nodes[] = {
 	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
 };
 
-static struct qcom_icc_desc sc8280xp_lpass_ag_noc = {
+static const struct qcom_icc_desc sc8280xp_lpass_ag_noc = {
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -2288,7 +2288,7 @@ static struct qcom_icc_node *mc_virt_nodes[] = {
 	[SLAVE_EBI1] = &ebi,
 };
 
-static struct qcom_icc_desc sc8280xp_mc_virt = {
+static const struct qcom_icc_desc sc8280xp_mc_virt = {
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -2319,7 +2319,7 @@ static struct qcom_icc_node *mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
 };
 
-static struct qcom_icc_desc sc8280xp_mmss_noc = {
+static const struct qcom_icc_desc sc8280xp_mmss_noc = {
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -2339,7 +2339,7 @@ static struct qcom_icc_node *nspa_noc_nodes[] = {
 	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
 };
 
-static struct qcom_icc_desc sc8280xp_nspa_noc = {
+static const struct qcom_icc_desc sc8280xp_nspa_noc = {
 	.nodes = nspa_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nspa_noc_nodes),
 	.bcms = nspa_noc_bcms,
@@ -2359,7 +2359,7 @@ static struct qcom_icc_node *nspb_noc_nodes[] = {
 	[SLAVE_SERVICE_NSPB_NOC] = &service_nspb_noc,
 };
 
-static struct qcom_icc_desc sc8280xp_nspb_noc = {
+static const struct qcom_icc_desc sc8280xp_nspb_noc = {
 	.nodes = nspb_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nspb_noc_nodes),
 	.bcms = nspb_noc_bcms,
@@ -2388,7 +2388,7 @@ static struct qcom_icc_node *system_noc_main_nodes[] = {
 	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
 };
 
-static struct qcom_icc_desc sc8280xp_system_noc_main = {
+static const struct qcom_icc_desc sc8280xp_system_noc_main = {
 	.nodes = system_noc_main_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_main_nodes),
 	.bcms = system_noc_main_bcms,
-- 
2.32.0

