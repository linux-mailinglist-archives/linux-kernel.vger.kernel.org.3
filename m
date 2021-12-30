Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8132481E04
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhL3QTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:19:13 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:57780 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbhL3QTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OdDk0xh9+JuaraiDOwpUe0sx5V/XA/yP3wgThBRC8so=; b=PYK0pGr1GAh3BYj5Ig9YP1jt0+
        tveUV048/tVR1xb1+bo+q+h0EMOGAuWY4CNn3to/oCEYJl9b39QOVWTagRlhh5nILGQWKJtDMe1zH
        QxTg7dbb92zM4p5iGrVFO48Y9/aG4suqljdLQeFNxGpdJR7z3TSMqnS2aUwOZvQ5gUe/xsZ1j2Buo
        njWrnyiijXu20aphPH7NchtapD/lrjWlnyPfiyxs/Ynxo23mAJASFyJdQUoLJnY6DEvHF7wI6NA3h
        B41H3j9fyBjBsWjXYOCrAULLQbe/cH0xfLcWpj2EyGXUa+Dd20GvRGyfnMZHimqhUAIZ2loGvWUrn
        p7povfqQ==;
Received: from 200-153-146-242.dsl.telesp.net.br ([200.153.146.242] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1n2y8t-000AOf-4m; Thu, 30 Dec 2021 17:19:03 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     gpiccoli@igalia.com, kernel@gpiccoli.net, pmladek@suse.com,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: [PATCH] panic: Move panic_print before kmsg dumpers
Date:   Thu, 30 Dec 2021 13:18:28 -0300
Message-Id: <20211230161828.121858-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panic_print setting allows users to collect more information in a
panic event, like memory stats, tasks, CPUs backtraces, etc.
This is a pretty interesting debug mechanism, but currently the print
event happens *after* kmsg_dump(), meaning that Pstore, for example,
cannot collect a dmesg with the panic_print information.

This patch changes that by moving the panic_print_sys_info() function
call up some lines, in order kmsg_dump() accounts this new information
and exposes it through Pstore or other kmsg dumpers.

Cc: Feng Tang <feng.tang@intel.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


Hey folks, thanks in advance for reviews/comments!
One alternative I've considered was to move kmsg_dump() some
lines down, I'm not sure which approach is better, can't see
much difference. Opinions are very welcome =)
Cheers,


Guilherme


 kernel/panic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366f..d918da0a1c29 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -271,6 +271,8 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	panic_print_sys_info();
+
 	kmsg_dump(KMSG_DUMP_PANIC);
 
 	/*
@@ -301,8 +303,6 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
-	panic_print_sys_info();
-
 	if (!panic_blink)
 		panic_blink = no_blink;
 
-- 
2.34.1

