Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93F85A4445
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiH2H4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiH2Hz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:55:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63F82715A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661759755; x=1693295755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jcnnNskazsBc3DHIiMPQsDf7lUlURK3M021eCeUP7pM=;
  b=OGcIyYRbXBOQQejgaaDTfoCuJJSngme/mry8Wzwg/caju5n9W3z8SguK
   X7zDPFtNKj+wftSQH3It4wQagJD3WbIAQwNvz40prKQo7eSiZ/oKxD8/D
   L96PWpwjYsISi3JsHbfpdYWKkD461oAO/Wps+oCtOm/YHPan+3miV/r6p
   GJGkOOhqO9lKqtzm0GnO2GTu7pllHRZFui8GS0+BcqhLiqjh8y/E/ZvT0
   AiEPqvIC8iQo6nvQYxCxfZxLI3b7iD+BUIuhS0hxj7WFmDFAuaokTiugp
   8UpXqz6mMl+KrKndQ6P2eNkHb+uxmGeEWGVBD1I5IX0V1pXLWFeSSe5fp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="381140133"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="381140133"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="672283586"
Received: from shbuild999.sh.intel.com ([10.239.147.181])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2022 00:55:52 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v4 3/4] mm: kasan: Add free_meta size info in struct kasan_cache
Date:   Mon, 29 Aug 2022 15:56:17 +0800
Message-Id: <20220829075618.69069-4-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220829075618.69069-1-feng.tang@intel.com>
References: <20220829075618.69069-1-feng.tang@intel.com>
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
info 'kasan_cache', so that its users can take right action to
avoid data conflict.

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

