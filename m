Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3675570C61
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiGKVGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiGKVGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:06:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED67F6BC04;
        Mon, 11 Jul 2022 14:06:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y4so7768233edc.4;
        Mon, 11 Jul 2022 14:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGbjfMuKxaOhS50lbNgGWMXPU73MU+jgwIU4egsEGPA=;
        b=VHt3yMJA1FdLEc0vJgKBkKlQoeeICXVviHGUKPmj8vH+6RyCWVLLO5ruBnZCw43LtF
         bWnJ2mjToqgKLUwmtDOEyL9optbnMiaLGlmB7sMID5MDftwinTzij/zb8jJ8HpGkYllZ
         diiQfFf8PKvfjHzDIZ5cpgMFep2a6ZFQ8OYWLjGp4ibGr0RnNvSwk0XKLQ4xpUTA8hyz
         2aOFcb4UU9rWuUsBmuUp7523NeX3aAZBAeDmmJMX4WXdpyEhgesdJFUF2wFg0tWH6cuO
         bDU+pg08bBuQ2+CHEWVxpkSyMlhPpjsl0aMTX+8WMffp1/MvMMP5arfjz9oQQ269jT6b
         E96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGbjfMuKxaOhS50lbNgGWMXPU73MU+jgwIU4egsEGPA=;
        b=ioOF14CmbrSZ+7+KVvm9syZVkKKbWQpUwjm7KCl4+BINe+dxCd9GpclfqrB3zjhjyl
         sh008cl4QNywbWB0bLpiiI2RHplVn+ImrnvJy093A6QV1ZVNNfzCPoNjBS/Ynil1ry+/
         SdVCR9LXuaZ/3qjU2LKOGjB6W4lig651aAazIC/tKggGwQO5bPMuS8MEt8zB/AQLUeBo
         BrI/f+HMZtXb32JJCC5gPat2sngkbRbUFxx6JwkJX4ggvvOF4K7bLAOLKc08iNmzpzEF
         KsgYNGGFaudj8cCqBxPIokejzfJ70erwmUS1BfV+n0x8SXDBKyqAEV2e3kNsqmesmDbY
         9bsA==
X-Gm-Message-State: AJIora9ekgJv5nLaYonbzu7dter+bUpwKoTUmaSBQpd4lnqLK5qwEImD
        qp7ezqpLcv3TPLaqcNOgJXtkAcNHDXrsGQ==
X-Google-Smtp-Source: AGRyM1sowQ6xE6jpQs3VbaWxjP/XD64VFRDPLbXmWlMdfH3EGGURoUzbtW2b/w7SY2k1ZzQ6wj4mWg==
X-Received: by 2002:a05:6402:518b:b0:43a:dc65:35f8 with SMTP id q11-20020a056402518b00b0043adc6535f8mr6501856edd.185.1657573599610;
        Mon, 11 Jul 2022 14:06:39 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id lb17-20020a170907785100b0072a430d2abdsm3052562ejc.91.2022.07.11.14.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:06:39 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 3/7] clk: qcom: apss-ipq6018: mark apcs_alias0_core_clk as critical
Date:   Mon, 11 Jul 2022 23:06:30 +0200
Message-Id: <20220711210634.3042092-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711210634.3042092-1-robimarko@gmail.com>
References: <20220711210634.3042092-1-robimarko@gmail.com>
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

While fixing up the driver I noticed that my IPQ8074 board was hanging
after CPUFreq switched the frequency during boot, WDT would eventually
reset it.

So mark apcs_alias0_core_clk as critical since its the clock feeding the
CPU cluster and must never be disabled.

Fixes: 5e77b4ef1b19 ("clk: qcom: Add ipq6018 apss clock controller")
Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/apss-ipq6018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index be952d417ded..f2f502e2d5a4 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -56,7 +56,7 @@ static struct clk_branch apcs_alias0_core_clk = {
 			.parent_hws = (const struct clk_hw *[]){
 				&apcs_alias0_clk_src.clkr.hw },
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
-- 
2.36.1

