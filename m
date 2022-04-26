Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF82510A82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354971AbiDZUfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354513AbiDZUfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:35:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4431A61E9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:32:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f4dee8688cso126518237b3.16
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZsCBuiiFgRZP4jhvDChuQicSvWa0udH/sRJiHNclKT4=;
        b=YHzUgr9QNc7oDN5KkGpaITjDoktFxpsf4LNMdcVtpPFSiZ1kR5IoBtXE/XY92k9t9T
         95VYIubjXmyZblFdrJAhW2MMy37VNzmyvZnc9wmsakyZJmXqDi8rB6XhcUSIwzfjchJC
         l9sy1K1FGT2luTvexMHuPDkejArUVYZW84GEE6MZGUYEXUPCXZ7+2fW+fYlTq9uOIUkz
         +lhMH3UOyj5f6NiVyT3UzgorhLTiTZLfygmSlAVB0bAg8preJ3FW9MSlqCjd1v0wKbzp
         HMcZXuhMkofdhk3JARWAupJW2lbSJfUbparW4zu76JIS1BFdxSyQCURJF5IHCb5NORG6
         Vl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZsCBuiiFgRZP4jhvDChuQicSvWa0udH/sRJiHNclKT4=;
        b=x5aohChK+qcKqCBbD3Oiw/x+OTqt6aW1e2Wl/52pM9/mrNE3BA2M2dUHOHmYa5V6zM
         azgnUYpYBWBcQafwZxz1OM/QSgv+kqGpQQgygtEltqIOggHWNcBfYirToSRteNpfoXK2
         ZEvdDYwCR1u5hb0VahIcwJDV812xe21kHQuHtRW+DVl7XlrjRhnm9Gghntwg42Wh08X4
         1tEKm06AHBHHa9PHR2ZXcZhMPKuOVAMPfENE3Psqn3bj4IQr2zCYsp8D/oThbqTUqvCQ
         9AuUSHJlX6N85R/G6XazKyoXs/ceQOUhAlU98FMnFuXqDd8xvM4miyXdkvQjyaGQYx5M
         CElQ==
X-Gm-Message-State: AOAM530Ykq9CU87lyHCoH3QFGy/iN+1tAUKf9xMXcyRGFjIERyLyrUWj
        2aT/r+XkU1z5/Bq4WYT9qzFRX0w=
X-Google-Smtp-Source: ABdhPJzh1YP7CmiwmN8+/yV7PpIBnE6Eb3WcbLq40RItiIfk+iQBhhV7y3oqof4jQQkJj88sSYXnl/Q=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:709f:5eff:336a:4109])
 (user=pcc job=sendgmr) by 2002:a05:6902:52:b0:645:bd1:970e with SMTP id
 m18-20020a056902005200b006450bd1970emr22523227ybh.413.1651005161361; Tue, 26
 Apr 2022 13:32:41 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:32:30 -0700
Message-Id: <20220426203231.2107365-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v4 1/2] printk: stop including cache.h from printk.h
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
 arch/arm64/include/asm/mte-kasan.h | 1 +
 arch/arm64/include/asm/percpu.h    | 1 +
 drivers/firmware/smccc/kvm_guest.c | 1 +
 include/linux/printk.h             | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)

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
 
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

