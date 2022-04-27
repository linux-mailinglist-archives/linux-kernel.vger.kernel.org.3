Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8997A511ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiD0Njq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiD0Njc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:39:32 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C134B43A;
        Wed, 27 Apr 2022 06:36:20 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:46958)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njhq4-00BNMo-N6; Wed, 27 Apr 2022 07:36:16 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35834 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njhq3-008HKf-Lv; Wed, 27 Apr 2022 07:36:16 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <20220426225211.308418-5-ebiederm@xmission.com>
        <YmjlScztfmfWBfGi@linutronix.de>
Date:   Wed, 27 Apr 2022 08:35:47 -0500
In-Reply-To: <YmjlScztfmfWBfGi@linutronix.de> (Sebastian Andrzej Siewior's
        message of "Wed, 27 Apr 2022 08:40:09 +0200")
Message-ID: <87tuaebqdo.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njhq3-008HKf-Lv;;;mid=<87tuaebqdo.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX186AxdiWfPFH1v/oamRbqPMj7VzLJuq57s=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 325 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (1.1%), b_tie_ro: 2.6 (0.8%), parse: 0.96
        (0.3%), extract_message_metadata: 15 (4.6%), get_uri_detail_list: 0.91
        (0.3%), tests_pri_-1000: 23 (7.1%), tests_pri_-950: 1.40 (0.4%),
        tests_pri_-900: 1.22 (0.4%), tests_pri_-90: 75 (23.1%), check_bayes:
        73 (22.6%), b_tokenize: 8 (2.4%), b_tok_get_all: 6 (1.8%),
        b_comp_prob: 1.93 (0.6%), b_tok_touch_all: 55 (17.0%), b_finish: 0.69
        (0.2%), tests_pri_0: 194 (59.5%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 1.91 (0.6%), poll_dns_idle: 0.51 (0.2%),
        tests_pri_10: 1.77 (0.5%), tests_pri_500: 6 (2.0%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 5/9] signal: Protect parent child relationships by
 childs siglock
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-04-26 17:52:07 [-0500], Eric W. Biederman wrote:
>> The functions ptrace_stop and do_signal_stop have to drop siglock
>> and grab tasklist_lock because the parent/child relation ship
>> is guarded by siglock and not siglock.
>
>  "is guarded by tasklist_lock and not siglock." ?

Yes.   Thank you.  I will fix that.

>> Simplify things by guarding the parent/child relationship
>> with siglock.  For the most part this just requires a little bit
>> of code motion.  In a couple of places more locking was needed.
>> 
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Sebastian

Eric
