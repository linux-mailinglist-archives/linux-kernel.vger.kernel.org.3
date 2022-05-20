Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283AB52E651
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346507AbiETHd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiETHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:33:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4914AC97;
        Fri, 20 May 2022 00:33:50 -0700 (PDT)
Date:   Fri, 20 May 2022 09:33:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653032028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WO3Qag7yVyo0GFmwDFCkyWbSVTR+kGU+HMvb/D9bjOo=;
        b=h4dL5j62evAr9rItV/vck1C6kA0EcttM1m0b1Da0ljJr4V7XdOnxfSv+mWxSutuS2anLKN
        neSSgNQkpP53eeKBE5CT48hYBJKpeL2q5GmrRpUfJSrhbbAgR96xaZFLm2m9HyNl2hpRjT
        p4R0TUJObBZ8LuvElhNTARZVzJSH+sfB8hS+wPzXOg5CKr62geGJqavEKMI2R0SUtV5/8r
        jm0hy5BI7tr3GfOMHLvYq1VeO3ehLaTFzPsyd262aPCmYuf6k1919aqHhR+iCvZFAB5r9g
        WDP5zU50AT8WP6hpkDrViT7FZkOgF4nok3fWjosNMDT8fokR0m0ESQUltn3zng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653032028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WO3Qag7yVyo0GFmwDFCkyWbSVTR+kGU+HMvb/D9bjOo=;
        b=4tb6POwNJbbl9CtNBPZJfUGQvl1P67iM9z/Z0O1ewVgldWrTMWuavKsCaXBCXYv5PsOEiU
        eksDJVhVX6WxZDDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
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
Subject: Re: [PATCH 00/16] ptrace: cleanups and calling do_cldstop with only
 siglock
Message-ID: <YodEWlfo4kFd8+mt@linutronix.de>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-18 17:49:50 [-0500], Eric W. Biederman wrote:
>=20
> For ptrace_stop to work on PREEMT_RT no spinlocks can be taken once
> ptrace_freeze_traced has completed successfully.  Which fundamentally
> means the lock dance of dropping siglock and grabbing tasklist_lock does
> not work on PREEMPT_RT.  So I have worked through what is necessary so
> that tasklist_lock does not need to be grabbed in ptrace_stop after
> siglock is dropped.
=E2=80=A6
It took me a while to realise that this is a follow-up I somehow assumed
that you added a few patches on top. Might have been the yesterday's
heat. b4 also refused to download this series because the v4 in this
thread looked newer=E2=80=A6 Anyway. Both series applied:

| =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
| WARNING: suspicious RCU usage
| 5.18.0-rc7+ #16 Not tainted
| -----------------------------
| include/linux/ptrace.h:120 suspicious rcu_dereference_check() usage!
|
| other info that might help us debug this:
|
| rcu_scheduler_active =3D 2, debug_locks =3D 1
| 2 locks held by ssdd/1734:
|  #0: ffff88800eaa6918 (&sighand->siglock){....}-{2:2}, at: lock_parents_s=
iglocks+0xf0/0x3b0
|  #1: ffff88800eaa71d8 (&sighand->siglock/2){....}-{2:2}, at: lock_parents=
_siglocks+0x115/0x3b0
|
| stack backtrace:
| CPU: 2 PID: 1734 Comm: ssdd Not tainted 5.18.0-rc7+ #16
| Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.=
16.0-4 04/01/2014
| Call Trace:
|  <TASK>
|  dump_stack_lvl+0x45/0x5a
|  unlock_parents_siglocks+0xb6/0xc0
|  ptrace_stop+0xb9/0x390
|  get_signal+0x51c/0x8d0
|  arch_do_signal_or_restart+0x31/0x750
|  exit_to_user_mode_prepare+0x157/0x220
|  irqentry_exit_to_user_mode+0x5/0x50
|  asm_sysvec_apic_timer_interrupt+0x12/0x20

That is ptrace_parent() in unlock_parents_siglocks().

Sebastian
