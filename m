Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12FC52B02C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiERBsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiERBrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:47:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D49354BF3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:47:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o7-20020a256b47000000b0064ddc3bea70so699172ybm.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=rNx9Wnnb2Q40MxJ2AB9/JnqJGMPM8zlMbTCpT3dj1BA=;
        b=f6Wu5/emDRNm3TYtxoLVModE1v2Mx1PvCfEpBOqsq/XlyHn9/UOOs77nvwwPtFVJq3
         qrFUkNi5NBLe/pBIYKRo2sd6wPItxq8wQFVlYmzUCfvI7M4regAPS6cdxxH6GbcyzC7s
         pKvcQC7KEQEotcCZ+1xkSH/D3SFaay9M2qrf6cUg4Gv0sWPkUyv6sWJH6O/1xx1wc7xX
         2wyH2dzmstBlBSK58XeKDFzZo/5XZ5e62feVsIhlFHehK8hd1JPDsPNJ9nzl/MZ070WZ
         9tiMBh18sOlIL8wH0W8wwikED9KXhFQkcZQxa6EH8aBNEeV+I1y+qJTYRmHLKtvRGLGZ
         WDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=rNx9Wnnb2Q40MxJ2AB9/JnqJGMPM8zlMbTCpT3dj1BA=;
        b=0RQ2/Xgd+tkN/YE6mwwMmVuwNTJT+BLzPzXfi74xRRrqKhjywFff2jwqfDrA83spZq
         nJblH2KKvRLZJhNfPVKWTzWpHgNzm35ycCgJUhY8Q0DQiggVjNCWVH2OwKYjxeGsg2To
         edqeLQKCGcBcMXGUiEdHc2yLIm8Fo1DOlbaG7KvMbNUt1L0EVTkv97yBgzLpgN52gsFS
         M/RBcsv06mqdcKw9aTdVPayNBkrI4JtjaifHSoVMLFu7b3A7rS+3VacFuzsUKncJRDQT
         d3qBfHpHlTYXFoPLz4H3OXBOuNAey8Mni7SmiXxBuRmGrCbTwDS7RDft2ELBVP6BA5Bo
         Yenw==
X-Gm-Message-State: AOAM532MTSyuUstySHwROs8Ib8+UlOF65N2FTnqOVBwtmySx38+bK4h8
        VgIofGSKRdyjMicFimWdmgg5oh1Gahk=
X-Google-Smtp-Source: ABdhPJw/GVYSFwqTPa9IB5eZEw8fBz/qkDDmWwgcQxKWC3IhU7UZHsf9NiWmIU8OqkuOn+EV5gSLDXe4G+Q=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:f7bc:90c9:d86e:4ea8])
 (user=yuzhao job=sendgmr) by 2002:a81:990f:0:b0:2f8:c347:d11a with SMTP id
 q15-20020a81990f000000b002f8c347d11amr28245783ywg.507.1652838429715; Tue, 17
 May 2022 18:47:09 -0700 (PDT)
Date:   Tue, 17 May 2022 19:46:30 -0600
In-Reply-To: <20220518014632.922072-1-yuzhao@google.com>
Message-Id: <20220518014632.922072-12-yuzhao@google.com>
Mime-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v11 11/14] mm: multi-gen LRU: thrashing prevention
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add /sys/kernel/mm/lru_gen/min_ttl_ms for thrashing prevention, as
requested by many desktop users [1].

When set to value N, it prevents the working set of N milliseconds
from getting evicted. The OOM killer is triggered if this working set
cannot be kept in memory. Based on the average human detectable lag
(~100ms), N=3D1000 usually eliminates intolerable lags due to thrashing.
Larger values like N=3D3000 make lags less noticeable at the risk of
premature OOM kills.

Compared with the size-based approach, e.g., [2], this time-based
approach has the following advantages:
1. It is easier to configure because it is agnostic to applications
   and memory sizes.
2. It is more reliable because it is directly wired to the OOM killer.

[1] https://lore.kernel.org/r/Ydza%2FzXKY9ATRoh6@google.com/
[2] https://lore.kernel.org/r/20101028191523.GA14972@google.com/

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
 include/linux/mmzone.h |  2 ++
 mm/vmscan.c            | 68 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 372a7f5a6829..b2e8869be7cf 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -421,6 +421,8 @@ struct lru_gen_struct {
 	unsigned long max_seq;
 	/* the eviction increments the oldest generation numbers */
 	unsigned long min_seq[ANON_AND_FILE];
+	/* the birth time of each generation in jiffies */
+	unsigned long timestamps[MAX_NR_GENS];
 	/* the multi-gen LRU lists */
 	struct list_head lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* the sizes of the above lists */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 09e2c3e6f2be..823c55e17e64 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4159,6 +4159,7 @@ static void inc_max_seq(struct lruvec *lruvec, bool c=
an_swap)
 	for (type =3D 0; type < ANON_AND_FILE; type++)
 		reset_ctrl_pos(lruvec, type, false);
=20
+	WRITE_ONCE(lrugen->timestamps[next], jiffies);
 	/* make sure preceding modifications appear */
 	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
=20
@@ -4281,7 +4282,8 @@ static long get_nr_evictable(struct lruvec *lruvec, u=
nsigned long max_seq,
 	return total > 0 ? total : 0;
 }
=20
-static void age_lruvec(struct lruvec *lruvec, struct scan_control *sc)
+static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc,
+		       unsigned long min_ttl)
 {
 	bool need_aging;
 	long nr_to_scan;
@@ -4292,14 +4294,22 @@ static void age_lruvec(struct lruvec *lruvec, struc=
t scan_control *sc)
=20
 	VM_WARN_ON_ONCE(sc->memcg_low_reclaim);
=20
+	if (min_ttl) {
+		int gen =3D lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
+		unsigned long birth =3D READ_ONCE(lruvec->lrugen.timestamps[gen]);
+
+		if (time_is_after_jiffies(birth + min_ttl))
+			return false;
+	}
+
 	mem_cgroup_calculate_protection(NULL, memcg);
=20
 	if (mem_cgroup_below_min(memcg))
-		return;
+		return false;
=20
 	nr_to_scan =3D get_nr_evictable(lruvec, max_seq, min_seq, swappiness, &ne=
ed_aging);
 	if (!nr_to_scan)
-		return;
+		return false;
=20
 	nr_to_scan >>=3D sc->priority;
=20
@@ -4308,11 +4318,18 @@ static void age_lruvec(struct lruvec *lruvec, struc=
t scan_control *sc)
=20
 	if (nr_to_scan && need_aging)
 		try_to_inc_max_seq(lruvec, max_seq, sc, swappiness);
+
+	return true;
 }
=20
+/* to protect the working set of the last N jiffies */
+static unsigned long lru_gen_min_ttl __read_mostly;
+
 static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_contro=
l *sc)
 {
 	struct mem_cgroup *memcg;
+	bool success =3D false;
+	unsigned long min_ttl =3D READ_ONCE(lru_gen_min_ttl);
=20
 	VM_WARN_ON_ONCE(!current_is_kswapd());
=20
@@ -4338,12 +4355,28 @@ static void lru_gen_age_node(struct pglist_data *pg=
dat, struct scan_control *sc)
 	do {
 		struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
=20
-		age_lruvec(lruvec, sc);
+		if (age_lruvec(lruvec, sc, min_ttl))
+			success =3D true;
=20
 		cond_resched();
 	} while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)));
=20
 	current->reclaim_state->mm_walk =3D NULL;
+
+	/*
+	 * The main goal is to OOM kill if every generation from all memcgs is
+	 * younger than min_ttl. However, another theoretical possibility is all
+	 * memcgs are either below min or empty.
+	 */
+	if (!success && !sc->order && mutex_trylock(&oom_lock)) {
+		struct oom_control oc =3D {
+			.gfp_mask =3D sc->gfp_mask,
+		};
+
+		out_of_memory(&oc);
+
+		mutex_unlock(&oom_lock);
+	}
 }
=20
 /*
@@ -5062,6 +5095,28 @@ static void lru_gen_change_state(bool enable)
  *                          sysfs interface
  *************************************************************************=
*****/
=20
+static ssize_t show_min_ttl(struct kobject *kobj, struct kobj_attribute *a=
ttr, char *buf)
+{
+	return sprintf(buf, "%u\n", jiffies_to_msecs(READ_ONCE(lru_gen_min_ttl)))=
;
+}
+
+static ssize_t store_min_ttl(struct kobject *kobj, struct kobj_attribute *=
attr,
+			     const char *buf, size_t len)
+{
+	unsigned int msecs;
+
+	if (kstrtouint(buf, 0, &msecs))
+		return -EINVAL;
+
+	WRITE_ONCE(lru_gen_min_ttl, msecs_to_jiffies(msecs));
+
+	return len;
+}
+
+static struct kobj_attribute lru_gen_min_ttl_attr =3D __ATTR(
+	min_ttl_ms, 0644, show_min_ttl, store_min_ttl
+);
+
 static ssize_t show_enable(struct kobject *kobj, struct kobj_attribute *at=
tr, char *buf)
 {
 	unsigned int caps =3D 0;
@@ -5110,6 +5165,7 @@ static struct kobj_attribute lru_gen_enabled_attr =3D=
 __ATTR(
 );
=20
 static struct attribute *lru_gen_attrs[] =3D {
+	&lru_gen_min_ttl_attr.attr,
 	&lru_gen_enabled_attr.attr,
 	NULL
 };
@@ -5125,12 +5181,16 @@ static struct attribute_group lru_gen_attr_group =
=3D {
=20
 void lru_gen_init_lruvec(struct lruvec *lruvec)
 {
+	int i;
 	int gen, type, zone;
 	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
=20
 	lrugen->max_seq =3D MIN_NR_GENS + 1;
 	lrugen->enabled =3D lru_gen_enabled();
=20
+	for (i =3D 0; i <=3D MIN_NR_GENS + 1; i++)
+		lrugen->timestamps[i] =3D jiffies;
+
 	for_each_gen_type_zone(gen, type, zone)
 		INIT_LIST_HEAD(&lrugen->lists[gen][type][zone]);
=20
--=20
2.36.0.550.gb090851708-goog

