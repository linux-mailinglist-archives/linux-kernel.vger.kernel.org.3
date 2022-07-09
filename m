Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4022E56CB4A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 21:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGITyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 15:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGITyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 15:54:35 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184FF1A07E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=omkWAofwlQhZwfFg6NlqwYMb2hSZlDfDMglmp7EN2TI=;
  b=PWlHCh2rFkyU70J9BoVgaRD0X1LZ1kOSKTuSjOb8JBZKQempx9J9G57Z
   gwlI4xEJTF6bcbQK4BgUa4s3fhYq3jI61pGI5x3pE1J69zw4Y4B08a50x
   zV8sj7jARdmKDmAvXrXnCuGTwAaDcEXqkqvfSpof5M4dquwqlcivyGLmH
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.92,259,1650924000"; 
   d="scan'208";a="18969110"
Received: from 150.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.150])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 21:54:31 +0200
Date:   Sat, 9 Jul 2022 21:54:30 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     David Howells <dhowells@redhat.com>
cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 61/61]
 fs/netfs/buffered_flush.c:1072:1-7: preceding lock on line 1011 (fwd)
Message-ID: <alpine.DEB.2.22.394.2207092153370.2756@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does line 1028 need to unlock dirty_lock?

julia

---------- Forwarded message ----------
Date: Sat, 9 Jul 2022 23:03:04 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 61/61]
    fs/netfs/buffered_flush.c:1072:1-7: preceding lock on line 1011

CC: kbuild-all@lists.01.org
BCC: lkp@intel.com
CC: "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>
CC: linux-kernel@vger.kernel.org
TO: David Howells <dhowells@redhat.com>

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   ce4670495468b797b0c5927fcb661bc0da48b9ab
commit: ce4670495468b797b0c5927fcb661bc0da48b9ab [61/61] netfs: Add a struct to group modifications together and flushed in order
:::::: branch date: 8 days ago
:::::: commit date: 8 days ago
config: openrisc-randconfig-c024-20220707 (https://download.01.org/0day-ci/archive/20220709/202207092348.fCpvRbGD-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>


cocci warnings: (new ones prefixed by >>)
>> fs/netfs/buffered_flush.c:1072:1-7: preceding lock on line 1011

vim +1072 fs/netfs/buffered_flush.c

ce4670495468b79 David Howells 2022-02-07   962
2dc27084e13c291 David Howells 2021-06-29   963  /*
2dc27084e13c291 David Howells 2021-06-29   964   * Flush some of the dirty queue, transforming a part of a sequence of dirty
2dc27084e13c291 David Howells 2021-06-29   965   * regions into a block we can flush.
2dc27084e13c291 David Howells 2021-06-29   966   *
2dc27084e13c291 David Howells 2021-06-29   967   * A number of things constrain us:
2dc27084e13c291 David Howells 2021-06-29   968   *  - The region we write out should not be undergoing modification
2dc27084e13c291 David Howells 2021-06-29   969   *  - We may need to expand or split the region for a number of reasons:
2dc27084e13c291 David Howells 2021-06-29   970   *    - Filesystem storage block/object size
2dc27084e13c291 David Howells 2021-06-29   971   *    - Filesystem RPC size (wsize)
2dc27084e13c291 David Howells 2021-06-29   972   *    - Cache block size
2dc27084e13c291 David Howells 2021-06-29   973   *    - Cache DIO block size
2dc27084e13c291 David Howells 2021-06-29   974   *    - Crypto/compression block size
2dc27084e13c291 David Howells 2021-06-29   975   *
2dc27084e13c291 David Howells 2021-06-29   976   * This may be entered multiple times simultaneously.  Automatic flushing by
2dc27084e13c291 David Howells 2021-06-29   977   * the VM is serialised on I_SYNC, but things like fsync() may enter multiple
2dc27084e13c291 David Howells 2021-06-29   978   * times simultaneously.
2dc27084e13c291 David Howells 2021-06-29   979   */
2dc27084e13c291 David Howells 2021-06-29   980  static int netfs_select_dirty(struct netfs_io_request *wreq,
2dc27084e13c291 David Howells 2021-06-29   981  			      struct writeback_control *wbc,
2dc27084e13c291 David Howells 2021-06-29   982  			      struct netfs_inode *ctx,
2dc27084e13c291 David Howells 2021-06-29   983  			      pgoff_t *_first, pgoff_t last)
2dc27084e13c291 David Howells 2021-06-29   984  {
2dc27084e13c291 David Howells 2021-06-29   985  	struct netfs_dirty_region *region;
ce4670495468b79 David Howells 2022-02-07   986  	struct netfs_flush_group *group;
2dc27084e13c291 David Howells 2021-06-29   987  	pgoff_t first = *_first;
2dc27084e13c291 David Howells 2021-06-29   988  	pgoff_t csize = 1UL << ctx->cache_order;
ce4670495468b79 David Howells 2022-02-07   989  	bool advance = true;
2dc27084e13c291 David Howells 2021-06-29   990  	int ret;
2dc27084e13c291 David Howells 2021-06-29   991
2dc27084e13c291 David Howells 2021-06-29   992  	/* Round out the range we're looking through to accommodate whole cache
2dc27084e13c291 David Howells 2021-06-29   993  	 * blocks.  The cache may only be able to store blocks of that size, in
2dc27084e13c291 David Howells 2021-06-29   994  	 * which case we may need to add non-dirty pages to the buffer too.
2dc27084e13c291 David Howells 2021-06-29   995  	 */
2dc27084e13c291 David Howells 2021-06-29   996  	if (ctx->cache_order) {
2dc27084e13c291 David Howells 2021-06-29   997  		first = round_down(first, csize);
2dc27084e13c291 David Howells 2021-06-29   998  		last = round_up_incl(last, csize);
2dc27084e13c291 David Howells 2021-06-29   999  	}
2dc27084e13c291 David Howells 2021-06-29  1000
2dc27084e13c291 David Howells 2021-06-29  1001  	_enter("%lx-%lx", first, last);
2dc27084e13c291 David Howells 2021-06-29  1002
2dc27084e13c291 David Howells 2021-06-29  1003  	if (wbc->sync_mode == WB_SYNC_NONE) {
2dc27084e13c291 David Howells 2021-06-29  1004  		if (!mutex_trylock(&ctx->wb_mutex))
2dc27084e13c291 David Howells 2021-06-29  1005  			return 0;
2dc27084e13c291 David Howells 2021-06-29  1006  	} else {
2dc27084e13c291 David Howells 2021-06-29  1007  		mutex_lock(&ctx->wb_mutex);
2dc27084e13c291 David Howells 2021-06-29  1008  	}
2dc27084e13c291 David Howells 2021-06-29  1009
2dc27084e13c291 David Howells 2021-06-29  1010  	/* Find the first dirty region that overlaps the requested range */
2dc27084e13c291 David Howells 2021-06-29 @1011  	spin_lock(&ctx->dirty_lock);
ce4670495468b79 David Howells 2022-02-07  1012
2dc27084e13c291 David Howells 2021-06-29  1013  	region = netfs_scan_for_region(ctx, first, last);
ce4670495468b79 David Howells 2022-02-07  1014  	if (region)
ce4670495468b79 David Howells 2022-02-07  1015  		kdebug("scan got D=%08x", region->debug_id);
ce4670495468b79 David Howells 2022-02-07  1016
ce4670495468b79 David Howells 2022-02-07  1017  	/* If the region selected is not in the bottommost flush group, we need
ce4670495468b79 David Howells 2022-02-07  1018  	 * to flush prerequisites first.
ce4670495468b79 David Howells 2022-02-07  1019  	 */
ce4670495468b79 David Howells 2022-02-07  1020  	if (region && region->group) {
ce4670495468b79 David Howells 2022-02-07  1021  		group = list_first_entry(&ctx->flush_groups,
ce4670495468b79 David Howells 2022-02-07  1022  					 struct netfs_flush_group, group_link);
ce4670495468b79 David Howells 2022-02-07  1023  		if (region->group != group) {
ce4670495468b79 David Howells 2022-02-07  1024  			kdebug("flush prereq");
ce4670495468b79 David Howells 2022-02-07  1025  			region = netfs_select_from_flush_group(wbc, ctx, group);
ce4670495468b79 David Howells 2022-02-07  1026  			if (IS_ERR(region)) {
ce4670495468b79 David Howells 2022-02-07  1027  				ret = PTR_ERR(region);
ce4670495468b79 David Howells 2022-02-07  1028  				goto unlock;
ce4670495468b79 David Howells 2022-02-07  1029  			}
ce4670495468b79 David Howells 2022-02-07  1030  			advance = false;
ce4670495468b79 David Howells 2022-02-07  1031  		}
2dc27084e13c291 David Howells 2021-06-29  1032  	}
ce4670495468b79 David Howells 2022-02-07  1033
ce4670495468b79 David Howells 2022-02-07  1034  	if (region)
ce4670495468b79 David Howells 2022-02-07  1035  		netfs_get_dirty_region(ctx, region, netfs_region_trace_get_wback);
ce4670495468b79 David Howells 2022-02-07  1036
2dc27084e13c291 David Howells 2021-06-29  1037  	spin_unlock(&ctx->dirty_lock);
2dc27084e13c291 David Howells 2021-06-29  1038  	if (!region) {
2dc27084e13c291 David Howells 2021-06-29  1039  		_debug("scan failed");
2dc27084e13c291 David Howells 2021-06-29  1040  		*_first = last;
2dc27084e13c291 David Howells 2021-06-29  1041  		ret = 0;
2dc27084e13c291 David Howells 2021-06-29  1042  		goto unlock;
2dc27084e13c291 David Howells 2021-06-29  1043  	}
2dc27084e13c291 David Howells 2021-06-29  1044
2dc27084e13c291 David Howells 2021-06-29  1045  	/* Try to grab the first folio of the requested range within that
2dc27084e13c291 David Howells 2021-06-29  1046  	 * region.
2dc27084e13c291 David Howells 2021-06-29  1047  	 */
2dc27084e13c291 David Howells 2021-06-29  1048  	if (*_first < region->first)
2dc27084e13c291 David Howells 2021-06-29  1049  		*_first = region->first;
ce4670495468b79 David Howells 2022-02-07  1050
2dc27084e13c291 David Howells 2021-06-29  1051  	ret = netfs_find_writeback_start(wreq, wbc, region, _first, last);
2dc27084e13c291 David Howells 2021-06-29  1052  	if (ret <= 0)
ce4670495468b79 David Howells 2022-02-07  1053  		goto put_region;
2dc27084e13c291 David Howells 2021-06-29  1054
2dc27084e13c291 David Howells 2021-06-29  1055  	netfs_extend_writeback(wreq, wbc, ctx, region);
ce4670495468b79 David Howells 2022-02-07  1056  	if (advance)
2dc27084e13c291 David Howells 2021-06-29  1057  		*_first = wreq->last + 1;
2dc27084e13c291 David Howells 2021-06-29  1058
2dc27084e13c291 David Howells 2021-06-29  1059  	netfs_split_out_regions(wreq, ctx, region);
2dc27084e13c291 David Howells 2021-06-29  1060
2dc27084e13c291 David Howells 2021-06-29  1061  	/* The assembled write request gets placed on the list to prevent
2dc27084e13c291 David Howells 2021-06-29  1062  	 * conflicting write requests happening simultaneously.
2dc27084e13c291 David Howells 2021-06-29  1063  	 */
2dc27084e13c291 David Howells 2021-06-29  1064  	netfs_add_wback_to_list(ctx, wreq);
2dc27084e13c291 David Howells 2021-06-29  1065  	ret = 1;
2dc27084e13c291 David Howells 2021-06-29  1066
ce4670495468b79 David Howells 2022-02-07  1067  put_region:
ce4670495468b79 David Howells 2022-02-07  1068  	netfs_put_dirty_region(ctx, region, netfs_region_trace_put_wback);
2dc27084e13c291 David Howells 2021-06-29  1069  unlock:
2dc27084e13c291 David Howells 2021-06-29  1070  	mutex_unlock(&ctx->wb_mutex);
2dc27084e13c291 David Howells 2021-06-29  1071  	_leave(" = %d [%lx]", ret, *_first);
2dc27084e13c291 David Howells 2021-06-29 @1072  	return ret;
2dc27084e13c291 David Howells 2021-06-29  1073  }
2dc27084e13c291 David Howells 2021-06-29  1074

:::::: The code at line 1072 was first introduced by commit
:::::: 2dc27084e13c29183f0a6853b81e5fa2941948e3 netfs: Generate a write request from ->writepages()

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
