Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0986C565DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiGDS6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiGDS56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:57:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F24A12607
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:57:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j7so5874230wmp.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5poSYlinO2iAnmaIm0CnEx4qAIHaY4O+1UlEMuYCNc=;
        b=Cbxc+86iTX0z4WsVPx5OduAQlR9qkJU7TB0nwc6Kr1qNOKOmuUXX0DJw/PVhgaOEpA
         n/wmw3ELdBLOOzG4MFSbUWg0ZgdOpH77GcD8zIwGedIt1aYwzCkqLEUUy8mx0GVWGWvn
         XIRg7trM37CE4YC6Bu8BEICgISr7YUzsCJi3ELfL+TAMq/imcAsxiWiufaFrJ1nEGyXF
         wTFu9aQfeI7OPr4MwY6WTbxJZ3jJjW0t+9GRmFf6HXJ5gQe1OQwdORBCGezbJAp7KOQU
         126EmhjOKrZbyYhnjN2o+44jc20BKsdQgTtTcwTaqZdvh61PxlK8/PBeUWK0iS5UhjLZ
         ZBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5poSYlinO2iAnmaIm0CnEx4qAIHaY4O+1UlEMuYCNc=;
        b=fUx3qjjteg/pw2pDuKDLwbT0azmSa6EoJqoEPAnk4Xne2JSYPlEoWch9ajUl/DuPpp
         rI09OF0lEkxWPtbevQdVVI5ZONywlMXYQtHOQcBq7ElL9Tj6MsT8bNb1gBd+Qz+7VGp0
         waRwLF5Yz/uhSCBsHv1gC61hWET49mbPW3k5PvGQomWydzJkQ4qYr3MPSsZ/Q6/xshe0
         1HSaCFwGYIN/IOOL0elyknS/nz6oe3DSmlxiYzoweSPvFwAC9BXMqzuzbQZvAqFoZVUE
         0i347x9DrjIKCnkbxO0HESkLo9ozvPXnJoxqI1k5cKar3ECPHcGpapjAwGxm5kXm6c2b
         Pa3w==
X-Gm-Message-State: AJIora94YWtFEYdPwUDB43820EydT+hlFQAxNWuQ5oLxhFrne5xatWb9
        fVYXcpGd2+m2nPvBI2xKl6Pwvw==
X-Google-Smtp-Source: AGRyM1vGKLOIMfCnLIwkfuo7eLCoSbQovJPAOaBT8opy2GAUFI4vyW7duiJLDWYmedNsLyIsleeVdQ==
X-Received: by 2002:a05:600c:255:b0:3a1:963d:2ba3 with SMTP id 21-20020a05600c025500b003a1963d2ba3mr14093642wmj.200.1656961071630;
        Mon, 04 Jul 2022 11:57:51 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id ba15-20020a0560001c0f00b0021bae66362esm27937213wrb.58.2022.07.04.11.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 11:57:50 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC] clk: Add clk_hw based provider enable/disable API
Date:   Mon,  4 Jul 2022 21:57:33 +0300
Message-Id: <20220704185733.1288578-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, a clock needs to be enabled or disabled by the provider,
without actually touching the enable count. For example, a clock
provider driver might choose to disable some unused clocks on sync state
callback rather than on the default clk_disable_unused. Such clocks are
usually enabled by bootloader and need to stay ungated until some driver
built as module probes. So add clk_hw enable/disable to allow the clock
provider drivers to disable such clocks on sync state callback.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/clk.c            | 25 +++++++++++++++++++++++++
 include/linux/clk-provider.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f00d4c1158d7..a727cffb6bba 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1011,6 +1011,17 @@ void clk_disable(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_disable);
 
+void clk_hw_disable(const struct clk_hw *hw)
+{
+	struct clk_core *core = hw->core;
+
+	trace_clk_disable(core);
+	if (core->ops->disable)
+		core->ops->disable(core->hw);
+	trace_clk_disable_complete(core);
+}
+EXPORT_SYMBOL_GPL(clk_hw_disable);
+
 static int clk_core_enable(struct clk_core *core)
 {
 	int ret = 0;
@@ -1176,6 +1187,20 @@ int clk_enable(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_enable);
 
+int clk_hw_enable(const struct clk_hw *hw)
+{
+	struct clk_core *core = hw->core;
+	int ret = 0;
+
+	trace_clk_enable(core);
+	if (core->ops->enable)
+		ret = core->ops->enable(core->hw);
+	trace_clk_enable_complete(core);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_hw_enable);
+
 /**
  * clk_is_enabled_when_prepared - indicate if preparing a clock also enables it.
  * @clk: clock source
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c10dc4c659e2..0f9968a7a6d2 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1212,6 +1212,8 @@ unsigned long clk_hw_get_flags(const struct clk_hw *hw);
 bool clk_hw_is_prepared(const struct clk_hw *hw);
 bool clk_hw_rate_is_protected(const struct clk_hw *hw);
 bool clk_hw_is_enabled(const struct clk_hw *hw);
+int clk_hw_enable(const struct clk_hw *hw);
+void clk_hw_disable(const struct clk_hw *hw);
 bool __clk_is_enabled(struct clk *clk);
 struct clk *__clk_lookup(const char *name);
 int __clk_mux_determine_rate(struct clk_hw *hw,
-- 
2.34.3

