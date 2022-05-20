Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1052F353
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352845AbiETSil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352967AbiETSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:38:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA19B197F45
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qqixKEXzoDshMrun7TBlJ9cCMvDNubk0hG9BbTmw7h0=; b=rJ4hYWhCYHM2CE97cDIXIPnZ/e
        5Y7xnVpdeTPV9jfXO7YefiFFtDs6jTGeeooXCRw2js215wj/C65Irdot+3ZkAjhHe9n0Efyv4r/wh
        PN5LvBQd+Ay3AY8MRz24EiBmbMne53LmpQfe34uf/asusPmy0UtN8i2BLQRP+PxvALFtVcmGwBxnW
        r8G/cIR6XZxSOrAAG42xBFiIfF8IwT2UCFhBQ3EnkwKINDj2hLwWZarG+zNkNZF+M386QVWeQt9IY
        1bs/c+ENsvQm50f2MoZVWWTV1sp3qtLmfln5myez9o1TwgH5pAHb8aiZmldK117T2HuFwDTABVRbz
        EtxH6N5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns7Vo-0001Jz-SB; Fri, 20 May 2022 18:38:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BBA8981243; Fri, 20 May 2022 20:38:06 +0200 (CEST)
Date:   Fri, 20 May 2022 20:38:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     nslusarek@gmx.net, Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] perf: Fix sys_perf_event_open() race against self
Message-ID: <20220520183806.GV2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Norbert reported that it's possible to race sys_perf_event_open() such
that the looser ends up in another context from the group leader,
triggering many WARNs.

The move_group case checks for races against itself, but the
!move_group case doesn't, seemingly relying on the previous
group_leader->ctx == ctx check. However, that check is racy due to not
holding any locks at that time.

Therefore, re-check the result after acquiring locks and bailing
if they no longer match.

Additionally, clarify the not_move_group case from the
move_group-vs-move_group race.

Fixes: f63a8daa5812 ("perf: Fix event->ctx locking")
Reported-by: Norbert Slusarek <nslusarek@gmx.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12217,6 +12217,9 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * Do not allow to attach to a group in a different task
 		 * or CPU context. If we're moving SW events, we'll fix
 		 * this up later, so allow that.
+		 *
+		 * Racy, not holding group_leader->ctx->mutex, see comment with
+		 * perf_event_ctx_lock().
 		 */
 		if (!move_group && group_leader->ctx != ctx)
 			goto err_context;
@@ -12282,6 +12285,7 @@ SYSCALL_DEFINE5(perf_event_open,
 			} else {
 				perf_event_ctx_unlock(group_leader, gctx);
 				move_group = 0;
+				goto not_move_group;
 			}
 		}
 
@@ -12298,7 +12302,17 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	} else {
 		mutex_lock(&ctx->mutex);
+
+		/*
+		 * Now that we hold ctx->lock, (re)validate group_leader->ctx == ctx,
+		 * see the group_leader && !move_group test earlier.
+		 */
+		if (group_leader && group_leader->ctx != ctx) {
+			err = -EINVAL;
+			goto err_locked;
+		}
 	}
+not_move_group:
 
 	if (ctx->task == TASK_TOMBSTONE) {
 		err = -ESRCH;

