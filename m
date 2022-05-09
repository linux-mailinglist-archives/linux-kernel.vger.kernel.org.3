Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5313B5204A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbiEISmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbiEISm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:42:27 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F4D26084D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:38:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652121511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7yqlEFZDQsrcQFeTz8EFzx9rgYk0i5CEIpAH0i4ulA=;
        b=xl/szZ3Ak9hLsVXMZIyVLhsP7L6EdVYibFE1x6wt/+BDQrOlFwGeFlXbNuS8zeDDqZaNO9
        JTCF9fGQGAUFA6fms/EFouu/UD2j1FYFlaP7xNjt773pfH2P2sonCkG9i3+Kd0NxDcjz71
        tWqMIBNy1sQ1DVBhaeW2qXhI9AZACRs=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v3 1/6] mm: memcontrol: introduce mem_cgroup_ino() and mem_cgroup_get_from_ino()
Date:   Mon,  9 May 2022 11:38:15 -0700
Message-Id: <20220509183820.573666-2-roman.gushchin@linux.dev>
In-Reply-To: <20220509183820.573666-1-roman.gushchin@linux.dev>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shrinker debugfs requires a way to represent memory cgroups without
using full paths, both for displaying information and getting input
from a user.

Cgroup inode number is a perfect way, already used by bpf.

This commit adds a couple of helper functions which will be used
to handle memcg-aware shrinkers.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 21 +++++++++++++++++++++
 mm/memcontrol.c            | 23 +++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fe580cb96683..a6de9e5c1549 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -831,6 +831,15 @@ static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 }
 struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
 
+#ifdef CONFIG_SHRINKER_DEBUG
+static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
+{
+	return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
+}
+
+struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
+#endif
+
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
 	return mem_cgroup_from_css(seq_css(m));
@@ -1324,6 +1333,18 @@ static inline struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 	return NULL;
 }
 
+#ifdef CONFIG_SHRINKER_DEBUG
+static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
+{
+	return 0;
+}
+
+static inline struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
+{
+	return NULL;
+}
+#endif
+
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
 	return NULL;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 04cea4fa362a..e6472728fa66 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5018,6 +5018,29 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 	return idr_find(&mem_cgroup_idr, id);
 }
 
+#ifdef CONFIG_SHRINKER_DEBUG
+struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
+{
+	struct cgroup *cgrp;
+	struct cgroup_subsys_state *css;
+	struct mem_cgroup *memcg;
+
+	cgrp = cgroup_get_from_id(ino);
+	if (!cgrp)
+		return ERR_PTR(-ENOENT);
+
+	css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
+	if (css)
+		memcg = container_of(css, struct mem_cgroup, css);
+	else
+		memcg = ERR_PTR(-ENOENT);
+
+	cgroup_put(cgrp);
+
+	return memcg;
+}
+#endif
+
 static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
-- 
2.35.3

