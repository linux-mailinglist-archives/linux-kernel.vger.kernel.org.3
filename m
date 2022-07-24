Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5557F657
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiGXSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiGXSYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:24:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A9DDF95;
        Sun, 24 Jul 2022 11:24:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l23so16834503ejr.5;
        Sun, 24 Jul 2022 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBXLmwSFxvw5R0+vrUzvvCWExGH87HipMkMT+NmwEG4=;
        b=htyEtDF5rj3S3r1u4ivLorVnTctGPVptDHWc+kJoD8lVI9OHk/DTGwGTlxaRtCEQzi
         3ywHkmYRyLAZsllDAGRdMTXScP20+Al2ZwZfg9JPJ5ZRTvkM/UMHgr0hXUNP9cPpAZtr
         USfrVC9VxdWC/o4tNroE+/4xxl6bFCStKHe+oBEABXIChH1BiTUvrUS6uoAOdiescIvS
         Gh9ZGhUuuTYMMFOuHO8t4Nvir+O1vbk4BYxjTY/ymUsGK+8D6L6SNtyoERFmn9S9gJFT
         4QzbRJ246XrHGvEgQFMA9H/Etv1ceOhMfGFhufOfjzFm9j2JdRFGBD36dAdOgereB6FR
         l7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBXLmwSFxvw5R0+vrUzvvCWExGH87HipMkMT+NmwEG4=;
        b=7mSrlQ60U62681dgmT7+IIVW7u9j0S5wOA753Hz5u/VQssmj3j8qhvBNr7qzSI7pOc
         56bCS+/nvBFRcmphXX50Tce8zBYZv4ll6ZaARjE7ZlUNm6OQGFxXc7RxCleReWZOswkm
         ljxZjddPb6zjTgcMEaqIO39q3GkmXYxM870Fd8wJ/hKLERF3/2XdQmG6vMfoX1LroUG/
         yuRPBrYPF/YoX195HSktigTjCb8G7RI9y+pyKkr7PilAGgPwFbdPCMtBAIan5pxGdbvM
         jEW6TnbFBxcTyrRTUXFmy6QEA6g/mXD5r35GJHX81ozuBxr0RL3yWPh4YvR4G3ofr6mI
         fZeA==
X-Gm-Message-State: AJIora9bbIBOl0MniWhpR0FNWNpDW9ePrRnhNG2n+UeEe6EOYRKBFhyb
        9cIjDZwbzkoA7QBu/ALg8Hs=
X-Google-Smtp-Source: AGRyM1t4aHW71XdOVDwliPatAMjbP9zt0QyMDXoBOoUxG6zYHd8wmI2cv/m3E1HPTOs6KuKJgVFhrw==
X-Received: by 2002:a17:906:cc5a:b0:72f:525:7c2a with SMTP id mm26-20020a170906cc5a00b0072f05257c2amr7032695ejb.247.1658687041318;
        Sun, 24 Jul 2022 11:24:01 -0700 (PDT)
Received: from localhost.localdomain ([5.171.121.144])
        by smtp.googlemail.com with ESMTPSA id kw24-20020a170907771800b0072b609d9a36sm502680ejc.16.2022.07.24.11.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 11:24:00 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v7 4/4] clk: qcom: lcc-ipq806x: use ARRAY_SIZE for num_parents
Date:   Sun, 24 Jul 2022 20:23:29 +0200
Message-Id: <20220724182329.9891-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220724182329.9891-1-ansuelsmth@gmail.com>
References: <20220724182329.9891-1-ansuelsmth@gmail.com>
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

Use ARRAY_SIZE for num_parents instead of raw number to prevent any
confusion/mistake.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
v7:
- Add review tag

 drivers/clk/qcom/lcc-ipq806x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index 1833e59a6434..81a44a9a9abc 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -134,7 +134,7 @@ static struct clk_rcg mi2s_osr_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_osr_src",
 			.parent_data = lcc_pxo_pll4,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -251,7 +251,7 @@ static struct clk_rcg pcm_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcm_src",
 			.parent_data = lcc_pxo_pll4,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -335,7 +335,7 @@ static struct clk_rcg spdif_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "spdif_src",
 			.parent_data = lcc_pxo_pll4,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -392,7 +392,7 @@ static struct clk_rcg ahbix_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "ahbix",
 			.parent_data = lcc_pxo_pll4,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_lcc_ops,
 		},
 	},
-- 
2.36.1

