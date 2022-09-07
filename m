Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F795AFD28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiIGHLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiIGHLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:11:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C727F24F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662534660; x=1694070660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LdKHrxAxXDqYHfPB0sEWH2wdDk/FqQuOHbbJB314/Vc=;
  b=HPoCrlEqKfSSfarAsIqX/uoSqDyvJVrAnrr4r+QzPy9N2RBO2JEHF7Fe
   xaerkYcJGqM9nd2TMIhP7RA8XwshJ1gpDY4lsFgKjlWksJz4EMkE1RAYh
   RraXhnO30cP1etDgi2PwgZHpAlOikIq1ngoZIOIYO+onEpNZnsqkuGhNP
   paPjXvplqgVukkgMH9CsiRA4yuV+VJppVPngL7uDF5yBz6GfWuTWIRxHL
   mh5gx3AMC4w1n14LvVnvaiCHz75rukbFOU+w9tKzNKtlqjnIxUmep71n3
   uoovMKIBeSyi3ZvdLFOfw+ET2qE8bab88+YxWds09Dtp2ib/oA5lsbDRz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="298115310"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="298115310"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 00:11:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676053451"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2022 00:10:57 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v5 3/4] mm: kasan: Add free_meta size info in struct kasan_cache
Date:   Wed,  7 Sep 2022 15:10:22 +0800
Message-Id: <20220907071023.3838692-4-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907071023.3838692-1-feng.tang@intel.com>
References: <20220907071023.3838692-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kasan is enabled for slab/slub, it may save kasan' free_meta
data in the former part of slab object data area in slab object
free path, which works fine.

There is ongoing effort to extend slub's debug function which will
redzone the latter part of kmalloc object area, and when both of
the debug are enabled, there is possible conflict, especially when
the kmalloc object has small size, as caught by 0Day bot [1]

For better information for slab/slub, add free_meta's data size
into 'struct kasan_cache', so that its users can take right action
to avoid data conflict.

[1]. https://lore.kernel.org/lkml/YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020/
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
 include/linux/kasan.h | 2 ++
 mm/kasan/common.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b092277bf48d..293bdaa0ba09 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -100,6 +100,8 @@ static inline bool kasan_has_integrated_init(void)
 struct kasan_cache {
 	int alloc_meta_offset;
 	int free_meta_offset;
+	/* size of free_meta data saved in object's data area */
+	int free_meta_size_in_object;
 	bool is_kmalloc;
 };
 
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 69f583855c8b..762ae7a7793e 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -201,6 +201,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
 			*size = ok_size;
 		}
+	} else {
+		cache->kasan_info.free_meta_size_in_object = sizeof(struct kasan_free_meta);
 	}
 
 	/* Calculate size with optimal redzone. */
-- 
2.34.1

