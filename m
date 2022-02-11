Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418FB4B1BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347118AbiBKCBh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Feb 2022 21:01:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbiBKCBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:01:36 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B745F48
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:01:36 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:36568)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nILFd-00BSHq-U6; Thu, 10 Feb 2022 19:01:33 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:52276 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nILFc-006jmq-Qj; Thu, 10 Feb 2022 19:01:33 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
References: <20220207121800.5079-1-mkoutny@suse.com>
Date:   Thu, 10 Feb 2022 20:01:25 -0600
In-Reply-To: <20220207121800.5079-1-mkoutny@suse.com> ("Michal =?utf-8?Q?K?=
 =?utf-8?Q?outn=C3=BD=22's?=
        message of "Mon, 7 Feb 2022 13:17:54 +0100")
Message-ID: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nILFc-006jmq-Qj;;;mid=<87o83e2mbu.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19iBzuPMqqn/Nk13JvCCRLIasKl2dLfAfg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 359 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (3.1%), b_tie_ro: 10 (2.7%), parse: 1.21
        (0.3%), extract_message_metadata: 3.5 (1.0%), get_uri_detail_list:
        1.09 (0.3%), tests_pri_-1000: 4.0 (1.1%), tests_pri_-950: 1.26 (0.4%),
        tests_pri_-900: 1.00 (0.3%), tests_pri_-90: 50 (13.9%), check_bayes:
        48 (13.5%), b_tokenize: 6 (1.6%), b_tok_get_all: 6 (1.8%),
        b_comp_prob: 1.93 (0.5%), b_tok_touch_all: 31 (8.7%), b_finish: 0.85
        (0.2%), tests_pri_0: 267 (74.4%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 3.1 (0.9%), poll_dns_idle: 1.32 (0.4%), tests_pri_10:
        2.9 (0.8%), tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/8] ucounts: RLIMIT_NPROC fixes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michal Koutný recently found some bugs in the enforcement of
RLIMIT_NPROC in the recent ucount rlimit implementation.

I saw some additional bugs and some cleaner ways to fix the problem so
instead of starting with his fixes these are my own.

I am aiming to send the first 5 of these to Linus once they have been
reviewed.  Two more are fixes in principle but I don't think do anything
in practice.  The last one is just a cleanup to prevent future
divergence of RLIMIT_NPROC logic.

Eric W. Biederman (8):
      ucounts: Fix RLIMIT_NPROC regression
      ucounts: Fix set_cred_ucounts
      ucounts: Fix and simplify RLIMIT_NPROC handling during setuid()+execve
      ucounts: Only except the root user in init_user_ns from RLIMIT_NPROC
      ucounts: Handle wrapping in is_ucounts_overlimit
      ucounts: Handle inc_rlimit_ucounts wrapping in fork
      rlimit: For RLIMIT_NPROC test the child not the parent for capabilites
      ucounts: Use the same code to enforce RLIMIT_NPROC in fork and exec

 fs/exec.c                    | 12 +++++-------
 include/linux/sched.h        |  2 +-
 include/linux/sched/signal.h |  2 ++
 kernel/cred.c                | 24 +++++++++++-------------
 kernel/fork.c                | 32 ++++++++++++++++++++++++--------
 kernel/sys.c                 | 14 --------------
 kernel/ucount.c              |  3 ++-
 kernel/user_namespace.c      |  2 ++
 8 files changed, 47 insertions(+), 44 deletions(-)

Eric
