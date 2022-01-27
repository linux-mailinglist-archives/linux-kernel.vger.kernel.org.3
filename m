Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18B449E777
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbiA0Q0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiA0Q0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:26:51 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BDEC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:26:51 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id g21-20020a056a0023d500b004cc3a6556c5so1332408pfc.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KUodK6JWWLQPTJW0rhbxzfsRrfCoLGdz3+B3g9F3RKc=;
        b=ll4Oa4ycdKHbS7VMAn+TqIdLrwfpkHqWzLIaXUTNgdnG7ik+KA/KF2oXNTJwlTXNBj
         U0CscAt0h9+Oaxt11SNbOTR7O9U25FDkC5mpzZRdQUOUgsZ2SR6y2l+/d5djldv23+1Z
         IlD7mhZbqpFfxb6+66HXcnxFIYMoNFuHMefKcqE2hT5bu4tniGUcxYiGi1VCEf6yz4av
         XMcQeoE2Px6Y9w6B0jSPglEyn4x/j9v11W2Z9FZwdFuiZVrB54M3Z1fHEubHvCMcK6vF
         6mwlFe567ON++Y7CLEg3LXDqTryexif0pfofp9Aedo3CmL+MiuYQDeAmXimjMoSpk2gm
         XsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KUodK6JWWLQPTJW0rhbxzfsRrfCoLGdz3+B3g9F3RKc=;
        b=vwQIL375vtpcqxNJk4vZ+n7fxGIFyiCSIbC4y8Kz9WbBXLniORRlsNJfqGuD6M2zHt
         Ye3EpDfPOlxuYpRAFpg78BV5N1NhEKBztrU3N1g5mMkKal1Jg0WcLBY8KZPqwf6QowlC
         ZuCnIxYIoXpwkENkod+PP2ANdTRTvEzA2CCT5TopzQO/rMVqfs+nkBwaKkQDzI5fQQZ8
         N+BhLZUbafhyvsZ+ZjrKCJljvdnHmOlGFDbc/ia4n+jbxzH2Ru95eZFKbWRCw2ALZRuI
         G5mtDl8/ctEaaLwUrsQ0VkvYgXF4U3S360MK2zHU8j1eF6rab+HdqHoRhIJy1wTSh2oK
         zfjw==
X-Gm-Message-State: AOAM530bnkh68WhJraw359RxefG+NvWjXQkXfatgZoK+ymRh2CBrQk5a
        41MJrbuxhHS1oxCYe+p7qDxGDkeEk5gvug==
X-Google-Smtp-Source: ABdhPJwGVS5aKq0qBJtwUwgRjFFMbqhJ3nw1k25WYIuIOENgf8IKdho72AED5XohUnQelYpQlDHbEX3qLiuJvw==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:e19:3c48:8d99:dd78])
 (user=shakeelb job=sendgmr) by 2002:a63:4f4f:: with SMTP id
 p15mr3299238pgl.452.1643300810423; Thu, 27 Jan 2022 08:26:50 -0800 (PST)
Date:   Thu, 27 Jan 2022 08:26:36 -0800
Message-Id: <20220127162636.3461256-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] memcg: replace in_interrupt() with !in_task()
From:   Shakeel Butt <shakeelb@google.com>
To:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the deprecated in_interrupt() with !in_task() because
in_interrupt() returns true for BH disabled even if the call happens in
the task context. in_task() is the right interface to differentiate
task context from NMI, hard IRQ and softirq contexts.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d067366002e6..215dfe325e9d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2688,7 +2688,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			READ_ONCE(memcg->swap.high);
 
 		/* Don't bother a random interrupted task */
-		if (in_interrupt()) {
+		if (!in_task()) {
 			if (mem_high) {
 				schedule_work(&memcg->high_work);
 				break;
@@ -6968,7 +6968,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 		return;
 
 	/* Do not associate the sock with unrelated interrupted task's memcg. */
-	if (in_interrupt())
+	if (!in_task())
 		return;
 
 	rcu_read_lock();
-- 
2.35.0.rc0.227.g00780c9af4-goog

