Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BC14B07E9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiBJIPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:15:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbiBJIPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:15:04 -0500
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4000D10A0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:15:06 -0800 (PST)
Received: by mail-ot1-x349.google.com with SMTP id h5-20020a9d5545000000b0059ecbfae94eso3017774oti.17
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ccL+prLnNui1wQO9OJC//pr1nIoZqpsfs/6QLowjnxA=;
        b=pmWp6X7ryarZ+YnBgBkSYNZxfbT8EUlpu8mZWkUUtaqWZTASUegrZGNcgLJM6LDrfa
         sOyZ5paq6lfQOFy7Maq4sHUcY9hzReQFMlxZLwCDGu/xt0EMaw3WG10U2i4brkjeC1ZN
         cTNPjKYzdbfmwoU3+S2uZkl6/qBNFL5mgkZ5IDt/F1jziJdPtD6JcM5+aDpIlRdfgXeG
         ZwDPGoUDwhz7YwmvtmbB011F5qAf/buznwxzhCM7vdskuMAf5xAw1VCbJL70Q2M0x5Rn
         KdTFwyttN8r6iGaw76vM+QZ7PWhQpOvxdEIg08Ms6pYH71vRsTnDCxQsmfoWxtiRLr65
         uIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ccL+prLnNui1wQO9OJC//pr1nIoZqpsfs/6QLowjnxA=;
        b=qvssOm3Jot0kbbh5REEw1kxHjB8akw/DAZXeqDXofYKMRjvAFRh7Fx4JRzKP3AQH/Q
         CBcUC3lV/FgPaIdfAbnFSdC1YpS1dLbxC6t1Ro47J8kemxD1oue7y3rfupy/GT4WlhGu
         HqgAu9Pi94DbO5YNbf9BS5+BFqlHAtGlSakDQLTwMCXfayO75gw67vMecB0iJrSbBQSs
         lJLcPluxi5ICprthHz8sHlODBKZhmE9eylHSkzvGTBcBMqTf1li8xm9gsdhIz8IZSlk2
         tnrqti9132Joiz0pkEkgvQhDXrv6JIQBqheercpZET+2qvIjgGhyxewVHqPZ0G3EscH0
         wYSw==
X-Gm-Message-State: AOAM533uFnyOIQUuV32yM/kiCFhrw2qoauNiFNC/zBkAe2TtDPMQpWD+
        6gzMPmb9B/dYBMudnHzI3wRFqrBMzDVTpw==
X-Google-Smtp-Source: ABdhPJzB3TPZFNIkTQlaHtc3qFPKgIqNHdfKDG4RKgU30NjreLXhCTGWbciK4zFungSiwD0o3q561rgbbNdsbg==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:6801:6774:cb90:c600])
 (user=shakeelb job=sendgmr) by 2002:a05:6808:168a:: with SMTP id
 bb10mr573255oib.246.1644480905495; Thu, 10 Feb 2022 00:15:05 -0800 (PST)
Date:   Thu, 10 Feb 2022 00:14:34 -0800
In-Reply-To: <20220210081437.1884008-1-shakeelb@google.com>
Message-Id: <20220210081437.1884008-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20220210081437.1884008-1-shakeelb@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 1/4] memcg: refactor mem_cgroup_oom
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

The function mem_cgroup_oom returns enum which has four possible values
but the caller does not care about such values and only care if the
return value is OOM_SUCCESS or not. So, remove the enum altogether and
make mem_cgroup_oom returns a simple bool.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a0e9d9f12cf5..c40c27822802 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1795,20 +1795,12 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
 		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
 }
 
-enum oom_status {
-	OOM_SUCCESS,
-	OOM_FAILED,
-	OOM_ASYNC,
-	OOM_SKIPPED
-};
-
-static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
+static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 {
-	enum oom_status ret;
-	bool locked;
+	bool locked, ret = false;
 
 	if (order > PAGE_ALLOC_COSTLY_ORDER)
-		return OOM_SKIPPED;
+		return ret;
 
 	memcg_memory_event(memcg, MEMCG_OOM);
 
@@ -1831,14 +1823,13 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 	 * victim and then we have to bail out from the charge path.
 	 */
 	if (memcg->oom_kill_disable) {
-		if (!current->in_user_fault)
-			return OOM_SKIPPED;
-		css_get(&memcg->css);
-		current->memcg_in_oom = memcg;
-		current->memcg_oom_gfp_mask = mask;
-		current->memcg_oom_order = order;
-
-		return OOM_ASYNC;
+		if (current->in_user_fault) {
+			css_get(&memcg->css);
+			current->memcg_in_oom = memcg;
+			current->memcg_oom_gfp_mask = mask;
+			current->memcg_oom_order = order;
+		}
+		return ret;
 	}
 
 	mem_cgroup_mark_under_oom(memcg);
@@ -1849,10 +1840,7 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 		mem_cgroup_oom_notify(memcg);
 
 	mem_cgroup_unmark_under_oom(memcg);
-	if (mem_cgroup_out_of_memory(memcg, mask, order))
-		ret = OOM_SUCCESS;
-	else
-		ret = OOM_FAILED;
+	ret = mem_cgroup_out_of_memory(memcg, mask, order);
 
 	if (locked)
 		mem_cgroup_oom_unlock(memcg);
@@ -2545,7 +2533,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
 	struct page_counter *counter;
-	enum oom_status oom_status;
 	unsigned long nr_reclaimed;
 	bool passed_oom = false;
 	bool may_swap = true;
@@ -2648,9 +2635,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * a forward progress or bypass the charge if the oom killer
 	 * couldn't make any progress.
 	 */
-	oom_status = mem_cgroup_oom(mem_over_limit, gfp_mask,
-		       get_order(nr_pages * PAGE_SIZE));
-	if (oom_status == OOM_SUCCESS) {
+	if (mem_cgroup_oom(mem_over_limit, gfp_mask,
+			   get_order(nr_pages * PAGE_SIZE))) {
 		passed_oom = true;
 		nr_retries = MAX_RECLAIM_RETRIES;
 		goto retry;
-- 
2.35.1.265.g69c8d7142f-goog

