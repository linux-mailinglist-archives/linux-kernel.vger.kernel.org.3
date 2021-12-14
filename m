Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC04474DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhLNWF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:05:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58722 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhLNWEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 139D8CE1AFC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A947C34635;
        Tue, 14 Dec 2021 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519482;
        bh=NvNN940Rq8R495Pg5UCrAMHQScZ8jAZXj/dQvCIug1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEpl8RaL/9YDoOG4T3e4/jxgmv8/hSNJ9I20Kd1CF6dm39l6HvItKLXesboP6VrDB
         oP7oO55Zv3z+ZGfYORcZXkYGHNreM6+0cbrqdopN52rlPutyx4xiQhdUChlqEiy4eu
         tFn6y88krG+DEOkWQi33E93F5Iczeu4xqp80V7jhfWbFWhS8U3bB9WWeaZoxuuZ5RH
         ESIyNqqxWXPL04u3RT5/kCUldgy6feygUjDffsJNdh9QPGVsqhdnx2oAZS7t7KmbZT
         Y4xqZ6/1guOAyB29Hb9xrfvi+DmksbwD4bwdM0L9LtyRYViW4/ReV1/5EJl3KQKIzv
         jefa0Hd72aOog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7EB695C1E82; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 19/29] x86/qspinlock, kcsan: Instrument barrier of pv_queued_spin_unlock()
Date:   Tue, 14 Dec 2021 14:04:29 -0800
Message-Id: <20211214220439.2236564-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

If CONFIG_PARAVIRT_SPINLOCKS=y, queued_spin_unlock() is implemented
using pv_queued_spin_unlock() which is entirely inline asm based. As
such, we do not receive any KCSAN barrier instrumentation via regular
atomic operations.

Add the missing KCSAN barrier instrumentation for the
CONFIG_PARAVIRT_SPINLOCKS case.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/include/asm/qspinlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index d86ab942219c4..d87451df480bd 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -53,6 +53,7 @@ static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 
 static inline void queued_spin_unlock(struct qspinlock *lock)
 {
+	kcsan_release();
 	pv_queued_spin_unlock(lock);
 }
 
-- 
2.31.1.189.g2e36527f23

