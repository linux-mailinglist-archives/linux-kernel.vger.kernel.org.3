Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33652523CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346321AbiEKSdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346356AbiEKSde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:33:34 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B166415F6CF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:33:32 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:54628)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nor9O-00FzwP-Pv; Wed, 11 May 2022 12:33:30 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37846 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nor9M-002r2a-CN; Wed, 11 May 2022 12:33:30 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>, keescook@chromium.org,
        Peter Zijlstra <peterz@infradead.org>, elver@google.com,
        legion@kernel.org, oleg@redhat.com, brauner@kernel.org
References: <aff07d75-622c-9bab-863c-0917c79da3c4@huawei.com>
        <fff65bc3-0b73-3c5e-0f31-bd5404f75353@huawei.com>
        <e70b350e-abfc-7f8d-4590-d18801a9a722@huawei.com>
        <87ilrd2dfj.fsf@email.froward.int.ebiederm.org>
        <58223bd3-b63b-0c2b-abcc-e1136090d060@huawei.com>
        <874k2mtny7.fsf@email.froward.int.ebiederm.org> <87zgk5v148.ffs@tglx>
Date:   Wed, 11 May 2022 13:33:21 -0500
In-Reply-To: <87zgk5v148.ffs@tglx> (Thomas Gleixner's message of "Thu, 28 Apr
        2022 14:33:27 +0200")
Message-ID: <87a6bnudfy.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nor9M-002r2a-CN;;;mid=<87a6bnudfy.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18c8RREKaMvog+JcKW3X0/sbAa5ThrtZRE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1804 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.4 (0.2%), b_tie_ro: 3.0 (0.2%), parse: 1.09
        (0.1%), extract_message_metadata: 13 (0.7%), get_uri_detail_list: 1.71
        (0.1%), tests_pri_-1000: 12 (0.7%), tests_pri_-950: 1.06 (0.1%),
        tests_pri_-900: 0.78 (0.0%), tests_pri_-90: 225 (12.5%), check_bayes:
        220 (12.2%), b_tokenize: 4.7 (0.3%), b_tok_get_all: 7 (0.4%),
        b_comp_prob: 1.94 (0.1%), b_tok_touch_all: 203 (11.3%), b_finish: 0.78
        (0.0%), tests_pri_0: 201 (11.1%), check_dkim_signature: 0.38 (0.0%),
        check_dkim_adsp: 2.6 (0.1%), poll_dns_idle: 1326 (73.5%),
        tests_pri_10: 2.6 (0.1%), tests_pri_500: 1340 (74.3%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: Question about kill a process group
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Thu, Apr 21 2022 at 11:12, Eric W. Biederman wrote:
>> Zhang Qiao <zhangqiao22@huawei.com> writes:
>>>> How many children are being created in this test?  Several million?
>>>
>>>   There are about 300,000+ processes.
>>
>> Not as many as I was guessing, but still enough to cause a huge
>> wait on locks.
>
> Indeed. It's about 4-5us per process to send the signal on a 2GHz
> SKL-X. So with 20000k processes tasklist lock is read held for 1 second.
>
>> I do agree over 1 second for holding a spin lock is ridiculous and a
>> denial of service attack.
>
> Exactly. Even holding it for 100ms (20k forks) is daft.
>
> So unless the number of PIDs for a user is limited this _is_ an
> unpriviledged DoS vector.

After having slept on this a bit it finally occurred to me the
semi-obvious solution to this issue is to convert tasklist_lock
from a rw-spinlock to rw-semaphore.  The challenge is finding
the users (tty layer?) that generate signals from interrupt
context and redirect that signal generation.

Once signals holding tasklist_lock are no longer generated from
interrupt context irqs no longer need to be disabled and
after verifying tasklist_lock isn't held under any other spinlocks
it can be converted to a semaphore.

It won't help the signal delivery times, but it should reduce
the effect on the rest of the system, and prevent watchdogs from
firing.

I don't know if I have time to do any of that now, but it does seem a
reasonable direction to move the code in.

Eric
