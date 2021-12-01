Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D24465196
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350943AbhLAP3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350961AbhLAP3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:29:34 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5256FC061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:26:13 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so12433348wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KwI6f4Z+SG6OLZ2CA76lIDj1HnRQns/gAAi6BnRl9xE=;
        b=L4KrD9fytPCqFfJpm7zKkhS2HO4DerOuUVaA/yqVFNpq2ISBqnspeoM40Yvr0t7k/D
         4iB0lDCoqTijStxCKHlbhOx3O3Fb0tJSEgpfnH1GHPJCe22BpkW/34cppuOiFTLUDlrZ
         Uu+CYeg9YBIKTbm3GXdkp6NOX0szTlGc0WMN48DnnO+9nMyi+2B1TItUDNBJ+/2MXbQV
         fNEHRtFwwkwbIsIGUvfWP1+nXooOpGx5aOorerAL3HND0JkqkWNwn4I40B2Rmcy9psXH
         Dix19JTyCsztwltZECYBTFMqarDF4ghypj1oTqoWDDT11ruXegfBl22e6Zos/ackfENo
         bwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KwI6f4Z+SG6OLZ2CA76lIDj1HnRQns/gAAi6BnRl9xE=;
        b=NTtYjSP83xFbeQvpO6fV84wAqpOptVPyHHfFlTR5zpPGNEP/7rWVIkxc0Xwc/K9fnD
         3XptjUD1eHUz1Cuz/+dKatm8oYHXQdtoJJxQxD4x4Lttxc+i74dSNxsfdrmBxOaO8ysG
         MXa9bP8YL/sWgsEt+4ZQeTeLnPeak5PiKQz+1/b4vTmKV0uaIpaDByPF75zYds5ctn1J
         ho68zkk8eJo+tC9FtvWUldqQ4608Waos66WLD8jz7b4RaKmOiiV59m57esiVR0dBIRNa
         ypXSbNU3U8q1SO2tfSQ4Pr1WY980zcITWAVu6unij/eUUjIYYcN6YjF/cl0/1ZEaKMmL
         hxAw==
X-Gm-Message-State: AOAM533M2t8rE2HuoDovczpvLx7udv12w6DYMIlAuemkoxN2sXoR42K8
        ZIpW3tL2LzgK5FUx9CLPqBw9Y9u6Lw==
X-Google-Smtp-Source: ABdhPJzH7BSHdEv19rN0wDFTHkoKh/DPf7zIINrpO+Z1PL0DO5khj8ogwlSq8tOln6a56ZQ+PVk6VSMzSw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:95ad:1401:cf07:6d1a])
 (user=elver job=sendgmr) by 2002:a05:600c:4f0b:: with SMTP id
 l11mr21247wmq.0.1638372371145; Wed, 01 Dec 2021 07:26:11 -0800 (PST)
Date:   Wed,  1 Dec 2021 16:26:04 +0100
Message-Id: <20211201152604.3984495-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] kcov: fix generic Kconfig dependencies if ARCH_WANTS_NO_INSTR
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until recent versions of GCC and Clang, it was not possible to disable
KCOV instrumentation via a function attribute. The relevant function
attribute was introduced in 540540d06e9d9 ("kcov: add
__no_sanitize_coverage to fix noinstr for all architectures").

x86 was the first architecture to want a working noinstr, and at the
time no compiler support for the attribute existed yet. Therefore,
0f1441b44e823 ("objtool: Fix noinstr vs KCOV") introduced the ability to
NOP __sanitizer_cov_*() calls in .noinstr.text.

However, this doesn't work for other architectures like arm64 and s390
that want a working noinstr per ARCH_WANTS_NO_INSTR.

At the time of 0f1441b44e823, we didn't yet have ARCH_WANTS_NO_INSTR,
but now we can move the Kconfig dependency checks to the generic KCOV
option. KCOV will be available if:

	- architecture does not care about noinstr, OR
	- we have objtool support (like on x86), OR
	- GCC is 12.0 or newer, OR
	- Clang is 13.0 or newer.

Signed-off-by: Marco Elver <elver@google.com>
---
 arch/x86/Kconfig  | 2 +-
 lib/Kconfig.debug | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95dd1ee01546..c030b2ee93b3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -78,7 +78,7 @@ config X86
 	select ARCH_HAS_FILTER_PGPROT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
-	select ARCH_HAS_KCOV			if X86_64 && STACK_VALIDATION
+	select ARCH_HAS_KCOV			if X86_64
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ef7ce18b4f5..589c8aaa2d5b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1977,6 +1977,8 @@ config KCOV
 	bool "Code coverage for fuzzing"
 	depends on ARCH_HAS_KCOV
 	depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
+	depends on !ARCH_WANTS_NO_INSTR || STACK_VALIDATION || \
+		   GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
 	select DEBUG_FS
 	select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
 	help
-- 
2.34.0.rc2.393.gf8c9666880-goog

