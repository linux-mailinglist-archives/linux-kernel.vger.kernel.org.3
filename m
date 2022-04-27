Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAE9511A70
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiD0NQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbiD0NPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:15:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10D23A2350
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:12:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z19so1873685edx.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYkrJLy1p+XxvrhEEZ1IAgmat2NjMtZTka/mSSSQ/0U=;
        b=R7mvZDkphifKpD+Z3mHx+KUHUKCaGykfzTW6eMWM5uCsYpCIK6gl1s7xDyT7u64x9t
         rggEL21uN/Q5+jmrizztW9MZPNxfIYNfWlJypbO1CyrVFQCd7nkj438C7AloHHMekZaY
         Vj31PGqGQDIxviLNg2mhtmn67dp5f8V3jIZy56BBD5vj5K3KZRRLsmGxGPQLcdEiNzPm
         ipxa/NSj5juloOMHzxNhyK4OWqIGkWUqBlbEs4Ss2nmxeVpBS4cr5j2Vhc+y0LTrGwZ6
         O6rI2O0EX7CbXl356TTkhUKqb0rWJ24hT3Uf2o6uWEne1jfXsPIl+9ufPCLwwmNKzkev
         y/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYkrJLy1p+XxvrhEEZ1IAgmat2NjMtZTka/mSSSQ/0U=;
        b=PJRHhUeO7dtGJf8FzV0qMnyQHeVN4MuXZpijLUQ33n3GJjYg+W5+MUKQPzEaq4irMe
         RPvLMVn1QJh0AKQ1k68fZNe+IoVJLR1zpHMsdr6/z4SeqTbjTio+I6EgdB7q2M8buZ6o
         vkvbz7m37DXVIPMSpOtd79fumnQ9iTTdeZqzZfZibwgZmhPel8oFgwbMA4UE4S+sGo/T
         4qWyxu+RDWQJXEOokC82WIfEKRgbCUJSsXjJ9imnYfzhAzrgPXCBQY0Ag8yEzpNU6u89
         OG+hEQ9GktdQcFnW/oQmNFHElw8nDcIhoy/+A5S8xMdMe/oyhlA95rOWhlM7qlOYgFYp
         FPzA==
X-Gm-Message-State: AOAM530QJAZWMTmInF+MVrILoO3eniYlhjOde+xJDTxvsj2XJ3OMsnI9
        ErRL9ckN0ZgD3qq9zm1GHd3eyQ==
X-Google-Smtp-Source: ABdhPJzgV11aeWdeaNi6wWDhLWIwyBsX5gRZgeIBu5ZKrL8bNbV72OnYm+daQTwpmatrZHODOLinyA==
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id eb5-20020a0564020d0500b00425b5c8faebmr30177910edb.273.1651065120316;
        Wed, 27 Apr 2022 06:12:00 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o23-20020a509b17000000b00425edfe72a3sm4881031edi.43.2022.04.27.06.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 06:11:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] interconnect: qcom: sc8280xp: constify qcom_icc_bcm pointers
Date:   Wed, 27 Apr 2022 15:11:54 +0200
Message-Id: <20220427131154.302581-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427131154.302581-1-krzysztof.kozlowski@linaro.org>
References: <20220427131154.302581-1-krzysztof.kozlowski@linaro.org>
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

Pointers to struct qcom_icc_bcm are not modified, so they can be made
const for safety.  The contents of struct qcom_icc_bcm must stay
non-const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/sc8280xp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index 408f6ade29e4..507fe5f89791 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -2009,7 +2009,7 @@ static struct qcom_icc_bcm bcm_sn10 = {
 	.nodes = { &xs_qdss_stm },
 };
 
-static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_sn3,
 	&bcm_sn5,
 };
@@ -2040,7 +2040,7 @@ static const struct qcom_icc_desc sc8280xp_aggre1_noc = {
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
 };
 
-static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
 	&bcm_ce0,
 	&bcm_pci0,
 	&bcm_sn4,
@@ -2076,7 +2076,7 @@ static const struct qcom_icc_desc sc8280xp_aggre2_noc = {
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
 };
 
-static struct qcom_icc_bcm *clk_virt_bcms[] = {
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
 	&bcm_ip0,
 	&bcm_qup0,
 	&bcm_qup1,
@@ -2101,7 +2101,7 @@ static const struct qcom_icc_desc sc8280xp_clk_virt = {
 	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
 };
 
-static struct qcom_icc_bcm *config_noc_bcms[] = {
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
 	&bcm_cn0,
 	&bcm_cn1,
 	&bcm_cn2,
@@ -2205,7 +2205,7 @@ static const struct qcom_icc_desc sc8280xp_config_noc = {
 	.num_bcms = ARRAY_SIZE(config_noc_bcms),
 };
 
-static struct qcom_icc_bcm *dc_noc_bcms[] = {
+static struct qcom_icc_bcm * const dc_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const dc_noc_nodes[] = {
@@ -2221,7 +2221,7 @@ static const struct qcom_icc_desc sc8280xp_dc_noc = {
 	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
 };
 
-static struct qcom_icc_bcm *gem_noc_bcms[] = {
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
 	&bcm_sh0,
 	&bcm_sh2,
 };
@@ -2255,7 +2255,7 @@ static const struct qcom_icc_desc sc8280xp_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
+static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
 	&bcm_sn9,
 };
 
@@ -2278,7 +2278,7 @@ static const struct qcom_icc_desc sc8280xp_lpass_ag_noc = {
 	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
 };
 
-static struct qcom_icc_bcm *mc_virt_bcms[] = {
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
 };
@@ -2295,7 +2295,7 @@ static const struct qcom_icc_desc sc8280xp_mc_virt = {
 	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
 };
 
-static struct qcom_icc_bcm *mmss_noc_bcms[] = {
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
 	&bcm_mm0,
 	&bcm_mm1,
 };
@@ -2326,7 +2326,7 @@ static const struct qcom_icc_desc sc8280xp_mmss_noc = {
 	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
 };
 
-static struct qcom_icc_bcm *nspa_noc_bcms[] = {
+static struct qcom_icc_bcm * const nspa_noc_bcms[] = {
 	&bcm_nsa0,
 	&bcm_nsa1,
 };
@@ -2346,7 +2346,7 @@ static const struct qcom_icc_desc sc8280xp_nspa_noc = {
 	.num_bcms = ARRAY_SIZE(nspa_noc_bcms),
 };
 
-static struct qcom_icc_bcm *nspb_noc_bcms[] = {
+static struct qcom_icc_bcm * const nspb_noc_bcms[] = {
 	&bcm_nsb0,
 	&bcm_nsb1,
 };
@@ -2366,7 +2366,7 @@ static const struct qcom_icc_desc sc8280xp_nspb_noc = {
 	.num_bcms = ARRAY_SIZE(nspb_noc_bcms),
 };
 
-static struct qcom_icc_bcm *system_noc_main_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_main_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn1,
 	&bcm_sn3,
-- 
2.32.0

