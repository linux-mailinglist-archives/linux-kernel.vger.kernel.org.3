Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7091952DC59
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243638AbiESSGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243647AbiESSGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:06:05 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D235BC27;
        Thu, 19 May 2022 11:05:57 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38982)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrkWs-003AjH-EX; Thu, 19 May 2022 12:05:42 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38810 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrkWr-006fmJ-Ca; Thu, 19 May 2022 12:05:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Kyle Huey <khuey@pernos.co>, LKML <linux-kernel@vger.kernel.org>,
        rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org,
        Robert O'Callahan <roc@pernos.co>,
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
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
        <CALWUPBdFDLuT7JaNGSJ_UXbHf8y9uKdC-SkAqzd=FQC0MX4nNQ@mail.gmail.com>
        <YoXhfGGPKnT/YFC1@linutronix.de>
Date:   Thu, 19 May 2022 13:05:32 -0500
In-Reply-To: <YoXhfGGPKnT/YFC1@linutronix.de> (Sebastian Andrzej Siewior's
        message of "Thu, 19 May 2022 08:19:40 +0200")
Message-ID: <8735h54cur.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nrkWr-006fmJ-Ca;;;mid=<8735h54cur.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+x0Ao64wqfn/lCXR2nCKOYfMdcIblQPOs=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 383 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (3.5%), b_tie_ro: 12 (3.1%), parse: 1.52
        (0.4%), extract_message_metadata: 22 (5.8%), get_uri_detail_list: 1.44
        (0.4%), tests_pri_-1000: 32 (8.5%), tests_pri_-950: 1.47 (0.4%),
        tests_pri_-900: 1.30 (0.3%), tests_pri_-90: 103 (26.8%), check_bayes:
        101 (26.3%), b_tokenize: 10 (2.6%), b_tok_get_all: 9 (2.2%),
        b_comp_prob: 2.6 (0.7%), b_tok_touch_all: 75 (19.7%), b_finish: 1.19
        (0.3%), tests_pri_0: 194 (50.7%), check_dkim_signature: 0.62 (0.2%),
        check_dkim_adsp: 3.3 (0.9%), poll_dns_idle: 1.19 (0.3%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 00/16] ptrace: cleanups and calling do_cldstop with only
 siglock
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-05-18 20:26:05 [-0700], Kyle Huey wrote:
>> Is there a git branch somewhere I can pull to test this? It doesn't apply
>> cleanly to Linus's tip.
>
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace_stop-cleanup-for-v5.19

Yes that is the branch this all applies to.

This is my second round of cleanups this cycle for this code.
I just keep finding little things that deserve to be changed,
when I am working on the more substantial issues.

Eric



