Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374EB52B026
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiERBrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiERBrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:47:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2D554BDF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:47:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fefb9975c5so7807467b3.21
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=4FeaUrAcLPRNiyzpAHQ0qcCXUD7YXoCTIslsK0eD41Y=;
        b=fY1LqfrKQ18+zKLGy9WAd1jhk4VwDPAd0IP4P/GayWs6ndMf1nwMh8ZeYcvmBvuQ86
         GpQQbyLBSjF23S7zqVvGdVp+NhPNYUcEUibP9bZO93rvR/t4RaRptXl2EOOp6+M7siuk
         yyRO+Wl6PuJWn7Xwhyh8gZ85CQPKMf/I/wBMMl0V/SycgsCafQq1iRHTvJ9moWxQmf46
         rZyxEQjVEhddig/3bxo3Z7eq6tArA9FnKVE89X+ECO3qXcalVE8q0pmjvTzgQoZD9u8Y
         1jNa9K1p0P9tENosGYdbO0KFHBjCCY+zlhZh6sG36xX4v5+dFYKBdKat1qNZevsdhVt/
         sD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=4FeaUrAcLPRNiyzpAHQ0qcCXUD7YXoCTIslsK0eD41Y=;
        b=Yctb6Ps7fdFFAgc75u2RI9XzpoxoE6nBCjDe2PfaL+GQl5xyrQ/j8n6JmTEI+12sR3
         aMJlJstWA4S8ko7DgHVpbZmFX5gWVXHu3vYlymy4ejTbSL7ULwMxIgz8XzOXVuL46uaX
         ZO8Zp1Gp/j/5Lxb7wDR5HzsLcmvcWRhStNJSonFb1Em6d99AQ1UJNnjG7YSJP0/w+xEW
         gRPscXVFQpKJcssgW8P+izH/NIQjNWduzMog04HMMmVSHqcgneqR5paO90iRQnxNwvfI
         9RIKx9GbWdLBGVSK4I3GzOOTNJb+DhjdEPwj6rLOACDZMRt1JhjlFD0jeXogPymF3TMX
         n7Lg==
X-Gm-Message-State: AOAM530x//URpklhvvgeII6Ddh4AVfYXNL9+08kP/K+f1Cj6UInXfaTE
        Qg0GNcNLYeJd8+ixOqnSEdh+xxymM1U=
X-Google-Smtp-Source: ABdhPJxuNk1xSGxsu2QLdajUUp4vZke7U/gS7MXlBwFIqZvnz7q0GxTwsMzXdo4nRCJXJA5BHFLhn+OxTdg=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:f7bc:90c9:d86e:4ea8])
 (user=yuzhao job=sendgmr) by 2002:a81:2684:0:b0:2f8:46f4:7c6d with SMTP id
 m126-20020a812684000000b002f846f47c6dmr30129509ywm.444.1652838427172; Tue, 17
 May 2022 18:47:07 -0700 (PDT)
Date:   Tue, 17 May 2022 19:46:28 -0600
In-Reply-To: <20220518014632.922072-1-yuzhao@google.com>
Message-Id: <20220518014632.922072-10-yuzhao@google.com>
Mime-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v11 09/14] mm: multi-gen LRU: optimize multiple memcgs
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index f292e7e761b1..a7e768675707 100644
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
@@ -4290,6 +4297,22 @@ static void lru_gen_age_node(struct pglist_data *pgd=
at, struct scan_control *sc)
=20
 	VM_WARN_ON_ONCE(!current_is_kswapd());
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
@@ -4699,7 +4722,8 @@ static int isolate_folios(struct lruvec *lruvec, stru=
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
@@ -4765,6 +4789,9 @@ static int evict_folios(struct lruvec *lruvec, struct=
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
@@ -4793,8 +4820,10 @@ static long get_nr_to_scan(struct lruvec *lruvec, st=
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
@@ -4816,6 +4845,8 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruv=
ec, struct scan_control *sc
 {
 	struct blk_plug plug;
 	long scanned =3D 0;
+	bool swapped =3D false;
+	unsigned long reclaimed =3D sc->nr_reclaimed;
 	struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
=20
 	lru_add_drain();
@@ -4841,13 +4872,19 @@ static void lru_gen_shrink_lruvec(struct lruvec *lr=
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
2.36.0.550.gb090851708-goog

