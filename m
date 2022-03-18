Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26144DDDF1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbiCRQKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbiCRQKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:10:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1B7340F9;
        Fri, 18 Mar 2022 09:08:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d10so17885068eje.10;
        Fri, 18 Mar 2022 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QkfgyebL6ZDeFyix3jLmVd6pOSFa+uhSyC95dgb9bxk=;
        b=BerOL3dQ/78Oz2+oKSWkFCE9uaVT6/DIBQQ8Rf+MrUS6iK2qnUAwH4dFavAWJtThvk
         4l1Uyqa1tOzGV+OaTSdhPJGqdowyXPu7l5oO+1mzZSA/jC5dnA9JfHacSrssQYFm2kH6
         b+rcN79MrT2Va1Hk5g9DDZWOv12Q9cXuBpw+qzSQGb3JiIPX9muFJ4vVnIf8D+LrB+uj
         mucvpW5naHtIoo+zKmIf5ln0Q7wAubSj4afnw1l4RcWwwIiupGDtv/40DzgpPe1D2aBy
         6BaiiwdmvCLMPRZFL6vM3Gkg7kUWq024LI0DVnj+danIN7G83riQjZudloxciqTggS4W
         I4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkfgyebL6ZDeFyix3jLmVd6pOSFa+uhSyC95dgb9bxk=;
        b=g56AwcPzcpM05UGe7fdJ4xrXoVepImjVedkU4hpxVeYdx7qiPpLLspyWo20Mvz7KvH
         kgl8aXp+4PgsQvIiuyBHyuSSwTP0SbBmwJ5OlFgL0ou9hTXL0MWKHgnMe1Puw6O9q1hZ
         CNcuuAuJW6ZGYOOpHPMuc9sAc4P4kBpx7/UZaiP3bcNZ8tawB+AzWpFfFJb80Cv8Knqu
         jqAZIjryUSru+ciGxX/pnW4JM2JtsAiyuaxIKQghOr+a8wIx7vMlrrEa4yx5mzzwEHSM
         pdpf+TeuhGslEkAmZARwmiRc+q4aUjLO5WuaOnkIdfBwMmhW+xOx1ZYuC2wnHaZy/G7Y
         mYDg==
X-Gm-Message-State: AOAM5313WzXRAI9sf6bkXWHQ570AP21f1cpb7mu0IdcTY0tW/I2z9L/h
        hg+/Yx7dGHsWl3mmXWFHeb4=
X-Google-Smtp-Source: ABdhPJyZqP28BOQfcEmKipl+Cj0mTuDHc92ASgrJShX6ni25UYRIgU+ok8PZTyj1dGq3jkwchkm0JQ==
X-Received: by 2002:a17:907:7fa2:b0:6d8:2397:42 with SMTP id qk34-20020a1709077fa200b006d823970042mr9513040ejc.218.1647619722468;
        Fri, 18 Mar 2022 09:08:42 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:42 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 13/16] clk: qcom: clk-krait: add enable disable ops
Date:   Fri, 18 Mar 2022 17:08:24 +0100
Message-Id: <20220318160827.8860-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318160827.8860-1-ansuelsmth@gmail.com>
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
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

