Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D8658C1D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbiHHCnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbiHHClk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FBE25C4;
        Sun,  7 Aug 2022 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fiLWB7FlMZG/t3/6at/lVnmuLuXlP9ApBxUL44LLPGI=; b=cV+xsr2dJdusY7y0TkSTgMXeQ0
        hiXR1lQDTb0NZ1r+yPBc/SHwfmocssIf1OWmy7KfHT0zQhxNolb+CBN8mJ+rzcAqxTB7d0jZGxCc2
        yeAO0NPrLksriSMv1Tjv55L/P1iTRnYT5eiymmpzFFtIySvuDh8xaUuVSOvQEysBDxEG4gsGiX8JT
        jg74xcTcIF/+GQvexqGnUqjhudrIrBlSuElsRc7yjmn8k1PmBb+p1vf0Hd5N+gDURFOfDjVagZeYF
        hZRpk2vdiPL6Ynyd65sLsSPz/ef0ZmpeorlTJZGkIhOw6f+X7tXAd41fClIw1bUShUYqzghpwigEL
        Z25ohh/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshy-00DVSX-Gm; Mon, 08 Aug 2022 02:41:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-tegra@vger.kernel.org
Subject: [PATCH v5 23/32] clk: tegra: bpmp: Convert to printbuf
Date:   Mon,  8 Aug 2022 03:41:19 +0100
Message-Id: <20220808024128.3219082-24-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

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
Cc: linux-tegra@vger.kernel.org
---
 drivers/clk/tegra/clk-bpmp.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 3748a39dae7c..7e3b48ed9d45 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/device.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include <linux/slab.h>
 
 #include <soc/tegra/bpmp.h>
@@ -365,39 +365,38 @@ static void tegra_bpmp_clk_info_dump(struct tegra_bpmp *bpmp,
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
2.35.1

