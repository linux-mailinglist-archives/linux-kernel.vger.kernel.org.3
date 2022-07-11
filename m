Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD1570B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiGKUAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKUAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:00:47 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718A83C8F6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:00:46 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39680)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oAzaH-006i2M-8Q; Mon, 11 Jul 2022 14:00:45 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:39664 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oAzaG-00Bnoh-D9; Mon, 11 Jul 2022 14:00:44 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Jul 2022 15:00:36 -0500
Message-ID: <87ilo3ctcr.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oAzaG-00Bnoh-D9;;;mid=<87ilo3ctcr.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/oE0bTBNrqEvz5+U4UaTWaRUKCuRr2JNE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 332 ms - load_scoreonly_sql: 0.29 (0.1%),
        signal_user_changed: 15 (4.7%), b_tie_ro: 12 (3.5%), parse: 2.4 (0.7%),
         extract_message_metadata: 19 (5.7%), get_uri_detail_list: 1.53 (0.5%),
         tests_pri_-1000: 18 (5.5%), tests_pri_-950: 3.1 (0.9%),
        tests_pri_-900: 2.4 (0.7%), tests_pri_-90: 58 (17.5%), check_bayes: 55
        (16.7%), b_tokenize: 5 (1.6%), b_tok_get_all: 4.5 (1.4%), b_comp_prob:
        2.3 (0.7%), b_tok_touch_all: 39 (11.6%), b_finish: 1.31 (0.4%),
        tests_pri_0: 166 (49.8%), check_dkim_signature: 1.09 (0.3%),
        check_dkim_adsp: 4.2 (1.3%), poll_dns_idle: 1.40 (0.4%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 40 (12.0%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ptrace: fix clearing of JOBCTL_TRACED in
 ptrace_unfreeze_traced()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the ptrace_unfreeze_fix-for-v5.19 tag from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace_unfreeze_fix-for-v5.19
  HEAD: 3418357a32db6c8ce5e4417964bac1edcc3f281a ptrace: fix clearing of JOBCTL_TRACED in ptrace_unfreeze_traced()

This change fixes a small but very problematic typo.

Sven Schnelle (1):
      ptrace: fix clearing of JOBCTL_TRACED in ptrace_unfreeze_traced()

 kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
