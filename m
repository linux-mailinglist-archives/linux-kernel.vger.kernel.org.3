Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6348DF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiAMUrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiAMUru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:47:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F7AC061574;
        Thu, 13 Jan 2022 12:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fwMgN18aax/qpl7xV/FJbxBhoGCoQyfFo229GjBsU3M=; b=EYLOMZPmcXiCQJbBDc2q2Lj2cd
        jt0irnZ6EgmlzGId8/WydFe8x/MYw/2W751TAHyzP58Yfuf6uV4IX2xuon3d/hADvga0UX/PgdoLY
        SVUvppusL4AzHKRqKZ4VE4zo1ydlUGKcFPmN7p4lJpfdTTIvlu+dRfsZiMpJ8eNGVY7VR9sPGsUXo
        PidMDAwWcXqOjiSH+h+odcVmUcNjaO9yb0G2yT9bUUMouHFIxauDS7ZINFqtXo5tPb1SNeF/oeriI
        9Dd+iSW86EyDSmVxykfD6e2C6RGuPV2yMVvpBDlvDfFmd4jKFlJcVPvXRcX203yMRupwosz7HH0Vt
        sCscdYUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n870a-005ENc-29; Thu, 13 Jan 2022 20:47:44 +0000
Date:   Thu, 13 Jan 2022 20:47:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for Jan 13 (UBSAN: invalid-load in
 ../mm/swap.c:996:11)
Message-ID: <YeCP8Kh+4y7NR1K+@casper.infradead.org>
References: <20220113152247.3f7c6c49@canb.auug.org.au>
 <56c04e36-ff53-10c7-34dd-1c1385639de6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56c04e36-ff53-10c7-34dd-1c1385639de6@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 12:12:52PM -0800, Randy Dunlap wrote:
> [    1.561983] UBSAN: invalid-load in ../mm/swap.c:996:11
> [    1.561986] load of value 221 is not a valid value for type '_Bool'

Ooh.  This one's mine.  Randy, does it repeat easily?  This should
fix it:

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index dda8d5868c81..67b1246f136b 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -111,6 +111,7 @@ static_assert(offsetof(struct pagevec, pages) ==
 static inline void folio_batch_init(struct folio_batch *fbatch)
 {
 	fbatch->nr = 0;
+	fbatch->percpu_pvec_drained = false;
 }
 
 static inline unsigned int folio_batch_count(struct folio_batch *fbatch)

> [    1.561988] CPU: 1 PID: 7 Comm: kworker/u16:0 Not tainted 5.16.0-next-20220113 #1
> [    1.561992] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
> [    1.561994] Workqueue: events_unbound async_run_entry_fn
> [    1.562001] Call Trace:
> [    1.562003]  <TASK>
> [    1.562004]  dump_stack_lvl+0x38/0x49
> [    1.562010]  dump_stack+0x10/0x12
> [    1.562014]  ubsan_epilogue+0x9/0x45
> [    1.562018]  __ubsan_handle_load_invalid_value+0x53/0x5c
> [    1.562023]  __pagevec_release+0x24/0x47
> [    1.562028]  pagevec_release+0xe/0x11
> [    1.562031]  truncate_inode_pages_range+0x1d9/0x410
> [    1.562036]  ? __filemap_fdatawait_range+0x77/0x108
> [    1.562041]  ? __invalidate_bh_lrus+0x2b/0x2b
> [    1.562045]  ? put_bh+0x5/0x5
> [    1.562050]  truncate_inode_pages+0xd/0xf
> [    1.562054]  kill_bdev.isra.0+0x21/0x25
> [    1.562059]  blkdev_flush_mapping+0x3d/0xd3
> [    1.562063]  ? filemap_fdatawait_range+0x17/0x19
> [    1.562067]  blkdev_put_whole+0x16/0x36
> [    1.562071]  blkdev_put+0x128/0x152
> [    1.562075]  disk_scan_partitions+0x4c/0x64
> [    1.562081]  device_add_disk+0x236/0x2d5
> [    1.562085]  sd_probe+0x308/0x3c4
> [    1.562088]  really_probe+0x17f/0x3c3
> [    1.562092]  __driver_probe_device+0xcf/0x14d
> [    1.562095]  driver_probe_device+0x1e/0x8f
> [    1.562097]  __device_attach_driver+0xc7/0x104
> [    1.562100]  ? driver_allows_async_probing+0x5d/0x5d
> [    1.562103]  ? driver_allows_async_probing+0x5d/0x5d
> [    1.562106]  bus_for_each_drv+0x8c/0xb3
> [    1.562111]  __device_attach_async_helper+0x75/0xd4
> [    1.562114]  async_run_entry_fn+0x58/0xe3
> [    1.562118]  process_one_work+0x129/0x1cc
> [    1.562121]  worker_thread+0x183/0x22a
> [    1.562124]  kthread+0xe0/0xe8
> [    1.562128]  ? rescuer_thread+0x24c/0x24c
> [    1.562130]  ? kthread_complete_and_exit+0x1b/0x1b
> [    1.562135]  ret_from_fork+0x22/0x30
> [    1.562139]  </TASK>
> [    1.562140] ================================================================================
> 
> 
> Full boot log and kernel config file are attached.
> 
> -- 
> ~Randy



