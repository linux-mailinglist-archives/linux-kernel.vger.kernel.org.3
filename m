Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6964B352A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 14:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiBLNGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 08:06:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbiBLNGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 08:06:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B662982D;
        Sat, 12 Feb 2022 05:05:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B73360E8E;
        Sat, 12 Feb 2022 13:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E30C340EE;
        Sat, 12 Feb 2022 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644671156;
        bh=rrREVX03S6o2+GQ+Y19T5cBN1f9aL3VHbifykc6norU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6N0oQP3Z5GIpUw5WAPvKbXPqIXIaBkctGL4u74IWL146ry/1PeOsoV8XkeTrKC/k
         MQBGXs2Het9arydYTiIVHau2cwhHHKRlu+TvsAYh1IELvRY7RKdunVDSGuXLsCicrh
         SzHuN0InPnJahcmIvAYSFXE+J4otIETQEI5FuIipgPpQKN8JnCN/zBqpINHIeMsEmD
         qYgiEE9h2ENX8xVVrmAuyG3ooyyppa/bfinP+pRQ2rtKlVfMWPi+g7hlOx8ORtB0lF
         NqWXq6uToTUdTeY8uI1qjsJMbWreRkYzaRHhh8xATQHP0EcvPCZzjZqaIKTzlWjvng
         2+HCQ8fsJTOWw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v4 11/20] rust: export generated symbols
Date:   Sat, 12 Feb 2022 14:03:37 +0100
Message-Id: <20220212130410.6901-12-ojeda@kernel.org>
In-Reply-To: <20220212130410.6901-1-ojeda@kernel.org>
References: <20220212130410.6901-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 rust/exports.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 rust/exports.c

diff --git a/rust/exports.c b/rust/exports.c
new file mode 100644
index 000000000000..a9aec51eed8a
--- /dev/null
+++ b/rust/exports.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// A hack to export Rust symbols for loadable modules without having to redo
+// the entire `include/linux/export.h` logic in Rust.
+//
+// This requires the Rust's new/future `v0` mangling scheme because the default
+// one ("legacy") uses invalid characters for C identifiers (thus we cannot use
+// the `EXPORT_SYMBOL_*` macros).
+//
+// All symbols are exported as GPL-only to guarantee no GPL-only feature is
+// accidentally exposed.
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

