Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CFC4B1EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346675AbiBKGtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:49:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346439AbiBKGto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:49:44 -0500
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278121120
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:49:44 -0800 (PST)
Received: by mail-oi1-x249.google.com with SMTP id be36-20020a05680821a400b002cf968c0889so2194411oib.14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Gp3MzKjywklApxzwU7bA0E+IdrMiraVuIp3bbtkpPwY=;
        b=pZFidtCwL5VMsnJRP/9b9wHwk02Whf8q/difXoIKsdZUTOmtfykRIOjUqweW4jqnAY
         8AEQsIf7BJ3qv1w8Ny3VBvWoNOmFTRKN3MfOMCY09iJzuIfqwdWFh7mMh1dOoqJ4ANRG
         kk6Yyu5VN4IsdIxQHdbPDB8jrS384vnBeQ0zTXmINULyixuihlw86O9M7+bkOQkq5FCF
         Lrhhz8wMvYt8tbAjV4cuO7v+/OfmJKzHuP1Xt8E8P3AuoqUne3R/7i1gblDPs3CiLF4I
         Lu2aeoDUQLQNqiMdUjzemZ+fOLmEn6qSvVpIVsT10mL7z1OHdnOzDR/O/QikLdqga1Ns
         Ahuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gp3MzKjywklApxzwU7bA0E+IdrMiraVuIp3bbtkpPwY=;
        b=uDO1f3kJMdy/WO9CkFVxN5zopRFygZqqKmdouXboua2adJCJwtohrd09bX3Nq7niUv
         64mpLCCxhQxEgJaHyP/fKRJSiKLeIe5GzvqLuMmU6ocK4GtzBnd02QBTEcrOrO+3E3VS
         +WcBUrmRZYgv08rpzdVTZk4xil8sJJZKqB8EALotUvfYDgVkRT9wvhcj3RNSGl+nUc+R
         0xtEq8dEiKxT6hmY+Dj5CSRjSl/M7+vWVmmXJHmWLXOVK6FSSreCebp6P/KzeRrQGcqP
         /WulGN7NBSkDbtHTJQ5NPXytKlj2RbUn5j1DTkMNgdFJGdOpQ02Ld2LsVyEJs05Zi9eS
         pg/w==
X-Gm-Message-State: AOAM532dU5VtFvYawzlZ/lps3CZ43bN37Na5fp1nkqFcwiKz4w+oWPko
        3GEeG8p12e3aZ2oxTAgEZhGKmymVe9CgSQ==
X-Google-Smtp-Source: ABdhPJw3ASDB+yZZwSrQEVhj4dACHJ86v54Lv8O291KKTat+VzaAivyC/3ZBnBIy1wraZJwv+qm5+0amn6FRHw==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:9a07:ef1a:2fee:57f1])
 (user=shakeelb job=sendgmr) by 2002:a05:6808:1918:: with SMTP id
 bf24mr473270oib.253.1644562183473; Thu, 10 Feb 2022 22:49:43 -0800 (PST)
Date:   Thu, 10 Feb 2022 22:49:15 -0800
In-Reply-To: <20220211064917.2028469-1-shakeelb@google.com>
Message-Id: <20220211064917.2028469-3-shakeelb@google.com>
Mime-Version: 1.0
References: <20220211064917.2028469-1-shakeelb@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 2/4] memcg: unify force charging conditions
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the kernel force charges the allocations which have __GFP_HIGH
flag without triggering the memory reclaim. __GFP_HIGH indicates that
the caller is high priority and since commit 869712fd3de5 ("mm:
memcontrol: fix network errors from failing __GFP_ATOMIC charges") the
kernel lets such allocations do force charging. Please note that
__GFP_ATOMIC has been replaced by __GFP_HIGH.

__GFP_HIGH does not tell if the caller can block or can trigger reclaim.
There are separate checks to determine that. So, there is no need to
skip reclaiming for __GFP_HIGH allocations. So, handle __GFP_HIGH
together with __GFP_NOFAIL which also does force charging.

Please note that this is a noop change as there are no __GFP_HIGH
allocators in the kernel which also have __GFP_ACCOUNT (or SLAB_ACCOUNT)
and does not allow reclaim for now.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
---
Changes since v1:
- None

 mm/memcontrol.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f12e489ba9b8..292b0b99a2c7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2564,15 +2564,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		goto retry;
 	}
 
-	/*
-	 * Memcg doesn't have a dedicated reserve for atomic
-	 * allocations. But like the global atomic pool, we need to
-	 * put the burden of reclaim on regular allocation requests
-	 * and let these go through as privileged allocations.
-	 */
-	if (gfp_mask & __GFP_HIGH)
-		goto force;
-
 	/*
 	 * Prevent unbounded recursion when reclaim operations need to
 	 * allocate memory. This might exceed the limits temporarily,
@@ -2646,7 +2637,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		goto retry;
 	}
 nomem:
-	if (!(gfp_mask & __GFP_NOFAIL))
+	/*
+	 * Memcg doesn't have a dedicated reserve for atomic
+	 * allocations. But like the global atomic pool, we need to
+	 * put the burden of reclaim on regular allocation requests
+	 * and let these go through as privileged allocations.
+	 */
+	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH)))
 		return -ENOMEM;
 force:
 	/*
-- 
2.35.1.265.g69c8d7142f-goog

