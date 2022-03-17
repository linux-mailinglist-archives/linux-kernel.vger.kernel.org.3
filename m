Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08624DCD48
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbiCQSOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiCQSOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:14:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4783A21F76A;
        Thu, 17 Mar 2022 11:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C63C26167E;
        Thu, 17 Mar 2022 18:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C614C340E9;
        Thu, 17 Mar 2022 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647540728;
        bh=bUhkeyVMEpUF8zm+Yp0Qgcuxbk2GMC5TY1d7kJdRmus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+Eu65csOPVvAQHxp+d2RmeYqZM3l2T65SXH6C1f7xMfD3Nqy7gq8ZkPtq+xn8cvy
         wFLp3pGeHuDdD4MfdwhL6221bpghlMuW7WJ/pzwJAUn0yw/mF6hPT0mVKmQDCzY0pP
         rW3cLCJV2Dk55tQDNrEE3l7KgUZSmFxSPqRB1iJhvYu3e80ctqrlW9iaAkCBiejQST
         hHVjWwGjMoJfMkyBJrYLHI3nKsi6GNRUOxHj3TcWayNEWCMWJdqYR9FBppgSM2pdvA
         zOX4HVKc+yOz6Sjwij/M2lrx70AYq2lW8jxAW8xw0gyiJzFW5Oqe3MuTuPPAH0Iy6H
         YNAQiFkLAVcFA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v5 11/20] rust: export generated symbols
Date:   Thu, 17 Mar 2022 19:09:59 +0100
Message-Id: <20220317181032.15436-12-ojeda@kernel.org>
In-Reply-To: <20220317181032.15436-1-ojeda@kernel.org>
References: <20220317181032.15436-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All symbols are reexported reusing the `EXPORT_SYMBOL_GPL` macro
from C. The lists of symbols are generated on the fly.

There are three main sets of symbols to distinguish:

  - The ones from the `core` and `alloc` crates (from the Rust
    standard library). The code is licensed as Apache/MIT.

  - The ones from our abstractions in the `kernel` crate.

  - The helpers (already exported since they are not generated).

We export everything as GPL. This ensures we do not mistakenly
expose GPL kernel symbols/features as non-GPL, even indirectly.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/exports.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 rust/exports.c

diff --git a/rust/exports.c b/rust/exports.c
new file mode 100644
index 000000000000..fe3dcfdd6fbf
--- /dev/null
+++ b/rust/exports.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A hack to export Rust symbols for loadable modules without having to redo
+ * the entire `include/linux/export.h` logic in Rust.
+ *
+ * This requires the Rust's new/future `v0` mangling scheme because the default
+ * one ("legacy") uses invalid characters for C identifiers (thus we cannot use
+ * the `EXPORT_SYMBOL_*` macros).
+ *
+ * All symbols are exported as GPL-only to guarantee no GPL-only feature is
+ * accidentally exposed.
+ */
+
+#include <linux/module.h>
+
+#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym);
+
+#include "exports_core_generated.h"
+#include "exports_alloc_generated.h"
+#include "exports_kernel_generated.h"
-- 
2.35.1

