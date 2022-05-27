Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33652535DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350865AbiE0KQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344125AbiE0KQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:16:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8869B106A62;
        Fri, 27 May 2022 03:16:01 -0700 (PDT)
Date:   Fri, 27 May 2022 10:15:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653646559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqbO8lBAtQQqUxPb04OcA1nfzUcOE4oNGSONA0ML0Tk=;
        b=zUE0cdL/U16vDerZ3jMzu2PtkGKhCouIBQt/5izxfupVYkSgJ99JbihX4aNHyIZ4WOybKG
        xgoE9mI3liDNChEF+PLZtCLrJjJGG+8C8fw0gaVBfo/7L/I7afpCZxZao5B0ZNVxYzB7pY
        Sqhluyv0CWlbSMlE8fLmgiI3dJVnZYqr5FE01Rx1uCmCOyz2sCOev4lCfdVh8UfqMebusi
        GZOwnQ7RkIbw8d5w65tdiT1aYjjjANm5ORcY3w1AsJXMjM4DypcmxMz4KHVkoqpmty+2Kg
        KUTWDHjDfNOuZF1fXfnmEJ6lRtNo0k+pwYMpLN/Zm+5D9H1DrDGEfDMLk5j4VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653646559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqbO8lBAtQQqUxPb04OcA1nfzUcOE4oNGSONA0ML0Tk=;
        b=Qi4iXw1Ql41nsUGgp9FjLiJkdOfC54Au5Viod3TbFJztvZWGdpAZrTYnDY0GQ3/6mniJDT
        LwsGK7SYg0op2rAA==
From:   "tip-bot2 for Haowen Bai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Remove unused local variable
Cc:     Haowen Bai <baihaowen@meizu.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1653645835-29206-1-git-send-email-baihaowen@meizu.com>
References: <1653645835-29206-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Message-ID: <165364655849.4207.2066662775081437250.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8b4dd2d8627e88dc3bd71bf29c48aaae2b69572b
Gitweb:        https://git.kernel.org/tip/8b4dd2d8627e88dc3bd71bf29c48aaae2b69572b
Author:        Haowen Bai <baihaowen@meizu.com>
AuthorDate:    Fri, 27 May 2022 18:03:54 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 27 May 2022 12:14:16 +02:00

perf/core: Remove unused local variable

Drop LIST_HEAD() where the variable it declares is never used.

Compiler probably never warned us, because the LIST_HEAD()
initializer is technically 'usage'.

[ mingo: Tweak changelog. ]

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/1653645835-29206-1-git-send-email-baihaowen@meizu.com
---
 kernel/events/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 950b25c..80782cd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4257,7 +4257,6 @@ static void perf_event_remove_on_exec(int ctxn)
 {
 	struct perf_event_context *ctx, *clone_ctx = NULL;
 	struct perf_event *event, *next;
-	LIST_HEAD(free_list);
 	unsigned long flags;
 	bool modified = false;
 
