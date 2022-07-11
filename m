Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF26B570C53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiGKVGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKVGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:06:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746365A451;
        Mon, 11 Jul 2022 14:06:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m16so7744897edb.11;
        Mon, 11 Jul 2022 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xfp89QyK0/p/8PmDaqGqGqPNT0fmeAkB/Wk4K0Cj4hI=;
        b=h7qJwRXjuIF5/hRpUwuhAUXZrPIT36RfWFWRQzyE53G2dK1gl40u+X3NukQI/xyISR
         TB5FLI6Y2DQwU1bC0aGmsgyhkgqKQUcdptIIxDyi//HjQjwZD1QIkvunHqWg7CbUoN9X
         qe+Er0GIK2fL5fhM288QM6MoaPc9a/XcuS6kDo1tyUynTJVp+wrIFk+CoCOuNb8B0UAi
         mzbXV5+3Q+nXGjeDoQpxQtp6T06ETs+eD3olHpfAVT9NGi9M1KfGERP0gtEd5V37uVtN
         gGh7xWhxbHAfrbRxfUkNTX8fklN/dlqGikQQR6kygNdcgQsb3FdwCntgkJF5yK0n5kgC
         sFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xfp89QyK0/p/8PmDaqGqGqPNT0fmeAkB/Wk4K0Cj4hI=;
        b=ISqe3pF3K62J5nsawVpeNfx+2WtVNcSaDLeI21oTATcQOjTWA9QwO/GzRJuUODg+1/
         0pgk8JCHXx2/so7goTKWxmzV4y1R5qacei5J/+zPe4ly2BJP3xueYKOOLdv7Jy67Cf1A
         4hKthTb+gFdX858saU1H3IGo1+DXq3eoAosEwm0UGKCSZ0nKkD+LLV6i9xom95ZkpXa+
         rL8bYu8kWvRBC6ny9wpxVMRcmRjZEMZ0XOk1AJQhQsm0at2cmkNFYGCvrCyVT+z69qug
         9Q+/tLMlAxeWsfXqCR2jABGNI/TVteAhgqDE7AyGOw4cUBTCdMQVoWoD+8WClK0/EuQu
         CayA==
X-Gm-Message-State: AJIora8lqE5tkt6y+slEtI7CH9bXR0FhONGUN1Pyx2Qt2Vm1GVR8dy/C
        9f/GUS8GoB943nxI1fMqevg=
X-Google-Smtp-Source: AGRyM1sH60y9Q8ZWrBVFITITOeGCiSlaWCsvQmhRaNGjeHqGABOg3dklQHXFKaOC0FNlCC6krenczg==
X-Received: by 2002:a05:6402:5205:b0:43a:b520:c7de with SMTP id s5-20020a056402520500b0043ab520c7demr23403794edd.22.1657573597018;
        Mon, 11 Jul 2022 14:06:37 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id lb17-20020a170907785100b0072a430d2abdsm3052562ejc.91.2022.07.11.14.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:06:36 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 1/7] clk: qcom: clk-rcg2: add rcg2 mux ops
Date:   Mon, 11 Jul 2022 23:06:28 +0200
Message-Id: <20220711210634.3042092-1-robimarko@gmail.com>
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
2.36.1

