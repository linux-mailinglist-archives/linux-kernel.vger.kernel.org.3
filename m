Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C10650A7AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391147AbiDUSF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391130AbiDUSFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:05:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0564B1DE;
        Thu, 21 Apr 2022 11:02:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u15so11560716ejf.11;
        Thu, 21 Apr 2022 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6ZmwFanJZuh7hQqz3LVbwr1p4KwEMnE7IqhDHbu+tA=;
        b=WQkj196SEjCOm5X1GFd5opNyYrB5ISoL5QCp3zcZ4yG0SHgB7UKcBFt7pk76U2OtPU
         +Ve58ZPZqJmVLzICA+f/cnKOvcfY/w5tV4ffzw3Qja6gBgVs/y+RzREkPUa4Y3xsmFbA
         3Je4Dkv/zCVMsTbR4+e2pYNkLBajXcdoM/FMM5Q+mt5Ts7Yfs2LoBBwxQbeaYSlUO+o2
         L/EGCoZIiqV+yiIOC3doM2oX8GC93aQ1io1l7PE3rqtxJd6HIp0xaT7N257ByOGQ5b07
         T6b1k8onjIXT3G9OxRiw0g3fI5pr8KMPaleq644o0uSnCkBIAdvXXVt5hGGGBzx7VcXK
         0u6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6ZmwFanJZuh7hQqz3LVbwr1p4KwEMnE7IqhDHbu+tA=;
        b=YH6qED0tzZePi/AJRNQhlz4YynHkXoDk+18nLzzpbTPP5TERw51SxyRv9D5J5Tk0YB
         wzjKbzF9ysa/MFrkAzyhcg9LxrANduNHMGwdbQ2x8TWsXX3lYrV6cLJWBbK444UmVP9/
         5uPYf3NP+4+unrOHTQlZP/7KaXiNP1EiWTV3yRwppVhFVg3ek4q7yZX817q6OQIo/Qzo
         lMWhmdO43oDJP/9RAE2OrbFYtTC013Twjete+IRt7cNthdgmbZqZlEIuBxvQnIOmHAAm
         gkxWCXUR+Dzkdscdyd2FrKlnJDgw0Q2XcVzbBHazGvH00wTFjz/VTvlaz0m1XDfHJVJ9
         ivKQ==
X-Gm-Message-State: AOAM533AFO5NG+5GX+PV43iGTihkm/PmFXR7/13TM5YxhFGU3YX30dgX
        17Gqi+stgeeFVH4zYugrr7Y=
X-Google-Smtp-Source: ABdhPJyLVNzKlRNdicrjeKkwsfZkoOjRLHIkNCSVnaOxJCJcfpFsnLT/eGP2v0fC33Y/ojSFUEB1Pg==
X-Received: by 2002:a17:907:7d88:b0:6f0:29ea:cbfe with SMTP id oz8-20020a1709077d8800b006f029eacbfemr640244ejc.704.1650564140059;
        Thu, 21 Apr 2022 11:02:20 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402231100b0041d98ed7ad8sm11836204eda.46.2022.04.21.11.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:02:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/4] Documentation/vm: Rework "Temporary Virtual Mappings"
Date:   Thu, 21 Apr 2022 20:02:00 +0200
Message-Id: <20220421180200.16901-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220421180200.16901-1-fmdefrancesco@gmail.com>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend and rework the "Temporary Virtual Mappings" section of the highmem.rst
documentation.

Despite the local kmaps were introduced by Thomas Gleixner in October 2020,
documentation was still missing information about them. These additions rely
largely on Gleixner's patches, Jonathan Corbet's LWN articles, comments by
Ira Weiny and Matthew Wilcox, and in-code comments from
./include/linux/highmem.h.

1) Add a paragraph to document kmap_local_page().
2) Reorder the list of functions by decreasing order of preference of
use.
3) Rework part of the kmap() entry in list.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 71 ++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index e05bf5524174..960f61e7a552 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -50,26 +50,75 @@ space when they use mm context tags.
 Temporary Virtual Mappings
 ==========================
 
-The kernel contains several ways of creating temporary mappings:
+The kernel contains several ways of creating temporary mappings. The following
+list shows them in order of preference of use.
 
-* vmap().  This can be used to make a long duration mapping of multiple
-  physical pages into a contiguous virtual space.  It needs global
-  synchronization to unmap.
+* kmap_local_page().  This function is used to require short term mappings.
+  It can be invoked from any context (including interrupts) but the mappings
+  can only be used in the context which acquired them.
+
+  This function should be preferred, where feasible, over all the others.
 
-* kmap().  This permits a short duration mapping of a single page.  It needs
-  global synchronization, but is amortized somewhat.  It is also prone to
-  deadlocks when using in a nested fashion, and so it is not recommended for
-  new code.
+  These mappings are per thread, CPU local (i.e., migration from one CPU to
+  another is disabled - this is why they are called "local"), but they don't
+  disable preemption. It's valid to take pagefaults in a local kmap region,
+  unless the context in which the local mapping is acquired does not allow
+  it for other reasons.
+
+  It is assumed that kmap_local_page() always returns the virtual address
+  of the mapping, therefore they won't ever fail.
+
+  If a task holding local kmaps is preempted, the maps are removed on context
+  switch and restored when the task comes back on the CPU. As the maps are
+  strictly CPU local, it is guaranteed that the task stays on the CPU and
+  that the CPU cannot be unplugged until the local kmaps are released.
+
+  Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
+  extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
+  because the map implementation is stack based.
 
 * kmap_atomic().  This permits a very short duration mapping of a single
   page.  Since the mapping is restricted to the CPU that issued it, it
   performs well, but the issuing task is therefore required to stay on that
   CPU until it has finished, lest some other task displace its mappings.
 
-  kmap_atomic() may also be used by interrupt contexts, since it is does not
-  sleep and the caller may not sleep until after kunmap_atomic() is called.
+  kmap_atomic() may also be used by interrupt contexts, since it does not
+  sleep and the callers too may not sleep until after kunmap_atomic() is
+  called.
+
+  Each call of kmap_atomic() in the kernel creates a non-preemptible section
+  and disable pagefaults. This could be a source of unwanted latency, so it
+  should be only used if it is absolutely required, otherwise kmap_local_page()
+  should be used where it is feasible.
 
-  It may be assumed that k[un]map_atomic() won't fail.
+  It is assumed that k[un]map_atomic() won't fail.
+
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
+  On 64-bit systems, calls to kmap_local_page(), kmap_atomic() and kmap() have
+  no real work to do because a 64-bit address space is more than sufficient to
+  address all the physical memory whose pages are permanently mapped.
+
+* vmap().  This can be used to make a long duration mapping of multiple
+  physical pages into a contiguous virtual space.  It needs global
+  synchronization to unmap.
 
 
 Cost of Temporary Mappings
-- 
2.34.1

