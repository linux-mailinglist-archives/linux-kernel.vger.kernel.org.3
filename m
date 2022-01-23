Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52DC496F8D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 02:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiAWBg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 20:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiAWBg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 20:36:26 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14089C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 17:36:26 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jx6so11154087ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 17:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VhpcLgiTZRWgcJmPmiVIMS50KRCO7XHLKSYxNUWC3Pk=;
        b=BwP/7FGLsImZA/ogpCkSY5lZvCJJ8j+FLvn7VvSSKMs/sl3M38tLK6tIh92n7VJgjT
         FlHwj2kbF2ACOp5FBBg3owK9k3MLpnK7zu6rKQTA8mv3817ztvjVpYLF1V8B4TV057F2
         YMdLe0NucazEB/8533um7kVLQvixWyNEyYLM3fX7C3xo1k2xBaNeGQwRtGHkGHUSxPqJ
         gFBs+s9BTBHqsI3dm+/AEsBoEs0mLUzP0+8Su72My3EdBaJz4TDmWeG/AeaRvHtuqkmj
         qWvOIByDQFg7bhzawpNeN/ogTQkgmdm0wUlqs3V3jd5AIwq6yf52hU9xqM2yCdji2Bu6
         xgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VhpcLgiTZRWgcJmPmiVIMS50KRCO7XHLKSYxNUWC3Pk=;
        b=qmV0X+F8P11pzIZxlo4kMix4DxkytoDZwnVvTLkdpx3ee3XgOs1hLTBfc5UYZIucnB
         Z28AlgmtXCmjcUClwNSSCCYLcR4DD6WypaRgaPrbAj19Pe4EkafrnZKw905LAdrsPPd4
         jNsEWOr1HX7ihkV2Q+wRNWJXZ49CsbD30M5ikzsg96UQD0QhuSqdOGnIc1BjgS3xqowQ
         5/xvikVnVv7xlRA/MDo59BqnGB1f9L3eC/XO+9nkCAGq1vik4x/tnVA+2s5DIyTyot52
         hg4JuNS0sS1rVUuE9svj9aA+V3ZnGX/srRcAiOXTRPbCleoBuDuBVjGsGjT/tc1m7L3u
         iWrQ==
X-Gm-Message-State: AOAM532dSjFbwfQTarynRXUIcuKqmr0Bc1O+aiLN0uPVTXNYQIEAzkDb
        LcsoGxaCm4Iz0ADFC6ZG9sU=
X-Google-Smtp-Source: ABdhPJzxPNAk450iZZImi9mVv6fGFRHEmD4pFY/kdULLN8Xhv+qFtBziYcfyBJq7RbkriFDGqStJdA==
X-Received: by 2002:a17:907:d11:: with SMTP id gn17mr1496723ejc.559.1642901784601;
        Sat, 22 Jan 2022 17:36:24 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y23sm4251117edo.31.2022.01.22.17.36.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jan 2022 17:36:24 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Krupa Ramakrishnan <krupa.ramakrishnan@amd.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 2/2] mm/page_alloc: add penalty to local_node
Date:   Sun, 23 Jan 2022 01:35:37 +0000
Message-Id: <20220123013537.20491-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220123013537.20491-1-richard.weiyang@gmail.com>
References: <20220123013537.20491-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'Commit 54d032ced983 ("mm/page_alloc: use accumulated load when building
node fallback list")' fix a bug on zonelist order. This let me think
about what would happen if we have a node system with the following
distance matrix.

   Node 0  1  2  3  4  5  6  7
   ----------------------------
   0    10 12 12 12 32 32 32 32
   1    12 10 12 12 32 32 32 32
   2    12 12 10 12 32 32 32 32
   3    12 12 12 10 32 32 32 32
   4    32 32 32 32 10 12 12 12
   5    32 32 32 32 12 10 12 12
   6    32 32 32 32 12 12 10 12
   7    32 32 32 32 12 12 12 10

Unfortunately for this case, the node fallback list gets built like this:

   Node Fallback list
   ---------------------
    0:   0  1  2  3  4  5  6  7
    1:   1  0  2  3  5  6  7  4
    2:   2  3  0  1  6  7  4  5
    3:   3  2  0  1  7  4  5  6
    4:   4  5  6  7  0  1  2  3
    5:   5  4  6  7  1  2  3  0
    6:   6  7  4  5  2  3  0  1
    7:   7  6  4  5  3  0  1  2

We found the order in diagonal block is not expected. The reason is we
don't penalty local node.

After penalty local node, the node fallback list gets built like this:

   Node Fallback list
   ---------------------
   0:   0  1  2  3  4  5  6  7
   1:   1  2  3  0  5  6  7  4
   2:   2  3  0  1  6  7  4  5
   3:   3  0  1  2  7  4  5  6
   4:   4  5  6  7  0  1  2  3
   5:   5  6  7  4  1  2  3  0
   6:   6  7  4  5  2  3  0  1
   7:   7  4  5  6  3  0  1  2

Now the fallback list is in round-robin order.

I am not very familiar with the node distance pattern, while I tried the
following distance matrix. Both of them works with this change.

   Node 0  1  2  3
   ----------------
   0    10 10 10 10
   1    10 10 10 10
   2    10 10 10 10
   3    10 10 10 10

   Node 0  1  2  3  4  5  6  7
   ----------------------------
   0    10 10 10 10 32 32 32 32
   1    10 10 10 10 32 32 32 32
   2    10 10 10 10 32 32 32 32
   3    10 10 10 10 32 32 32 32
   4    32 32 32 32 10 10 10 10
   5    32 32 32 32 10 10 10 10
   6    32 32 32 32 10 10 10 10
   7    32 32 32 32 10 10 10 10

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Krupa Ramakrishnan <krupa.ramakrishnan@amd.com>
CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f27afd517652..0cc25429a17e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6260,8 +6260,9 @@ static void build_zonelists(pg_data_t *pgdat)
 		 * So adding penalty to the first node in same
 		 * distance group to make it round-robin.
 		 */
-		if (node_distance(local_node, node) !=
-		    node_distance(local_node, prev_node))
+		if ((node_distance(local_node, node) !=
+		    node_distance(local_node, prev_node)) ||
+		    node == local_node)
 			node_load[node] += nr_online_nodes;
 
 		node_order[nr_nodes++] = node;
-- 
2.33.1

