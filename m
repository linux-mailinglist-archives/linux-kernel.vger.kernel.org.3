Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D64453F207
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 00:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiFFWQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 18:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiFFWQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 18:16:20 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9352AE1;
        Mon,  6 Jun 2022 15:16:19 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56556)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyL18-00Dr2R-6X; Mon, 06 Jun 2022 16:16:10 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53752 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyL17-008WKx-AS; Mon, 06 Jun 2022 16:16:09 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
        <20220518225355.784371-8-ebiederm@xmission.com>
        <20220524152725.GE14347@redhat.com>
Date:   Mon, 06 Jun 2022 17:16:01 -0500
In-Reply-To: <20220524152725.GE14347@redhat.com> (Oleg Nesterov's message of
        "Tue, 24 May 2022 17:27:25 +0200")
Message-ID: <87pmjl1lr2.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nyL17-008WKx-AS;;;mid=<87pmjl1lr2.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+XLuQrB0IHmo0lv55ADS0tXNzKSUteaDM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 309 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (3.7%), b_tie_ro: 10 (3.2%), parse: 0.95
        (0.3%), extract_message_metadata: 2.9 (0.9%), get_uri_detail_list:
        0.92 (0.3%), tests_pri_-1000: 5 (1.7%), tests_pri_-950: 1.15 (0.4%),
        tests_pri_-900: 1.03 (0.3%), tests_pri_-90: 64 (20.6%), check_bayes:
        62 (20.1%), b_tokenize: 9 (2.8%), b_tok_get_all: 8 (2.6%),
        b_comp_prob: 2.4 (0.8%), b_tok_touch_all: 39 (12.7%), b_finish: 0.94
        (0.3%), tests_pri_0: 206 (66.7%), check_dkim_signature: 0.53 (0.2%),
        check_dkim_adsp: 2.8 (0.9%), poll_dns_idle: 0.96 (0.3%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 08/16] ptrace: Only populate last_siginfo from ptrace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/18, Eric W. Biederman wrote:
>>
>> The code in ptrace_signal to populate siginfo if the signal number
>> changed is buggy.  If the tracer contined the tracee using
>> ptrace_detach it is guaranteed to use the real_parent (or possibly a
>> new tracer) but definitely not the origional tracer to populate si_pid
>> and si_uid.
>
> I guess nobody cares. As the comment says
>
> 	 If the debugger wanted something
> 	 specific in the siginfo structure then it should
> 	 have updated *info via PTRACE_SETSIGINFO.
>
> otherwise I don't think si_pid/si_uid have any value.

No one has complained so it is clearly no one cares.  So it is
definitely not a regression.  Or even anything that needs to be
backported.

However si_pid and si_uid are defined with SI_USER are defined
to be whomever sent the signal.  So I would argue by definition
those values are wrong.

> However the patch looks fine to me, just the word "buggy" looks a bit
> too strong imo.

I guess I am in general agreement.  Perhaps I can just say they values
are wrong by definition?

Eric


