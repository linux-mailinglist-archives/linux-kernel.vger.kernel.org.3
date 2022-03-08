Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E04D25F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiCIBOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiCIBNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:13:48 -0500
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E6D15AF3E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:58:05 -0800 (PST)
Received: by mail-oi1-x249.google.com with SMTP id x15-20020a54400f000000b002d9be4bd8a2so716071oie.20
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Ho7f/NeezaNx/+VE1xEC1BmmHhvU/tXr7U8nm19Ny/8=;
        b=Kug63PWFYJQb+IwWw8YfG9c5gyFA/+YkOMbdO97VJcnY3F7XuGvLqV1qb6eKsstYC6
         fu8W4sy6PFGBz9UK+746zgHTSZVNYleA69c+Vq1TWk4/TU0EuK497e70zIiIOamehA0h
         Gr8W0c+sSHve+4eRxqrR5ljYMTvqacpM74fUU6qQ0A3IGEfMNnRqsozICggpkVL7/dY2
         AvgPNCEIzB1Ja/2nNKG0O2O9vsy6qG9DZgHVDhhRhmUleDNdAcGGbCYTbG8epYqydwO0
         gs5Tif4RsqE8crhUUYHOSkRUeNWcEXmkJs1SO+Rol7UpeJyHXqzn/uBhfzxuF7jaIr8/
         O7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Ho7f/NeezaNx/+VE1xEC1BmmHhvU/tXr7U8nm19Ny/8=;
        b=t4HvKu842SHGXwB26IKqe3oe5xBoMs10n6Z+RXIIWO5W1t6Pi0Nh0LD5iWhEYUREfI
         +xltbxWZDQcXaz082uvV+Lj1DQn5oSGS1pdiovUMrNB8dito528HR/PkULZFe7K32gsc
         KtE9NqPBu2/81SKMb8E8oW4rgA5rcUv/J8Tkj38zHzX3GehsLBbmcEZdd8pS1rNbqu0B
         ERq7ShRRfWBDLpEIxwcMig3GYmR7AX+uj4DXAypDDUXRxg2qSjzMwSf3ZCYn9W/XM+Fu
         7/sdiiZ+VBGgd522sVpxiFUiRFRKWV/BTWbOKmQI69nMlA6SvyuOXDavUKxSMjKD1XBp
         yBAw==
X-Gm-Message-State: AOAM533elqznhSBJdwloDzuFSZsg1/wHT3L5kHcwkImIe56PnYkMrchu
        k0fTPo3S7R5o1cIY2I4q0HkMvvViFBs=
X-Google-Smtp-Source: ABdhPJzM4xXQoy+k+mVLsuJXY9MtpV9RL7jteuvpZLDCBS3uEqNMbJUnHqoKnZ3hL+Nd69OrayRE4a4XWJk=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:57a6:54a6:aad1:c0a8])
 (user=yuzhao job=sendgmr) by 2002:a05:6808:1455:b0:2d9:a01a:4bbd with SMTP id
 x21-20020a056808145500b002d9a01a4bbdmr4227260oiv.228.1646783316883; Tue, 08
 Mar 2022 15:48:36 -0800 (PST)
Date:   Tue,  8 Mar 2022 16:47:19 -0700
In-Reply-To: <20220308234723.3834941-1-yuzhao@google.com>
Message-Id: <20220308234723.3834941-10-yuzhao@google.com>
Mime-Version: 1.0
References: <20220308234723.3834941-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v8 09/14] mm: multi-gen LRU: optimize multiple memcgs
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
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

