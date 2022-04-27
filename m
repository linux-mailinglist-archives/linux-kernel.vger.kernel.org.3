Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A05512332
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiD0UBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiD0UBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:01:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F9B81FDF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:58:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f4e28ae604so26221857b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XcyimqZCgzNKPz0n6jeYchV2A0CiM03dMGsti55IHHA=;
        b=s02dGKNs5N9wITi7rLK6r0wHnOi9sVCax7ULGA2NwdsiQb4JBG5S6sUifvHUzlsP+s
         JQMkwbvLTHNVpZ5d2M2T18eXehKh37hy4yu+Wl46oiRt94FCdObnc9xrEiNwDX3hFqci
         UJQsrBd44/V04s0nxcZ+xzDoda9xt5xeFeWvTlEbhfSaAnw2q65HrpmVhVLTvrHZFJVD
         xwLy8iQmkExeBpM8uvvPoU8lhjeki5LzjnerCCpyBlB+1ebdiwXi8/IzIZhdXUUEhWwK
         0Jfz2DFR5rqTo7C0rTLwdcm9gQ4z9DokGrRg2z2d6XeMpX6E2zoI4WoXs8uPvTgEBll4
         TLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XcyimqZCgzNKPz0n6jeYchV2A0CiM03dMGsti55IHHA=;
        b=OPfK/zX5MTiDBkTL+kCslf8OBR2m8eRAr6IKaM7TCt/38W5GCLA80UimMBa1pOaubO
         p7IXhLQFJF5GMJi9Lf7yRGhvjU17PdlTKWCmRZUWCNi7+XZtsE2YESarqR57gSFWBv6+
         ynqRyQL6DkvPEIBDiyI7pN5VwuLeRWpZn1y+vZGZUBhVsp7zgHHygsqHSYBPAVE9J2Ne
         fn9rjO03e0YIGpKuk3iBeR1WhHq1S5tVdt65x8+S/LvhL/XzdBoEr5lxVuLCqTsy78Z7
         zJlhZWT7CRBhMcXZUmd90FP4T/TelgLXL70YZJdB2hSUgkh/SZqQCzp+b33OvORJ+a93
         xQzQ==
X-Gm-Message-State: AOAM5327HXmqCJ8lKNpUYO4ZtrXxFNzICWe5CAc5TA2S9NFjViXdnIkz
        YmLeyHBcO8ctKVNzMkwyUMB+yp0=
X-Google-Smtp-Source: ABdhPJwTnOgzyHrJ8E1iFAiir6PeHMoiemkC6w/nZnaRnH+NDqYyIBLFMruNHYrJdqIATkyGMvDpSWU=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:7bf6:862b:86da:9ce1])
 (user=pcc job=sendgmr) by 2002:a81:38d4:0:b0:2ea:ad04:a284 with SMTP id
 f203-20020a8138d4000000b002eaad04a284mr29122079ywa.139.1651089504681; Wed, 27
 Apr 2022 12:58:24 -0700 (PDT)
Date:   Wed, 27 Apr 2022 12:58:19 -0700
Message-Id: <20220427195820.1716975-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v5 1/2] printk: stop including cache.h from printk.h
From:   Peter Collingbourne <pcc@google.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vbabka@suse.cz, penberg@kernel.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, rientjes@google.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An inclusion of cache.h in printk.h was added in 2014 in
commit c28aa1f0a847 ("printk/cache: mark printk_once test variable
__read_mostly") in order to bring in the definition of __read_mostly. The
usage of __read_mostly was later removed in commit 3ec25826ae33 ("printk:
Tie printk_once / printk_deferred_once into .data.once for reset")
which made the inclusion of cache.h unnecessary, so remove it.

We have a small amount of code that depended on the inclusion of cache.h
from printk.h; fix that code to include the appropriate header.

This fixes a circular inclusion on arm64 (linux/printk.h -> linux/cache.h
-> asm/cache.h -> linux/kasan-enabled.h -> linux/static_key.h ->
linux/jump_label.h -> linux/bug.h -> asm/bug.h -> linux/printk.h) that
would otherwise be introduced by the next patch.

Build tested using {allyesconfig,defconfig} x {arm64,x86_64}.

Link: https://linux-review.googlesource.com/id/I8fd51f72c9ef1f2d6afd3b2cbc875aa4792c1fba
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
v5:
- fixes for arm randconfig and (tentatively) csky

 arch/arm64/include/asm/mte-kasan.h | 1 +
 arch/arm64/include/asm/percpu.h    | 1 +
 arch/csky/include/asm/processor.h  | 2 +-
 drivers/firmware/smccc/kvm_guest.c | 1 +
 include/linux/printk.h             | 1 -
 kernel/bpf/bpf_lru_list.h          | 1 +
 6 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index a857bcacf0fe..9f79425fc65a 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -6,6 +6,7 @@
 #define __ASM_MTE_KASAN_H
 
 #include <asm/compiler.h>
+#include <asm/cputype.h>
 #include <asm/mte-def.h>
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 8f1661603b78..b9ba19dbdb69 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -10,6 +10,7 @@
 #include <asm/alternative.h>
 #include <asm/cmpxchg.h>
 #include <asm/stack_pointer.h>
+#include <asm/sysreg.h>
 
 static inline void set_my_cpu_offset(unsigned long off)
 {
diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 688c7548b559..9638206bc44f 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -4,9 +4,9 @@
 #define __ASM_CSKY_PROCESSOR_H
 
 #include <linux/bitops.h>
+#include <linux/cache.h>
 #include <asm/ptrace.h>
 #include <asm/current.h>
-#include <asm/cache.h>
 #include <abi/reg_ops.h>
 #include <abi/regdef.h>
 #include <abi/switch_context.h>
diff --git a/drivers/firmware/smccc/kvm_guest.c b/drivers/firmware/smccc/kvm_guest.c
index 2d3e866decaa..89a68e7eeaa6 100644
--- a/drivers/firmware/smccc/kvm_guest.c
+++ b/drivers/firmware/smccc/kvm_guest.c
@@ -4,6 +4,7 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/bitmap.h>
+#include <linux/cache.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 1522df223c0f..8e8d74edf121 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/kern_levels.h>
 #include <linux/linkage.h>
-#include <linux/cache.h>
 #include <linux/ratelimit_types.h>
 #include <linux/once_lite.h>
 
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index 6b12f06ee18c..4ea227c9c1ad 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -4,6 +4,7 @@
 #ifndef __BPF_LRU_LIST_H_
 #define __BPF_LRU_LIST_H_
 
+#include <linux/cache.h>
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
 
-- 
2.36.0.464.gb9c8b46e94-goog

