Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E784C8721
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiCAIwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCAIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:52:45 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEBF89CC6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:52:05 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id u16so13562994pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=X+CELJ7rEgmBMwuKX3QnxNunnNgyBQv4GScNFZ71SB0=;
        b=KwqZjC+TAY7yWZaiJPe0/5cQbVUsJm4BVqQGXKKDx26ptfR4w5H4zNTfiTpyaFtkmB
         +W5TytA2dylB07CeWLQuxbQWEPAGeLV89hEFLJ/MIamYquQ8KQO4III05jixVjhu545v
         jkL0Ua1N11cP7USZt+IU/3AjYRNKUmNtbl/8jCbTTRQ3nMDP2CYgbaPTxfhBQMLb94UT
         nfFyYee1BRqI/zDHFOrMZFP2d2oWxLhg89c0MP7tioNASOMIcpkiz9W298B0bRLKcr+W
         SoHvrpjQuJshP4oRvo0+79s/eau8VJxniJaG8VdfzBRaCXgiCC1BSS7pQZShTczThqVD
         lGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=X+CELJ7rEgmBMwuKX3QnxNunnNgyBQv4GScNFZ71SB0=;
        b=po5W9u9xo8IhwcVJPkbAv26SkXb/vbOZ22sSnLbAZmYPWF+HN8aPV6kqdDMh0qPVBG
         BqC61cIPUQ6Ua6m30a024rawOxlPIbiMC8/h58vt5QME1WQITCI4y208g4Xhg5KvR9gX
         0/TSSr8DDWScAxbyzzMyRc3u4Cl5hYhSv2mTJHltUYFrQBebY/n06ph2X995An2NLNNg
         XamEdPfEwqr2ANWhVzJ6KY255dlZZNId3w68l0S4qa2I+39E505xtaOFxn5EDkM2QO1X
         DXbXCNUM+EVk781Nw1YRtM28x3YGlmkItK/ryRpvCY4hBWvEeFB6P7CK+4yAF74sOh21
         ZHjg==
X-Gm-Message-State: AOAM532SG4ZRLW0kJKh0VpcclTX441HlG6K/q6o1Ld89zPXVddSp6c1x
        gAL/0EJ5oQQkEJromy/SOX0=
X-Google-Smtp-Source: ABdhPJz+fO4CUS/yMIGn/QrRS/NMKXCeSG9j218AJLbx2wIEG3bt8mJAh6hrbPF00rlmtIW3daVe0g==
X-Received: by 2002:a62:7e06:0:b0:4e0:f0f8:9b86 with SMTP id z6-20020a627e06000000b004e0f0f89b86mr26732203pfc.26.1646124724549;
        Tue, 01 Mar 2022 00:52:04 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id o3-20020a056a0015c300b004e17afd9af9sm16979963pfu.92.2022.03.01.00.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 00:52:04 -0800 (PST)
Date:   Tue, 1 Mar 2022 08:51:56 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, kbuild-all@lists.01.org,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
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
Subject: [PATCH v3] mm/slub: initialize stack depot in boot process
Message-ID: <Yh3erDM9anwFXkD8@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203011512.U0o5cAx4-lkp@intel.com>
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

[ lkp@intel.com: Fix build error. ]

Link: https://lore.kernel.org/all/YhyeaP8lrzKgKm5A@ip-172-31-19-208.ap-northeast-1.compute.internal/
Fixes: ba10d4b46655 ("mm/slub: use stackdepot to save stack trace in objects")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h       |  1 +
 include/linux/stackdepot.h |  3 ++-
 mm/slab.c                  |  5 +++++
 mm/slob.c                  |  5 +++++
 mm/slub.c                  | 19 ++++++++++++++++---
 5 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 37bde99b74af..d2b0f8f9e5e6 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -762,6 +762,7 @@ extern void kvfree_sensitive(const void *addr, size_t len);
 
 unsigned int kmem_cache_size(struct kmem_cache *s);
 void __init kmem_cache_init_late(void);
+int __init slab_stack_depot_init(void);
 
 #if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
 int slab_prepare_cpu(unsigned int cpu);
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
diff --git a/mm/slab.c b/mm/slab.c
index ddf5737c63d9..c7f929665fbe 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1196,6 +1196,11 @@ static void __init set_up_node(struct kmem_cache *cachep, int index)
 	}
 }
 
+int __init slab_stack_depot_init(void)
+{
+	return 0;
+}
+
 /*
  * Initialisation.  Called after the page allocator have been initialised and
  * before smp_init().
diff --git a/mm/slob.c b/mm/slob.c
index 60c5842215f1..7597c219f061 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -725,3 +725,8 @@ void __init kmem_cache_init_late(void)
 {
 	slab_state = FULL;
 }
+
+int __init slab_stack_depot_init(void)
+{
+	return 0;
+}
diff --git a/mm/slub.c b/mm/slub.c
index a74afe59a403..8f130f917977 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -646,6 +646,16 @@ static slab_flags_t slub_debug;
 
 static char *slub_debug_string;
 static int disable_higher_order_debug;
+static bool __initdata init_stack_depot;
+
+int __init slab_stack_depot_init(void)
+{
+#ifdef CONFIG_STACKDEPOT
+	if (init_stack_depot)
+		stack_depot_init();
+#endif
+	return 0;
+}
 
 /*
  * slub is about to manipulate internal object metadata.  This memory lies
@@ -1531,6 +1541,8 @@ static int __init setup_slub_debug(char *str)
 			global_slub_debug_changed = true;
 		} else {
 			slab_list_specified = true;
+			if (flags & SLAB_STORE_USER)
+				init_stack_depot = true;
 		}
 	}
 
@@ -1546,6 +1558,10 @@ static int __init setup_slub_debug(char *str)
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
@@ -4221,9 +4237,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
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
