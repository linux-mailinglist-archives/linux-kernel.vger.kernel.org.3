Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA81C55F44C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 05:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiF2Dpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 23:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiF2Dpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:45:39 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF017E33;
        Tue, 28 Jun 2022 20:45:38 -0700 (PDT)
X-UUID: 39b93c53ef7e412f860efe34d9938852-20220629
X-Spam-Fingerprint: 0
X-GW-Reason: 11109
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HNeS6uumcgOimgeWuoeaguA==
X-Content-Feature: ica/max.line-size 73
        audit/email.address 1
        dict/adv 1
        dict/contack 1
        dict/job 1
        dict/notice 1
        dict/operate 1
        dict/time 1
        meta/cnt.alert 1
X-CPASD-INFO: 98e5361e75aa41c9ab3a1a3410923128@goifVWBoX5VjVaOtg3Suc4GTY5FhjVO
        Dc2pZYmFhXliVgnxsTWBnX1OEgnBQYl5dZFZ3dG9RYmBgYlB_i4Jyj1RgXmCCVHSTgHtyhWVhZg==
X-CLOUD-ID: 98e5361e75aa41c9ab3a1a3410923128
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:182.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:195.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:2,DUF:128,ACD:2,DCD:2,SL:0,EISP:0,AG:0,CFC:0.512,CFSR:0.049,UAT:0,RAF:0
        ,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,EAF:
        0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 39b93c53ef7e412f860efe34d9938852-20220629
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 39b93c53ef7e412f860efe34d9938852-20220629
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <xiongxin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 588509231; Wed, 29 Jun 2022 08:34:18 +0800
From:   xiongxin <xiongxin@kylinos.cn>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiongxin@kylinos.cn
Subject: [PATCH -next 2/2] PM: suspend: advanced pm_wakeup_clear() for normal suspend/hibernate
Date:   Wed, 29 Jun 2022 08:33:38 +0800
Message-Id: <20220629003338.299195-3-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629003338.299195-1-xiongxin@kylinos.cn>
References: <20220629003338.299195-1-xiongxin@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_PBL,RDNS_DYNAMIC,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_wakeup_clear() will clear the wakeup source, which can ensure that it
is not disturbed by useless wakeup signals when doing suspend/hibernate;

At the beginning of the suspend/hibernate process, the notifier
mechanism is used to notify other device drivers. This action is
time-consuming (second-level time-consuming). If the process fails due
to the received wakeup signal during the execution of these functions,
it can better improve the experience of failing suspend/hibernate
returns;

Therefore, it is recommended here that for the suspend/hibernate process
normally called from /sys/power/state, the pm_wakeup_clear() function
should be brought before the notifier call; for the freeze_process()
function called from other places, the original logic is kept;

The pm_suspend_target_state variable is used here to identify whether the
suspend process is going normally.

Signed-off-by: xiongxin <xiongxin@kylinos.cn>
---
 kernel/power/process.c | 5 ++++-
 kernel/power/suspend.c | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 3068601e585a..3fde0240b3d1 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -131,7 +131,10 @@ int freeze_processes(void)
 	if (!pm_freezing)
 		atomic_inc(&system_freezing_cnt);
 
-	pm_wakeup_clear(0);
+	if (pm_suspend_target_state != PM_SUSPEND_ON)
+		pm_wakeup_clear(1);
+	else
+		pm_wakeup_clear(0);
 	pr_info("Freezing user space processes ... ");
 	pm_freezing = true;
 	error = try_to_freeze_tasks(true);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index c754b084ec03..f4259f6c1cc2 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -569,6 +569,12 @@ static int enter_state(suspend_state_t state)
 	 * performed from the /sys/power/state entry.
 	 */
 	pm_suspend_target_state = state;
+	/*
+	 * Put pm_wakeup_clear() before the notifier notification chain to
+	 * optimize in the suspend process, the wakeup signal can interrupt
+	 * the suspend in advance and fail to return.
+	 */
+	pm_wakeup_clear(0);
 
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
