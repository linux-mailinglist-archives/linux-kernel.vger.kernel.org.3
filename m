Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B179496F8C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 02:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiAWBg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 20:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiAWBgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 20:36:25 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183A7C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 17:36:25 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a8so11100116ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 17:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=/ZCgQgGKKxuFU4Nc2E9u25znTcXk1hn09RecLC7scws=;
        b=MbXHNMzBMwEcYBM/4/gKidZaeov8wZYdIOiTKGjTbE7GetmOeRwTtSRbfO4L5gGGnG
         WAhXxcYLqcOeYD282LT2Lg1FcACo0KLKn1hJfHWZv2C+45+XVwIGDb7D5SQMsufPndoW
         IvXaXC9l0/ToipdlnW1mZt/zIoxcLIjkPiBfhiA41UpXSQ5Q7iphVv7gBdTqfYr1UYWp
         9vqGe46zcjHvQcckxt1uh4ckBG5MhoRrfLj5cTr1njwyjVlbSA/GFkjr8wDF4lme0s2E
         bNkV5cePl+used01vP1knIOmsrZW3trvxlTlwQs6QeHtWd6udgaHeuP1YORc55BdlODx
         +Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ZCgQgGKKxuFU4Nc2E9u25znTcXk1hn09RecLC7scws=;
        b=Bg1LZ2zocu33pOYyTlYOyJzvskEttYFUl6xp4XYnMbLL7BIYRCyNlDIYbw/0UfwLVP
         Prr33GFr2FG6Ocu2c4Nin1tqRTszf6oOoCPWxEwrN0J2t+TiRK84h0H7VP+sbE+YE5Pl
         wlmNnVT0dtzJu49c7zwiV0THg2Bpx5zIIuAZKdZucZtu27MCTq2STM6GWYibQ4gFOhIX
         DLOSgmiJnpqhuJxsGH0aX2ZQzod0lstXfd4OOyg6D1wbz2NWCdSw+GQOA9NxtDRdJAHc
         h1TynlZSMUCcUgYj6eaPI3L/ZeW4gpCBGZnbegPlqFEDZQ61nQvkaE/Qv83+44x/HrlG
         MDYQ==
X-Gm-Message-State: AOAM530ko9pzKfw49jlaqEblC4bvKk3WIvn0ykn1rg9yG2O09W5XOF1V
        NXWgImKxY3eClgZMdf4/ILM=
X-Google-Smtp-Source: ABdhPJx2zCmZxPhYnCzWe2/KXiYIUAMMgFsYOJmgWiZuJK28PutRvLH/dqrYEef7uxR0V+KSOWjyOA==
X-Received: by 2002:a17:906:2f0c:: with SMTP id v12mr8245070eji.761.1642901783557;
        Sat, 22 Jan 2022 17:36:23 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k23sm3336247ejr.65.2022.01.22.17.36.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jan 2022 17:36:23 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/2] mm/page_alloc: add same penalty is enough to get round-robin order
Date:   Sun, 23 Jan 2022 01:35:36 +0000
Message-Id: <20220123013537.20491-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make node order in round-robin in the same distance group, we add a
penalty to the first node we got in each round.

To get a round-robin order in the same distance group, we don't need to
decrease the penalty since:

  * find_next_best_node() always iterates node in the same order
  * distance matters more then penalty in find_next_best_node()
  * in nodes with the same distance, the first one would be picked up

So it is fine to increase same penalty when we get the first node in the
same distance group.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/page_alloc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..f27afd517652 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6245,13 +6245,12 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
 static void build_zonelists(pg_data_t *pgdat)
 {
 	static int node_order[MAX_NUMNODES];
-	int node, load, nr_nodes = 0;
+	int node, nr_nodes = 0;
 	nodemask_t used_mask = NODE_MASK_NONE;
 	int local_node, prev_node;
 
 	/* NUMA-aware ordering of nodes */
 	local_node = pgdat->node_id;
-	load = nr_online_nodes;
 	prev_node = local_node;
 
 	memset(node_order, 0, sizeof(node_order));
@@ -6263,11 +6262,10 @@ static void build_zonelists(pg_data_t *pgdat)
 		 */
 		if (node_distance(local_node, node) !=
 		    node_distance(local_node, prev_node))
-			node_load[node] += load;
+			node_load[node] += nr_online_nodes;
 
 		node_order[nr_nodes++] = node;
 		prev_node = node;
-		load--;
 	}
 
 	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
-- 
2.33.1

