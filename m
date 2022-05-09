Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163A35207CA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiEIWiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiEIWgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:36:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6106B2B9C91
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:32:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d22so15153236plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=ZW4Wh2F92AaGgkTq3RYNioOG15W5RvqR7U43OAjNTGE=;
        b=OJ8/z1H0yxOfjvNIz5GyJj5zfB3yzETOSWZgiZ4JDbCXZ4D/Fw0kDuTE+TVB7WnjKz
         f10yDnI2QhASS2wNA9HaJ3RgUMeT75ziZXqgEzTmHHJtxq59d2fXeEjM5wOAxZW2NzD1
         vsqWI3UMY+G9WNlAQbNLY9dcfzxfr+bKESuRkrl9KWNGc0FcGikBLc/QIWcVyMnbd54f
         g3kXLZhpt3B23HL6lhDUviKv8fCVonj8AkNF1BOtU4dS23DtdFTjMLYo7kVdPu9uaMRF
         r3zvAnCirXnIri808iEE9IDgcsFN4ys53jS+uv4sZq5oYQt047znsym3BXBmMlanOmDg
         Sl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=ZW4Wh2F92AaGgkTq3RYNioOG15W5RvqR7U43OAjNTGE=;
        b=S/Nf4hcUh++psxvJU8WHbCh7ElAQyxOIYxKAiHGyjqPJa0ZSYoiI1vA287fK3Li9g4
         2t4IX/LSbMb9Fef+2xQM9d1c9aNBbLN6qGrSalSHmeqMIi0zrD741m81e7EHr1zdSg5b
         gvSSRT4nb+jdEcx3yYAWEp5xDbb7+4DJ1fa9HMsoUHY4ua6pGcYCJ+ep7KdD3ORmAFf1
         O+DTDNDx/IFAgIMGQ5dWVPWku13BgXzw2FSsg6TwuneP3cUbVlcjtPWLz0RVYIccdjQT
         1S5FtmM96GGr1Zl45wMSxTO7XJFeWOH1MmU5lXXL4HcuyeHNc3HMVS2pcZLfifuR7zwU
         AKkw==
X-Gm-Message-State: AOAM531WNdUp1Dh2VTgi1WyeNaWptQbiFp3he0mP5RNpFdbhhF7/fhbq
        /GF0riFOTdpH74pcklbPd8UVLQ==
X-Google-Smtp-Source: ABdhPJx0hcRTNWyyUDxvbLajs6wyBIGgRAtfmL2Lsz3K2ittGTQcIfLVbn7WWX9D3t+/vP39Ej+XHg==
X-Received: by 2002:a17:902:bf09:b0:153:99a6:55b8 with SMTP id bi9-20020a170902bf0900b0015399a655b8mr17645821plb.142.1652135544838;
        Mon, 09 May 2022 15:32:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0015eb200cc00sm378567plg.138.2022.05.09.15.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:32:24 -0700 (PDT)
Subject: [PATCH v5 1/7] asm-generic: ticket-lock: New generic ticket-based spinlock
Date:   Mon,  9 May 2022 15:29:50 -0700
Message-Id: <20220509222956.2886-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509222956.2886-1-palmer@rivosinc.com>
References: <20220509222956.2886-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, macro@orcam.me.uk,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

This is a simple, fair spinlock.  Specifically it doesn't have all the
subtle memory model dependencies that qspinlock has, which makes it more
suitable for simple systems as it is more likely to be correct.  It is
implemented entirely in terms of standard atomics and thus works fine
without any arch-specific code.

This replaces the existing asm-generic/spinlock.h, which just errored
out on SMP systems.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/asm-generic/spinlock.h       | 94 +++++++++++++++++++++++++---
 include/asm-generic/spinlock_types.h | 17 +++++
 2 files changed, 104 insertions(+), 7 deletions(-)
 create mode 100644 include/asm-generic/spinlock_types.h

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index adaf6acab172..fdfebcb050f4 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -1,12 +1,92 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_GENERIC_SPINLOCK_H
-#define __ASM_GENERIC_SPINLOCK_H
+
 /*
- * You need to implement asm/spinlock.h for SMP support. The generic
- * version does not handle SMP.
+ * 'Generic' ticket-lock implementation.
+ *
+ * It relies on atomic_fetch_add() having well defined forward progress
+ * guarantees under contention. If your architecture cannot provide this, stick
+ * to a test-and-set lock.
+ *
+ * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
+ * sub-word of the value. This is generally true for anything LL/SC although
+ * you'd be hard pressed to find anything useful in architecture specifications
+ * about this. If your architecture cannot do this you might be better off with
+ * a test-and-set.
+ *
+ * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
+ * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
+ * a full fence after the spin to upgrade the otherwise-RCpc
+ * atomic_cond_read_acquire().
+ *
+ * The implementation uses smp_cond_load_acquire() to spin, so if the
+ * architecture has WFE like instructions to sleep instead of poll for word
+ * modifications be sure to implement that (see ARM64 for example).
+ *
  */
-#ifdef CONFIG_SMP
-#error need an architecture specific asm/spinlock.h
-#endif
+
+#ifndef __ASM_GENERIC_SPINLOCK_H
+#define __ASM_GENERIC_SPINLOCK_H
+
+#include <linux/atomic.h>
+#include <asm-generic/spinlock_types.h>
+
+static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	u32 val = atomic_fetch_add(1<<16, lock);
+	u16 ticket = val >> 16;
+
+	if (ticket == (u16)val)
+		return;
+
+	/*
+	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
+	 * custom cond_read_rcsc() here we just emit a full fence.  We only
+	 * need the prior reads before subsequent writes ordering from
+	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
+	 * have no outstanding writes due to the atomic_fetch_add() the extra
+	 * orderings are free.
+	 */
+	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
+	smp_mb();
+}
+
+static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
+{
+	u32 old = atomic_read(lock);
+
+	if ((old >> 16) != (old & 0xffff))
+		return false;
+
+	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
+}
+
+static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
+	u32 val = atomic_read(lock);
+
+	smp_store_release(ptr, (u16)val + 1);
+}
+
+static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(lock);
+
+	return ((val >> 16) != (val & 0xffff));
+}
+
+static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(lock);
+
+	return (s16)((val >> 16) - (val & 0xffff)) > 1;
+}
+
+static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	return !arch_spin_is_locked(&lock);
+}
+
+#include <asm/qrwlock.h>
 
 #endif /* __ASM_GENERIC_SPINLOCK_H */
diff --git a/include/asm-generic/spinlock_types.h b/include/asm-generic/spinlock_types.h
new file mode 100644
index 000000000000..8962bb730945
--- /dev/null
+++ b/include/asm-generic/spinlock_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_GENERIC_SPINLOCK_TYPES_H
+#define __ASM_GENERIC_SPINLOCK_TYPES_H
+
+#include <linux/types.h>
+typedef atomic_t arch_spinlock_t;
+
+/*
+ * qrwlock_types depends on arch_spinlock_t, so we must typedef that before the
+ * include.
+ */
+#include <asm/qrwlock_types.h>
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	ATOMIC_INIT(0)
+
+#endif /* __ASM_GENERIC_SPINLOCK_TYPES_H */
-- 
2.34.1

