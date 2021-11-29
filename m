Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3AE462628
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbhK2WsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbhK2WrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:47:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E5FC0C087D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:48:27 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638208106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dkltu1kAzc9JHOgyCqJmEJlABCPHPuNKHsAFYVYIVGE=;
        b=FDkOqlo/LrWlcgj4BVdwsIJAHXE8YnzLEe2sDntHBVAmEw68hIlCSu292jcLTM/gJjcdB2
        zlO9nG9afAxlq5Nj3BE2c7SH958dL867SSC3VWALW1o0In2ZphuL4LzNy/xhRboMucVuVO
        JDufHpVs0cBNw6jlgBg2+qq7YnVh3ur22UeNBZ6ozDV3B9oGrIyW9dlsgRkEdoGPG5dOcQ
        V5QTv9OA71Hz8kqGWaltG/RBkvuXSRPJnEpEFpU4Ykz/EtAHGawJIb25k3LJxTEtpZ0Qd3
        u7LiMeUs7PvDvrLC+cAktDDAXfa2bd2dgQmB/gDsycawfmQbwhv+//YEp7dpRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638208106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dkltu1kAzc9JHOgyCqJmEJlABCPHPuNKHsAFYVYIVGE=;
        b=9hCHf1b4nGm6XK4iBL0gQuhMGfWj52M3JgjMk7sfXhWBYAGYTMdhaOk5J3Ks9wgdrsNykN
        ZVYt9EQHF2Lpw5AA==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 01/11] sched: Trigger warning if ->migration_disabled counter underflows.
Date:   Mon, 29 Nov 2021 18:46:44 +0100
Message-Id: <20211129174654.668506-2-bigeasy@linutronix.de>
In-Reply-To: <20211129174654.668506-1-bigeasy@linutronix.de>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If migrate_enable() is used more often than its counter part then it
remains undetected and rq::nr_pinned will underflow, too.

Add a warning if migrate_enable() is attempted if without a matching a
migrate_disable().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 76f9deeaa9420..02be3f6144e97 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2171,6 +2171,8 @@ void migrate_enable(void)
 	if (p->migration_disabled > 1) {
 		p->migration_disabled--;
 		return;
+	} else if (WARN_ON_ONCE(p->migration_disabled =3D=3D 0)) {
+		return;
 	}
=20
 	/*
--=20
2.34.0

