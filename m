Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC33465750
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbhLAUrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352975AbhLAUoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:44:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D90C06175A;
        Wed,  1 Dec 2021 12:41:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 73FDFCE2105;
        Wed,  1 Dec 2021 20:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EAFC53FD0;
        Wed,  1 Dec 2021 20:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638391275;
        bh=u7hDbDByWYfT0TX0W3OHC3WM8OBJ/lrCMsCnd08PHIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=bzqexLznTw7eifiMaUbFNhSjDXnaFMdYCRsBnL94R0vJXvOy1JIvLIGzFe9J8FIKF
         goDWWE5ZeTmV0sAMauilCwnZXxEAnFB1oOZZ4cb3ssIkD61QBwLNuH2FqxND2jv2WV
         lIvoltR27E8bdy/IECR3/ezQBwHvB684iiiHfqgEawIcjaibMht6KAf+BBqwzDHKrz
         2dx+k7s4a5KqxQlhPTY8al2uM0O3btosQ0Ovxd+h5HI2U+BK2pTZK6WCWkP2pYDABy
         org2Owk/Fi5APfUyLfmjhU7II9nG9xbLM4SKijvuyspNqmdj6eewBiH4OFyLxHV73V
         CDHMht83/Fu6w==
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
Cc:     stable-rt@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH RT 4/8] mm: Disable NUMA_BALANCING_DEFAULT_ENABLED and TRANSPARENT_HUGEPAGE on PREEMPT_RT
Date:   Wed,  1 Dec 2021 14:41:04 -0600
Message-Id: <0421bbd936f2b617164726e47825ce243f0fa5ee.1638391253.git.zanussi@kernel.org>
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


[ Upstream commit aae93144898af113331668f53f80cb83f5a07360 ]

TRANSPARENT_HUGEPAGE:
There are potential non-deterministic delays to an RT thread if a critical
memory region is not THP-aligned and a non-RT buffer is located in the same
hugepage-aligned region. It's also possible for an unrelated thread to migrate
pages belonging to an RT task incurring unexpected page faults due to memory
defragmentation even if khugepaged is disabled.

Regular HUGEPAGEs are not affected by this can be used.

NUMA_BALANCING:
There is a non-deterministic delay to mark PTEs PROT_NONE to gather NUMA fault
samples, increased page faults of regions even if mlocked and non-deterministic
delays when migrating pages.

[Mel Gorman worded 99% of the commit description].

Link: https://lore.kernel.org/all/20200304091159.GN3818@techsingularity.net/
Link: https://lore.kernel.org/all/20211026165100.ahz5bkx44lrrw5pt@linutronix.de/
Cc: stable-rt@vger.kernel.org
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20211028143327.hfbxjze7palrpfgp@linutronix.de
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 266802704c06..c733392fe237 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -769,7 +769,7 @@ config NUMA_BALANCING
 	bool "Memory placement aware NUMA scheduler"
 	depends on ARCH_SUPPORTS_NUMA_BALANCING
 	depends on !ARCH_WANT_NUMA_VARIABLE_LOCALITY
-	depends on SMP && NUMA && MIGRATION
+	depends on SMP && NUMA && MIGRATION && !PREEMPT_RT
 	help
 	  This option adds support for automatic NUMA aware memory/task placement.
 	  The mechanism is quite primitive and is based on migrating memory when
-- 
2.17.1

