Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CA047CEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243731AbhLVJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbhLVJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:10:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BE0C061574;
        Wed, 22 Dec 2021 01:10:35 -0800 (PST)
Date:   Wed, 22 Dec 2021 09:10:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640164233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2d0Wg7VLsfegQIWHVxTH9Scsya5TFPCUwn/Zyee+Ao=;
        b=1hPRagHUHTVpayjgHUDgh3j+uNZ6WGNOFsbYyZNvA5n3KwmJmjszYektwrBDFKtRVaiqRr
        zeXQR4hFUM6ZtSuK5BTMtYHVNJFX0xPSrzMs9lbfZwkd8+kZ4SAUOQW4XJwPUOye1OvSkL
        EMfdKng+3S5dsPEF9gvYj8NpjMfFjndTuIeq4uWrTL4j+/d/AkFxhdiJNllX2cTC7N8xNH
        p1BJ4uu3YQn2I/1aOAy1V71Go2R4t+5k8SPrGVNDcCV1jvKCpKXgVC4p5uv6Bc3+hhyrQP
        UYioEBHWRhgsXP1VU4GeXRcAX9pRUUpxWgOO/clcIJ8us5jsQCQC7fqoNjxX1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640164233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2d0Wg7VLsfegQIWHVxTH9Scsya5TFPCUwn/Zyee+Ao=;
        b=A5deNL/QgLMdoNpugZxDehG/kqdcjBUaiiOdseZtNk16I30SF/Pk1WfyURvfcDbenSKQaQ
        IZe/GhG96O4YVbDQ==
From:   "tip-bot2 for Ismael Luceno" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] uapi: Fix undefined __always_inline on
 non-glibc systems
Cc:     Ismael Luceno <ismael@iodev.co.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211115134647.1921-1-ismael@iodev.co.uk>
References: <20211115134647.1921-1-ismael@iodev.co.uk>
MIME-Version: 1.0
Message-ID: <164016423189.16921.12749456431975367694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     cb8747b7d2a9e3d687a19a007575071d4b71cd05
Gitweb:        https://git.kernel.org/tip/cb8747b7d2a9e3d687a19a007575071d4b71cd05
Author:        Ismael Luceno <ismael@iodev.co.uk>
AuthorDate:    Mon, 15 Nov 2021 14:46:47 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 21 Dec 2021 15:09:46 -08:00

uapi: Fix undefined __always_inline on non-glibc systems

This macro is defined by glibc itself, which makes the issue go unnoticed on
those systems.  On non-glibc systems it causes build failures on several
utilities and libraries, like bpftool and objtool.

Fixes: 1d509f2a6ebc ("x86/insn: Support big endian cross-compiles")
Fixes: 2d7ce0e8a704 ("tools/virtio: more stubs")
Fixes: 3fb321fde22d ("selftests/net: ipv6 flowlabel")
Fixes: 50b3ed57dee9 ("selftests/bpf: test bpf flow dissection")
Fixes: 9cacf81f8161 ("bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE")
Fixes: a4b2061242ec ("tools include uapi: Grab a copy of linux/in.h")
Fixes: b12d6ec09730 ("bpf: btf: add btf print functionality")
Fixes: c0dd967818a2 ("tools, include: Grab a copy of linux/erspan.h")
Fixes: c4b6014e8bb0 ("tools: Add copy of perf_event.h to tools/include/linux/")

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211115134647.1921-1-ismael@iodev.co.uk
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
---
 include/uapi/linux/byteorder/big_endian.h    | 1 +
 include/uapi/linux/byteorder/little_endian.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/byteorder/big_endian.h b/include/uapi/linux/byteorder/big_endian.h
index 2199adc..80aa5c4 100644
--- a/include/uapi/linux/byteorder/big_endian.h
+++ b/include/uapi/linux/byteorder/big_endian.h
@@ -9,6 +9,7 @@
 #define __BIG_ENDIAN_BITFIELD
 #endif
 
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/swab.h>
 
diff --git a/include/uapi/linux/byteorder/little_endian.h b/include/uapi/linux/byteorder/little_endian.h
index 601c904..cd98982 100644
--- a/include/uapi/linux/byteorder/little_endian.h
+++ b/include/uapi/linux/byteorder/little_endian.h
@@ -9,6 +9,7 @@
 #define __LITTLE_ENDIAN_BITFIELD
 #endif
 
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/swab.h>
 
