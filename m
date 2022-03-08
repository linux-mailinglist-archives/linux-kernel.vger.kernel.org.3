Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D174E4D25FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiCIBPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiCIBNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:13:54 -0500
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBEE1617D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:01:42 -0800 (PST)
Received: by mail-ot1-x34a.google.com with SMTP id t16-20020a9d7290000000b005b24005289dso604592otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 17:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Yy5tsDcd68WP2pPFOldj5ImTljRQrxxQbB0W/VdFifI=;
        b=b5lAjQE8r1DEbBPedd60rKa6+76988i0gaD01NKhWSvAbggK5fAUfUjLdDSqtCvhi9
         pSdAuIJUfsWqSY+yKR3opn1rWFJFPyd6uw0EZTOi89mg3w+9Kij3hZgzSNzQ5uXTIO8Y
         HaMdUR+NTV2+ofLu655yGEGiMMsv0+/LtxcARukANmdSz0BAgX6igRbXlyWUhH6ywAsw
         zycuNFFrPjtLG6b4DYVMH54gLp/6K2firQt4JHBz5JuUND1ASXZYseK7OsOP1xFz/xkY
         WH6L9ooZaCWmADf90u5JzOTRFfZi//lfdLr4wAbqfl+F9F2vsAjm0w5yazXQEOjFRlkI
         3Kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Yy5tsDcd68WP2pPFOldj5ImTljRQrxxQbB0W/VdFifI=;
        b=ehxArRAV+Np+vjOAz2WUnKgXidNYhJTu76bPP6otrD9M9MjBWp06c3GZRq4lKRfzcV
         qphnULvyAPhopEWNmtPnmZMllhz2UcGFTyC4JismZDar2A8Sm76eWrf09QXXfftcM5SN
         igt6WezucfSXNfHLQO/rTM6xRVFw/oVFiKlxdmlSs/WNwC0NcXu6oRPVNyK3+KY5RM9o
         GvIerJOeAeX9JkNrlAumfwvuHJCBgMvaDttX4uvG9zGuTf/6QY1l/4nyg3ZYU0uOuxKY
         NxdzPXL+59ufQoTX081P9qQRt0nGujBgVcKxbAdVdyfKt+dTD9h7JD7oZy6tK5UJREwk
         dWgg==
X-Gm-Message-State: AOAM532F2TKY3YJNUTJDHlxM3gGhkLHQ3+W/SM+sShfHH2TkJ0swdXX3
        1n411hypfvTmK/FLnxOXSj98rA8rm00=
X-Google-Smtp-Source: ABdhPJzVnM44uuYLVqWxi2C6HusyvMeenfA/ZcHczyWerbLbS/aJiKNUW4mZoiizV40TQ7wKAK96owR34vA=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:57a6:54a6:aad1:c0a8])
 (user=yuzhao job=sendgmr) by 2002:a25:dfcd:0:b0:628:d031:e3a7 with SMTP id
 w196-20020a25dfcd000000b00628d031e3a7mr14090539ybg.305.1646783309668; Tue, 08
 Mar 2022 15:48:29 -0800 (PST)
Date:   Tue,  8 Mar 2022 16:47:14 -0700
In-Reply-To: <20220308234723.3834941-1-yuzhao@google.com>
Message-Id: <20220308234723.3834941-5-yuzhao@google.com>
Mime-Version: 1.0
References: <20220308234723.3834941-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v8 04/14] Revert "include/linux/mm_inline.h: fold
 __update_lru_size() into its sole caller"
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
index cf90b1fa2c60..2c24f5ac3e2a 100644
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
2.35.1.616.g0bdcbb4464-goog

