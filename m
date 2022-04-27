Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18725121A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiD0SxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiD0Sw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:52:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F0B42CA;
        Wed, 27 Apr 2022 11:38:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y3so5094493ejo.12;
        Wed, 27 Apr 2022 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jOs08eZRk6ExS199wzRva9ul3oRppHhYhG8H+SRVTNs=;
        b=AMCnfbxGjjdKlTzyhbozRm+aS3brrBzQsgur9pRnfMnqBvu/SuIbid8Crrkl+UpJ2A
         3vqPNbLrcej51RTvsy/6grOFJ2gpJvYXxUhJoioSGBxUpZVmn9LWKugWlsUoVUyLb9PN
         SeI78ZtISIfEOKQbRTMJolDxr7IeTuYjWX7SOfMU4sTFchUkfO156gbilKnrvXtDOFZC
         bKWawtwNT4XqEnuQc7pJBNQjP3ZO303Nv2Ox4a51AmYwU27kQzAF/oC8t4y5WtTm4F2t
         Mlusn2zDvW1bCViW3PJGgln2upWw+xF0B1Y3j+uoV9viNLa0i/7zunE/6Yp0xtOcZI1P
         Mvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jOs08eZRk6ExS199wzRva9ul3oRppHhYhG8H+SRVTNs=;
        b=PERUKU09fT7TOgt3brI7PuzXfLo3w+4IqsT0hEg1unHrWCJ7YfFEIyaYLcRD14NIy9
         GGv8WCybgvCnlI0V/s3CTxbNBpXLIg5pj9NXtLaMoTX3XfCI3SXF3PbZfbccxywv6q8G
         +Q6zT9mMuUWJmgT67/BWFjvWnfVoOo4/nTAsxpZSUQYdUxGGYAdUeSHuFNL32xVlE5LF
         u3uOP3M+8AAnuCTMfeRBu8WxDYlMtY6H9/gf6RcoBtemEyLV83H3wCKMg3s8Fr3u+itl
         LytYIgnczJ9u1ygjrSKV6bx3gAO3IBbz9z8o6Fgz2j0qNm+PJPG57OnJFBAk44b6l0ys
         CErQ==
X-Gm-Message-State: AOAM532SpGzKesu/VRVGv9ziMb/PPnNWSIWCLW0rjDsviJyD71pozyeD
        IDkU1wZKf+6S/pNZsCpwVCw=
X-Google-Smtp-Source: ABdhPJwWDatxEfRatj8lLwPfJQ47Zd8rjxiQLgCmNfAWGsGt89ymZa2VnfWy1gE6hzBSiMls3Z9HOw==
X-Received: by 2002:a17:907:3e2a:b0:6f3:aa0c:ab94 with SMTP id hp42-20020a1709073e2a00b006f3aa0cab94mr11398613ejc.23.1651084716314;
        Wed, 27 Apr 2022 11:38:36 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ig8-20020a1709072e0800b006f38f2e9ebesm4691667ejc.64.2022.04.27.11.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:38:34 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 4/4] Documentation/vm: Rework "Temporary Virtual Mappings" section
Date:   Wed, 27 Apr 2022 20:38:21 +0200
Message-Id: <20220427183821.1979-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220427183821.1979-1-fmdefrancesco@gmail.com>
References: <20220427183821.1979-1-fmdefrancesco@gmail.com>
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
Ira Weiny and Matthew Wilcox, and in-code comments from highmem.h.

1) Add a paragraph to document kmap_local_page().
2) Reorder the list of functions by decreasing order of preference of
use.
3) Rework part of the kmap() entry in list.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 74 ++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index e05bf5524174..c8aff448612b 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -50,26 +50,78 @@ space when they use mm context tags.
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
+  These mappings are thread-local and CPU-local (i.e., migration from one CPU
+  to another is disabled - this is why they are called "local"), but they don't
+  disable preemption. It's valid to take pagefaults in a local kmap region,
+  unless the context in which the local mapping is acquired does not allow it
+  for other reasons.
+
+  kmap_local_page() always returns a valid virtual address and it is assumed
+  that kunmap_local() will never fail.
+
+  If a task holding local kmaps is preempted, the maps are removed on context
+  switch and restored when the task comes back on the CPU. The maps are
+  strictly thread-local and CPU-local, therefore it is guaranteed that the
+  task stays on the CPU and the CPU cannot be unplugged until the local kmaps
+  are released.
+
+  Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
+  extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
+  because the map implementation is stack based. See kmap_local_page () kdocs
+  (included in the "Functions" section) for details on how to manage nested
+  mappings.
 
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
+  for synchronization. When mapping is no longer needed, the address that
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

