Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB1A488C36
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiAIUQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:16:04 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:48490 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiAIUQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:16:03 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id F08E82013EC;
        Sun,  9 Jan 2022 20:15:59 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id C345680240; Sun,  9 Jan 2022 21:14:23 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH] pcmcia: fix setting of kthread task states
Date:   Sun,  9 Jan 2022 21:14:15 +0100
Message-Id: <20220109201415.78895-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to set TASK_INTERRUPTIBLE before calling kthread_should_stop().
Otherwise, kthread_stop() might see that the pccardd thread is still
in TASK_RUNNING state and fail to wake it up.

Additonally, we only need to set the state back to TASK_RUNNING if
kthread_should_stop() breaks the loop.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Fixes: d3046ba809ce ("pcmcia: fix a boot time warning in pcmcia cs code")
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/cs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index e211e2619680..f70197154a36 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -666,18 +666,16 @@ static int pccardd(void *__skt)
 		if (events || sysfs_events)
 			continue;
 
+		set_current_state(TASK_INTERRUPTIBLE);
 		if (kthread_should_stop())
 			break;
 
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		schedule();
 
-		/* make sure we are running */
-		__set_current_state(TASK_RUNNING);
-
 		try_to_freeze();
 	}
+	/* make sure we are running before we exit */
+	__set_current_state(TASK_RUNNING);
 
 	/* shut down socket, if a device is still present */
 	if (skt->state & SOCKET_PRESENT) {
-- 
2.34.1

