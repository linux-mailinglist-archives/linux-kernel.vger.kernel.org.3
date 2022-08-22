Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C5859BECC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiHVLse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiHVLsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:48:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8142DB;
        Mon, 22 Aug 2022 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=knAjhsG/6jthQQWVo2QqXwIZ8VPSdd1nuBR6NhivhIM=; b=jTXfHl5rGNr1GZo5Hw1OkcgndP
        LcklSXEiRRjACSZWWyXodFfcZp/VY/WB3qm0SLO8NCmc0IvAMwq8DqHBte8v9/auhMpExkZG+rECZ
        IpicUshoT8R/h/ey5JX4tqgZKn3KK0s/Tp7/HalmRwcYQ/9lsljjwBALDtHJrdBT5iupn8cpSM/Gc
        /Tw3e3gJAfIFab228UkSe8QiHLQ0ci1Xg3ShkZW5GIvgMohGP/2I/q+4s/FYDc8FOVUiQVtsILPyu
        miBFNTPGUtx/79IxXpLrE6l4iOn7u9lDDGDx6v5OWmrdoJOrRvb1iIIMZfVd7Ne+8mkJTYVxYCX6t
        T127jj8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ5uM-00EEet-1H; Mon, 22 Aug 2022 11:47:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7B97300326;
        Mon, 22 Aug 2022 13:47:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8C20320187A6F; Mon, 22 Aug 2022 13:47:50 +0200 (CEST)
Message-ID: <20220822114648.791019324@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Aug 2022 13:18:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 2/6] freezer,umh: Clean up freezer/initrd interaction
References: <20220822111816.760285417@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

handle_initrd() marks itself as PF_FREEZER_SKIP in order to ensure
that the UMH, which is going to freeze the system, doesn't
indefinitely wait for it's caller.

Rework things by adding UMH_FREEZABLE to indicate the completion is
freezable.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/umh.h     |    9 +++++----
 init/do_mounts_initrd.c |   10 +---------
 kernel/umh.c            |    8 ++++++++
 3 files changed, 14 insertions(+), 13 deletions(-)

--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -11,10 +11,11 @@
 struct cred;
 struct file;
 
-#define UMH_NO_WAIT	0	/* don't wait at all */
-#define UMH_WAIT_EXEC	1	/* wait for the exec, but not the process */
-#define UMH_WAIT_PROC	2	/* wait for the process to complete */
-#define UMH_KILLABLE	4	/* wait for EXEC/PROC killable */
+#define UMH_NO_WAIT	0x00	/* don't wait at all */
+#define UMH_WAIT_EXEC	0x01	/* wait for the exec, but not the process */
+#define UMH_WAIT_PROC	0x02	/* wait for the process to complete */
+#define UMH_KILLABLE	0x04	/* wait for EXEC/PROC killable */
+#define UMH_FREEZABLE	0x08	/* wait for EXEC/PROC freezable */
 
 struct subprocess_info {
 	struct work_struct work;
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -79,19 +79,11 @@ static void __init handle_initrd(void)
 	init_mkdir("/old", 0700);
 	init_chdir("/old");
 
-	/*
-	 * In case that a resume from disk is carried out by linuxrc or one of
-	 * its children, we need to tell the freezer not to wait for us.
-	 */
-	current->flags |= PF_FREEZER_SKIP;
-
 	info = call_usermodehelper_setup("/linuxrc", argv, envp_init,
 					 GFP_KERNEL, init_linuxrc, NULL, NULL);
 	if (!info)
 		return;
-	call_usermodehelper_exec(info, UMH_WAIT_PROC);
-
-	current->flags &= ~PF_FREEZER_SKIP;
+	call_usermodehelper_exec(info, UMH_WAIT_PROC|UMH_FREEZABLE);
 
 	/* move initrd to rootfs' /old */
 	init_mount("..", ".", NULL, MS_MOVE, NULL);
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -28,6 +28,7 @@
 #include <linux/async.h>
 #include <linux/uaccess.h>
 #include <linux/initrd.h>
+#include <linux/freezer.h>
 
 #include <trace/events/module.h>
 
@@ -436,6 +437,9 @@ int call_usermodehelper_exec(struct subp
 	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
 		goto unlock;
 
+	if (wait & UMH_FREEZABLE)
+		freezer_do_not_count();
+
 	if (wait & UMH_KILLABLE) {
 		retval = wait_for_completion_killable(&done);
 		if (!retval)
@@ -448,6 +452,10 @@ int call_usermodehelper_exec(struct subp
 	}
 
 	wait_for_completion(&done);
+
+	if (wait & UMH_FREEZABLE)
+		freezer_count();
+
 wait_done:
 	retval = sub_info->retval;
 out:


