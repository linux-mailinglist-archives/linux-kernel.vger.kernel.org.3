Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97944576B0B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 02:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiGPAQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 20:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiGPAQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 20:16:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742298AEF9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 17:16:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m123-20020a253f81000000b0066ff6484995so1663757yba.22
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=K1u/08k1kHvQ8RIYk0HRaqbL2NYdWoYTw1DMyhtc5Cw=;
        b=ho4U6QwUwXhpx81KMHiBsPWFgJd29KTWTUHZtpCpwKlYMTwBhoeXodak0kOIHbZ2ir
         BpGSx7gVS1PPG+NQ2aAFqq0AgMA50X8mXFaW1ql992pf9L3w8vLyF+bdZIWnGJW/YoLX
         AbeXy+d/mGyc7jUiCNNruhVn6Jf2pqOxbsHLu73faBNIGntKz8usvZy4DSJg/H3MKTUn
         JhBVt3Rq48h/YgiVHWle7KeEFSaA643KcJxCmU6VsNG8YnWxYm/mkeKg77U6RANWhbUj
         /xj0aGtFI6Y3ga4QKFY/czxZXcottGTH5osym5cpiBTDhHQmr1mlaIAwSvBJTThmUSRB
         /LNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=K1u/08k1kHvQ8RIYk0HRaqbL2NYdWoYTw1DMyhtc5Cw=;
        b=YKeETCW1306p9x35dzz8viiSUUos/K0DADzcpeFZy/LSLdN7sv4323VMIs1VPVZ1/u
         NeRRUG85JgXJxgMPlGjrdqsbfVAMRUcJ+NBjVjsiEmMo8QuGrEvfO+oW/dW5BDMYVeQ6
         FC1LKhNcc1fb2oTj0UHhorprtpqXBMTRhDelfuyJ6wHqYqigdCvC3ULuFI1FI9cj9LFR
         WU1L/vqfjXs5fbFWxIEcSx68JpE3zai6LhYV1bKbPmzcyqY2l6vvt+JXwgGTLJ57QFrm
         WF6Ko8OnlY7uSBB43i/1f3UjC6T+SpryrYZqKbfV0Mln8tWoAGv6GYoJ3A122cJCC9Kh
         SzMg==
X-Gm-Message-State: AJIora8et2hc1g1Vz4zialYblvYdc++cYP5RL7sSeJpyGsPwzrlgVhlY
        zp9nDm3J9eqpaYec3eUXt2/bBCdlPEEkIaZoEGE=
X-Google-Smtp-Source: AGRyM1sIdHPQVqAztkcQa3o63z7bs2yVKH4jL3uicRwyLHqvXlO1IHuc1+cZsIt5Hj1UM8MMx63bfZSooMS6oiNnaDU=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:a3e6:c68c:2c0c:ebf6])
 (user=ndesaulniers job=sendgmr) by 2002:a5b:ecc:0:b0:66e:da0a:7736 with SMTP
 id a12-20020a5b0ecc000000b0066eda0a7736mr15615949ybs.587.1657930585734; Fri,
 15 Jul 2022 17:16:25 -0700 (PDT)
Date:   Fri, 15 Jul 2022 17:16:07 -0700
Message-Id: <20220716001616.4052225-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1657930566; l=1743;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=QIu9o/mxb9btODsh6DZRIF2F1BpZvwkAJQhLHDs2c4Y=;
 b=QdWV52FzNZq1EiGz28q4F2oq+2dQcFXBgbMNZYK/TVuExNteLEHksMhp5aGDF1c1JydpYzq8AL8R
 O+7hwHWKAJsuMWHDosqLDtYAeYA9XElDWzKsyB0obqe7JCPyMRWB
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH] arm: lib: implement aeabi_uldivmod via div64_u64_rem
From:   Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Ard Biesheuval <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Gary Guo <gary@garyguo.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compilers frequently need to defer 64b division to a libcall with this
symbol name. It essentially is div64_u64_rem, just with a different
signature. Kernel developers know to call div64_u64_rem, but compilers
don't.

Link: https://lore.kernel.org/lkml/20220524004156.0000790e@garyguo.net/
Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/lib/Makefile         |  1 +
 arch/arm/lib/aeabi_uldivmod.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 arch/arm/lib/aeabi_uldivmod.c

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 6d2ba454f25b..3fa273219312 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -29,6 +29,7 @@ endif
 obj-$(CONFIG_UACCESS_WITH_MEMCPY) += uaccess_with_memcpy.o
 
 lib-$(CONFIG_MMU) += $(mmu-y)
+lib-$(CONFIG_AEABI) += aeabi_uldivmod.o
 
 ifeq ($(CONFIG_CPU_32v3),y)
   lib-y	+= io-readsw-armv3.o io-writesw-armv3.o
diff --git a/arch/arm/lib/aeabi_uldivmod.c b/arch/arm/lib/aeabi_uldivmod.c
new file mode 100644
index 000000000000..310427893195
--- /dev/null
+++ b/arch/arm/lib/aeabi_uldivmod.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Unsigned 64b division with remainder, as is typically provided by libgcc or
+ * compiler-rt.
+ *
+ * Copyright (C) 2023 Google, LLC.
+ *
+ * Author: Nick Desaulniers <ndesaulniers@google.com>
+ */
+
+#include <linux/math64.h>
+
+struct result {
+	u64 quot, rem;
+};
+
+struct result __aeabi_uldivmod(u64 numerator, u64 denominator)
+{
+	struct result res;
+
+	res.quot = div64_u64_rem(numerator, denominator, &res.rem);
+	return res;
+}
-- 
2.37.0.170.g444d1eabd0-goog

