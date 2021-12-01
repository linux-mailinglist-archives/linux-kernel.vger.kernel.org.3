Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA1465754
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353178AbhLAUsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353019AbhLAUon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:44:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28211C061756;
        Wed,  1 Dec 2021 12:41:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 75294CE210A;
        Wed,  1 Dec 2021 20:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA5FC53FD2;
        Wed,  1 Dec 2021 20:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638391278;
        bh=0eEPhATQ1R0Bm7TG0MGwB3OXGgPxjzOA4WGmxHXHbSs=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Rtu9b1EGVGU5EqCTQD6vt76bXHzANyMMrC199fogdUY3vLzxdwrccBYKIdBaPIXHb
         NORQbDPOH+qYQZNSq8woLOSjggB6AHG4n+B12XIlvVRg3v+ZqeqUo8lpqc8UsAGPA9
         SSprK8C7ufBxmAJ07ko99Cy6lDu/cW/mTPyuP1cwlzxHc3InYMQPHQaiYyZkQVeOYl
         tOtJSF1jkEU3Wvjxf0BawLb1ghx0Uk464A5GVmamDcVbEmUgYfJjQcwrylM9o4KCg1
         5oe1h1ZhdF2vTSaGyV8T69DrDksD4oBYaw/zE9Sdod9NKE9VWhIrRyi7nFhwaSMEmi
         hdKlD0UFgJECA==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 7/8] locking: Drop might_resched() from might_sleep_no_state_check()
Date:   Wed,  1 Dec 2021 14:41:07 -0600
Message-Id: <2343af990554e062b1b93fddf610ce78a4a001de.1638391253.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1638391253.git.zanussi@kernel.org>
References: <cover.1638391253.git.zanussi@kernel.org>
In-Reply-To: <cover.1638391253.git.zanussi@kernel.org>
References: <cover.1638391253.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v5.4.161-rt67-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream 5.10 commit e88f48e796b2286b565ee95ca8c46f32e051cd8c ]

might_sleep_no_state_check() serves the same purpose as might_sleep()
except it is used before sleeping locks are acquired and therefore does
not check task_struct::state because the state is preserved.

That state is preserved in the locking slow path so we must not schedule
at the begin of the locking function because the state will be lost and
not preserved at that time.

Remove might_resched() from might_sleep_no_state_check() to avoid losing the
state before it is preserved.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f5ec1ddbfe07..fac917085516 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -229,7 +229,7 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 	do { __might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
 
 # define might_sleep_no_state_check() \
-	do { ___might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
+	do { ___might_sleep(__FILE__, __LINE__, 0); } while (0)
 
 /**
  * cant_sleep - annotation for functions that cannot sleep
-- 
2.17.1

