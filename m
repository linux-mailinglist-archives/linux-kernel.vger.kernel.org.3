Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A8F5A16E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbiHYQm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243116AbiHYQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:42:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EF9BB012
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:41:54 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661445701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3a2uwD3ePfGP6QOLusJldJ8Cx5w8uOIWpoMcUghBNEI=;
        b=fAoAi6GN6WY3LeygB/lU0oNfEevDLSlEyWydv2qLC8qJtAwmaJKfLqO4P16YjHMIUo0Je9
        llrAhoYh2vZSnpVGam3C5lt5iT7SkmCn51yjLk++hlqRWDKbRPigRr+Dc56Fpb8OYFzSe7
        DnlzDN20dDV1rYDLSq3rpXJOlaXcaUMMB5MMNQFUokVaixRlqPj3UFwL9lQjHuBaaXpY67
        HVdPQDhN7wH4uc9PcPmbOBplXAZUd9DEUEz4jPfqyQgdpRk0lgPTcxpzkq+V5x55YEH9gj
        +/KOfkwwtXkRGDvRjHAlLiKvucUPP/2n3UEDqCQOO+U6s4fLgWmQYRcw60KBTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661445701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3a2uwD3ePfGP6QOLusJldJ8Cx5w8uOIWpoMcUghBNEI=;
        b=YGZc1zl3hETI58auazyzwWtrsPvOEkOwmmHlHQaf1c4aLojGysK6XG0Bv0ZbXFdkioOVw0
        bEi0iQIIzmj2gYBA==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/8] mm/vmstat: Use preempt_[dis|en]able_nested()
Date:   Thu, 25 Aug 2022 18:41:26 +0200
Message-Id: <20220825164131.402717-4-bigeasy@linutronix.de>
In-Reply-To: <20220825164131.402717-1-bigeasy@linutronix.de>
References: <20220825164131.402717-1-bigeasy@linutronix.de>
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

