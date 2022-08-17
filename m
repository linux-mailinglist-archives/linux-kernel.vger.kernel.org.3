Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE906597436
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbiHQQ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbiHQQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:27:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908DAA0329
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:27:38 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660753657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uD14oDgx3FWYy2lpa5ke4a7FAfpDJmqbWQP4XZyslYQ=;
        b=pwMEWV1ORtsBhWwUa8v7DjvJNCSvXYXfvaI1nzWmFzO34axX2YU1OwIEv00HeOxx9EskLh
        n+X76iezbyBUafup4Bs87iFbG7f4r2MULKgdyTvJq2kbNQ2tZDpIyJqLJ72ZwmkNQT59QD
        5y2qy0qOmjLmW1nRTLrHlwYrnBUfe4IV0pdjgIh1shupwHaZTqPkgTXGR/Q7SveBeNCjlt
        qXEqH/eXj2NqFfKLq/rYcI9lCgqib3CTeGepPoQMDcTGRJ5ZVlpVKAGEhBZYoOs69OQ61e
        RIcQp/kgnY+LkE3zxJWz14klf9oOPJMCpCQ7jJ1k271/8RS1qLUBQnKfblyOrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660753657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uD14oDgx3FWYy2lpa5ke4a7FAfpDJmqbWQP4XZyslYQ=;
        b=w/DxSHF39+Tt6W/BvI0ZfDJidVshXYBpD/T6BXvbSwmFZMmR2HP2P4v1x02SJAGzL+riKK
        Df1TwmEPcoJlPPBA==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/9] mm/vmstat: Use preempt_[dis|en]able_nested()
Date:   Wed, 17 Aug 2022 18:26:58 +0200
Message-Id: <20220817162703.728679-5-bigeasy@linutronix.de>
In-Reply-To: <20220817162703.728679-1-bigeasy@linutronix.de>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace the open coded CONFIG_PREEMPT_RT conditional
preempt_enable/disable() pairs with the new helper functions which hide
the underlying implementation details.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/vmstat.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 373d2730fcf21..d514fe7f90af0 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -355,8 +355,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone=
_stat_item item,
 	 * CPU migrations and preemption potentially corrupts a counter so
 	 * disable preemption.
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
=20
 	x =3D delta + __this_cpu_read(*p);
=20
@@ -368,8 +367,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone=
_stat_item item,
 	}
 	__this_cpu_write(*p, x);
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 EXPORT_SYMBOL(__mod_zone_page_state);
=20
@@ -393,8 +391,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, e=
num node_stat_item item,
 	}
=20
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
=20
 	x =3D delta + __this_cpu_read(*p);
=20
@@ -406,8 +403,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, e=
num node_stat_item item,
 	}
 	__this_cpu_write(*p, x);
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 EXPORT_SYMBOL(__mod_node_page_state);
=20
@@ -441,8 +437,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat=
_item item)
 	s8 v, t;
=20
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
=20
 	v =3D __this_cpu_inc_return(*p);
 	t =3D __this_cpu_read(pcp->stat_threshold);
@@ -453,8 +448,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat=
_item item)
 		__this_cpu_write(*p, -overstep);
 	}
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
=20
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -466,8 +460,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum n=
ode_stat_item item)
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
=20
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
=20
 	v =3D __this_cpu_inc_return(*p);
 	t =3D __this_cpu_read(pcp->stat_threshold);
@@ -478,8 +471,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum n=
ode_stat_item item)
 		__this_cpu_write(*p, -overstep);
 	}
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
=20
 void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -501,8 +493,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat=
_item item)
 	s8 v, t;
=20
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
=20
 	v =3D __this_cpu_dec_return(*p);
 	t =3D __this_cpu_read(pcp->stat_threshold);
@@ -513,8 +504,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat=
_item item)
 		__this_cpu_write(*p, overstep);
 	}
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
=20
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -526,8 +516,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum n=
ode_stat_item item)
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
=20
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
=20
 	v =3D __this_cpu_dec_return(*p);
 	t =3D __this_cpu_read(pcp->stat_threshold);
@@ -538,8 +527,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum n=
ode_stat_item item)
 		__this_cpu_write(*p, overstep);
 	}
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
=20
 void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
--=20
2.37.2

