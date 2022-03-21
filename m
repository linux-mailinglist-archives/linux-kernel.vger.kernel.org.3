Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5974E2D60
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350800AbiCUQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350696AbiCUQJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:09:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E06289A4;
        Mon, 21 Mar 2022 09:08:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d7so21372249wrb.7;
        Mon, 21 Mar 2022 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uKLqUE0HqMblkYxTDEoLkraH8fYkNKsZ80vlgdu8msQ=;
        b=pPQBa78YGPtspBAIwSYLH3sOjVqFmTH2f8C0gFoZvX/PVsvFeGhgYea1CT/qyovtU1
         86NC6amFLmb3bZB2iUc0YiXtQXIONJEjCxizGOx8emPmgk+ej1/ZG+gtrDH+wg3PEKeQ
         QBe8sWtR91uETw08N1DmXx+4xF6r68ShR02w8vYCN4jgh1eHphPwRKssaCHgw3dYf7zB
         PZYTyIn3IxQf7MLkZndv1VrVNwNTdscSdUfxjUpAWOizc5zqXYrZ30maoi9hA9at7fiH
         Sxoa0oTzVA1EO0nTfFjYRPrXoCC0YektC93Zt287WVP2GYWTw3fdDkTnwyILo8git/nD
         070w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKLqUE0HqMblkYxTDEoLkraH8fYkNKsZ80vlgdu8msQ=;
        b=BSWRXLH3XUoNDzTPyzvezRL1YSa8gIeEGfAC/8C5NGf6eWDNBqjSwUzRkqlWZmh0be
         8ZcwAnBcrV8hQb0A92zuLtS+zCBxMZoMAtI+u+SYVJwsMDAwoS+KeOB9IVJf7yJdyqME
         FTkajy85dWFXSwtDViWbta7N2zIz3UUKpIcNe+gWvCLs0pTE67w7TzP1PHnKIkLCqarX
         Jw4gYQXXsXmXRrMPhj4Jv+bwCUfSWowA/CwmW36qlbN2nN8DQRL2P1eWLPcMJYIiTFWt
         2dS3jfgkcP69NCAnhFMFBwcH9gqn3BjMXsoi0/ds7iEfrHtg/+9ngeyWJ9fyT/az0mim
         3ylQ==
X-Gm-Message-State: AOAM531ev1Vxq5dnxmbQthohC2fszJblFPWd7Bn/N/FG0cNXyj9JWG//
        V8Wc8tT1JsNWcJJngNOIhHU=
X-Google-Smtp-Source: ABdhPJytAlmKqsU78d+ZiKESAIbMPYYAdAO5Iu5OxAzit5428s8wkU1OO7zQxDkB/ofhfxfZ+oyAOA==
X-Received: by 2002:adf:d4c2:0:b0:203:da50:12c5 with SMTP id w2-20020adfd4c2000000b00203da5012c5mr19321170wrk.100.1647878902712;
        Mon, 21 Mar 2022 09:08:22 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:22 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 07/18] clk: qcom: clk-krait: add hw_parent check for div2_round_rate
Date:   Mon, 21 Mar 2022 16:38:44 +0100
Message-Id: <20220321153855.12082-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321153855.12082-1-ansuelsmth@gmail.com>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
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

Check if hw_parent is present before calculating the round_rate to
prevent kernel panic. On error -EINVAL is reported.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index e447fcc3806d..b6b7650dbf15 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -80,7 +80,12 @@ EXPORT_SYMBOL_GPL(krait_mux_clk_ops);
 static long krait_div2_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *parent_rate)
 {
-	*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), rate * 2);
+	struct clk_hw *hw_parent = clk_hw_get_parent(hw);
+
+	if (!hw_parent)
+		return -EINVAL;
+
+	*parent_rate = clk_hw_round_rate(hw_parent, rate * 2);
 	return DIV_ROUND_UP(*parent_rate, 2);
 }
 
-- 
2.34.1

