Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FBC5726E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiGLUDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiGLUDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:03:21 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19DB3E74B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:03:20 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:58916)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oBM6F-008snJ-KZ; Tue, 12 Jul 2022 14:03:15 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38716 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oBM6B-00EgHA-UL; Tue, 12 Jul 2022 14:03:14 -0600
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
Date:   Tue, 12 Jul 2022 15:03:04 -0500
In-Reply-To: <CABV8kRxQNPUzLaJ1tFF8H-E_iqCkz0+Ac5rPBurnmA3GcofMmQ@mail.gmail.com>
        (Keno Fischer's message of "Fri, 8 Jul 2022 19:22:01 -0400")
Message-ID: <875yk22j5z.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oBM6B-00EgHA-UL;;;mid=<875yk22j5z.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+YkQubfrIv1qgyoUMDuaCP6iHCuoPdSL4=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Keno Fischer <keno@juliacomputing.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2022 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 17 (0.8%), b_tie_ro: 16 (0.8%), parse: 1.56
        (0.1%), extract_message_metadata: 36 (1.8%), get_uri_detail_list: 1.78
        (0.1%), tests_pri_-1000: 22 (1.1%), tests_pri_-950: 2.1 (0.1%),
        tests_pri_-900: 1.46 (0.1%), tests_pri_-90: 306 (15.2%), check_bayes:
        222 (11.0%), b_tokenize: 23 (1.1%), b_tok_get_all: 8 (0.4%),
        b_comp_prob: 14 (0.7%), b_tok_touch_all: 135 (6.7%), b_finish: 6
        (0.3%), tests_pri_0: 1573 (77.8%), check_dkim_signature: 1.22 (0.1%),
        check_dkim_adsp: 40 (2.0%), poll_dns_idle: 35 (1.7%), tests_pri_10:
        4.1 (0.2%), tests_pri_500: 53 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/3] ptrace: Stop supporting SIGKILL for PTRACE_EVENT_EXIT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keno Fischer <keno@juliacomputing.com> writes:

> Hi Eric,
>
> On Fri, Jul 8, 2022 at 6:25 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> > Recently I had a conversation where it was pointed out to me that
>> > SIGKILL sent to a tracee stropped in PTRACE_EVENT_EXIT is quite
>> > difficult for a tracer to handle.
>> >
>>
>> RR folks any comments?
>>
>> Did I properly understand what Keno Fischer was asking for when we
>> talked in person?
>
> Yes, this is indeed what I had in mind. I have not yet had the opportunity
> to try out your patch series (sorry), but from visual inspection, it does indeed
> do what I wanted, which is to make sure that a tracee stays in
> PTRACE_EVENT_EXIT for the tracer to inspect, even if there is another
> SIGKILL incoming simultaneously (since otherwise it may be impossible
> for the tracer to observe the PTRACE_EVENT_EXIT if two SIGKILLs
> come in rapid succession). I will try to take this series for a proper spin
> shortly.

Thanks,

I haven't yet figured out how to get the rr test suite to run
successfully.  Something about my test machine and lack of perf counters
seems to be causing problems.  So if you can perform the testing on your
side that would be fantastic.

Eric
