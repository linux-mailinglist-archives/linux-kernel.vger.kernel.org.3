Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27005AFD1E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIGHKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiIGHKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:10:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94587760DC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662534649; x=1694070649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yDo54Ene97KfLAtM/nTSGuxis/RqzNhE541Fy1Mc1ok=;
  b=oBsDxGZAyIEaiM/ZgBloSzlnLgZZrw3YpzzgGEwMuJcmuPLE/JP+gvTW
   pRkYlARzZoix0HYZHqOwo/Hy39GXTEzIQG1PFayEM/p1Qbw0md4SrgAEE
   nK71LlTeORyLSbxHlIz5mPjpgjcfqpFBqG9hg18wUSeo4aKv7myeFrc6r
   RrMy/e5g83a/vr9MK080Q5Lza9KedXQC9qPgtEuQlSkCHNoGvOp4vrsbF
   IBkR59+6CHeujr2uFxzJuv0TJnBZ3ccaVMmRhFipiiVBf77a5iZITUX2L
   rRlozztk7ewfqnE+Fvd503EvpTh25dvCloggKQ6WpId2kalMV6W2fZOHl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="298115254"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="298115254"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 00:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676053353"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2022 00:10:45 -0700
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
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v5 0/4] mm/slub: some debug enhancements for kmalloc 
Date:   Wed,  7 Sep 2022 15:10:19 +0800
Message-Id: <20220907071023.3838692-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
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

kmalloc's API family is critical for mm, and one of its nature is that
it will round up the request size to a fixed one (mostly power of 2).
When user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
could be allocated, so in worst case, there is around 50% memory space
waste.

The wastage is not a big issue for requests that get allocated/freed 
quickly, but may cause problems with objects that have longer life time,
and there were some OOM cases in some extrem cases.

This patchset tries to :
* Add a debug method to track each kmalloced object's wastage info,
  and show the call stack of original allocation (depends on
  SLAB_STORE_USER flag)
* Extend the redzone sanity check to the extra kmalloced buffer than
  requested, to better detect un-legitimate access to it. (depends
  on SLAB_STORE_USER & SLAB_RED_ZONE)

The redzone part has been tested with code below:

	for (shift = 3; shift <= 12; shift++) {
		size = 1 << shift;
		buf = kmalloc(size + 4, GFP_KERNEL);
		/* We have 96, 196 kmalloc size, which is not power of 2 */
		if (size == 64 || size == 128)
			oob_size = 16;
		else
			oob_size = size - 4;
		memset(buf + size + 4, 0xee, oob_size);
		kfree(buf);
	}

Please help to review, thanks!

- Feng

---
Changelogs:
 
  since v4:
    * fix a race issue in v3, by moving kmalloc debug init into
      alloc_debug_processing (Hyeonggon Yoo)
    * add 'partial_conext' for better parameter passing in get_partial()
      call chain (Vlastimil Babka)
    * update 'slub.rst' for 'alloc_traces' part (Hyeonggon Yoo)
    * update code comments for 'orig_size'

  since v3:
    * rebase against latest post 6.0-rc1 slab tree's 'for-next' branch  
    * fix a bug reported by 0Day, that kmalloc-redzoned data and kasan's
      free meta data overlaps in the same kmalloc object data area 

  since v2:
    * rebase against slab tree's 'for-next' branch
    * fix pointer handling (Kefeng Wang)
    * move kzalloc zeroing handling change to a separate patch (Vlastimil Babka) 
    * make 'orig_size' only depend on KMALLOC & STORE_USER flag
      bits (Vlastimil Babka)

  since v1:
    * limit the 'orig_size' to kmalloc objects only, and save
      it after track in metadata (Vlastimil Babka)
    * fix a offset calculation problem in print_trailer

  since RFC:
    * fix problems in kmem_cache_alloc_bulk() and records sorting,
      improve the print format (Hyeonggon Yoo)
    * fix a compiling issue found by 0Day bot
    * update the commit log based info from iova developers

Feng Tang (4):
  mm/slub: enable debugging memory wasting of kmalloc
  mm/slub: only zero the requested size of buffer for kzalloc
  mm: kasan: Add free_meta size info in struct kasan_cache
  mm/slub: extend redzone check to extra allocated kmalloc space than
    requested

 Documentation/mm/slub.rst |  33 +++---
 include/linux/kasan.h     |   2 +
 include/linux/slab.h      |   2 +
 mm/kasan/common.c         |   2 +
 mm/slab.c                 |   6 +-
 mm/slab.h                 |  13 ++-
 mm/slab_common.c          |   4 +
 mm/slub.c                 | 219 ++++++++++++++++++++++++++++++--------
 8 files changed, 220 insertions(+), 61 deletions(-)

-- 
2.34.1

