Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83E849CAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbiAZNap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbiAZNac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:30:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C30CC061749;
        Wed, 26 Jan 2022 05:30:32 -0800 (PST)
Date:   Wed, 26 Jan 2022 13:30:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643203830;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3I4ChLYHGk093NXNmLne78ptnuGfPC6K8VKoX3iLCws=;
        b=1+QGhL8uyD8Owf1iU2s9QrNIQkeknAntZfAZDdVQX2j0Nnjj8ENXb/93Rmtl1VOPFknlUH
        EwyTXUQGwOianBgm9fFhJOzBxl/kdNgZAdNPVsPJG/40Xa2Hvo0VWLo6i/tWmTT0BkXpc8
        G9B1+7LJ3P/wDWF3fBgqracGJHEkezdbrpuNlHPvKIpQrokIz5vpouPL/z+SNJ9gfTd+Sw
        0dp+080v9Cu0GvF0tIYV35alycXVDTWI5Iazcr0pHdgNXruYH+v/6hjTQSQbhckzY8Wo/Y
        DnKsd/YPr/Dx8+T/hdVZg3cTC6nhgqqqbW34+0s+DITYX/+/OBPF6/jkEDx5iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643203830;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3I4ChLYHGk093NXNmLne78ptnuGfPC6K8VKoX3iLCws=;
        b=CT4f5htCUHBtN8X4h6jvEvdraU9laUqugPhKYOYrOl2b7YpdbEPjspWR6X/3qzx7cPQvKf
        gqSDk+5OOS+DSyDg==
From:   "tip-bot2 for Xiu Jianfeng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Use memset_startat() helper in reinit_class()
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211213132618.105737-1-xiujianfeng@huawei.com>
References: <20211213132618.105737-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Message-ID: <164320382983.16921.16443534509567100814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e204193b138af347fbbbe026e68cb3385112f387
Gitweb:        https://git.kernel.org/tip/e204193b138af347fbbbe026e68cb3385112f387
Author:        Xiu Jianfeng <xiujianfeng@huawei.com>
AuthorDate:    Mon, 13 Dec 2021 21:26:18 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 25 Jan 2022 22:30:27 +01:00

lockdep: Use memset_startat() helper in reinit_class()

use memset_startat() helper to simplify the code, there is no functional
change in this patch.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211213132618.105737-1-xiujianfeng@huawei.com
---
 kernel/locking/lockdep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4a882f8..89b3df5 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6011,13 +6011,10 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 
 static void reinit_class(struct lock_class *class)
 {
-	void *const p = class;
-	const unsigned int offset = offsetof(struct lock_class, key);
-
 	WARN_ON_ONCE(!class->lock_entry.next);
 	WARN_ON_ONCE(!list_empty(&class->locks_after));
 	WARN_ON_ONCE(!list_empty(&class->locks_before));
-	memset(p + offset, 0, sizeof(*class) - offset);
+	memset_startat(class, 0, key);
 	WARN_ON_ONCE(!class->lock_entry.next);
 	WARN_ON_ONCE(!list_empty(&class->locks_after));
 	WARN_ON_ONCE(!list_empty(&class->locks_before));
