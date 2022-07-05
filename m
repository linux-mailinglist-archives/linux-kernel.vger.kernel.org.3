Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDDF5678FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiGEU5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiGEU5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:57:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C2E13FBB;
        Tue,  5 Jul 2022 13:57:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n4so4435834ejz.10;
        Tue, 05 Jul 2022 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4tUb5C67DiBxz7NqEEQ7OjQvrD/Rs9OTZXUbtaDEJU=;
        b=ewJadcZCfCX01AQ0rRjcHbNo/r57oGwLEXsaG+Le9z52O+3+9etstDAwj1chvKgVKq
         snZ72Au8LWJsBzUpanZitiYFJMYRPI0TF07e81e0QUl020cTWqzF4AWmzV4NA1XzSeW1
         FXheeKRPyvjezVOhGAPVYvQMaGMYAeNCStniqQFVQjdailGy6JVaz5M6wVmz3o0QaOLo
         6i3shKAZu2TyyXvAxQ3Ki81POUq+IQSEBGqd0tgDJRQhGduBWyP9mfSJ31b6zXiwT/4I
         CF08flvCnea1RzVglDWSZ+Epfubu6j1I2kyyKwuBZhpSG/lfOr1IR/9LxzkdH3IR+G4V
         nySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4tUb5C67DiBxz7NqEEQ7OjQvrD/Rs9OTZXUbtaDEJU=;
        b=ePQqgpwH0wfnx4IrGGtO3M+4fARtKUgwIq489J57BS294pt98qBMaUkXLM2LZ+apHu
         tzzLeClYE8A8RuACi9+mFC2Cud1tkvK93oCam3aLI1g+mklbTg78Q8M9eUASbyHXyglR
         +Ztgs73KrkUIRlBQ+57W/GzGC2M6NPzhkim8f0yNwi4SCTgGkQaV9fQcFnblZvot+H3t
         hXKHdTMeo2M+SkFxqbCDZOBOBDeS0mDLhqhkRWJafjg9JV9O2vG8dCp8QZgQJv2NJyym
         o8JfqATG5b0VVvomS5f9WUi4mcEdENXFvj4QRQ4Ov1wcDByPcJWasFzo2KbpAmF7HNvE
         OkxQ==
X-Gm-Message-State: AJIora/sUECDDPJBF0GnNbCWAeu4GXEO2VaIcx5MKjpqNXkW1YNOyYrb
        4mGEaXSYSboO+nGv/jU14iqW5zeU7UE=
X-Google-Smtp-Source: AGRyM1us3X7z2uO7g2uvxLgYU68CekTEp9kWFADT51smYEelq2csD7N35H38cz8m8UsMU0jBDpouEA==
X-Received: by 2002:a17:907:3f1d:b0:726:c927:769b with SMTP id hq29-20020a1709073f1d00b00726c927769bmr35983967ejc.754.1657054650098;
        Tue, 05 Jul 2022 13:57:30 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id s6-20020a1709062ec600b00711d88ae162sm16249037eji.24.2022.07.05.13.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:57:29 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] clk: introduce (devm_)hw_register_mux_parent_data_table API
Date:   Tue,  5 Jul 2022 22:30:32 +0200
Message-Id: <20220705203033.1862-1-ansuelsmth@gmail.com>
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

Introduce (devm_)hw_register_mux_parent_data_table new API. We have
basic support for clk_register_mux using parent_data but we lack any API
to provide a custom parent_map. Add these 2 new API to correctly handle
these special configuration instead of using the generic
__(devm_)clk_hw_register_mux API.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/clk-provider.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 72d937c03a3e..0e9aceaf87a1 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -955,12 +955,26 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 	__clk_hw_register_mux((dev), NULL, (name), (num_parents), NULL, NULL, \
 			      (parent_data), (flags), (reg), (shift),	      \
 			      BIT((width)) - 1, (clk_mux_flags), NULL, (lock))
+#define clk_hw_register_mux_parent_data_table(dev, name, parent_data,	      \
+					      num_parents, flags, reg, shift, \
+					      width, clk_mux_flags, table,    \
+					      lock)			      \
+	__clk_hw_register_mux((dev), NULL, (name), (num_parents), NULL, NULL, \
+			      (parent_data), (flags), (reg), (shift),	      \
+			      BIT((width)) - 1, (clk_mux_flags), table, (lock))
 #define devm_clk_hw_register_mux(dev, name, parent_names, num_parents, flags, reg, \
 			    shift, width, clk_mux_flags, lock)		      \
 	__devm_clk_hw_register_mux((dev), NULL, (name), (num_parents),	      \
 			      (parent_names), NULL, NULL, (flags), (reg),     \
 			      (shift), BIT((width)) - 1, (clk_mux_flags),     \
 			      NULL, (lock))
+#define devm_clk_hw_register_mux_parent_data_table(dev, name, parent_data,    \
+					      num_parents, flags, reg, shift, \
+					      width, clk_mux_flags, table,    \
+					      lock)			      \
+	__devm_clk_hw_register_mux((dev), NULL, (name), (num_parents), NULL,  \
+			      NULL, (parent_data), (flags), (reg), (shift),   \
+			      BIT((width)) - 1, (clk_mux_flags), table, (lock))
 
 int clk_mux_val_to_index(struct clk_hw *hw, const u32 *table, unsigned int flags,
 			 unsigned int val);
-- 
2.36.1

