Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664E85820C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiG0HKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiG0HKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:10:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BFEE088
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658905839; x=1690441839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pgzWF10gM+nk0heJ6laSiJKJPMsfPIgqqxGgbJXgLcM=;
  b=QNtVcMDXswsVAiUrWsTAZMHKSyWf3s5YR+JOVrlM34vQmkb+/UMonX1R
   O0AvbJZjcOD76WEtGzoefnwXRmv/bxGJQobUjhOmDQ2PUDeN+9U+R9hZ3
   bVMO2OyREow/eer53n9c5RqqZeRvaqzRovuO/1TqO6m86yl2AQjmsXtwC
   f9LVMdZYVafu4mOkV9kFd6IL16L2DORgWiRtuXsLQ9cwfZ8nLZRleIY0p
   MQ7sf49gJZHyhppEC2i8+lYs27nAWqa4Qnp6yqvq92g6kbt4FXe0TnJxQ
   NUov3GyTkN3d7GwJbmJ6fyCykhEvVWtbxrrd656U9pXMS1tJ7jb3tBmp0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="267931675"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="267931675"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 00:10:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="550737896"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by orsmga003.jf.intel.com with ESMTP; 27 Jul 2022 00:10:35 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 0/3] mm/slub: some debug enhancements 
Date:   Wed, 27 Jul 2022 15:10:39 +0800
Message-Id: <20220727071042.8796-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
  and show the call stack of original allocation
* Extend the redzone sanity check to the extra kmalloced buffer than
  requested, to better detect un-legitimate access to it.

Please help to review, thanks!

- Feng

---
Changelogs:

  since v2:
    * rebased against slab tree's 'for-next' branch
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


Feng Tang (3):
  mm/slub: enable debugging memory wasting of kmalloc
  mm/slub: only zero the requested size of buffer for kzalloc
  mm/slub: extend redzone check to cover extra allocated kmalloc space
    than requested

 include/linux/slab.h |   2 +
 mm/slab.c            |   8 +--
 mm/slab.h            |   9 ++-
 mm/slub.c            | 157 ++++++++++++++++++++++++++++++++++++-------
 4 files changed, 146 insertions(+), 30 deletions(-)

-- 
2.27.0

