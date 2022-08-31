Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAE45A8508
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiHaSIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiHaSIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:08:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759D2E396E;
        Wed, 31 Aug 2022 11:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24AABB82271;
        Wed, 31 Aug 2022 18:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9292BC43146;
        Wed, 31 Aug 2022 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969287;
        bh=cuZvf2I96/EDoARq2cU0qVdQPo0+rYUi76tBGq7KBaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLFXKa0NyXxac//Joj5H/FBsrhbUeAfIMRkMIVWysxNVppG0h38AQsEQdhXqJ7EjM
         W65nDQ/bger9XUj3e2zoxMmKUoueNOmfjCFi2FwPIpYjYtRqZv+7QWFpYnQJVe92r7
         gPHoExaZJrPKySqq2mHVvLnYFTyBP//o/xa9sfFHrig2YyJ9L89NnGgnkAoX1J34SF
         6f7ELKE0SMR0sOPn8+dDJnVKo/V+z17lFSUmoEzkl7fhzbyHJxTOZszJ9Mjduy0grd
         9eNcFLYSL6gaLR48YQ7FOBEb7n6Yi6DJAwHZUEc9Vb1VjiAAC74eKTOABUMWX2uJlR
         QBb/0UWIwAMoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0049C5C090A; Wed, 31 Aug 2022 11:08:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Maxim Mikityanskiy <maximmi@nvidia.com>
Subject: [PATCH rcu 06/10] rcu: Update rcu_access_pointer() header for rcu_dereference_protected()
Date:   Wed, 31 Aug 2022 11:08:01 -0700
Message-Id: <20220831180805.2693546-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
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

The rcu_access_pointer() docbook header correctly notes that it may be
used during post-grace-period teardown.  However, it is usually better to
use rcu_dereference_protected() for this purpose.  This commit therefore
calls out this preferred usage.

Reported-by: Maxim Mikityanskiy <maximmi@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f527f27e64387..61a1a85c720c3 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -496,13 +496,21 @@ do {									      \
  * against NULL.  Although rcu_access_pointer() may also be used in cases
  * where update-side locks prevent the value of the pointer from changing,
  * you should instead use rcu_dereference_protected() for this use case.
+ * Within an RCU read-side critical section, there is little reason to
+ * use rcu_access_pointer().
+ *
+ * It is usually best to test the rcu_access_pointer() return value
+ * directly in order to avoid accidental dereferences being introduced
+ * by later inattentive changes.  In other words, assigning the
+ * rcu_access_pointer() return value to a local variable results in an
+ * accident waiting to happen.
  *
  * It is also permissible to use rcu_access_pointer() when read-side
- * access to the pointer was removed at least one grace period ago, as
- * is the case in the context of the RCU callback that is freeing up
- * the data, or after a synchronize_rcu() returns.  This can be useful
- * when tearing down multi-linked structures after a grace period
- * has elapsed.
+ * access to the pointer was removed at least one grace period ago, as is
+ * the case in the context of the RCU callback that is freeing up the data,
+ * or after a synchronize_rcu() returns.  This can be useful when tearing
+ * down multi-linked structures after a grace period has elapsed.  However,
+ * rcu_dereference_protected() is normally preferred for this use case.
  */
 #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
 
-- 
2.31.1.189.g2e36527f23

