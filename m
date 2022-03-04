Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A84CCDE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiCDGgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbiCDGgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:36:18 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F8018E430
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:34:53 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d17so6886071pfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 22:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ks5pvMqQR8K26b0NEwSqAgaMYIVmHGUi4tZdn97VHAs=;
        b=mn/MfoEj7ex4cmWohzuiwMeU/dZ0xaA4vmjw8XtRuG2VBO7jFKIZkJ6oC7nxEnlPCU
         1WZ1wLqzmp4zRfAh1HWUQLkVtbW7dmuR6q4FHPMIIzZ0NAiL9IGsbUVoomTUyxiac2CG
         F5DiPVczqJKVJNP55QPIQxeP2up+AbCNUuNTSJDU5nuBFZjf5FbOGiL2wHoCDaUA+ZS2
         SMuXS50A+ZEdGex9kFFp9bU5DwfFMmhd/sUA088joOH3oLz+XBULwpkKsts4Hv/XUCTP
         M4oXr61f00V6ykH++i/cZx4YKwEsoqxKtenjUKqtj+ekJxDsba+46cUsSS6vTOg1nwy0
         faqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ks5pvMqQR8K26b0NEwSqAgaMYIVmHGUi4tZdn97VHAs=;
        b=RtSDGQZiUHV6AvZZ9PPX7M3ZGJ2xgeyvt8QELydqN1QO3dMy8ln0PMID+JsIP6uLJX
         cD9bVxc466kBxrlwu3PCk2rSPUjhbG92PjHk2JIMskQQivdqFjIapQczG80i6AOS5I6K
         MDUenhd6rUgnvXNOCJl3EbmUFmj9PUlpgDSexRzcwPVbe3GX/OtdIimu5IaWMYbTh0X3
         jO/7yZWXb+sMmDfdYLsGTW68hVMdkvF7fT7+7GaXGWVpP/iQnqVjB/J++CBn3+NjNc7C
         lkIBwWSLKBwRiPBuZg8maGeGmo6XHsonmwGqKhmUkbMgT4t7+oQuSwXcH1r7UV2T0MYP
         fpTA==
X-Gm-Message-State: AOAM5311M9AxZQdYx/kbx6W5InEsHQQUAqFgxYZ5pNdcSiHhZn3qBycU
        5GH1ceowmyWMompZblOWrg4=
X-Google-Smtp-Source: ABdhPJyEhvk8aBpqhMLNfeybmgloUiwg+1evBGGHCq6W0x0KqLIVEGGOo3A5PVK/zxqLLXfIyyj3nw==
X-Received: by 2002:a63:df0e:0:b0:378:4f83:496f with SMTP id u14-20020a63df0e000000b003784f83496fmr27591895pgg.560.1646375692737;
        Thu, 03 Mar 2022 22:34:52 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b004e0f420dd90sm4900007pfu.40.2022.03.03.22.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 22:34:52 -0800 (PST)
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
Subject: [PATCH v2 4/5] mm/slub: limit number of node partial slabs only in cache creation
Date:   Fri,  4 Mar 2022 06:34:26 +0000
Message-Id: <20220304063427.372145-5-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220304063427.372145-1-42.hyeyoo@gmail.com>
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
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
---
 mm/slub.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6f0ebadd8f30..f9ae983a3dc6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3981,15 +3981,6 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
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
@@ -4196,7 +4187,8 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	 * The larger the object size is, the more slabs we want on the partial
 	 * list to avoid pounding the page allocator excessively.
 	 */
-	set_min_partial(s, ilog2(s->size) / 2);
+	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
+	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
 
 	set_cpu_partial(s);
 
@@ -5361,7 +5353,7 @@ static ssize_t min_partial_store(struct kmem_cache *s, const char *buf,
 	if (err)
 		return err;
 
-	set_min_partial(s, min);
+	s->min_partial = min;
 	return length;
 }
 SLAB_ATTR(min_partial);
-- 
2.33.1

