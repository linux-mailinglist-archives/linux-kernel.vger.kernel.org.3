Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE93A530777
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352884AbiEWCFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352576AbiEWCEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:04:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA57D39140;
        Sun, 22 May 2022 19:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AB6AB80EA5;
        Mon, 23 May 2022 02:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A37C34115;
        Mon, 23 May 2022 02:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653271438;
        bh=aK8g7YMuhRZgp2N5KP65riZ4nX/BjeCdLeOjA/xPOVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZ/uJwEDrrrmp7GTqBPiaeJClYMerrbggk8QPGp5Ef39QyFOQ9jomO5+mWpWYWhNj
         2PqqP+nsRDLzgi/iXOQ10kLkRgz/bnSXqII+zOHQhd98gQ2hbdmEeiC0rbG6fTZ4DU
         epoGhV2qzhW/Kqxs2N86+lxhfqPAiq/SOC5ngPpNo0OlyJ401beiKFmEsDasIq206S
         rmOuDgXD6Ch+lpaaAGpf3HvTAffjke+hVuJIyMuap6BIs0gJB1N64iuFi6etVjOR6V
         HmGEDqXLDaP4293dBobYW4w+d4qwZchhbg94NMWsEq5JBLD3aydNW0x/Z/7475lzFK
         RiBzCjaImL0bw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v7 13/25] rust: export generated symbols
Date:   Mon, 23 May 2022 04:01:26 +0200
Message-Id: <20220523020209.11810-14-ojeda@kernel.org>
In-Reply-To: <20220523020209.11810-1-ojeda@kernel.org>
References: <20220523020209.11810-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.36.1

