Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9832A5B235C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiIHQPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiIHQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:15:30 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AD35FE3;
        Thu,  8 Sep 2022 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=UeuW3y4mcZK68L2IDICGGzPskyQWuMEDeNPUgMXd7i0=; b=txnX3wmwBVF6pn5dOC3TIBAM3e
        ESAzIGaY3nXB51Q1DSf4BYMsqh00GtapzNjYiCxChVmIVA1FWAhM76F3FrRVFABCd+udkOspoAV9P
        BMCm8MwUsc2wnSt1Pu0a8i+rM9aOynBAAUOFg9Om4t5RzhneoJttbOmLbfjHFFoiNcTeDLN74me3Y
        n0FRTW+lNraD1V1qYmeCG466UNfTqwEH/CTEdNHIhUErCyrkysVutXTdMLk0h31lIq8mo85vtM6my
        Ilpk5vu0TxmNlDOB+V9gh8OAfLHgjr3r/UI12mhlbtIO2a7DaWnjVmylbJYSwg1fBsfYxi+uWHTxS
        pxNaU7ug==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oWKBW-001jJz-RD; Thu, 08 Sep 2022 10:15:24 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oWKBU-00019D-GF; Thu, 08 Sep 2022 10:15:20 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        David Sloan <david.sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Guoqing Jiang <Guoqing.jiang@linux.dev>
Date:   Thu,  8 Sep 2022 10:15:14 -0600
Message-Id: <20220908161516.4361-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220908161516.4361-1-logang@deltatee.com>
References: <20220908161516.4361-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, david.sloan@eideticom.com, logang@deltatee.com, hch@lst.de, guoqing.jiang@linux.dev, Guoqing.jiang@linux.dev
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 1/3] md/raid5: Remove unnecessary bio_put() in raid5_read_one_chunk()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Sloan <david.sloan@eideticom.com>

When running chunk-sized reads on disks with badblocks duplicate bio
free/puts are observed:

   =============================================================================
   BUG bio-200 (Not tainted): Object already free
   -----------------------------------------------------------------------------
   Allocated in mempool_alloc_slab+0x17/0x20 age=3 cpu=2 pid=7504
    __slab_alloc.constprop.0+0x5a/0xb0
    kmem_cache_alloc+0x31e/0x330
    mempool_alloc_slab+0x17/0x20
    mempool_alloc+0x100/0x2b0
    bio_alloc_bioset+0x181/0x460
    do_mpage_readpage+0x776/0xd00
    mpage_readahead+0x166/0x320
    blkdev_readahead+0x15/0x20
    read_pages+0x13f/0x5f0
    page_cache_ra_unbounded+0x18d/0x220
    force_page_cache_ra+0x181/0x1c0
    page_cache_sync_ra+0x65/0xb0
    filemap_get_pages+0x1df/0xaf0
    filemap_read+0x1e1/0x700
    blkdev_read_iter+0x1e5/0x330
    vfs_read+0x42a/0x570
   Freed in mempool_free_slab+0x17/0x20 age=3 cpu=2 pid=7504
    kmem_cache_free+0x46d/0x490
    mempool_free_slab+0x17/0x20
    mempool_free+0x66/0x190
    bio_free+0x78/0x90
    bio_put+0x100/0x1a0
    raid5_make_request+0x2259/0x2450
    md_handle_request+0x402/0x600
    md_submit_bio+0xd9/0x120
    __submit_bio+0x11f/0x1b0
    submit_bio_noacct_nocheck+0x204/0x480
    submit_bio_noacct+0x32e/0xc70
    submit_bio+0x98/0x1a0
    mpage_readahead+0x250/0x320
    blkdev_readahead+0x15/0x20
    read_pages+0x13f/0x5f0
    page_cache_ra_unbounded+0x18d/0x220
   Slab 0xffffea000481b600 objects=21 used=0 fp=0xffff8881206d8940 flags=0x17ffffc0010201(locked|slab|head|node=0|zone=2|lastcpupid=0x1fffff)
   CPU: 0 PID: 34525 Comm: kworker/u24:2 Not tainted 6.0.0-rc2-localyes-265166-gf11c5343fa3f #143
   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
   Workqueue: raid5wq raid5_do_work
   Call Trace:
    <TASK>
    dump_stack_lvl+0x5a/0x78
    dump_stack+0x10/0x16
    print_trailer+0x158/0x165
    object_err+0x35/0x50
    free_debug_processing.cold+0xb7/0xbe
    __slab_free+0x1ae/0x330
    kmem_cache_free+0x46d/0x490
    mempool_free_slab+0x17/0x20
    mempool_free+0x66/0x190
    bio_free+0x78/0x90
    bio_put+0x100/0x1a0
    mpage_end_io+0x36/0x150
    bio_endio+0x2fd/0x360
    md_end_io_acct+0x7e/0x90
    bio_endio+0x2fd/0x360
    handle_failed_stripe+0x960/0xb80
    handle_stripe+0x1348/0x3760
    handle_active_stripes.constprop.0+0x72a/0xaf0
    raid5_do_work+0x177/0x330
    process_one_work+0x616/0xb20
    worker_thread+0x2bd/0x6f0
    kthread+0x179/0x1b0
    ret_from_fork+0x22/0x30
    </TASK>

The double free is caused by an unnecessary bio_put() in the
if(is_badblock(...)) error path in raid5_read_one_chunk().

The error path was moved ahead of bio_alloc_clone() in c82aa1b76787c
("md/raid5: move checking badblock before clone bio in
raid5_read_one_chunk"). The previous code checked and freed align_bio
which required a bio_put. After the move that is no longer needed as
raid_bio is returned to the control of the common io path which
performs its own endio resulting in a double free on bad device blocks.

Fixes: c82aa1b76787c ("md/raid5: move checking badblock before clone bio in raid5_read_one_chunk")
Signed-off-by: David Sloan <david.sloan@eideticom.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Guoqing Jiang <Guoqing.jiang@linux.dev>
---
 drivers/md/raid5.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4e6d865a6456..734f92e75f85 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5538,7 +5538,6 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 
 	if (is_badblock(rdev, sector, bio_sectors(raid_bio), &first_bad,
 			&bad_sectors)) {
-		bio_put(raid_bio);
 		rdev_dec_pending(rdev, mddev);
 		return 0;
 	}
-- 
2.30.2

