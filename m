Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B99F4F72E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbiDGDSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbiDGDSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:18:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2253375215
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:16:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb645be8dbso38166257b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 20:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=0gDL2pvTD5zxTlqUvzGVrkqMwF+WWHMG6CzLJtufS9M=;
        b=QICSklTnaaKrO6/CXXqJRjo6eUoMfPz4jqJsprXE9+mK/IdywVQeWsiiKfkQzApu8E
         io4jZTYfk+M2pMZWRjWFCLRIdy4NtX6ZsC2I+g4xsFu5eLUI1hci3N0Drcy7JIguNy5K
         RLAw+HBz0UxECtKLdy3aUU8a/9UqGtIpri8M0oTvcgQC1m7+xPlp35VoWv8m920YL6NM
         GjgHvHcdIRjPovqKGoeuusODGjIBEdxv59NO9FePJjy28RshR3nHegG91QPzvdIySuve
         b1Y7KAmXVj0xLVH0KzccTpDl62qkV19v+SnBwH4Q+yJwvKT+Hq28lrFMCeA3SVYkl+pf
         AkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=0gDL2pvTD5zxTlqUvzGVrkqMwF+WWHMG6CzLJtufS9M=;
        b=tFZ+qSuB3TCMe0wTV2x7fYnmU443vaOVARngFLtdnUwc958SY6oZFpTcwOpjLHNfd4
         7wKiiA+9LDrUwk43NAeoH7KnqjhGM8eSjh5kdC1Q2xcZcT8El4RTHMNNsoOcyCwxEiSo
         9RORPsPzbSyKEibQi4WZkVXj8TAIm+QAXy2h6XOiH2rroi4XXEPZdLoZDkUtz0z6ab1r
         eX63vo1S4zc/U0/VFW0ZLKNkROxX7/BFRl1AFwFAS+qJALLW4KNlgb1Ibo3XKDpv0HHl
         br2LaWBDQMNWvMQQg+RoZe9ViZUTQzrsbudsl+d0Rv/8M3xtcKxo6e9PyBzvkSDo9hFY
         MjMg==
X-Gm-Message-State: AOAM533irUVBnLWoEPsag4gEdxxDcOeHlzNoCfhE+Z1IHqpQxtNY9fCM
        Ygsp5ZgeGDTBMc1hE2kngYuBqR68ZOo=
X-Google-Smtp-Source: ABdhPJy0qDaWGmrAHqYOlAxiHODGv8oSz35pnKw1CmjSNap+V1hJvi+veG0m6uQb5qNeS9I6XInk5X7RAis=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:9ea2:c755:ae22:6862])
 (user=yuzhao job=sendgmr) by 2002:a25:3247:0:b0:63d:8e17:ac77 with SMTP id
 y68-20020a253247000000b0063d8e17ac77mr8382368yby.325.1649301362972; Wed, 06
 Apr 2022 20:16:02 -0700 (PDT)
Date:   Wed,  6 Apr 2022 21:15:16 -0600
In-Reply-To: <20220407031525.2368067-1-yuzhao@google.com>
Message-Id: <20220407031525.2368067-5-yuzhao@google.com>
Mime-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v10 04/14] Revert "include/linux/mm_inline.h: fold
 __update_lru_size() into its sole caller"
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch undoes the following refactor:
commit 289ccba18af4 ("include/linux/mm_inline.h: fold __update_lru_size() i=
nto its sole caller")

The upcoming changes to include/linux/mm_inline.h will reuse
__update_lru_size().

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
 include/linux/mm_inline.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index ac32125745ab..7c9c2157e9a8 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -32,7 +32,7 @@ static inline int page_is_file_lru(struct page *page)
 	return folio_is_file_lru(page_folio(page));
 }
=20
-static __always_inline void update_lru_size(struct lruvec *lruvec,
+static __always_inline void __update_lru_size(struct lruvec *lruvec,
 				enum lru_list lru, enum zone_type zid,
 				long nr_pages)
 {
@@ -41,6 +41,13 @@ static __always_inline void update_lru_size(struct lruve=
c *lruvec,
 	__mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
 	__mod_zone_page_state(&pgdat->node_zones[zid],
 				NR_ZONE_LRU_BASE + lru, nr_pages);
+}
+
+static __always_inline void update_lru_size(struct lruvec *lruvec,
+				enum lru_list lru, enum zone_type zid,
+				int nr_pages)
+{
+	__update_lru_size(lruvec, lru, zid, nr_pages);
 #ifdef CONFIG_MEMCG
 	mem_cgroup_update_lru_size(lruvec, lru, zid, nr_pages);
 #endif
--=20
2.35.1.1094.g7c7d902a7c-goog

