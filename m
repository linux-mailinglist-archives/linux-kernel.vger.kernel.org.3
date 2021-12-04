Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6363468515
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377677AbhLDNnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355042AbhLDNnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:43:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390F0C061751;
        Sat,  4 Dec 2021 05:40:07 -0800 (PST)
Date:   Sat, 04 Dec 2021 13:40:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638625205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bz2xrUPHCFfeXmY59v4v/41E2tC5qLNgAcSQ+qV2MZc=;
        b=tZJ03u+0uyqR3g84eh9My2l+pVI9O9E58O3FqZZs52NQgXdP15whIwGHzYisgl+qXlsxpZ
        aXLM4tyYRSsIIV+R3TiGkdm/vJfTUWWiYFreeSO48crvllCDKGc3s3KUp9MxH5SliU7P61
        5wCVEfA0L6383L2ovv2D/+bpQ756SYYt5GljRS4nz8Ke/LElAG+m5TK+CB+Z8p7OozYLtD
        N1vy8L5KuEZxO5UEAUpfsYKkbthRCDu3t6yEtSt2y4n05MilrCZ4b5RZNEp+trc2NXnAwO
        h9MPKForK6rcY2kjDUPMBeQRnppIg0HsJU5YMsYfFNAgRFN93KHBomiOStTJpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638625205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bz2xrUPHCFfeXmY59v4v/41E2tC5qLNgAcSQ+qV2MZc=;
        b=6Y3cXJMfBFE+5r7xFO2jmFSJv8xAMCjbqOANqHLRMgvrkOVttXHG5FNXgFSilJelp5r/Hy
        FjsWYO6t2ein8cAg==
From:   "tip-bot2 for Andrew Halaney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] preempt/dynamic: Fix setup_preempt_mode() return value
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211203233203.133581-1-ahalaney@redhat.com>
References: <20211203233203.133581-1-ahalaney@redhat.com>
MIME-Version: 1.0
Message-ID: <163862520435.11128.7753816715963167229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     9ed20bafc85806ca6c97c9128cec46c3ef80ae86
Gitweb:        https://git.kernel.org/tip/9ed20bafc85806ca6c97c9128cec46c3ef80ae86
Author:        Andrew Halaney <ahalaney@redhat.com>
AuthorDate:    Fri, 03 Dec 2021 17:32:03 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:18 +01:00

preempt/dynamic: Fix setup_preempt_mode() return value

__setup() callbacks expect 1 for success and 0 for failure. Correct the
usage here to reflect that.

Fixes: 826bfeb37bb4 ("preempt/dynamic: Support dynamic preempt with preempt= boot option")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211203233203.133581-1-ahalaney@redhat.com
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 76f9dee..814c52d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6617,11 +6617,11 @@ static int __init setup_preempt_mode(char *str)
 	int mode = sched_dynamic_mode(str);
 	if (mode < 0) {
 		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
-		return 1;
+		return 0;
 	}
 
 	sched_dynamic_update(mode);
-	return 0;
+	return 1;
 }
 __setup("preempt=", setup_preempt_mode);
 
