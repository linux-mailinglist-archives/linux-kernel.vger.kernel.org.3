Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971E84AA470
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378260AbiBDXjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47868 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378223AbiBDXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB21B61C12;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245D5C340ED;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=GiLrQ3LZHqRBis8jo4OGf4RQr8OnWDgZfbmOreYAyMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0lG4kL5LGHXvjH7vnxUId9ZbQvzm8X/+B9WefPgJWzq0Ug2D97o7gHKwFEqtnYHQ
         f8VOtFwA9jRK0gYUicubYeiZpge1GQzcnzTheDJdR7+nzHOadvqYhbvD2gBhwnNijV
         c1fUaAYivxO0UiwxJAlDe5sal6hXtBINJDsR3spMQhH3L3/+11Ye6A/VpCdnmc21Yu
         cwva3hZm3zKvz/r1F7PFg+6OAtdIkRB9Rv+UzzBO2aVfdOSKiQdWgyzK4xkeYqQ6bv
         fOwn/hT2rYpfNluiYeuy3d3QzRmzq1RkFt/uKbNw2RwZGlml46WrX1eAWsoMzr2Mz/
         DEtDr24/y6kAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E98DD5C0829; Fri,  4 Feb 2022 15:39:03 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/19] srcu: Fix s/is/if/ typo in srcu_node comment
Date:   Fri,  4 Feb 2022 15:38:45 -0800
Message-Id: <20220204233902.1902-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixed a typo in the srcu_node structure's ->srcu_have_cbs
comment.  While in the area, redo a couple of comments to take advantage
of 100-character line lengths.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index cb1f4351e8baa..4025840ba9a38 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -47,11 +47,9 @@ struct srcu_data {
  */
 struct srcu_node {
 	spinlock_t __private lock;
-	unsigned long srcu_have_cbs[4];		/* GP seq for children */
-						/*  having CBs, but only */
-						/*  is > ->srcu_gq_seq. */
-	unsigned long srcu_data_have_cbs[4];	/* Which srcu_data structs */
-						/*  have CBs for given GP? */
+	unsigned long srcu_have_cbs[4];		/* GP seq for children having CBs, but only */
+						/*  if greater than ->srcu_gq_seq. */
+	unsigned long srcu_data_have_cbs[4];	/* Which srcu_data structs have CBs for given GP? */
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
 	struct srcu_node *srcu_parent;		/* Next up in tree. */
 	int grplo;				/* Least CPU for node. */
-- 
2.31.1.189.g2e36527f23

