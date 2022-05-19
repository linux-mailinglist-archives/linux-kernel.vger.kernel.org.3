Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EB952DC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiESSGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243655AbiESSGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:06:35 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0830F644CB;
        Thu, 19 May 2022 11:06:32 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:42124)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrkXf-00EPB8-BY; Thu, 19 May 2022 12:06:31 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38814 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrkXe-006g2j-DA; Thu, 19 May 2022 12:06:30 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
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
        <20220518225355.784371-3-ebiederm@xmission.com>
        <20220519075619.GE2578@worktop.programming.kicks-ass.net>
Date:   Thu, 19 May 2022 13:06:22 -0500
In-Reply-To: <20220519075619.GE2578@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Thu, 19 May 2022 09:56:19 +0200")
Message-ID: <87wneh2y8x.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nrkXe-006g2j-DA;;;mid=<87wneh2y8x.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19pQDaLrMLAmG2KN+ovoqyefv1ateYU328=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 349 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (3.4%), b_tie_ro: 10 (3.0%), parse: 0.97
        (0.3%), extract_message_metadata: 11 (3.3%), get_uri_detail_list: 0.60
        (0.2%), tests_pri_-1000: 17 (4.8%), tests_pri_-950: 1.23 (0.4%),
        tests_pri_-900: 1.04 (0.3%), tests_pri_-90: 83 (23.8%), check_bayes:
        82 (23.3%), b_tokenize: 8 (2.2%), b_tok_get_all: 8 (2.4%),
        b_comp_prob: 2.4 (0.7%), b_tok_touch_all: 60 (17.1%), b_finish: 0.90
        (0.3%), tests_pri_0: 203 (58.1%), check_dkim_signature: 1.34 (0.4%),
        check_dkim_adsp: 6 (1.7%), poll_dns_idle: 0.90 (0.3%), tests_pri_10:
        3.0 (0.9%), tests_pri_500: 14 (3.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 03/16] kdb: Use real_parent when displaying a list of
 processes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, May 18, 2022 at 05:53:42PM -0500, Eric W. Biederman wrote:
>> kdb has a bug that when using the ps command to display a list of
>> processes, if a process is being debugged the debugger as the parent
>> process.
>> 
>> This is silly, and I expect it never comes up in ptractice.  As there
>                                                    ^^^^^^^^^
>
> Lol, love the new word :-)

It wasn't intentional but now I just might have to keep it.

Eric

