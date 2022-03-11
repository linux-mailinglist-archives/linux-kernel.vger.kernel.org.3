Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD24D63F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiCKOmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344430AbiCKOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:42:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9261CE986;
        Fri, 11 Mar 2022 06:40:57 -0800 (PST)
Date:   Fri, 11 Mar 2022 14:40:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647009656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hegKktPR+oSJlZ7eMJINSbSES7bQHZfFFKSD96G5/LA=;
        b=MzcljQCinP7twuiPsPW9gYtb+h6/YxFv1Rge2rl0hOeXY/H3/vyMTuhaoEt/NK+3JIm8fk
        mwlTMfvvk8OeYE3AKkmRxLYop/1DpOS/M3GeCRyV5Z6Z+c4JIgzB21EFqhtlimuh2IMfHD
        1FN6F2yK6mr6vfyzEFsxDPdxnpSvOPKj+Z+EhV7MOqZhhGUuHXMhHhCKtOr/HqR8TgtiIn
        TZSfAIlGRVFt5KywHHLNZxxl8uABvW9LwJTqB2nMS1Xj0Urbt5BXbtViBS+VuAJnMJQCwF
        ZRRrXdszCIRUSlnZsEpGrT43GMydsanBzfRQumYtAW43viWxNAEfJvLScgUjiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647009656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hegKktPR+oSJlZ7eMJINSbSES7bQHZfFFKSD96G5/LA=;
        b=qy/1hBkvMQUckH55AU62qHWpu0LfLVlvuJxuKcj7tKjd7eZhE5L9iIuEJFtykiVVPNRY5C
        jf3DVp+lpLl3GxBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86,ftrace: Fix modify_ftrace_direct()
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
References: <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164700965551.16921.1526159512411364871.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c841668784cc609e7ae103d91c3e03bf8939418d
Gitweb:        https://git.kernel.org/tip/c841668784cc609e7ae103d91c3e03bf8939418d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 11 Mar 2022 10:40:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Mar 2022 13:05:08 +01:00

x86,ftrace: Fix modify_ftrace_direct()

Alexei reported that BPF direct trampolines are no longer working with
IBT=y builds.

Make modify_ftrace_direct() consistent vs
{,un}register_ftrace_direct(), such that they all agree on where the
__fentry__ site lives.

Fixes: ee1a8cf8dd0f ("x86/ibt,ftrace: Search for __fentry__ location")
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net
---
 kernel/trace/ftrace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ae0d9f6..8e0509e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5381,6 +5381,11 @@ int modify_ftrace_direct(unsigned long ip,
 	mutex_lock(&direct_mutex);
 
 	mutex_lock(&ftrace_lock);
+
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry = find_direct_entry(&ip, &rec);
 	if (!entry)
 		goto out_unlock;
