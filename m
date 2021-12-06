Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80944469EA0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378303AbhLFPnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386666AbhLFP0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:26:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB9AC061359;
        Mon,  6 Dec 2021 07:17:22 -0800 (PST)
Date:   Mon, 06 Dec 2021 15:15:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638803750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NlwSy0KTkW8egjU4s3md9aosjgWu+klQvZ9SqaZM1lw=;
        b=R1qObF1U7LeZKTFOGqKFJGUQvnAcA/undZpJd5zO7mwangMz2EZgPjAGL0wwiImtnhfHQW
        Lejpbeop0BVErvTiA0VoYmA6MudGRusESgWG3F9jGTzUzOqZn1vOBtly7D5dLy4mzUMWDV
        6PYtWK4eI0rqOdmYWgsGs81EuNYm0OadnpIWo3LZwdnunMxJnAFfOrIbSs7Pc8oum9acW3
        TKrqhzXWRDsXN5N6eCoA50/QwAdEI3Gu5SroCvDIQqbcTXDGZKDO+qDPbavAN2RItwZfJv
        y9dOvI+EZT2b32prfg6EgBRlmkNAqEiCdmBL5EYTTYVlBMgQ5JQnimX5mnnAiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638803750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NlwSy0KTkW8egjU4s3md9aosjgWu+klQvZ9SqaZM1lw=;
        b=EZ97xfmDWyzmOiuFM7XvK2p1PO+Gy9pJ2+TPDYPdWoAfCLDbeFVpR4JCgGuxvUbXtj5lA4
        4/cUuk+CWOhtHiCg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Remove rt_rwlock_is_contended().
Cc:     kernel test robot <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129174654.668506-3-bigeasy@linutronix.de>
References: <20211129174654.668506-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163880374939.11128.7605699076003373474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e08f343be00c3fe8f9f6ac58085c81bcdd231fab
Gitweb:        https://git.kernel.org/tip/e08f343be00c3fe8f9f6ac58085c81bcdd231fab
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 29 Nov 2021 18:46:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:23 +01:00

locking: Remove rt_rwlock_is_contended().

rt_rwlock_is_contended() has no users. It makes no sense to use it as
rwlock_is_contended() because it is a sleeping lock on RT and
preemption is possible. It reports always != 0 if used by a writer and
even if there is a waiter then the lock might not be handed over if
the current owner has the highest priority.

Remove rt_rwlock_is_contended().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211129174654.668506-3-bigeasy@linutronix.de
---
 kernel/locking/spinlock_rt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index b2e553f..9e396a0 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -257,12 +257,6 @@ void __sched rt_write_unlock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_write_unlock);
 
-int __sched rt_rwlock_is_contended(rwlock_t *rwlock)
-{
-	return rw_base_is_contended(&rwlock->rwbase);
-}
-EXPORT_SYMBOL(rt_rwlock_is_contended);
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
 		      struct lock_class_key *key)
