Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24C746574D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353206AbhLAUqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:46:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34032 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352973AbhLAUoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:44:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B7A9B81F49;
        Wed,  1 Dec 2021 20:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94C2C53FCF;
        Wed,  1 Dec 2021 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638391273;
        bh=xhGJRz9BulQnvsOgFE2Mr1fKCRSkEYqt5PpRCrxkWL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CZ578Q3NDDUSWRMjBPndP9vGk/2xQTprej9Eb3FXs0gBkhHZG7AJTM4uEfAe7fMwC
         kgk9J28qvfwMFgVLggUyDsRi4w7JfkpbGB6PDwQLaaH6F7oPc9CDMqg+vhbZSVRFqF
         T1WVy24hJadazQdN6Z26JrhF/u+auYWPtBIVqUpYfi31p7/N3rU0ZkcfljGHM4E9GR
         s2nOyySFP4aaUNTBsuxhG0QYcJhjdtuEHYJ5MjfQgUNAyqHphWJbubZBiIVSIFSJ5w
         e9Y0qtjKupu0bGFUD+gUavf7Nj7mv2Mpok7YlYz4FL1aJdMO59aGJfDVN5d1LefsnS
         JRrPQwS1j8Olg==
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
Cc:     stable-rt@vger.kernel.org
Subject: [PATCH RT 3/8] preempt: Move preempt_enable_no_resched() to the RT block
Date:   Wed,  1 Dec 2021 14:41:03 -0600
Message-Id: <9d8babfb7cbd1d5639c50b352d32cf5ab6f83daf.1638391253.git.zanussi@kernel.org>
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


[ Upstream commit 1a45b3551ef852193c3d338888132c4925d0690d ]

preempt_enable_no_resched() should point to preempt_enable() on
PREEMPT_RT so nobody is playing any preempt tricks and enables
preemption without checking for the need-resched flag.

This was misplaced in v3.14.0-rt1 und remained unnoticed until now.

Point preempt_enable_no_resched() and preempt_enable() on RT.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/preempt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index adb085fe31e4..bbc3592b6f04 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -211,12 +211,12 @@ do { \
 	preempt_count_dec(); \
 } while (0)
 
-#ifdef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPT_RT
 # define preempt_enable_no_resched() sched_preempt_enable_no_resched()
-# define preempt_check_resched_rt() preempt_check_resched()
+# define preempt_check_resched_rt() barrier();
 #else
 # define preempt_enable_no_resched() preempt_enable()
-# define preempt_check_resched_rt() barrier();
+# define preempt_check_resched_rt() preempt_check_resched()
 #endif
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
-- 
2.17.1

