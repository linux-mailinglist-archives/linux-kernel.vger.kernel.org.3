Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14E3570039
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiGKLWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiGKLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:22:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77047292;
        Mon, 11 Jul 2022 03:47:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so2781920wmb.1;
        Mon, 11 Jul 2022 03:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+HVJW7F1K6wwajjNiFtroQgNImhSLi34xU+wa1Cgw+Q=;
        b=Y9GEdopa3o8OdYGhlwPne4NRX97Pjgrb17XEryWJrkZrDb+1vrRA+lsV6YRdNPInRI
         LSr/l2WKjp/vWEEB5MHPVMxOGRaAxMFA29T76iZYTJPftiVHQOcl5NrRIlwwRAmJCfUu
         BclJZ9SuLD09Mv6Jv/EBFUOcZ7RJIGYyIHqN2s7uHvdA5V4pok1gCLEBSCe6VGo1tVgW
         w3HNyBIHnFYiYtgLEyykkpmKsTYpSELhu/fegA2mROBoKjqFxL4+r6x72Kt1cJNJQScz
         X08ZdIqxzob3KG9kGrGnEbUcacmbesYycFHgMsJQDY8Cc8jCSSEz5zTRHtyeDDgyOl50
         qnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+HVJW7F1K6wwajjNiFtroQgNImhSLi34xU+wa1Cgw+Q=;
        b=Zeds8xhabg2RI/V7SpSSlRaOk0xUoQ1gHQbEdELFSvvdVLXeFUtJmR3ofZwbm/oOgx
         s/dCqu6geCKsg7jOqDwsOuQuBb7iviyDzgsorgiN+AMYTx30xTKtjOU8WCX6BmugliYL
         5rPiGQT10mnm3VZvlkxCTf+nAC0187d0bAdr6An6OvhJjes9wllFrGaQWuMTqoMj7ixS
         ZHOWxk+EOvRW0+YYq/P3b/0EI2P06m15vYAijL9CJcXuVpTHXC6h3nZ8aX7VnT0vuFab
         G441tXQqsWthgT5dUv2ljkVvEFBNz4Ogdwf5V3T5bcKIstmDDU0+km9P5p2tI462tfHh
         jmZg==
X-Gm-Message-State: AJIora/YFkU402Wqhtrc4x4L6iKjk9hiXM4UwxY9FfPnh+vY30hX2GA9
        ACNFFqkKrKg5qal8Xdniyz8=
X-Google-Smtp-Source: AGRyM1sLFtigAlMz6p6003Ctun0EzJ4efrh/28U35kZN9NLZUjilcNWAJOQpLy2KnVXLIhPc+xW1pQ==
X-Received: by 2002:a05:600c:3594:b0:3a2:b918:fc99 with SMTP id p20-20020a05600c359400b003a2b918fc99mr15305330wmq.46.1657536444932;
        Mon, 11 Jul 2022 03:47:24 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-242-cbl.xnet.hr. [94.253.144.242])
        by smtp.googlemail.com with ESMTPSA id n3-20020a7bcbc3000000b003a05621dc53sm6338716wmi.29.2022.07.11.03.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:47:24 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/6] clk: qcom: clk-rcg2: add rcg2 mux ops
Date:   Mon, 11 Jul 2022 12:47:14 +0200
Message-Id: <20220711104719.40939-1-robimarko@gmail.com>
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

From: Christian Marangi <ansuelsmth@gmail.com>

An RCG may act as a mux that switch between 2 parents.
This is the case on IPQ6018 and IPQ8074 where the APCS core clk that feeds
the CPU cluster clock just switches between XO and the PLL that feeds it.

Add the required ops to add support for this special configuration and use
the generic mux function to determine the rate.

This way we dont have to keep a essentially dummy frequency table to use
RCG2 as a mux.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/clk-rcg.h  | 1 +
 drivers/clk/qcom/clk-rcg2.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 012e745794fd..01581f4d2c39 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -167,6 +167,7 @@ struct clk_rcg2_gfx3d {
 
 extern const struct clk_ops clk_rcg2_ops;
 extern const struct clk_ops clk_rcg2_floor_ops;
+extern const struct clk_ops clk_rcg2_mux_closest_ops;
 extern const struct clk_ops clk_edp_pixel_ops;
 extern const struct clk_ops clk_byte_ops;
 extern const struct clk_ops clk_byte2_ops;
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 28019edd2a50..609c10f8d0d9 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -509,6 +509,13 @@ const struct clk_ops clk_rcg2_floor_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_floor_ops);
 
+const struct clk_ops clk_rcg2_mux_closest_ops = {
+	.determine_rate = __clk_mux_determine_rate_closest,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_mux_closest_ops);
+
 struct frac_entry {
 	int num;
 	int den;
-- 
2.36.1

