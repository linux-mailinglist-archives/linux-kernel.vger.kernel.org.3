Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1259BB2A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiHVIPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiHVIOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:14:49 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ED81B7B2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:14:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id u12so1670223pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DRMOGZpV+QIISp4JRXmMjfwQlEf6dwNCOFyN0rcigzk=;
        b=SqWGfE6mo5mD0EZqSJ3GMcIwpU2eCmW5vM8lKGmwtj5eU0LzYYVKEUJJg5Nn2RvB6J
         zbhTyIZqVUR/AqgYJvNP1BWSrwNYzaCxTgJhI4LwgMo3bTLjYX0FKFUqivpNkvzo8a5u
         OLAt2cO3XchHdpwIHe1qBtoeW2LtksfKBHUZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DRMOGZpV+QIISp4JRXmMjfwQlEf6dwNCOFyN0rcigzk=;
        b=ap9xEQtOwSUWVOHyTCi4Xvb6gEVH3FKL/NEdas7RoTovVXt4A7Ep2B2BjehT7r5GiN
         /+ktiMi4cfUPddJIL8Rs19/E7SyrHTMIgrz5Q3pq98H88P0QkCEIh1rD4wMqarQ0DRB7
         n19Byd5jNN8wntn+AITo9imz/5iWL1dY/rmLvm3Jo4vGOeLi4YIxxF8FuJPAqhwJkwF+
         9GP9a9kM44kBsqYqACK6+wbWXoBAfNXQ3KflxTNtWTiTVKI1V36NE9j5DMD/FHt8YEEj
         p3RF+ufuQPKU6qsI5gUnI9r32bi20y58e20ALvW8xaTAPHYoXtGrktZjGWTI4/MvSFk9
         rL3A==
X-Gm-Message-State: ACgBeo2EPYQdbA5Uc7IzVs63+WtWUp35+M+jw3bGxy4OGk8NLc1l6YxS
        IhH32hTDNYgGp0ItoqImEKHKLsBQeDdNGQ==
X-Google-Smtp-Source: AA6agR7FUSE/XVfJ8Cj1cg1uhQsLHSg8Z9o+NFkZND6FLlZQjawGZ1icjFjdujCiYH2AxKCkBGSW1A==
X-Received: by 2002:a63:89c7:0:b0:429:fab3:96d7 with SMTP id v190-20020a6389c7000000b00429fab396d7mr16734118pgd.597.1661156086719;
        Mon, 22 Aug 2022 01:14:46 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d583:9d7d:3429:1b4b])
        by smtp.gmail.com with ESMTPSA id f184-20020a6238c1000000b00536b3fe1300sm1204858pfa.13.2022.08.22.01.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 01:14:46 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 2/2] clk: core: Fix runtime PM sequence in clk_core_unprepare()
Date:   Mon, 22 Aug 2022 16:14:24 +0800
Message-Id: <20220822081424.1310926-3-wenst@chromium.org>
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

In the original commit 9a34b45397e5 ("clk: Add support for runtime PM"),
the commit message mentioned that pm_runtime_put_sync() would be done
at the end of clk_core_unprepare(). This mirrors the operations in
clk_core_prepare() in the opposite order.

However, the actual code that was added wasn't in the order the commit
message described. Move clk_pm_runtime_put() to the end of
clk_core_unprepare() so that it is in the correct order.

Fixes: 9a34b45397e5 ("clk: Add support for runtime PM")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/clk/clk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9b365cd6d14b..2e29a72c68e1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -859,13 +859,12 @@ static void clk_core_unprepare(struct clk_core *core)
 	if (core->ops->unprepare)
 		core->ops->unprepare(core->hw);
 
-	clk_pm_runtime_put(core);
-
 	trace_clk_unprepare_complete(core);
 
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_disable_lock(core->parent);
 	clk_core_unprepare(core->parent);
+	clk_pm_runtime_put(core);
 }
 
 static void clk_core_unprepare_lock(struct clk_core *core)
-- 
2.37.1.595.g718a3a8f04-goog

