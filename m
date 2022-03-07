Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656444CF2C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiCGHmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbiCGHmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:42:11 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559A11C1C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:41:18 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o26so12871128pgb.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 23:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tlFuEYo8Qx2S8WIAtfcNMg/P/GSehAMJ4GeATPvNw5s=;
        b=EmSWW4qOqQ70lyF9xacw400VSbQfslPnfkW68IsF9ZUaP//kVexYiY6fqcgcvKk2lv
         Jwc+wqyFPpKzg3r8E987L80y7ENqcn7qy1U8KQoJfhuPPzcOVxSSxFol5Rtbnjg+adWN
         3bDby7QoC7LjW9k/D4Asop5K+5HwRpRdhJ0aGRX762MnLTSHziLNFmRJweFa3QcAEPaR
         52iSmSjAEmsW+7lHsp+BKe2HmAuSQQ7i38H1VIcgCZ1c9PoLQyqjLZ2J9VyDeZifxgJb
         PBeUiREFLdfLCZFDUwCI5TuUdQjS4BDveEDSRWi5RyBtkgJjlQU3JAK0LHqlMaPA9e0K
         Z6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tlFuEYo8Qx2S8WIAtfcNMg/P/GSehAMJ4GeATPvNw5s=;
        b=DCu1Oqw65gsM3uWefeIVGqHg13TMXoK6AkOqOeP2ykbky5BHKwxtJ54/+FqhfB0hxm
         NaCcBlPhZ9PNmilaKBzLdbPQ5s770zJiZk0d7f12fxcqN+GvA0b9XaIz/Dby4acv/g0J
         eTOXfSs6XJFkhLAPt6M3eVi8zRl9AJydLw9Pcj54RDwXIIxaSnniWXM3qBnqGKpEybYv
         y+HW1dxamRWHrHgHXLw5722wjMo/DJhlSQ2Wc7tsecadtA5yb4C+t+tGXwVLGFQQSgjQ
         70lqi7i5kvYvjVXdWGP5BDIjl5SPxk+cgDjHT3XTD5OwDSB0mKTVB+dQmga9sgxG9MWn
         SkeA==
X-Gm-Message-State: AOAM533RS8NLbHPsNBEZ3AOZ4L95rYjch/yqPr5JSpXJzd1/7b5FZB2q
        5AjVuo+X4kkqD/N+w5fpqrA=
X-Google-Smtp-Source: ABdhPJzR0IKk676yJGBx7ojlx56c0CgzQrBTQ0syjlZrPtwjHvFVB53TKSgrjCpQ686BFcZaTeXEqg==
X-Received: by 2002:a63:dd17:0:b0:36c:33aa:6d5f with SMTP id t23-20020a63dd17000000b0036c33aa6d5fmr8799031pgg.300.1646638878098;
        Sun, 06 Mar 2022 23:41:18 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id p10-20020a637f4a000000b00373a2760775sm10878743pgn.2.2022.03.06.23.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 23:41:17 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com
Subject: [PATCH v3 1/2] mm/slub: limit number of node partial slabs only in cache creation
Date:   Mon,  7 Mar 2022 07:40:55 +0000
Message-Id: <20220307074057.902222-2-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220307074057.902222-1-42.hyeyoo@gmail.com>
References: <20220307074057.902222-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLUB sets number of minimum partial slabs for node (min_partial)
using set_min_partial(). SLUB holds at least min_partial slabs even if
they're empty to avoid excessive use of page allocator.

set_min_partial() limits value of min_partial limits value of
min_partial MIN_PARTIAL and MAX_PARTIAL. As set_min_partial() can be
called by min_partial_store() too, Only limit value of min_partial
in kmem_cache_open() so that it can be changed to value that a user wants.

[ rientjes@google.com: Fold set_min_partial() into its callers ]

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 261474092e43..1ce09b0347ad 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4000,15 +4000,6 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 	return 1;
 }
 
-static void set_min_partial(struct kmem_cache *s, unsigned long min)
-{
-	if (min < MIN_PARTIAL)
-		min = MIN_PARTIAL;
-	else if (min > MAX_PARTIAL)
-		min = MAX_PARTIAL;
-	s->min_partial = min;
-}
-
 static void set_cpu_partial(struct kmem_cache *s)
 {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
@@ -4215,7 +4206,8 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	 * The larger the object size is, the more slabs we want on the partial
 	 * list to avoid pounding the page allocator excessively.
 	 */
-	set_min_partial(s, ilog2(s->size) / 2);
+	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
+	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
 
 	set_cpu_partial(s);
 
@@ -5396,7 +5388,7 @@ static ssize_t min_partial_store(struct kmem_cache *s, const char *buf,
 	if (err)
 		return err;
 
-	set_min_partial(s, min);
+	s->min_partial = min;
 	return length;
 }
 SLAB_ATTR(min_partial);
-- 
2.33.1

