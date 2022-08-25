Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DF05A16E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbiHYQms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiHYQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:42:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90163BB038
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:42:05 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661445702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZ0gImFj9vNb9oCghFEFyZK2gmeHgP1Q4vEv6+ZBTOo=;
        b=iZPGCTy46sVqGQTmbG+4Y+5JUk2LCMCns27UxDt2NcGkCvR86mDvUT5mf7UHORjsDHXnEb
        dbSvanfsvEh8sNGDjLVFm7HDYcPbErT/madlxlWk94fWVSWGm78tu2jqpj2Aa0UGhD7FNb
        bYt9NFkgYpQQrfzexIL3SOlbm0f12LRD/wcZCMXB92dUWi38W7918IYoxza7wUKVUr3gE/
        mkR1SQObdAsGtoqcu+Yf5u8rZN0ZqxSafA7PORNYXClXKeoZq1BldrO9Mf0bFCilK+k8IZ
        oY8mBeN10xdLin4VnWWIGEai4rZEo7+gZfV6wl+7UmNCZEfE0tvQQJm3Zdkpcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661445702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZ0gImFj9vNb9oCghFEFyZK2gmeHgP1Q4vEv6+ZBTOo=;
        b=uzVcIXdcn/xNA2DNNwNkBxw35ISWhO/M9DgMSdVRoz5tw0i3FBmz9D7aRxiTgMNLUN8Z/5
        kUWqWgKJerzA5UDg==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 7/8] flex_proportions: Disable preemption entering the write section.
Date:   Thu, 25 Aug 2022 18:41:30 +0200
Message-Id: <20220825164131.402717-8-bigeasy@linutronix.de>
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

The seqcount fprop_global::sequence is not associated with a lock. The
write section (fprop_new_period()) is invoked from a timer and since the
softirq is preemptible on PREEMPT_RT it is possible to preempt the write
section which is not desited.

Disable preemption around the write section on PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/flex_proportions.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 05cccbcf1661a..83332fefa6f42 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -70,6 +70,7 @@ bool fprop_new_period(struct fprop_global *p, int periods)
 	 */
 	if (events <=3D 1)
 		return false;
+	preempt_disable_nested();
 	write_seqcount_begin(&p->sequence);
 	if (periods < 64)
 		events -=3D events >> periods;
@@ -77,6 +78,7 @@ bool fprop_new_period(struct fprop_global *p, int periods)
 	percpu_counter_add(&p->events, -events);
 	p->period +=3D periods;
 	write_seqcount_end(&p->sequence);
+	preempt_enable_nested();
=20
 	return true;
 }
--=20
2.37.2

