Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ED74F2AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352697AbiDEKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiDEIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:30:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072B424F2E;
        Tue,  5 Apr 2022 01:22:03 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:22:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649146921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+duiD32iMvOs7dnQ0Ve1PZwuaC4V1bdhbWLDOYKenw=;
        b=chCsgVPjZfQX/R6PhO14giuawgRJTUop2TWpJfXrr7zTnkrVw/28FNWKVJCtGY8yNXSfEh
        aQS9NTIYkFRS2TzrA0X8gw3XseAG+OT2itmxhbnnX9F/LhkFJQClnqRjgI8wyfOzMlhqCR
        ipfFVH+PqYaOqrs9DBGy0BPkuKivEJk3HoiM4G/Kdqli2udnUkGcRjdijraYqGJ8FEjKu1
        N6QvPyOTMERyW1ENJQDmn6HQbTfR7bTXJ5fQ6KbAblPWcKHPZ5uAkMNeBhkHenJbvlxJxX
        AdhbpNIjkL1oWDPr+runaDJBCrPj6DclnZjfU+a3w6OqhPPDBmqqw0FGoit9lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649146921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+duiD32iMvOs7dnQ0Ve1PZwuaC4V1bdhbWLDOYKenw=;
        b=EB1uS2Id7A4PZsS3NE1y8bmGcrI6KLBEAqCZ9jqSn2JrQIxfS9gR596j/KqpdBpjfY98tC
        Tv2Bi8mRhLgcSGAQ==
From:   "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] entry: Fix compile error in
 dynamic_irqentry_exit_cond_resched()
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220330084328.1805665-1-svens@linux.ibm.com>
References: <20220330084328.1805665-1-svens@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <164914692031.389.12455051042732550539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     0a70045ed8516dfcff4b5728557e1ef3fd017c53
Gitweb:        https://git.kernel.org/tip/0a70045ed8516dfcff4b5728557e1ef3fd0=
17c53
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Wed, 30 Mar 2022 10:43:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:36 +02:00

entry: Fix compile error in dynamic_irqentry_exit_cond_resched()

kernel/entry/common.c: In function =E2=80=98dynamic_irqentry_exit_cond_resche=
d=E2=80=99:
kernel/entry/common.c:409:14: error: implicit declaration of function =E2=80=
=98static_key_unlikely=E2=80=99; did you mean =E2=80=98static_key_enable=E2=
=80=99? [-Werror=3Dimplicit-function-declaration]
  409 |         if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_resch=
ed))
      |              ^~~~~~~~~~~~~~~~~~~
      |              static_key_enable

static_key_unlikely() should be static_branch_unlikely().

Fixes: 99cf983cc8bca ("sched/preempt: Add PREEMPT_DYNAMIC using static keys")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20220330084328.1805665-1-svens@linux.ibm.com
---
 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e57a224..93c3b86 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -392,7 +392,7 @@ DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqent=
ry_exit_cond_resched);
 DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 void dynamic_irqentry_exit_cond_resched(void)
 {
-	if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
 		return;
 	raw_irqentry_exit_cond_resched();
 }
