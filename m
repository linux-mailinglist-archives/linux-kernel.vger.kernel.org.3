Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D0955516E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358263AbiFVQoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbiFVQoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:44:15 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8333E19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:44:14 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:57132)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o43Sd-00AWLN-1r; Wed, 22 Jun 2022 10:44:11 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57362 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o43Sa-001XTg-Lr; Wed, 22 Jun 2022 10:44:10 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        bigeasy@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Robert O'Callahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Keno Fischer <keno@juliacomputing.com>
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
Date:   Wed, 22 Jun 2022 11:43:37 -0500
In-Reply-To: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Thu, 05 May 2022 13:25:57 -0500")
Message-ID: <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o43Sa-001XTg-Lr;;;mid=<87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+HUrQnJ1mzH6gsmI5jzL3UyqNu9wsYCv8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1777 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.36
        (0.1%), extract_message_metadata: 3.8 (0.2%), get_uri_detail_list:
        0.82 (0.0%), tests_pri_-1000: 4.2 (0.2%), tests_pri_-950: 1.32 (0.1%),
        tests_pri_-900: 1.05 (0.1%), tests_pri_-90: 78 (4.4%), check_bayes: 77
        (4.3%), b_tokenize: 5 (0.3%), b_tok_get_all: 5 (0.3%), b_comp_prob:
        1.95 (0.1%), b_tok_touch_all: 61 (3.4%), b_finish: 0.85 (0.0%),
        tests_pri_0: 1603 (90.2%), check_dkim_signature: 0.90 (0.1%),
        check_dkim_adsp: 3.5 (0.2%), poll_dns_idle: 0.80 (0.0%), tests_pri_10:
        5 (0.3%), tests_pri_500: 56 (3.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/3] ptrace: Stop supporting SIGKILL for PTRACE_EVENT_EXIT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Recently I had a conversation where it was pointed out to me that
SIGKILL sent to a tracee stropped in PTRACE_EVENT_EXIT is quite
difficult for a tracer to handle.

Keeping SIGKILL working for anything after the process has been killed
is also a real pain from an implementation point of view.

So I am attempting to remove this wart in the userspace API and see
if anyone cares.

Eric W. Biederman (3):
      signal: Ensure SIGNAL_GROUP_EXIT gets set in do_group_exit
      signal: Guarantee that SIGNAL_GROUP_EXIT is set on process exit
      signal: Drop signals received after a fatal signal has been processed

 fs/coredump.c                |  2 +-
 include/linux/sched/signal.h |  1 +
 kernel/exit.c                | 20 +++++++++++++++++++-
 kernel/fork.c                |  2 ++
 kernel/signal.c              |  3 ++-
 5 files changed, 25 insertions(+), 3 deletions(-)

Eric
