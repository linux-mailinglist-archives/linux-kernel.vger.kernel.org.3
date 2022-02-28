Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F724C7052
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiB1PKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiB1PKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:10:42 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3E777A9D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:10:03 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o8so11687291pgf.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=/IzYX9ekXXf7onTNDRhy0rzD0OI0XgiFY+K3R+MvA9A=;
        b=ZGIn/OXsY7QB0Sykq85jAfBBii7x+DAFUHBo7NHAudLxTsc/Unb8bKEFWoqST8WBpW
         bw94JTVLzK0mn8ztcZhov9MXKHyGOOwbI70uHhcBZOtpoU5oafVBEP+KOeLCU0ev9dGu
         QcEZM2EuIVFq9qVSGgzdj9jnqTBiv2dVZqWPReaWwHdGy1gdqmDn7oMTQOTUBYMrm4kH
         7eRTEmq2C6bq8/xae6yoaqQa45g73ts/DgJrKuxRIfD66i1hf1Xxzat3o81X9wY3erRa
         4cvJvMcJZLXK+ITjHuzNkMEZ9UtcL1Vq1LUMOxaiL6dvIxfvD0rgcprLUrOA57gpF60H
         /Xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=/IzYX9ekXXf7onTNDRhy0rzD0OI0XgiFY+K3R+MvA9A=;
        b=H2lP5vT2iJh0nPG551cHjj0D7Cxkot48PvCL45FOmtLqf5sGBOVeoPjGVDCvNGby4x
         vHWxhi4jvqFvnsN4bI6LRay7M31ErJRlyuTwOPNWjhTCK1JnV6q20kCj22OIJeL4uI4Y
         kX8g2rZrRIPjctvhPqO9lBnTl4FIzcocxVWqRUp9SrQjNgtUf4htEhpEaG596yJSkRuL
         XteIfL+XlWiOQY/OcGFDU8EaqlCX1OPo40OQN4WB7Yh30Lyf+M0gQRGcO1FnC0XKgzF1
         UOXo/0aWCTNNZ+ujh0BqC1OitjyIvtr2o+ZiIp95pTV6ZHoWsw6t7aDrGTJB9NfLig4C
         wEKg==
X-Gm-Message-State: AOAM5302i2G7cFZ4CwDVFQefO8vIuBaHrM4gP0d/9ApwsL5Nk5Td5814
        48TpmSBFqyEl/28bxwTsD78=
X-Google-Smtp-Source: ABdhPJwOXeWsUUvwtVxFSOTG/liBvry3WbgiNRSaXCk4O/6AoD9vAhicr3tugHtb0p7pOx8qnDjRWQ==
X-Received: by 2002:a63:d904:0:b0:372:9faf:5467 with SMTP id r4-20020a63d904000000b003729faf5467mr17491373pgg.196.1646061002852;
        Mon, 28 Feb 2022 07:10:02 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id q8-20020a056a00088800b004bca31c8e56sm14786206pfj.115.2022.02.28.07.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 07:10:02 -0800 (PST)
Date:   Mon, 28 Feb 2022 15:09:55 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Zqiang <qiang.zhang@windriver.com>
Subject: [PATCH] mm/slub: initialize stack depot in boot process
Message-ID: <Yhzlw0GGBeuCALJp@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOOhuoU7T4UqHbzkRAvM+b-gvt+Qtx41va=9ixGgUSWaQ@mail.gmail.com>
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
objects") initializes stack depot while creating cache if SLAB_STORE_USER
flag is set.

This can make kernel crash because a cache can be created in various
contexts. For example if user sets slub_debug=U, kernel crashes
because create_boot_cache() calls stack_depot_init(), which tries to
allocate hash table using memblock_alloc() if slab is not available.
But memblock is also not available at that time.

This patch solves the problem by initializing stack depot early
in boot process if SLAB_STORE_USER debug flag is set globally
or the flag is set to at least one cache.

[ elver@google.com: initialize stack depot depending on slub_debug
  parameter instead of allowing stack_depot_init() can be called
  in kmem_cache_init() for simplicity. ]

Link: https://lkml.org/lkml/2022/2/28/238
Fixes: ba10d4b46655 ("mm/slub: use stackdepot to save stack trace in objects")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h |  1 +
 init/main.c          |  1 +
 mm/slab.c            |  4 ++++
 mm/slob.c            |  4 ++++
 mm/slub.c            | 28 +++++++++++++++++++++++++---
 5 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 37bde99b74af..023f3f71ae35 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -139,6 +139,7 @@ struct mem_cgroup;
 /*
  * struct kmem_cache related prototypes
  */
+void __init kmem_cache_init_early(void);
 void __init kmem_cache_init(void);
 bool slab_is_available(void);
 
diff --git a/init/main.c b/init/main.c
index 65fa2e41a9c0..4fdb7975a085 100644
--- a/init/main.c
+++ b/init/main.c
@@ -835,6 +835,7 @@ static void __init mm_init(void)
 	kfence_alloc_pool();
 	report_meminit();
 	stack_depot_early_init();
+	kmem_cache_init_early();
 	mem_init();
 	mem_init_print_info();
 	kmem_cache_init();
diff --git a/mm/slab.c b/mm/slab.c
index ddf5737c63d9..80a6d01aab06 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1196,6 +1196,10 @@ static void __init set_up_node(struct kmem_cache *cachep, int index)
 	}
 }
 
+void __init kmem_cache_init_early(void)
+{
+}
+
 /*
  * Initialisation.  Called after the page allocator have been initialised and
  * before smp_init().
diff --git a/mm/slob.c b/mm/slob.c
index 60c5842215f1..00e323af8be4 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -715,6 +715,10 @@ struct kmem_cache kmem_cache_boot = {
 	.align = ARCH_KMALLOC_MINALIGN,
 };
 
+void __init kmem_cache_init_early(void)
+{
+}
+
 void __init kmem_cache_init(void)
 {
 	kmem_cache = &kmem_cache_boot;
diff --git a/mm/slub.c b/mm/slub.c
index a74afe59a403..40bcd18143b6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4221,9 +4221,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	s->remote_node_defrag_ratio = 1000;
 #endif
 
-	if (s->flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
-		stack_depot_init();
-
 	/* Initialize the pre-computed randomized freelist if slab is up */
 	if (slab_state >= UP) {
 		if (init_cache_random_seq(s))
@@ -4810,6 +4807,31 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 	return s;
 }
 
+/* Initialize stack depot if needed */
+void __init kmem_cache_init_early(void)
+{
+#ifdef CONFIG_STACKDEPOT
+	slab_flags_t block_flags;
+	char *next_block;
+	char *slab_list;
+
+	if (slub_debug & SLAB_STORE_USER)
+		goto init_stack_depot;
+
+	next_block = slub_debug_string;
+	while (next_block) {
+		next_block = parse_slub_debug_flags(next_block, &block_flags, &slab_list, false);
+		if (block_flags & SLAB_STORE_USER)
+			goto init_stack_depot;
+	}
+
+	return;
+
+init_stack_depot:
+	stack_depot_init();
+#endif
+}
+
 void __init kmem_cache_init(void)
 {
 	static __initdata struct kmem_cache boot_kmem_cache,
-- 
2.33.1
