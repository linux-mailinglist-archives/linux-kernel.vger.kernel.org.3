Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964774C81AE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiCADha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiCADh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:37:26 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6749870312
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:36:46 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id bc27so4426756pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wvHyMWb4Vup6fp70fcnYjPwaQlO4R7c0Csa1i6hXi9M=;
        b=EBvBprQQ//9P3T/BVK9MgCeHo1ctnzByGpuO39blALooJrEPY4SOSpFa8BBXfnBEBI
         ENckznChvtoDSYrxUSfH6FmKbXAdEZ+TCLtss/48tk32k5Z/IpBHE7XCXiRkm6cti8yD
         /cADisIYld/bdrsJhdHi0AbX0lkGTj5kHUVxOkg/wITDIhgLd1g31B4ohCpIdk+vcKta
         sbSbptc4OYc6JkXsyvQG8oqHi7I/kJlco8oZctdPPjZlWo+yJelu8QIFYfZ554YUFnd4
         CbSSmU+YEdUVujYBt1Xg+HsW+nveNueZB/9ofo8BLovB1o0rMGZhCfdmXSlz499TYUuq
         /O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wvHyMWb4Vup6fp70fcnYjPwaQlO4R7c0Csa1i6hXi9M=;
        b=wmx0s3th6ZHFP0OlSh62d9nxmWIep2AQmi4crWajeUkEXrDeTZj72Sg2HNXCNczdb/
         0Efl5lcrdW0wRXnon+12vfqVkjAsTVKUQzGdK4AuwYcrV+FZ5nw3+4dgFwT5rwccuo2X
         nUfrUamg2/tjtr3NUuG+yPFBCCD15mAMRj9fYJD1ku6SwTu2W4R9m2IA5QXR2xWPuHsw
         gxRjsFfHCD0VM/TrIdP6bsoRmNAubEgaXGwFUrYihB0vS29vPVW7ChHMXgCjNNfj4tes
         YSO8IEbikZg3LRpN/Jjx2vAsGkI82GXR3aso62amC84D2u7fTnnJUBdK7sYP7CA5Yywf
         Nw/w==
X-Gm-Message-State: AOAM532Q5uKtcKaHLlJWJEuRwTPsRpUmDxS/lV5fGw77oRlsqSkjKNeb
        32s3T+fIgsF4RO/cSM3PSlA=
X-Google-Smtp-Source: ABdhPJwSQICuomfFXU9pBsEdQPGrrNXV+o0mg9L9MaM7NwoauJKYFZE45/IEzWZzDBBkHG3RvGqw6g==
X-Received: by 2002:a63:1b5e:0:b0:36f:e756:c118 with SMTP id b30-20020a631b5e000000b0036fe756c118mr19840678pgm.562.1646105805849;
        Mon, 28 Feb 2022 19:36:45 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id 17-20020a056a00071100b004f0f941d1e8sm14258564pfl.24.2022.02.28.19.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 19:36:45 -0800 (PST)
Date:   Tue, 1 Mar 2022 03:36:38 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Zqiang <qiang.zhang@windriver.com>
Subject: [PATCH v2] mm/slub: initialize stack depot in boot process
Message-ID: <Yh2Uxh9DMndwjGcb@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ba10d4b46655 ("mm/slub: use stackdepot to save stack trace in
objects") initializes stack depot in cache creation if SLAB_STORE_USER
flag is set.

This can make kernel crash because a cache can be crashed in various
contexts. For example if user sets slub_debug=U, kernel crashes
because create_boot_cache() calls stack_depot_init(), which tries to
allocate hash table using memblock_alloc() if slab is not available.
But memblock is also not available at that time.

This patch solves the problem by initializing stack depot early
in boot process if SLAB_STORE_USER debug flag is set globally
or the flag is set for at least one cache.

[ elver@google.com: initialize stack depot depending on slub_debug
  parameter instead of allowing stack_depot_init() to be called
  during kmem_cache_init() for simplicity. ]

[ vbabka@suse.cz: parse slub_debug parameter in setup_slub_debug()
  and initialize stack depot in stack_depot_early_init(). ]

Link: https://lore.kernel.org/all/YhyeaP8lrzKgKm5A@ip-172-31-19-208.ap-northeast-1.compute.internal/
Fixes: ba10d4b46655 ("mm/slub: use stackdepot to save stack trace in objects")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h       |  6 ++++++
 include/linux/stackdepot.h |  3 ++-
 mm/slub.c                  | 18 +++++++++++++++---
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 37bde99b74af..062128e0db10 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -763,6 +763,12 @@ extern void kvfree_sensitive(const void *addr, size_t len);
 unsigned int kmem_cache_size(struct kmem_cache *s);
 void __init kmem_cache_init_late(void);
 
+#if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_STACKDEPOT)
+int slab_stack_depot_init(void);
+#else
+int slab_stack_depot_init(void) { return 0; }
+#endif
+
 #if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
 int slab_prepare_cpu(unsigned int cpu);
 int slab_dead_cpu(unsigned int cpu);
diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 17f992fe6355..a813a2673c48 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -12,6 +12,7 @@
 #define _LINUX_STACKDEPOT_H
 
 #include <linux/gfp.h>
+#include <linux/slab.h>
 
 typedef u32 depot_stack_handle_t;
 
@@ -32,7 +33,7 @@ int stack_depot_init(void);
 #ifdef CONFIG_STACKDEPOT_ALWAYS_INIT
 static inline int stack_depot_early_init(void)	{ return stack_depot_init(); }
 #else
-static inline int stack_depot_early_init(void)	{ return 0; }
+static inline int stack_depot_early_init(void)	{ return slab_stack_depot_init(); }
 #endif
 
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
diff --git a/mm/slub.c b/mm/slub.c
index a74afe59a403..2419fc3cc9f3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -646,6 +646,14 @@ static slab_flags_t slub_debug;
 
 static char *slub_debug_string;
 static int disable_higher_order_debug;
+static bool init_stack_depot;
+
+int slab_stack_depot_init(void)
+{
+	if (init_stack_depot)
+		stack_depot_init();
+	return 0;
+}
 
 /*
  * slub is about to manipulate internal object metadata.  This memory lies
@@ -1531,6 +1539,8 @@ static int __init setup_slub_debug(char *str)
 			global_slub_debug_changed = true;
 		} else {
 			slab_list_specified = true;
+			if (flags & SLAB_STORE_USER)
+				init_stack_depot = true;
 		}
 	}
 
@@ -1546,6 +1556,10 @@ static int __init setup_slub_debug(char *str)
 			global_flags = slub_debug;
 		slub_debug_string = saved_str;
 	}
+
+	if (global_flags & SLAB_STORE_USER)
+		init_stack_depot = true;
+
 out:
 	slub_debug = global_flags;
 	if (slub_debug != 0 || slub_debug_string)
@@ -1556,6 +1570,7 @@ static int __init setup_slub_debug(char *str)
 	     static_branch_unlikely(&init_on_free)) &&
 	    (slub_debug & SLAB_POISON))
 		pr_info("mem auto-init: SLAB_POISON will take precedence over init_on_alloc/init_on_free\n");
+
 	return 1;
 }
 
@@ -4221,9 +4236,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	s->remote_node_defrag_ratio = 1000;
 #endif
 
-	if (s->flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
-		stack_depot_init();
-
 	/* Initialize the pre-computed randomized freelist if slab is up */
 	if (slab_state >= UP) {
 		if (init_cache_random_seq(s))
-- 
2.33.1
