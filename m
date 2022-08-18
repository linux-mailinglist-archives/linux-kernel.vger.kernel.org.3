Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C26598FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244702AbiHRWGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiHRWGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:06:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396ABD21F7;
        Thu, 18 Aug 2022 15:06:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w19so5670395ejc.7;
        Thu, 18 Aug 2022 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JCTh8kG/kYdyoUHtyXB+jjX01mOnfuolr7Ild9fizAg=;
        b=Elp+bln4oYJ2TL8Kz11eRwuDXELrurfYX7F96HcVgoDhNrih84Wi1fwB5zaEPrordD
         UP1Blce+6zK/CiMXxfzsnNOEelFQuLC2uLO7v0btgAW614L1OTem1BW8lvPVfanvWKL7
         fFeyj7k1uobaoghg+g0CHxn2vLI4CWqcXRxaruzE/L2QrxzaffSxSwgfZF4HBxnXXIcE
         l89PNc9mbU8jA8XFk7qBnIO8C0LRoY9U6RfPzFCtuqesZdEswP90weWEmz/xTs1k+3+0
         Uyq+Gzka5gO0s6bxUSdMOPYVcz+BOxgMJ+pttNBJ4XYifLOJQ4z0UgcqA7KYegBK1j7k
         lozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JCTh8kG/kYdyoUHtyXB+jjX01mOnfuolr7Ild9fizAg=;
        b=CpVQyuwPVCeb5mdbHyFAT3V4kTH68YdswM+5g/BG0mIxQ4zuBpi092ju26AtjOrDuV
         lvcZbXwXSWh0Wmqusux2uC6aYRFr8cNH+aLMtc86SeppHxJcB5pIQRr23sYVRN/eZrI1
         qwQ7okKcwx1WwVHlDLxLr6WN1VxVUfFhST4k4BUY1ugjSa1GF/s9ASgHawOAdzUWzk3B
         blwhwD1jjJmyEagZOfF5WtLJb1hVOx4GlHyrI0vbMBM32Awi9AVrUJrhITe4LOjaOphM
         Dm3pmwDc04tYfB2WC82wKoAUTbKfaBN4tYv2VHjpe1k6u1o2gprot2ElzjXRVMGk0/kq
         H7MA==
X-Gm-Message-State: ACgBeo3WYqo8KfglYXSMQfJBCDjC19csaU0jkqYck9bBYQ7aHmulHRYA
        cwttXi0vlf64Glq4/8mRMrE=
X-Google-Smtp-Source: AA6agR4xImEt3gc0hR6OSGR8kI9kikSTupIwRDS50TI7JIiPFifM6tDC+Iykx66rN2W8OEDh6lfH9w==
X-Received: by 2002:a17:907:608b:b0:731:8a9d:5a2d with SMTP id ht11-20020a170907608b00b007318a9d5a2dmr3104711ejc.443.1660860390741;
        Thu, 18 Aug 2022 15:06:30 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id dk5-20020a0564021d8500b00442d5054a51sm1851584edb.87.2022.08.18.15.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:06:30 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 1/9] clk: qcom: clk-rcg2: add rcg2 mux ops
Date:   Fri, 19 Aug 2022 00:06:20 +0200
Message-Id: <20220818220628.339366-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
2.37.2

