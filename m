Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A62046BD81
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbhLGOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhLGOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:25:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446E8C061746;
        Tue,  7 Dec 2021 06:22:19 -0800 (PST)
Date:   Tue, 07 Dec 2021 14:22:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638886938;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOKTCXuFLexkeFs2BCk+xDHXO0EZ0hgKBQ2jy7Bbsyw=;
        b=nFUwpvQ+wMPbjBBpj/Lt91TYG3bwr2URogJAUZ2n8tAfDctaw2I9jKX+bfDqzFILn5QJj3
        XG4qMml/v4K8e7QtKOcYxfruot+/rlZ0XuRqQ+s6I3MiZh3xb/tET4qRfnZDNf3kBwxdV7
        kdQKaZfkzyawt/Mm5n70Z92j0flsgxlpzztu8lfwgUzrjsAtZVaoMTfeDXuj0/xoRZ4fSw
        sy+nlAdWrDRISFnYl06ByIswj2zkVN46aoi/gJQ/ZZ5tSEDzKwOX9gjsEvKrDhXJMb/Qk2
        kmRtt+fz40K4ZtOmdx6Xd71F8lZKIymY2GE1XHw9F3eSUiPU6Hiyg3fsjdK7/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638886938;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOKTCXuFLexkeFs2BCk+xDHXO0EZ0hgKBQ2jy7Bbsyw=;
        b=fBGKoqc/dalClkHQdjCIlQ1YbRu/gCQTsUNt++R7nYaLUEyJYXhfRd6YVQNGD+kiOFqBiD
        ebPDr5YjubqQzhDA==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Document the slow path and fast path in
 select_task_rq_fair
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211016111109.5559-1-21cnbao@gmail.com>
References: <20211016111109.5559-1-21cnbao@gmail.com>
MIME-Version: 1.0
Message-ID: <163888693710.11128.901865554375513171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2917406c352757642c3c1a13a4c99c96e6d22fde
Gitweb:        https://git.kernel.org/tip/2917406c352757642c3c1a13a4c99c96e6d22fde
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Sat, 16 Oct 2021 19:11:09 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 07 Dec 2021 15:14:10 +01:00

sched/fair: Document the slow path and fast path in select_task_rq_fair

All People I know including myself took a long time to figure out that
typical wakeup will always go to fast path and never go to slow path
except WF_FORK and WF_EXEC.

Vincent reminded me once in a linaro meeting and made me understand
slow path won't happen for WF_TTWU. But my other friends repeatedly
wasted a lot of time on testing this path like me before I reminded
them.

So obviously the code needs some document.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211016111109.5559-1-21cnbao@gmail.com
---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0672218..f34f2f3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6917,6 +6917,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 			break;
 		}
 
+		/*
+		 * Usually only true for WF_EXEC and WF_FORK, as sched_domains
+		 * usually do not have SD_BALANCE_WAKE set. That means wakeup
+		 * will usually go to the fast path.
+		 */
 		if (tmp->flags & sd_flag)
 			sd = tmp;
 		else if (!want_affine)
