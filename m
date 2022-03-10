Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F974D489B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242690AbiCJOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242687AbiCJOJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:09:43 -0500
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2031496A1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1646921322; bh=/udTN7nALEHPjWGb6QXe2TvLszHnb85ZIuIPj3HkQLQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=N5oRVE90DCnQVEFtmbP6+o4lgirNU8PX4HK8SQ27EXqcNlyFYjZEG7u05cm9j8wmY
         MXPU/akTZcQIaatAqdLdp6y0eOkzwv7Hr6wYRDeYUwNpkOe9sB5Os4vD0FsroT8qPX
         TYHkPuqpZ0W9OrvUhab4H1TpteJwrAMl6Vlw88qAMORSG6sLNeoAzNoxE/wBUk+W4l
         JRAwv7ckiqhxF8Zi0vJfolNja/RvFVWTSP0GlFsbSTUK790IV4XILuFlBDP8krxbFF
         MkASqVc9r9wWJnVvZMM2Af8O+hl34NrwsI3rgfFzTPTmSGQLeVWuSPcArCMc+uJ5N7
         pFVqyB5SB8wZA==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id CA02B8083B;
        Thu, 10 Mar 2022 14:08:31 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        longman@redhat.com, guro@fb.com, willy@infradead.org,
        roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 2/2] mm: slub: Delete useless parameter of alloc_slab_page()
Date:   Thu, 10 Mar 2022 22:07:01 +0800
Message-Id: <20220310140701.87908-3-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220310140701.87908-1-sxwjean@me.com>
References: <20220310140701.87908-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-03-10_03:2022-03-09,2022-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2203100077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

The parameter @s is useless for alloc_slab_page(). It was added in 2014
by commit 5dfb41750992 ("sl[au]b: charge slabs to kmemcg explicitly"). The
need for it was removed in 2020 by commit 1f3147b49d75 ("mm: slub: call
account_slab_page() after slab page initialization"). Let's delete it.

[willy@infradead.org: Added detailed history of @s]
Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: David Rientjes <rientjes@google.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/slub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 261474092e43..5d273ee04c43 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1788,8 +1788,8 @@ static void *setup_object(struct kmem_cache *s, struct slab *slab,
 /*
  * Slab allocation and freeing
  */
-static inline struct slab *alloc_slab_page(struct kmem_cache *s,
-		gfp_t flags, int node, struct kmem_cache_order_objects oo)
+static inline struct slab *alloc_slab_page(gfp_t flags, int node,
+		struct kmem_cache_order_objects oo)
 {
 	struct folio *folio;
 	struct slab *slab;
@@ -1941,7 +1941,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
 		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~(__GFP_RECLAIM|__GFP_NOFAIL);
 
-	slab = alloc_slab_page(s, alloc_gfp, node, oo);
+	slab = alloc_slab_page(alloc_gfp, node, oo);
 	if (unlikely(!slab)) {
 		oo = s->min;
 		alloc_gfp = flags;
@@ -1949,7 +1949,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 * Allocation may have failed due to fragmentation.
 		 * Try a lower order alloc if possible
 		 */
-		slab = alloc_slab_page(s, alloc_gfp, node, oo);
+		slab = alloc_slab_page(alloc_gfp, node, oo);
 		if (unlikely(!slab))
 			goto out;
 		stat(s, ORDER_FALLBACK);
-- 
2.30.2

