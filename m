Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBC65A070F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 04:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiHYCAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 22:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbiHYCAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 22:00:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748DA60536
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 18:58:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id hf17so252694pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 18:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=McjdVWcg5yH4l5WwS84vMDbd/eUz11zHVMD6I1qs6ic=;
        b=cYthl/MMJngt0CSZxjadIzmfV/4F6CQbLkiCIOV+I6d2c5sS4hrX12ba7QZ81CqesD
         Bt23+2bha3pKEBSxuxuffhbs3eDRPKt67NVESCIcLcCNmqFikHNQhpSHWbUcEqYYrGsu
         tTlzJdaC9n/jTCObNOi0ipQPU9GqG3epAulDLl7znAOBAI6mvVOn+F0gIenmnZwtTM3v
         IZ4U7GnOZ79WOUt7KOysP3jOEaBYfBsaAfZfR76SCFGGLk4+e+yuud8Ef1+I+9g/deUQ
         bnmcPGbGsrn+2Xr5EKFQtDjK2+enaPb5znmEWkmWlooOH4Qr5WzOzxQEDLL0V0Q1syYJ
         Rnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=McjdVWcg5yH4l5WwS84vMDbd/eUz11zHVMD6I1qs6ic=;
        b=S1lIT61NRFh/PUDbj/6/U4XDI8Q3Dj5E9fC9t1vo+nDRroBEna1q7VRY98uYT/oMAb
         Ck2dPixIushzPMvP3S72DAq9/rZniSffpjX3MmcXwUVxYDHQJU7X15g2CUb1YUYYhOGe
         Pgxj5BhttwTk9xB8asNpVkJBSbMn7BpiWTO1jZUhCeCytCgVQPsXo6TFA9lHxrefzc71
         BUwdMGyBVQsQu//wTsJi6/jcuiC7CjSYzrYOcAJUlRXEwhaDOQhRLEn238qHHhrR8OBY
         /KMxoEXzLkL2wmHdGM+nb4KvjKt5bGoAxN7Sp2NAz2KA+XVC0MKOAjinssitwLC2wJka
         r9YA==
X-Gm-Message-State: ACgBeo16fQWDv24dV77DKnTlP+IPABGQiCWOXaEy19nf7Zo0/9l90dxq
        YZfsJJ7hjRmoJjCw6m39m9I=
X-Google-Smtp-Source: AA6agR6o5Mj8VcCRfEZJCxNFLae0gULOPNsYlHRXk1KIUlb2QNCWFuh30xRsM607vLB2FhhpkdLjqw==
X-Received: by 2002:a17:902:ab98:b0:171:2cbc:3d17 with SMTP id f24-20020a170902ab9800b001712cbc3d17mr1683003plr.143.1661392714909;
        Wed, 24 Aug 2022 18:58:34 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79e03000000b0052e78582aa2sm10988872pfq.181.2022.08.24.18.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 18:58:33 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: fix comments about fastpath limitation on PREEMPT_RT
Date:   Thu, 25 Aug 2022 10:57:22 +0900
Message-Id: <20220825015722.1697209-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
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

With PREEMPT_RT disabling interrupt is unnecessary as there is
no user of slab in hardirq context on PREEMPT_RT.

The limitation of lockless fastpath on PREEMPT_RT comes from the fact
that local_lock does not disable preemption on PREEMPT_RT.

Fix comments accordingly.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 30c2ee9e8a29..aa42ac6013b8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -100,7 +100,7 @@
  *   except the stat counters. This is a percpu structure manipulated only by
  *   the local cpu, so the lock protects against being preempted or interrupted
  *   by an irq. Fast path operations rely on lockless operations instead.
- *   On PREEMPT_RT, the local lock does not actually disable irqs (and thus
+ *   On PREEMPT_RT, the local lock does not actually disable preemption (and thus
  *   prevent the lockless operations), so fastpath operations also need to take
  *   the lock and are no longer lockless.
  *
@@ -3185,10 +3185,12 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 	slab = c->slab;
 	/*
 	 * We cannot use the lockless fastpath on PREEMPT_RT because if a
-	 * slowpath has taken the local_lock_irqsave(), it is not protected
-	 * against a fast path operation in an irq handler. So we need to take
-	 * the slow path which uses local_lock. It is still relatively fast if
-	 * there is a suitable cpu freelist.
+	 * slowpath has taken the local_lock which does not disable preemption
+	 * on PREEMPT_RT, it is not protected against a fast path operation in
+	 * another thread that does not take the local_lock.
+	 *
+	 * So we need to take the slow path which uses local_lock. It is still
+	 * relatively fast if there is a suitable cpu freelist.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
 	    unlikely(!object || !slab || !node_match(slab, node))) {
@@ -3457,10 +3459,13 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 #else /* CONFIG_PREEMPT_RT */
 		/*
 		 * We cannot use the lockless fastpath on PREEMPT_RT because if
-		 * a slowpath has taken the local_lock_irqsave(), it is not
-		 * protected against a fast path operation in an irq handler. So
-		 * we need to take the local_lock. We shouldn't simply defer to
-		 * __slab_free() as that wouldn't use the cpu freelist at all.
+		 * a slowpath has taken the local_lock which does not disable
+		 * preemption on PREEMPT_RT, it is not protected against a
+		 * fast path operation in another thread that does not take
+		 * the local_lock.
+		 *
+		 * So we need to take the local_lock. We shouldn't simply defer
+		 * to __slab_free() as that wouldn't use the cpu freelist at all.
 		 */
 		void **freelist;
 
-- 
2.32.0

