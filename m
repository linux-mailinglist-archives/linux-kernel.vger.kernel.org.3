Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC184F72F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbiDGDTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbiDGDS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:18:27 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF19DFDD4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:16:11 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id x6-20020a923006000000b002bea39c3974so2975097ile.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=/BTpyTC3BWITVgtzyo3yWI9ScJ2B23IF80HP+e4RTLs=;
        b=B+qgdKxMWufdOBeUFvxfs40yxRQ7wr/nUoKevP6v/dym/GHDI4umWm7dakxK+KMyIG
         pKTbn9qM+ALlw0LJ4lXKe+uPjIn7kNg442HN2penNhVKqSwWJlTgxh2R//+4KwhK4KTy
         jBR9nB940pfXEwDgg+3Ua63sSMFkbj3UMgy3/VYHTw/jYgQ6u70mJLUanJ/RVtfBv/NM
         t6pqlQjzQ7a/X2eGtAf+2IQbpPwTu3rMFj1QeOYxKx8t2DFExeZSyJy8pVs9Le8/4hQr
         Am4uio9JdJDvzBecumGJ552H6Pho70P2bDeqOopqV7jw9A5CayyaMPT3Xdu30OuCXenz
         PeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=/BTpyTC3BWITVgtzyo3yWI9ScJ2B23IF80HP+e4RTLs=;
        b=SieC+u6//aQ+dO8jHBgGYK3SBqEgsuG6zMCiO0AcZhcSPLvsAYbF4yDm6T+COpI9Bd
         bErARctGUFyz0Iqt9KfwATUgGeC/wWXtuxakdp99Q/Qp8oYXz3ajWRVWPfNwgBOkvkah
         m7XcTmvYIgHtuYpQluMf1lfVw3K3OTNsKywh1PkVr6zwKkDs3myOyuIEVKeci5me1ijS
         xaWZ83CGx0HZnEeYLIG2IukeqaqWrJ3jvNRvyreJMliuX6Z9bezOCFl8xKH6PWRpOXG2
         8N8BUxLxSEEK6G788hC+rDzmbNHgKSdlBhWFQFQTefGuG5zt6f+3h8ZLzersLyY9ella
         cUKw==
X-Gm-Message-State: AOAM532fNTAkchKr+tXuiAzarX8vfDX/UWokQDHdpuplVWwhMOezQz5z
        92dMQMnx+H8IY9bvFFnPGvPmV1DRAz4=
X-Google-Smtp-Source: ABdhPJy3glMkK9W/PAxRI8gGi5IapTHMDsOIhIIaou07CiFi6H6ib0unmvM/k4dP33swU+zixbfwt7mVghs=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:9ea2:c755:ae22:6862])
 (user=yuzhao job=sendgmr) by 2002:a05:6638:d88:b0:322:e0cf:cf8e with SMTP id
 l8-20020a0566380d8800b00322e0cfcf8emr6265712jaj.171.1649301370401; Wed, 06
 Apr 2022 20:16:10 -0700 (PDT)
Date:   Wed,  6 Apr 2022 21:15:21 -0600
In-Reply-To: <20220407031525.2368067-1-yuzhao@google.com>
Message-Id: <20220407031525.2368067-10-yuzhao@google.com>
Mime-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v10 09/14] mm: multi-gen LRU: optimize multiple memcgs
From:   Yu Zhao <yuzhao@google.com>
To:     Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Yu Zhao <yuzhao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        "=?UTF-8?q?Holger=20Hoffst=C3=A4tte?=" 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple memcgs are available, it is possible to make better
choices based on generations and tiers and therefore improve the
overall performance under global memory pressure. This patch adds a
rudimentary optimization to select memcgs that can drop single-use
unmapped clean pages first. Doing so reduces the chance of going into
the aging path or swapping. These two operations can be costly.

A typical example that benefits from this optimization is a server
running mixed types of workloads, e.g., heavy anon workload in one
memcg and heavy buffered I/O workload in the other.

Though this optimization can be applied to both kswapd and direct
reclaim, it is only added to kswapd to keep the patchset manageable.
Later improvements will cover the direct reclaim path.

Server benchmark results:
  Mixed workloads:
    fio (buffered I/O): +[1, 3]%
                IOPS         BW
      patch1-8: 2154k        8415MiB/s
      patch1-9: 2205k        8613MiB/s

    memcached (anon): +[132, 136]%
                Ops/sec      KB/sec
      patch1-8: 819618.49    31838.48
      patch1-9: 1916516.06   74447.92

  Mixed workloads:
    fio (buffered I/O): +[59, 61]%
                IOPS         BW
      5.18-rc1: 1378k        5385MiB/s
      patch1-9: 2205k        8613MiB/s

    memcached (anon): +[229, 233]%
                Ops/sec      KB/sec
      5.18-rc1: 578946.00    22489.44
      patch1-9: 1916516.06   74447.92

  Configurations:
    (changes since patch 6)

    cat mixed.sh
    modprobe brd rd_nr=3D2 rd_size=3D56623104

    swapoff -a
    mkswap /dev/ram0
    swapon /dev/ram0

    mkfs.ext4 /dev/ram1
    mount -t ext4 /dev/ram1 /mnt

    memtier_benchmark -S /var/run/memcached/memcached.sock \
      -P memcache_binary -n allkeys --key-minimum=3D1 \
      --key-maximum=3D50000000 --key-pattern=3DP:P -c 1 -t 36 \
      --ratio 1:0 --pipeline 8 -d 2000

    fio -name=3Dmglru --numjobs=3D36 --directory=3D/mnt --size=3D1408m \
      --buffered=3D1 --ioengine=3Dio_uring --iodepth=3D128 \
      --iodepth_batch_submit=3D32 --iodepth_batch_complete=3D32 \
      --rw=3Drandread --random_distribution=3Drandom --norandommap \
      --time_based --ramp_time=3D10m --runtime=3D90m --group_reporting &
    pid=3D$!

    sleep 200

    memtier_benchmark -S /var/run/memcached/memcached.sock \
      -P memcache_binary -n allkeys --key-minimum=3D1 \
      --key-maximum=3D50000000 --key-pattern=3DR:R -c 1 -t 36 \
      --ratio 0:1 --pipeline 8 --randomize --distinct-client-seed

    kill -INT $pid
    wait

Client benchmark results:
  no change (CONFIG_MEMCG=3Dn)

Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Brian Geffon <bgeffon@google.com>
Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Acked-by: Steven Barrett <steven@liquorix.net>
Acked-by: Suleiman Souhlal <suleiman@google.com>
Tested-by: Daniel Byrne <djbyrne@mtu.edu>
Tested-by: Donald Carr <d@chaos-reins.com>
Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
Tested-by: Sofia Trinh <sofia.trinh@edi.works>
Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 mm/vmscan.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9e2810a230a4..0663f1a3f72a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -128,6 +128,13 @@ struct scan_control {
 	/* Always discard instead of demoting to lower tier memory */
 	unsigned int no_demotion:1;
=20
+#ifdef CONFIG_LRU_GEN
+	/* help make better choices when multiple memcgs are available */
+	unsigned int memcgs_need_aging:1;
+	unsigned int memcgs_need_swapping:1;
+	unsigned int memcgs_avoid_swapping:1;
+#endif
+
 	/* Allocation order */
 	s8 order;
=20
@@ -4309,6 +4316,22 @@ static void lru_gen_age_node(struct pglist_data *pgd=
at, struct scan_control *sc)
=20
 	VM_BUG_ON(!current_is_kswapd());
=20
+	/*
+	 * To reduce the chance of going into the aging path or swapping, which
+	 * can be costly, optimistically skip them unless their corresponding
+	 * flags were cleared in the eviction path. This improves the overall
+	 * performance when multiple memcgs are available.
+	 */
+	if (!sc->memcgs_need_aging) {
+		sc->memcgs_need_aging =3D true;
+		sc->memcgs_avoid_swapping =3D !sc->memcgs_need_swapping;
+		sc->memcgs_need_swapping =3D true;
+		return;
+	}
+
+	sc->memcgs_need_swapping =3D true;
+	sc->memcgs_avoid_swapping =3D true;
+
 	current->reclaim_state->mm_walk =3D &pgdat->mm_walk;
=20
 	memcg =3D mem_cgroup_iter(NULL, NULL, NULL);
@@ -4714,7 +4737,8 @@ static int isolate_folios(struct lruvec *lruvec, stru=
ct scan_control *sc, int sw
 	return scanned;
 }
=20
-static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, in=
t swappiness)
+static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, in=
t swappiness,
+			bool *swapped)
 {
 	int type;
 	int scanned;
@@ -4780,6 +4804,9 @@ static int evict_folios(struct lruvec *lruvec, struct=
 scan_control *sc, int swap
=20
 	sc->nr_reclaimed +=3D reclaimed;
=20
+	if (type =3D=3D LRU_GEN_ANON && swapped)
+		*swapped =3D true;
+
 	return scanned;
 }
=20
@@ -4808,8 +4835,10 @@ static long get_nr_to_scan(struct lruvec *lruvec, st=
ruct scan_control *sc, bool
 	if (!nr_to_scan)
 		return 0;
=20
-	if (!need_aging)
+	if (!need_aging) {
+		sc->memcgs_need_aging =3D false;
 		return nr_to_scan;
+	}
=20
 	/* leave the work to lru_gen_age_node() */
 	if (current_is_kswapd())
@@ -4831,6 +4860,8 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruv=
ec, struct scan_control *sc
 {
 	struct blk_plug plug;
 	long scanned =3D 0;
+	bool swapped =3D false;
+	unsigned long reclaimed =3D sc->nr_reclaimed;
 	struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
=20
 	lru_add_drain();
@@ -4856,13 +4887,19 @@ static void lru_gen_shrink_lruvec(struct lruvec *lr=
uvec, struct scan_control *sc
 		if (!nr_to_scan)
 			break;
=20
-		delta =3D evict_folios(lruvec, sc, swappiness);
+		delta =3D evict_folios(lruvec, sc, swappiness, &swapped);
 		if (!delta)
 			break;
=20
+		if (sc->memcgs_avoid_swapping && swappiness < 200 && swapped)
+			break;
+
 		scanned +=3D delta;
-		if (scanned >=3D nr_to_scan)
+		if (scanned >=3D nr_to_scan) {
+			if (!swapped && sc->nr_reclaimed - reclaimed >=3D MIN_LRU_BATCH)
+				sc->memcgs_need_swapping =3D false;
 			break;
+		}
=20
 		cond_resched();
 	}
--=20
2.35.1.1094.g7c7d902a7c-goog

