Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BB1553D68
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355849AbiFUVTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355816AbiFUVTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:19:02 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D7A2F3A9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:04:38 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:59736)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o3l2y-008PZ1-37; Tue, 21 Jun 2022 15:04:28 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57252 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o3l2w-00G9Ba-OZ; Tue, 21 Jun 2022 15:04:27 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Derek Bruening <bruening@google.com>,
        Kevin Malachowski <chowski@google.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Carlos O'Donell <carlos@redhat.com>,
        Paul Turner <pjt@google.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        Peter Oskolkov <posk@posk.io>,
        Chris Kennelly <ckennelly@google.com>,
        Pedro Alves <palves@redhat.com>,
        Bui Quang Minh <minhquangbui99@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: <20220618182515.95831-1-minhquangbui99@gmail.com>
        <258546133.12151.1655739550814.JavaMail.zimbra@efficios.com>
        <CAJqdLroJ6eTD02dAi8Nnb63Sog5x9Pwt9CDwXaUeBQe1Sn2EBg@mail.gmail.com>
        <648712158.13199.1655748645141.JavaMail.zimbra@efficios.com>
        <CAJqdLrpKLO8Wh_AytFS9XPMkaq22cOJ+fPi06kyJY55yQUpScg@mail.gmail.com>
        <CAB=H8NXaMvNU+0Z02VPnLmQde-F8pdw2Ms2SqiOzWtuTcyNjaA@mail.gmail.com>
        <CAO1ikSbnEbN1-=rY+aOUbjvPS=i9AFJaGBpmbkGR-9UinNKbKw@mail.gmail.com>
        <87y1xper17.fsf@email.froward.int.ebiederm.org>
        <871717002.20576.1655841912053.JavaMail.zimbra@efficios.com>
Date:   Tue, 21 Jun 2022 16:04:18 -0500
In-Reply-To: <871717002.20576.1655841912053.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 21 Jun 2022 16:05:12 -0400
        (EDT)")
Message-ID: <87pmj1enjh.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o3l2w-00G9Ba-OZ;;;mid=<87pmj1enjh.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18zc+rDFOEBT4bWBnCryNsw5KoKma6AAho=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 740 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 9 (1.2%), b_tie_ro: 7 (1.0%), parse: 0.90 (0.1%),
        extract_message_metadata: 14 (1.9%), get_uri_detail_list: 1.29 (0.2%),
        tests_pri_-1000: 25 (3.3%), tests_pri_-950: 1.22 (0.2%),
        tests_pri_-900: 1.09 (0.1%), tests_pri_-90: 340 (46.0%), check_bayes:
        339 (45.8%), b_tokenize: 11 (1.5%), b_tok_get_all: 165 (22.3%),
        b_comp_prob: 3.0 (0.4%), b_tok_touch_all: 155 (21.0%), b_finish: 1.00
        (0.1%), tests_pri_0: 338 (45.6%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.4 (0.3%), poll_dns_idle: 0.59 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 7 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] rseq: x86: Fix rseq_cs get cleared when returning from
 signal handler
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

> ----- On Jun 21, 2022, at 3:48 PM, Eric W. Biederman ebiederm@xmission.com wrote:
>
>> Derek Bruening <bruening@google.com> writes:
>> 
>>> From the viewpoint of dynamic binary translation/instrumentation and
>>> memtrace (go/memtrace), removing those RSEQ_CS_FLAG_NO_RESTART_ON_* flags
>>> is a good thing as it reduces complexity and makes it easier to handle rseq
>>> (which is painful enough to handle already).
>> 
>> It sounds like there is consensus.
>> 
>> Does someone want to code up a simple patch that detects when
>> RSEQ_CS_NO_RESTART_ON_SIGNAL and does a WARN_ON_ONCE and fails if
>> someone uses so it can be set to Linus in the next merge window.
>> 
>> After no one screams at that patch it should be safe to remove the
>> functionality, because you have empirical proof that no one uses
>> that functionality.
>
> Sure, I can whip up something.
>
> I'll send it to Peter Zijlstra shortly.
>
> I plan to, as you suggest, WARN_ON_ONCE() when this happens, and return
> an error when the rseq flags or rseq_cs flags contain either of the
> RSEQ_CS_FLAG_NO_RESTART_ON_* flags. This error is handled by forcing a
> killing the process with sigsegv:
>
> __rseq_handle_notify_resume()
> [...]
> error:
>         sig = ksig ? ksig->sig : 0;
>         force_sigsegv(sig);
>
> Does it look acceptable ?

I think so.  force_sigsegv preps things so that when you go into
exit_to_user_mode_loop the signal handler kills the process.

So assuming that happens after force_sigsegv that looks good.

Eric
