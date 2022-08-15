Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F155C592A39
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbiHOHPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiHOHPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:15:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F601CFDF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:14:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j130-20020a252388000000b0067c1f731317so5376175ybj.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=5eUro1Ys65PlYEqsgNKi16f/oPtNjC98bqZv1yckg04=;
        b=EB8amhRSjr6akZtRJpJd3EbVK5+m7OZimLU3f1TX6110F1KqnW4WpnJt8XFow2IRTP
         ZblIfviXz3UrCUCTrYg8On2uNDBjJtniWRX9QYBRMli1hFiVLZAFh4YA+S05Qi39c0xT
         Dzyv9cBuHv3M3cs9EPK2CtKrtnT9L9flJv91JwQv6yjUmMNFsc1BxLVGdxgalAJNNa4U
         ldMrM1RlDpTthS9li0XcUfSpz/6FwY1aPtZVbwsG8YI4+2wHqpjOUZ8BFUBdnGxyij4I
         QkOgsdGdwTSfzBuS31n/8w9gh5PpaY3vWxvDvWrjMIivtuWaExuM/ADamWAlrYjHYE5x
         nujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=5eUro1Ys65PlYEqsgNKi16f/oPtNjC98bqZv1yckg04=;
        b=vN6+CT1j8SjuB/n6w/oRogX7ZupBJEwSK/MCrg9KPrKapeihLIdmzTRBHEq7bnfeDH
         d9RwlsxVL1AGYyD6mzlt6l3fyDwY/56kBoiQkkoWymq8t46k7hjSwsXZX9VCTPHryRHK
         LhB+UPCby7DmWaWcYc5Zxs5K5rK369algdv5wNO4hpXAqqyOlk6D+zKC0spG0YAymTXz
         Kzo1KbMXpzKDp6cnFmAW212GXxCTLiv4tXWLWVPxCxMsI1XbwFTID22mUueEscy6ZJQQ
         nCK23tBhqOJbNOaAfZeGafSCHWjBqqgwPYMZcAuvmlUhI+J0pJd2FQGE1YLowCh6LutF
         RCUQ==
X-Gm-Message-State: ACgBeo0/cN64uGrYNAyx1a23Jj2sexBKWUkUty6rW+1ZbYCVNPHQNOx2
        rzk8K4rytRYuDxa2NeIS74kuyRxOUIU=
X-Google-Smtp-Source: AA6agR669YNMXgcKgGcmGvzMJKETmvy/CAH14Ch6T2S9fJbFuil9iZjGHFjOhKoiLRsskelSJ4q76RDP/iM=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:d91:5887:ac93:ddf0])
 (user=yuzhao job=sendgmr) by 2002:a81:1206:0:b0:32f:ecac:f0f with SMTP id
 6-20020a811206000000b0032fecac0f0fmr5286066yws.495.1660547666940; Mon, 15 Aug
 2022 00:14:26 -0700 (PDT)
Date:   Mon, 15 Aug 2022 01:13:28 -0600
In-Reply-To: <20220815071332.627393-1-yuzhao@google.com>
Message-Id: <20220815071332.627393-10-yuzhao@google.com>
Mime-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v14 09/14] mm: multi-gen LRU: optimize multiple memcgs
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
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
the aging path or swapping. These two decisions can be costly.

A typical example that benefits from this optimization is a server
running mixed types of workloads, e.g., heavy anon workload in one
memcg and heavy buffered I/O workload in the other.

Though this optimization can be applied to both kswapd and direct
reclaim, it is only added to kswapd to keep the patchset manageable.
Later improvements will cover the direct reclaim path.

Server benchmark results:
  Mixed workloads:
    fio (buffered I/O): +[19, 21]%
                IOPS         BW
      patch1-8: 1880k        7343MiB/s
      patch1-9: 2252k        8796MiB/s

    memcached (anon): +[119, 123]%
                Ops/sec      KB/sec
      patch1-8: 862768.65    33514.68
      patch1-9: 1911022.12   74234.54

  Mixed workloads:
    fio (buffered I/O): +[75, 77]%
                IOPS         BW
      5.19-rc1: 1279k        4996MiB/s
      patch1-9: 2252k        8796MiB/s

    memcached (anon): +[13, 15]%
                Ops/sec      KB/sec
      5.19-rc1: 1673524.04   65008.87
      patch1-9: 1911022.12   74234.54

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
 mm/vmscan.c | 55 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d1dfc0a77b6f..ee51c752a3af 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -131,6 +131,13 @@ struct scan_control {
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
@@ -4437,6 +4444,22 @@ static void lru_gen_age_node(struct pglist_data *pgd=
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
 	set_mm_walk(pgdat);
=20
 	memcg =3D mem_cgroup_iter(NULL, NULL, NULL);
@@ -4846,7 +4869,8 @@ static int isolate_folios(struct lruvec *lruvec, stru=
ct scan_control *sc, int sw
 	return scanned;
 }
=20
-static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, in=
t swappiness)
+static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, in=
t swappiness,
+			bool *need_swapping)
 {
 	int type;
 	int scanned;
@@ -4909,6 +4933,9 @@ static int evict_folios(struct lruvec *lruvec, struct=
 scan_control *sc, int swap
=20
 	sc->nr_reclaimed +=3D reclaimed;
=20
+	if (type =3D=3D LRU_GEN_ANON && need_swapping)
+		*need_swapping =3D true;
+
 	return scanned;
 }
=20
@@ -4918,10 +4945,9 @@ static int evict_folios(struct lruvec *lruvec, struc=
t scan_control *sc, int swap
  *    reclaim.
  */
 static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_con=
trol *sc,
-				    bool can_swap, unsigned long reclaimed)
+				    bool can_swap, unsigned long reclaimed, bool *need_aging)
 {
 	int priority;
-	bool need_aging;
 	unsigned long nr_to_scan;
 	struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
@@ -4936,7 +4962,7 @@ static unsigned long get_nr_to_scan(struct lruvec *lr=
uvec, struct scan_control *
 	    (mem_cgroup_below_low(memcg) && !sc->memcg_low_reclaim))
 		return 0;
=20
-	nr_to_scan =3D get_nr_evictable(lruvec, max_seq, min_seq, can_swap, &need=
_aging);
+	nr_to_scan =3D get_nr_evictable(lruvec, max_seq, min_seq, can_swap, need_=
aging);
 	if (!nr_to_scan)
 		return 0;
=20
@@ -4952,7 +4978,7 @@ static unsigned long get_nr_to_scan(struct lruvec *lr=
uvec, struct scan_control *
 	if (!nr_to_scan)
 		return 0;
=20
-	if (!need_aging)
+	if (!*need_aging)
 		return nr_to_scan;
=20
 	/* skip the aging path at the default priority */
@@ -4972,6 +4998,8 @@ static unsigned long get_nr_to_scan(struct lruvec *lr=
uvec, struct scan_control *
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_contr=
ol *sc)
 {
 	struct blk_plug plug;
+	bool need_aging =3D false;
+	bool need_swapping =3D false;
 	unsigned long scanned =3D 0;
 	unsigned long reclaimed =3D sc->nr_reclaimed;
=20
@@ -4993,21 +5021,30 @@ static void lru_gen_shrink_lruvec(struct lruvec *lr=
uvec, struct scan_control *sc
 		else
 			swappiness =3D 0;
=20
-		nr_to_scan =3D get_nr_to_scan(lruvec, sc, swappiness, reclaimed);
+		nr_to_scan =3D get_nr_to_scan(lruvec, sc, swappiness, reclaimed, &need_a=
ging);
 		if (!nr_to_scan)
-			break;
+			goto done;
=20
-		delta =3D evict_folios(lruvec, sc, swappiness);
+		delta =3D evict_folios(lruvec, sc, swappiness, &need_swapping);
 		if (!delta)
-			break;
+			goto done;
=20
 		scanned +=3D delta;
 		if (scanned >=3D nr_to_scan)
 			break;
=20
+		if (sc->memcgs_avoid_swapping && swappiness < 200 && need_swapping)
+			break;
+
 		cond_resched();
 	}
=20
+	/* see the comment in lru_gen_age_node() */
+	if (!need_aging)
+		sc->memcgs_need_aging =3D false;
+	if (!need_swapping)
+		sc->memcgs_need_swapping =3D false;
+done:
 	clear_mm_walk();
=20
 	blk_finish_plug(&plug);
--=20
2.37.1.595.g718a3a8f04-goog

