Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89A49EF20
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbiA1AIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbiA1AIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:08:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C81C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:08:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v13so7626241wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+UJbVBKe2v11VAhxonJJHgo2MJev+F3zVTIM6Z5XRw=;
        b=psUgohyl/doORdmZpKT9JvNyVNCMVTurVaepNc+M3Rb5SDgb0BnTDCUFFPigNzVotN
         92nmmigURubruSfN/txEaLTLYMmP/5gAmxnu7kb1g7vLPjK5teQgIgBvlOiM/EFXjXiK
         JMk+gbc2aq4sKB6TWO7NCf2PljfPtsC8ifxci2cEe0aCLzkzfFG2lor7yAIQE+nAe8d+
         X7nNyTrXo1V34XQBoyZGHwFTM4pwIccOOOrkW7hJHURe1br5atFZtCthXeYLP5oqLuO5
         wSutWX4u/k21K9QksqxirE/Tu0gGC+vdIiMToR7D++NkndSfeNiqCyT9e75LGM1WP4CL
         g89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+UJbVBKe2v11VAhxonJJHgo2MJev+F3zVTIM6Z5XRw=;
        b=FIioswbEhl3jUfphI/8dkYRpfJqD2x7Dh1jNS1XchdOXjpcJYNTXkQJ7qIvY3Z1aOO
         AYeY+6L4XIQA8Ni/4feoEcFYa1PnG76Y7qrorqL1pkScjatymLAphAtMRrKStnGtVGwJ
         kHfDhLOFNApLI0r6q90WGR/XTHrHp4rRce65q2RXoYW9+a/Orc0vN/sxy7kI5P9aOeU3
         CA+525VJaCWoUouNEF0WjZzE1QqYh0TPxuzIOen4GscCKd7aHAjNfad+5wrGF29B0roy
         /a5hPvG3lLK18ms537Svg/p2MbwvdkQ4vMTvQaKY9NWV9pVWbc8m32E68hAy12LiurFh
         gMmw==
X-Gm-Message-State: AOAM530Y1dITuwQL24C6dPieFw9BtTL8zi8q2UZOPvNLJkco3eLaA33v
        1pw5ieUuLfBIew8C+lZvnbOvCw==
X-Google-Smtp-Source: ABdhPJy3A9A4vHVzTqch7FBhXJ74y2DidYQOHSjMeuLljJ0EttxQrMYJx64VhClsBwmL/nuv77wyVg==
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr4686186wri.589.1643328479307;
        Thu, 27 Jan 2022 16:07:59 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id x4sm3478297wrp.13.2022.01.27.16.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:07:58 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>
Subject: [PATCH v2] x86/csum: Add KASAN/KCSAN instrumentation
Date:   Fri, 28 Jan 2022 01:07:52 +0100
Message-Id: <20220128000752.2322591-1-jannh@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the optimized X86 version of the copy-with-checksum helpers, use
instrument_*() before accessing buffers from assembly code so that KASAN
and KCSAN don't have blind spots there.

Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    v2: use instrument_copy_{from,to}_user instead of instrument_{read,writ=
e}
        where appropriate (dvyukov)

 arch/x86/lib/csum-partial_64.c  | 3 +++
 arch/x86/lib/csum-wrappers_64.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 1f8a8f895173..8b0c353cd212 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -8,6 +8,7 @@
=20=20
 #include <linux/compiler.h>
 #include <linux/export.h>
+#include <linux/instrumented.h>
 #include <asm/checksum.h>
 #include <asm/word-at-a-time.h>
=20
@@ -37,6 +38,8 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 	u64 temp64 =3D (__force u64)sum;
 	unsigned odd, result;
=20
+	instrument_read(buff, len);
+
 	odd =3D 1 & (unsigned long) buff;
 	if (unlikely(odd)) {
 		if (unlikely(len =3D=3D 0))
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_6=
4.c
index 189344924a2b..c44973b8f255 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -6,6 +6,8 @@
  */
 #include <asm/checksum.h>
 #include <linux/export.h>
+#include <linux/in6.h>
+#include <linux/instrumented.h>
 #include <linux/uaccess.h>
 #include <asm/smap.h>
=20
@@ -26,6 +28,7 @@ csum_and_copy_from_user(const void __user *src, void *dst=
, int len)
 	__wsum sum;
=20
 	might_sleep();
+	instrument_copy_from_user(dst, src, len);
 	if (!user_access_begin(src, len))
 		return 0;
 	sum =3D csum_partial_copy_generic((__force const void *)src, dst, len);
@@ -51,6 +54,7 @@ csum_and_copy_to_user(const void *src, void __user *dst, =
int len)
 	__wsum sum;
=20
 	might_sleep();
+	instrument_copy_to_user(dst, src, len);
 	if (!user_access_begin(dst, len))
 		return 0;
 	sum =3D csum_partial_copy_generic(src, (void __force *)dst, len);
@@ -71,6 +75,8 @@ EXPORT_SYMBOL(csum_and_copy_to_user);
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
+	instrument_write(dst, len);
+	instrument_read(src, len);
 	return csum_partial_copy_generic(src, dst, len);
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
@@ -81,6 +87,9 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 {
 	__u64 rest, sum64;
=20
+	instrument_read(saddr, sizeof(*saddr));
+	instrument_read(daddr, sizeof(*daddr));
+
 	rest =3D (__force __u64)htonl(len) + (__force __u64)htons(proto) +
 		(__force __u64)sum;
=20

base-commit: 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
--=20
2.35.0.rc0.227.g00780c9af4-goog

