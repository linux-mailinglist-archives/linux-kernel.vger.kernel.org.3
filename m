Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472D8570BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiGKUcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiGKUcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2352E599FA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657571494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aTwmb8JOS12zadjvclFF3Icn3IZ5tZFv5l4855dWsao=;
        b=NJCK4bnmnmenOp3ecI76HJ96m8ZGE/Ce+O3ffHwptcFTuB4lcOjyfyUTCUTLUlrVZ61viA
        CLJyNHRal/pyHOe7u0rdU2RJut56SxERcf98+5MJ1fNl78cc7/vDlOuF8yiwP4MUSs8/V9
        Y7PXUk4bn1hinkOCbYPyeDT8ile6McU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-meKS1-h4MfWQM6h0WA_YPw-1; Mon, 11 Jul 2022 16:31:27 -0400
X-MC-Unique: meKS1-h4MfWQM6h0WA_YPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B50F9101AA4D;
        Mon, 11 Jul 2022 20:31:26 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A962218EB7;
        Mon, 11 Jul 2022 20:31:26 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 26BKVQ4q005686;
        Mon, 11 Jul 2022 16:31:26 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 26BKVQ3K005682;
        Mon, 11 Jul 2022 16:31:26 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 11 Jul 2022 16:31:26 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Mike Snitzer <msnitzer@redhat.com>
cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: [PATCH 3/4] dm-writecache: count the number of blocks written, not
 the number of write bios
In-Reply-To: <alpine.LRH.2.02.2207111627260.5249@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2207111631000.5249@file01.intranet.prod.int.rdu2.redhat.com>
References: <20220706093146.1961598-1-yukuai1@huaweicloud.com> <alpine.LRH.2.02.2207111627260.5249@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change dm-writecache, so that it counts the number of blocks written
instead of the number of write bios. Bios can be split and requeued using
the dm_accept_partial_bio function, so counting of bios provided
inaccurate results.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Yu Kuai <yukuai1@huaweicloud.com>

Index: linux-2.6/drivers/md/dm-writecache.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-writecache.c
+++ linux-2.6/drivers/md/dm-writecache.c
@@ -1413,6 +1413,9 @@ static void writecache_bio_copy_ssd(stru
 	bio->bi_iter.bi_sector = start_cache_sec;
 	dm_accept_partial_bio(bio, bio_size >> SECTOR_SHIFT);
 
+	wc->stats.writes += bio->bi_iter.bi_size >> wc->block_size_bits;
+	wc->stats.writes_allocate += (bio->bi_iter.bi_size - wc->block_size) >> wc->block_size_bits;
+
 	if (unlikely(wc->uncommitted_blocks >= wc->autocommit_blocks)) {
 		wc->uncommitted_blocks = 0;
 		queue_work(wc->writeback_wq, &wc->flush_work);
@@ -1428,9 +1431,10 @@ static enum wc_map_op writecache_map_wri
 	do {
 		bool found_entry = false;
 		bool search_used = false;
-		wc->stats.writes++;
-		if (writecache_has_error(wc))
+		if (writecache_has_error(wc)) {
+			wc->stats.writes += bio->bi_iter.bi_size >> wc->block_size_bits;
 			return WC_MAP_ERROR;
+		}
 		e = writecache_find_entry(wc, bio->bi_iter.bi_sector, 0);
 		if (e) {
 			if (!writecache_entry_is_committed(wc, e)) {
@@ -1454,9 +1458,10 @@ static enum wc_map_op writecache_map_wri
 		if (unlikely(!e)) {
 			if (!WC_MODE_PMEM(wc) && !found_entry) {
 direct_write:
-				wc->stats.writes_around++;
 				e = writecache_find_entry(wc, bio->bi_iter.bi_sector, WFE_RETURN_FOLLOWING);
 				writecache_map_remap_origin(wc, bio, e);
+				wc->stats.writes_around += bio->bi_iter.bi_size >> wc->block_size_bits;
+				wc->stats.writes += bio->bi_iter.bi_size >> wc->block_size_bits;
 				return WC_MAP_REMAP_ORIGIN;
 			}
 			wc->stats.writes_blocked_on_freelist++;
@@ -1470,6 +1475,7 @@ direct_write:
 bio_copy:
 		if (WC_MODE_PMEM(wc)) {
 			bio_copy_block(wc, bio, memory_data(wc, e));
+			wc->stats.writes++;
 		} else {
 			writecache_bio_copy_ssd(wc, bio, e, search_used);
 			return WC_MAP_REMAP;
Index: linux-2.6/Documentation/admin-guide/device-mapper/writecache.rst
===================================================================
--- linux-2.6.orig/Documentation/admin-guide/device-mapper/writecache.rst
+++ linux-2.6/Documentation/admin-guide/device-mapper/writecache.rst
@@ -80,11 +80,11 @@ Status:
 4. the number of blocks under writeback
 5. the number of read blocks
 6. the number of read blocks that hit the cache
-7. the number of write requests
-8. the number of write requests that hit uncommitted block
-9. the number of write requests that hit committed block
-10. the number of write requests that bypass the cache
-11. the number of write requests that are allocated in the cache
+7. the number of write blocks
+8. the number of write blocks that hit uncommitted block
+9. the number of write blocks that hit committed block
+10. the number of write blocks that bypass the cache
+11. the number of write blocks that are allocated in the cache
 12. the number of write requests that are blocked on the freelist
 13. the number of flush requests
 14. the number of discard requests

