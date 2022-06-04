Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B91453D859
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbiFDTdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbiFDTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:45 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8A95006A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x75so4967012qkb.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJKGBDexodWWi3v7d8CIP7nDbDAKpXAShXjsyM+XqYo=;
        b=L2aTCNAmvIeV+mmoBcGrwRVseEMQ39fJ5n8rwtdgsPesbbN4QJaLLyAyaaJEAZ1eGr
         bZcRZK/rri1uLE2KV3EOsQ9SizakITASmJSCRTRrcj9zKU+zJwrnveRiUR8fRe6NUBeG
         HawmFj4dJB6TflzYC+208jPJ1c0mI/IN/IE3KQYwS/dP8czbRj5pRCUTdzIA3hLmTRa7
         SED/W4SYB8WGPmR6HUBBcWQPJuXh/GyI5VcFnRJhcgMbHlhrkZuL/3A1rr9hs9D2fPof
         Y2l4JGEeDSPIvCMuQpCV5xMGBF29JV8mozNwUHvqE2wKYS3ofK0WrWyL9sPxwiuVQLFq
         Y5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJKGBDexodWWi3v7d8CIP7nDbDAKpXAShXjsyM+XqYo=;
        b=v/heGYP763+BzTcYkfwD5aNu9uO6CuscPz+J8oay1uRKS+H3WqohXOzK9XHgIM79aV
         hZV3HOcsjkty20WzlJ8oWor+kFZ9JevVPotYsB78g9ytX/1pBvSNBY1Dgr5QMQnhLL3J
         /wiZXfPN9f+69Ky3DX7cPWJ2MIRVAXmYVJTvarzLQdnrY06O/oZk5CiS+uOYtR94ZV4x
         W8Y+Mq3RX8k7tfbZAgS1aoyT01/JLU3gittyNufJz4nsU+3J1q7D7v6q7lpdBrk7Lp4u
         /5MEfEWu/nR8z/3zzMnS1JOdA70T7/Sd1np6PktMPSqipTE1zwGoX15nEkZweUDFdpIY
         ptWA==
X-Gm-Message-State: AOAM531LiZa2nfhzU/2b2cBImu7y0yMSQlkTNCtOWZ5kXoddfDKtHJx3
        hYS8cm0G+RQlWgFWQiK7i55KyO3aTBKd
X-Google-Smtp-Source: ABdhPJwOcaHElFrLXXJvVqSZ3B+X4j3Ba3ekudjRftXMdJ/1Ph/Sgr2Q2VR4uSJIqWu5zLwMHUPHsg==
X-Received: by 2002:a37:a683:0:b0:6a6:ae13:7df8 with SMTP id p125-20020a37a683000000b006a6ae137df8mr2473713qke.385.1654371088085;
        Sat, 04 Jun 2022 12:31:28 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:27 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 25/33] clk: tegra: bpmp: Convert to printbuf
Date:   Sat,  4 Jun 2022 15:30:34 -0400
Message-Id: <20220604193042.1674951-26-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
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
2.36.0

