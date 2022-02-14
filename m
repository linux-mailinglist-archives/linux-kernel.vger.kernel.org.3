Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A6E4B5464
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243724AbiBNPRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:17:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiBNPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:17:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB13593BC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:17:02 -0800 (PST)
Date:   Mon, 14 Feb 2022 16:17:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644851821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/POc7+dE2pY24OqtAsA23BaK4CAfuqEPnI7uYCQWOY=;
        b=4CismoWTguXKx95kte1F97ud2x41ZCLGqoC0cpTbX05d+BmQYyoLDsTwPbbizUIdt8gbiW
        clOwP94SlXZZKZ8JL1VJQ7GZOmLsJCE5xZ8eRKvMOPhbEwpa9fIKgib1IjM6O8jiZHageI
        xjnmkWjufXKX/YyyypRjk54ZQkIk8eomvRAkn6SMWvzDkEI7PoCBKD3JOIqR27KjX0Ot+/
        xcroWEk450ykqG2wJ0pg+Qp5FnJqozwFhQDRtgVm8jmxDbccLf811XnD7DajExp7e+RqSB
        BKCm+77vACfYEWotughpMp1saxV240A4sQaz+QEDcw8LK46Ord1hfszxtMhamw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644851821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/POc7+dE2pY24OqtAsA23BaK4CAfuqEPnI7uYCQWOY=;
        b=VBoDF+998vYwslKUkL0Vj1yKI5XV7MIon4+lgkZDySabhZ47OOfLnw7EXrrGO9V2RyVGtm
        vkknHpiVEXk4RcCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: set fast pool count to zero in cpuhp teardown
Message-ID: <YgpybD+PeQ5Az7CJ@linutronix.de>
References: <CAHmME9rAnh6nSRNYo56Ty6VSrY17ej35AoNkSjunFO0AQp1D9Q@mail.gmail.com>
 <20220214133735.966528-1-Jason@zx2c4.com>
 <Ygpkej/vnMvUDIlP@linutronix.de>
 <CAHmME9ruM85U+dp4coBRJUBdk=iHXFZq3ZvHSiDXmpV+BoZEVw@mail.gmail.com>
 <Ygpr9Xg0I+ZVzp9v@linutronix.de>
 <CAHmME9rp+O3+yjX_q-BS8y06PigbkEgi4vn=nzLACnBAWZt-vA@mail.gmail.com>
 <Ygpv/kLWCmTzUTki@linutronix.de>
 <CAHmME9qrhpRCox2mR2UEStWxev2Zu14htBkpv3mdFEkVqacvVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHmME9qrhpRCox2mR2UEStWxev2Zu14htBkpv3mdFEkVqacvVQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-14 16:10:36 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> On Mon, Feb 14, 2022 at 4:06 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > But you acked my question regarding boot-up? So the teardown callback
> > won't happen during boot-up.
>=20
> I'd like to do only one method here, so we can set those fields in
> startup, provided it happens early enough.
> > > So I think it seems better to keep it before CPUHP_TIMERS_PREPARE, but
> > > do it on startup rather than teardown. Seem reasonable? Would that
> > > mean we zero out before IRQs are enabled?
> > I would only zero it if the upper-most bit is there.
>=20
> I still don't quite understand: why can't we just unconditionally
> zero, always, before CPUHP_TIMERS_PREPARE?

If you have a rollback before CPUHP_TIMERS_PREPARE you don't notice it
and your worker may have skipped this work because it run on the wrong
CPU. Also, I *think* that if you happen to have 64 interrupts between
   CPUHP_AP_ONLINE_IDLE =E2=80=A6 CPUHP_AP_WORKQUEUE_ONLINE

then the scheduled worker is unbound and may run on the "wrong" CPU.

> > And then have another one after
>=20
> Two of them seems a little bit out of hand in complexity here... Let's
> just find one phase where we can simply set variables without too much
> fiddly logic. I'll send a v+1 of what I have in mind for the startup
> path.

Oki.

> Jason

Sebastian
