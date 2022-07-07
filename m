Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70B4569F13
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbiGGKDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiGGKDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:03:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC083192C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:03:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v14so25583978wra.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0vZOGzWGZ/XO6zAE9EANkv0Ksk8cGK1twtf6zicImM=;
        b=kznfz8BZq2mc6CDFmmSESwHqfYtxDnIQcY3udHhOo5r4x7ew35us/9p0iWIfwJwKfv
         FKHSR/kazvJsEtK+ZxxdYyMBQqKz01aiywfvbDtuh8S+551PWf0sNMw1N/eJlVlMQnG8
         fn4YijInV79eZvhrTHH/o5crrzrgk1ZLXFWYrPBG+CL5RVRzGGuSfg14/FCbLRZec7dn
         tYlkSqbyKi6AP+4xr49K/LTyy04hmcDDt6kkkEJFXGy3IdiY/XdW5p1zDgtp8PdwSdGI
         gTqR/jNliQ1gf99f8/j6WzlNeqPjuYXoxuuAGyNRX7RqmHVpv8gh7eO5UoZytJtNttrq
         prag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0vZOGzWGZ/XO6zAE9EANkv0Ksk8cGK1twtf6zicImM=;
        b=vNn4BGBIvCPwb0wUXz7Xp5zZ6eGydssor0JxJDOTtvZ/D1JQsPew+VQhLUXXMrSTQF
         O3JTM/nbkRMLRb1KXtjbBW5cRmOxcQTwrAcL9zgWxZtqJHIsIVUTZ6lrl4XSBAgcwBNY
         DqrNV3PIAIkksb9i7olQZjsJk4e1pJPb9dyokhQRS5m9g5aB8+wfTZFEqNBVmmBSSskW
         ae7nPpKKbpohRG99cACwxDoL+jgoCgIgtdYSplVWQRk4IohicxFMAKek8RZ7ghjc06Gi
         d9PlxeOYrpgV3UdERX0F9pqFCcdkPGnD27ZB+5Uf9iry2+YLZGCHLvjIFfgLJPhmlhz4
         2yqg==
X-Gm-Message-State: AJIora8OJ8pitIL2NTB3Nk8rGVJx2nqTpq+utgnQIs0hiYwwdmnLQ4p9
        hIi4ZzG5SN2z1D7w0BXw27v0lA==
X-Google-Smtp-Source: AGRyM1shZYWd4bEBmVlz7fWpCBjNR12KwTWTJeKuIpR9ErTrkaVkZ5U1PJdsIhR7FR75vPQYLUsd3Q==
X-Received: by 2002:a5d:6d06:0:b0:21b:c433:d1f6 with SMTP id e6-20020a5d6d06000000b0021bc433d1f6mr42623372wrq.717.1657188223813;
        Thu, 07 Jul 2022 03:03:43 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d548e000000b0021d7ad6b9fdsm4612034wrv.57.2022.07.07.03.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:03:43 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC PATCH 4/4] clk: Skip disabling clocks if they have consumers
Date:   Thu,  7 Jul 2022 13:03:09 +0300
Message-Id: <20220707100309.1357663-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220707100309.1357663-1-abel.vesa@linaro.org>
References: <20220707100309.1357663-1-abel.vesa@linaro.org>
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

If a clock has already consumers, it should be considered as used.
So clk_disable_unused should leave it as is.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/clk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e412e83a6e28..6cce31ea4f72 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1228,6 +1228,9 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 	hlist_for_each_entry(child, &core->children, child_node)
 		clk_unprepare_unused_subtree(child);
 
+	if (core->consumers_count)
+		return;
+
 	if (core->prepare_count)
 		return;
 
@@ -1259,6 +1262,9 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 	hlist_for_each_entry(child, &core->children, child_node)
 		clk_disable_unused_subtree(child);
 
+	if (core->consumers_count)
+		return;
+
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_prepare_enable(core->parent);
 
-- 
2.34.3

