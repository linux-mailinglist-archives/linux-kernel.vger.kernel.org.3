Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667965718A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiGLLeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiGLLeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:34:12 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9603AB7DA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:34:10 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 23so7301210pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2kOxzZkRxT+SCDc/hWVbeiMQchYapmJ5tgcoSnW9NfA=;
        b=K38rRvmuZwuHeV6S3mbZFNYaUh+iQnDJiTeHryLUFX6A4Sa361BXHcjCCufV/u/0tQ
         S1CjpD8Eo1dtBiG30ORyACtnbkIZT0m1pIzantyWMCy57+O0mrKWAp5FQTOEtuV8Jr2/
         DNPcYFr3kIRGXgphvzGSfVUyoVRNxXEsBdNSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2kOxzZkRxT+SCDc/hWVbeiMQchYapmJ5tgcoSnW9NfA=;
        b=S7VW8mx9zKoC0kF70xEzIUNj3KcX7eTxxdEm953c31xeURRbE5Evt0S2K1P6wbThd5
         5I3V4z1c+Wqxql5vF3WRQq0MVA/dTV/ctilyu3z2HwE0F3Zs/6HWO4HFo2EwQD8QCQGH
         n9ILVvSldKfYg/5j3fC5BhgFbo90Y56pcmdErdt0Jf5rSml7jj4IZ/cg2rBN+WWbWauM
         WUEs4YW5XMtIrBMp6VT+Pvn0MSosIkMt7NAZ+TqR4CRtaInXGUAO4jZYpILZNmKrzC5G
         1VojEWpAUrCoY+Tdmjx1BAoIhzT4hQW+ywTFEBikNHigZc1TFD05O8fwmAFlwSFj0zkU
         O6kg==
X-Gm-Message-State: AJIora99Sxd9OkDPzYPH2D2/JduVYI1/SB0fOvbaEDF/PBmDLFHPvKfS
        CsGqGidFBUmWo3NsS7lb67pccw==
X-Google-Smtp-Source: AGRyM1tn283Rt4KAICZxZjkCqC4Dqisu5OgjAM1jSZZTEhExCZIzgXS5foi0gjTiljvGWvcroMLYMg==
X-Received: by 2002:a65:6b94:0:b0:3fb:16f4:3620 with SMTP id d20-20020a656b94000000b003fb16f43620mr20278951pgw.464.1657625650461;
        Tue, 12 Jul 2022 04:34:10 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d1a9:ca7d:e86f:cf6f])
        by smtp.gmail.com with ESMTPSA id 80-20020a621653000000b0052890d61628sm6537967pfw.60.2022.07.12.04.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:34:09 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH 1/2] clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops
Date:   Tue, 12 Jul 2022 19:34:01 +0800
Message-Id: <20220712113402.871838-2-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220712113402.871838-1-wenst@chromium.org>
References: <20220712113402.871838-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous commits that added CLK_OPS_PARENT_ENABLE, support for
this flag was only added to rate change operations (rate setting and
reparent) and disabling unused subtree. It was not added to the
clock gate related operations. Any hardware driver that needs it for
these operations will either see bogus results, or worse, hang.

This has been seen on MT8192 and MT8195, where the imp_ii2_* clk
drivers set this, but dumping debugfs clk_summary would cause it
to hang.

Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
Fixes: a4b3518d146f ("clk: core: support clocks which requires parents enable (part 1)")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---

I'm guessing Stephen might have some things to say about adding forward
declarations. Moving code around would make the patch larger though.

 drivers/clk/clk.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7fc191c15507..b3de636eec84 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -215,6 +215,9 @@ static bool clk_core_is_prepared(struct clk_core *core)
 	return ret;
 }
 
+static int clk_core_prepare_enable(struct clk_core *core);
+static void clk_core_disable_unprepare(struct clk_core *core);
+
 static bool clk_core_is_enabled(struct clk_core *core)
 {
 	bool ret = false;
@@ -226,6 +229,9 @@ static bool clk_core_is_enabled(struct clk_core *core)
 	if (!core->ops->is_enabled)
 		return core->enable_count;
 
+	if (core->flags & CLK_OPS_PARENT_ENABLE)
+		clk_core_prepare_enable(core->parent);
+
 	/*
 	 * Check if clock controller's device is runtime active before
 	 * calling .is_enabled callback. If not, assume that clock is
@@ -249,6 +255,9 @@ static bool clk_core_is_enabled(struct clk_core *core)
 	if (core->rpm_enabled)
 		pm_runtime_put(core->dev);
 
+	if (core->flags & CLK_OPS_PARENT_ENABLE)
+		clk_core_disable_unprepare(core->parent);
+
 	return ret;
 }
 
@@ -812,6 +821,9 @@ int clk_rate_exclusive_get(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
 
+static int clk_core_enable(struct clk_core *core);
+static void clk_core_disable(struct clk_core *core);
+
 static void clk_core_unprepare(struct clk_core *core)
 {
 	lockdep_assert_held(&prepare_lock);
@@ -835,6 +847,9 @@ static void clk_core_unprepare(struct clk_core *core)
 
 	WARN(core->enable_count > 0, "Unpreparing enabled %s\n", core->name);
 
+	if (core->flags & CLK_OPS_PARENT_ENABLE)
+		clk_core_enable(core->parent);
+
 	trace_clk_unprepare(core);
 
 	if (core->ops->unprepare)
@@ -843,6 +858,9 @@ static void clk_core_unprepare(struct clk_core *core)
 	clk_pm_runtime_put(core);
 
 	trace_clk_unprepare_complete(core);
+
+	if (core->flags & CLK_OPS_PARENT_ENABLE)
+		clk_core_disable(core->parent);
 	clk_core_unprepare(core->parent);
 }
 
@@ -891,6 +909,9 @@ static int clk_core_prepare(struct clk_core *core)
 		if (ret)
 			goto runtime_put;
 
+		if (core->flags & CLK_OPS_PARENT_ENABLE)
+			clk_core_enable(core->parent);
+
 		trace_clk_prepare(core);
 
 		if (core->ops->prepare)
@@ -898,6 +919,9 @@ static int clk_core_prepare(struct clk_core *core)
 
 		trace_clk_prepare_complete(core);
 
+		if (core->flags & CLK_OPS_PARENT_ENABLE)
+			clk_core_disable(core->parent);
+
 		if (ret)
 			goto unprepare;
 	}
-- 
2.37.0.144.g8ac04bfd2-goog

