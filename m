Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFA657718B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 23:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiGPVb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 17:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGPVb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 17:31:28 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397D255A7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 14:31:28 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:53112)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oCpNl-003XHC-Sw; Sat, 16 Jul 2022 15:31:25 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:48014 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oCpNk-0096qh-SE; Sat, 16 Jul 2022 15:31:25 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Robert O'Callahan" <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Oleg Nesterov <oleg@redhat.com>
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
        <87edyvgs2s.fsf@email.froward.int.ebiederm.org>
        <CABV8kRxQNPUzLaJ1tFF8H-E_iqCkz0+Ac5rPBurnmA3GcofMmQ@mail.gmail.com>
        <875yk22j5z.fsf@email.froward.int.ebiederm.org>
Date:   Sat, 16 Jul 2022 16:29:49 -0500
In-Reply-To: <875yk22j5z.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 12 Jul 2022 15:03:04 -0500")
Message-ID: <87pmi4ycdu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oCpNk-0096qh-SE;;;mid=<87pmi4ycdu.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+/Vjcg1LG+PkIixgXe8YCIN4VRwU6Ap+E=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Keno Fischer <keno@juliacomputing.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 445 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (2.7%), b_tie_ro: 11 (2.4%), parse: 1.34
        (0.3%), extract_message_metadata: 21 (4.6%), get_uri_detail_list: 2.4
        (0.5%), tests_pri_-1000: 33 (7.5%), tests_pri_-950: 1.45 (0.3%),
        tests_pri_-900: 1.15 (0.3%), tests_pri_-90: 82 (18.5%), check_bayes:
        80 (18.0%), b_tokenize: 8 (1.9%), b_tok_get_all: 8 (1.8%),
        b_comp_prob: 3.0 (0.7%), b_tok_touch_all: 56 (12.7%), b_finish: 1.20
        (0.3%), tests_pri_0: 280 (62.8%), check_dkim_signature: 0.77 (0.2%),
        check_dkim_adsp: 3.7 (0.8%), poll_dns_idle: 1.08 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/3] ptrace: Stop supporting SIGKILL for PTRACE_EVENT_EXIT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Keno Fischer <keno@juliacomputing.com> writes:
>
>> Hi Eric,
>>
>> On Fri, Jul 8, 2022 at 6:25 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>> > Recently I had a conversation where it was pointed out to me that
>>> > SIGKILL sent to a tracee stropped in PTRACE_EVENT_EXIT is quite
>>> > difficult for a tracer to handle.
>>> >
>>>
>>> RR folks any comments?
>>>
>>> Did I properly understand what Keno Fischer was asking for when we
>>> talked in person?
>>
>> Yes, this is indeed what I had in mind. I have not yet had the opportunity
>> to try out your patch series (sorry), but from visual inspection, it does indeed
>> do what I wanted, which is to make sure that a tracee stays in
>> PTRACE_EVENT_EXIT for the tracer to inspect, even if there is another
>> SIGKILL incoming simultaneously (since otherwise it may be impossible
>> for the tracer to observe the PTRACE_EVENT_EXIT if two SIGKILLs
>> come in rapid succession). I will try to take this series for a proper spin
>> shortly.
>
> Thanks,
>
> I haven't yet figured out how to get the rr test suite to run
> successfully.  Something about my test machine and lack of perf counters
> seems to be causing problems.  So if you can perform the testing on your
> side that would be fantastic.

Ok.  I finally found a machine where I can run rr and the rr test suite.

It looks like there are a couple of the rr 5.5.0 test that fail on
Linus's lastest kernel simply because of changes in kernel behavior.  In
particular clone_cleartid_coredump, and fcntl_rw_hints.  The
clone_cleartid_coredump appears to fail because SIGSEGV no longer kills
all processes that share an mm.  Which was a deliberate change.

With the lastest development version of rr, only detach_sigkill appears
to be failing on Linus's latest.  That failure appears to be independent
of the patches in question as well.  When run manually the
detach_sigkill test succeeds so I am not quite certain what is going on,
any thoughts?

As for my patchset it looks like it does not cause any new test failures
for rr so I will plan on getting it into linux-next shortly.

Eric

