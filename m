Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A16C5933FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiHOR0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiHOR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:26:26 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD59E0DE;
        Mon, 15 Aug 2022 10:26:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660584383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eI2BGmyyIY8zW+rShKl34oPf/vsRJS4uIVl8kL8dn94=;
        b=r8tYQABG44qVpTNChmwVXjRHuWc3Te68jLi5Lm3J1MugACfcvqvgeHAs38aBcYZEyLfnUK
        b3usRfKjvSRH217n7MXZDCSSNyoRfLUXwf0CWvvsF1Fq3kCYYN1lsJjClm5rMTA58t3eeb
        Nw8GuPqJFRzsnaNljCKUm80fE2xIhUc=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 02/11] clk: tegra: bpmp: Convert to printbuf
Date:   Mon, 15 Aug 2022 13:26:04 -0400
Message-Id: <20220815172613.621627-3-kent.overstreet@linux.dev>
In-Reply-To: <20220815172613.621627-1-kent.overstreet@linux.dev>
References: <20220815172613.621627-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
index 3748a39dae..7e3b48ed9d 100644
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
2.36.1

