Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A2A550E27
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbiFTAox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbiFTAnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:49 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F226582
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:34 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id i17so7358941qvo.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gsfcZAwqlEFdpq95DCanp3EHZzLLogwQwMtGGhdzNxc=;
        b=IJg+Op9gT+0zu+I1RSZ69r2h/io0Iax9HRwqmS4TNZwJTDJb7fQj026KZbjdqpzkeQ
         jl63+ujHD9wLMzImVc5A4YY4qI9U2LNA4I8nLz6Ol+iQOJjRrtaICS3bqCJLtm94lkMX
         HlRwKatR1EWzhIi0kVdHwo7ijnkdt45FIgHRrvgsVL5dZRFPVZofaM8mB83/j4l1Y5JR
         de2b8vrhPFqHXAhnsiNg9oAo1naki+8XE3L9tyvz45B1eG2U/C1sxsCrFe0K1ge80Tq2
         QxqXh5GjwwdfbGbY3qllndBsStR188f/LqZMiittFETjyR0Ev3SqPq0l+ztbB3+OacT6
         qoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gsfcZAwqlEFdpq95DCanp3EHZzLLogwQwMtGGhdzNxc=;
        b=IqE3lEmqV2Ico727s9PVPjaUlb+vIlLINsABxqv4XCl9O39ybnOardIyKtE6EgBN+4
         ljFC4383jm2S6BcnpfI1kxxqBMuROVI6gD/hnXlUk6JMrVcPf2UPOM62XOvumTAXMUUb
         t4Bh2RZTz4KU1EmGvQCKq/lN8RtiLUXqvtkE3kfyQnp2vMwkQ662M9BQ1NF6VKy33Vlh
         Br7ODgD+I0ErSyZcPTAWfvCVEjYWPBpa3gMd6EjgGTRs88YrhV2sgosTxOhC8MdVbYbB
         rK3QprrY66CqNB+aB2xnnsHaMQQjSO0GWyfvw+QsJpWqoUSD7+wf5zYPIEk6IPMLl5lA
         Q4og==
X-Gm-Message-State: AJIora/Kj9SvXcciyGVs2ZZote98APs1NNoVOzAagUPmDl2+XvIz/iEn
        rV1goKjf14qcJgKOkrgwHRN/E9TP/wqYMEc=
X-Google-Smtp-Source: AGRyM1tQ+0xDN5He/7+qn3hDH+zCCBLc6Ym4XEqTwDgs43uHcX8GDVZ/W0pK2YuJv48o6g71jadKkQ==
X-Received: by 2002:a05:622a:493:b0:306:7794:a16 with SMTP id p19-20020a05622a049300b0030677940a16mr17925571qtx.605.1655685812910;
        Sun, 19 Jun 2022 17:43:32 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id b7-20020ac86787000000b002f93be3ccfdsm9462183qtp.18.2022.06.19.17.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:32 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 25/34] clk: tegra: bpmp: Convert to printbuf
Date:   Sun, 19 Jun 2022 20:42:24 -0400
Message-Id: <20220620004233.3805-26-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
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

This converts from seq_buf to printbuf, which is similar but heap
allocates the string buffer.

Previously in this code the string buffer was allocated on the stack;
this means we've added a new potential memory allocation failure. This
is fine though since it's only for a dev_printk() message.

Memory allocation context: printbuf doesn't take gfp flags, instead we
prefer the new memalloc_no*_(save|restore) interfaces to be used. Here
the surrounding code is already allocating with GFP_KERNEL, so
everything is fine.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/clk/tegra/clk-bpmp.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 6ecf18f71c..301551174c 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/device.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include <linux/slab.h>
 
 #include <soc/tegra/bpmp.h>
@@ -360,39 +360,38 @@ static void tegra_bpmp_clk_info_dump(struct tegra_bpmp *bpmp,
 				     const struct tegra_bpmp_clk_info *info)
 {
 	const char *prefix = "";
-	struct seq_buf buf;
+	struct printbuf buf = PRINTBUF;
 	unsigned int i;
-	char flags[64];
-
-	seq_buf_init(&buf, flags, sizeof(flags));
 
 	if (info->flags)
-		seq_buf_printf(&buf, "(");
+		prt_printf(&buf, "(");
 
 	if (info->flags & TEGRA_BPMP_CLK_HAS_MUX) {
-		seq_buf_printf(&buf, "%smux", prefix);
+		prt_printf(&buf, "%smux", prefix);
 		prefix = ", ";
 	}
 
 	if ((info->flags & TEGRA_BPMP_CLK_HAS_SET_RATE) == 0) {
-		seq_buf_printf(&buf, "%sfixed", prefix);
+		prt_printf(&buf, "%sfixed", prefix);
 		prefix = ", ";
 	}
 
 	if (info->flags & TEGRA_BPMP_CLK_IS_ROOT) {
-		seq_buf_printf(&buf, "%sroot", prefix);
+		prt_printf(&buf, "%sroot", prefix);
 		prefix = ", ";
 	}
 
 	if (info->flags)
-		seq_buf_printf(&buf, ")");
+		prt_printf(&buf, ")");
 
 	dev_printk(level, bpmp->dev, "%03u: %s\n", info->id, info->name);
-	dev_printk(level, bpmp->dev, "  flags: %lx %s\n", info->flags, flags);
+	dev_printk(level, bpmp->dev, "  flags: %lx %s\n", info->flags, printbuf_str(&buf));
 	dev_printk(level, bpmp->dev, "  parents: %u\n", info->num_parents);
 
 	for (i = 0; i < info->num_parents; i++)
 		dev_printk(level, bpmp->dev, "    %03u\n", info->parents[i]);
+
+	printbuf_exit(&buf);
 }
 
 static int tegra_bpmp_probe_clocks(struct tegra_bpmp *bpmp,
-- 
2.36.1

