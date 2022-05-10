Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201C9521E78
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiEJP2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345654AbiEJP1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:27:31 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B925EF;
        Tue, 10 May 2022 08:18:46 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:55028)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1noRdJ-003qNX-VX; Tue, 10 May 2022 09:18:42 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37648 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1noRdI-00D1O9-QE; Tue, 10 May 2022 09:18:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <20220510141119.GA23277@redhat.com>
        <87lev9xy3n.fsf@email.froward.int.ebiederm.org>
        <Ynp6fP8QkIGvUT1T@linutronix.de>
Date:   Tue, 10 May 2022 10:18:32 -0500
In-Reply-To: <Ynp6fP8QkIGvUT1T@linutronix.de> (Sebastian Andrzej Siewior's
        message of "Tue, 10 May 2022 16:45:16 +0200")
Message-ID: <877d6twh4n.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1noRdI-00D1O9-QE;;;mid=<877d6twh4n.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+K53bzJQj82BQIbEeFyvHE/PiTfNglD3U=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 534 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 9 (1.7%), b_tie_ro: 8 (1.4%), parse: 1.01 (0.2%),
        extract_message_metadata: 12 (2.3%), get_uri_detail_list: 0.95 (0.2%),
        tests_pri_-1000: 12 (2.3%), tests_pri_-950: 1.36 (0.3%),
        tests_pri_-900: 1.11 (0.2%), tests_pri_-90: 270 (50.6%), check_bayes:
        268 (50.2%), b_tokenize: 7 (1.3%), b_tok_get_all: 7 (1.3%),
        b_comp_prob: 2.2 (0.4%), b_tok_touch_all: 248 (46.5%), b_finish: 0.97
        (0.2%), tests_pri_0: 212 (39.7%), check_dkim_signature: 0.87 (0.2%),
        check_dkim_adsp: 3.4 (0.6%), poll_dns_idle: 0.78 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 9 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 0/12] ptrace: cleaning up ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-05-10 09:26:36 [-0500], Eric W. Biederman wrote:
>> Does anyone else have any comments on this patchset?
>> 
>> If not I am going to apply this to a branch and get it into linux-next.
>
> Looks good I guess.
> Be aware that there will be clash due to
>    https://lore.kernel.org/all/1649240981-11024-3-git-send-email-yangtiezhu@loongson.cn/
>
> which sits currently in -akpm.

Thanks for the heads up.  That looks like the best kind of conflict.
One where code just disappears.

Eric
