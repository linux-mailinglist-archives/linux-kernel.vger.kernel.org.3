Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45B14F382F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376402AbiDELVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbiDEIsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D6B2898C;
        Tue,  5 Apr 2022 01:36:40 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6CEypLR3RXn8BhEvCgFWjtDxP0Hx5DJRV2tJQjvOOIA=;
        b=GfkoeIykMCOi3ZW12ZoHCdlHZAYOLm7QYaJBn4OUgoJ5exOpxbjr8J6g6Il3eo8a/mO9AO
        jYk8MBmpmmeO7sRxtwOjs+JfAvNU/qObiIm9l69qHVmk23Amvngs02Ln4oDLKfPZqbLgpq
        cyqa8YLi/h7H6skXksMTxoJ5dh5FlcCZkDqido1gDF64wvn0x8nYZRDbVMcy59+ua2jzlE
        NXJ1B3OcS145NJccsobyGwAik6WQkh03rb3gnHoWr15HqUTtrnDYgbWZD4jNeIoyRrqK2B
        jV748OsRX5PkCtjE38Kl/Q1dmvoNfVqnuTcmzQlj2vYvZ3AXNUakBq0A8S7uFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6CEypLR3RXn8BhEvCgFWjtDxP0Hx5DJRV2tJQjvOOIA=;
        b=2GxrV5zHWKZZDx9Y2dH2tQMw011rvgTttb1Oyx23iFmGeIvyr+g+ym0oAnTIixoMoszzZP
        /FbIFxu8kqR7bSBQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: No need to check for handoff bit
 if wait queue empty
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322152059.2182333-2-longman@redhat.com>
References: <20220322152059.2182333-2-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <164914778225.389.644461284127262702.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f9e21aa9e6fb11355e54c8949a390d49ca21cde1
Gitweb:        https://git.kernel.org/tip/f9e21aa9e6fb11355e54c8949a390d49ca21cde1
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Tue, 22 Mar 2022 11:20:57 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:34 +02:00

locking/rwsem: No need to check for handoff bit if wait queue empty

Since commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling
more consistent"), the handoff bit is always cleared if the wait queue
becomes empty. There is no need to check for RWSEM_FLAG_HANDOFF when
the wait list is known to be empty.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220322152059.2182333-2-longman@redhat.com
---
 kernel/locking/rwsem.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index acde5d6..b077b1b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -977,12 +977,11 @@ queue:
 	if (list_empty(&sem->wait_list)) {
 		/*
 		 * In case the wait queue is empty and the lock isn't owned
-		 * by a writer or has the handoff bit set, this reader can
-		 * exit the slowpath and return immediately as its
-		 * RWSEM_READER_BIAS has already been set in the count.
+		 * by a writer, this reader can exit the slowpath and return
+		 * immediately as its RWSEM_READER_BIAS has already been set
+		 * in the count.
 		 */
-		if (!(atomic_long_read(&sem->count) &
-		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
+		if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
 			/* Provide lock ACQUIRE */
 			smp_acquire__after_ctrl_dep();
 			raw_spin_unlock_irq(&sem->wait_lock);
