Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C16570BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiGKUcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiGKUbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC8F64D171
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657571431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0n60kckffBfmzZA5sfyY6ZipoCQDQpxgKUj1+I9TUs=;
        b=TG1+hsrINsZh5oVF+Plr3/qA5VcQLn2GUFnCPNB04u0o/bEKZKAGNf+f1Qin6Do1HDEvOV
        HGTl3mKniOfr9ZV7ZXEf+caCU2NodhuOhDYb/jnt2jQWUmwZvuzDxOEvf5inB6bsP+SC0N
        3EQLW9i5XP/n3Hc2Fk1ejA9jp6304FU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-bqBRylkdM4CUrriH52UmaQ-1; Mon, 11 Jul 2022 16:30:27 -0400
X-MC-Unique: bqBRylkdM4CUrriH52UmaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60D921C06ED0;
        Mon, 11 Jul 2022 20:30:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 556152166B26;
        Mon, 11 Jul 2022 20:30:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 26BKURIU005597;
        Mon, 11 Jul 2022 16:30:27 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 26BKURTq005594;
        Mon, 11 Jul 2022 16:30:27 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 11 Jul 2022 16:30:27 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Mike Snitzer <msnitzer@redhat.com>
cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: [PATCH 1/4] dm-writecache: make writecache_map_remap_origin return
 void
In-Reply-To: <alpine.LRH.2.02.2207111627260.5249@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2207111629560.5249@file01.intranet.prod.int.rdu2.redhat.com>
References: <20220706093146.1961598-1-yukuai1@huaweicloud.com> <alpine.LRH.2.02.2207111627260.5249@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions writecache_map_remap_origin and writecache_bio_copy_ssd
return only a single value, thus we can make them return void.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-2.6/drivers/md/dm-writecache.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-writecache.c
+++ linux-2.6/drivers/md/dm-writecache.c
@@ -1329,8 +1329,8 @@ enum wc_map_op {
 	WC_MAP_ERROR,
 };
 
-static enum wc_map_op writecache_map_remap_origin(struct dm_writecache *wc, struct bio *bio,
-						  struct wc_entry *e)
+static void writecache_map_remap_origin(struct dm_writecache *wc, struct bio *bio,
+					struct wc_entry *e)
 {
 	if (e) {
 		sector_t next_boundary =
@@ -1338,8 +1338,6 @@ static enum wc_map_op writecache_map_rem
 		if (next_boundary < bio->bi_iter.bi_size >> SECTOR_SHIFT)
 			dm_accept_partial_bio(bio, next_boundary);
 	}
-
-	return WC_MAP_REMAP_ORIGIN;
 }
 
 static enum wc_map_op writecache_map_read(struct dm_writecache *wc, struct bio *bio)
@@ -1366,14 +1364,15 @@ read_next_block:
 			map_op = WC_MAP_REMAP;
 		}
 	} else {
-		map_op = writecache_map_remap_origin(wc, bio, e);
+		writecache_map_remap_origin(wc, bio, e);
+		map_op = WC_MAP_REMAP_ORIGIN;
 	}
 
 	return map_op;
 }
 
-static enum wc_map_op writecache_bio_copy_ssd(struct dm_writecache *wc, struct bio *bio,
-					      struct wc_entry *e, bool search_used)
+static void writecache_bio_copy_ssd(struct dm_writecache *wc, struct bio *bio,
+				    struct wc_entry *e, bool search_used)
 {
 	unsigned bio_size = wc->block_size;
 	sector_t start_cache_sec = cache_sector(wc, e);
@@ -1419,8 +1418,6 @@ static enum wc_map_op writecache_bio_cop
 	} else {
 		writecache_schedule_autocommit(wc);
 	}
-
-	return WC_MAP_REMAP;
 }
 
 static enum wc_map_op writecache_map_write(struct dm_writecache *wc, struct bio *bio)
@@ -1458,7 +1455,8 @@ static enum wc_map_op writecache_map_wri
 direct_write:
 				wc->stats.writes_around++;
 				e = writecache_find_entry(wc, bio->bi_iter.bi_sector, WFE_RETURN_FOLLOWING);
-				return writecache_map_remap_origin(wc, bio, e);
+				writecache_map_remap_origin(wc, bio, e);
+				return WC_MAP_REMAP_ORIGIN;
 			}
 			wc->stats.writes_blocked_on_freelist++;
 			writecache_wait_on_freelist(wc);
@@ -1469,10 +1467,12 @@ direct_write:
 		wc->uncommitted_blocks++;
 		wc->stats.writes_allocate++;
 bio_copy:
-		if (WC_MODE_PMEM(wc))
+		if (WC_MODE_PMEM(wc)) {
 			bio_copy_block(wc, bio, memory_data(wc, e));
-		else
-			return writecache_bio_copy_ssd(wc, bio, e, search_used);
+		} else {
+			writecache_bio_copy_ssd(wc, bio, e, search_used);
+			return WC_MAP_REMAP;
+		}
 	} while (bio->bi_iter.bi_size);
 
 	if (unlikely(bio->bi_opf & REQ_FUA || wc->uncommitted_blocks >= wc->autocommit_blocks))

