Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE7B4DBB0F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348301AbiCPX35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbiCPX3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:29:49 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9FE167D3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:28:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q19so1311674pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=TemgJXj/dxR4o9xjuRPFVAtvCpC+RuCkyAl1o75jaTw=;
        b=5NAASYUylgaEPqqdOEpfJYNUGMgV0gFaeMRax5C5dSSZLOGAdqEJZnhq0wtD7zPoW0
         G5ob4+N2yFpwbpch0DWhTknq6SOGVQuAlyx5O3Q4z+CabPYf0Q0nUxJYIRUm+1UXldia
         CUfn33UFTj/UQ6niZ6ytLeUqcODuQ8vUjiiE5/y4Cga4QKby77CDm6r7N0bPNRi39KC4
         O/zvHvMm0khtUBVhRQ1vvm59igRk3I3+zGiCD9QZkEZ4zSYXLICNZRMaGnxXlOOI5pc8
         96R6MSsMUafEA9jSOCcTsTp6f+fYDXiBsUqlxz1cBR4CM7sz772W9JvY9llYBqeaxTjL
         2xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=TemgJXj/dxR4o9xjuRPFVAtvCpC+RuCkyAl1o75jaTw=;
        b=Yj3W0MsKldy7WJXG/g5Bqf6h1B8I9RPtZmYBZEol1pn3HfsnK3Dk7HizS9cT5foSNM
         ZPDOiNI75OO7mhJ94q4StlW7EGCeTbsxAcQLcZPdErmR/BDLppaAM/1aOoiXKNVjz7tw
         jhebh8wibsEWzterezcG9I131yw1GcMitmQfJp0Iy+LOibMvoAZURSVPu/wMLlbTP8AL
         dO13P4GS5D85xmtEs+GQS9Y2KVLrNWQq1KD8oU4Z1Df3eX3RwJ0RCu1TdyzfcSACPjv4
         99w8Vgl/+/cKCCRtUsThtTBNHKlSne68VnQszVoNPErUMbZlz2uM7fsQj994VMfF5lo1
         l/Vg==
X-Gm-Message-State: AOAM531+LtMFmemuzGEiPZFyUxFWK7uIJEsfJMgiEAumBxoO1EXVUcp+
        Q9E2ZchpvUHrULUVlGs0mLZSL30oOfcG5w==
X-Google-Smtp-Source: ABdhPJzu2zL3dDL4hiAgSK4z9Dcw0idEICTak8foXBS3lSnxmO9pbBmuyGxzNgKWSyVr5slYVp3eQg==
X-Received: by 2002:a05:6a00:1a89:b0:4f7:b90b:17ee with SMTP id e9-20020a056a001a8900b004f7b90b17eemr2233942pfv.46.1647473308139;
        Wed, 16 Mar 2022 16:28:28 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00245000b004f7728a4346sm4436763pfj.79.2022.03.16.16.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 16:28:27 -0700 (PDT)
Subject: [PATCH 3/5] openrisc: Move to ticket-spinlock
Date:   Wed, 16 Mar 2022 16:25:58 -0700
Message-Id: <20220316232600.20419-4-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220316232600.20419-1-palmer@rivosinc.com>
References: <20220316232600.20419-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, mingo@redhat.com, Will Deacon <will@kernel.org>,
        longman@redhat.com, boqun.feng@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org, peterz@infradead.org
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

We have no indications that openrisc meets the qspinlock requirements,
so move to ticket-spinlock as that is more likey to be correct.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

I have specifically not included Peter's SOB on this, as he sent his
original patch
<https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
without one.
---
 arch/openrisc/Kconfig                      | 1 -
 arch/openrisc/include/asm/Kbuild           | 5 ++---
 arch/openrisc/include/asm/spinlock.h       | 3 +--
 arch/openrisc/include/asm/spinlock_types.h | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index f724b3f1aeed..f5fa226362f6 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -30,7 +30,6 @@ config OPENRISC
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
-	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index ca5987e11053..cb260e7d73db 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
-generic-y += qspinlock_types.h
-generic-y += qspinlock.h
+generic-y += ticket-lock.h
+generic-y += ticket-lock-types.h
 generic-y += qrwlock_types.h
 generic-y += qrwlock.h
 generic-y += user.h
diff --git a/arch/openrisc/include/asm/spinlock.h b/arch/openrisc/include/asm/spinlock.h
index 264944a71535..40e4c9fdc349 100644
--- a/arch/openrisc/include/asm/spinlock.h
+++ b/arch/openrisc/include/asm/spinlock.h
@@ -15,8 +15,7 @@
 #ifndef __ASM_OPENRISC_SPINLOCK_H
 #define __ASM_OPENRISC_SPINLOCK_H
 
-#include <asm/qspinlock.h>
-
+#include <asm/ticket-lock.h>
 #include <asm/qrwlock.h>
 
 #define arch_spin_relax(lock)	cpu_relax()
diff --git a/arch/openrisc/include/asm/spinlock_types.h b/arch/openrisc/include/asm/spinlock_types.h
index 7c6fb1208c88..58ea31fa65ce 100644
--- a/arch/openrisc/include/asm/spinlock_types.h
+++ b/arch/openrisc/include/asm/spinlock_types.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_OPENRISC_SPINLOCK_TYPES_H
 #define _ASM_OPENRISC_SPINLOCK_TYPES_H
 
-#include <asm/qspinlock_types.h>
+#include <asm/ticket-lock-types.h>
 #include <asm/qrwlock_types.h>
 
 #endif /* _ASM_OPENRISC_SPINLOCK_TYPES_H */
-- 
2.34.1

