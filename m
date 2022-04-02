Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1CD4F0035
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbiDBJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiDBJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:52:35 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD86580C5;
        Sat,  2 Apr 2022 02:50:42 -0700 (PDT)
Message-ID: <121a6930-9ebd-e488-e109-273a403a93cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648893038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vKOjx/Vt8DqRqzPiULw6+4zObfqOlUna1mMji8AreA=;
        b=GCDVvvldK54YpIP+KOfOQhHpt69SxANUSlLD/C34pER3EBbkJbNBWXHDBjT2RDteFFsMqo
        UyDy4L5mksUO6f84JTm1nd74N1tUkhUfSM4WMiHV6O/RUcnvdmU9k46FC/ICR/bcWVrIx8
        LgQTzM/jAcNRA6vukrkKok3P6GDoFLM=
Date:   Sat, 2 Apr 2022 12:50:37 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: [PATCH v2] nft: memcg accounting for dynamically allocated objects
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     kernel@openvz.org, Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <935e4270-9e0e-4cd0-ffb4-9c1eb3d9c56e@linux.dev>
Content-Language: en-US
In-Reply-To: <935e4270-9e0e-4cd0-ffb4-9c1eb3d9c56e@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

nft_*.c files whose NFT_EXPR_STATEFUL flag is set on need to
use __GFP_ACCOUNT flag for objects that are dynamically
allocated from the packet path.

Such objects are allocated inside nft_expr_ops->init() callbacks
executed in task context while processing netlink messages.

In addition, this patch adds accounting to nft_set_elem_expr_clone()
used for the same purposes.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
v2: removed accounting in nft_expr_ops->clone() callbacks
---
 net/netfilter/nf_tables_api.c | 2 +-
 net/netfilter/nft_connlimit.c | 2 +-
 net/netfilter/nft_counter.c   | 2 +-
 net/netfilter/nft_last.c      | 2 +-
 net/netfilter/nft_limit.c     | 2 +-
 net/netfilter/nft_quota.c     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 04be94236a34..e01241151ef7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5447,7 +5447,7 @@ int nft_set_elem_expr_clone(const struct nft_ctx *ctx, struct nft_set *set,
 	int err, i, k;
 
 	for (i = 0; i < set->num_exprs; i++) {
-		expr = kzalloc(set->exprs[i]->ops->size, GFP_KERNEL);
+		expr = kzalloc(set->exprs[i]->ops->size, GFP_KERNEL_ACCOUNT);
 		if (!expr)
 			goto err_expr;
 
diff --git a/net/netfilter/nft_connlimit.c b/net/netfilter/nft_connlimit.c
index 3362417ebfdb..f5df535bcbd0 100644
--- a/net/netfilter/nft_connlimit.c
+++ b/net/netfilter/nft_connlimit.c
@@ -77,7 +77,7 @@ static int nft_connlimit_do_init(const struct nft_ctx *ctx,
 			invert = true;
 	}
 
-	priv->list = kmalloc(sizeof(*priv->list), GFP_KERNEL);
+	priv->list = kmalloc(sizeof(*priv->list), GFP_KERNEL_ACCOUNT);
 	if (!priv->list)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index f179e8c3b0ca..7691e42f6bbe 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -62,7 +62,7 @@ static int nft_counter_do_init(const struct nlattr * const tb[],
 	struct nft_counter __percpu *cpu_stats;
 	struct nft_counter *this_cpu;
 
-	cpu_stats = alloc_percpu(struct nft_counter);
+	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_KERNEL_ACCOUNT);
 	if (cpu_stats == NULL)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_last.c b/net/netfilter/nft_last.c
index 4f745a409d34..97d0d09d48d3 100644
--- a/net/netfilter/nft_last.c
+++ b/net/netfilter/nft_last.c
@@ -30,7 +30,7 @@ static int nft_last_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	u64 last_jiffies;
 	int err;
 
-	last = kzalloc(sizeof(*last), GFP_KERNEL);
+	last = kzalloc(sizeof(*last), GFP_KERNEL_ACCOUNT);
 	if (!last)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_limit.c b/net/netfilter/nft_limit.c
index a726b623963d..c1f7e8bb33e6 100644
--- a/net/netfilter/nft_limit.c
+++ b/net/netfilter/nft_limit.c
@@ -90,7 +90,7 @@ static int nft_limit_init(struct nft_limit_priv *priv,
 				 priv->rate);
 	}
 
-	priv->limit = kmalloc(sizeof(*priv->limit), GFP_KERNEL);
+	priv->limit = kmalloc(sizeof(*priv->limit), GFP_KERNEL_ACCOUNT);
 	if (!priv->limit)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_quota.c b/net/netfilter/nft_quota.c
index f394a0b562f6..0d2f55900f7b 100644
--- a/net/netfilter/nft_quota.c
+++ b/net/netfilter/nft_quota.c
@@ -90,7 +90,7 @@ static int nft_quota_do_init(const struct nlattr * const tb[],
 			return -EOPNOTSUPP;
 	}
 
-	priv->consumed = kmalloc(sizeof(*priv->consumed), GFP_KERNEL);
+	priv->consumed = kmalloc(sizeof(*priv->consumed), GFP_KERNEL_ACCOUNT);
 	if (!priv->consumed)
 		return -ENOMEM;
 
-- 
2.31.1

