Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6F5033B0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiDPAbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 20:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiDPAax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 20:30:53 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63398DAFD7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:28:21 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650068899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XZZWweDhLkUOzoGjk2nZa3eMTmJYoI0OHNWOPTHZmo=;
        b=DMhX8nIvQXvjHFV70qMe2HbYl7ufGj5tarrp/VQxtL94dab8ieQfSoa2M7kMQFrkbcplx2
        af0PG8XF9znncRJuWufEjWY+jz31+q0YrvSK5EkC++ad5tiL8s6Wgj6llY+spQuR/9TgAU
        rR/TC4qf8RiWHA5dDerrz2aqtXvDAlI=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 2/5] mm: memcontrol: introduce mem_cgroup_ino() and mem_cgroup_get_from_ino()
Date:   Fri, 15 Apr 2022 17:27:53 -0700
Message-Id: <20220416002756.4087977-3-roman.gushchin@linux.dev>
In-Reply-To: <20220416002756.4087977-1-roman.gushchin@linux.dev>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shrinker sysfs requires a way to represent memory cgroups without
using full paths, both for displaying information and getting input
from a user.

Cgroup inode numbers is a perfect way, used by e.g. bpf.

This commit adds a couple of helper functions, which will be used to
represent and interact with memcg-aware shrinkers using shrinkers sysfs.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h |  9 +++++++++
 mm/memcontrol.c            | 23 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index cc16ba262464..299472046000 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -838,6 +838,15 @@ static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 }
 struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
 
+#ifdef CONFIG_SHRINKER_DEBUG
+static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
+{
+	return cgroup_ino(memcg->css.cgroup);
+}
+
+struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
+#endif
+
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
 	return mem_cgroup_from_css(seq_css(m));
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4a3e1300c5a1..030dd637ec7a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5023,6 +5023,29 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
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
2.35.1

