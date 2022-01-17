Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB32490177
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiAQFfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:35:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40836 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiAQFek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:34:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B17AD60DFF;
        Mon, 17 Jan 2022 05:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D02C36AED;
        Mon, 17 Jan 2022 05:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642397679;
        bh=5sO+DVq/B8LfLiCRXoo9vrGP1/bmz/YXbgCFN+RtTx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IUn1GUnKX2r0MiWblWp4CWoPAnflgTGFC12IMZvNlbd8ekmTxqUzCuw9LjWD4aXTO
         b3zMELQcDY1kzPEnh6FZAsP86O0nLUcta4d5lU1jPKnTMXumryAgSkYGFPQXV7mL+Y
         CYBRrgmSxFSzLTzJafi2GbllCYxXKokksqSwvr2npRlRi0UWS3gAuEn5i1ndj4TQ45
         3Lj2rY8ZI/z9/u9/lGvH3+c0NLTdcKoeHnhNlOUdS0ErmctxpPQ+k81gnSJC0Z/zKl
         VFN5+dgM+zLSibErbCEf7gxl9/YWrsIa+pEwiZk/pgDaZ9eYT3J/8YUpSAu78uOzlu
         uI8/bXGLydEFQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v3 10/19] rust: export generated symbols
Date:   Mon, 17 Jan 2022 06:33:40 +0100
Message-Id: <20220117053349.6804-11-ojeda@kernel.org>
In-Reply-To: <20220117053349.6804-1-ojeda@kernel.org>
References: <20220117053349.6804-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 rust/exports.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 rust/exports.c

diff --git a/rust/exports.c b/rust/exports.c
new file mode 100644
index 000000000000..d7dff1b3b919
--- /dev/null
+++ b/rust/exports.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// A hack to export Rust symbols for loadable modules without having to redo
+// the entire `include/linux/export.h` logic in Rust.
+//
+// This requires the Rust's new/future `v0` mangling scheme because the default
+// one ("legacy") uses invalid characters for C identifiers (thus we cannot use
+// the `EXPORT_SYMBOL_*` macros).
+
+#include <linux/module.h>
+
+#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym);
+
+#include "exports_core_generated.h"
+#include "exports_alloc_generated.h"
+#include "exports_kernel_generated.h"
-- 
2.34.1

