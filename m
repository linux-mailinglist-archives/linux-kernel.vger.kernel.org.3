Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061AE5718A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbiGLLeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiGLLeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:34:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9C0AB7C9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:34:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so11101304pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHpICsyByAQH93fjocLsnPpN777QDLGLHmPw1NuqSiI=;
        b=HiWiJHoIMTwU/6yayll4vWwEVSoyDhb3Rr+kWxAHJ6wVtixr58GSQ8/vOUuXyZhSBH
         9UHzutDKljJGdU7Tav0qNG9aObjZYZF2PYLFh018b7wUnh1YSRW6tF+xpzHcOTxrg869
         qMmLVmsVV2zjXqecmyRCvbS0iZRMn1T6s9b2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHpICsyByAQH93fjocLsnPpN777QDLGLHmPw1NuqSiI=;
        b=uqkgFDVJnay0vRdU4My8DlO3TvIVj0qsCVMz8lmkIMPdJVrpcXFYVtY64nDauzVvPO
         VxboIpIb60p5gFjxW6z/XVS4thry5xHaX9OxQl7Zomqr4F7JJfsMywln2GCn+0okScHN
         PORjdgP8ufg2t9P37zhkn65LX/xl1dvpkRkzl3Cd4nBp/CrkBqh0+5Z8tYR0PSc+oUHB
         EkjfsChle+XjantaAp97LTbB0jV6ifakehTv83Ptr0CtY0uDfiitUYncFFnoTWraJm7+
         s14ojRX/tF9CDE9aK61dLf98GLYuaundMkUaNlU5fSwnvXvkmFYisY2Bd42KS50mifAt
         pheQ==
X-Gm-Message-State: AJIora83SSYsIbRupt+1oR2wueSghwoQAzlSd1eQ4C6Xs6L69Fh2mRoO
        2YMk8PeCxnp5DOPTkjp2CQ4sEA==
X-Google-Smtp-Source: AGRyM1t9YjFM9jfrb3CKRXxvF1sBMXVpXvetHSpZs3rbBUk7GAB2Qt1od81KyIufbdXQokePzaibcQ==
X-Received: by 2002:a17:90a:4294:b0:1ee:f3f2:9cd0 with SMTP id p20-20020a17090a429400b001eef3f29cd0mr3812180pjg.79.1657625652797;
        Tue, 12 Jul 2022 04:34:12 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d1a9:ca7d:e86f:cf6f])
        by smtp.gmail.com with ESMTPSA id 80-20020a621653000000b0052890d61628sm6537967pfw.60.2022.07.12.04.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:34:12 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH 2/2] clk: core: Fix runtime PM sequence in clk_core_unprepare()
Date:   Tue, 12 Jul 2022 19:34:02 +0800
Message-Id: <20220712113402.871838-3-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220712113402.871838-1-wenst@chromium.org>
References: <20220712113402.871838-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the original commit 9a34b45397e5 ("clk: Add support for runtime PM"),
the commit message mentioned that pm_runtime_put_sync() would be done
at the end of clk_core_unprepare(). This mirrors the operations in
clk_core_prepare() in the opposite order.

However, the actual code that was added wasn't in the order the commit
message described. Move clk_pm_runtime_put() to the end of
clk_core_unprepare() so that it is in the correct order.

Fixes: 9a34b45397e5 ("clk: Add support for runtime PM")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/clk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b3de636eec84..87684daadedd 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -855,13 +855,12 @@ static void clk_core_unprepare(struct clk_core *core)
 	if (core->ops->unprepare)
 		core->ops->unprepare(core->hw);
 
-	clk_pm_runtime_put(core);
-
 	trace_clk_unprepare_complete(core);
 
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_disable(core->parent);
 	clk_core_unprepare(core->parent);
+	clk_pm_runtime_put(core);
 }
 
 static void clk_core_unprepare_lock(struct clk_core *core)
-- 
2.37.0.144.g8ac04bfd2-goog

