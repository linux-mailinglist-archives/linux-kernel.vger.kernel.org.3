Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD256836E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiGFJTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGFJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:19:16 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFAD14D05
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:19:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LdDVV0D49zl1Vt
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 17:18:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgAXemmNU8VihkO+AQ--.22758S4;
        Wed, 06 Jul 2022 17:19:11 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        mpatocka@redhat.com
Cc:     linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH] dm writecache: fix inaccurate reads/writes stats
Date:   Wed,  6 Jul 2022 17:31:46 +0800
Message-Id: <20220706093146.1961598-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAXemmNU8VihkO+AQ--.22758S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw43uFy3AFyrJrW8XFWxCrg_yoW5WFW8pF
        Z7Jr15Gr1SvF47WwsrAa4UWa4FyayDJasFq347G3yxuF1DAwnxCFWUWFy2yF40qr97uFW3
        AF4DKrW8CryjyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Test procedures:

1) format a dm writecache device with 4k blocksize.
2) flush cache.
3) cache 1G data through write.
4) clear stats.
5) read 2G data with bs=1m.
6) read stats.

Expected result:
cache hit ratio is 50%.

Test result:
stats: 0, 1011345, 749201, 0, 263168, 262144, 0, 0, 0, 0, 0, 0, 0, 0
ratio is 99% (262144/263168)

The way that reads is accounted is different between cache hit and cache
miss:

1) If cache hit, reads will be accounted for each entry, which means reads
and read_hits will both increase 256 for each io in the above test.

2) If cache miss, reads will only account once, which means reads will only
increase 1 for each io in the above test.

The case that writes_around has the same problem, fix it by adding
appropriate reads/writes in writecache_map_remap_origin().

Fixes: e3a35d03407c ("dm writecache: add event counters")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-writecache.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index d74c5a7a0ab4..c2c6c3a023dd 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1329,16 +1329,29 @@ enum wc_map_op {
 	WC_MAP_ERROR,
 };
 
-static enum wc_map_op writecache_map_remap_origin(struct dm_writecache *wc, struct bio *bio,
-						  struct wc_entry *e)
+static enum wc_map_op writecache_map_remap_origin(struct dm_writecache *wc,
+						  struct bio *bio,
+						  struct wc_entry *e, bool read)
 {
+	sector_t next_boundary;
+	unsigned long long miss_count;
+
 	if (e) {
-		sector_t next_boundary =
+		next_boundary =
 			read_original_sector(wc, e) - bio->bi_iter.bi_sector;
 		if (next_boundary < bio->bi_iter.bi_size >> SECTOR_SHIFT)
 			dm_accept_partial_bio(bio, next_boundary);
+	} else {
+		next_boundary = bio->bi_iter.bi_size;
 	}
 
+	miss_count = (round_up(next_boundary, wc->block_size) >>
+			wc->block_size_bits) - 1;
+	if (read)
+		wc->stats.reads += miss_count;
+	else
+		wc->stats.writes += miss_count;
+
 	return WC_MAP_REMAP_ORIGIN;
 }
 
@@ -1366,7 +1379,7 @@ static enum wc_map_op writecache_map_read(struct dm_writecache *wc, struct bio *
 			map_op = WC_MAP_REMAP;
 		}
 	} else {
-		map_op = writecache_map_remap_origin(wc, bio, e);
+		map_op = writecache_map_remap_origin(wc, bio, e, true);
 	}
 
 	return map_op;
@@ -1458,7 +1471,8 @@ static enum wc_map_op writecache_map_write(struct dm_writecache *wc, struct bio
 direct_write:
 				wc->stats.writes_around++;
 				e = writecache_find_entry(wc, bio->bi_iter.bi_sector, WFE_RETURN_FOLLOWING);
-				return writecache_map_remap_origin(wc, bio, e);
+				return writecache_map_remap_origin(wc, bio, e,
+								   false);
 			}
 			wc->stats.writes_blocked_on_freelist++;
 			writecache_wait_on_freelist(wc);
-- 
2.31.1

