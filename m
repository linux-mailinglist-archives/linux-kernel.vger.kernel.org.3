Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F724697E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbhLFOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:09:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34906 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245197AbhLFOJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:09:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03824B810D6;
        Mon,  6 Dec 2021 14:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B034CC341C7;
        Mon,  6 Dec 2021 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799555;
        bh=Sv8UbA+YOXh48vn+8evN0B9FHTLFFn+ALVe5qXVXpWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJJIx2BbMkchQwgLbhfKvZNtswBZzYNC59Yvyu5+n+4JXdBbqCEwkxlyroVNPsiWT
         MOE8lmmEDglEruF1dBxwgIfICBDWRoueNwYI9S8T17vdqhdWANa5fHByppqBaqeDlv
         Rtutrnypx58QOr8sRRcH1iIeCPgwUld+KAIruyKwSMrwOGtP03o882faAhzPNvQcGp
         /mbmLk7KUO/BR4MD0Aqi4V6FIxzhpLohWLeW1nZ+PC2zUZVfrOK6vZQNrNWs4NzfZz
         iwg/JfeFiT5voPLEjR0QeLw7iYWAgZeCMsJzn1KuZvGNpUR7272KVsS8hBTQ+A0I7J
         D6SsPVCaOxoCw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH 10/19] rust: export generated symbols
Date:   Mon,  6 Dec 2021 15:03:04 +0100
Message-Id: <20211206140313.5653-11-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-1-ojeda@kernel.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
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
2.34.0

