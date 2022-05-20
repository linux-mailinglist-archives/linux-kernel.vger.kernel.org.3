Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BB552F3D6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353272AbiETTcu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 May 2022 15:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353236AbiETTcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:32:47 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBE719579A;
        Fri, 20 May 2022 12:32:46 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37830)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ns8MT-007S8z-KA; Fri, 20 May 2022 13:32:33 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38910 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ns8MS-00BQ97-Jb; Fri, 20 May 2022 13:32:33 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, oleg@redhat.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org,
        Robert O'Callahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
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
        <YodEWlfo4kFd8+mt@linutronix.de>
Date:   Fri, 20 May 2022 14:32:24 -0500
In-Reply-To: <YodEWlfo4kFd8+mt@linutronix.de> (Sebastian Andrzej Siewior's
        message of "Fri, 20 May 2022 09:33:46 +0200")
Message-ID: <87wnegyp87.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1ns8MS-00BQ97-Jb;;;mid=<87wnegyp87.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18cQrXh+UQWoHE6LCH3Iga9qNv05JRvfdM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 420 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (2.9%), b_tie_ro: 10 (2.4%), parse: 1.71
        (0.4%), extract_message_metadata: 17 (4.1%), get_uri_detail_list: 2.1
        (0.5%), tests_pri_-1000: 17 (4.1%), tests_pri_-950: 1.73 (0.4%),
        tests_pri_-900: 1.39 (0.3%), tests_pri_-90: 79 (18.7%), check_bayes:
        77 (18.3%), b_tokenize: 12 (2.9%), b_tok_get_all: 10 (2.5%),
        b_comp_prob: 3.5 (0.8%), b_tok_touch_all: 47 (11.2%), b_finish: 0.95
        (0.2%), tests_pri_0: 269 (64.1%), check_dkim_signature: 0.74 (0.2%),
        check_dkim_adsp: 2.5 (0.6%), poll_dns_idle: 0.73 (0.2%), tests_pri_10:
        4.0 (0.9%), tests_pri_500: 12 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 00/16] ptrace: cleanups and calling do_cldstop with only
 siglock
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-05-18 17:49:50 [-0500], Eric W. Biederman wrote:
>> 
>> For ptrace_stop to work on PREEMT_RT no spinlocks can be taken once
>> ptrace_freeze_traced has completed successfully.  Which fundamentally
>> means the lock dance of dropping siglock and grabbing tasklist_lock does
>> not work on PREEMPT_RT.  So I have worked through what is necessary so
>> that tasklist_lock does not need to be grabbed in ptrace_stop after
>> siglock is dropped.
> …
> It took me a while to realise that this is a follow-up I somehow assumed
> that you added a few patches on top. Might have been the yesterday's
> heat. b4 also refused to download this series because the v4 in this
> thread looked newer… Anyway. Both series applied:
>
> | =============================
> | WARNING: suspicious RCU usage
> | 5.18.0-rc7+ #16 Not tainted
> | -----------------------------
> | include/linux/ptrace.h:120 suspicious rcu_dereference_check() usage!
> |
> | other info that might help us debug this:
> |
> | rcu_scheduler_active = 2, debug_locks = 1
> | 2 locks held by ssdd/1734:
> |  #0: ffff88800eaa6918 (&sighand->siglock){....}-{2:2}, at: lock_parents_siglocks+0xf0/0x3b0
> |  #1: ffff88800eaa71d8 (&sighand->siglock/2){....}-{2:2}, at: lock_parents_siglocks+0x115/0x3b0
> |
> | stack backtrace:
> | CPU: 2 PID: 1734 Comm: ssdd Not tainted 5.18.0-rc7+ #16
> | Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> | Call Trace:
> |  <TASK>
> |  dump_stack_lvl+0x45/0x5a
> |  unlock_parents_siglocks+0xb6/0xc0
> |  ptrace_stop+0xb9/0x390
> |  get_signal+0x51c/0x8d0
> |  arch_do_signal_or_restart+0x31/0x750
> |  exit_to_user_mode_prepare+0x157/0x220
> |  irqentry_exit_to_user_mode+0x5/0x50
> |  asm_sysvec_apic_timer_interrupt+0x12/0x20
>
> That is ptrace_parent() in unlock_parents_siglocks().

How odd.  I thought I had the appropriate lockdep config options enabled
in my test build to catch things like this.  I guess not.

Now I am trying to think how to tell it that holding the appropriate
iglock makes this ok.

Eric
