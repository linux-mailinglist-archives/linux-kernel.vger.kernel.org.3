Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97764D3708
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiCIQqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbiCIQbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:41 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB4C19D634
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:26:09 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:35936)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz8I-00CNBn-UC; Wed, 09 Mar 2022 09:25:50 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz8I-005hAS-27; Wed, 09 Mar 2022 09:25:50 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:52 -0600
Message-Id: <20220309162454.123006-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz8I-005hAS-27;;;mid=<20220309162454.123006-11-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/xGYbyRUb4cp99k8UiT6cL7eMGMoOzO8E=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 276 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (4.1%), b_tie_ro: 10 (3.5%), parse: 0.81
        (0.3%), extract_message_metadata: 11 (3.9%), get_uri_detail_list: 0.61
        (0.2%), tests_pri_-1000: 14 (5.0%), tests_pri_-950: 1.23 (0.4%),
        tests_pri_-900: 1.00 (0.4%), tests_pri_-90: 79 (28.7%), check_bayes:
        78 (28.2%), b_tokenize: 4.4 (1.6%), b_tok_get_all: 5 (1.8%),
        b_comp_prob: 1.68 (0.6%), b_tok_touch_all: 64 (23.0%), b_finish: 0.84
        (0.3%), tests_pri_0: 146 (53.0%), check_dkim_signature: 0.63 (0.2%),
        check_dkim_adsp: 3.0 (1.1%), poll_dns_idle: 0.76 (0.3%), tests_pri_10:
        2.0 (0.7%), tests_pri_500: 7 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 11/13] resume_user_mode: Remove #ifdef TIF_NOTIFY_RESUME in set_notify_resume
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every architecture defines TIF_NOTIFY_RESUME so remove the unnecessary
ifdef.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/tracehook.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 1b7365aef8da..946404ebe10b 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -63,10 +63,8 @@ struct linux_binprm;
  */
 static inline void set_notify_resume(struct task_struct *task)
 {
-#ifdef TIF_NOTIFY_RESUME
 	if (!test_and_set_tsk_thread_flag(task, TIF_NOTIFY_RESUME))
 		kick_process(task);
-#endif
 }
 
 /**
-- 
2.29.2

