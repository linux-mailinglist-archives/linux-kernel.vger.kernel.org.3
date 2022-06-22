Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4611554750
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357778AbiFVLr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357785AbiFVLry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:47:54 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F4239807;
        Wed, 22 Jun 2022 04:47:51 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id eo8so23565311edb.0;
        Wed, 22 Jun 2022 04:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=unEr3IBeLbRfuTie0KZCBAqiK12CoDgMmUuwQlpyhLg=;
        b=NG3QUuIDMvohVjJMZ1+2zT989w91r4Nb1HsldcN7QoQrmhVyTjbbBjvY+eO04GmEtQ
         CCXbgVtfW4CxkA8x2TxJszCLX5/6ZYmjbRASkyv07pHVf6NCHgZBWUClzzvjVSrpQZYP
         V1o+YKRjRI3BSVOt7CBsTqAzX2BIFh4umBHipqXWp2W+frg5fZAycX2AWIheoMMN1m2R
         4pfEqesKmZdmTbpYwcpNfh4gh10i5i9GzHQId1W7YxBt7QDnUOD4brikit+tQi5dI9My
         d6rm/F3B4vjDsW49FCTlFqA9bzyDviCm+l9/IFDv8YArwYvSbOLhPCNk7C7O5zrFRaSp
         BAnQ==
X-Gm-Message-State: AJIora+vHuwxHd7dnNjo047W+Tg2pqASvzouiObeQznFgcAmMI4rztgA
        PnR8oHc1wBMXdKtk7MudYwSgD3xn35E=
X-Google-Smtp-Source: AGRyM1tlyIgcyBf9g1gy9o30p1plgkRK8+Mj0aIrQot47xRCx5A9uW0I8RnVpGN8HNYDxN4pIIhuxQ==
X-Received: by 2002:a05:6402:1854:b0:435:7f6e:e553 with SMTP id v20-20020a056402185400b004357f6ee553mr3677495edy.282.1655898469421;
        Wed, 22 Jun 2022 04:47:49 -0700 (PDT)
Received: from tiehlicka.suse.cz ([193.86.92.180])
        by smtp.gmail.com with ESMTPSA id dz21-20020a0564021d5500b0043592bf496fsm4414866edb.38.2022.06.22.04.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 04:47:48 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [RFC PATCH] rcu: back off on allocation failure in fill_page_cache_func
Date:   Wed, 22 Jun 2022 13:47:11 +0200
Message-Id: <20220622114711.28154-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

fill_page_cache_func allocates couple of pages to store
kvfree_rcu_bulk_data. This is a lightweight (GFP_NORETRY) allocation
which can fail under memory pressure. The function will, however keep
retrying even when the previous attempt has failed.

While this is not really incorrect there is one thing to consider. This
allocation is invoked from the WQ context and that means that if the
memory reclaim gets stuck it can hog the worker for quite some time.
WQ concurrency is only triggered when the worker context sleeps and that
is not guaranteed for __GFP_NORETRY allocation attempts (see
should_reclaim_retry).

We have seen WQ lockups
kernel: BUG: workqueue lockup - pool cpus=93 node=1 flags=0x1 nice=0 stuck for 32s!
[...]
kernel: pool 74: cpus=37 node=0 flags=0x1 nice=0 hung=32s workers=2 manager: 2146
kernel:   pwq 498: cpus=249 node=1 flags=0x1 nice=0 active=4/256 refcnt=5
kernel:     in-flight: 1917:fill_page_cache_func
kernel:     pending: dbs_work_handler, free_work, kfree_rcu_monitor

Originaly, we thought that several retries with direct reclaim being
stuck is the underlying reason but we couldn't have confirmed that and
have seen a similar lockups detected even without any heavy memory
pressure so there is likely something else/more going on. On the other
hand failing the allocation shouldn't have a big impact and from the
code it is not really obvious why retrying is desirable so back off
after the allocation failure.

Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Hi,
I am sending this as an RFC because I couldn't prove that the WQ
concurency issue as a result from the allocation retry is really a
problem. On the other hand I couldn't see a good reason to retry after a
previous failure. While the kswapd running in the background could have
released some memory this is a not really guaranteed and mostly a
wishful thinking.

I do not understand the code well enough so I could be easily missing
something. If the patch is a wrong thing to do then it would be really
nice to add a comment why the retry is desirable and a good thing to do.

The retry loop should be bound to rcu_min_cached_objs which is quite
small but configurable so this can get large in some setups.

Thanks

 kernel/rcu/tree.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c25ba442044a..54a3a19c4c0b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3508,15 +3508,16 @@ static void fill_page_cache_func(struct work_struct *work)
 		bnode = (struct kvfree_rcu_bulk_data *)
 			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
-		if (bnode) {
-			raw_spin_lock_irqsave(&krcp->lock, flags);
-			pushed = put_cached_bnode(krcp, bnode);
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
+		if (!bnode)
+			break;
 
-			if (!pushed) {
-				free_page((unsigned long) bnode);
-				break;
-			}
+		raw_spin_lock_irqsave(&krcp->lock, flags);
+		pushed = put_cached_bnode(krcp, bnode);
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+		if (!pushed) {
+			free_page((unsigned long) bnode);
+			break;
 		}
 	}
 
-- 
2.30.2

