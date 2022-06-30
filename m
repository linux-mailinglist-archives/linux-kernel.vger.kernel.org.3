Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516005611EF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 07:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiF3FvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 01:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiF3FvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 01:51:12 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6319F29C80;
        Wed, 29 Jun 2022 22:51:09 -0700 (PDT)
X-UUID: e7805405b3204ff9bc52d329ace227c3-20220630
X-Spam-Fingerprint: 0
X-GW-Reason: 13103
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HNeS6uumcgOimgeWuoeaguA==
X-Content-Feature: ica/max.line-size 74
        audit/email.address 1
        dict/adv 1
        dict/notice 1
        dict/time 1
        meta/cnt.alert 1
X-CPASD-INFO: f04af3d012a344bab0b433d0e571db6a@r4BugZNlkmBdUqN_g3etm4JhkmRjX4R
        _p29XYZKSYoGVgnxsTWBnX1OEgnBQYl5dZFZ3dG9RYmBgYlB_i4Jyj1RgXmCCVHSTgKhqVJGUYw==
X-CLOUD-ID: f04af3d012a344bab0b433d0e571db6a
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:182.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:187.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:10,DUF:236,ACD:3,DCD:3,SL:0,EISP:0,AG:0,CFC:0.552,CFSR:0.049,UAT:0,RAF:
        0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,EAF
        :0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: e7805405b3204ff9bc52d329ace227c3-20220630
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: e7805405b3204ff9bc52d329ace227c3-20220630
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <xiongxin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 908372878; Thu, 30 Jun 2022 08:57:52 +0800
From:   xiongxin <xiongxin@kylinos.cn>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        xiongxin@kylinos.cn, luriwen@kylinos.cn
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 -next 1/2] PM: suspend: expand the assignment scope of the pm_suspend_target_state
Date:   Thu, 30 Jun 2022 08:57:17 +0800
Message-Id: <20220630005718.309178-2-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630005718.309178-1-xiongxin@kylinos.cn>
References: <20220630005718.309178-1-xiongxin@kylinos.cn>
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

The pm_suspend_target_state variable can be used as a suspend state
identifier and given to the specific device driver as a code judgment;

Because the suspend_prepare() function is time-consuming for the
operation of freezing processes, and this stage is actually in the suspend
stage, it is necessary to expand the scope of the pm_suspend_target_state
variable to be assigned to the suspend state at enter_state() function;

Another reason is that the specific device driver can locate whether it is
in the suspend state based on this variable, so as to determine the
validity of its wake-up source.

Signed-off-by: xiongxin <xiongxin@kylinos.cn>
---
 kernel/power/suspend.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 827075944d28..4cfa464600bf 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -48,7 +48,7 @@ const char *mem_sleep_states[PM_SUSPEND_MAX];
 
 suspend_state_t mem_sleep_current = PM_SUSPEND_TO_IDLE;
 suspend_state_t mem_sleep_default = PM_SUSPEND_MAX;
-suspend_state_t pm_suspend_target_state;
+suspend_state_t pm_suspend_target_state = PM_SUSPEND_ON;
 EXPORT_SYMBOL_GPL(pm_suspend_target_state);
 
 unsigned int pm_suspend_global_flags;
@@ -564,6 +564,12 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
+	/*
+	 * Expand the scope of suspend state for suspend operations
+	 * performed from the /sys/power/state entry.
+	 */
+	pm_suspend_target_state = state;
+
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
 		ksys_sync_helper();
@@ -590,6 +596,7 @@ static int enter_state(suspend_state_t state)
 	pm_pr_dbg("Finishing wakeup.\n");
 	suspend_finish();
  Unlock:
+	pm_suspend_target_state = PM_SUSPEND_ON;
 	mutex_unlock(&system_transition_mutex);
 	return error;
 }
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
