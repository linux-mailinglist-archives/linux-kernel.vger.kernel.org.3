Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB628563581
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiGAO3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiGAO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:28:36 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E785B64D45
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:25:02 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id hs18-20020a1709073e9200b0072a3e7eb0beso844375ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7Mhpta8bleV/UMALfZOJOInTXQD6eorZ40ixMEZLH18=;
        b=SK4zuM/LqN9V22hVvhABvQyziEAxlHrFJzT62CJ+8Gr5z1csKhH0NIvPZy7HXwJZFS
         0o2Dz9vScER5v/m3+Ov0b57zCiiCbrCApAZdn0z0ihUpL5uyP1/bXdMsnOidMKiSUJDa
         BkpEhnOP5g9I2ipIkJ/00hmAFD/og1SK1bdSIzNn7w1oXdItFTnvjA3O0QGS+joj1qPX
         vu0mr88M+r8S11fh0jNIUSEtNfYY0tXFLftByqdopzCcL3vRLSr276xum9GnJaDchFRq
         uhPrpu558FoA7vusBo7CKw0yXyOXaTlW7kFEpBeSn/VATqyQvBlleRzR7PZQtdIROe8G
         gmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7Mhpta8bleV/UMALfZOJOInTXQD6eorZ40ixMEZLH18=;
        b=jBSsm9EUBWsr57z3MKb/PjsdxXWiZMzMNsTYl1A1rYpkSu67sELgjHAaDDSw26t/+7
         kcM480vGQ19h9Jso5ghuY7Q2cwE6FL6E3hI+n8dBEbokWnK5jhcbQJHyHN+Rx0YrK/ky
         EiRHUPIhl3+uCStSJr2qPdtG9d/iGEJXidEExSs3JgPbWD3qqwzG0ka/v7E8DtiIGUlD
         2/CxVnuAvmGnBq1dSfEnA+DH6zlV5naNzAE9aRn++TzP33EISN72FdmuFYn9PgI/mu8F
         +FU8Ipu6+2Fl8V8T/8HrHaWwBC7CHoHucPD+xmo1gfy0T0wSV6EKZMRcNZ6Gw+Ea6O1D
         HsJw==
X-Gm-Message-State: AJIora80WaCXr+kr+OPQ/B8UGzcz8SnZaq7rhswCf0Xt5aHKbpFabKK7
        UUx6SOWWtTyMJDhsxd7CK4HewIyQXLw=
X-Google-Smtp-Source: AGRyM1ukHF/75hMCkE1ceqIKqAwme//w8kYLgX2Q1lXtK73q2uRxhmeeO4GeXUnmM9oAotsl2fJIw5hKglI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6402:f29:b0:435:c108:58f2 with SMTP id
 i41-20020a0564020f2900b00435c10858f2mr19006559eda.401.1656685502496; Fri, 01
 Jul 2022 07:25:02 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:23:03 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-39-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 38/45] x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on
 x86, enable it for KASAN/KMSAN
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to allow memory tools like KASAN and KMSAN see the
memory accesses from the checksum code. Without CONFIG_GENERIC_CSUM the
tools can't see memory accesses originating from handwritten assembly
code.
For KASAN it's a question of detecting more bugs, for KMSAN using the C
implementation also helps avoid false positives originating from
seemingly uninitialized checksum values.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

Link: https://linux-review.googlesource.com/id/I3e95247be55b1112af59dbba07e8cbf34e50a581
---
 arch/x86/Kconfig                |  4 ++++
 arch/x86/include/asm/checksum.h | 16 ++++++++++------
 arch/x86/lib/Makefile           |  2 ++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be0b95e51df66..4a5d0a0f54dea 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -324,6 +324,10 @@ config GENERIC_ISA_DMA
 	def_bool y
 	depends on ISA_DMA_API
 
+config GENERIC_CSUM
+	bool
+	default y if KMSAN || KASAN
+
 config GENERIC_BUG
 	def_bool y
 	depends on BUG
diff --git a/arch/x86/include/asm/checksum.h b/arch/x86/include/asm/checksum.h
index bca625a60186c..6df6ece8a28ec 100644
--- a/arch/x86/include/asm/checksum.h
+++ b/arch/x86/include/asm/checksum.h
@@ -1,9 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER 1
-#define HAVE_CSUM_COPY_USER
-#define _HAVE_ARCH_CSUM_AND_COPY
-#ifdef CONFIG_X86_32
-# include <asm/checksum_32.h>
+#ifdef CONFIG_GENERIC_CSUM
+# include <asm-generic/checksum.h>
 #else
-# include <asm/checksum_64.h>
+# define  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER 1
+# define HAVE_CSUM_COPY_USER
+# define _HAVE_ARCH_CSUM_AND_COPY
+# ifdef CONFIG_X86_32
+#  include <asm/checksum_32.h>
+# else
+#  include <asm/checksum_64.h>
+# endif
 #endif
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index f76747862bd2e..7ba5f61d72735 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -65,7 +65,9 @@ ifneq ($(CONFIG_X86_CMPXCHG64),y)
 endif
 else
         obj-y += iomap_copy_64.o
+ifneq ($(CONFIG_GENERIC_CSUM),y)
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
+endif
         lib-y += clear_page_64.o copy_page_64.o
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o
-- 
2.37.0.rc0.161.g10f37bed90-goog

