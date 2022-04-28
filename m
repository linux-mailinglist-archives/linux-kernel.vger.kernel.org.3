Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA02513949
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349767AbiD1QDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349735AbiD1QC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:02:59 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3607AADD52
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:59:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651161583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zwt1Sx0pGDDP1QIiEEqqtc28lIMUpPSKVSQzvDDcrGM=;
        b=Mq2yqVxnX5D6a3Z+8iHVLmG47adlPN+nsa+tNRylOKiQ5DMBIoi9QNMIJ6U2jEe08yPZlk
        R2JK+OjIkZygJjuvdv3k/k5U0iH3M9dwvX618NHg9W6UBlVrFod9G9y7bBZR6lZPWi4VfA
        KSTFRMbkHn8kXFbU5TNGdZRobG8jaY8=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 2/2] mm: slab: fix comment for __assume_kmalloc_alignment
Date:   Thu, 28 Apr 2022 17:59:40 +0200
Message-Id: <84d8142747230f2015eaf9705ee7c2e1a9f56596.1651161548.git.andreyknvl@google.com>
In-Reply-To: <fe1ca7a25a054b61d1038686d07569416e287e7b.1651161548.git.andreyknvl@google.com>
References: <fe1ca7a25a054b61d1038686d07569416e287e7b.1651161548.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

The comment next to the __assume_kmalloc_alignment definition is not
precise: kmalloc relies on kmem_cache_alloc, so kmalloc technically returns
pointers aligned to both ARCH_KMALLOC_MINALIGN and ARCH_SLAB_MINALIGN,
not only to ARCH_KMALLOC_MINALIGN.

(See create_kmalloc_cache()->create_boot_cache()->calculate_alignment()
 for SLAB and SLUB and __do_kmalloc_node() for SLOB.)

Clarify the comment.

The assumption specified by __assume_kmalloc_alignment is still correct,
although it can be made stronger. I'll leave this to a separate patch.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/slab.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8cc1d54e56ad..06323a4beff0 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -210,9 +210,9 @@ void kmem_dump_obj(void *object);
 #endif
 
 /*
- * kmalloc and friends return ARCH_KMALLOC_MINALIGN aligned
- * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MINALIGN
- * aligned pointers.
+ * kmem_cache_alloc and friends return pointers aligned to ARCH_SLAB_MINALIGN.
+ * kmalloc and friends return pointers aligned to both ARCH_KMALLOC_MINALIGN
+ * and ARCH_SLAB_MINALIGN, but here we only assume the former alignment.
  */
 #define __assume_kmalloc_alignment __assume_aligned(ARCH_KMALLOC_MINALIGN)
 #define __assume_slab_alignment __assume_aligned(ARCH_SLAB_MINALIGN)
-- 
2.25.1

