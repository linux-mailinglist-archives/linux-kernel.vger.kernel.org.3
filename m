Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D260D463F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbhK3VCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343860AbhK3U7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:59:22 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6CCC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:02 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id kl8so19336456qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Bo+Pv75ux3OGEm6ikDV6Ba4T5sjSa44YKAVb8mwSlU=;
        b=OATjX5FBqQrB/au9HwrGyDr0P1n5KmjZCIlBvsKMXmrNI9tqL54t4Qn+s0PxUZ+J9n
         uRO0Y5sAoLOmje3P0Bv3aVIGkjarnBz15YPpUObEn2Kv7yT7k01DPceuJNANJFB+OKIB
         ts16woG+VQfdW+qRpcLLUw5eCm6u+Uwd9Q8RZtMM/ZPce2tavN/XrmaW7eJihaflpr1I
         dhOGXyIdlCOsWH+ZJjfOb6Kjl3QNiAJgxMmq06bOwBdTau21seh16KO33NASZrYuGNRb
         rkM6SyKhg+2SL2Lf88jPMkZJtLLpsrOINSnftQfLbJfIKU8XZ07qCohpVJwdsYtzeC+f
         v2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Bo+Pv75ux3OGEm6ikDV6Ba4T5sjSa44YKAVb8mwSlU=;
        b=H0BX/bhAidEmFtH5pvS3k6MVoNYV8Vl9S6bXY2132iR1yHhQPIGWw2mi+XqoebQR+Q
         3SFv5CNDaQoFgDzFK9I78h9XW2VVOt/3V/bFwJQXW/SMTk3Cj9yJRaS3EqzMsBdu9w+J
         IhIlcJj4kVLa8oLt9wCgbpPaWO+sARE/oowFuhdJUz09/VxofQyy5FfX2Siu+2ce8tTb
         D6qMtEb9EXLIIUVDld93369kD2wAOJepDlLCtbLE09LQR2TvCcwuOGatR8W6tCzCQAcg
         cWPfqF8BLoxLEvZSM7SwD8txSCicdaQDqW6gjt+GQBNz5xYYrT8HtGg63L6Vm3su6XJj
         AhFA==
X-Gm-Message-State: AOAM532MmxjQAno5ZbI4U75nWoj0Ee/3PetAKY/FS0EuJlag7d7Ly3od
        lncAj0ue9ZdF9p79Wq8UaEQTPqgoOA==
X-Google-Smtp-Source: ABdhPJwJl4cxTR60TgMFp63gz6NhdkpYDBFhrT21J/a+4OqKgInRVp7cOp/8GpHAm7xd65KGNQ82AA==
X-Received: by 2002:a05:6214:23c9:: with SMTP id hr9mr1627021qvb.80.1638305761431;
        Tue, 30 Nov 2021 12:56:01 -0800 (PST)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id t11sm10549356qkp.56.2021.11.30.12.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:56:01 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 1/6] x86: Remove stack protector test scripts
Date:   Tue, 30 Nov 2021 15:55:44 -0500
Message-Id: <20211130205549.116673-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130205549.116673-1-brgerst@gmail.com>
References: <20211130205549.116673-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 64-bit, this test for the stack protector was added in 2006 to
make sure the compiler had the PR28281 patch applied.  With GCC 5.1
being the minimum supported compiler now, this test is no longer
necessary.

For 32-bit, testing for compiler option support can be done directly
in Kconfig.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                          | 7 +++----
 scripts/gcc-x86_32-has-stack-protector.sh | 8 --------
 scripts/gcc-x86_64-has-stack-protector.sh | 4 ----
 3 files changed, 3 insertions(+), 16 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8ef4c24cc569..82ed7fdddc75 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -392,12 +392,11 @@ config PGTABLE_LEVELS
 
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
-	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 64BIT
-	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC))
+	default y if 64BIT
+	default $(cc-option,-mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard)
 	help
 	   We have to make sure stack protector is unconditionally disabled if
-	   the compiler produces broken code or if it does not let us control
-	   the segment on 32-bit kernels.
+	   the compiler does not let us control the segment and symbol.
 
 menu "Processor type and features"
 
diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
deleted file mode 100755
index 825c75c5b715..000000000000
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# This requires GCC 8.1 or better.  Specifically, we require
-# -mstack-protector-guard-reg, added by
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
deleted file mode 100755
index 75e4e22b986a..000000000000
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
-- 
2.31.1

