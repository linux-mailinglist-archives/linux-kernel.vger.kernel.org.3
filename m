Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E222A5A2AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiHZPQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244684AbiHZPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:14:13 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2166937FB8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:10:00 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id x9-20020a05640226c900b00447e004ea4cso1243407edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=+OT6SjVSfWjyqzxbCZyABchDUcmsVpvJACt5vGUex24=;
        b=Z6njr41sW+TrPWrMaWFwC05L0RlOcYNPG3bg02BhPFfdHpKhjWZb3JQSd3EE7bQR4t
         BLm0gQ80M2u3Pdlj1pDIh1/qXUSrg7ZtmpWtyd9GiSzXUcv17N5l1NutHYYducPw8Nm1
         53fip5LebyiAQRD1QGNbSqOqemN8I8dcjPld+gmWIt0k8q85y5Jr57b99LSEVn0lBt+H
         zdJQxrYdMQVOvNNpr1+RziHtXPGmKyGhGOD17LJ7bJ7AAVD99iIBY1+G52ypCLREDV+F
         yPwT4hR+BLBGY/xYmzyBjGu/5to6IUIp+jowlZqMWLLM1SmRm2HCrOTVeGnkhu8gk10k
         xggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=+OT6SjVSfWjyqzxbCZyABchDUcmsVpvJACt5vGUex24=;
        b=WRE9xKxaX18jEuJfG572iIvx2cAI1hsD1P4Kfw4J8VZt27hm2+b5ec7FKnJp/sVQrQ
         BcPR9iKWJ6Bbo1A7aMKnJ7aq6vkpPWfJurPn/mGoZ96C16ATLCLIChkcjgmGRr68rJhH
         rUPrcXaqITFK1AFKTucZHsnsQUiOxfaj1U9fSMkGh0qBEg2a3dIJE6yMzID7lp3S/Pc4
         aUDcRd4AsEkwZda54h7+wDxHWqW2mRF/gE7RPEnVOA5pWp2HiX6Yzo5VMr1FC++fL6Gg
         YZ9Durz6KlwWqTGE7abvunHqJ6+USDAMUav5sGvjV3asSKvAMCCDD/opV8zawxrdpF/M
         0srA==
X-Gm-Message-State: ACgBeo1bw0DuMkjwMpIF8T/C7EfBzpcidA35QuR/s65RUhZn+XC27NIa
        k7M6/blHNYK9ygyD1LFKTZ5Qi2brLTE=
X-Google-Smtp-Source: AA6agR4t0eef92ReeAZR+Mrv7r8ag8b4BdV1NIADifSFVxHgYfyFuws8EoWxRalcgwj85FhAMYNvlh2MVzI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a05:6402:43c6:b0:43d:79a6:4e32 with SMTP id
 p6-20020a05640243c600b0043d79a64e32mr6871771edc.281.1661526590665; Fri, 26
 Aug 2022 08:09:50 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:58 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-36-glider@google.com>
Subject: [PATCH v5 35/44] x86: kmsan: handle open-coded assembly in lib/iomem.c
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN cannot intercept memory accesses within asm() statements.
That's why we add kmsan_unpoison_memory() and kmsan_check_memory() to
hint it how to handle memory copied from/to I/O memory.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Icb16bf17269087e475debf07a7fe7d4bebc3df23
---
 arch/x86/lib/iomem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index 3e2f33fc33de2..e0411a3774d49 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -1,6 +1,7 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/kmsan-checks.h>
 
 #define movs(type,to,from) \
 	asm volatile("movs" type:"=&D" (to), "=&S" (from):"0" (to), "1" (from):"memory")
@@ -37,6 +38,8 @@ static void string_memcpy_fromio(void *to, const volatile void __iomem *from, si
 		n-=2;
 	}
 	rep_movs(to, (const void *)from, n);
+	/* KMSAN must treat values read from devices as initialized. */
+	kmsan_unpoison_memory(to, n);
 }
 
 static void string_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
@@ -44,6 +47,8 @@ static void string_memcpy_toio(volatile void __iomem *to, const void *from, size
 	if (unlikely(!n))
 		return;
 
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(from, n);
 	/* Align any unaligned destination IO */
 	if (unlikely(1 & (unsigned long)to)) {
 		movs("b", to, from);
-- 
2.37.2.672.g94769d06f0-goog

