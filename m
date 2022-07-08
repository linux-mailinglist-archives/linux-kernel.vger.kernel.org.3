Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C4556C30E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbiGHWZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbiGHWZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:25:41 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD0FA2E61
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 15:25:40 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:59826)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o9wPq-004o3a-Ov; Fri, 08 Jul 2022 16:25:38 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:43408 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o9wPp-00AEXn-O8; Fri, 08 Jul 2022 16:25:38 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        bigeasy@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Robert O'Callahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Oleg Nesterov <oleg@redhat.com>
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
Date:   Fri, 08 Jul 2022 17:25:31 -0500
In-Reply-To: <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 22 Jun 2022 11:43:37 -0500")
Message-ID: <87edyvgs2s.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o9wPp-00AEXn-O8;;;mid=<87edyvgs2s.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/stSDpTvjFDPy2IhraphYlslMz8o/ejjI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Keno Fischer <keno@juliacomputing.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 454 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (2.8%), b_tie_ro: 11 (2.4%), parse: 1.23
        (0.3%), extract_message_metadata: 15 (3.3%), get_uri_detail_list: 1.23
        (0.3%), tests_pri_-1000: 19 (4.1%), tests_pri_-950: 1.60 (0.4%),
        tests_pri_-900: 1.22 (0.3%), tests_pri_-90: 173 (38.1%), check_bayes:
        171 (37.6%), b_tokenize: 7 (1.5%), b_tok_get_all: 7 (1.6%),
        b_comp_prob: 2.6 (0.6%), b_tok_touch_all: 150 (33.0%), b_finish: 1.15
        (0.3%), tests_pri_0: 208 (46.0%), check_dkim_signature: 0.88 (0.2%),
        check_dkim_adsp: 3.6 (0.8%), poll_dns_idle: 1.41 (0.3%), tests_pri_10:
        4.4 (1.0%), tests_pri_500: 14 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/3] ptrace: Stop supporting SIGKILL for PTRACE_EVENT_EXIT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Recently I had a conversation where it was pointed out to me that
> SIGKILL sent to a tracee stropped in PTRACE_EVENT_EXIT is quite
> difficult for a tracer to handle.
>
> Keeping SIGKILL working for anything after the process has been killed
> is also a real pain from an implementation point of view.
>
> So I am attempting to remove this wart in the userspace API and see
> if anyone cares.
>
> Eric W. Biederman (3):
>       signal: Ensure SIGNAL_GROUP_EXIT gets set in do_group_exit
>       signal: Guarantee that SIGNAL_GROUP_EXIT is set on process exit
>       signal: Drop signals received after a fatal signal has been processed
>
>  fs/coredump.c                |  2 +-
>  include/linux/sched/signal.h |  1 +
>  kernel/exit.c                | 20 +++++++++++++++++++-
>  kernel/fork.c                |  2 ++
>  kernel/signal.c              |  3 ++-
>  5 files changed, 25 insertions(+), 3 deletions(-)

RR folks any comments?

Did I properly understand what Keno Fischer was asking for when we
talked in person?

Eric
