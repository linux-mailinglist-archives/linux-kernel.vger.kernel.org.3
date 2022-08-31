Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C25A851C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiHaSLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiHaSKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:10:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C09FE1904;
        Wed, 31 Aug 2022 11:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79179B82272;
        Wed, 31 Aug 2022 18:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407BCC433D7;
        Wed, 31 Aug 2022 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969363;
        bh=ceDPItoNiUMap9R4gIe5pPog2RIqMPTPWZ/pngjibCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojZK7e7g/vPC97dOPizdjJcJQOptdULd1jMc3kllquHhTbrrhHdb74kxQi5WJ3wz3
         Xy6RYLGBq0hb+K6IKwNjgVn/kLcCyoTxpTxAVatUe9eq5Nr3T2yKk66jPTLfXO9F1+
         QVr65rCZtum+0sXzkdULU45/nyeFlkml0+Vf0YunzlBj4v3wuNwMBxgBSspmij/gVN
         a9ZVXBMVRWL3zcLKxHZIcGvxknV1AMkT9VnLqupY1v3BlosG+PY6EQmoDveEWGf98P
         9VMPqcIwLCgzL2S0HkFa2IdZAoL1FtBosgAxeTmobgA0VqFKEGCoFKkxMOZ5uq3nXa
         cUBX0yl0EQgGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 02DBD5C019C; Wed, 31 Aug 2022 11:09:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/3] rcu/kfree: Fix kfree_rcu_shrink_count() return value
Date:   Wed, 31 Aug 2022 11:09:20 -0700
Message-Id: <20220831180921.2694017-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180916.GA2693797@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180916.GA2693797@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

As per the comments in include/linux/shrinker.h, .count_objects callback
should return the number of freeable items, but if there are no objects
to free, SHRINK_EMPTY should be returned. The only time 0 is returned
should be when we are unable to determine the number of objects, or the
cache should be skipped for another reason.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index eb435941e92fd..3d234d536d4c3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3372,7 +3372,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 		atomic_set(&krcp->backoff_page_cache_fill, 1);
 	}
 
-	return count;
+	return count == 0 ? SHRINK_EMPTY : count;
 }
 
 static unsigned long
-- 
2.31.1.189.g2e36527f23

