Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A804E1CD4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245573AbiCTQah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245517AbiCTQ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A8935261;
        Sun, 20 Mar 2022 09:28:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q8so6500159wrc.0;
        Sun, 20 Mar 2022 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QkfgyebL6ZDeFyix3jLmVd6pOSFa+uhSyC95dgb9bxk=;
        b=fSEwj5Ha6UFb9CDLegqXD8R9svLc6ia09ioy5Uz4x/0iaa2PPVWwuWyib+xnHXQDxw
         X4rQhvpfSjQepD1eW5UBb6n8fFqnth1s+b4wjLVwhxoZ7iabMQzLEVoE6fT/1iq+ptWW
         xZXDOLbVNG/d2O38D+3OnQ1cewaYUrdJo3fvI1Cg3RW1L9iCJSn/Sc+Qt9wAQKMhuYqi
         kkaY0il8kVG0Xf8to0zzf+GtRwltnfXXaXNknChJnKG0uhBrO+xbe6YcXSoddBlBxUHK
         zL6kbiq0th4RDbFsd5aFCpAt1gFk8jWHt3Vp/Z7WUUNCtR9r9jmjSzMuShl+LSXY0F4/
         tZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkfgyebL6ZDeFyix3jLmVd6pOSFa+uhSyC95dgb9bxk=;
        b=1uxjvn8FMA5dpAiJbTibKynoA0YGIRQqmigF2b8eDgE4tCDSeP6CuBoDDh7ylzoumx
         ++3CebnTtetf52FVJNGs2yqJEjBEVAeyWT+DExj36flcCdxkmoNMCAqZCokMdOLop/9u
         bCWuj0KtInzuFhkLfoOO6T902pHR8hKWWVuuwxZkQBsz6/LUas4FZ3h/4+sT0ngFX5+g
         qKx2hfmRukwWQNc14tiOVt+YVZsB4r9pMwUyDj80kflodk4GIoeJ9WBMjb14CZHTJWWL
         NIceNVB+1T2/smTOBIWXvE0qGDakQNv5WeLg02bcKXxE68FCUsz/jOwjX3xscdpRHUgP
         fpXg==
X-Gm-Message-State: AOAM530jdB1I0yVO0NXPJclQmJsFo4AfRnipZRYJSWUHihzcZ6JCgao1
        laAH/ocoVd4eabyQI5/pSJA=
X-Google-Smtp-Source: ABdhPJwZ5bTmi6XVP7H3D54Q3pixThOtRzOZ/HdyY5HsjmWAWQKGNYj6WF2pCJPgYUG2GfFXYdNTaA==
X-Received: by 2002:a5d:6205:0:b0:1e4:b3fd:9ba8 with SMTP id y5-20020a5d6205000000b001e4b3fd9ba8mr14862298wru.426.1647793705557;
        Sun, 20 Mar 2022 09:28:25 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:25 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 13/18] clk: qcom: clk-krait: add enable disable ops
Date:   Sun, 20 Mar 2022 12:34:25 +0100
Message-Id: <20220320113430.26076-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add enable/disable ops for krait mux. On disable the mux is set to the
safe selection.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 7ba5dbc72bce..061af57b0ec2 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -85,7 +85,25 @@ static u8 krait_mux_get_parent(struct clk_hw *hw)
 	return clk_mux_val_to_index(hw, mux->parent_map, 0, sel);
 }
 
+static int krait_mux_enable(struct clk_hw *hw)
+{
+	struct krait_mux_clk *mux = to_krait_mux_clk(hw);
+
+	__krait_mux_set_sel(mux, mux->en_mask);
+
+	return 0;
+}
+
+static void krait_mux_disable(struct clk_hw *hw)
+{
+	struct krait_mux_clk *mux = to_krait_mux_clk(hw);
+
+	__krait_mux_set_sel(mux, mux->safe_sel);
+}
+
 const struct clk_ops krait_mux_clk_ops = {
+	.enable = krait_mux_enable,
+	.disable = krait_mux_disable,
 	.set_parent = krait_mux_set_parent,
 	.get_parent = krait_mux_get_parent,
 	.determine_rate = __clk_mux_determine_rate_closest,
-- 
2.34.1

