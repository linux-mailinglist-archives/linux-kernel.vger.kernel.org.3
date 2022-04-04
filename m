Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C224F16FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377441AbiDDObo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377345AbiDDObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:31:23 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FF61EC6B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:29:25 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:52758)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nbNhq-004PiG-Oc; Mon, 04 Apr 2022 08:29:22 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:42064 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nbNhp-0034L9-N7; Mon, 04 Apr 2022 08:29:22 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
In-Reply-To: <Ykblv2aKh3ekqpi4@linutronix.de> (Sebastian Andrzej Siewior's
        message of "Fri, 1 Apr 2022 13:45:03 +0200")
References: <Ygq5aBB/qMQw6aP5@linutronix.de>
        <8735j2xigt.fsf@email.froward.int.ebiederm.org>
        <YkHfokLO1UGCISGc@linutronix.de>
        <87zgl9pw82.fsf@email.froward.int.ebiederm.org>
        <YkLR3rGTayl/6qIm@linutronix.de>
        <87o81nl3b6.fsf@email.froward.int.ebiederm.org>
        <Ykblv2aKh3ekqpi4@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Mon, 04 Apr 2022 09:29:10 -0500
Message-ID: <87y20kkjm1.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nbNhp-0034L9-N7;;;mid=<87y20kkjm1.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/G4MNkZODmgwk3F1qHE7FMnKz+BZ2J9Ok=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 471 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 10 (2.1%), parse: 0.91
        (0.2%), extract_message_metadata: 11 (2.4%), get_uri_detail_list: 1.33
        (0.3%), tests_pri_-1000: 7 (1.5%), tests_pri_-950: 1.23 (0.3%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 96 (20.5%), check_bayes:
        94 (19.9%), b_tokenize: 8 (1.8%), b_tok_get_all: 8 (1.8%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 70 (14.8%), b_finish: 1.00
        (0.2%), tests_pri_0: 322 (68.4%), check_dkim_signature: 1.33 (0.3%),
        check_dkim_adsp: 5 (1.1%), poll_dns_idle: 0.83 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 14 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal/x86: Delay calling signals in atomic
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-03-30 13:10:05 [-0500], Eric W. Biederman wrote:
>> But it looks like if we are coming from userspace then we use the same
>> stack as any other time we would come from userspace.  AKA a stack
>> that allows the kernel to sleep.
>> 
>> So I don't see what the problem is that is trying to be fixed.
>
> It is not only the stack. In atomic context / disabled interrupts it is
> not possible to acquire a spinlock_t (sighand_struct::siglock) which is
> done later.

Looking at do_int3_user the interrupts must be enabled.
>
>> I know that code has been changed over the years, perhaps this is
>> something that was fixed upstream and the real time tree didn't realize
>> there was no longer a need to fix anything?
>> 
>> Or am I missing something subtle when reading the idtentry assembly?
>
> It certainly is true that the code changed over the years. The per-CPU
> stack is one problem, the siglock in atomic context is the other one.
> Thank you for the input. Let me digest the informations I have here and
> get back.

Certainly.  I case it helps this is the relevant bit of code:

static void do_int3_user(struct pt_regs *regs)
{
	if (do_int3(regs))
		return;

	cond_local_irq_enable(regs);
	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, 0, 0, NULL);
	cond_local_irq_disable(regs);
}

The signal delivery where siglock is take happens inside of do_trap.  If
we are coming from kernel mode only do_int3 is called.

Coming from user_mode we switch to the task stack and
enable interrupts.

Unless I am misreading the code the cond_local_irq_{enable/disable} can
correctly be replaced local_irq_{enable/disable} as coming from user
mode interrupts are always enabled.

Unless I am misreading cond_local_irq_enable.  If for some reason
cond_local_irq_enable doesn't enable interrupts when come from user
mode fixing that appears to be the fix that is needed.


Eric
