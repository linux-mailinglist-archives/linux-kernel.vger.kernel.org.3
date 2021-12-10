Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0089D46F8A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhLJBqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhLJBqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:46:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F7C061746;
        Thu,  9 Dec 2021 17:42:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C1361CE2994;
        Fri, 10 Dec 2021 01:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE95BC004DD;
        Fri, 10 Dec 2021 01:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639100557;
        bh=JlJ6afzOk2DAywlPVjTl4GV7LRs/fplw5FcqgaVwtuA=;
        h=From:To:Cc:Subject:Date:From;
        b=JVMbTC8qkQl1zij99M+ZZGj6lMJAXXox4bpKpNLye2DLFZ6imyfjek2tPM7VHmBNi
         +k3XPuQmyWB1Gbav6Y7c/ceUNdZ1u+Sl7obmIsKF/nYTKYjaFOQkDZmQOme5LvqXHz
         zT5OHsAh7pY//H634pMUYbmoGctKFM7lxcUTf9Kdv0W2SqyFYVbkmIm/rtTeY4JAuA
         vW7k2pvQQqxNysBMe/2rdLI/VljFmLJmtZZVrcal1qp29mhmFJ8qfA4oCAFG4kM530
         i9mFUH7Kr6NEvmKQKnvtSECoH0t9G8EmoaeSOL3i4lsbe7336j7of9YWzVMH6nH9Lt
         D1ksH3iFRomMg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clk: Emit a stern warning with writable debugfs enabled
Date:   Thu,  9 Dec 2021 17:42:37 -0800
Message-Id: <20211210014237.2130300-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want vendors to be enabling this part of the clk code and
shipping it to customers. Exposing the ability to change clk frequencies
and parents via debugfs is potentially damaging to the system if folks
don't know what they're doing. Emit a strong warning so that the message
is clear: don't enable this outside of development systems.

Fixes: 37215da5553e ("clk: Add support for setting clk_rate via debugfs")
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8ccedec2cc9d..ecb2a732a20d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3383,6 +3383,24 @@ static int __init clk_debug_init(void)
 {
 	struct clk_core *core;
 
+#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
+	pr_warn("\n");
+	pr_warn("********************************************************************\n");
+	pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE           **\n");
+	pr_warn("**                                                                **\n");
+	pr_warn("**  WRITEABLE clk DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL **\n");
+	pr_warn("**                                                                **\n");
+	pr_warn("** This means that this kernel is built to expose clk operations  **\n");
+	pr_warn("** such as parent or rate setting, enabling, disabling, etc.      **\n");
+	pr_warn("** to userspace, which may compromise security on your system.    **\n");
+	pr_warn("**                                                                **\n");
+	pr_warn("** If you see this message and you are not debugging the          **\n");
+	pr_warn("** kernel, report this immediately to your vendor!                **\n");
+	pr_warn("**                                                                **\n");
+	pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE           **\n");
+	pr_warn("********************************************************************\n");
+#endif
+
 	rootdir = debugfs_create_dir("clk", NULL);
 
 	debugfs_create_file("clk_summary", 0444, rootdir, &all_lists,

base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
prerequisite-patch-id: e0d3f8e3fa43b55e55d7c4cee7c4902ae06ea4e0
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

