Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DBC5033E9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356451AbiDOXWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 19:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiDOXV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 19:21:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CF25F5A;
        Fri, 15 Apr 2022 16:19:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k23so17558516ejd.3;
        Fri, 15 Apr 2022 16:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VQ4t+4unN4Bi2tgZL0pBgqD4ZstJy3iXF/YNfaCg2WI=;
        b=hXNYinU44+STlYg31sonOjoHMIG2/wUcTlJCQDtleDGusHuVRKcs/INWVreUslUo1l
         gLR7T+I4CLzdoJpNsHs2NhywG+aqNX0KkKJHsxi0WVW9yOqqhOHNRCg/9WeNVBgB6nnB
         rC5nT+erQLneJZcR5bO+07dRyQukO4nzz8C/pGsnyTfdlNWRcmITz8cTpRsK/wHA+EGu
         loxONqNK5/KMSNkJnXNgmNolf15H0gejDzdp7bE5RKZaanzNZGLnKPXZjjjgoKjLVmfz
         XAa/XyVuYABi5QVtSFuWop5XieKc6l8C6aDY1LoDXomw46B48iF7URdk+n/oTvc8u/mJ
         qjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQ4t+4unN4Bi2tgZL0pBgqD4ZstJy3iXF/YNfaCg2WI=;
        b=17YC/9Ghn0BcB90P+3P8zyXXSk97d3VVC7pF+BjwFoEJMiKA712aX678uDexRUujyw
         Webcp2ygxZUZ0U71xsDxS1wAiD5JPKZk2z7pghARkKsK62dNwHcAsyP4kHeW06NKy8oi
         JrQz/bYrriSYKpNY5tqB8NWeVNIGqES3WrPFj43PXyw7Xd21Qe1hb1svyTnogqo19eMJ
         Rnqqj0USw/VYFaAhlhfIKC0pRabk4d1nTB3wZUJyzHCB8Xt+9g3P7FnTvMzlx+fCz3zh
         uaZa7uHNtWNCG32z4FwVlw502q58X9bF7QnYnV963GxIaX+uZLZ6O9sPHiBz4o5RKInb
         AZCg==
X-Gm-Message-State: AOAM532Fao+MA0jnMVYzAk1EQpDNKnT/z6Rx8TDyx6U7mJj4lhn7x3Gr
        hnmrvZDznkpAxYvxHhKkzwE=
X-Google-Smtp-Source: ABdhPJw/WuceJCnteKdVgPQLnCKMC/EWqVEUp9aKvRK5D4e9sIzp2RQIusc+XfezlPRsPZzjS2LC1A==
X-Received: by 2002:a17:906:7952:b0:6da:94c9:cccb with SMTP id l18-20020a170906795200b006da94c9cccbmr906202ejo.469.1650064766635;
        Fri, 15 Apr 2022 16:19:26 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id o15-20020a50fd8f000000b0041f95b8a90dsm3203394edt.69.2022.04.15.16.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 16:19:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        outreachy@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 1/2] Documentation/vm: Extend "Temporary Virtual Mappings" section
Date:   Sat, 16 Apr 2022 01:19:16 +0200
Message-Id: <20220415231917.25962-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220415231917.25962-1-fmdefrancesco@gmail.com>
References: <20220415231917.25962-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend and rework the "Temporary Virtual Mappings" section of the highmem.rst
documentation.

Do a partial rework of the paragraph related to kmap() and add a new paragraph
in order to document the set of kmap_local_*() functions. Re-order paragraphs
in decreasing order of preference of usage.

Despite the local kmaps were introduced by Thomas Gleixner in October 2020,
documentation was still missing information about them. These additions rely
largely on Gleixner's patches, Jonathan Corbet's LWN articles, comments by
Ira Weiny and Matthew Wilcox, and in-code comments from
./include/linux/highmem.h.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 67 ++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index 0f69a9fec34d..12dcfbee094d 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -52,24 +52,69 @@ Temporary Virtual Mappings
 
 The kernel contains several ways of creating temporary mappings:
 
-* vmap().  This can be used to make a long duration mapping of multiple
-  physical pages into a contiguous virtual space.  It needs global
-  synchronization to unmap.
-
-* kmap().  This permits a short duration mapping of a single page.  It needs
-  global synchronization, but is amortized somewhat.  It is also prone to
-  deadlocks when using in a nested fashion, and so it is not recommended for
-  new code.
+* kmap_local_*().  These provide a set of functions that are used to require
+  short term mappings. They can be invoked from any context (including
+  interrupts) but the mappings can only be used in the context which acquired
+  it.
+
+  These mappings are per thread, CPU local (i.e., migration from one CPU to
+  another is disabled - this is why they are called "local"), but they don't
+  disable preemption. It's valid to take pagefaults in a local kmap region,
+  unless the context in which the local mapping is acquired does not allow
+  it for other reasons.
+
+  If a task holding local kmaps is preempted, the maps are removed on context
+  switch and restored when the task comes back on the CPU. As the maps are
+  strictly CPU local, it is guaranteed that the task stays on the CPU and
+  that the CPU cannot be unplugged until the local kmaps are released.
+
+  Nesting kmap_local.*() and kmap_atomic.*() mappings is allowed to a certain
+  extent (up to KMAP_TYPE_NR). Nested kmap_local.*() and kunmap_local.*()
+  invocations have to be strictly ordered because the map implementation is
+  stack based.
 
 * kmap_atomic().  This permits a very short duration mapping of a single
   page.  Since the mapping is restricted to the CPU that issued it, it
   performs well, but the issuing task is therefore required to stay on that
   CPU until it has finished, lest some other task displace its mappings.
 
-  kmap_atomic() may also be used by interrupt contexts, since it is does not
-  sleep and the caller may not sleep until after kunmap_atomic() is called.
+  kmap_atomic() may also be used by interrupt contexts, since it does not
+  sleep and the caller too can not sleep until after kunmap_atomic() is called.
+  Each call of kmap_atomic() in the kernel creates a non-preemptible section and
+  disable pagefaults.
+
+  This could be a source of unwanted latency, so it should be only used if it is
+  absolutely required, otherwise the corresponding kmap_local_*() variant should
+  be used if it is feasible.
+
+  On 64-bit systems, calls to kmap() and kmap_atomic() have no real work to do
+  because a 64-bit address space is more than sufficient to address all the
+  physical memory, so all of physical memory appears in the direct mapping.
+
+  It is assumed that k[un]map_atomic() won't fail.
 
-  It may be assumed that k[un]map_atomic() won't fail.
+* kmap().  This should be used to make short duration mapping of a single
+  page with no restrictions on preemption or migration. It comes with an
+  overhead as mapping space is restricted and protected by a global lock
+  for synchronization. When mapping is no more needed, the address that
+  the page was mapped to must be released with kunmap().
+
+  Mapping changes must be propagated across all the CPUs. kmap() also
+  requires global TLB invalidation when the kmap's pool wraps and it might
+  block when the mapping space is fully utilized until a slot becomes
+  available. Therefore, kmap() is only callable from preemptible context.
+
+  All the above work is necessary if a mapping must last for a relatively
+  long time but the bulk of high-memory mappings in the kernel are
+  short-lived and only used in one place. This means that the cost of
+  kmap() is mostly wasted in such cases. kmap() was not intended for long
+  term mappings but it has morphed in that direction and its use is
+  strongly discouraged in newer code and the set of the preceding functions
+  should be preferred.
+
+* vmap().  This can be used to make a long duration mapping of multiple
+  physical pages into a contiguous virtual space.  It needs global
+  synchronization to unmap.
 
 
 Using kmap_atomic
-- 
2.34.1

