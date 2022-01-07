Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6037487C3E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348826AbiAGSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:33:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43206 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240556AbiAGSda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:33:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD53D60BD3;
        Fri,  7 Jan 2022 18:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370CAC36AE0;
        Fri,  7 Jan 2022 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641580409;
        bh=/O1V8c1GBTvHNkBLACc6ZOiDCdYgbkOd1VzcLgA42jQ=;
        h=From:To:Cc:Subject:Date:From;
        b=M0Y7keVE7rrIVFdBNO2atcUnhA56BhFQhTy1L6AXowSSUPb//mMnH+ghuIu4c+CIx
         6k1rIi6UQXJrePHrjoTP3MLNOnTYDSjqB/hFxeMY4Udoqwp/XR2JXDnLCY2hjSUBVb
         NWrJ3WqCpMws10Xc8E4w5B2Y8vqEHKQfnS6WvMlzEP7TIXR+0XeFBW8pC+/aJ45O8w
         BMplBOHZuxZKI5Y1YuF8gZYj3TYx6yxT1tvktM2GWiKOhMxIk7khsKD4td8WjgnSwF
         pNmdl10WxB9p4LY7d6rQiAUBqYdf2zBOWCe7I1UV5/yH8uCchTmkvWN41cJw2eJmQC
         vchUXo9JjGqPQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] clk: visconti: Remove pointless NULL check in visconti_pll_add_lookup()
Date:   Fri,  7 Jan 2022 11:33:03 -0700
Message-Id: <20220107183303.2337676-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/clk/visconti/pll.c:292:20: warning: address of array 'ctx->clk_data.hws' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (ctx->clk_data.hws && id)
            ~~~~~~~~~~~~~~^~~ ~~
1 warning generated.

This array cannot be NULL if ctx is not NULL, which is allocated in
visconti_init_pll(), so just remove the check, which matches other clk
drivers.

Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and reset driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/1564
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/clk/visconti/pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c
index 3b6e88bb73d5..a2398bc6c6e4 100644
--- a/drivers/clk/visconti/pll.c
+++ b/drivers/clk/visconti/pll.c
@@ -289,7 +289,7 @@ static void visconti_pll_add_lookup(struct visconti_pll_provider *ctx,
 				    struct clk_hw *hw_clk,
 				    unsigned int id)
 {
-	if (ctx->clk_data.hws && id)
+	if (id)
 		ctx->clk_data.hws[id] = hw_clk;
 }
 

base-commit: 70faf946ad975c64efb2eb809f9139f304a494b0
-- 
2.34.1

