Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DAE59BB2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiHVIOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiHVIOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:14:47 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A603FD37
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:14:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d71so8721455pgc.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IE9z0fBhPksiP/pwlYETW9TxjlMXMx385aynhNYxesU=;
        b=a4xELweNAdtImdOryMuf97q6wznTft+2pd2NXGi9/Uu45MwqTCJeS8d9uIVlcK0R1t
         Wbc8Dwgtwhbpzq5tvdebGhyB+UdIUfeu0d9Qj9dA3p/WRL3HJHY/6KjrSoUqT46kAKRF
         AW4N7OsQirmPq4MiHJqK22PhIFuZtzTleTqVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IE9z0fBhPksiP/pwlYETW9TxjlMXMx385aynhNYxesU=;
        b=FsdfhAne7tjcInVElvCDen89jMgfPXKHVGiC5VHCn3f4gDEVLJPGWJGiNls4lEplSI
         9WafqYwQKRWeOxgAX21DEoydJGG+MrhZ886M/ZdSXe/YafOdnJejXrFttxEYClvChJ/d
         XFpSF1LMMxuwUNpkMntc0eOBlFObJeFyJhcYofw0ZcQsCu4U9JEe/NG32d2iCXwE5U8j
         lgy8URMRstngdwkC9p87Q/FNdJnE0lvBkFiuKURbUHLdKq2jxCvfeWvPU9a4zncP/HWX
         AjUB2cJjieBBfWHJ3CKstWuqdnxmAgzrCN5H24xgk0zynVcCnNdYpWxNAudbyQ9GWLrc
         fAcA==
X-Gm-Message-State: ACgBeo2eO5jH5mMTgHnzst6fShUniwjxB0APGzEPa+9v1NIfXHVZ/fAQ
        nV3b5XneupvYd+BsIbnFeHTa498A7b1EcQ==
X-Google-Smtp-Source: AA6agR6Jupl9v7GziBhTOH0kDalXXlDMdRXBBnW8kLYLAJqa3IodQup2do2g2gD+AwNYygTwOsFPjg==
X-Received: by 2002:a63:f94f:0:b0:429:7aef:e252 with SMTP id q15-20020a63f94f000000b004297aefe252mr16679215pgk.270.1661156084627;
        Mon, 22 Aug 2022 01:14:44 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d583:9d7d:3429:1b4b])
        by smtp.gmail.com with ESMTPSA id f184-20020a6238c1000000b00536b3fe1300sm1204858pfa.13.2022.08.22.01.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 01:14:44 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 1/2] clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops
Date:   Mon, 22 Aug 2022 16:14:23 +0800
Message-Id: <20220822081424.1310926-2-wenst@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220822081424.1310926-1-wenst@chromium.org>
References: <20220822081424.1310926-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/clk/clk.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7fc191c15507..9b365cd6d14b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -196,6 +196,9 @@ static bool clk_core_rate_is_protected(struct clk_core *core)
 	return core->protect_count;
 }
 
+static int clk_core_prepare_enable(struct clk_core *core);
+static void clk_core_disable_unprepare(struct clk_core *core);
+
 static bool clk_core_is_prepared(struct clk_core *core)
 {
 	bool ret = false;
@@ -208,7 +211,11 @@ static bool clk_core_is_prepared(struct clk_core *core)
 		return core->prepare_count;
 
 	if (!clk_pm_runtime_get(core)) {
+		if (core->flags & CLK_OPS_PARENT_ENABLE)
+			clk_core_prepare_enable(core->parent);
 		ret = core->ops->is_prepared(core->hw);
+		if (core->flags & CLK_OPS_PARENT_ENABLE)
+			clk_core_disable_unprepare(core->parent);
 		clk_pm_runtime_put(core);
 	}
 
@@ -244,7 +251,13 @@ static bool clk_core_is_enabled(struct clk_core *core)
 		}
 	}
 
+	if (core->flags & CLK_OPS_PARENT_ENABLE)
+		clk_core_prepare_enable(core->parent);
+
 	ret = core->ops->is_enabled(core->hw);
+
+	if (core->flags & CLK_OPS_PARENT_ENABLE)
+		clk_core_disable_unprepare(core->parent);
 done:
 	if (core->rpm_enabled)
 		pm_runtime_put(core->dev);
@@ -812,6 +825,9 @@ int clk_rate_exclusive_get(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
 
+static int clk_core_enable_lock(struct clk_core *core);
+static void clk_core_disable_lock(struct clk_core *core);
+
 static void clk_core_unprepare(struct clk_core *core)
 {
 	lockdep_assert_held(&prepare_lock);
@@ -835,6 +851,9 @@ static void clk_core_unprepare(struct clk_core *core)
 
 	WARN(core->enable_count > 0, "Unpreparing enabled %s\n", core->name);
 
+	if (core->flags & CLK_OPS_PARENT_ENABLE)
+		clk_core_enable_lock(core->parent);
+
 	trace_clk_unprepare(core);
 
 	if (core->ops->unprepare)
@@ -843,6 +862,9 @@ static void clk_core_unprepare(struct clk_core *core)
 	clk_pm_runtime_put(core);
 
 	trace_clk_unprepare_complete(core);
+
+	if (core->flags & CLK_OPS_PARENT_ENABLE)
+		clk_core_disable_lock(core->parent);
 	clk_core_unprepare(core->parent);
 }
 
@@ -891,6 +913,9 @@ static int clk_core_prepare(struct clk_core *core)
 		if (ret)
 			goto runtime_put;
 
+		if (core->flags & CLK_OPS_PARENT_ENABLE)
+			clk_core_enable_lock(core->parent);
+
 		trace_clk_prepare(core);
 
 		if (core->ops->prepare)
@@ -898,6 +923,9 @@ static int clk_core_prepare(struct clk_core *core)
 
 		trace_clk_prepare_complete(core);
 
+		if (core->flags & CLK_OPS_PARENT_ENABLE)
+			clk_core_disable_lock(core->parent);
+
 		if (ret)
 			goto unprepare;
 	}
-- 
2.37.1.595.g718a3a8f04-goog

