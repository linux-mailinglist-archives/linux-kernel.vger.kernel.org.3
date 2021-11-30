Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6523F463307
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbhK3LtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbhK3Lsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:48:53 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD46C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:45:33 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id s12-20020a50ab0c000000b003efdf5a226fso10528280edc.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=e4DEXl9ENL8f6grIX8Smd5WFfYq3AcFIjaS7u+NEo6I=;
        b=VRFC3Sd61/1Tk7+lMqH9mkXHzsXrk6VDRpNr/RODxLb0s8opBH5XBdY0sCSwlL4os0
         aNipizz3jan6hjYbfkih51nEKluedB8DR5M+li6i6hvW06Y0WJ5x5tx3zq2x3JKh92zp
         beJxpvn/kGN1x6ljKuhUDI2IbBAwSqkUeaN+7HU3YpFEvrF+c/6aydWsQctO4Ymd0udk
         IJ84ZzgzCmWkNlqi/QghFcQ2djhgKy4WBgUVGPVv6c4CskqMJrMZy7XrZOPfGlo9LN1Z
         65TsX2NnW+8SOrVW+OK5wZAA3QUZMDcz6AMizaKTb/XX111gUThqKlkXg/p7apaNndAq
         SUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=e4DEXl9ENL8f6grIX8Smd5WFfYq3AcFIjaS7u+NEo6I=;
        b=lKIB+v4HipWi8VWmNAic2NVfO0tikIo6tgxxOtmctn+fS91FHAZWy8NV2fg5TCO24l
         YLmmPGDotI9atYh0PJKM635K/0oHG8P/E1xMYW1RXnUHHtprE9F0H1uqjpL9hSvXj/5X
         aUy8Nx0Sp+ziZif5J5bQ8xl9Ycbm3/WWOr9GuDbMMPUteh/IAwVbKQBkyYcjuptM36i4
         8gOBWKMxd9RzQkro3a/cubED3qlbN7LGX0pUbY+oSOMo1eN9urt2QDzp7JZvy665TzcI
         0TrOcXleEzrJM+2F+A1D4bgzkZ5dcdGda8xO8EkwWA4rKu5pgXwcxBl25HWVant4IF5L
         KTyA==
X-Gm-Message-State: AOAM530YlFSay5EUcXw5H3MBWjY1Ylcg6JJEtz4YtbM9PoKINLHZu8vH
        g2VHZaG4NBanmCv7B1SwzUDRxZzC6g==
X-Google-Smtp-Source: ABdhPJz7RyZqdN7S4/+caxzBBOK3JiCGoO88loaeaBFa4FUTBsvk6hn509wWF6mKeqicro2oUCPsrxEoNg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:a17:907:3f29:: with SMTP id
 hq41mr66294129ejc.216.1638272732309; Tue, 30 Nov 2021 03:45:32 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:20 +0100
In-Reply-To: <20211130114433.2580590-1-elver@google.com>
Message-Id: <20211130114433.2580590-13-elver@google.com>
Mime-Version: 1.0
References: <20211130114433.2580590-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 12/25] kcsan: Ignore GCC 11+ warnings about TSan runtime support
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 11 has introduced a new warning option, -Wtsan [1], to warn about
unsupported operations in the TSan runtime. But KCSAN !=3D TSan runtime,
so none of the warnings apply.

[1] https://gcc.gnu.org/onlinedocs/gcc-11.1.0/gcc/Warning-Options.html

Ignore the warnings.

Currently the warning only fires in the test for __atomic_thread_fence():

kernel/kcsan/kcsan_test.c: In function =E2=80=98test_atomic_builtins=E2=80=
=99:
kernel/kcsan/kcsan_test.c:1234:17: warning: =E2=80=98atomic_thread_fence=E2=
=80=99 is not supported with =E2=80=98-fsanitize=3Dthread=E2=80=99 [-Wtsan]
 1234 |                 __atomic_thread_fence(__ATOMIC_SEQ_CST);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

which exists to ensure the KCSAN runtime keeps supporting the builtin
instrumentation.

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/Makefile.kcsan | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index 4c7f0d282e42..19f693b68a96 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -13,6 +13,12 @@ kcsan-cflags :=3D -fsanitize=3Dthread -fno-optimize-sibl=
ing-calls \
 	$(call cc-option,$(call cc-param,tsan-compound-read-before-write=3D1),$(c=
all cc-option,$(call cc-param,tsan-instrument-read-before-write=3D1))) \
 	$(call cc-param,tsan-distinguish-volatile=3D1)
=20
+ifdef CONFIG_CC_IS_GCC
+# GCC started warning about operations unsupported by the TSan runtime. Bu=
t
+# KCSAN !=3D TSan, so just ignore these warnings.
+kcsan-cflags +=3D -Wno-tsan
+endif
+
 ifndef CONFIG_KCSAN_WEAK_MEMORY
 kcsan-cflags +=3D $(call cc-option,$(call cc-param,tsan-instrument-func-en=
try-exit=3D0))
 endif
--=20
2.34.0.rc2.393.gf8c9666880-goog

