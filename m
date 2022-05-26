Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0E8535658
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346714AbiEZXPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiEZXPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:15:42 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D57E52A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 16:15:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3B7DE5C00BB;
        Thu, 26 May 2022 19:15:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 May 2022 19:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1653606940; x=
        1653693340; bh=yFZglDNybaIMHmH9kYiFg9JUBZT2DT4WqPECVtKPtHQ=; b=V
        Gk9Kb5UWLW9rAmv4oflryNCTdu5f02iH/Eggx26tDDAlFb5/7NKSdpDaY3aaY99f
        xhxLsB1sOZoLTKPHXGoO2yCpck2lKS8j4U6j0fotxcBsJd9Z6g3VqPWXsGmJBgIm
        ao+0g6yQAi9b9VHYaqS+O8DANnT5RBMgj+RgxhiKS02e3goN3ZlUXfQkJaAei2IR
        DI8/cJ77eelIGSaGbZ6g6TRi2h5YxODtQ/JzskqPjEVVjDXB9tOqTvOss15JfNeq
        XqpMmEocGU1hfvl4SZSeuyj1N1v43wdoNi9vtBGWDcogn33bDrqD/Vk9ZkElA3oL
        tcZUKWGabjwfQFqmV1wMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1653606940; x=1653693340; bh=y
        FZglDNybaIMHmH9kYiFg9JUBZT2DT4WqPECVtKPtHQ=; b=szQGTVZ5KKlCRaZdj
        txQU6MuzToX1f/jvtVzVzJWLSRv7f1qYiL0gb+EuHRLIfqGXpyAKLfWdGX//CYQq
        7Fbdcv0ayCsto2+i2yk8HJPfDyfsVCjovxSvRVLr29zXegnnKO4tyq6kBfTkaaEb
        BN9UtXoIOdPi6tstSKxKRzy4tasbGVkmzEoG9Y+ETnmKaR8J8+/MsW5SkezXYdYF
        xKf6BlmDgExWEfwDnbfJ1ZNYbnAm+86WgBFnE0082tf51dX/12sa43wICGTCKSRj
        f6OYKVCkEP5zfQn3nngy5qiit9OvMbVirLQGkB+W9OU1CQJWKzAbErB75FuEQ9Eg
        3Kxmw==
X-ME-Sender: <xms:HAqQYugJPjG5z_4XU3abTApFifulRP6zv1tyHJIbTdCMurCFqILAoQ>
    <xme:HAqQYvDDJk4Pg_r_rXIt3S4MK-WOTjcTfE98cLFKL1goWTooLL_Y-dtVQOSzQTfIb
    jvTVNqOKtvXbEvKtw>
X-ME-Received: <xmr:HAqQYmFlK9Pb9PnZ9BmLaEhO1b5CQtDZ52XcP4RAQQyJsCOpYTXACIKIUAjb5pobRQl5o1uzX2ZcFdrHGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeekgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepudeiue
    evhffhkeelhfeugeevjeefleelkedviedugfdvjeejfeejtdetheeulefhnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:HAqQYnS83r7JXBl7KB6d4ZaBwCEFoFFycuqxoxsNE_HVyH7bGXJBZg>
    <xmx:HAqQYrw5WvFPp1wYkrF0384s2hUD-wLRLzBp6cU2_p-Kdb0nGy6Edg>
    <xmx:HAqQYl4ZgJWQF67d1tUwEOph2xywpSF_rvfPFrzo9lEBgat42L1FtA>
    <xmx:HAqQYuqNEMKpe9rz6zFNHa_OyhrULDxoPTzzOWJyU4HeWLW2ewbmYA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 May 2022 19:15:39 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Qian Cai <quic_qiancai@quicinc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>, Doug Berger <opendmb@gmail.com>
Subject: [PATCH 2/2] mm: split free page with properly free memory accounting and without race
Date:   Thu, 26 May 2022 19:15:31 -0400
Message-Id: <20220526231531.2404977-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220526231531.2404977-1-zi.yan@sent.com>
References: <20220526231531.2404977-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

In isolate_single_pageblock(), free pages are checked without holding zone
lock, but they can go away in split_free_page() when zone lock is held.
Check the free page and its order again in split_free_page() when zone lock
is held. Recheck the page if the free page is gone under zone lock.

In addition, in split_free_page(), the free page was deleted from the page
list without changing free page accounting. Add the missing free page
accounting code.

Fix the type of order parameter in split_free_page().
Link: https://lore.kernel.org/lkml/20220525103621.987185e2ca0079f7b97b856d@=
linux-foundation.org/

Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granula=
rity")
Reported-by: Doug Berger <opendmb@gmail.com>
Link: https://lore.kernel.org/linux-mm/c3932a6f-77fe-29f7-0c29-fe6b1c67ab7b=
@gmail.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/internal.h       |  4 ++--
 mm/page_alloc.c     | 24 ++++++++++++++++++++----
 mm/page_isolation.c | 10 +++++++---
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 20e0a990da40..7cf12a15475b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -374,8 +374,8 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t=
 align,
 			  phys_addr_t min_addr,
 			  int nid, bool exact_nid);
=20
-void split_free_page(struct page *free_page,
-				int order, unsigned long split_pfn_offset);
+int split_free_page(struct page *free_page,
+			unsigned int order, unsigned long split_pfn_offset);
=20
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
=20
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 355bd017b185..2717d6dede99 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1112,30 +1112,44 @@ static inline void __free_one_page(struct page *pag=
e,
  * @order:		the order of the page
  * @split_pfn_offset:	split offset within the page
  *
+ * Return -ENOENT if the free page is changed, otherwise 0
+ *
  * It is used when the free page crosses two pageblocks with different mig=
ratetypes
  * at split_pfn_offset within the page. The split free page will be put in=
to
  * separate migratetype lists afterwards. Otherwise, the function achieves
  * nothing.
  */
-void split_free_page(struct page *free_page,
-				int order, unsigned long split_pfn_offset)
+int split_free_page(struct page *free_page,
+			unsigned int order, unsigned long split_pfn_offset)
 {
 	struct zone *zone =3D page_zone(free_page);
 	unsigned long free_page_pfn =3D page_to_pfn(free_page);
 	unsigned long pfn;
 	unsigned long flags;
 	int free_page_order;
+	int mt;
+	int ret =3D 0;
=20
 	if (split_pfn_offset =3D=3D 0)
-		return;
+		return ret;
=20
 	spin_lock_irqsave(&zone->lock, flags);
+
+	if (!PageBuddy(free_page) || buddy_order(free_page) !=3D order) {
+		ret =3D -ENOENT;
+		goto out;
+	}
+
+	mt =3D get_pageblock_migratetype(free_page);
+	if (likely(!is_migrate_isolate(mt)))
+		__mod_zone_freepage_state(zone, -(1UL << order), mt);
+
 	del_page_from_free_list(free_page, zone, order);
 	for (pfn =3D free_page_pfn;
 	     pfn < free_page_pfn + (1UL << order);) {
 		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
=20
-		free_page_order =3D min_t(int,
+		free_page_order =3D min_t(unsigned int,
 					pfn ? __ffs(pfn) : order,
 					__fls(split_pfn_offset));
 		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
@@ -1146,7 +1160,9 @@ void split_free_page(struct page *free_page,
 		if (split_pfn_offset =3D=3D 0)
 			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
 	}
+out:
 	spin_unlock_irqrestore(&zone->lock, flags);
+	return ret;
 }
 /*
  * A bad page could be due to a number of fields. Instead of multiple bran=
ches,
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index fbd820b21292..6021f8444b5a 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -371,9 +371,13 @@ static int isolate_single_pageblock(unsigned long boun=
dary_pfn, int flags,
 		if (PageBuddy(page)) {
 			int order =3D buddy_order(page);
=20
-			if (pfn + (1UL << order) > boundary_pfn)
-				split_free_page(page, order, boundary_pfn - pfn);
-			pfn +=3D (1UL << order);
+			if (pfn + (1UL << order) > boundary_pfn) {
+				/* free page changed before split, check it again */
+				if (split_free_page(page, order, boundary_pfn - pfn))
+					continue;
+			}
+
+			pfn +=3D 1UL << order;
 			continue;
 		}
 		/*
--=20
2.35.1

