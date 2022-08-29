Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A767F5A4441
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiH2Hzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH2Hzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:55:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5DD1AF39
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661759746; x=1693295746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GIoiXdJvmXZ6xSeL3NAMSUDFWyLW73E9SMskZ4AWliI=;
  b=e1XL2rlH2n90ObylcDi8tyPKVdbgLoP7vqOgGIKtlAFxW/YSOSYnyNqI
   ZtwiIDQkSEurc+BO0Cdlq4ehzjIhAttiVLO9Zf3AJVNWPLVCbWn+x7IIZ
   5MowEnho2Sjt9cQQ5KxVDAHp6730KAHWAoydy+3eycYL/FCGQQKZNYbJH
   RXZc7dm4GnWIAZtzmXoyWFv5RVq1u1wLJlIqhgbLa9NdsPIhvN9hGFXLU
   ctHYpXTpZa2OUMga+ZMkEinSXjFKtnklNzIxLEEs+4JGlvPsxdb7CUl60
   QxVm60RloYZ+CkO1QZTJ73SII1gCSVVPVtUZTacHmbgcrl8zQ5oARE/Dj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="381140112"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="381140112"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="672283525"
Received: from shbuild999.sh.intel.com ([10.239.147.181])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2022 00:55:42 -0700
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
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>
Subject: [PATCH v4 0/4] mm/slub: some debug enhancements for kmalloc objects 
Date:   Mon, 29 Aug 2022 15:56:14 +0800
Message-Id: <20220829075618.69069-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
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

  since v3:
    * rebase against latest post 6.0-rc1 slab tree's 'for-next' branch.
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
  mm/slub: extend redzone check to cover extra allocated kmalloc space
    than requested

 include/linux/kasan.h |   2 +
 include/linux/slab.h  |   2 +
 mm/kasan/common.c     |   2 +
 mm/slab.c             |   6 +-
 mm/slab.h             |  13 +++-
 mm/slab_common.c      |   4 +
 mm/slub.c             | 168 +++++++++++++++++++++++++++++++++++++-----
 7 files changed, 172 insertions(+), 25 deletions(-)

-- 
2.34.1

