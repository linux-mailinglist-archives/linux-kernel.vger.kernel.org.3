Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C458E4E2438
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346255AbiCUKVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbiCUKVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:21:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74F72DA83;
        Mon, 21 Mar 2022 03:20:25 -0700 (PDT)
Date:   Mon, 21 Mar 2022 10:20:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647858024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Eopz/MQCZ+Z8E/7sU2FMr5+ZT81Yw3113vHKndsiWBs=;
        b=HoduWKmzLVHPFL7Pf/ZXQk8JlQVKbUhABrqVvFI9WS/q667t+30OxWBff7iJVL6yLkSgGI
        qFL4LTmSia9ZH+S4I4kzg75yuKodxfBdY7e13FdpOd+/I74/GWdvI8oYsLCByLk+coKkEe
        HqkP3yhAkJiVa5AkPgMsNlp4XIgnA10cT1WTC58n+HnOKBp0WsfuTQojLsEFixjriY5N7X
        8qlrao/JFREsPnaLe0hCSxMBe7WXZfgWsJS1LjhhphFzq+8BbFwZQJWToMflzquW9FDse7
        PGL6OmVs1BVSP1PpRXeD+QNdbtIsaLLdlqFHWSI/DNB/PbZNgVnpIsrVE2QfRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647858024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Eopz/MQCZ+Z8E/7sU2FMr5+ZT81Yw3113vHKndsiWBs=;
        b=D0b6EWo913iAW+B08snFFckA5Br94FJMUnmuhv1wijqzMeMTDDy6bP6hmNAKq81BOaU7Ej
        Ui+BnK84ahymlmDQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] headers/prep: Fix header to build standalone: <linux/psi.h>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164785802309.389.16437260063378101886.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3387ce4d8a5f2956fab827edf499fe6780e83faa
Gitweb:        https://git.kernel.org/tip/3387ce4d8a5f2956fab827edf499fe6780e83faa
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 21 Mar 2022 11:05:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 21 Mar 2022 11:13:49 +01:00

headers/prep: Fix header to build standalone: <linux/psi.h>

Add the <linux/cgroup-defs.h> dependency to <linux/psi.h>, because
cgroup_move_task() will dereference 'struct css_set'.

( Only older toolchains are affected, due to variations in
  the implementation of rcu_assign_pointer() et al. )

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Reported-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/psi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 7f7d1d8..8978476 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -6,6 +6,7 @@
 #include <linux/psi_types.h>
 #include <linux/sched.h>
 #include <linux/poll.h>
+#include <linux/cgroup-defs.h>
 
 struct seq_file;
 struct css_set;
