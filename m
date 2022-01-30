Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941CE4A3AAD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 23:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352469AbiA3WTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 17:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiA3WTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:19:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6325C061714;
        Sun, 30 Jan 2022 14:19:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55C2C60F56;
        Sun, 30 Jan 2022 22:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7992CC340E4;
        Sun, 30 Jan 2022 22:19:44 +0000 (UTC)
X-Mailbox-Line: From 21c067c189901e2f7b368bc1ff6e7216a367c347 Mon Sep 17 00:00:00 2001
From:   Clark Williams <clark.williams@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.org>,
        linux-rt-users@vger.kernel.org, williams@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 30 Jan 2022 15:46:27 -0600
Subject: [PATCH PREEMPT_RT 4.19 STABLE] rt:  PREEMPT_RT safety net for backported patches
Message-Id: <20220130221944.7992CC340E4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While doing some 4.19-rt cleanup work, I stumbled across the fact that parts of
two backported patches were dependent on CONFIG_PREEMPT_RT, rather than
the CONFIG_PREEMPT_RT_FULL used in 4.19 and earlier RT series.  The commits
in the linux-stable-rt v4.19-rt branch are:

dad4c6a33bf4e mm: slub: Don't resize the location tracking cache on PREEMPT_RT
e626b6f873f2c net: Treat __napi_schedule_irqoff() as __napi_schedule() on PREEMPT_RT

Discussing this at the Stable RT maintainers meeting, Steven Rostedt suggested that
we automagically select CONFIG_PREEMPT_RT if CONFIG_PREEMPT_RT_FULL is on, giving
us a safety net for any subsequently backported patches. Here's my first cut at
that patch.

I suspect we'll need a similar patch for stable RT kernels < 4.19.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 kernel/Kconfig.preempt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 306567f72a3e..951f58cbd652 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -6,6 +6,10 @@ config PREEMPT_RT_BASE
 	bool
 	select PREEMPT
 
+config PREEMPT_RT
+       bool
+       default false
+
 config HAVE_PREEMPT_LAZY
 	bool
 
@@ -80,6 +84,7 @@ config PREEMPT_RT_FULL
 	depends on IRQ_FORCED_THREADING
 	select PREEMPT_RT_BASE
 	select PREEMPT_RCU
+	select PREEMPT_RT
 	help
 	  All and everything
 
-- 
2.34.1

