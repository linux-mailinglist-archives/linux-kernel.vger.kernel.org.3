Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E261570D38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiGKWNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGKWM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:12:58 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB224BE9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:12:57 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:55648)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB1eC-009pJi-Vp; Mon, 11 Jul 2022 16:12:57 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:47124 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB1eC-00C71j-1j; Mon, 11 Jul 2022 16:12:56 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        tools@linux.kernel.org
References: <87a69fct75.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wge5Dh6ukEQoueSh9dzn6GPqGiRtDQqfSnP5vWEXKJzXw@mail.gmail.com>
Date:   Mon, 11 Jul 2022 17:12:50 -0500
In-Reply-To: <CAHk-=wge5Dh6ukEQoueSh9dzn6GPqGiRtDQqfSnP5vWEXKJzXw@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 11 Jul 2022 15:02:06 -0700")
Message-ID: <87y1wz8fj1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oB1eC-00C71j-1j;;;mid=<87y1wz8fj1.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+Mg+ojls4Xs7EhAmmgqKaQ2yeORcmvbZU=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 428 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 13 (3.0%), b_tie_ro: 11 (2.5%), parse: 0.80
        (0.2%), extract_message_metadata: 13 (3.1%), get_uri_detail_list: 1.21
        (0.3%), tests_pri_-1000: 15 (3.4%), tests_pri_-950: 1.45 (0.3%),
        tests_pri_-900: 1.12 (0.3%), tests_pri_-90: 138 (32.2%), check_bayes:
        135 (31.6%), b_tokenize: 5.0 (1.2%), b_tok_get_all: 41 (9.7%),
        b_comp_prob: 2.1 (0.5%), b_tok_touch_all: 82 (19.2%), b_finish: 1.41
        (0.3%), tests_pri_0: 232 (54.2%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.8 (0.7%), poll_dns_idle: 0.64 (0.2%), tests_pri_10:
        2.0 (0.5%), tests_pri_500: 9 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] ipc: Fix free mq_sysctls when ipc namespace creation
 fails
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jul 11, 2022 at 1:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Please pull the free-mq_sysctls-for-v5.19 tag from the git tree:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git free-mq_sysctls-for-v5.19
>
> The pr-tracker-bot doesn't seem to understand octopus merges, so this
> one didn't get a pr-tracker-bot response despite being merged.
>
> I don't do octopus merges very often, but since I had done the ptrace
> fix as a hotfix for rc6 and your other pull request thus didn't bring
> in any new code (just a new commit), I did your two pull requests as
> one single merge:
>
>   23458ac91dc8 ("Merge tags 'free-mq_sysctls-for-v5.19' and
> 'ptrace_unfreeze_fix-for-v5.19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace").
>
> just FYI.

Thanks for letting me know.  I took a quick look and everything appears
to be there so I don't have any complaints.

Trivial topic branches confusing bots since 2022 ;)

I have Cc'd Konstantin so he knows that octopus merges can confuse bots.

Eric
