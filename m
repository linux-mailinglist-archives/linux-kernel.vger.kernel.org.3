Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2518154AA50
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353946AbiFNHRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353708AbiFNHRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:17:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F6912AC9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:17:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s22-20020a252d56000000b0065d1ef35f9dso6962582ybe.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=D1tI7WDD6BkSp8vdJUGyasd9RspDYVcf2s3K3k00n8E=;
        b=oVRZoBVjG7Z4RBep9kZJo6+f/8GPme9EC4Rjg3mMbmfp42nGp5yz4K6r1QvXRcxPJN
         9mMsDFeH6u1+l2WSoQ3O6zlXfQR4yhMIySD4Z/GkwdIaewcfx6jJrixTMAAqtgMsa34q
         RWlzUXwTCHNovn+liPTEnS7IyzwYNVTpiZlKrhsx4qhGPdMXNEitlBg7tE3NeJZWPJH1
         nTt1+klEynatT9dGdyS+6oZr5/WQoTUASriruXj9BnKhuytK+J2aIZNhfOtOrVdIxPuh
         jSLKFFaZSA+H5uB9Tl0el85eepw4IilpgV9W609BtW5CIgwFJw6QSZYoKZ6+yIMqmqg9
         4A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=D1tI7WDD6BkSp8vdJUGyasd9RspDYVcf2s3K3k00n8E=;
        b=S3XCmZaNRyrVZrnE8mHkzoi9oOAvvwa/wmurLSoeaQX3X7r2meqpWWhqM88mBx37bv
         iUDVmEik7pUpoajanZJ+hFYJCti/SeJTQN7s06SIyoVfJOyzjwzXfDmp9kXzonxvrVHN
         bYZvgMFvJ8sHVK7cgpXCesBGwrmiCbVG81HJauWC5cWqtbg66BKBRcn9nObEGdAr5jLY
         zml51LAQ5bdQnRiLsdRbxSyYYoCHZXeq2Z8Td9dumdas3gPPZOZu2aT+X0x99ZTSgNLq
         ArJzU1cN0Ac1nxSoyDnFynpKTi5/FvCs4c0FWLFLKdctysbj5jAV3b8NtJi0wpD5IE7u
         O7oQ==
X-Gm-Message-State: AJIora9NpFwgPBlBmO4edwoL4kDDI1Sobvkh7Dp9f/+jejZ787O92sOJ
        orOEnoGfmtzgISu9tX9Qgtgvu7AeAtc=
X-Google-Smtp-Source: AGRyM1toFkvdpMNGM0kO7TSnX52idsIuCtYt4XUqDdqzJqgRklSPx3240tBaTFSm3AZCDyJ2di6Eb18fdcQ=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:eaa7:1f3f:e74a:2a26])
 (user=yuzhao job=sendgmr) by 2002:a25:3c45:0:b0:664:cf75:c2d6 with SMTP id
 j66-20020a253c45000000b00664cf75c2d6mr3416410yba.446.1655191051871; Tue, 14
 Jun 2022 00:17:31 -0700 (PDT)
Date:   Tue, 14 Jun 2022 01:16:41 -0600
In-Reply-To: <20220614071650.206064-1-yuzhao@google.com>
Message-Id: <20220614071650.206064-5-yuzhao@google.com>
Mime-Version: 1.0
References: <20220614071650.206064-1-yuzhao@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v12 04/14] Revert "include/linux/mm_inline.h: fold
 __update_lru_size() into its sole caller"
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
        Miaohe Lin <linmiaohe@huawei.com>,
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
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
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
index 7b25b53c474a..fb8aadb81cd6 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -34,7 +34,7 @@ static inline int page_is_file_lru(struct page *page)
 	return folio_is_file_lru(page_folio(page));
 }
=20
-static __always_inline void update_lru_size(struct lruvec *lruvec,
+static __always_inline void __update_lru_size(struct lruvec *lruvec,
 				enum lru_list lru, enum zone_type zid,
 				long nr_pages)
 {
@@ -43,6 +43,13 @@ static __always_inline void update_lru_size(struct lruve=
c *lruvec,
 	__mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
 	__mod_zone_page_state(&pgdat->node_zones[zid],
 				NR_ZONE_LRU_BASE + lru, nr_pages);
+}
+
+static __always_inline void update_lru_size(struct lruvec *lruvec,
+				enum lru_list lru, enum zone_type zid,
+				long nr_pages)
+{
+	__update_lru_size(lruvec, lru, zid, nr_pages);
 #ifdef CONFIG_MEMCG
 	mem_cgroup_update_lru_size(lruvec, lru, zid, nr_pages);
 #endif
--=20
2.36.1.476.g0c4daa206d-goog

