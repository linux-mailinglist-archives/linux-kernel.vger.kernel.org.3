Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06525033C6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiDPFmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 01:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDPFlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 01:41:44 -0400
Received: from camel.birch.relay.mailchannels.net (camel.birch.relay.mailchannels.net [23.83.209.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687CAFCBED
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 22:39:13 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A92A15A0812;
        Sat, 16 Apr 2022 05:39:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0E0E75A041F;
        Sat, 16 Apr 2022 05:39:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650087552; a=rsa-sha256;
        cv=none;
        b=4SXZxwS7usFcejGdUgETrT2yCbFZZB0lsfZtsUDgM99sdQkJ9YgUA2s3BBm8c6WoxSuV/Z
        gZ6O/5ICyUsAyggYyaKZ8JLnAq0bMVlYSZSSrS5qn6Inh9Z5RhQmf99U6KJswX0uf9Nb70
        HtLZe6NMlIiouQqGeMKXhG/DjiyqlHDvfZtPd3k+cZX/A6wocnmKbGBWv8FkDiau8NqKNy
        /HJpa5Cu8U9tS4y3UzLPNExuJ7kUXMuYu3N5ToJ1mkso20vHZ4Drzvs1CIzkMnkme6kPsQ
        PQmcbACRGX4/zWLy+zuOTF3FytavqfLVxamQyBqJ1hnc6hXGW4DIkiW1KoruJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650087552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=MINJwd5OLO59JndE14sJrRNnUCPFbYse28/G1Tm6ZUg=;
        b=sTaubIZYnrvhNGLF8wetyW7Esi2m5P0VyBx2gFW/fqOkLhzuWQoH/Atm6p8XdbgY2HN72e
        c2HdGJeOrgt4LHzf2izQQS4fvpSbcq7mrYxEzKIih6nZFBc/solCM22B6RkP5/bXjWYR+Y
        aRdLjd0SDYwsXOVNn+CSUPkc5xlAqDP1HQx1KmWM9YmEcKqDGhVI18R24NC8gELhGM3QZT
        tSRbYOq7/aUgXFFpg+CtCsUpj51on6UOMcTdt1/upqcJwPmTTv2JOt0kJG+05Gf4cddVZL
        q44Z6qhxQtSCYl7xUcZYMn2lJ0B5P5IFvdlx/oczXqEV0QHXz/W8tjVzPTqI1g==
ARC-Authentication-Results: i=1;
        rspamd-b69d6888c-g7hrr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.158.161 (trex/6.7.1);
        Sat, 16 Apr 2022 05:39:12 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-White: 551691287601fc33_1650087552488_1211284300
X-MC-Loop-Signature: 1650087552488:2168839710
X-MC-Ingress-Time: 1650087552488
Received: from localhost.localdomain (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4KgMSt6gZhz1M5;
        Fri, 15 Apr 2022 22:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1650087551;
        bh=MINJwd5OLO59JndE14sJrRNnUCPFbYse28/G1Tm6ZUg=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=ig+ufRQSyfnVLcYiog8z/3ADVGHTPhIJPTs3FGEh28sxNpFrfhhsNi87iTDg7XSWv
         wKVBlG4mxXB/m0sQXdaYLFnWehjtrB4NmRIz2W7bgFwCZvLxA1Z8OwRBg4Ze4yFZfG
         p5SwVjsN75gVF8rGfeQQlTrr4kkR9Nljh4k2by+dyBiFHI9dB4WChA2otUEwishpPc
         RUtrYSIMA3op2xuk8kz3KoOQWVTukWn2iFqB45tcsqgLTqa2QN2J6eBTmmnb7wvnPD
         JX9LIq3yFzt33jJuNbzXekqsgcj2v5J4CzKAc1r+TO90eEbFBuDMaYdXEhWftI0JGO
         A/nmlgDZaeyHA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] mm/migration: export demotion_path of a node via sysfs
Date:   Fri, 15 Apr 2022 22:39:01 -0700
Message-Id: <20220416053902.68517-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220416053902.68517-1-dave@stgolabs.net>
References: <20220416053902.68517-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a /sys/devices/system/node/nodeX/demotion_path file
to export the possible target(s) in node_demotion[node].

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/stable/sysfs-devices-node |  6 ++++
 drivers/base/node.c                         | 39 +++++++++++++++++++++
 include/linux/migrate.h                     | 15 ++++++++
 mm/migrate.c                                | 15 +-------
 4 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 3c935e1334f7..f620c6ae013c 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -192,3 +192,9 @@ Description:
 		When it completes successfully, the specified amount or more memory
 		will have been reclaimed, and -EAGAIN if less bytes are reclaimed
 		than the specified amount.
+
+What:		/sys/devices/system/node/nodeX/demotion_path
+Date:		April 2022
+Contact:	Davidlohr Bueso <dave@stgolabs.net>
+Description:
+		Shows nodes within the next tier of slower memory below this node.
diff --git a/drivers/base/node.c b/drivers/base/node.c
index d80c478e2a6e..ab4bae777535 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -17,6 +17,7 @@
 #include <linux/nodemask.h>
 #include <linux/cpu.h>
 #include <linux/device.h>
+#include <linux/migrate.h>
 #include <linux/pm_runtime.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
@@ -560,11 +561,49 @@ static ssize_t node_read_distance(struct device *dev,
 }
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
+static ssize_t node_read_demotion_path(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	int nid = dev->id;
+	int len = 0;
+	int i;
+	struct demotion_nodes *nd;
+
+	/*
+	 * buf is currently PAGE_SIZE in length and each node needs 4 chars
+	 * at the most (target + space or newline).
+	 */
+	BUILD_BUG_ON(MAX_NUMNODES * 4 > PAGE_SIZE);
+
+	if (!node_demotion) {
+		len += sysfs_emit_at(buf, len, "%d", NUMA_NO_NODE);
+		goto done;
+	}
+
+	nd = &node_demotion[nid];
+
+	rcu_read_lock();
+	if (nd->nr == 0)
+		len += sysfs_emit_at(buf, len, "%d", NUMA_NO_NODE);
+	else {
+		for (i = 0; i < nd->nr; i++) {
+			len += sysfs_emit_at(buf, len, "%s%d",
+					     i ? " " : "", nd->nodes[i]);
+		}
+	}
+	rcu_read_unlock();
+done:
+	len += sysfs_emit_at(buf, len, "\n");
+	return len;
+}
+static DEVICE_ATTR(demotion_path, 0444, node_read_demotion_path, NULL);
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+	&dev_attr_demotion_path.attr,
 	NULL
 };
 
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 90e75d5a54d6..b0ac6a717e44 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -111,6 +111,21 @@ static inline int migrate_misplaced_page(struct page *page,
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+#define DEFAULT_DEMOTION_TARGET_NODES 15
+
+#if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
+#define DEMOTION_TARGET_NODES	(MAX_NUMNODES - 1)
+#else
+#define DEMOTION_TARGET_NODES	DEFAULT_DEMOTION_TARGET_NODES
+#endif
+
+struct demotion_nodes {
+	unsigned short nr;
+	short nodes[DEMOTION_TARGET_NODES];
+};
+
+extern struct demotion_nodes *node_demotion __read_mostly;
+
 #ifdef CONFIG_MIGRATION
 
 /*
diff --git a/mm/migrate.c b/mm/migrate.c
index 6c31ee1e1c9b..e47ea25fcfe8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2172,20 +2172,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
  * must be held over all reads to ensure that no cycles are
  * observed.
  */
-#define DEFAULT_DEMOTION_TARGET_NODES 15
-
-#if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
-#define DEMOTION_TARGET_NODES	(MAX_NUMNODES - 1)
-#else
-#define DEMOTION_TARGET_NODES	DEFAULT_DEMOTION_TARGET_NODES
-#endif
-
-struct demotion_nodes {
-	unsigned short nr;
-	short nodes[DEMOTION_TARGET_NODES];
-};
-
-static struct demotion_nodes *node_demotion __read_mostly;
+struct demotion_nodes *node_demotion __read_mostly;
 
 /**
  * next_demotion_node() - Get the next node in the demotion path
-- 
2.26.2

