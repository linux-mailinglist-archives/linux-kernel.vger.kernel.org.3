Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC8A4F3048
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356925AbiDEKZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbiDEIcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A617AA7;
        Tue,  5 Apr 2022 01:29:41 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CG5YoLwVtENTsJI0ZrkElUF1kAUax6t9VUJ60RvhJyU=;
        b=wffzHuT9w4t8vE4ER/eAMk+5e/hBQx8EcbUsg7pU3enhphts0JZ6s2zwslkkAlVo907big
        2pXR+XvNOjDvv7UMspTmLAV3ns+Z2HH9F02PvJpSUV/C7gjSKgwzUgVmNGHAeRtFYbK8us
        pPzBT1YKCWup5r0g8QqsALJ88HlSUY94h8UHi6NvP1sUW/ko+SFf3ObzVh+v6Lt0cEvlbx
        Crpawo91PVuXsp97UCNud7km3qmxm8GnZLozaxNvdULMdo68xtFYUgU3/CrVjR0do93E9u
        0vP9C83d70JL22GkLV/z4yps34Pbx5yN0HXie9y40wNFgBh9+TsncbFcpw8qIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CG5YoLwVtENTsJI0ZrkElUF1kAUax6t9VUJ60RvhJyU=;
        b=JDN0WqxdBfxFnEc3qfli09GyeYL47oKKnegWtayfWO47xAP0wIs9aW6Vv1T4kDOiTI+k69
        6PTMTx8rgs36CCDQ==
From:   "tip-bot2 for Vincent Mailhol" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bug: Prevent shadowing in __WARN_FLAGS
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220324023742.106546-1-mailhol.vincent@wanadoo.fr>
References: <20220324023742.106546-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Message-ID: <164914737896.389.7504824366044835648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9ce02f0fc68326dd1f87a0a3a4c6ae7fdd39e6f6
Gitweb:        https://git.kernel.org/tip/9ce02f0fc68326dd1f87a0a3a4c6ae7fdd39e6f6
Author:        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
AuthorDate:    Thu, 24 Mar 2022 11:37:42 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:40 +02:00

x86/bug: Prevent shadowing in __WARN_FLAGS

The macro __WARN_FLAGS() uses a local variable named "f". This being a
common name, there is a risk of shadowing other variables.

For example, GCC would yield:

| In file included from ./include/linux/bug.h:5,
|                  from ./include/linux/cpumask.h:14,
|                  from ./arch/x86/include/asm/cpumask.h:5,
|                  from ./arch/x86/include/asm/msr.h:11,
|                  from ./arch/x86/include/asm/processor.h:22,
|                  from ./arch/x86/include/asm/timex.h:5,
|                  from ./include/linux/timex.h:65,
|                  from ./include/linux/time32.h:13,
|                  from ./include/linux/time.h:60,
|                  from ./include/linux/stat.h:19,
|                  from ./include/linux/module.h:13,
|                  from virt/lib/irqbypass.mod.c:1:
| ./include/linux/rcupdate.h: In function 'rcu_head_after_call_rcu':
| ./arch/x86/include/asm/bug.h:80:21: warning: declaration of 'f' shadows a parameter [-Wshadow]
|    80 |         __auto_type f = BUGFLAG_WARNING|(flags);                \
|       |                     ^
| ./include/asm-generic/bug.h:106:17: note: in expansion of macro '__WARN_FLAGS'
|   106 |                 __WARN_FLAGS(BUGFLAG_ONCE |                     \
|       |                 ^~~~~~~~~~~~
| ./include/linux/rcupdate.h:1007:9: note: in expansion of macro 'WARN_ON_ONCE'
|  1007 |         WARN_ON_ONCE(func != (rcu_callback_t)~0L);
|       |         ^~~~~~~~~~~~
| In file included from ./include/linux/rbtree.h:24,
|                  from ./include/linux/mm_types.h:11,
|                  from ./include/linux/buildid.h:5,
|                  from ./include/linux/module.h:14,
|                  from virt/lib/irqbypass.mod.c:1:
| ./include/linux/rcupdate.h:1001:62: note: shadowed declaration is here
|  1001 | rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
|       |                                               ~~~~~~~~~~~~~~~^

For reference, sparse also warns about it, c.f. [1].

This patch renames the variable from f to __flags (with two underscore
prefixes as suggested in the Linux kernel coding style [2]) in order
to prevent collisions.

[1] https://lore.kernel.org/all/CAFGhKbyifH1a+nAMCvWM88TK6fpNPdzFtUXPmRGnnQeePV+1sw@mail.gmail.com/

[2] Linux kernel coding style, section 12) Macros, Enums and RTL,
paragraph 5) namespace collisions when defining local variables in
macros resembling functions
https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl

Fixes: bfb1a7c91fb7 ("x86/bug: Merge annotate_reachable() into_BUG_FLAGS() asm")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20220324023742.106546-1-mailhol.vincent@wanadoo.fr
---
 arch/x86/include/asm/bug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 4d20a29..aaf0cb0 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -78,9 +78,9 @@ do {								\
  */
 #define __WARN_FLAGS(flags)					\
 do {								\
-	__auto_type f = BUGFLAG_WARNING|(flags);		\
+	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);			\
+	_BUG_FLAGS(ASM_UD2, __flags, ASM_REACHABLE);		\
 	instrumentation_end();					\
 } while (0)
 
