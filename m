Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4994AA3FE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376323AbiBDXIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377896AbiBDXII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:08:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816E9DF99CE4;
        Fri,  4 Feb 2022 15:08:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2302B61BB9;
        Fri,  4 Feb 2022 23:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2425CC340F6;
        Fri,  4 Feb 2022 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016087;
        bh=HtrXU6XavCULFLTGswh4umGI+avoB5uYHWhzGpWLZXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BmI+L8KAmubNxgJ795HEDlDRj4rXhcbDQ3pLpxzVFKHEQop3Tq3tK53DOjvQibsVW
         jX/Aa+BSVnoFknjOBOHpO0I5wBlMBnBkayQTucETiEW/GAxW2ErFznEl37dTe5U5gn
         hCbbno3nQ9t6uzfaXhbtzWgPFH0nzAP9A00BjIyArkXpHDGwIu2vVeO1LeBpIMA9KO
         o8FHQRQ56yqKBsK4e6MiHvrcM8sFZuo2UKHTz2BfH3yvfOYrvWJJU5pYae4T40kLir
         YYrZaeNZJ+al2h+LbDN1sG9Kjlp+OgxL4672PeLUhR3I1wstEaNPpWedSXxHcOacdj
         xp97qdjgnz2nQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A05CC5C0A0A; Fri,  4 Feb 2022 15:08:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 6/9] rcu: Mark writes to the rcu_segcblist structure's ->flags field
Date:   Fri,  4 Feb 2022 15:08:02 -0800
Message-Id: <20220204230805.4193767-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCSAN reports data races between the rcu_segcblist_clear_flags() and
rcu_segcblist_set_flags() functions, though misreporting the latter
as a call to rcu_segcblist_is_enabled() from call_rcu().  This commit
converts the updates of this field to WRITE_ONCE(), relying on the
resulting unmarked reads to continue to detect buggy concurrent writes
to this field.

Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu_segcblist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index e373fbe44da5e..431cee212467d 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -56,13 +56,13 @@ static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
 static inline void rcu_segcblist_set_flags(struct rcu_segcblist *rsclp,
 					   int flags)
 {
-	rsclp->flags |= flags;
+	WRITE_ONCE(rsclp->flags, rsclp->flags | flags);
 }
 
 static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
 					     int flags)
 {
-	rsclp->flags &= ~flags;
+	WRITE_ONCE(rsclp->flags, rsclp->flags & ~flags);
 }
 
 static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
-- 
2.31.1.189.g2e36527f23

