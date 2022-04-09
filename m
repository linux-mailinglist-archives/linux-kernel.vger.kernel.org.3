Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E64FA967
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbiDIQEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 12:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiDIQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 12:04:41 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E0F12F6CE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 09:02:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q19so10381139pgm.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V5itTOXlA9Vu+1gfr0e8kL5zhkqq5PIPY77y1N6pVbA=;
        b=mKkQLUOlFy+bwMw5+Wu4K/tzuJgiictDE/1HF1ltvHzUgzx3WOFtHA+qgD0WS1iv5v
         XO6cKUO06prfE3i8KFg6huktqps5I7gMEvECj6p32TxwTvgdL1/voO1zWZzYXeVpIeLa
         v7/crUUEy8rwfUDOmtLCuGWjdJue0N4JSVFP46DrmvIkLjcE4gQaiZYnfnHpCXnTdUJI
         YQP8X5cl61Z0v/dq4vKmB7r5qNbxe19wt1kkrDD3ONnRhT+0PTeuP9jiY7wUrIYk3h3g
         Goh1TKfDHYqIhMBmVH5hphyxl2Cme2pc43v7rzRYLZ9+GTeg3iE+nPr4A51xgFDnRAVH
         nNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V5itTOXlA9Vu+1gfr0e8kL5zhkqq5PIPY77y1N6pVbA=;
        b=dQZusUHzpCwI12HpTBPfxEopMIm02hIw+dWCDr6Vkrp4TURr21vEr4fn+E+38/eUWp
         nJR3srI6iA7Mv1ecP7hrFeGHkNPyt2nb52IGI7BAdVjJuM6lmXyPqC4/wMTmdayEr6qD
         68xjfAXjmHf/nbtY13yuZVZzfzFiAQUuGQnOfc9BdDq1yC1vOrFejamb+TBXHCs0AJ7J
         ruixqcZaofO4713rS/zqm2cN2Q8BrrS6mfl6zDc+jx0S6oF//uZw9R+psnNkxQf+SIwO
         lMAHG+d/Y3lPq+j+vUKn0YKAFspyx2r81fMuor2CeBBAmBbybnBjaWSymrKqpZ0gmP5E
         5x+w==
X-Gm-Message-State: AOAM530OjcbjEQQda3XPEhGeIUBXotR+nJeXSTvPFVtZe8fqOOYwfU7v
        EkR28ZKlxohpUhASn0K/nIo=
X-Google-Smtp-Source: ABdhPJzZiNHYjzwnYoSdMSRW3JW5qJC9B1WJNYEMxkqqzovGKWEk5CFlfrvTYwrmqrHC/k+7h7PPIA==
X-Received: by 2002:a05:6a00:ac1:b0:4f1:29e4:b3a1 with SMTP id c1-20020a056a000ac100b004f129e4b3a1mr24920269pfl.63.1649520153977;
        Sat, 09 Apr 2022 09:02:33 -0700 (PDT)
Received: from localhost.localdomain ([210.100.217.177])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm30091904pfh.83.2022.04.09.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 09:02:33 -0700 (PDT)
From:   Ohhoon Kwon <ohkwon1043@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: check pfmemalloc_match in slab_alloc_node fastpath
Date:   Sun, 10 Apr 2022 01:02:23 +0900
Message-Id: <20220409160224.611353-1-ohkwon1043@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If current alloc context does not have __GFP_MEMALLOC in its gfpflags,
then slab objects that were previously created with __GFP_MEMALLOC
should not be given.

This criteria is well kept in slab alloc slowpath:
When gfpflags does not contain __GFP_MEMALLOC but if per-cpu slab page
was allocated with __GFP_MEMALLOC, then allocator first deactivates
per-cpu slab page and then again allocates new slab page with the
current context's gfpflags.

However, this criteria is not checked in fastpath.
It should also be checked in the fastpath, too.

Signed-off-by: Ohhoon Kwon <ohkwon1043@gmail.com>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 74d92aa4a3a2..c77cd548e106 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3179,7 +3179,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 	 * there is a suitable cpu freelist.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
-	    unlikely(!object || !slab || !node_match(slab, node))) {
+	    unlikely(!object || !slab || !node_match(slab, node) ||
+			!pfmemalloc_match(slab, gfpflags))) {
 		object = __slab_alloc(s, gfpflags, node, addr, c);
 	} else {
 		void *next_object = get_freepointer_safe(s, object);
-- 
2.25.1

