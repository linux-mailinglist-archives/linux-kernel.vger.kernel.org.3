Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670DB4626C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhK2W5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbhK2WzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:55:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E40C0C2365
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:48:28 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638208106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y23vD09IoN6Yo3gJvioAu7jdWJUdTPaZ9iTjGpny6/o=;
        b=JQW/Ln7YK0xr12Thi+syaITqaddSyJmH+BCHYx5J+P2l5IgmfAf79499TKEeP30+15L1UR
        mqlvW8AH7LXwpWOorKOtXwDL8iWtduC4olx9IOlnjp4CDGgI6IigZJJnjAT5OuAQLGJdqU
        n3MJO2oDrDppUuzWZBac3/tWPoe4UGQj1O5uYf3WybFBRrdCiE6Ge11IYcznO4AZqrPUmQ
        RejiE5yBadzngV07/MSs97VoAetlJu/2Sys6whWmUGzbXRzlG+Q9DJo1jrrK7KU86586CZ
        3IudEPhwAOaEs+Ox2ukAGJpgCWUlCj7pwA/5SIs6f8gOJb1RPFKe9ahoqWOi0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638208106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y23vD09IoN6Yo3gJvioAu7jdWJUdTPaZ9iTjGpny6/o=;
        b=COifPVv+x/opMmFbl3sCKEAjFgPuMqp6tkcCAUsR7lux9PVNfl3VN8UZDtkNgGFiDKmEzD
        NpicyNxrQvPyllAw==
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
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 02/11] locking: Remove rt_rwlock_is_contended().
Date:   Mon, 29 Nov 2021 18:46:45 +0100
Message-Id: <20211129174654.668506-3-bigeasy@linutronix.de>
In-Reply-To: <20211129174654.668506-1-bigeasy@linutronix.de>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rt_rwlock_is_contended() has not users. It makes no sense to use it as
rwlock_is_contended() because it is a sleeping lock on RT and preemption
is possible. It reports always !=3D 0 if used by a writer and even if
there is a waiter then the lock might not be handed over if the
current owner has the highest priority.

Remove rt_rwlock_is_contended().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/spinlock_rt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index b2e553f9255bf..9e396a09fe0fd 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -257,12 +257,6 @@ void __sched rt_write_unlock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_write_unlock);
=20
-int __sched rt_rwlock_is_contended(rwlock_t *rwlock)
-{
-	return rw_base_is_contended(&rwlock->rwbase);
-}
-EXPORT_SYMBOL(rt_rwlock_is_contended);
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
 		      struct lock_class_key *key)
--=20
2.34.0

