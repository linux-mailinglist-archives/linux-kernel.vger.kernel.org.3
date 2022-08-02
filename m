Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E3587549
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiHBBy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiHBBxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:53:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3084C4AD79;
        Mon,  1 Aug 2022 18:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A60BDB81919;
        Tue,  2 Aug 2022 01:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDC7C433D6;
        Tue,  2 Aug 2022 01:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405179;
        bh=Nwvosf4rZfVbsrgfu4jpbeEbnBmN8SkCMgwgVSEaawY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uULhgZSfIhDGavNWTZfQMGmjXiXiDSzPz5L0SCTzw0lG6qg1bPz1jHVyS1guvWqj7
         jQIw8fFyBNq7Twc/xoUsq68GHc39/tMV0i4G7mWtaZY0lf5YNxxuNbvrjwUi0+KUKP
         m34bVwdU4H+Re4N+T1WX6uv2YuFgjbAwStb4d3RWutxN4YnVCDfMWGGOa3FzzK9PCV
         tlquGbehZ4+iGuzAi2VagvlwQkzjyJSnXb3MjDEV/BQHNxe80964sw5deBFZ/afSvD
         72+6B1wBWhOoO8Pal/cvjhngyLwgjWqnWzPlm8LoPZki+e6uutB1KWMzz6f39wqZOA
         dcmIBVzcQmdVQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH v8 18/31] rust: export generated symbols
Date:   Tue,  2 Aug 2022 03:50:05 +0200
Message-Id: <20220802015052.10452-19-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-1-ojeda@kernel.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Co-developed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/exports.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 rust/exports.c

diff --git a/rust/exports.c b/rust/exports.c
new file mode 100644
index 000000000000..bb7cc64cecd0
--- /dev/null
+++ b/rust/exports.c
@@ -0,0 +1,21 @@
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
+#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
+
+#include "exports_core_generated.h"
+#include "exports_alloc_generated.h"
+#include "exports_bindings_generated.h"
+#include "exports_kernel_generated.h"
-- 
2.37.1

