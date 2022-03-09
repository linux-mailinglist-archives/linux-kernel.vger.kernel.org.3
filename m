Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8EF4D3786
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbiCIQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbiCIQbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:23 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC56A19416E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:25:44 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:35736)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz84-00CN9i-Og; Wed, 09 Mar 2022 09:25:36 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz83-005hAS-Om; Wed, 09 Mar 2022 09:25:36 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:47 -0600
Message-Id: <20220309162454.123006-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz83-005hAS-Om;;;mid=<20220309162454.123006-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/sct7WF471VqTYi29XPbFVbpflqmi3YZs=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 369 ms - load_scoreonly_sql: 0.23 (0.1%),
        signal_user_changed: 13 (3.4%), b_tie_ro: 10 (2.8%), parse: 1.09
        (0.3%), extract_message_metadata: 13 (3.5%), get_uri_detail_list: 1.26
        (0.3%), tests_pri_-1000: 15 (3.9%), tests_pri_-950: 1.38 (0.4%),
        tests_pri_-900: 1.10 (0.3%), tests_pri_-90: 97 (26.2%), check_bayes:
        95 (25.7%), b_tokenize: 7 (1.9%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 2.1 (0.6%), b_tok_touch_all: 77 (20.7%), b_finish: 1.08
        (0.3%), tests_pri_0: 211 (57.1%), check_dkim_signature: 0.61 (0.2%),
        check_dkim_adsp: 3.0 (0.8%), poll_dns_idle: 1.05 (0.3%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 12 (3.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 06/13] task_work: Remove unnecessary include from posix_timers.h
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break a header file circular dependency by removing the unnecessary
include of task_work.h from posix_timers.h.

sched.h -> posix-timers.h
posix-timers.h -> task_work.h
task_work.h -> sched.h

Add missing includes of task_work.h to:
arch/x86/mm/tlb.c
kernel/time/posix-cpu-timers.c

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/tlb.c              | 1 +
 include/linux/posix-timers.h   | 1 -
 kernel/time/posix-cpu-timers.c | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index a6cf56a14939..6eb4d91d5365 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -9,6 +9,7 @@
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 #include <linux/sched/smt.h>
+#include <linux/task_work.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 5bbcd280bfd2..83539bb2f023 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -6,7 +6,6 @@
 #include <linux/list.h>
 #include <linux/alarmtimer.h>
 #include <linux/timerqueue.h>
-#include <linux/task_work.h>
 
 struct kernel_siginfo;
 struct task_struct;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 96b4e7810426..9190d9eb236d 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -15,6 +15,7 @@
 #include <linux/workqueue.h>
 #include <linux/compat.h>
 #include <linux/sched/deadline.h>
+#include <linux/task_work.h>
 
 #include "posix-timers.h"
 
-- 
2.29.2

