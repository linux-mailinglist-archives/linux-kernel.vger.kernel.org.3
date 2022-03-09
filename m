Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BCD4D2678
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiCICPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiCICOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:14:45 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B80C1EC49
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:13:37 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d81518795fso6742187b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 18:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Ho7f/NeezaNx/+VE1xEC1BmmHhvU/tXr7U8nm19Ny/8=;
        b=f2iGsd8KLjTvdwnOU/PaF5BcBUzgaJCYEFsor5ChQ74EYHdncuokZb7J/i3hhv5Oxb
         DSBoI9zMy3M4fQQ1HRx+Lz2YFXJxjPeJUIaEgfGQTpWm4OR33tb/qEHyvHX8+ZFz0/Kh
         qqZv8mK/lmSDx5zxzc7wBqknu9swMndCZNzcMkBV9eVJekGPEzqsnUQe23uo/NaOF+xd
         esIUJnzrNowZIn2Yh8WOTW8sep4Vcs3fF8r+vsb8CsZ7mzefcXI4g3CmlAOKHtwtEgh8
         I5/Qx5+IdrzM8UDRLOWJZkd1dAdogb6Y0WFHITEzaP0RnKKEh5drH1AB+wk1gtzoSu/7
         hATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Ho7f/NeezaNx/+VE1xEC1BmmHhvU/tXr7U8nm19Ny/8=;
        b=WSzYquuKD2FUrT5JZZwfmdzz0CTGCLGW87/h/I+JftjTIzoRaoM72njsZmXfap5dtf
         adW4wo78dE8wyNqS5JcWB9Pc2niS+z9SEkW6Q+qDXUJKlyaKbpR3T1NCK7mC+cW4L+kx
         9kjxR9F01mq/uPeZIyxxuOsPm0TEbgKa+iASJk997t+xYF9q3GhHPmAr7qC0Okpq2uVH
         fAQNrCgTlmWewVHRjozfTcJ/dcKWzd+NjuMrFgxYVNrq+7Ny7gjkXMEK6d27AzKAJkqZ
         C2pCjgkcG80CFHn6zomY4uCw+xQdztefXN8Ik53y/HWcBr6UG3TET05UUPWKSb157khk
         9YtQ==
X-Gm-Message-State: AOAM530XCxtBZIMmratiwvPxpukysUKnRvLHSrLGW5A8MISdUdRtKZHw
        +LxSAgyzSxyAODwUwlmsMsXEkUBg454=
X-Google-Smtp-Source: ABdhPJwnzAqhA+7g3z8XaNpxTjAGR8VoCQrruUgnn2QDkQcElVOONx450D5zSNJq2q47uQ4auOAsOQN5UI4=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:57a6:54a6:aad1:c0a8])
 (user=yuzhao job=sendgmr) by 2002:a81:f10f:0:b0:2d6:935e:c3f8 with SMTP id
 h15-20020a81f10f000000b002d6935ec3f8mr15858441ywm.325.1646792016423; Tue, 08
 Mar 2022 18:13:36 -0800 (PST)
Date:   Tue,  8 Mar 2022 19:12:26 -0700
In-Reply-To: <20220309021230.721028-1-yuzhao@google.com>
Message-Id: <20220309021230.721028-10-yuzhao@google.com>
Mime-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v9 09/14] mm: multi-gen LRU: optimize multiple memcgs
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>, Brian Geffon <bgeffon@google.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
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
    fio (buffered I/O): -[28, 30]%
                IOPS         BW
      patch1-7: 3117k        11.9GiB/s
      patch1-8: 2217k        8661MiB/s

    memcached (anon): +[247, 251]%
                Ops/sec      KB/sec
      patch1-7: 563772.35    21900.01
      patch1-8: 1968343.76   76461.24

  Mixed workloads:
    fio (buffered I/O): -[4, 6]%
                IOPS         BW
      5.17-rc2: 2338k        9133MiB/s
      patch1-8: 2217k        8661MiB/s

    memcached (anon): +[524, 530]%
                Ops/sec      KB/sec
      5.17-rc2: 313821.65    12190.55
      patch1-8: 1968343.76   76461.24

  Configurations:
    (changes since patch 5)

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
index 67dc4190e790..7375c9dae08f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -127,6 +127,13 @@ struct scan_control {
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
@@ -4348,6 +4355,22 @@ static void lru_gen_age_node(struct pglist_data *pgd=
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
@@ -4750,7 +4773,8 @@ static int isolate_folios(struct lruvec *lruvec, stru=
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
@@ -4816,6 +4840,9 @@ static int evict_folios(struct lruvec *lruvec, struct=
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
@@ -4844,8 +4871,10 @@ static long get_nr_to_scan(struct lruvec *lruvec, st=
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
@@ -4867,6 +4896,8 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruv=
ec, struct scan_control *sc
 {
 	struct blk_plug plug;
 	long scanned =3D 0;
+	bool swapped =3D false;
+	unsigned long reclaimed =3D sc->nr_reclaimed;
 	struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
=20
 	lru_add_drain();
@@ -4892,13 +4923,19 @@ static void lru_gen_shrink_lruvec(struct lruvec *lr=
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
2.35.1.616.g0bdcbb4464-goog

