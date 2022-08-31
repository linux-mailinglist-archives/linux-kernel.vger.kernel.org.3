Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2E45A8541
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiHaSOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiHaSNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DAFF23C1;
        Wed, 31 Aug 2022 11:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC4D961C5B;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131E5C43143;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=ZZy+CEe3X58TPi2PAPGr5aGa6z9m03nXkRDid1QaiUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGXrTPXSb4TPHXnCBLSOBtXGt0Y94oSzDImoM2jqzg1pHChP8X1dYFbLmekKt0tMv
         8cpWdbxKCA9njeByXWmVnYRH0NLeRKRNtAQTuvwvwmztU652njMUWSsNqYSK0f33ku
         3uSeM9RqwqfbnRxS2ccONiNqjt6T86lni0KjUf4VnUWHoQ1i/O3THV6wB62wSSHP0g
         4C0R1sOsfdC7Il/+S/klZi8MDS9SIg5o2HlLhEKp7moOVSRDqFkgeaqaQtKyiON5Mq
         Hu9UzQhFBgeJaVQzyDLkcF5OgkUM61gqHJfL5QlsAlZ83t8Xi0Zal6ZdRIdsmCw+Uc
         M4JlZ8Q0m9+3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 71A895C0B54; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 14/25] rcu: Set rcu_data structures' initial ->gpwrap value to true
Date:   Wed, 31 Aug 2022 11:11:59 -0700
Message-Id: <20220831181210.2695080-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
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

It would be good do reduce the size of the rcu_gp_oldstate structure
from three unsigned long instances to two, but this requires that the
boot-time optimized grace periods update the various ->gp_seq fields.
Updating these fields in the rcu_state structure and in all of the
rcu_node structures is at least semi-reasonable, but updating them in
all of the rcu_data structures is a bridge too far.  This means that if
there are too many early boot-time grace periods, the ->gp_seq field in
the rcu_data structure cannot be trusted.  This commit therefore sets
each rcu_data structure's ->gpwrap field to provide the necessary impetus
for a suitable level of distrust.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5c4ec9dd4ce70..03b089184b37e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -76,6 +76,7 @@
 /* Data structures. */
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
+	.gpwrap = true,
 #ifdef CONFIG_RCU_NOCB_CPU
 	.cblist.flags = SEGCBLIST_RCU_CORE,
 #endif
-- 
2.31.1.189.g2e36527f23

