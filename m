Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ED5570B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiGKUEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKUEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:04:08 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C688DE80
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:04:07 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:36214)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oAzdW-009bPy-4R; Mon, 11 Jul 2022 14:04:06 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:39676 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oAzdU-00BoPI-KJ; Mon, 11 Jul 2022 14:04:05 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Jul 2022 15:03:58 -0500
Message-ID: <87a69fct75.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oAzdU-00BoPI-KJ;;;mid=<87a69fct75.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/4PWT21BmdIOApvVIUj1DedADrXMb0YSk=
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
X-Spam-Timing: total 384 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (3.2%), b_tie_ro: 10 (2.7%), parse: 1.33
        (0.3%), extract_message_metadata: 17 (4.5%), get_uri_detail_list: 1.50
        (0.4%), tests_pri_-1000: 20 (5.3%), tests_pri_-950: 1.80 (0.5%),
        tests_pri_-900: 1.37 (0.4%), tests_pri_-90: 128 (33.2%), check_bayes:
        126 (32.7%), b_tokenize: 7 (1.8%), b_tok_get_all: 18 (4.7%),
        b_comp_prob: 1.53 (0.4%), b_tok_touch_all: 95 (24.8%), b_finish: 0.99
        (0.3%), tests_pri_0: 140 (36.3%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 0.54 (0.1%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 56 (14.5%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ipc: Fix free mq_sysctls when ipc namespace creation fails
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the free-mq_sysctls-for-v5.19 tag from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git free-mq_sysctls-for-v5.19
  HEAD: db7cfc380900bc4243b09623fd72fabe0a8ff23b ipc: Free mq_sysctls if ipc namespace creation failed

This fixes a bug with error handling if ipc creation fails that
was reported by syzbot.

Alexey Gladkov (1):
      ipc: Free mq_sysctls if ipc namespace creation failed

 ipc/namespace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

