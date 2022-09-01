Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F195AA2B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiIAWSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiIAWSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:00 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AF95809E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:17:59 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j17so205318qtp.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ocxsdgSxr9WyJwVb16iinpfYqPxMSVghGuyFQwZXQfs=;
        b=ti/1WG1u8VpXWufM64ni12DTreKGCzniiXPz9JlY5rrgucCra9WVKDdRPJHpbwSpxj
         iG++ZS/nv4W4EuHP+8BlbKh7cvUFrg0n06h/UoIiKDHin6Qnra6rJCmg3+AA9tjOu7oI
         ZELEHVazqBBYH+5PbuvWb3Wxw/KtdCPykBIsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ocxsdgSxr9WyJwVb16iinpfYqPxMSVghGuyFQwZXQfs=;
        b=nXGVQGljQ83KZIHaCZ4I85MTpji7DO1HIbGpBdYgVJLh7DZcZMbE+uSY+BZryN+2Nu
         y0dMwME2u2MwZxryTBi/YPAPtn9SB9QzZ6+Wf9sJ56hb+Zj+orHICgsIM0kJa72G5fKa
         di272phBRzYke+j61PyER7tFy3stOFx/vwwqnRcVxmuxvje7xFFdV+ypnNhNitdW0OV6
         0//7UkSKs1zPoelE9XHtuxhoU7AN5i2Ys+WnMd9+4VAEPb8qgP2L1Zu015Y0L4g2No0l
         WZ33C0kPnrLPW/4nZsWFzlfK7oCMCuxZxpX5kWLNEWZdNEPweVdaikNYxit3bNQOd6Ax
         eMjg==
X-Gm-Message-State: ACgBeo0QUI7VHcUhbxuQt+IoQC0pzRz80CCtuy6bkLAiF86Qp3qPrbxv
        ZZzFtF3OBEdURO+/aD7jmpJk2g==
X-Google-Smtp-Source: AA6agR6eIoBqsq90vcCegOqFmOL0xyor84GJfMSmDM+50XbL31b6MpOWJKpxG/NZU2dOPdvIGdA/1Q==
X-Received: by 2002:ac8:5f53:0:b0:343:a8d0:c81b with SMTP id y19-20020ac85f53000000b00343a8d0c81bmr25798028qta.489.1662070678847;
        Thu, 01 Sep 2022 15:17:58 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:17:58 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v5 02/18] mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head
Date:   Thu,  1 Sep 2022 22:17:04 +0000
Message-Id: <20220901221720.1105021-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vlastimil Babka <vbabka@suse.cz>

Joel reports [1] that increasing the rcu_head size for debugging
purposes used to work before struct slab was split from struct page, but
now runs into the various SLAB_MATCH() sanity checks of the layout.

This is because the rcu_head in struct page is in union with large
sub-structures and has space to grow without exceeding their size, while
in struct slab (for SLAB and SLUB) it's in union only with a list_head.

On closer inspection (and after the previous patch) we can put all
fields except slab_cache to a union with rcu_head, as slab_cache is
sufficient for the rcu freeing callbacks to work and the rest can be
overwritten by rcu_head without causing issues.

This is only somewhat complicated by the need to keep SLUB's
freelist+counters aligned for cmpxchg_double. As a result the fields
need to be reordered so that slab_cache is first (after page flags) and
the union with rcu_head follows. For consistency, do that for SLAB as
well, although not necessary there.

As a result, the rcu_head field in struct page and struct slab is no
longer at the same offset, but that doesn't matter as there is no
casting that would rely on that in the slab freeing callbacks, so we can
just drop the respective SLAB_MATCH() check.

Also we need to update the SLAB_MATCH() for compound_head to reflect the
new ordering.

While at it, also add a static_assert to check the alignment needed for
cmpxchg_double so mistakes are found sooner than a runtime GPF.

[1] https://lore.kernel.org/all/85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org/

Reported-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h | 54 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 4ec82bec15ec..2c248864ea91 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -11,37 +11,43 @@ struct slab {
 
 #if defined(CONFIG_SLAB)
 
+	struct kmem_cache *slab_cache;
 	union {
-		struct list_head slab_list;
+		struct {
+			struct list_head slab_list;
+			void *freelist;	/* array of free object indexes */
+			void *s_mem;	/* first object */
+		};
 		struct rcu_head rcu_head;
 	};
-	struct kmem_cache *slab_cache;
-	void *freelist;	/* array of free object indexes */
-	void *s_mem;	/* first object */
 	unsigned int active;
 
 #elif defined(CONFIG_SLUB)
 
-	union {
-		struct list_head slab_list;
-		struct rcu_head rcu_head;
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-		struct {
-			struct slab *next;
-			int slabs;	/* Nr of slabs left */
-		};
-#endif
-	};
 	struct kmem_cache *slab_cache;
-	/* Double-word boundary */
-	void *freelist;		/* first free object */
 	union {
-		unsigned long counters;
 		struct {
-			unsigned inuse:16;
-			unsigned objects:15;
-			unsigned frozen:1;
+			union {
+				struct list_head slab_list;
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+				struct {
+					struct slab *next;
+					int slabs;	/* Nr of slabs left */
+				};
+#endif
+			};
+			/* Double-word boundary */
+			void *freelist;		/* first free object */
+			union {
+				unsigned long counters;
+				struct {
+					unsigned inuse:16;
+					unsigned objects:15;
+					unsigned frozen:1;
+				};
+			};
 		};
+		struct rcu_head rcu_head;
 	};
 	unsigned int __unused;
 
@@ -66,9 +72,10 @@ struct slab {
 #define SLAB_MATCH(pg, sl)						\
 	static_assert(offsetof(struct page, pg) == offsetof(struct slab, sl))
 SLAB_MATCH(flags, __page_flags);
-SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
 #ifndef CONFIG_SLOB
-SLAB_MATCH(rcu_head, rcu_head);
+SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
+#else
+SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
 #endif
 SLAB_MATCH(_refcount, __page_refcount);
 #ifdef CONFIG_MEMCG
@@ -76,6 +83,9 @@ SLAB_MATCH(memcg_data, memcg_data);
 #endif
 #undef SLAB_MATCH
 static_assert(sizeof(struct slab) <= sizeof(struct page));
+#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && defined(CONFIG_SLUB)
+static_assert(IS_ALIGNED(offsetof(struct slab, freelist), 16));
+#endif
 
 /**
  * folio_slab - Converts from folio to slab.
-- 
2.37.2.789.g6183377224-goog

